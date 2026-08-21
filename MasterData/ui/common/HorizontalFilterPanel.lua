-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\HorizontalFilterPanel.lua

local FilterCell = Class("HorizontalFilterPanel_SignetFilterCell", UIControls.Child)

function FilterCell:ctor()
	self.btn = UIControls.Button(self, "BtnNml")

	self.btn:addEventClick(self.onClickBtn)

	self.txtName = UIControls.Label(self, "BtnNml/Text")
	self.iconNew = UIControls.Image(self, "BtnNml/IconNew")
end

function FilterCell:init(clickCb)
	self.clickCb = clickCb
end

function FilterCell:setData(data)
	self.data = data

	self.txtName:setText(data.text)
end

function FilterCell:setSelect(value)
	self.btn:setEnable(not value)
end

function FilterCell:setRedDot(value)
	self.iconNew:setVisible(value)
end

function FilterCell:onClickBtn()
	self.clickCb(self)
end

local HorizontalFilterPanel = Class("HorizontalFilterPanel", UIControls.Panel)

function HorizontalFilterPanel:ctor()
	self.cellList = {}
	self.slotOnClickCell = Slot(self.onClickCell, self)
end

function HorizontalFilterPanel:init(sortInfoList, selectCb, cellPath)
	self.selectCb = selectCb
	self.cellPath = cellPath or "System/HandBook/TabAchievementList"

	local cellNum = #self.cellList
	local dataNum = #sortInfoList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = self.cellList[i]
		else
			cell = FilterCell(self, self.mPath, self.cellPath)

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

function HorizontalFilterPanel:setRedDot(name, value)
	for _, cell in ipairs(self.cellList) do
		if cell.data and cell.data.name == name then
			cell:setRedDot(value)

			break
		end
	end
end

function HorizontalFilterPanel:onSelectCell(cell)
	self.selectCb(self.curCell.data.name)
end

function HorizontalFilterPanel:onClickCell(cell)
	if not cell or self.curCell == cell then
		return
	end

	if self.curCell then
		self.curCell:setSelect(false)
	end

	self.curCell = cell

	self.curCell:setSelect(true)
	self:onSelectCell(self.curCell)
end

return HorizontalFilterPanel
