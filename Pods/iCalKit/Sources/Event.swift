import Foundation

/// TODO add documentation
public struct Event {
    public var subComponents: [CalendarComponent] = []
    public var otherAttrs = [String:String]()

    // required
    public var uid: String!
    public var dtstamp: Date!

    // optional
    // public var organizer: Organizer? = nil
    public var location: String?
    public var summary: String?
    public var descr: String?
    public var bla: String?
    // public var class: some enum type?
    public var dtstart: Date?
    public var dtend: Date?
    
    public init(uid: String? = NSUUID().uuidString, dtstamp: Date? = Date()) {
        self.uid = uid
        self.dtstamp = dtstamp
    }

}

extension Event: CalendarComponent {
    public func toCal() -> String {
        var str: String = "BEGIN:VEVENT\n"

        if let uid = uid {
            str += "UID:\(uid)\n"
        }
        if let dtstamp = dtstamp {
            str += "DTSTAMP:\(dtstamp.toString())\n"
        }
        if let summary = summary {
            str += "SUMMARY:\(summary)\n"
        }
        if let descr = descr {
            str += "DESCRIPTION:\(descr)\n"
        }
        if let dtstart = dtstart {
            str += "DTSTART:\(dtstart.toString())\n"
        }
        /*
        if let dtend = dtend {
            str += "DTEND:\(dtend.toString())\n"
        }
        */
        for (key, val) in otherAttrs {
            str += "\(key):\(val)\n"
        }

        for component in subComponents {
            str += "\(component.toCal())\n"
        }

        str += "END:VEVENT"
        return str
    }
}

extension Event: IcsElement {
    public mutating func addAttribute(attr: String, _ value: String) {
        switch attr {
        //case "UID":
            //uid = value
        case "DTSTART":
            dtstamp = value.toDate()
        case "SUMMARY":
            summary = value
        case "DESCRIPTION":
            descr = value
        case "\n":
            bla = value
        //case "DTSTART":
            //dtstart = value.toDate()
        //case "DTEND":
            //dtend = value.toDate()
        // case "ORGANIZER":
        //     organizer


        default:
            otherAttrs[attr] = value
        }
    }
}

extension Event: Equatable { }

public func ==(lhs: Event, rhs: Event) -> Bool {
    return lhs.uid == rhs.uid
}

extension Event: CustomStringConvertible {
    public var description: String {
        let date = Date()
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/dd"
        var output = ""
        //return String(describing: dtstamp.toString()) + ": " + summary! + ": "
        if (dtstamp != nil){
            let days = (86400*2)
            let interval = date.timeIntervalSince(dtstamp)
            if (interval >= Double(-days) && interval <= Double(days)){
                if (dtstamp != nil){
                    if (NSCalendar.current.isDateInToday(dtstamp)) {
                        let dateprint = dateFormatterPrint.string(from: dtstamp)
                        output += "Today (\(String(describing: dateprint))): "
                    } else {
                        let dateprint = dateFormatterPrint.string(from: dtstamp)
                        output += String(describing: dateprint) + ": "
                    }
                }
                if (summary != nil){
                    output += summary! + " "
                }
                if (descr != nil){
                    output += descr!
                }
            }
        }
        return(output)
    }
}
