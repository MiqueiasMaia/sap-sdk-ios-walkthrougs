//
// SDK iOS I
//
// Created by SAP BTP SDK Assistant for iOS v7.0.7 application on 15/07/22
//

import Foundation
import SAPFiori
import UIKit

class DatePickerViewController: FUIFormTableViewController {
    var datePicker = UIDatePicker()
    var dateValue = ""
    var onSave: ((_ data: String) -> Void)?
    let formatter = DateFormatter()
    let supportedDateFormats = ["yyyy-MM-dd'T'HH:mm:ss", "yyyy-MM-dd'T'HH:mm:ss.SSS"]

    var selectedDateString: String {
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.string(from: datePicker.date)
    }

    func setDatePickerDate() {
        for format in supportedDateFormats {
            formatter.dateFormat = format
            if let date = formatter.date(from: dateValue) {
                datePicker.date = date
                return
            }
        }
        datePicker.date = Date()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDatePickerDate()
        datePicker.backgroundColor = .systemBackground

        view = datePicker
        title = NSLocalizedString("keySelectDateTitle", value: "Select Date/Time", comment: "XTIT: Title of select date/time screen.")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(updateDateTime))
        navigationItem.rightBarButtonItem = doneButton
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("keyCancelButtonToGoPreviousScreen", value: "Cancel", comment: "XBUT: Title of Cancel button."), style: .plain, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
    }

    @objc func cancel() {
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }

    @objc func updateDateTime() {
        onSave?(selectedDateString)
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
