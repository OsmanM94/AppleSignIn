//
//  ViewModel.swift
//  AppleSignIn
//
//  Created by Osman M. on 22/05/2024.
//

import SwiftUI
import CloudKit
import AuthenticationServices

@MainActor
final class CloudKitViewModel: ObservableObject {
    @Published private(set) var user: User?
    @Published var errorMessage: String?
    
    private var container: CKContainer
    private var database: CKDatabase
    
    init() {
        self.container = CKContainer.default()
        self.database = container.publicCloudDatabase
    }
    
    func checkUserStatus() {
        container.fetchUserRecordID { recordID, error in
            if let recordID = recordID {
                DispatchQueue.main.async {
                    self.user = User(id: recordID.recordName, name: "User")
                    self.fetchUserData(userID: recordID.recordName)
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Authentication failed. Please ensure you are logged in to iCloud.: \(error.localizedDescription)"
                }
            }
        }
    }
    
    func handleAuthorizationAppleIDRequest(request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }
    
    func handleAuthorizationAppleIDCompletion(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let userID = appleIDCredential.user
                let fullName = appleIDCredential.fullName?.givenName ?? "User"
                
                let newUser = User(id: userID, name: fullName)
                saveUserData(user: newUser)
                
                DispatchQueue.main.async {
                    self.user = newUser
                }
            }
        case .failure:
            DispatchQueue.main.async {
                self.errorMessage = "Sign in with Apple failed. Please check your internet connection."
            }
        }
    }
    
    func saveUserData(user: User) {
        let record = CKRecord(recordType: "User")
        record["id"] = user.id as CKRecordValue
        record["name"] = user.name as CKRecordValue
        
        database.save(record) { record, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error saving user data: \(error.localizedDescription)"
                }
            } else {
                DispatchQueue.main.async {
                    print("User data saved successfully.")
                }
            }
        }
    }
    
    func fetchUserData(userID: String) {
        let predicate = NSPredicate(format: "id == %@", userID)
        let query = CKQuery(recordType: "User", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.resultsLimit = 1
        operation.recordMatchedBlock = { recordID, recordResult in
            switch recordResult {
            case .success(let record):
                DispatchQueue.main.async {
                    let id = record["id"] as! String
                    let name = record["name"] as! String
                    self.user = User(id: id, name: name)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Error fetching user data: \(error.localizedDescription)"
                }
            }
        }
        operation.queryResultBlock = { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorMessage = "Error fetching user data: \(error.localizedDescription)"
                }
            }
        }
        database.add(operation)
    }
    
    func signOut() {
            DispatchQueue.main.async {
                self.user = nil
                self.errorMessage = nil
            }
        }

}





