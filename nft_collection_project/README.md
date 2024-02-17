## Introduction To NFT Collection Project 

The objective of this endeavor is to improve an already established NFT smart contract through the integration of a novel function known as borrowAuthNFT. This newly introduced function is intended to enable public access for retrieving metadata associated with NFTs stored on the blockchain. The initiative encompasses tasks such as configuring accounts, minting NFTs, and developing scripts to showcase the functionality.

## Contract Explanation 

```cadence
import NonFungibleToken from 0x02

pub contract CryptoPoops: NonFungibleToken {
  pub var totalSupply: UInt64

  pub event ContractInitialized()
  pub event Withdraw(id: UInt64, from: Address?)
  pub event Deposit(id: UInt64, to: Address?)

  pub resource NFT: NonFungibleToken.INFT {
    pub let id: UInt64

    pub let name: String
    pub let favouriteFood: String
    pub let luckyNumber: Int

    init(_name: String, _favouriteFood: String, _luckyNumber: Int) {
      self.id = self.uuid

      self.name = _name
      self.favouriteFood = _favouriteFood
      self.luckyNumber = _luckyNumber
    }
  }

  pub resource Collection: NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic {
    pub var ownedNFTs: @{UInt64: NonFungibleToken.NFT}

    // Dictionary to store owned NFTs' metadata
    pub var ownedNFTsMetadata: @{UInt64: CryptoPoops.NFT}

    pub fun withdraw(withdrawID: UInt64): @NonFungibleToken.NFT {
        let nft <- self.ownedNFTs.remove(key: withdrawID)
                ?? panic("This NFT does not exist in this Collection.")
        emit Withdraw(id: nft.id, from: self.owner?.address)
        return <- nft
    }

    pub fun deposit(token: @NonFungibleToken.NFT) {
        let nft <- token as! @NFT
        emit Deposit(id: nft.id, to: self.owner?.address)
        self.ownedNFTs[nft.id] <-! nft
    }

    pub fun getIDs(): [UInt64] {
        return self.ownedNFTs.keys
    }

    pub fun borrowNFT(id: UInt64): &NonFungibleToken.NFT {
        return (&self.ownedNFTs[id] as &NonFungibleToken.NFT?)!
    }

    // Borrow a reference to an NFT's metadata using its ID
    pub fun borrowAuthNFT(id: UInt64): &CryptoPoops.NFT {
        return (&self.ownedNFTsMetadata[id] as &CryptoPoops.NFT?)!
    }


    init() {
      self.ownedNFTs <- {}
      self.ownedNFTsMetadata <- {}
    }

    destroy() {
      destroy self.ownedNFTs
      destroy self.ownedNFTsMetadata
    }
  }

  pub fun createEmptyCollection(): @NonFungibleToken.Collection {
    return <- create Collection()
  }

  pub resource Minter {

    pub fun createNFT(name: String, favouriteFood: String, luckyNumber: Int): @NFT {
      return <- create NFT(_name: name, _favouriteFood: favouriteFood, _luckyNumber: luckyNumber)
    }

    pub fun createMinter(): @Minter {
      return <- create Minter()
    }

  }

  init() {
    self.totalSupply = 0
    emit ContractInitialized()
    self.account.save(<- create Minter(), to: /storage/Minter)
  }
}
```

A smart contract named CryptoPoops inheriting from the 0x05 version of NonFungibleToken. This contract introduces an NFT resource with properties like name, favorite food, and lucky number. Additionally, it includes a collection resource to manage ownership of NFTs, enabling withdrawal, deposit, and retrieval of NFTs by ID. The contract incorporates a Minter resource for NFT creation and Minter instantiation. Notably, the borrowAuthNFT function provides authenticated access to owned NFTs. Upon initialization, the contract sets total supply to zero, emits a ContractInitialized event, and saves a Minter instance to storage. Overall, the contract establishes a flexible NFT framework with access control and comprehensive functionalities

## Transaction 

#### Collection 

```cadence
import CryptoPoops from 0x01

transaction() {
  prepare(signer: AuthAccount) {
    // Check if a collection already exists in the account storage.
    if signer.borrow<&CryptoPoops.Collection>(from: /storage/CryptoPoopsCollection) != nil {
      log("You already have a collection")
      return
    }

    // Create a collection in account storage.
    signer.save(<- CryptoPoops.createEmptyCollection(), to: /storage/CryptoPoopsCollection)

    // Link it to the public.
    signer.link<&CryptoPoops.Collection>(/public/CryptoPoopsCollection, target: /storage/CryptoPoopsCollection)

    log("Collection Created")
  }
}
```
 imports the CryptoPoops module from address 0x01 and defines a transaction function. Within this function, it first checks whether the account storage already contains a CryptoPoops collection. If a collection exists, a log message is generated, indicating that the user already possesses a collection. In the absence of a collection, the code proceeds to create an empty collection using CryptoPoops.createEmptyCollection() and saves it to the account storage. Subsequently, the newly created collection is linked to the public namespace, specifically to /public/CryptoPoopsCollection. A log message is then generated to confirm the successful creation of the collection.

 ### Mint

 ```cadence
import NonFungibleToken from 0x02
import CryptoPoops from 0x01

transaction(recipientAccount: Address, _name: String, _favFood: String, _luckyNo: Int) {
  prepare(signer: AuthAccount) {
    // Borrow a reference to the minter
    let minter = signer.borrow<&CryptoPoops.Minter>(from: /storage/Minter)!

    // Borrow a reference to the recipient`s public Collection
    let pubrecipientRef = getAccount(recipientAccount).getCapability(/public/CryptoPoopsCollection)
                    .borrow<&CryptoPoops.Collection{NonFungibleToken.CollectionPublic}>()
                    ?? panic("There is no collection associated with the address.")

    // Mint the NFT using the reference to the minter
    let nft <- minter.createNFT(name: _name, favouriteFood: _favFood, luckyNumber: _luckyNo)

    // Deposit the NFT in the recipient's collection
    pubrecipientRef.deposit(token: <- nft)
  }

  execute {
    log("NFT minted and deposited successfully")
  }
}
```

 imports the NonFungibleToken module from address 0x02 and the CryptoPoops module from address 0x01. It defines a transaction function that takes parameters for the recipient's account address, name, favorite food, and lucky number. Within the prepare block, the code borrows a reference to the CryptoPoops.Minter from the account storage. It also borrows a reference to the recipient's public CryptoPoops collection. The transaction then mints a new NFT using the minter reference with the provided name, favorite food, and lucky number. Finally, the newly minted NFT is deposited into the recipient's collection using the public reference. The execute block logs a message indicating the successful minting and deposit of the NFT.

 
