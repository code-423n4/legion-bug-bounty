// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.30;

import { Test } from "forge-std/Test.sol";
import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { LegionLinearEpochVesting } from "../../src/vesting/LegionLinearEpochVesting.sol";

contract MintableERC20 is ERC20 {
    constructor() ERC20("Test", "TST") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}

contract RegressionVestingEpochMonotonicity is Test {
    MintableERC20 public token;
    LegionLinearEpochVesting public vesting;

    address public beneficiary = address(0x1234);
    address public vestingController = address(0x5678);

    uint256 public constant ALLOCATION = 1000e18;
    uint64 public constant START = 1_000_000;
    uint64 public constant DURATION = 10_000_000;
    uint64 public constant CLIFF = 1_000_000;
    uint64 public constant EPOCH = 1_000_000;
    uint64 public constant EPOCHS = 10;

    function setUp() public {
        token = new MintableERC20();
        vesting = new LegionLinearEpochVesting();

        vesting.initialize(
            beneficiary,
            vestingController,
            address(token),
            START,
            DURATION,
            CLIFF,
            EPOCH,
            EPOCHS
        );

        token.mint(address(vesting), ALLOCATION);
    }

    /// vestedAmount(token, pastTs) must be a pure function of time: a later claim must
    /// not collapse the historical schedule to 0 (monotonicity invariant).
    function test_past_vestedAmount_unchanged_after_release() public {
        uint256 pastTs = START + EPOCH * 2;
        uint256 before = vesting.vestedAmount(address(token), pastTs);
        assertGt(before, 0, "past vested amount must be non-zero");

        vm.warp(START + EPOCH * 5);
        vesting.release(address(token));

        uint256 after = vesting.vestedAmount(address(token), pastTs);
        assertEq(after, before, "past vested amount must not change after a release");
        assertGt(after, 0, "past vested amount must stay non-zero after a release");
    }

    /// The vesting curve must stay monotonic in time across a claim.
    function test_vesting_monotonic_across_release() public {
        uint256 t1 = START + EPOCH * 2;
        uint256 t2 = START + EPOCH * 5;

        uint256 v1 = vesting.vestedAmount(address(token), t1);
        uint256 v2 = vesting.vestedAmount(address(token), t2);
        assertGt(v2, v1, "vesting must be monotonic in time");

        vm.warp(t2);
        vesting.release(address(token));

        assertEq(vesting.vestedAmount(address(token), t1), v1);
        assertEq(vesting.vestedAmount(address(token), t2), v2);
        assertGt(vesting.vestedAmount(address(token), t2), vesting.vestedAmount(address(token), t1));
    }

    /// releasable() must not underflow (Panic 0x11) once released > 0.
    function test_releasable_no_underflow_after_claim() public {
        vm.warp(START + EPOCH * 5);
        vesting.release(address(token));
        assertGt(vesting.released(address(token)), 0, "release must record a released amount");

        vm.warp(START + EPOCH * 8);
        uint256 r = vesting.releasable(address(token));
        assertGt(r, 0, "releasable must not underflow after a claim");
    }
}
