import UIKit

class ViewController: UIViewController {
    var rows = {
        return [Int](1...50)
    }()

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let shuffleRightButton = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(shuffle))
        self.navigationItem.setRightBarButton(shuffleRightButton, animated: false)
        tableView.register(CellWithIndex.self, forCellReuseIdentifier: "mycell")
        tableView.dataSource = self
        tableView.reloadData()
        view.addSubview(tableView)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
    }

    private func updateLayout(with size: CGSize) {
        self.tableView.frame = CGRect.init(origin: .zero, size: size)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayout(with: view.frame.size)
    }

    @objc
    func shuffle() {
        var copyRow = rows
        copyRow.shuffle()

        tableView.beginUpdates()
        for (index, row) in rows.enumerated() {
            let oldIndexPath = IndexPath(row: index, section: 0)
            let newIndex = copyRow.firstIndex {$0 == row}
            let newIndexPath = IndexPath(row: newIndex!, section: 0)
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
        }
        tableView.endUpdates()

        rows = copyRow
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! CellWithIndex
        cell.label.text = String(self.rows[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        let value = rows[indexPath.row]
        rows.remove(at: indexPath.row)
        rows.insert(value, at: 0)
        tableView.beginUpdates()
        tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
        tableView.endUpdates()
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

class CellWithIndex : UITableViewCell {
    let label = UILabel()
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(label)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(label)
        selectionStyle = .none
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 20, y: 10, width: 40, height: 40)
    }
}
