//
//  Country.swift
//  Newsy
//
//  Created by Salma Atef on 10/12/2021.
//

import Foundation

enum Country: String, CaseIterable {
    
    case ar
    case au
    case at
    case be
    case br
    case bg
    case ca
    case cn
    case co
    case cu
    case cz
    case eg
    case fr
    case de
    case gr
    case hk
    case hu
    case `in`
    case id
    case ie
    case it
    case jp
    case lv
    case lt
    case my
    case mx
    case ma
    case nl
    case nz
    case ng
    case no
    case ph
    case pl
    case pt
    case ro
    case ru
    case sa
    case rs
    case sg
    case sk
    case si
    case za
    case kr
    case se
    case ch
    case tw
    case th
    case tr
    case ae
    case ua
    case gb
    case us
    case ve
    
    init(countryName: String) {
        switch countryName {
        case "Argentina":
            self = .ar
        case "Australia":
            self = .au
        case "Austria":
            self = .at
        case "Belgium":
            self = .be
        case "Brazil":
            self = .br
        case "Bulgaria":
            self = .bg
        case "Canada":
            self = .ca
        case "China":
            self = .cn
        case "Colombia":
            self = .co
        case "Cuba":
            self = .cu
        case "Czech Republic":
            self = .cz
        case "Egypt":
            self = .eg
        case "France":
            self = .fr
        case "Germany":
            self = .de
        case "Greece":
            self = .gr
        case "Hong Kong":
            self = .hk
        case "Hungary":
            self = .hu
        case "India":
            self = .`in`
        case "Indonesia":
            self = .id
        case "Ireland":
            self = .ie
        case "Italy":
            self = .it
        case "Japan":
            self = .jp
        case "Latvia":
            self = .lv
        case "Lithuania":
            self = .lt
        case "Malaysia":
            self = .my
        case "Mexico":
            self = .mx
        case "Morocco":
            self = .ma
        case "Netherlands":
            self = .nl
        case "New Zealand":
            self = .nz
        case "Nigeria":
            self = .ng
        case "Norway":
            self = .no
        case "Philippines":
            self = .ph
        case "Poland":
            self = .pl
        case "Portugal":
            self = .pt
        case "Romania":
            self = .ro
        case "Russia":
            self = .ru
        case "Saudi Arabia":
            self = .sa
        case "Serbia":
            self = .rs
        case "Singapore":
            self = .sg
        case "Slovakia":
            self = .sk
        case "Slovenia":
            self = .si
        case "South Africa":
            self = .za
        case "South Korea":
            self = .kr
        case "Sweden":
            self = .se
        case "Switzerland":
            self = .ch
        case "Taiwan":
            self = .tw
        case "Thailand":
            self = .th
        case "Turkey":
            self = .tr
        case "UAE":
            self = .ae
        case "Ukraine":
            self = .ua
        case "United Kingdom":
            self = .gb
        case "United States":
            self = .us
        case "Venuzuela":
            self = .ve
        default:
            self = .us
        }
    }
    
    var description: String {
        
        switch self {
        case .ar:
            return "Argentina"
        case .au:
            return "Australia"
        case .at:
            return "Austria"
        case .be:
            return "Belgium"
        case .br:
            return "Brazil"
        case .bg:
            return "Bulgaria"
        case .ca:
            return "Canada"
        case .cn:
            return "China"
        case .co:
            return "Colombia"
        case .cu:
            return "Cuba"
        case .cz:
            return "Czech Republic"
        case .eg:
            return "Egypt"
        case .fr:
            return "France"
        case .de:
            return "Germany"
        case .gr:
            return "Greece"
        case .hk:
            return "Hong Kong"
        case .hu:
            return "Hungary"
        case .`in`:
            return "India"
        case .id:
            return "Indonesia"
        case .ie:
            return "Ireland"
        case .it:
            return "Italy"
        case .jp:
            return "Japan"
        case .lv:
            return "Latvia"
        case .lt:
            return "Lithuania"
        case .my:
            return "Malaysia"
        case .mx:
            return "Mexico"
        case .ma:
            return "Morocco"
        case .nl:
            return "Netherlands"
        case .nz:
            return "New Zealand"
        case .ng:
            return "Nigeria"
        case .no:
            return "Norway"
        case .ph:
            return "Philippines"
        case .pl:
            return "Poland"
        case .pt:
            return "Portugal"
        case .ro:
            return "Romania"
        case .ru:
            return "Russia"
        case .sa:
            return "Saudi Arabia"
        case .rs:
            return "Serbia"
        case .sg:
            return "Singapore"
        case .sk:
            return "Slovakia"
        case .si:
            return "Slovenia"
        case .za:
            return "South Africa"
        case .kr:
            return "South Korea"
        case .se:
            return "Sweden"
        case .ch:
            return "Switzerland"
        case .tw:
            return "Taiwan"
        case .th:
            return "Thailand"
        case .tr:
            return "Turkey"
        case .ae:
            return "UAE"
        case .ua:
            return "Ukraine"
        case .gb:
            return "United Kingdom"
        case .us:
            return "United States"
        case .ve:
            return "Venuzuela"
        }
    }
    
    var flag: String {
        
        switch self {
        case .ar:
            return "🇦🇷"
        case .au:
            return "🇦🇺"
        case .at:
            return "🇦🇹"
        case .be:
            return "🇧🇪"
        case .br:
            return "🇧🇷"
        case .bg:
            return "🇧🇬"
        case .ca:
            return "🇨🇦"
        case .cn:
            return "🇨🇳"
        case .co:
            return "🇨🇴"
        case .cu:
            return "🇨🇺"
        case .cz:
            return "🇨🇿"
        case .eg:
            return "🇪🇬"
        case .fr:
            return "🇫🇷"
        case .de:
            return "🇩🇪"
        case .gr:
            return "🇬🇷"
        case .hk:
            return "🇭🇰"
        case .hu:
            return "🇭🇺"
        case .`in`:
            return "🇮🇳"
        case .id:
            return "🇮🇩"
        case .ie:
            return "🇮🇪"
        case .it:
            return "🇮🇹"
        case .jp:
            return "🇯🇵"
        case .lv:
            return "🇱🇻"
        case .lt:
            return "🇱🇹"
        case .my:
            return "🇲🇾"
        case .mx:
            return "🇲🇽"
        case .ma:
            return "🇲🇦"
        case .nl:
            return "🇳🇱"
        case .nz:
            return "🇳🇿"
        case .ng:
            return "🇳🇬"
        case .no:
            return "🇳🇴"
        case .ph:
            return "🇵🇭"
        case .pl:
            return "🇵🇱"
        case .pt:
            return "🇵🇹"
        case .ro:
            return "🇷🇴"
        case .ru:
            return "🇷🇺"
        case .sa:
            return "🇸🇦"
        case .rs:
            return "🇷🇸"
        case .sg:
            return "🇸🇬"
        case .sk:
            return "🇸🇰"
        case .si:
            return "🇸🇮"
        case .za:
            return "🇿🇦"
        case .kr:
            return "🇰🇷"
        case .se:
            return "🇸🇪"
        case .ch:
            return "🇨🇭"
        case .tw:
            return "🇹🇼"
        case .th:
            return "🇹🇭"
        case .tr:
            return "🇹🇷"
        case .ae:
            return "🇦🇪"
        case .ua:
            return "🇺🇦"
        case .gb:
            return "🇬🇧"
        case .us:
            return "🇺🇸"
        case .ve:
            return "🇻🇨"
        }
    }
}
