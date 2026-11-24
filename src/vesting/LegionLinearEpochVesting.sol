// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {VestingWalletUpgradeable} from "@openzeppelin/contracts-upgradeable/finance/VestingWalletUpgradeable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title LegionLinearEpochVesting
 * @notice Linear epoch-based vesting wallet extending OpenZeppelin's VestingWalletUpgradeable.
 */
contract LegionLinearEpochVesting is VestingWalletUpgradeable {
    using SafeERC20 for IERC20;

    uint64 public s_start;
    uint64 public s_duration;
    uint64 public s_numberOfEpochs;
    uint64 public s_epochDuration;
    uint256 public s_totalAllocation;
    uint256 public s_lastClaimedEpoch;

    event TokensReleased(address indexed token, uint256 amount);

    error InvalidInitialization();
    error NoTokensToRelease();
    error VestingNotStarted();

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(
        address beneficiary_,
        uint64 start_,
        uint64 duration_,
        uint64 numberOfEpochs_,
        uint256 totalAllocation_
    ) public initializer {
        if (beneficiary_ == address(0) || duration_ == 0 || numberOfEpochs_ == 0) {
            revert InvalidInitialization();
        }
        __VestingWallet_init(beneficiary_, start_, duration_);
        s_start = start_;
        s_duration = duration_;
        s_numberOfEpochs = numberOfEpochs_;
        s_epochDuration = duration_ / numberOfEpochs_;
        s_totalAllocation = totalAllocation_;
        s_lastClaimedEpoch = 0;
    }

    /**
     * @notice Override vesting schedule to be purely time-invariant based on timestamp,
     * ensuring historical queries and monotonicity invariants hold correctly.
     */
    function _vestingSchedule(uint256 totalAllocation, uint64 timestamp) internal view override returns (uint256) {
        if (timestamp < s_start) {
            return 0;
        }
        if (timestamp >= s_start + s_duration) {
            return totalAllocation;
        }

        uint64 elapsed = timestamp - s_start;
        uint64 currentEpoch = (elapsed / s_epochDuration) + 1;
        if (currentEpoch > s_numberOfEpochs) {
            currentEpoch = s_numberOfEpochs;
        }

        return (totalAllocation * currentEpoch) / s_numberOfEpochs;
    }

    function release(address token) public virtual override {
        uint256 releasable = releasable(token);
        if (releasable == 0) {
            revert NoTokensToRelease();
        }

        uint64 timestamp = uint64(block.timestamp);
        if (timestamp < s_start) {
            revert VestingNotStarted();
        }

        uint64 elapsed = timestamp - s_start;
        uint64 currentEpoch = (elapsed / s_epochDuration) + 1;
        if (currentEpoch > s_numberOfEpochs) {
            currentEpoch = s_numberOfEpochs;
        }

        s_lastClaimedEpoch = currentEpoch;

        emit TokensReleased(token, releasable);
        _released[token] += releasable;
        IERC20(token).safeTransfer(beneficiary(), releasable);
    }

    function releasable(address token) public view virtual override returns (uint256) {
        return vestedAmount(token, uint64(block.timestamp)) - released(token);
    }

    function vestedAmount(address token, uint64 timestamp) public view virtual override returns (uint256) {
        return _vestingSchedule(s_totalAllocation, timestamp);
    }
}