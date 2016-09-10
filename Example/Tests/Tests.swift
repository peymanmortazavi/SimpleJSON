// https://github.com/Quick/Quick

import Quick
import Nimble
import SimpleJSON

class SimpleJSONTests: QuickSpec {
    
    struct Person : Deserializable {
        var name: String
        var age: Int
        var value2: Double
        
        init?(dictionary: [String : AnyObject]) {
            guard
                let name = dictionary["name"] --> String.self,
                let age = dictionary["age"] --> Int.self,
                let value2 = dictionary["value2"] --> Double.self else {
                    return nil
            }
            self.name = name
            self.age = age
            self.value2 = value2
        }
    }
    
    struct ProjectDetails : Deserializable {
        var manager: Person
        var costs: [String:Double]
        
        init?(dictionary: [String : AnyObject]) {
            guard
                let manager = dictionary["manager"] --> Person.self,
                let costs = dictionary["costs"] --> [String:Double].self else {
                    return nil
            }
            self.manager = manager
            self.costs = costs
        }
    }
    
    struct Group : Deserializable {
        var members: [Person]
        
        init?(dictionary: [String : AnyObject]) {
            guard let members = dictionary["members"] --> [Person].self else {
                return nil
            }
            self.members = members
        }
    }
    
    override func spec() {
        let person1_str = "{\"name\":\"peyman\", \"age\":23, \"value2\":2.56}"
        let person2_str = "{\"name\":\"sally\", \"age\":26, \"value2\":5.1}"
        let manager1_str = "{\"manager\":\(person1_str), \"costs\":{\"cheese\":8.9012, \"paper\":12.025}}"
        let group_str = "{\"members\":[\(person1_str), \(person2_str)]}"
        let persons_str = "[\(person1_str), \(person2_str)]"
        
        describe("JSON") {
            
            it("can parse basic types") {
                let person = person1_str --> Person.self
                expect(person).toNot(beNil())
                
                expect(person?.age).to(equal(23))
                expect(person?.value2).to(equal(2.56))
                expect(person?.name).to(equal("peyman"))
            }
            
            it("can read nested objects and dictionaries") {
                let projectDetails = manager1_str --> ProjectDetails.self
                expect(projectDetails).toNot(beNil())
                expect(projectDetails?.manager.age).to(equal(23))
                expect(projectDetails?.manager.name).to(equal("peyman"))
                expect(projectDetails?.manager.value2).to(equal(2.56))
                expect(projectDetails?.costs.count).to(equal(2))
                expect(projectDetails?.costs.keys.contains("cheese")).to(equal(true))
                expect(projectDetails?.costs.keys.contains("paper")).to(equal(true))
                expect(projectDetails?.costs["cheese"]).to(equal(8.9012))
                expect(projectDetails?.costs["paper"]).to(equal(12.025))
            }
            
            it("can read basic arrays") {
                let group = group_str --> Group.self
                expect(group).notTo(beNil())
                expect(group?.members.count).to(equal(2))
                expect(group?.members.first?.name).to(equal("peyman"))
                expect(group?.members.last?.name).to(equal("sally"))
            }
            
            it("can read arrays in root") {
                let persons = persons_str --> [Person].self
                expect(persons).notTo(beNil())
                expect(persons?.count).to(equal(2))
                expect(persons?.first?.name).to(equal("peyman"))
                expect(persons?.last?.name).to(equal("sally"))
            }
        }
    }
}
