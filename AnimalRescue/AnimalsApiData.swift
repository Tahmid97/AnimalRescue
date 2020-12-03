//
//  AnimalsApiData.swift
//  AnimalRescue
//
//  Created by Sami Tamim on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import Foundation

var catsGridList = [Animal]()
var dogsGridList = [Animal]()
var foxesGridList = [Animal]()
var randomAnimalsList = [Animal]()

/*
 ******************************
 MARK: - Get JSON Data from API
 ******************************
 */
public func getJsonDataFromApi(apiUrl: String) -> Data? {
    
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: apiUrl) {
        apiQueryUrlStruct = urlStruct
    } else {
        return nil
    }
    
    let jsonData: Data?
    do {
        /*
         Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
         Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
         */
        jsonData = try Data(contentsOf: apiQueryUrlStruct!, options: Data.ReadingOptions.mappedIfSafe)
        return jsonData
        
    } catch {
        return nil
    }
}

public func populateLists() {
    for _ in 1...50 {
        catsGridList.append(getCatFromApi())
        dogsGridList.append(getDogFromApi())
        foxesGridList.append(getFoxFromApi())
    }
    
    for index in 1...48 {
        let number = Int.random(in: 1...3)
        switch number {
        case 1:
            randomAnimalsList.append(catsGridList[index])
        case 2:
            randomAnimalsList.append(dogsGridList[index])
        case 3:
            randomAnimalsList.append(foxesGridList[index])
        default:
            break
        }
    }
    
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getCatFromApi() -> Animal {
    let catPictureUrl = "https://aws.random.cat/meow"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: catPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving cat")
            return getCatFromApi()
        }
        
        if let photoLink = jsonDataDictionary["file"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getCatFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving cat")
            return getCatFromApi()
        }
        
    }
    catch {
        print("error retrieving cat")
    }
    
    return Animal(id: UUID(), animalType: "Cat", photoUrl: photoUrl)
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getDogFromApi() -> Animal {
    let dogPictureUrl = "https://dog.ceo/api/breeds/image/random"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: dogPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving dog")
            return getDogFromApi()
        }
        
        if let photoLink = jsonDataDictionary["message"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getDogFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving dog")
            return getDogFromApi()
        }
        
    }
    catch {
        print("error retrieving dog")
    }
    
    return Animal(id: UUID(), animalType: "Dog", photoUrl: photoUrl)
}

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getFoxFromApi() -> Animal {
    let foxPictureUrl = "https://randomfox.ca/floof/"
    
    // The function is given in ApiData.swift
    let jsonDataFromApi = getJsonDataFromApi(apiUrl: foxPictureUrl)
    var photoUrl = ""
    
    //------------------------------------------------
    // JSON data is obtained from the API. Process it.
    //------------------------------------------------
    
    do {
        /*
         Foundation framework’s JSONSerialization class is used to convert JSON data
         into Swift data types such as Dictionary, Array, String, Number, or Bool.
         */
        let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi!,
                                                            options: JSONSerialization.ReadingOptions.mutableContainers)
        
        /*
         JSON object with Attribute-Value pairs corresponds to Swift Dictionary type with
         Key-Value pairs. Therefore, we use a Dictionary to represent a JSON object
         where Dictionary Key type is String and Value type is Any (instance of any type)
         */
        var jsonDataDictionary = Dictionary<String, Any>()
        
        if let jsonObject = jsonResponse as? [String: Any] {
            jsonDataDictionary = jsonObject
        } else {
            print("error retrieving fox")
            return getFoxFromApi()
        }
        
        if let photoLink = jsonDataDictionary["image"] as? String {
            if (photoLink.suffix(3) == "gif") {
                return getFoxFromApi()
            }
            photoUrl = photoLink
        } else {
            print("error retrieving fox")
            return getFoxFromApi()
        }
        
    }
    catch {
        print("error retrieving fox")
    }
    
    return Animal(id: UUID(), animalType: "Fox", photoUrl: photoUrl)
}
