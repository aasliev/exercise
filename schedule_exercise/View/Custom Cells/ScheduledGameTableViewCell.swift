//
//  ScheduledGameTableViewCell.swift
//  schedule_exercise
//
//  Created by Asliddin Asliev on 11/14/20.
//

import UIKit

class ScheduledGameTableViewCell: UITableViewCell {

    @IBOutlet weak var awayTeamName: UILabel!
    @IBOutlet weak var homeTeamName: UILabel!
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var awayScore: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var gameState: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var homeTeamImage: ImageLoaderClass!
    @IBOutlet weak var awayTeamImage: ImageLoaderClass!
    @IBOutlet weak var atSign: UILabel!
    @IBOutlet weak var BYEWeekLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        awayTeamName.font = LabelFonts.kTeamNameFont
        homeTeamName.font = LabelFonts.kTeamNameFont
        homeScore.font = LabelFonts.kScoreFont
        awayScore.font = LabelFonts.kScoreFont
        time.font = LabelFonts.k3RDLevelFont
        gameState.font = LabelFonts.k3RDLevelFont
        week.font = LabelFonts.k3RDLevelFont
        week.textColor = UIColor(rgb: 0x999999)
        atSign.textColor = UIColor(rgb: 0x999999)
        
//        cell.week.text = game?.week.uppercased()
//        cell.BYEWeekLabel.text = "BYE"
        BYEWeekLabel.textColor = UIColor(rgb: 0x999999)
        BYEWeekLabel.font = LabelFonts.kBYEFont
        
    }

    //if it's BYE week, call function to hide other labels
    func hideLabels(){
        self.atSign.isHidden = !self.BYEWeekLabel.isHidden
        self.awayTeamName.isHidden = !self.BYEWeekLabel.isHidden
        self.homeTeamName.isHidden = !self.BYEWeekLabel.isHidden
        self.awayScore.isHidden = !self.BYEWeekLabel.isHidden
        self.homeScore.isHidden = !self.BYEWeekLabel.isHidden
        self.time.isHidden = !self.BYEWeekLabel.isHidden
        self.gameState.isHidden = !self.BYEWeekLabel.isHidden
        self.homeTeamImage.isHidden = !self.BYEWeekLabel.isHidden
        self.awayTeamImage.isHidden = !self.BYEWeekLabel.isHidden
    }
    
    // setUpCell function
    func setUpCell(game: GameDetails?, teamInfo : TeamDetails){
        
        self.homeScore.text = game?.homeScore
        self.awayScore.text = game?.awayScore
        self.time.text = self.convertISO8601ToDate(timestamp: (game?.date?.timestamp) ?? "")[0]
        self.week.text = game?.week.uppercased()
        
        let  opponentTeamLink = self.getLogoLink(withTriCode: game?.opponent?.triCode)
        let currentTeamLink = self.getLogoLink(withTriCode: teamInfo.triCode)
        
        if (game?.isHome != "true"){
            // current team is playing away
            self.homeTeamName.text = game?.opponent?.name
            self.awayTeamName.text = teamInfo.name
            
            self.homeTeamImage.loadImage(fromUrl: opponentTeamLink)
            self.awayTeamImage.loadImage(fromUrl: currentTeamLink)
            
            
        } else {
            self.homeTeamName.text = teamInfo.name
            self.awayTeamName.text = game?.opponent?.name
            
            self.homeTeamImage.loadImage(fromUrl: currentTeamLink)
            self.awayTeamImage.loadImage(fromUrl: opponentTeamLink)

        }
        
        if (game?.type == "F"){
            self.gameState.text = game?.gameState?.uppercased()
        } else {
            self.gameState.text = self.convertISO8601ToDate(timestamp: game?.date?.timestamp ?? "")[1]
            
            self.homeScore.font = LabelFonts.kScoreFontScheduledGame
            self.homeScore.textColor = UIColor(rgb: 0x999999)
            
            self.awayScore.font = LabelFonts.kScoreFontScheduledGame
            self.awayScore.textColor = UIColor(rgb: 0x999999)
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
    
    // make a string url for logos
    func getLogoLink(withTriCode triCode: String?)->String{
        return "http://yc-app-resources.s3.amazonaws.com/nfl/logos/nfl_\(triCode!.lowercased())_light.png"
    }
    
    
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }
   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
