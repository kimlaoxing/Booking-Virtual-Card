public extension Date {
    func toString(with format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Constants.DefaultLocale
        return formatter.string(from: self)
    }
}



