-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Shop\\ActivityLinkedShopPage.lua

local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local ResShopExchg = require("ClientData/ResShopExchg")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local UIControls = UIControls
local LinkedShopItemGrid = Class("LinkedShopItemGrid", UIConst.ActivityShopCellChild)

function LinkedShopItemGrid:ctor()
	self.btnSelf:setEnable(true)

	self.panelStateLock = UIControls.Panel(self, "ContentPanel/PricePanel/TextUnlock")
	self.textPriceDiscount = UIControls.Label(self, "ContentPanel/PricePanel/TextDiscount")
	self.panelStateNext = UIControls.Panel(self, "ImgDecR")
	self.imgItemBg = UIControls.Image(self, "BgItem")
	self.remainLabelColor = ResColor.BLACK
end

function LinkedShopItemGrid:showItem(actData, shopInfo, isLast)
	local shopItem = shopInfo[1]

	self:setData(shopItem)

	self.actData = actData
	self.actState = actData:getShopItemState(shopInfo[2])

	if shopItem ~= nil and not self.showDiscount then
		local data = shopItem.data
		local moneyInfo = data.use[1]
		local hasDiscount = moneyInfo.rate ~= nil

		self.showDiscount = hasDiscount and shopItem.sellStyle == nil

		self.panelMoneyDiscount:setVisible(self.showDiscount)

		local discountV = moneyInfo.rate or 10

		if Const.SHOP_DISCOUNT_MODE == 1 then
			discountV = 100 - discountV * 10
		end

		local a, b = math.modf(discountV)
		local strFormat = "%s"

		if b > 0 then
			strFormat = "%.1f"
		end

		self.txtRateDc:setText(string.format(strFormat, discountV))
	end

	if self.showDiscount and self.discountShowStr then
		self.textPriceDiscount:setVisible(true)
		self.textPriceDiscount:setText(self.discountShowStr)
	else
		self.textPriceDiscount:setVisible(false)
	end

	self.txtMoneyDc:setVisible(false)
	self.panelStateLock:setVisible(self.actState == Const.ACT_SHOP_STATE_LOCK)
	self.panelStateNext:setVisible(not isLast)

	if self.actState == Const.ACT_SHOP_STATE_NML then
		self.imgItemBg:setImage("Atlas/ActivityAtlas/AdventurerStoreAtlas/AdventurerStoreAtlas02", "BgSpecialStoreSel")
	elseif self.actState == Const.ACT_SHOP_STATE_FINISH then
		self.imgItemBg:setImage("Atlas/ActivityAtlas/AdventurerStoreAtlas/AdventurerStoreAtlas02", "BgSpecialStoreDis")
	else
		self.imgItemBg:setImage("Atlas/ActivityAtlas/AdventurerStoreAtlas/AdventurerStoreAtlas02", "BgSpecialStoreNml")
	end
end

local LinkedShopCell = Class("LinkedShopCell", UIControls.Child)

function LinkedShopCell:ctor()
	self.shopCells = {}
	self.panelContent = UIControls.Panel(self, "Viewport/Content")
	self.panelNothing = UIControls.Panel(self, "ImgNothing")
end

function LinkedShopCell:setData(nodeId)
	self.actData = self.mParent.actData
	self.shopItems = {}
	self.nodeId = nodeId

	if nodeId then
		self.panelContent:setVisible(true)
		self.panelNothing:setVisible(false)

		for index = 1, 100 do
			local shopItem = self.actData:getNodeShopItem(nodeId)

			if shopItem then
				table.insert(self.shopItems, {
					shopItem,
					nodeId
				})
			end

			nodeId = self.actData:getNextNodeId(nodeId)

			if not nodeId then
				break
			end
		end

		for index = #self.shopCells, #self.shopItems - 1 do
			local newCell = LinkedShopItemGrid(self, "Viewport/Content", "System/Common/Grid/GridAdventurerStoreItem")

			newCell.mEventClick = Slot(self.onShopItemClick, self)

			table.insert(self.shopCells, newCell)
		end

		local finishPos = 0

		for index, cell in ipairs(self.shopCells) do
			if self.shopItems[index] then
				cell:setVisible(true)
				cell:showItem(self.actData, self.shopItems[index], index == #self.shopItems)

				if cell.actState == Const.ACT_SHOP_STATE_FINISH then
					finishPos = index
				end
			else
				cell:setVisible(false)
			end
		end

		local allPos = #self.shopItems

		self.panelContent:setPosition(50 - math.max(0, math.min(finishPos - 2, allPos - 4.5)) * 350, 0)
	else
		self.panelContent:setVisible(false)
		self.panelNothing:setVisible(true)
	end
end

function LinkedShopCell:onShopItemClick(item)
	self.actData:onShopItemBuy(item, self, LinkedShopItemGrid, "System/Common/Grid/GridAdventurerStoreItem")
end

local LinkedShopPanel = Class("LinkedShopPanel", UIControls.Panel)

function LinkedShopPanel:ctor()
	self.imgLinkDecline = UIControls.Image(self, "ImgDecline")
	self.linkCells = {}
end

function LinkedShopPanel:setData(linkNodes)
	self.actData = self.mParent.actData
	self.linkNodes = linkNodes

	local linkNodesLenght = math.max(1, #linkNodes - 1)

	for index = #self.linkCells, linkNodesLenght do
		local newCell = LinkedShopCell(self, self.mPath .. "/ItemSaleList/Viewport/Content", "System/Activity/SpecialSaleListCell")

		table.insert(self.linkCells, newCell)
	end

	self.imgLinkDecline:setVisible(linkNodesLenght > 2)

	for index, cell in ipairs(self.linkCells) do
		if linkNodes[index] or index <= 2 then
			cell:setVisible(true)
			cell:setData(linkNodes[index])
		else
			cell:setVisible(false)
		end
	end
end

local LinkedShopNmlItemGrid = Class("LinkedShopNmlItemGrid", UIConst.ActivityShopCellChild)

function LinkedShopNmlItemGrid:ctor()
	self.btnSelf:setEnable(true)

	self.textPriceDiscount = UIControls.Label(self, "ContentPanel/PricePanel/TextDiscount")
	self.imgItemBg = UIControls.Image(self, "ContentPanel/BgItem")
	self.remainLabelColor = ResColor.BLACK
end

function LinkedShopNmlItemGrid:showItem(actData, shopInfo, isLast)
	self:setData(shopInfo[1])

	self.actData = actData
	self.actState = actData:getShopItemState(shopInfo[2])

	if self.actState ~= Const.ACT_SHOP_STATE_FINISH and self.showDiscount and self.discountShowStr then
		self.textPriceDiscount:setVisible(true)
		self.textPriceDiscount:setText(self.discountShowStr)
	else
		self.textPriceDiscount:setVisible(false)
	end

	self.txtMoneyDc:setVisible(false)

	if self.actState == Const.ACT_SHOP_STATE_FINISH then
		self.imgItemBg:setImage("Atlas/ActivityAtlas/AdventurerStoreAtlas/AdventurerStoreAtlas02", "BgOrdinaryStoreDis")
	else
		self.imgItemBg:setImage("Atlas/ActivityAtlas/AdventurerStoreAtlas/AdventurerStoreAtlas02", "BgOrdinaryStoreNml")
	end
end

local LinkedShopNmlCell = Class("LinkedShopNmlCell", UIControls.Child)

function LinkedShopNmlCell:ctor()
	self.shopCells = {}
end

function LinkedShopNmlCell:setData(allNodes)
	self.actData = self.mParent.actData
	self.shopItems = {}

	if next(allNodes) then
		for index, nodeId in ipairs(allNodes) do
			local shopItem = self.actData:getNodeShopItem(nodeId)

			if shopItem then
				table.insert(self.shopItems, {
					shopItem,
					nodeId
				})
			end
		end

		for index = #self.shopCells, #self.shopItems - 1 do
			local newCell = LinkedShopNmlItemGrid(self, "", "System/Common/Grid/GridAdventurerStoreCommonItem")

			newCell.mEventClick = Slot(self.onShopItemClick, self)

			table.insert(self.shopCells, newCell)
		end

		for index, cell in ipairs(self.shopCells) do
			if self.shopItems[index] then
				cell:setVisible(true)
				cell:showItem(self.actData, self.shopItems[index], index == #self.shopItems)
			else
				cell:setVisible(false)
			end
		end
	end
end

function LinkedShopNmlCell:onShopItemClick(item)
	self.actData:onShopItemBuy(item, self, LinkedShopNmlItemGrid, "System/Common/Grid/GridAdventurerStoreCommonItem")
end

local NmlShopPanel = Class("NmlShopPanel", UIControls.Panel)

function NmlShopPanel:ctor()
	self.imgNmlDecline = UIControls.Image(self, "ImgDecline")
	self.shopCells = {}
end

local NML_CELL_GRID_NUM = 4

function NmlShopPanel:setData(nmlNodes)
	self.actData = self.mParent.actData
	self.nmlNodes = nmlNodes

	local nodesNum = math.ceil(#nmlNodes / NML_CELL_GRID_NUM)

	for index = #self.shopCells, nodesNum - 1 do
		local newCell = LinkedShopNmlCell(self, self.mPath .. "/ItemCommonList/Viewport/Content", "System/Activity/CommonSaleListCell")

		table.insert(self.shopCells, newCell)
	end

	self.imgNmlDecline:setVisible(nodesNum - 1 > 2)

	for index, cell in ipairs(self.shopCells) do
		local startIndex = (index - 1) * 4 + 1

		if nmlNodes[startIndex] then
			local nodes = {}

			for index = 0, NML_CELL_GRID_NUM - 1 do
				table.insert(nodes, nmlNodes[startIndex + index])
			end

			cell:setVisible(true)
			cell:setData(nodes)
		else
			cell:setVisible(false)
		end
	end
end

local classNameStr = "ActivityLinkedShopPage"
local ActivityLinkedShopPage = Class(classNameStr, UIControls.Child)

MixinClass(ActivityLinkedShopPage, ActivityPanelMixin)

function ActivityLinkedShopPage:initUI()
	self.btnLink = UIControls.Button(self, "StoreInfoPanel/TabPanel/BtnSpecial")

	self.btnLink:addEventClick(self.onLinkShopClick)

	self.btnNml = UIControls.Button(self, "StoreInfoPanel/TabPanel/BtnCommon")

	self.btnNml:addEventClick(self.onNmlShopClick)

	self.textTime = UIControls.Label(self, "StoreInfoPanel/BgSign/BgTime/TextTime")
	self.textRule = UIControls.Label(self, "StoreInfoPanel/SpecialStorePanel/TextRule")
	self.panelLink = LinkedShopPanel(self, "StoreInfoPanel/SpecialStorePanel")
	self.panelNml = NmlShopPanel(self, "StoreInfoPanel/CommonStorePanel")
	self.actData = self.actObj.actData
	self.chgCostId = self.actData.miscData and self.actData.miscData.item_id
end

function ActivityLinkedShopPage:onLinkShopClick()
	self.btnLink:setEnable(false)
	self.btnNml:setEnable(true)
	self.panelLink:setVisible(true)
	self.panelNml:setVisible(false)
end

function ActivityLinkedShopPage:onNmlShopClick()
	self.btnLink:setEnable(true)
	self.btnNml:setEnable(false)
	self.panelLink:setVisible(false)
	self.panelNml:setVisible(true)
end

function ActivityLinkedShopPage:refreshData()
	self.linkNodes, self.singleNodes = self.actObj.actData:getLinkedNodes()

	self.panelLink:setData(self.linkNodes)
	self.panelNml:setData(self.singleNodes)
end

function ActivityLinkedShopPage:_setData()
	self:refreshData()

	if self.actObj.actData:linkedNodeAllOver() then
		self:onNmlShopClick()
	else
		self:onLinkShopClick()
	end
end

function ActivityLinkedShopPage:updateActivityData()
	self:refreshData()
end

return ActivityLinkedShopPage
