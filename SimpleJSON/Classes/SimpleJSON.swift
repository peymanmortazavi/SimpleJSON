//
//  SimpleJSON.swift
//  Pods
//
//  Created by Peyman Mortazavi on 9/10/16.
//
//

import Foundation


/**
    JSON Deserializable Protocol. Classes and structures that
    implement this protocol, must initialize based on given
    dictionary if and only if they can find sufficient data
    in the dictionary to initialize a valid instance.
*/
public protocol Deserializable {
    init?(dictionary: [String:AnyObject])
}

infix operator --> { associativity left precedence 60 }

public func --><T: Deserializable>(left: AnyObject?, right: T.Type) -> T? {
    if let dictionary = left as? [String:AnyObject] {
        return T.init(dictionary: dictionary)
    }
    return nil
}

public func --><T: Deserializable>(left: AnyObject?, right: [T].Type) -> [T]? {
    if let array = left as? NSArray {
        return array.flatMap({ (object) -> T? in
            return object --> T.self
        })
    }
    return nil
}

public func --><G>(left: AnyObject?, right: G.Type) -> G? {
    return left as? G
}

public func --><G>(left: AnyObject?, right: [G].Type) -> [G]? {
    if let array = left as? NSArray {
        return array.flatMap({ (object) -> G? in
            return object as? G
        })
    }
    return nil
}

public func --><T: Deserializable>(left: NSData, right: T.Type) -> T? {
    do {
        let jsonObject = try NSJSONSerialization
            .JSONObjectWithData(left, options: .AllowFragments)
        
        return jsonObject --> T.self
    } catch {
        return nil
    }
}

public func --><T: Deserializable>(left: NSData, right: [T].Type) -> [T]? {
    do {
        let jsonObject = try NSJSONSerialization
            .JSONObjectWithData(left, options: .AllowFragments)
        
        return jsonObject --> [T].self
    } catch {
        return nil
    }
}

public func --><T: Deserializable>(left: String, right: T.Type) -> T? {
    if let data = left.dataUsingEncoding(NSUTF8StringEncoding) {
        return data --> T.self
    }
    return nil
}

public func --><T: Deserializable>(left: String, right: [T].Type) -> [T]? {
    if let data = left.dataUsingEncoding(NSUTF8StringEncoding) {
        return data --> [T].self
    }
    return nil
}
