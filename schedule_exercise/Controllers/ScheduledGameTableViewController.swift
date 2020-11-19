//
//  ScheduledGameTableViewController.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import UIKit

// url of JSON data for the current screen (team)
let urlString : String = "http://files.yinzcam.com.s3.amazonaws.com/iOS/interviews/ScheduleExercise/schedule.json";


class ScheduledGameTableViewController: UITableViewController {
    // create variables
    let currentTeam = TeamScheduleData(apiURL: urlString) //
    var scheduledGames  =  [GameSections]()
    var teamInfo = TeamDetails()
    var currentYear = String()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load dataObjects
        self.scheduledGames = self.currentTeam.getGameSections()
        self.teamInfo = self.currentTeam.getTeamInfo()
        self.currentYear = self.currentTeam.getCurrentYear() ?? ""
        
        // design requirements. set navigationBar color and barStyle
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x234E57)
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.scheduledGames.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    // custom header desing
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        return self.sectionHeader(with: "\(self.currentYear) \(self.scheduledGames[section].section ?? "")",width: tableView.frame.width, height: tableView.sectionHeaderHeight)
            //sectionHeader

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.scheduledGames[section].games?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath) as! ScheduledGameTableViewCell
        let game = scheduledGames[indexPath.section].games?[indexPath.row]
        
        // if type is Bye
        if (game?.type == "B"){
            //hide all labels except BYE and week
            cell.BYEWeekLabel.isHidden = false
            cell.hideLabels()
        }
        else { //type is not Bye
            
            cell.BYEWeekLabel.isHidden = true
            cell.hideLabels()
            
            cell.setUpCell(game: game, teamInfo: teamInfo)
        }
        return cell
        
    }
    
    //section header view
    func sectionHeader(with title:String,width: CGFloat, height: CGFloat) -> UIView{
        let sectionHeader = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height)) // create a UIView
        let backGroundImage = UIImageView(image: UIImage(named: "list_header")) // create UIImageView
        backGroundImage.frame = sectionHeader.bounds //set the frame size to UIView
        sectionHeader.addSubview(backGroundImage) // add UIImageView to sectionHeaderView
        let headerTitle = UILabel(frame: sectionHeader.bounds) //create label and set the design
        headerTitle.textAlignment = .center
        headerTitle.text = title
            //" \(self.currentYear) \(self.scheduledGames[section].section ?? "")"
        headerTitle.font = LabelFonts.kHeaderFont
        headerTitle.textColor = UIColor(rgb: 0x999999)
        sectionHeader.addSubview(headerTitle) // add label to sectionHeader view
        
        return sectionHeader
    }
    
  
}
