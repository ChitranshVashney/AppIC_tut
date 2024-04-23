import TrieMap "mo:base/TrieMap";
import Nat "mo:base/Nat";
import Hash "mo:base/Hash";
import Principal "mo:base/Principal";

actor AppIC_tut_backend {
  // Define the structure for a position

  // Define the structure for a swap
  type SwapStatus = {
    #Successful;
    #Failed;
  };

  type Swap = {
    swapTime : Nat;
    swapStatus : SwapStatus;
  };

  type Position = {
    sellToken : Principal;
    buyToken : Principal;
    sellAmount : Nat;
    swaps : Swap;
  };
  // Create the TrieMap to store positions
  var positions = TrieMap.TrieMap<Nat, Position>(Nat.equal, Hash.hash);

  public func createPosition(sellToken : Principal, buyToken : Principal, sellAmount : Nat, swapTime : Nat) : async Nat {
    let swap = {
      swapTime = swapTime;
      swapStatus = #Failed;
    };
    let position = {
      sellToken = sellToken;
      buyToken = buyToken;
      sellAmount = sellAmount;
      swaps = swap;
    };
    let positionId = positions.size();
    positions.put(positionId, position);
    return positionId;
  };

  // Function to edit an existing position
  public func editPosition(positionId : Nat, newSellToken : Principal, newBuyToken : Principal, newSellAmount : Nat, newSwapTime : Nat) : async Bool {
    let maybePosition = positions.get(positionId);
    switch (maybePosition) {
      case (null) {
        return false;
      };
      case (?oldPosition) {
        let newPosition = {
          sellToken = newSellToken;
          buyToken = newBuyToken;
          sellAmount = newSellAmount;
          swaps = {
            swapTime = newSwapTime;
            swapStatus = oldPosition.swaps.swapStatus; // Maintain the same status
          };
        };
        positions.put(positionId, newPosition);
        return true;
      };
    };
  };

  // Function to delete a position
  public func deletePosition(positionId : Nat) : async Bool {
    positions.delete(positionId);
    return true;
  };

};
