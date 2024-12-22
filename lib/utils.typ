// Helper Functions
#let monthname(n, display: "short") = {
    n = int(n)
    let month = ""

    if n == 1 { month = "January" }
    else if n == 3 { month = "March" }
    else if n == 2 { month = "February" }
    else if n == 4 { month = "April" }
    else if n == 5 { month = "May" }
    else if n == 6 { month = "June" }
    else if n == 7 { month = "July" }
    else if n == 8 { month = "August" }
    else if n == 9 { month = "September" }
    else if n == 10 { month = "October" }
    else if n == 11 { month = "November" }
    else if n == 12 { month = "December" }
    else { month = none }
    if month != none {
        if display == "short" {
            month = month.slice(0, 3)
        } else {
            month
        }
    }
    month
}

#let strpdate(isodate) = {
    if isodate == none{
        return none
    }
    let date = ""
    if lower(isodate) != "present" {
        let year = int(isodate.slice(0, 4))
        let month = int(isodate.slice(5, 7))
        let day = int(isodate.slice(8, 10))
        let monthName = monthname(month, display: "short")
        date = datetime(year: year, month: month, day: day)
        date = monthName + " " + date.display("[year repr:full]")
    } else if lower(isodate) == "present" {
        date = "Present"
    }
    return date
}

#let daterange(start, end) = {
    if start != none and end != none [
        #start #sym.dash.en #end
    ]
    if start == none and end != none [
        #end
    ]
    if start != none and end == none [
        #start
    ]
}

#let ternary(condition,if_true,if_false) = {
    if condition{
        if_true
    }else{
        if_false
    }
}


#let col2(left_body,right_body) = {
  grid(
  columns: (auto,1fr),
  align(left)[#left_body],
  align(right)[#right_body]
)
}

#let array2grid(columns,arr,remove_empty:false) = {
    let arr = if remove_empty{
        arr.filter(e => e != [] and e!= none)
    }else{
        arr
    }
    let windows = arr.chunks(2)
    for win in windows {
        col2(win.at(0),win.at(1, default: none))
    }
}