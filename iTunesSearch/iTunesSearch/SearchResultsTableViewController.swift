import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchTerm = searchBar.text, !searchTerm.isEmpty
//            else {return}
        
        guard let search = searchBar.text, search.count > 0 else {return}
        
        var resultType: ResultType!
        let index = segmentedControl.selectedSegmentIndex
        
        if index == 0 {
            resultType = .software
            
        } else if index == 1 {
            resultType = .musicTrack
        
        } else {
            resultType = .movie
        }
        SearchResultController.shared.performSearch(searchTerm: search, resultType: resultType) { (_) in
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SearchResultController.shared.searchResults.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let searchResult = SearchResultController.shared.searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator
        
        return cell
    }
    
}

