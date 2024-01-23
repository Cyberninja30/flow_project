import car from 0x05

transaction(id: UInt64, name: String, company: String) {
    
    prepare(acct: AuthAccount) {}

    execute {
      car.addcars(car_id: id, car_name: name, car_company: company)
      log("Cars Information Added")
    }
}