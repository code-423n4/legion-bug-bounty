# Legion Bug Bounty

- [Read our guidelines for more details](https://docs.code4rena.com/bounties)
- Submit findings [using the C4 form](https://code4rena.com/bounties/legion.cc/submit)

| Risk Score | Payout            |
| ---------- | ----------------- |
| Critical   | Up to USD $75,000 |
| High       | USD $10,000       |

## Background on Legion

### What Is Legion?

Legion connects investors and contributors with promising crypto projects, enabling compliant and incentive-aligned investments before and after Token Generation Events (TGEs). Our platform supports both pre-TGE fundraising and token launches, streamlining capital raising and token distribution.

### How Does It Work?

Legion facilitates ERC20 token sales — Fixed Price, Sealed Bid Auction, and Pre-Liquid (Approved & Open Application), ERC20 capital raises and ERC20 token distribution — using the [EIP-1167 Minimal Proxy Standard Clone Pattern](https://eips.ethereum.org/EIPS/eip-1167) for deployment and **Merkle Proofs** + **Signatures** for eligibility verification.

Legion’s smart contracts are designed to work seamlessly with our backend for off-chain calculations, such as sale result processing, ensuring efficiency and compliance. While this introduces dependency, it enables complex operations not feasible on-chain alone.

### Further Technical Resources & Links

- **Legion Docs**: Our system documentation, subject to change. [Link](https://legion-1.gitbook.io/)
- **Legion Changelog**: [Link](https://github.com/Legion-Team/legion-protocol-contracts/releases/tag/2025-08-27)
- **Legion Whitepaper**: [Link](https://legion.cc/documents/Legion_Whitepaper.pdf)
- **Legion Website**: [Link](https://legion.cc)
- **Twitter**: [@legiondotcc](https://x.com/legiondotcc)
- **Discord** [https://discord.gg/legiondotcc](https://discord.gg/legiondotcc)

## Scope & Severity Criteria

| Severity level     | Impact: High | Impact: Medium | Impact: Low |
| ------------------ | ------------ | -------------- | ----------- |
| Likelihood: High   | Critical     | High           | -           |
| Likelihood: Medium | High         | -              | -           |
| Likelihood: Low    | -            | -              | -           |

## Smart Contracts in Scope

**Source**: [GitHub](https://github.com/Legion-Team/legion-protocol-contracts)

| Name (Address Link)                                                                                     | Repo                                                                                                                                |
| ------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------               |
| LegionBouncer                                                                 | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/access/LegionBouncer.sol>                                 |
| LegionReferrerFeeDistributor                                                  | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/distribution/LegionReferrerFeeDistributor.sol>            |
| LegionTokenDistributor                                                        | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/distribution/LegionTokenDistributor.sol>                  |
| LegionCapitalRaiseFactory                                                     | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionCapitalRaiseFactory.sol>                  |
| LegionFixedPriceSaleFactory                                                   | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionFixedPriceSaleFactory.sol>                |
| LegionPreLiquidApprovedSaleFactory                                            | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionPreLiquidApprovedSaleFactory.sol>         |
| LegionPreLiquidOpenApplicationSaleFactory                                     | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionPreLiquidOpenApplicationSaleFactory.sol>  |
| LegionSealedBidAuctionSaleFactory                                             | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionSealedBidAuctionSaleFactory.sol>          |
| LegionTokenDistributorFactory                                                 | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionTokenDistributorFactory.sol>              |
| LegionVestingFactory                                                          | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionVestingFactory.sol>                       |
| LegionCapitalRaise                                                            | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/raise/LegionCapitalRaise.sol>                             |
| LegionAddressRegistry                                                         | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/registries/LegionAddressRegistry.sol>                     |
| LegionFixedPriceSale                                                          | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/sales/LegionFixedPriceSale.sol>                           |
| LegionPreLiquidApprovedSale                                                   | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/sales/LegionPreLiquidApprovedSale.sol>                    |
| LegionPreLiquidOpenApplicationSale                                            | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/sales/LegionPreLiquidOpenApplicationSale.sol>             |
| LegionSealedBidAuctionSale                                                    | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/sales/LegionSealedBidAuctionSale.sol>                     |
| LegionLinearEpochVesting                                                      | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/vesting/LegionLinearEpochVesting.sol>                     |
| LegionLinearVesting                                                           | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/vesting/LegionLinearVesting.sol>                          |

## Out-of-Scope

### Known Issues

Bug reports covering previously-discovered bugs (listed below) are not eligible for a reward within this program. This includes known issues that the project is aware of but has consciously decided not to “fix”, necessary code changes, or any implemented operational mitigating procedures that can lessen potential risk. Every issue opened in the repo, closed PRs, previous contests and audits are out of scope.

All issues submitted by wardens to the Legion bounty will be added to [this repo](https://github.com/code-423n4/legion-bug-bounty/issues?q=is%3Aissue%20state%3Aclosed) once they have been reviewed by the sponsors. These are considered known issues and are out-of-scope for bounty rewards.

The following are known issues and therefore are out of scope:

- Centralization risks
- Lack of support for fee-on-transfer and rebasing tokens
- Project owners are not required to provide ask tokens to pre-liquid sales before withdrawing capital
- Signature reuse when investing (users are allowed to invest multiple times in the same sale, using the same signature)
- Refunding is allowed prior to official sale end, technically allowing users more time for refund than the specified `refundPeriod`

### Previous Audits

Any **previously reported** vulnerabilities mentioned in past audit reports are not eligible for a reward.

Legion's previous audits can be found below: [Audits](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/audits)

### Specific Types of Issues

**An example of that would be the following:**

- Code outside the `master` branch.
- Anything in [test](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/test), [script](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/script), [src/mocks](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/src/mocks), [src/lib](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/src/lib), [src/utils](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/src/utils), or [src/interfaces](https://github.com/Legion-Team/legion-protocol-contracts/tree/master/src/interfaces) folders.
- Bugs already reported by others.
- Known issues tied to third-party contracts built on top of Legion.
- Problems in external systems or contracts interacting with us.
- Testnet deployments — no points for sandbox wins.

**And these don’t count either:**

- Incorrect input data supplied by users.
- Missing input data validation.
- MEV / Frontrunning attacks.
- Breakdowns in outside services.
- Compromised private keys.
- Phishing schemes or fake sites.
- DDoS onslaughts.
- Social manipulation tricks.
- UI bugs (like misleading clicks).
- Spam floods.
- Automated tool outputs (e.g., CI/CD scans).

## Additional Context

### Trusted Roles

- **Legion** - Legion's admin access and interactions are controlled through the `LegionBouncer` contract. A `BROADCASTER` role is granted to a AWS Broadcaster Wallet, responsible for executing function calls requiring Legion's access privileges.
- **Project Admin** - Projects have the ability to withdraw raised capital and supply tokens for distribution.

### Miscellaneous

Employees of Legion, contractors and their family members are ineligible for bounties.

Reward amounts may be displayed using a dollar sign for simplicity, but the underlying valuation is based on a USD-pegged digital asset such as USDC. Because the displayed figure reflects a USD reference value rather than a fiat currency payment, the final amount delivered in the corresponding token may differ slightly at the time of payout.
