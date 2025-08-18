-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\VerticalFilterPanel.lua

local ResColor = require("ClientData/ResColor")
local SortBtnListTypeCell = Class("VerticalFilterPanel_SortBtnListTypeCell", UIControls.Child)

function SortBtnListTypeCell:ctor()
	self.btn = UIControls.Button(self, "", "Text")

	self.btn:addEventClick(self.onClickBtn)

	self.txtName = UIControls.Label(self, "Text")
	self.imgBg = UIControls.Image(self, "Bg")
end

function SortBtnListTypeCell:init(clickCb)
	self.clickCb = clickCb
end

function SortBtnListTypeCell:setData(data)
	self.data = data

	self.txtName:setText(self.data.text)
end

function SortBtnListTypeCell:setSelect(value)
	local color = value and ResColor.ORANGEBTN or ResColor.GREYLIGHT

	self.txtName:setFontColor(color)
	self.imgBg:setVisible(value)
end

function SortBtnListTypeCell:onClickBtn()
	self.clickCb(self)
end

local VerticalFilterPanel = Class("VerticalFilterPanel", UIControls.Panel)

function VerticalFilterPanel:ctor()
	self.btnSortType = UIControls.Button(self, self.mPath .. "/BtnListType", "Text")

	self.btnSortType:addEventClick(self.onClickBtnSortType)

	self.sortTypePanel = UIControls.Panel(self, self.mPath .. "/ListTypePanel")
	self.btnRaycast = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnRaycast:addEventClick(self.onClickBtnRaycast)

	self.cellList = {}
	self.slotOnClickCell = Slot(self.onClickCell, self)
end

function VerticalFilterPanel:init(sortInfoList, selectCb)
	self.selectCb = selectCb
	self.sortInfoList = sortInfoList

	local cellNum = #self.cellList
	local dataNum = #sortInfoList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = self.cellList[i]
		else
			cell = SortBtnListTypeCell(self, self.mPath .. "/ListTypePanel", "System/Hero/BtnListTypeCell")

			cell:init(self.slotOnClickCell)
			table.insert(self.cellList, cell)
		end

		cell:setData(sortInfoList[i])
		cell:setVisible(true)

		local checkSelect = i == 1

		cell:setSelect(checkSelect)

		if checkSelect then
			self.curCell = cell

			self:onSelectCell(self.curCell)
		end
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			self.cellList[i]:setVisible(false)
		end
	end
end

function VerticalFilterPanel:onSelectCell(cell)
	self.btnSortType:setText(cell.data.text)
	self.selectCb(self.curCell.data.name)
end

function VerticalFilterPanel:onClickCell(cell)
	if not cell or self.curCell == cell then
		return
	end

	if self.curCell then
		self.curCell:setSelect(false)
	end

	self.curCell = cell

	self.curCell:setSelect(true)
	self.sortTypePanel:setVisible(false)
	self.btnRaycast:setVisible(false)
	self:onSelectCell(self.curCell)
end

function VerticalFilterPanel:onClickBtnSortType()
	self.sortTypePanel:setVisible(true)
	self.btnRaycast:setVisible(true)
end

function VerticalFilterPanel:onClickBtnRaycast()
	self.sortTypePanel:setVisible(false)
	self.btnRaycast:setVisible(false)
end

return VerticalFilterPanel
