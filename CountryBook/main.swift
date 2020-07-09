//
//  main.swift
//  CountryBook
//
//  Created by Kimyaehoon on 07/07/2020.
//  Copyright © 2020 Kimyaehoon. All rights reserved.
//

import Foundation

// 목표 값 추가 + 값 보기 + 값 정렬
// 값? CountryInfo -> country, capital, language

func printAndInfoString(text:String) -> String{
    print(text)
    let _info = readLine()
    guard let info = _info else {return ""}
    return info
}

func printAndInfoInt(text:String) -> Int{
    print(text)
    let _info = readLine()
    guard let info = _info, let infoInt = Int(info) else {return 0}
    return infoInt
}


struct CountryBook{ //book 하나기 때문에 싱글톤으로 전환 필요
    static var book = [CountryInfo]()
    
    private static func sortBookbyName()->[CountryInfo]{ //분할 정렬 혹은 오메가 확줄게 추가
        var tempBook = book
        for _ in 0...tempBook.count-1 {
            for n in 0...tempBook.count-2{
                if tempBook[n].name > tempBook[n+1].name {
                    let temp = tempBook[n+1]
                    tempBook[n+1] = tempBook[n]
                    tempBook[n] = temp
                }
            }
        }
        return tempBook
    }
    
    static func plusCountryInfo(){
        let name = printAndInfoString(text: "추가할 나라 이름을 알려주세요. :")
        let capital = printAndInfoString(text: "이 나라의 수도를 알려주세요. :")
        let language = printAndInfoString(text: "이 나라의 언어를 알려주세요. :")
        
        book.append(CountryInfo(name: name, capital: capital, language: language))
        print("나라 \(name) 이/가 추가되었습니다!")
    }
    
    static func showCountryBook(){
        if(book.count == 0){
            print("값이 없습니다.")
            return
        }
        
        let sortValue = printAndInfoInt(text: "볼 방법을 골라주세요. : 1. 이름순 / 2. 최신 순")
        
        switch sortValue {
        case 1:
            var tempBook:[CountryInfo] = []
            if(book.count > 1){
                tempBook = sortBookbyName()
            }
            for i in tempBook {
                print("나라: \(i.name), 수도: \(i.capital), 언어: \(i.language)")
            }
        case 2:
            for i in book {
                print("나라: \(i.name), 수도: \(i.capital), 언어: \(i.language)")
            }
        default:
            print("정확한 값이 아닙니다. 다시 시도해주세요.")
            CountryBook.showCountryBook()
            return
        }
    }
    
    static func rePlusCountryInfo(){
        let newName = printAndInfoString(text: "수정을 원하시는 나라이름을 알려주세요: ")
//        let countryArray = book.filter({$0.name == newName})
        
        for (index, b) in book.enumerated(){ //for in 인덱스 계산 디버거 사용법
            if(b.name == newName){
                let name = printAndInfoString(text: "수정할 나라 이름을 알려주세요. :")
                let capital = printAndInfoString(text: "수정할 이 나라의 수도를 알려주세요. :")
                let language = printAndInfoString(text: "수정할 이 나라의 언어를 알려주세요. :")
                
                book[index] = CountryInfo(name: name, capital: capital, language: language)
                print("수정되었습니다.")
            }
        }
        
    }
}

struct CountryInfo{
    var name: String
    var capital: String
    var language: String
    
    init(name:String, capital:String, language:String){
        self.name = name
        self.capital = capital
        self.language = language
    }
}


//실행문
func Play(){
    
let answer = printAndInfoInt(text: "원하는 기능을 선택해주세요: 1. 새로운 나라 추가 / 2.나라 목록 보기 / 3.나라 수정하기")
    
    if (1...3).contains(answer){
        switch answer {
        case 1:
            CountryBook.plusCountryInfo()
        case 2:
            CountryBook.showCountryBook()
        case 3:
            CountryBook.rePlusCountryInfo()
        default:
            return
        }
        Play()
    } else {
        print("그런 기능은 없습니다. 다시 선택해주세요.")
        Play()
        return
    }
}

Play()

