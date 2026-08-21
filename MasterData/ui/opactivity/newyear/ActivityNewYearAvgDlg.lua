-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearAvgDlg.lua

local ResTalkTitle = require("ClientData/ResTalkTitle")
local ActivityNewYearAvgCell = Class("ActivityNewYearAvgCell", UIControls.ScrollViewLoopCell)

function ActivityNewYearAvgCell:ctor()
	self.iconAVG = UIControls.Image(self, "IconTitle")
	self.labelName = UIControls.Label(self, "TxtName")
	self.labelDesc = UIControls.Label(self, "TxtDes")
	self.panelLock = UIControls.Panel(self, "TxtLock")
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)
end

function ActivityNewYearAvgCell:setData(avgData)
	self.avgId = avgData[1]
	self.unlocked = avgData[2]
	self.avgData = ResTalkTitle[self.avgId]

	if self.avgData.icon_path and self.avgData.icon then
		self.iconAVG:setImage(self.avgData.icon_path, self.avgData.icon)
	end

	self.labelName:setText(self.avgData.name or "")
	self.labelDesc:setText(self.avgData.desc or "")
	self.sensor:setEnable(self.unlocked)
end

function ActivityNewYearAvgCell:onSensorClick()
	local dinnerAvgDlg = UIManager.getUI("activityNewYearAvgDlg", nil, false)

	if dinnerAvgDlg then
		dinnerAvgDlg:setVisible(false)
	end

	UIManager.playAVG(self.avgId, nil, ActivityNewYearAvgCell._avgEndCallback, true)
end

function ActivityNewYearAvgCell._avgEndCallback()
	local dinnerDlg = UIManager.getUI("activityNewYearDinnerDlg", nil, false)

	if dinnerDlg then
		dinnerDlg:onAVGClick()
	end
end

local strClassName = "ActivityNewYearAvgDlg"
local ActivityNewYearAvgDlg = Class(strClassName, UIControls.Window)

function ActivityNewYearAvgDlg:ctor()
	self:initUI()
end

function ActivityNewYearAvgDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.avgCells = {}
	self.view = UIControls.ScrollViewLoopV(self, "BgPanel/AvgListPanel", 0, self.onCellChanged)
end

function ActivityNewYearAvgDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ActivityNewYearAvgCell(sender, self.cellPath .. "/EveAvgCell", newIdx, 0, 0)
	else
		if targetCell.idx then
			self.avgCells[targetCell.idx] = nil
		end

		targetCell.idx = newIdx
	end

	self.avgCells[newIdx] = targetCell

	targetCell:setData(self.avgData[newIdx])
end

function ActivityNewYearAvgDlg:onShow(actData)
	self.actData = actData
	self.avgData = {}

	for pos, posData in ipairs(actData.clientData) do
		local get_avg = posData.unlock_avg

		if get_avg and ResTalkTitle[get_avg] then
			local unlocked = not actData:isPosLocked(pos)

			table.insert(self.avgData, {
				get_avg,
				unlocked
			})
		end
	end

	for foodId, foodData in ipairs(actData.foodData) do
		local get_avg = foodData.get_avg

		if get_avg and ResTalkTitle[get_avg] then
			local unlocked = actData:getFoodFinishCount(foodId) > 0

			table.insert(self.avgData, {
				get_avg,
				unlocked
			})
		end
	end

	self.cellPath = "System/Activity/ActivityNewYearEve"

	local clientTemplate = actData.actObject.clientTemplateData

	if clientTemplate and clientTemplate.src_replace and clientTemplate.src_replace[1] then
		self.cellPath = "System/Activity/" .. clientTemplate.src_replace[1]
	end

	self.view:setTotalCount(#self.avgData, 1, false)
end

function ActivityNewYearAvgDlg:onCloseClick()
	self:setVisible(false)
end

return ActivityNewYearAvgDlg
