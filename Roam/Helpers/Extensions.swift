//
//  Extensions.swift
//  Roam
//
//  Created by Darrel Muonekwu on 7/27/19.
//  Copyright © 2019 Darrel Muonekwu. All rights reserved.
//

import UIKit
import FirebaseFirestore

extension UIViewController {
    
    func displayError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func displayError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func displayError(title: String, message: String, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default, handler: completion)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var hasLettersOnly: Bool {
        return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
    }
    
    var containsWhitespace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    var isValidName: Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let fullName = trimmedString.components(separatedBy: " ")
        
        if fullName.count != 2 { return false }

        let firstName = fullName[0]
        let lastName = fullName[1]
        
        if !firstName.hasLettersOnly { return false }
        
        if !lastName.hasLettersOnly { return false }
        
        print("Full Name: \(fullName)")
        
        return true
    }
    
    
    func separateName() -> [String] {
            let name =  self
            let nameFormatter = PersonNameComponentsFormatter()
            if let nameComps  = nameFormatter.personNameComponents(from: name),
                let firstLetter = nameComps.givenName?.first?.uppercased(),
                let lastLetter = nameComps.familyName?.first?.uppercased(),
                let firstName = nameComps.givenName?.lowercased(),
                let lastName = nameComps.familyName?.lowercased() {
                
                let sortedName = ["\(firstLetter)\(firstName[1 ..< lastName.count])", "\(lastLetter)\(lastName[1 ..< lastName.count])"]  // J. Singh
                return sortedName
            }
            return self.components(separatedBy: " ")
    }
    
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self)!
    }
    
}


extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    func toStringInWords() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        
        let dateStr = dateFormatter.string(from: self)
        
        return formatMyDate(dateStr: dateStr)
    }
    
    private func formatMyDate(dateStr: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "h:mm a" // "4:44 pm
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        let dateStr2 = formatter.string(from: self) // "4:44 PM on June 23, 2016\n"
        
        let dateArr = dateStr.components(separatedBy: ", ") // Wednesday, January 10, 2018

        return "\(dateArr[0]) • \(dateStr2)" // Wednesday • 4:44 pm
    }
    
    var recivedUnderFiveMinutesAgo: Bool  {
        let inputDate = self.toString()
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let aDate = dateFormatter.date(from: inputDate) {
            
            let timeInterval = aDate.timeIntervalSinceNow
            
            let dateComponentsFormatter = DateComponentsFormatter()
            
            if var dateString = dateComponentsFormatter.string(from: abs(timeInterval)) {
                print ("Elapsed time= \(dateString)") // 4:04
                if (!dateString.contains(":")) { // 32   <-- seconds 
                    return true
                }
                else {
                    if (dateString.count > 4) { return false } // 12:22, 13:32, 1:23:23

                }
                dateString = dateString.replacingOccurrences(of: ":", with: ".") //  4.04
                let minutesPassed = Double(dateString) ?? 5
                
                if (minutesPassed <= 5.0) {
                    return true
                }
            }
        }
        return false
    }
}
extension DispatchGroup {
    var count: Int {
        let count = self.debugDescription.components(separatedBy: ",").filter({$0.contains("count")}).first?.components(separatedBy: CharacterSet.decimalDigits.inverted).compactMap{Int($0)}.first
        return count!
    }
    
    func customLeave(){
        if count > 0 {
            self.leave()
        }
    }
}


//let str = "abcdef"
//str[1 ..< 3] // returns "bc"
//str[5] // returns "f"
//str[80] // returns ""
//str.substring(fromIndex: 3) // returns "def"
//str.substring(toIndex: str.length - 2) // returns "abcd"
extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}

