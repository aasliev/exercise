//
//  ScheduledGameTableViewController.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import UIKit
let urlString : String = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json";


class ScheduledGameTableViewController: UITableViewController {

    let currentTeam = TeamScheduleData(apiURL: urlString)
    var scheduledGames  =  [GameSections]()
    var teamInfo = TeamDetails()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for family: String in UIFont.familyNames
//        {
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        
        
        currentTeam.initData { (finished) in
            if (finished){
                print(self.currentTeam.gameCount())
                self.scheduledGames = self.currentTeam.getGameSections()
                self.teamInfo = self.currentTeam.getTeamInfo()
//                self.tableView.reloadData()
            }
        }
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.scheduledGames.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.scheduledGames[section].section
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.scheduledGames[section].games?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = scheduledGames[indexPath.section].games?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! ScheduledGameTableViewCell
        if (game?.isHome != "true"){
            
            // current team is playing away
            cell.leftTeamName.text = game?.opponent?.name
            cell.rightTeamName.text = teamInfo.name
//            cell.homeTeamImage.load(triCode: game?.opponent?.triCode ?? "")
//            cell.awayTeamImage.load(triCode: teamInfo.triCode ?? "")
            
        } else {
            cell.leftTeamName.text = teamInfo.name
            cell.rightTeamName.text = game?.opponent?.name
//            cell.homeTeamImage.load(triCode: teamInfo.triCode ?? "")
//            cell.awayTeamImage.load(triCode: game?.opponent?.triCode ?? "")
        }
        cell.homeScore.text = game?.homeScore
        cell.awayScore.text = game?.awayScore
        cell.gameState.text = game?.gameState?.capitalized
        cell.time.text = game?.date?.text
        cell.week.text = game?.week
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    @IBAction func reloadPressed(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    

}

//extension UIImageView {
//    func load(triCode: String) {
//        let urlString : String = "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode)_light.png"
//        if let url = URL(string: urlString){
//            DispatchQueue.global().async { [weak self] in
//                if let data = try? Data(contentsOf: url) {
//                    if let image = UIImage(data: data) {
//                        DispatchQueue.main.async {
//                            self?.image = image
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
