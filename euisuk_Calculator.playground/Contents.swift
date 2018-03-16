//: Playground - noun: a place where people can play
// 1582년부터 계산가능합니다.
import UIKit

//아래에 날짜에 입력
var year = 2018
var month = 3
var day = 31

//계산 할 월 입력
var calMonth = 4

var resultYear = year
var resultMonth = 0
var resultDay = 0

var N = calMonth * 30 - day

//윤년 판별 함수
func isYoon(_ year: Int) -> Bool {
    return ((year%4 == 0) && (year%100 != 0)) || (year%400 == 0)
}

//월별 마지막 일 수 차이
func getYearGap (_ year: Int) -> [Int] {
    return [1, (isYoon(year) ? -1 : -2), 1, 0, 1, 0, 1, 1, 0, 1, 0, 1]
}

//개월 수가 1년이 넘을 경우 처리
while N >= 365 {
    N -= 365 + (isYoon(resultYear) ? 1 : 0)
    resultYear -= 1
}

var cal = getYearGap(year)

//입력한 해를 "이전의 월"을 다 뺌
for (index, i) in cal[0 ... (month - 2)].map({$0 + 30}).reversed().enumerated() {
    N -= i
    
    // -N월이 해를 넘어가지 않는 경우
    if N <= 0 {
        //-N * 30일이 넘지 못할 경우
        if (day - N + 1) > 0 {
            resultMonth = month
            resultDay = day + N - 1
            print(resultYear, resultMonth, resultDay)
        // -N * 30일이 넘을 경우
        } else {
            resultMonth = month - index - 1
            resultDay = -N + 1
            print(resultYear, resultMonth, resultDay)
        }
        break
    // -N월이 해를 넘기는 경우
    } else if index == month - 2 {
        resultYear -= 1
        
        var resultGap = getYearGap(resultYear)
        
        for (inindex, a) in resultGap.reversed().map({$0 + 30}).enumerated() {
            N -= a
            if N <= 0 {
                resultMonth = 12 - inindex
                resultDay = -N + 1
                print(resultYear, resultMonth, resultDay)
                break
            }
        }
    }
}
