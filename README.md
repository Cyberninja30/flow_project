##   Introduction To Project 03 

**Contract Explanation:**

This smart contract, named "car," is designed to manage information about cars on the Flow blockchain. It includes a public structure named carstruct that encapsulates details about a car, such as its unique identifier (car_id), name (car_name), and the company that produces it (car_company). The structure has an initializer (init) that sets these attributes when a new car instance is created.

The contract also features a public variable named cars, which is a dictionary mapping UInt64 (car IDs) to instances of the carstruct. The init() function initializes an empty dictionary when the contract is deployed.

Two essential functions are defined in this contract. The addcars function allows users to add new cars to the contract by specifying the car's ID, name, and company. It creates a new carstruct instance and adds it to the cars dictionary using the provided ID as the key.

The carsinfo function enables users to retrieve information about a specific car by providing its ID as an argument. It returns the corresponding carstruct instance from the cars dictionary if it exists, allowing users to access details about a particular car stored in the contract.

**Script Explanation:**

This script serves as a querying mechanism to retrieve information about a specific car by its unique identifier (id) from the imported car smart contract on the Flow blockchain. The car contract is assumed to be deployed at the address 0x05, as indicated by the import statement.

The primary function, named main, takes a single argument id of type UInt64. It attempts to fetch information about the car with the given ID by invoking the carsinfo function from the imported car contract. The function returns a nullable carstruct, representing the details of the specified car.

The script employs the ! operator to force unwrap the result, indicating an assumption that the queried car with the provided ID exists in the contract. It is important to note that if the specified car ID is not present in the contract, the script may encounter a runtime error due to the force unwrap. Therefore, it assumes the caller has ensured the existence of the queried car in the contract before invoking this script.

**Transaction Explanation**

This transaction script is designed to execute the addition of new car information to the car smart contract, assumed to be deployed at the address 0x05 on the Flow blockchain. The script takes three parameters: id of type UInt64, representing the unique identifier for the new car; name of type String, representing the name of the car; and company of type String, representing the company producing the car.

The transaction keyword indicates the beginning of a transaction, and it is followed by the parameter list enclosed in parentheses. In the execute block, the actual logic of the transaction is defined.

**Within the execute block:**

The car.addcars function is invoked with the provided parameters (id, name, and company). This function is assumed to be part of the car contract and is responsible for adding a new car entry to the contract's storage.
A logging statement, log("Cars Information Added"), is included to record the successful execution of the transaction.
The prepare block is present but empty in this script. The prepare block typically includes any operations that need to be performed before the execution of the transaction, such as authorization checks or other setup steps. In this case, it appears that no specific preparation steps are required.

## Process 

```
Generate your Contract, Transaction, and Script files within the Flow Playground environment.
Deploy the contract onto the Flow blockchain.
Utilize the transaction functionality to add a book, specifying its ID and name.
Leverage the script to retrieve information about a book by providing its ID.
```

## Summary of Project 

A smart contract and two script transactions written in the Move programming language for the Flow blockchain. The smart contract, named "car," serves as a data structure to manage information about cars. It defines a public structure, carstruct, with attributes such as car_id, car_name, and car_company. The contract includes functionalities to add new cars (addcars function) and retrieve information about a specific car (carsinfo function).

The first script transaction is designed to retrieve car information. It imports the car contract and defines a main function that takes a car ID as a parameter, querying the car contract using the carsinfo function to retrieve details about the specified car.

The second script transaction focuses on adding new car information. It also imports the car contract and defines a transaction that includes parameters for the car ID, name, and company. The transaction's execute block invokes the addcars function to add the new car entry, accompanied by a log statement indicating the successful addition of car information.





