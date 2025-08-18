-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Management\\ManagementToyChooseDlg.lua

local ManagementToyCell = require("UI/OpActivity/Management/ManagementToyCell")
local managementToyChooseDlg = Class("managementToyChooseDlg", UIControls.Window)

function managementToyChooseDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm)
end

function managementToyChooseDlg:setData(actData)
	self.actData = actData

	local toyTypeList = self.actData.unlockToyTypeList
	local assignToyType = self.actData.assignToyType

	self.toyCellList = self.toyCellList or {}
	self.slotOnClickToyCell = self.slotOnClickToyCell or Slot(self.onClickToyCell, self)
	self.selectToyCell = nil

	local cellList = self.toyCellList
	local dataList = toyTypeList
	local dataNum = #dataList
	local cellNum = #cellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = cellList[i]
		else
			cell = ManagementToyCell(self, "BgPanel/ToyPanel", "System/Activity/ActivityManagement1/ToyNeedCell")

			cell:init(false, 2, self.slotOnClickToyCell)
			table.insert(cellList, cell)
		end

		cell:setVisible(true)

		local type = dataList[i]

		cell:setData(self.actData.actId, type)

		local checkSelect = self.selectToyCell == nil and type == assignToyType

		cell:setSelect(checkSelect)

		if checkSelect then
			self.selectToyCell = cell
		end
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			cellList[i]:setVisible(false)
		end
	end
end

function managementToyChooseDlg:onClickToyCell(toyCell)
	if not toyCell then
		return
	end

	if self.selectToyCell == toyCell then
		self.selectToyCell:setSelect(false)

		self.selectToyCell = nil
	else
		if self.selectToyCell then
			self.selectToyCell:setSelect(false)
		end

		self.selectToyCell = toyCell

		self.selectToyCell:setSelect(true)
	end
end

function managementToyChooseDlg:onClickBtnConfirm()
	self.actData.assignToyType = self.selectToyCell and self.selectToyCell.type or 0

	local mainDlg = UIManager.tryGetUI("managementMainDlg")

	if mainDlg then
		mainDlg:refreshProduce()
	end

	self:setVisible(false)
end

function managementToyChooseDlg:onClickBtnClose()
	self:setVisible(false)
end

return managementToyChooseDlg
