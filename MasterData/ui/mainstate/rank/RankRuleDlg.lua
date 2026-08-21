-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Rank\\RankRuleDlg.lua

local strClassName = "RankRuleCell"
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local ResCampScore = require("ClientData/ResCampScore")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local RankRuleCell = Class(strClassName, UIControls.Child)

function RankRuleCell:ctor()
	self:initUI()
end

function RankRuleCell:initUI()
	self.txtPoint = UIControls.Label(self, "TextPoint")
	self.txtNum = UIControls.Label(self, "TextNum")
	self.txtTotalPoint = UIControls.Label(self, "TextPointTotal")
	self.txtStar = UIControls.Label(self, "TextStar")
end

function RankRuleCell:setStarInfo(starInfo)
	self.starInfo = starInfo

	self.txtTotalPoint:setText(self.starInfo.score)
	self.txtPoint:setText(ResCampScore[self.starInfo.star].score)
	self.txtNum:setText(self.starInfo.score / ResCampScore[self.starInfo.star].score)
	self.txtStar:setText(UIConst.HERO_STAR_EMOJI_DIC[self.starInfo.star])
end

local strClassName = "RankRuleDlg"
local RankRuleDlg = Class(strClassName, UIControls.Window)

function RankRuleDlg:ctor()
	self:initUI()
end

function RankRuleDlg:initUI()
	self.txtHistoryHighestPoint = UIControls.Label(self, "Bg/PointRecordPanel/TextPoint")
	self.curTotalPoint = UIControls.Label(self, "Bg/PointNowPanel/TextPointTotal")
	self.txtRule = UIControls.Label(self, "Bg/TextRule")
	self.txtRuleTitle = UIControls.Label(self, "Bg/TextTitle")
end

function RankRuleDlg:setPointData(historyHighestPoint, starScoreInfo)
	self.historyHighestPoint = historyHighestPoint
	self.starScoreInfo = starScoreInfo

	self.txtHistoryHighestPoint:setText(self.historyHighestPoint)
	self.curTotalPoint:setText(self.starScoreInfo.totalScore)
	self.txtRule:setText(ResInfoNotice[Const.INFO_NOTICE_CAMP_SCORE_RULE].content)
	self.txtRuleTitle:setText(ResInfoNotice[Const.INFO_NOTICE_CAMP_SCORE_RULE].title)

	self.ruleCellList = {}

	for star = 1, #ResStarUpCondition do
		if self.starScoreInfo.starScoreList[star] then
			local ruleCell = RankRuleCell(self, "Bg/RuleList/Content", "System/Rank/RankingRuleCell", 0, 0, true)
			local starInfo = {}

			starInfo.star = star
			starInfo.score = self.starScoreInfo.starScoreList[star]

			ruleCell:setStarInfo(starInfo)
		end
	end
end

return RankRuleDlg
