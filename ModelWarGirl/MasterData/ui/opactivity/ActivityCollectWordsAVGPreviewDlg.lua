-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsAVGPreviewDlg.lua

local ResTalkTitle = require("ClientData/ResTalkTitle")
local ResActivityPlayNodeConfig = require("ClientData/ResActivityPlayNodeConfig")
local ActivityCollectWordsAvgCell = Class("ActivityCollectWordsAvgCell", UIControls.ScrollViewLoopCell)

function ActivityCollectWordsAvgCell:ctor()
	self.iconAVG = UIControls.Image(self, "BgPanel/LockPanel/IconAvg")
	self.iconAVGUnLock = UIControls.Image(self, "BgPanel/UnLockPanel/IconAvg")
	self.lockDesc = UIControls.Label(self, "BgPanel/LockPanel/TextName")
	self.avgName = UIControls.Label(self, "BgPanel/UnLockPanel/TxtName")
	self.panelLock = UIControls.Panel(self, "BgPanel/LockPanel")
	self.panelUnLock = UIControls.Panel(self, "BgPanel/UnLockPanel")
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)
end

function ActivityCollectWordsAvgCell:setData(avgInfo)
	self.avgId = ResActivityPlayNodeConfig[avgInfo.id].avg_id
	self.islock = avgInfo.lock
	self.avgData = ResTalkTitle[self.avgId]

	if self.avgData then
		if self.avgData.icon_path and self.avgData.icon then
			self.iconAVG:setImage(self.avgData.icon_path, self.avgData.icon)
			self.iconAVGUnLock:setImage(self.avgData.icon_path, self.avgData.icon)
		end

		self.avgName:setText(self.avgData.name or "")
	end

	self.panelLock:setVisible(self.islock)
	self.panelUnLock:setVisible(not self.islock)
	self.lockDesc:setText(avgInfo.lock_desc or "")
	self.sensor:setEnable(not self.islock)
end

function ActivityCollectWordsAvgCell:onSensorClick()
	UIManager.playAVG(self.avgId, nil, ActivityCollectWordsAvgCell._avgEndCallback, true)
end

function ActivityCollectWordsAvgCell._avgEndCallback()
	return
end

local strClassName = "ActivityCollectWordsAVGPreviewDlg"
local ActivityCollectWordsAVGPreviewDlg = Class(strClassName, UIControls.Window)

function ActivityCollectWordsAVGPreviewDlg:ctor()
	self:initUI()
end

function ActivityCollectWordsAVGPreviewDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.avgCells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "BgPanel/AvgListPanel")

	self.scroll:addEventCellChanged(self.onCellChanged)
end

function ActivityCollectWordsAVGPreviewDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityCollectWordsAvgCell(sender, self.cellAtlas, newIdx, 0, 0)
	else
		if targetCell.idx then
			self.avgCells[targetCell.idx] = nil
		end

		targetCell.idx = newIdx
	end

	self.avgCells[newIdx] = targetCell

	targetCell:setData(self.avgInfo[newIdx])
end

function ActivityCollectWordsAVGPreviewDlg:setData(avgInfo, mergeTimes, actObj)
	local replaceableCellPath = actObj.clientTemplateData.src_replace

	if replaceableCellPath and replaceableCellPath[1] then
		self.cellAtlas = "System/Activity/" .. replaceableCellPath[1] .. "/CollectWordsAVGCell"
	else
		self.cellAtlas = "System/Activity/CollectWords/CollectWordsAVGCell"
	end

	self.avgInfo = {}
	self.mergeTimes = mergeTimes

	for i, avg in ipairs(avgInfo or {}) do
		if avg.param <= self.mergeTimes then
			avg.lock = false
		else
			avg.lock = true
		end

		table.insert(self.avgInfo, i, avg)
	end

	self.scroll:setTotalCount(#self.avgInfo, 1, false)
end

function ActivityCollectWordsAVGPreviewDlg:onCloseClick()
	self:setVisible(false)
end

return ActivityCollectWordsAVGPreviewDlg
