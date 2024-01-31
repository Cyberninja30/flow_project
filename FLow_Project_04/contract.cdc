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
