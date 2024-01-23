pub contract car{

    pub struct carstruct {
        pub let car_id: UInt64
        pub let car_name: String
        pub let car_company: String

        init(id: UInt64, name: String, company: String) {
            self.car_id = id
            self.car_name = name
            self.car_company = company
        }
    }

    pub var cars: {UInt64: carstruct}

    init() {
        self.cars = {}
    }

    pub fun addcars(car_id: UInt64, car_name: String, car_company: String) {
        let car = carstruct(id: car_id, name: car_name, company: car_company)
        self.cars[car_id] = car
    }

    pub fun carsinfo(id: UInt64): carstruct? {
        return self.cars[id]
    }
}