-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleAchievementDlg.lua

local AchievementCell = require("UI/Circle/AchievementCell")
local strClassName = "CircleAchievementDlg"
local CircleAchievementDlg = Class(strClassName, UIControls.Window)

function CircleAchievementDlg:ctor()
	self:initUI()
end

function CircleAchievementDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
	self.scrollAchievement = UIControls.ScrollViewLoopV(self, "BgPanel/AchievementList")

	self.scrollAchievement:addEventCellChanged(self.onAchievementChanged)
end

function CircleAchievementDlg:onAchievementChanged(sender, targetCell, newIdx)
	targetCell = targetCell or AchievementCell(sender, "System/Circle/CircleAchievementCell", newIdx)

	if not self.achievementDataList or #self.achievementDataList == 0 then
		return
	end

	if self.achievementDataList[newIdx] ~= nil then
		targetCell:setAchievementData(self.achievementDataList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function CircleAchievementDlg:setAchievementData(achievementDataList)
	self.achievementDataList = achievementDataList

	self.scrollAchievement:setTotalCount(#self.achievementDataList)
end

function CircleAchievementDlg:onBtnCloseClick()
	self:setVisible(false)
end

return CircleAchievementDlg
