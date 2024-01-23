import car from 0x05

pub fun main(id: UInt64): car.carstruct? {
  return car.carsinfo(id: id)!
}