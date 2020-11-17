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
    var currentYear = String()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x234E57)
        self.reLoadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.scheduledGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
//        sectionHeader.backgroundColor = .red
        let backGroundImage = UIImageView(image: UIImage(named: "list_header"))
        backGroundImage.frame = sectionHeader.bounds
        sectionHeader.addSubview(backGroundImage)
        let headerTitle = UILabel(frame: sectionHeader.bounds)
        headerTitle.textAlignment = .center
        headerTitle.text = " \(self.currentYear) \(self.scheduledGames[section].section ?? "")"
        headerTitle.font = LabelFonts.kHeaderFont
        headerTitle.textColor = UIColor(rgb: 0x999999)
        sectionHeader.addSubview(headerTitle)

        return sectionHeader

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.scheduledGames[section].games?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! ScheduledGameTableViewCell
        let game = scheduledGames[indexPath.section].games?[indexPath.row]
        
//        print("Week: \(game?.week) type \(game?.type)")

        if (game?.type == "B"){
            cell.BYEWeekLabel.isHidden = false
            cell.hideLabels()
            


        }
        else {
            cell.BYEWeekLabel.isHidden = true
            cell.hideLabels()
            
            cell.homeScore.text = game?.homeScore
            cell.awayScore.text = game?.awayScore
            cell.time.text = self.convertISO8601ToDate(timestamp: (game?.date?.timestamp) ?? "")[0]
            cell.week.text = game?.week.uppercased()
            
            if (game?.isHome != "true"){
                // current team is playing away
                cell.homeTeamName.text = game?.opponent?.name
                cell.awayTeamName.text = teamInfo.name
                
                //set up images---------
                
            } else {
                cell.homeTeamName.text = teamInfo.name
                cell.awayTeamName.text = game?.opponent?.name

//
//                //set up images---------

            }
            
            if (game?.type == "F"){
                cell.gameState.text = game?.gameState?.uppercased()
            } else {
                cell.gameState.text = self.convertISO8601ToDate(timestamp: game?.date?.timestamp ?? "")[1]
                
                cell.homeScore.font = LabelFonts.kScoreFontScheduledGame
                cell.homeScore.textColor = UIColor(rgb: 0x999999)
                
                cell.awayScore.font = LabelFonts.kScoreFontScheduledGame
                cell.awayScore.textColor = UIColor(rgb: 0x999999)
            }

        }
        return cell
        
    }
    
    
    // MARK: - Reload Data
    func reLoadData(){
        currentTeam.initData { (finished) in
            if (finished){
                self.scheduledGames = self.currentTeam.getGameSections()
                self.teamInfo = self.currentTeam.getTeamInfo()
                self.currentYear = self.currentTeam.getCurrentYear() ?? ""
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    
    // function to convert ISO8601 format timestamp to date
    func convertISO8601ToDate(timestamp: String) -> [String]{
        let formatterInput = ISO8601DateFormatter()
        var time = [String]()
        if let date = formatterInput.date(from: timestamp){
            let formatterOutput = DateFormatter()
            formatterOutput.dateFormat = "E, MMM d-h:mm a"
            formatterOutput.locale = Locale.current
            formatterOutput.timeZone = TimeZone.current
            time = formatterOutput.string(from: date).components(separatedBy: "-")
        }
        return time
    }

    @IBAction func reloadPressed(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
            
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image!")
                completionHandler(nil)
            } else {
                completionHandler(data)
            }
        }
            
        dataTask.resume()
    }
    

}
