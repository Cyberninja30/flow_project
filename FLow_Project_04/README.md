## Access Modifiers in Flow 

In Flow blockchain's Cadence programming language, access modifiers are used to control the visibility and accessibility of variables, functions, and resources within smart contracts. Cadence provides three main access modifiers:

**Public (pub):**

Public declarations can be accessed from anywhere, both internally within the contract and externally from other contracts or transactions.
They are visible to all accounts on the Flow blockchain.

**Private (priv):**

Private declarations are only accessible within the contract they are defined in.
They cannot be accessed from outside the contract, including other contracts and transactions.

## Contract Explanations

```cadence
access(all) contract SomeContract {

    pub var testStruct: SomeStruct


    pub struct SomeStruct {

        //
        // 4 Variables
        // There are four variable with different access modifiers keywords use

        // We've write or read permission to the value of this variable from Somestruct (Area 1), Resources (Area 2)
        // Other Function (Area 3) and Other files like scripts (Area 4)

        pub(set) var a: String

        // We've read permission to the value of this variable from Somestruct (Area 1), Resources (Area 2)
        // Other Function (Area 3) and Other files like scripts (Area 4), and write permission only from area 01

        pub var b: String

        // Read scope in Areas 1, 2, and 3; Write scope in Area 1 only

         // We've read permission to the value of this variable from Somestruct (Area 1), Resources (Area 2)
        // Other Function (Area 3), and write permission only from area 01
        access(contract) var c: String


        // We've write or read permission to the value of this variable from Somestruct (Area 1)
        access(self) var d: String

        //
        // 3 Functions
        //

        // Accessible in Areas 1, 2, 3, and 4
        pub fun publicFunc() {}

        // Accessible in Areas 1, 2, and 3; Limited to contract scope
        access(contract) fun contractFunc() {}

        // Accessible in Area 1 only; Restricted to struct scope
        access(self) fun privateFunc() {}

        pub fun structFunc() {
            /**************/
            /*** AREA 1 ***/
            /**************/
        }

        init() {
            self.a = "a"
            self.b = "b"
            self.c = "c"
            self.d = "d"
        }
    }

    pub resource SomeResource {
        pub var e: Int


        pub fun resourceFunc() {
            /**************/
            /*** AREA 2 ***/
            /**************/
        }

        init() {
            self.e = 17
        }
    }


    pub fun createSomeResource(): @SomeResource {
        return <- create SomeResource()
    }


    pub fun questsAreFun() {
        /**************/
        /*** AREA 3 ****/
        /**************/
    }

    init() {
        self.testStruct = SomeStruct()
    }
}
```

A Cadence code outlines a smart contract named SomeContract, incorporating variables, functions, and a resource. Within SomeContract, a custom struct named SomeStruct is defined. This struct contains four variables, each designated with distinct access modifiers governing their visibility and accessibility. For instance, variable a allows both read and write operations across various areas, while variable d confines its permissions solely to the struct's scope. Additionally, SomeStruct encompasses three functions, each with its access level, dictating where they can be invoked within the contract or the blockchain.

Moreover, SomeContract encompasses a resource termed SomeResource, housing a single public variable e of integer type. Initialization functions are provided for both SomeStruct and SomeResource, configuring their initial states upon deployment.

Furthermore, two standalone functions exist outside the struct and resource scopes. createSomeResource() instantiates a SomeResource instance and returns it, while questsAreFun() serves as a generic function definition.

The contract concludes with an initialization function init(), initializing the testStruct variable with a new SomeStruct instance. This function establishes initial configurations when the contract is deployed onto the blockchain.

In essence, SomeContract orchestrates a structured environment regulating the access and functionality of its components, ensuring secure and controlled interactions within the Flow blockchain ecosystem.

