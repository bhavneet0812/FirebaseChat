
import UIKit

class DatePickerTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupDatePicker()
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 10, height: bounds.height)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width - 10, height: bounds.height)
    }
    
    private func setupDatePicker(){
        let dummyButton = UIButton()
        dummyButton.isEnabled = false
        self.setButtonToRightView(btn: dummyButton, selectedImage: nil, normalImage: nil, size: nil)
        self.rightView?.frame.size.width += 15
        self.textAlignment = .left
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        self.delegate = self
        
    }
}

// MARK:- Delegate
//=================
extension DatePickerTextField : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.yyyy_MM_dd.rawValue
        
        var currDate = Date()
        if textField.text != nil && !textField.text!.isEmpty {
            if let curDate = formatter.date(from: textField.text!){
                currDate = curDate
            }
        }
        
        DatePicker.openPicker(in: self, currentDate: currDate, minimumDate: date, maximumDate: nil, pickerMode: UIDatePickerMode.date) { (selectedDate) in
            
            let result = formatter.string(from: selectedDate)
            self.text = result
        }
    }
}

// MARK:- DatePicker
//==================
class DatePicker : UIDatePicker {
    
    internal typealias PickerDone = (_ date : Date) -> Void
    private var doneBlock : PickerDone!
    
    class func openPicker(in textField: UITextField, currentDate: Date?, minimumDate: Date?, maximumDate: Date?, pickerMode: UIDatePickerMode, doneBlock: @escaping PickerDone) {
        
        let picker = DatePicker()
        picker.doneBlock = doneBlock
        picker.openPickerInTextField(textField: textField, currentDate: currentDate, minimumDate: minimumDate, maximumDate: maximumDate, pickerMode: pickerMode)
        
    }
    
    private func openPickerInTextField(textField: UITextField, currentDate: Date?, minimumDate: Date?, maximumDate: Date?, pickerMode: UIDatePickerMode) {
        
        self.datePickerMode = pickerMode
        
        self.maximumDate = maximumDate //?? NSDate() //NSDate(timeIntervalSinceNow: -1.577e+8)
        self.date = currentDate ?? Date()
        self.minimumDate = minimumDate //?? NSDate() //NSDate(timeIntervalSince1970: -1000000000)
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(DatePicker.pickerDoneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action:nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(DatePicker.pickerCancelButtonTapped))
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let array = [cancelButton,spaceButton, doneButton]
        toolbar.setItems(array, animated: true)
        toolbar.backgroundColor = UIColor.lightText
        
        textField.inputView = self
        textField.inputAccessoryView = toolbar
        
    }
    
    @IBAction private func pickerDoneButtonTapped(){
        
        UIApplication.shared.keyWindow?.endEditing(true)
        self.doneBlock(self.date)
    }
    
    @IBAction private func pickerCancelButtonTapped(){
        
        UIApplication.shared.keyWindow?.endEditing(true)
        self.setDate(Calendar.current.date(byAdding: .year, value: 0, to: Date(), wrappingComponents: false)!, animated: false)
    }
}

