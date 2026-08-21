-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeSolderReplaceDlg.lua

local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeFettersType = require("ClientData/ResNewMazeFettersType")
local strClassName = "NewMazeSolderReplaceDlg"
local NewMazeSolderReplaceDlg = Class(strClassName, UIControls.Window)

function NewMazeSolderReplaceDlg:ctor()
	self:initUI()
end

function NewMazeSolderReplaceDlg:initUI()
	self.aniOld = UIControls.UIAni(self, "OldPanel")
	self.imgOldSolder = UIControls.Image(self, "OldPanel/IconSolder")
	self.textOldSolder = UIControls.Label(self, "OldPanel/IconSolder/Text")
	self.imgNewSolder = UIControls.Image(self, "NewPanel/IconSolder")
	self.textNewSolder = UIControls.Label(self, "NewPanel/IconSolder/Text")
end

function NewMazeSolderReplaceDlg:onShow(heroId, oldId, newId)
	if oldId and oldId > 0 then
		local oldSolderData = ResNewMazeFettersType[oldId] or {}

		oldSolderData = oldSolderData[1]

		self.imgOldSolder:setImage(oldSolderData.icon_path, oldSolderData.icon_name)
		self.textOldSolder:setText(oldSolderData.name)

		local mazeData = ResNewMazeHero[heroId] or {}

		if mazeData.team_label == oldId or mazeData.feature_label1 == oldId or mazeData.feature_label2 == oldId then
			self.aniOld:startAni("GridSolder01")
		else
			self.aniOld:startAni("GridSolder02")
		end
	end

	local newSolderData = ResNewMazeFettersType[newId]

	if newSolderData then
		newSolderData = newSolderData[1]

		self.imgNewSolder:setImage(newSolderData.icon_path, newSolderData.icon_name)
		self.textNewSolder:setText(newSolderData.name)
	end

	if oldId and oldId > 0 then
		self:playAni("ShowReplace", Slot(self.onAniOver, self), true)
	else
		self:playAni("ShowInstal", Slot(self.onAniOver, self), true)
	end
end

function NewMazeSolderReplaceDlg:onAniOver()
	self:setVisible(false)
end

return NewMazeSolderReplaceDlg
