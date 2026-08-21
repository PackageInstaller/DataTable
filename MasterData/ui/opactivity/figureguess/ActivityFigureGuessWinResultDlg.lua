-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FigureGuess\\ActivityFigureGuessWinResultDlg.lua

local ActivityFigureGuessTools = require("UI/OpActivity/FigureGuess/ActivityFigureGuessTools")
local ResOpActivityGuessAward = require("ClientData/ResOpActivityGuessAward")
local ActivityFigureGuessWinResultDlg = Class("ActivityFigureGuessWinResultDlg", UIControls.Window)

function ActivityFigureGuessWinResultDlg:ctor()
	self.careerPanel = UIControls.Panel(self, "BgPanel/ChooseCareerPanel")
	self.imgCareer = UIControls.Image(self, "BgPanel/ChooseCareerPanel/ImgCareer")
	self.groupPanel = UIControls.Panel(self, "BgPanel/ChooseGroupPanel")
	self.imgGroup = UIControls.Image(self, "BgPanel/ChooseGroupPanel/ImgGroup")
	self.teamPanel = UIControls.Panel(self, "BgPanel/ChooseTeamPanel")
	self.imgTeam = UIControls.Image(self, "BgPanel/ChooseTeamPanel/ImgTeam")
	self.awardItem = UIControls.ItemGridChild(self, "BgPanel/AwardPanel", "System/Common/Grid/GridMaterialItem")
	self.btnResult = UIControls.Button(self, "BgPanel/BtnResult")

	self.btnResult:addEventClick(self.onClickBtnClose)
end

function ActivityFigureGuessWinResultDlg:setData(actObj, answerType, rightId, awardId, closeAction)
	self.closeAction = closeAction

	self.groupPanel:setVisible(answerType == 1)
	self.careerPanel:setVisible(answerType == 2)
	self.teamPanel:setVisible(answerType == 3)

	if answerType == 1 then
		ActivityFigureGuessTools.refreshGroupShow(rightId, self.imgGroup)
	elseif answerType == 2 then
		ActivityFigureGuessTools.refreshCareerShow(rightId, self.imgCareer, self.txtCareer)
	elseif answerType == 3 then
		ActivityFigureGuessTools.refreshTeamShow(rightId, self.imgTeam)
	end

	local config = ResOpActivityGuessAward[1][awardId]
	local item = BaseObject.GetObject(actObj.actData.awardId, config.win_award)

	self.awardItem:setObj(item)
	self.awardItem:setVisible(true)
end

function ActivityFigureGuessWinResultDlg:onClose()
	self.closeAction(self.awardItem)
	ActivityFigureGuessWinResultDlg.super.onClose(self)
end

function ActivityFigureGuessWinResultDlg:onClickBtnClose()
	self:setVisible(false)
end

return ActivityFigureGuessWinResultDlg
