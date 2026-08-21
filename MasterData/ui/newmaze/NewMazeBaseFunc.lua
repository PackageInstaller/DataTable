-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeBaseFunc.lua

local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local NewMazeBaseFunc = Class("NewMazeBaseFunc", UIControls.Window)

function NewMazeBaseFunc:ctor()
	return
end

function NewMazeBaseFunc:initUI()
	self.textName = UIControls.Label(self, "MainInfoPanel/FuncPanel/RogueInfoPanel/TextName")
	self.textTime = UIControls.Label(self, "MainInfoPanel/FuncPanel/RogueInfoPanel/TextTime")
	self.btnRank = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnRank")

	self.btnRank:addEventClick(self.onBtnRankClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.iconNew = UIControls.RedDot(self, "MainInfoPanel/FuncPanel/BtnAward/IconNew")
end

function NewMazeBaseFunc:setData()
	if self.newMazeData.miscData.relate_achieve_id then
		local relaActObj = CurAvatar:getActivityObj(self.newMazeData.miscData.relate_achieve_id)

		if relaActObj then
			self.iconNew:addHint({
				relaActObj.redDotId
			})
		end
	end

	self.ratingLevel = self.newMazeData.ratingLevel or 1

	local miscLevelData = self.newMazeData.levelMiscData[self.ratingLevel]

	self:setFuncTime()

	local levelNum = tostring(miscLevelData.level)

	if miscLevelData.level < 10 then
		levelNum = "0" .. miscLevelData.level
	end

	self.textName:setText(string.format("%s%s %s", ResNewMazeDisplay[13060007].desc, levelNum, miscLevelData.level_name))
end

function NewMazeBaseFunc:setFuncTime()
	local leftTime = self.newMazeData:getRemainOpenTime()
	local leftTime = self.actObj:getRemainOpenTime()
	local resetTime = self.newMazeData:getResetTime()
	local preStr = string.format(ResNewMazeDisplay[13060004].desc, self.newMazeData.cycle or 1)
	local str = string.format(Lang.get(70026), self.newMazeData.cycle, "%s")

	if leftTime <= resetTime then
		str = string.format(Lang.get(70027), self.newMazeData.cycle, "%s")
	end

	ClientTimerManager.AddSecondFormatTickUI(self.textTime, resetTime, nil, str, Slot(self._onTimeDownEnd, self), nil)
end

function NewMazeBaseFunc:_onTimeDownEnd()
	RPC.opActivityData("kOpActivitySyncMgrData", 0, self.actObj.opId)

	if self.ratingLevel == 1 then
		local cycle = self.newMazeData.cycle + 1
		local str = string.format(Lang.get(70026), self.newMazeData.cycle, "%s")
		local resetTime = 259200
		local leftTime = self.newMazeData:getRemainOpenTime()

		if leftTime <= resetTime then
			str = string.format(Lang.get(70027), self.newMazeData.cycle, "%s")
		end

		ClientTimerManager.AddSecondFormatTickUI(self.textTime, resetTime, nil, str, Slot(self._onTimeDownEnd, self), nil)
	end
end

function NewMazeBaseFunc:onBtnRankClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_NEW_MAZE)
end

function NewMazeBaseFunc:onBtnAwardClick()
	local awardDlg = UIManager.getUI("newMazeAwardDlg", true)

	awardDlg:setData()
end

function NewMazeBaseFunc:onBtnCloseClick()
	self:setVisible(false)
end

function NewMazeBaseFunc:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_NEW_MAZE)
end

function NewMazeBaseFunc:updateRelatedActivityData()
	local newMazeAwardDlg = UIManager.tryGetUI("newMazeAwardDlg")

	if newMazeAwardDlg and newMazeAwardDlg.updateActivityData then
		newMazeAwardDlg:updateActivityData()
	end
end

return NewMazeBaseFunc
