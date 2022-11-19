//
//  StorageManager.swift
//  SketchPerfect
//
//  Created by Ethan Chew on 5/11/22.
//

import Foundation
import Firebase
import FirebaseStorage

public class StorageManager: ObservableObject {
    let storage = Storage.storage()
    
    @Published var imageData = ImageData(easy: [], medium: [], hard: [])
    
    func getImages(completion: @escaping (ImageData?) -> ()) {
        let imageTypes = ["easy", "medium", "hard"]
        // Loops through the different Image Types and list the images inside
        for type in imageTypes {
            let storageRef = storage.reference().child(type)
            
            storageRef.listAll { (res, err) in
                if let error = err {
                    print("Error in getting files in Type: \(type), with Error: \(error.localizedDescription)")
                }
                
                if let res = res {
                    for item in res.items {
                        let imageRef = self.storage.reference(forURL: String(describing: item)) // Image Reference in the database
                        imageRef.getData(maxSize: (1 * 1024 * 1024)) { (data, err) in
                            if let err = err {
                                fatalError("An error occurred when getting Image of \(item) difficulty: \(err.localizedDescription)")
                            }
                            
                            if data != nil {
                                if let img = data {
                                    DispatchQueue.main.async {
                                        switch type {
                                        case "easy":
                                            self.imageData.easy.append(img)
                                        case "medium":
                                            self.imageData.medium.append(img)
                                        case "hard":
                                            self.imageData.hard.append(img)
                                        default:
                                            break
                                        }
                                        completion(self.imageData)
                                    }
                                }
                            }
                        }
                    }
                }
//                for item in res!.items {
//                    let imageRef = self.storage.reference(forURL: String(describing: item))
//                    imageRef.getData(maxSize: (1 * 1024 * 1024)) { (data, err) in
//                        if let err = err {
//                            fatalError("An Error Occurred when getting Image: \(err.localizedDescription)")
//                        }
//
//                        if let img = data {
//                            switch type {
//                            case "easy":
//                                self.imageData.easy.append(img)
//                            case "medium":
//                                self.imageData.medium.append(img)
//                            case "hard":
//                                self.imageData.hard.append(img)
//                            default:
//                                break
//                            }
//                        }
//                    }
//                }
            }
        }
    }
}
