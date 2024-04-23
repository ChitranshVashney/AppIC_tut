# autoInvest Project - Smart Contract Documentation

This document outlines the functionalities implemented in the autoInvest smart contract deployed on the Internet Computer. The contract facilitates the management of positions related to token swaps, using a TrieMap data structure for efficient storage and retrieval.

## Data Structures

### SwapStatus

Represents the status of a token swap.

- **Successful**: Indicates that the swap was completed successfully.
- **Failed**: Indicates that the swap failed to complete.

### Swap

Stores details about a token swap operation.

- **swapTime** (`Nat`): The timestamp when the swap was initiated.
- **swapStatus** (`SwapStatus`): The status of the swap, either `Successful` or `Failed`.

### Position

Represents a trading position involving token swaps.

- **sellToken** (`Principal`): The principal ID of the token being sold.
- **buyToken** (`Principal`): The principal ID of the token being bought.
- **sellAmount** (`Nat`): The amount of the sellToken being offered.
- **swaps** (`Swap`): The swap details associated with this position.

## Functions

### createPosition

Creates a new position and stores it in the TrieMap.

- **Parameters**:
  - `sellToken` (`Principal`): The principal ID of the sell token.
  - `buyToken` (`Principal`): The principal ID of the buy token.
  - `sellAmount` (`Nat`): The amount of the sell token.
  - `swapTime` (`Nat`): The time when the swap was initiated.
- **Returns**: `Nat`
  - Returns the unique identifier (`positionId`) of the newly created position.
- **Errors**:
  - None explicitly thrown, but incorrect types in parameters will prevent compilation.

### editPosition

Updates an existing position with new values.

- **Parameters**:
  - `positionId` (`Nat`): The identifier of the position to update.
  - `newSellToken` (`Principal`): Updated principal ID of the sell token.
  - `newBuyToken` (`Principal`): Updated principal ID of the buy token.
  - `newSellAmount` (`Nat`): Updated amount of the sell token.
  - `newSwapTime` (`Nat`): Updated time when the swap was initiated.
- **Returns**: `Bool`
  - Returns `true` if the position was successfully updated, `false` if the position does not exist.
- **Errors**:
  - No position found with the given `positionId`.

### deletePosition

Removes a position from the TrieMap.

- **Parameters**:
  - `positionId` (`Nat`): The identifier of the position to delete.
- **Returns**: `Bool`
  - Returns `true` if the position was successfully removed, `false` if the position does not exist.
- **Errors**:
  - No position found with the given `positionId`.

## Usage Example

```shell
# Create a new position
dfx canister call autoInvest createPosition '(principal "aaaaa-aa", principal "bbbbb-bb", 1000, 1618033988)'

# Edit an existing position
dfx canister call autoInvest editPosition '(0, principal "ccccc-cc", principal "ddddd-dd", 1500, 1618033999)'

# Delete a position
dfx canister call autoInvest deletePosition '(0)'
```
