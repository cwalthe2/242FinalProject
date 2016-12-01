//
//  uome_db.swift
//  U O ME
//
//  Created by Rohit Saigal on 11/20/16.
//  Copyright © 2016 Collin Walther, Rohit Saigal. All rights reserved.
//

import Foundation
import SQLite
import UIKit
class uomeDB {
    static let instance = uomeDB()
    let db:Connection?
    
    private let users=Table("users")
    
    private let level = Expression<Int64>("level")
    private let first = Expression<String?>("first")
    private let last = Expression<String?>("last")
    private let email = Expression<String>("email")
    private let id = Expression<Int64>("id")
    
    init(){
        
        
        //let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        do{
            db=try Connection("/Users/Collin/Desktop/uomeDatabase.db")
            print("database OPENED :) :) 8===D~~~")
        }catch{
            db=nil
            print("cant open db")
        }
        
        
        //createTable()
    }
    func createTable() {
        do {
            try db!.run(users.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(first)
                table.column(last)
                table.column(email, unique: true)
                table.column(level)
            })
            print("created table")
        } catch {
            print("Unable to create table")
        }
    }
    
    func addUsers(ufirst: String, ulast:String, uemail: String, ulevel: Int64) -> Int64? {
        do {
            let insert = users.insert(first <- ufirst,last <- ulast, email <- uemail, level <- ulevel)
            print(insert.asSQL())
            let id = try db!.run(insert)
            
            print("Insert succeeded")
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getUsers() -> [User] {
        var users = [User]()
        

        
        
        do {
            for user in try db!.prepare(self.users) {
                users.append(User(name: user[first]!, level: NSInteger(user[level]), image:UIImage(named:"profile_icon  30x30.png")!, points: 0))
                
            }
        } catch {
            print("Select failed")
        }
        
        return users
    }
    
    
}
