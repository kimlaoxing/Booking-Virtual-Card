import UIKit

public extension UIDatePicker {

    func setDate(_ date:Date, unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int, animated:Bool) {
        setDate(date, animated: animated)
        setMinMax(unit: unit, deltaMinimum: deltaMinimum, deltaMaximum: deltaMaximum)
    }

    func setMinMax(unit:NSCalendar.Unit, deltaMinimum:Int, deltaMaximum:Int) {
        if let gregorian = NSCalendar(calendarIdentifier:.gregorian) {
            if let minDate = gregorian.date(byAdding: unit, value: deltaMinimum, to: self.date) {
                minimumDate = minDate }

            if let maxDate = gregorian.date(byAdding: unit, value: deltaMaximum, to: self.date) {
                maximumDate = maxDate
            }
        }
    }
}
