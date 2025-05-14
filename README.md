# Legion Bug Bounty

- [Read our guidelines for more details](https://docs.code4rena.com/bounties)
- Submit findings [using the C4 form](https://code4rena.com/bounties/legion.cc/submit)

| Risk Score | Payout            |
| ---------- | ----------------- |
| Critical   | Up to USD $75,000 |
| High       | USD $10,000       |

## Background on Legion

### What Is Legion?

Legion is a groundbreaking platform that connects value-add network participants with the most promising crypto projects seeking to build a dedicated community through compliant and incentive-aligned investments, both pre-Token Generation Event (TGE) and for token launches.

### How Does It Work?

The Legion protocol consists of smart contracts designed to facilitate different types of ERC20 token sales and manage related operations.

Legion uses a Clone Pattern utilizing the [EIP-1167 Minimal Proxy Standard](https://eips.ethereum.org/EIPS/eip-1167) for deploying sale and vesting schedule contracts. Standard **Merkle Proofs** and **Signatures** are used for verification of different conditions, such as eligibility to distribute tokens to investors, token and funds claiming etc.

Legion's smart contracts work together with Legion's backend, which is responsible for publishing sale results after analyzing and indexing events emitted during the sale process.

### Further Technical Resources & Links

- **Legion Docs**: Our system documentation, subject to change. [Link](https://legion-1.gitbook.io/)
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

| Name (Address Link)                                                                                     | Repo                                                                                                                  |
| ------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| [LegionBouncer](https://etherscan.io/address/0x4a7aca57a685c9e893f60a716415e5e588500533)                | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/LegionBouncer.sol>                          |
| [LegionVestingFactory](https://etherscan.io/address/0x7832d6730aa93f6954ca158e392b21d0a95e9e5f)         | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionVestingFactory.sol>         |
| [LegionAddressRegistry](https://etherscan.io/address/0x58ddd0816120cab3e646dd57b9722b016552aed7)        | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/LegionAddressRegistry.sol>                  |
| [LegionPreLiquidSaleV1Factory](https://etherscan.io/address/0x6d1a5c2c7f71c3a16a36a247f12ce8aedeb5c4e7) | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionPreLiquidSaleV1Factory.sol> |
| [LegionPreLiquidSaleV2Factory](https://etherscan.io/address/0x9b7ed9757e0e97e11427377fed3bb46f92d53ce9) | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/factories/LegionPreLiquidSaleV2Factory.sol> |
| [LegionPreLiquidSaleV1](https://etherscan.io/address/0x3Cd9E6a79446d8331101252F6cA8d943AC1777ef)        | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/LegionPreLiquidSaleV1.sol>                  |
| [LegionPreLiquidSaleV2](https://etherscan.io/address/0x076Ff291EA6783C17d8AC3459E1Fd9Da37741add)        | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/LegionPreLiquidSaleV2.sol>                  |
| [LegionLinearVesting](https://etherscan.io/address/0x423781817E3998659AE3a012357e1B958e9aEE06)          | <https://github.com/Legion-Team/legion-protocol-contracts/blob/master/src/LegionLinearVesting.sol>                    |

## Out-of-Scope

### Known Issues

Bug reports covering previously-discovered bugs (listed below) are not eligible for a reward within this program. This includes known issues that the project is aware of but has consciously decided not to “fix”, necessary code changes, or any implemented operational mitigating procedures that can lessen potential risk. Every issue opened in the repo, closed PRs, previous contests and audits are out of scope.

The following are known issues and therefore are out of scope:

- Centralisation Risks
- Lack of support for fee-on-transfer and rebasing tokens
- Project owners are not required to provide ask tokens before
  withdrawing capital

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
