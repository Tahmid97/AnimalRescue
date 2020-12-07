//
//  RescueGroupsApiData.swift
//  AnimalRescue
//
//  Created by CS3714 on 12/3/20.
//  Copyright © 2020 CS3714-91386 Team 16. All rights reserved.
//

import Foundation

fileprivate let appKey = "GLJHM8fB"

// Global variable of found animals
var rescueGroupsAnimalsList = [AnimalStruct]()

public func getAnimalRescueDataFromApi(animal: String) {
    
    // Initialization
    rescueGroupsAnimalsList = [AnimalStruct]()
    
    /*
     *********************************************
     *   Obtaining API Search Query URL Struct   *
     *********************************************
     */
    var apiQueryUrlStruct: URL?
    
    if let urlStruct = URL(string: "https://test1-api.rescuegroups.org/v5/public/animals/search/available/\(animal)/haspic/") {
        apiQueryUrlStruct = urlStruct
    } else {
        return
    }
    
    /*
     *******************************
     *   HTTP GET Request Set Up   *
     *******************************
     */
    
    let headers = [
        "Authorization": appKey,
        "Content-Type": "application/vnd.api+json",
    ]
    
    let request = NSMutableURLRequest(url: apiQueryUrlStruct!,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    /*
     You may need to increase the timeout interval from 10 seconds to a higher value
     if fetching data from the API is much more time consuming.
     */
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    
    /*
     *********************************************************************
     *  Setting Up a URL Session to Fetch the JSON File from the API     *
     *  in an Asynchronous Manner and Processing the Received JSON File  *
     *********************************************************************
     */
    
    /*
     Create a semaphore to control getting and processing API data.
     signal() -> Int    Signals (increments) a semaphore.
     wait()             Waits for, or decrements, a semaphore.
     */
    let semaphore = DispatchSemaphore(value: 0)
    
    URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        /*
         URLSession is established and the JSON file from the API is set to be fetched
         in an asynchronous manner. After the file is fetched, data, response, error
         are returned as the input parameter values of this Completion Handler Closure.
         */
        
        // Process input parameter 'error'
        guard error == nil else {
            semaphore.signal()
            return
        }
        
        // Process input parameter 'response'. HTTP response status codes from 200 to 299 indicate success.
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            semaphore.signal()
            return
        }
        
        // Process input parameter 'data'. Unwrap Optional 'data' if it has a value.
        guard let jsonDataFromApi = data else {
            semaphore.signal()
            return
        }
        
        //------------------------------------------------
        // JSON data is obtained from the API. Process it.
        //------------------------------------------------
        do {
            /*
             Foundation framework’s JSONSerialization class is used to convert JSON data
             into Swift data types such as Dictionary, Array, String, Number, or Bool.
             */
            let jsonResponse = try JSONSerialization.jsonObject(with: jsonDataFromApi,
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
                semaphore.signal()
                return
            }
            
            var idUrlDictionary = Dictionary<String, String>()
            
            // Make a dictionary of photo URL
            if let includeArray = jsonDataDictionary["included"] as? [Any] {
                // Iterate over the array
                for aJsonObject in includeArray {
                    let include = aJsonObject as! [String: Any]
                    let type = include["type"] as! String
                    
                    if type == "pictures" {
                        let id = include["id"] as! String
                        let attributes = include["attributes"] as! [String: Any]
                        let original = attributes["original"] as! [String: Any]
                        let url = original["url"] as? String ?? ""
                        
                        idUrlDictionary[id] = url
                    }
                    else {
                        continue
                    }
                }   // End of 'for loop'
            } else {
                // Return an empty response indicating that API access was unsuccessful
                return
            }
            
            
            
            
            if let dataArray = jsonDataDictionary["data"] as? [Any] {
                // Iterate over the array
                for aJsonObject in dataArray {
                    let data = aJsonObject as! [String: Any]
                    let attributes = data["attributes"] as! [String: Any]
                    
                    let relationships = data["relationships"] as! [String: Any]
                    let pictures = relationships["pictures"] as? [String: Any] ?? nil
                    
                    var id = ""
                    
                    if pictures != nil {
                        let pictureData = pictures?["data"] as! [Any]
                        let pic0 = pictureData[0] as! [String: Any]
                        id = pic0["id"] as! String
                        //print(id)
                    }
                    
                    // Extract the features
                    let adoptionFeeString = attributes["adoptionFeeString"] as? String ?? "Not Listed"
                    let ageGroup = attributes["ageGroup"] as? String ?? "Not Listed"
                    let ageString = attributes["ageString"] as? String ?? "Not Listed"
                    let availableDate = attributes["availableDate"] as? String ?? "Not Listed"
                    let birthDate = attributes["birthDate"] as? String ?? "Not Listed"
                    let breedString = attributes["breedString"] as? String ?? "Not Listed"
                    let colorDetails = attributes["colorDetails"] as? String ?? "Not Listed"
                    let descriptionText = attributes["descriptionText"] as? String ?? "Not Listed"
                    let indoorOutdoor = attributes["indoorOutdoor"] as? String ?? "Not Listed"
                    let name = attributes["name"] as? String ?? "Not Listed"
                    let sex = attributes["sex"] as? String ?? "Not Listed"
                    let url = attributes["url"] as? String ?? "Not Listed"
                    
                    var photoUrl = ""
                    
                    if let purl = idUrlDictionary[id] {
                        photoUrl = purl
                    }
                    else {
                        photoUrl = ""
                    }
                                        
                    let animalFound = AnimalStruct(id: UUID().uuidString, adoptionFeeString: adoptionFeeString, ageGroup: ageGroup, ageString: ageString, availableDate: availableDate, birthDate: birthDate, breedString: breedString, colorDetails: colorDetails, descriptionText: descriptionText, indoorOutdoor: indoorOutdoor, name: name, species: String(animal.dropLast()), sex: sex, url: url, photoUrl: photoUrl)
                    
                    rescueGroupsAnimalsList.append(animalFound)
                    //print(animalFound)
                }   // End of 'for loop'
            } else {
                // Return an empty response indicating that API access was unsuccessful
                return
            }
            
            
            /*
             activityLevel = "Moderately Active";
             adoptedDate = "2011-01-21T00:00:00Z";
             # adoptionFeeString = "25.00";
             # ageGroup = Adult;
             # ageString = "15 Years 8 Months";
             # availableDate = "2011-03-10T00:00:00Z";
             # birthDate = "2004-11-07T00:00:00Z";
             breedPrimary = "Domestic Short Hair";
             breedPrimaryId = 35;
             # breedString = "Domestic Short Hair";
             # colorDetails = "brown tabby";
             createdDate = "2005-11-07T22:28:13Z";
             descriptionHtml = "Katie&nbsp;is a real character. She's super playful and full of funny antics. She still acts like a kitten.&nbsp; She's a quiet, low maintenance cat.&nbsp; She prances into and out of her carrier without assistance, is a good traveler, and is eager to meet each new royal adventure. She prefers to be the ruler of her own&nbsp;castle, but will tolerate other cats.&nbsp; To meet her or for more information, please call (561) 784-4792.<img src=\"https://tracker.rescuegroups.org/pet?13197\" width=\"0\" height=\"0\" alt=\"\" />";
             # descriptionText = "Katie&nbsp;is a real character. She's super playful and full of funny antics. She still acts like a kitten.&nbsp; She's a quiet, low maintenance cat.&nbsp; She prances into and out of her carrier without assistance, is a good traveler, and is eager to meet each new royal adventure. She prefers to be the ruler of her own&nbsp;castle, but will tolerate other cats.&nbsp; To meet her or for more information, please call (561) 784-4792.";
             # indoorOutdoor = "Indoor Only";
             isAdoptionPending = 0;
             isBirthDateExact = 0;
             isCourtesyListing = 0;
             isCurrentVaccinations = 1;
             isDeclawed = 0;
             isDogsOk = 1;
             isFound = 0;
             isHousetrained = 1;
             isNeedingFoster = 0;
             isSpecialNeeds = 0;
             isSponsorable = 1;
             # name = Katie;
             newPeopleReaction = Friendly;
             ownerExperience = Breed;
             pictureCount = 10;
             pictureThumbnailUrl = "https://s3.amazonaws.com/filestore.rescuegroups.org/112/pictures/animals/13/13197/14275605_100x87.jpg";
             priority = 10;
             # sex = Female;
             sizeCurrent = 9;
             sizeGroup = Small;
             sizeUOM = Pounds;
             slug = "adopt-katie-domestic-short-hair-cat";
             updatedDate = "2019-10-24T21:13:17Z";
             # url = "https://www.animalrescueforce.org/animals/detail?AnimalID=13197";
             videoCount = 0;
             videoUrlCount = 0;
             */
            
            
        } catch {
            semaphore.signal()
            return
        }
        
        semaphore.signal()
    }).resume()
    
    /*
     The URLSession task above is set up. It begins in a suspended state.
     The resume() method starts processing the task in an execution thread.
     
     The semaphore.wait blocks the execution thread and starts waiting.
     Upon completion of the task, the Completion Handler code is executed.
     The waiting ends when .signal() fires or timeout period of 10 seconds expires.
     */
    
    _ = semaphore.wait(timeout: .now() + 10)
    
    /*
     You may need to increase the timeout interval from 10 seconds to a higher value
     if fetching data from the API is much more time consuming.
     */
    
}
