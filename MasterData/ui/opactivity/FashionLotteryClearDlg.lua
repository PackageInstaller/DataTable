-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FashionLotteryClearDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local FashionLotteryClearGrid = Class("FashionLotteryClearGrid", UIControls.Child)

function FashionLotteryClearGrid:ctor()
	self.bgSpe = UIControls.Panel(self, "BgSpe")
	self.imgSpe = UIControls.Panel(self, "ImgSpe")
	self.textName = UIControls.Label(self, "TextName")
end

function FashionLotteryClearGrid:setItem(item, isSpe)
	self.item = item

	self.bgSpe:setVisible(isSpe)
	self.imgSpe:setVisible(isSpe)
	self.textName:setText(item.name)

	if not self.grid then
		self.grid = UIControls.getGridChild(item, self, "GridItem", true)

		self.grid:setVisible(true)

		self.grid.mDisableWays = true

		self.grid:setObj(item)
	end
end

local strClassName = "FashionLotteryClearDlg"
local FashionLotteryClearDlg = Class(strClassName, UIControls.Window)

function FashionLotteryClearDlg:ctor()
	self.gridTargets = {}
	self.disableFly = {}

	self:initUI()

	self.aniClear = UIControls.UIAni(self, "")
end

function FashionLotteryClearDlg:initUI()
	self.awardGrids = {}
end

function FashionLotteryClearDlg:onShow(roundBonus, closeCB)
	self.closeCB = closeCB

	local clientItems = ClientUtils.getAllClientItems(roundBonus[1], roundBonus[2], roundBonus[3], roundBonus[4], roundBonus[5], roundBonus[6])

	if #clientItems <= 0 then
		self:setVisible(false, nil, true)
	else
		for index, item in ipairs(clientItems) do
			local nameGridContainer = FashionLotteryClearGrid(self, "Bg/AwardPanel", "System/Common/Grid/GridSkinLotteryContainer", 0, 0, true)

			nameGridContainer:setItem(item, false)
			table.insert(self.awardGrids, nameGridContainer)
		end
	end
end

function FashionLotteryClearDlg:setSpecialCustomizeFlyConfig(id, targetUIObj)
	self.gridTargets[id] = targetUIObj
end

function FashionLotteryClearDlg:onOpenOver()
	FashionLotteryClearDlg.super.onOpenOver(self)
	self.aniClear:startAniLoop("LoopActivitySkinLotteryClearCanvas")
end

function FashionLotteryClearDlg:onClose(...)
	local startObj, itemId, itemNum, itemData

	for _, grid in ipairs(self.awardGrids) do
		itemData = grid.item

		if grid.grid and itemData and itemData.id and itemData.num then
			startObj = grid
			itemId = itemData.id
			itemNum = itemData.num

			if self.gridTargets[itemId] then
				FlyIconUtils.setFlyUItoUI(startObj, self.gridTargets[itemId], itemId, itemNum)
			else
				grid.grid:flyToCommonFuncEntryPanel()
			end
		end
	end

	if self.closeCB then
		self.closeCB()
	end

	FashionLotteryClearDlg.super.onClose(self)
end

return FashionLotteryClearDlg
