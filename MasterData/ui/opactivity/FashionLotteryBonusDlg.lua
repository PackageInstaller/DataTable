-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FashionLotteryBonusDlg.lua

local FlyIconUtils = require("UI/Common/FlyIconUtils")
local FashionLotteryBonusGrid = Class("FashionLotteryBonusGrid", UIControls.Child)

function FashionLotteryBonusGrid:ctor()
	self.bgSpe = UIControls.Panel(self, "BgSpe")
	self.imgSpe = UIControls.Panel(self, "ImgSpe")
	self.textName = UIControls.Label(self, "TextName")
end

function FashionLotteryBonusGrid:setItem(item, isSpe)
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

local strClassName = "FashionLotteryBonusDlg"
local FashionLotteryBonusDlg = Class(strClassName, UIControls.Window)

function FashionLotteryBonusDlg:ctor()
	self.gridTargets = {}
	self.disableFly = {}

	self:initUI()
end

function FashionLotteryBonusDlg:initUI()
	self.awardGrids = {}
end

function FashionLotteryBonusDlg:onShow(commonBonus, speBonus, closeCB, gridReplacePath)
	self.closeCB = closeCB
	gridReplacePath = gridReplacePath or "GridSkinLotteryContainer"

	local girdPath = "System/Common/Grid/" .. gridReplacePath
	local clientItems = ClientUtils.getAllClientItems(commonBonus[1], commonBonus[2], commonBonus[3], commonBonus[4], commonBonus[5], commonBonus[6])
	local speItems = ClientUtils.getAllClientItems(speBonus[1], speBonus[2], speBonus[3], speBonus[4], speBonus[5], speBonus[6])

	if #clientItems <= 0 and #speItems <= 0 then
		self:setVisible(false, nil, true)
	else
		for index, item in ipairs(clientItems) do
			local nameGridContainer = FashionLotteryBonusGrid(self, "Bg/AwardList/Content", girdPath, 0, 0, true)

			nameGridContainer:setItem(item, false)
			table.insert(self.awardGrids, nameGridContainer)
		end

		for index, item in ipairs(speItems) do
			local nameGridContainer = FashionLotteryBonusGrid(self, "Bg/AwardList/Content", girdPath, 0, 0, true)

			nameGridContainer:setItem(item, true)
			table.insert(self.awardGrids, nameGridContainer)
		end
	end
end

function FashionLotteryBonusDlg:setSpecialCustomizeFlyConfig(id, targetUIObj)
	self.gridTargets[id] = targetUIObj
end

function FashionLotteryBonusDlg:onClose(...)
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

	FashionLotteryBonusDlg.super.onClose(self)

	if self.closeCB then
		self.closeCB()
	end
end

return FashionLotteryBonusDlg
