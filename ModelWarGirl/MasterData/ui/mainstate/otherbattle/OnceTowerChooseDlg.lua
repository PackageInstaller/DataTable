-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\OnceTowerChooseDlg.lua

local ResRelics = require("ClientData/ResRelics")
local ResOnceTower = require("ClientData/ResOnceTower")
local ResClientNotice = require("ClientData/ResClientNotice")
local OnceTowerChooseCell = Class("OnceTowerChooseCell", UIControls.Panel)

function OnceTowerChooseCell:ctor()
	self.btnSensor = UIControls.Button(self, self.mPath)

	self.btnSensor:addEventClick(self.onSensorClick)

	self.textDesc = UIControls.Label(self, self.mPath .. "/TextAttr")
end

function OnceTowerChooseCell:setData(index, relicId)
	self.index = index
	self.relicId = relicId

	local relicData = ResRelics[relicId]

	if relicData then
		self.textDesc:setText(relicData.dec or "")
	end
end

function OnceTowerChooseCell:onSensorClick()
	self.mParent:onChooseRelic(self.index)
end

function OnceTowerChooseCell:setSelected(selected)
	self.btnSensor:setEnable(not selected)
end

local MAX_CELLS = 3
local OnceTowerChooseDlg = Class("OnceTowerChooseDlg", UIControls.Window)

function OnceTowerChooseDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnHoldOn")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnChoose = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnChoose:addEventClick(self.onChooseClick)

	self.cells = {}

	for index = 1, MAX_CELLS do
		local newCell = OnceTowerChooseCell(self, "BgPanel/AttrPanel/BtnAttr" .. index)

		table.insert(self.cells, newCell)
	end
end

function OnceTowerChooseDlg:onBtnCloseClick()
	self:setVisible(false)
end

function OnceTowerChooseDlg:onChooseClick()
	if self.chooseIndex == nil or self.chooseIndex == 0 then
		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", ResClientNotice[170].notice)

		return
	end

	local battleDragHeroDlg = UIManager.getUI("battleDragHeroDlg", nil, false)

	if battleDragHeroDlg then
		battleDragHeroDlg:chooseOnceTowerRelic(self.chooseIndex)
	end

	self:setVisible(false)
end

function OnceTowerChooseDlg:onChooseRelic(index)
	self.chooseIndex = index

	for index, cell in ipairs(self.cells) do
		cell:setSelected(cell.index == self.chooseIndex)
	end
end

function OnceTowerChooseDlg:onShow(layer, nowSelect)
	local towerData = ResOnceTower[layer]

	if towerData and towerData.relics then
		self.chooseIndex = nowSelect

		for index, cell in ipairs(self.cells) do
			if towerData.relics[index] then
				cell:setData(index, towerData.relics[index].id)
				cell:setSelected(cell.index == self.chooseIndex)
				cell:setVisible(true)
			else
				cell:setVisible(false)
			end
		end

		if #towerData.relics == 1 and self.chooseIndex == nil then
			self:onChooseRelic(1)
		end
	end
end

return OnceTowerChooseDlg
