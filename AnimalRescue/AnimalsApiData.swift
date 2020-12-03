//
//  AnimalsApiData.swift
//  AnimalRescue
//
//  Created by Sami Tamim on 12/2/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import SwiftUI
import Foundation

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

/*
 *********************************************
 MARK: - Obtain Cat Picture from Api
 *********************************************
 */
public func getCatPictureUrlFromApi() -> String {
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
            return "e"
        }
        
        if let photoLink = jsonDataDictionary["file"] as? String {
            photoUrl = photoLink
        } else {
            print("error retrieving cat")
            return "e"
        }
        
    }
    catch {
        print("error retrieving cat")
    }
    
    return photoUrl
}
