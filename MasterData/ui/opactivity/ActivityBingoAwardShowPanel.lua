-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBingoAwardShowPanel.lua

local ResOpActivityBingoBigReward = require("ClientData/ResOpActivityBingoBigReward")
local strClassName = "ActivityBingoAwardShowPanel"
local ActivityBingoAwardShowPanel = Class(strClassName, UIControls.Window)

function ActivityBingoAwardShowPanel:ctor()
	self.txtNum = UIControls.Label(self, "MainInfoPanel/TextNum")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickCfm)
end

function ActivityBingoAwardShowPanel:setData(finalId, awardId, gridId)
	local awardInfo = ResOpActivityBingoBigReward[finalId][awardId]

	if not awardInfo then
		return
	end

	local item = BaseObject.GetObject(awardInfo.item_id, awardInfo.item_num)
	local awardItem = UIControls.getGridAwardContainer(self, "MainInfoPanel/FinalAwardPanel")

	awardItem.mDisableWays = true
	awardItem.isShowPreviewTips = true

	awardItem:setVisible(true)

	if gridId then
		awardItem:setContainerConfig(gridId)
	end

	awardItem:setObj(item)
	awardItem:hideTxtNum(true)
	self.txtNum:setText(awardInfo.item_num)

	self.awardItem = awardItem
	self.awardInfo = awardInfo
end

function ActivityBingoAwardShowPanel:onClickCfm()
	local mainDlg = UIManager.tryGetUI("activityBingoDlg")

	if mainDlg then
		mainDlg:toNextRound()
	end

	self.awardItem.grid:flyToCommonFuncEntryPanel()
	self:setVisible(false)
end

return ActivityBingoAwardShowPanel
