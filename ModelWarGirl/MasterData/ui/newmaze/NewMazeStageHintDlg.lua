-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeStageHintDlg.lua

local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeStageHintDlg"
local NewMazeStageHintDlg = Class(strClassName, UIControls.Window)

function NewMazeStageHintDlg:ctor(...)
	self:initUI()
end

function NewMazeStageHintDlg:initUI()
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)
end

function NewMazeStageHintDlg:setData(cycle, ratingLevel, lastPlayLevel)
	self.ratingLevel = ratingLevel
	self.lastPlayLevel = lastPlayLevel

	self.textTitle:setText(string.format(ResNewMazeDisplay[13060004].desc, cycle or 1))
end

function NewMazeStageHintDlg:_onAniFinish()
	self:setVisible(false)

	if self.lastPlayLevel and self.ratingLevel <= self.lastPlayLevel + 1 then
		-- block empty
	else
		local ratingDlg = UIManager.getUI("newMazeRatingDlg", true)

		ratingDlg:setData(nil, true)
	end
end

return NewMazeStageHintDlg
