-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\GiftChooseBox.lua

local ResRechargeSelLib = require("ClientData/ResRechargeSelLib")
local ResRandClient = require("ClientData/ResRandClient")
local GiftChooseResultCell = Class("GiftChooseResultCell", UIControls.Child)

function GiftChooseResultCell:ctor()
	self.btnAdd = UIControls.Button(self, "")

	self.btnAdd:addEventClick(self.onAddClick)

	self.gridBonus = {}
	self.panelItem = UIControls.Panel(self, "GridItem")
	self.panelSelect = UIControls.Panel(self, "ImgSelect")
end

function GiftChooseResultCell:setData(index, chooseAward)
	self.index = index
	self.chooseAward = chooseAward

	if self.chooseAward then
		self.panelItem:setVisible(true)
		ClientUtils.CreateBonusGrid(self, self.gridBonus, "GridItem", self.chooseAward, true)

		for index, grid in ipairs(self.gridBonus) do
			grid:setTipsEnable(false, Slot(self.onAddClick, self))
		end
	else
		self.panelItem:setVisible(false)
	end
end

function GiftChooseResultCell:setSelect(isSelect)
	self.panelSelect:setVisible(isSelect)
end

function GiftChooseResultCell:onAddClick()
	if self.mParent.curIndex == self.index then
		if self.chooseAward and self.gridBonus[1] then
			self.gridBonus[1]:showTips()
		end
	else
		self.mParent:onSelIndex(self)
	end
end

local strClassName = "GiftChooseBox"
local GiftChooseBox = Class(strClassName, UIControls.Window)

function GiftChooseBox:ctor()
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBoxClose)

	self.btnBuy = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnBuy:addEventClick(self.onConfirmClick)

	self.gridAllAwards = {}
	self.gridResultAwards = {}
end

function GiftChooseBox:onShow(selLib, orderUI, chooseCb, chooseResult, fromIndex)
	self.selLib = selLib
	self.chooseCb = chooseCb
	self.chooseResult = {}

	for pos, sel in pairs(chooseResult) do
		self.chooseResult[pos] = sel
	end

	if orderUI and orderUI.mWindow then
		self:bindWindow(orderUI.mWindow)
	end

	for index = #self.gridResultAwards, #self.selLib - 1 do
		local newRCell = GiftChooseResultCell(self, "MainInfoPanel/GiftChooseList", "System/Common/Grid/GridGiftChoose")

		table.insert(self.gridResultAwards, newRCell)
	end

	self:_updateResult()
	self:onSelIndex(self.gridResultAwards[fromIndex] or self.gridResultAwards[1])
end

function GiftChooseBox:_updateResult()
	for index, cell in ipairs(self.gridResultAwards) do
		local libData = ResRechargeSelLib[self.selLib[index]]

		if libData then
			cell:setVisible(true)

			local resIndex = self.chooseResult[index]

			if resIndex and libData[resIndex] then
				cell:setData(index, libData[resIndex].rand_id)
			else
				cell:setData(index)
			end
		else
			cell:setVisible(false)
		end
	end
end

function GiftChooseBox:onSelIndex(cell)
	if cell.index then
		self.curIndex = cell.index

		self:_updateBonus()

		for index, cell in ipairs(self.gridResultAwards) do
			cell:setSelect(index == self.curIndex)
		end
	end
end

function GiftChooseBox:_updateBonus()
	local libData = ResRechargeSelLib[self.selLib[self.curIndex]] or {}
	local allItems = {}

	for index, oneData in ipairs(libData) do
		if oneData.rand_id then
			local bonus = ResRandClient[oneData.rand_id] or {}
			local showIds = bonus.show_ids or {}
			local showNums = bonus.show_nums or {}
			local show_flag = bonus.show_flag or {}

			if showIds[1] then
				local clientItem = BaseObject.GetObject(showIds[1], showNums[1] or 1)

				clientItem.randId = oneData.rand_id

				table.insert(allItems, clientItem)
			end
		end
	end

	ClientUtils.CreateBonusGridByItems(self, self.gridAllAwards, "MainInfoPanel/AwardChooseList/Content", allItems)

	for index, grid in ipairs(self.gridAllAwards) do
		grid:setToHoldMode(Functor(self.onBonusClick, self, index))
		grid:setGet(index == self.chooseResult[self.curIndex])

		if grid.object and grid.object.randId then
			grid:setVisible(ClientUtils.IsRandomValid(grid.object.randId))
		end
	end
end

function GiftChooseBox:onBonusClick(index)
	if self.chooseResult[self.curIndex] == index then
		self.chooseResult[self.curIndex] = nil
	else
		self.chooseResult[self.curIndex] = index
	end

	self:_updateResult()
	self:_updateBonus()
end

function GiftChooseBox:onBoxClose()
	self:setVisible(false)
end

function GiftChooseBox:onConfirmClick()
	if self.chooseCb then
		self.chooseCb(self.chooseResult)
	end

	self:setVisible(false)
end

return GiftChooseBox
