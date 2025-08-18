-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeGridCard.lua

local NewMazeShopHeroCard = require("UI/NewMaze/NewMazeShopHeroCard")
local NewMazeShopHallowCard = require("UI/NewMaze/NewMazeShopHallowCard")
local NewMazeShopHaloCard = require("UI/NewMaze/NewMazeShopHaloCard")
local NewMazeCoinCard = require("UI/NewMaze/NewMazeCoinCard")
local ResNewMazeHero = require("ClientData/ResNewMazeHero")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local ResNewMazeItemType = require("ClientData/ResNewMazeItemType")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeDeBuff = require("ClientData/ResNewMazeDeBuff")
local ResNewMazeEnchanter = require("ClientData/ResNewMazeEnchanter")
local ResColor = require("ClientData/ResColor")
local strClassName = "NewMazeGridCard"
local NewMazeGridCard = Class(strClassName, UIControls.Child)
local SHOP_ITEM_MAP = {
	[Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero] = {
		NewMazeShopHeroCard,
		"System/Common/Grid/GridRogueHeroCard"
	},
	[Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic] = {
		NewMazeShopHallowCard,
		"System/Common/Grid/GridRogueHallowCard"
	},
	[Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo] = {
		NewMazeShopHaloCard,
		"System/Common/Grid/GridRogueHaloCard"
	},
	[Const.NEW_MAZE_SHOP_ITEM_TYPE.Coin] = {
		NewMazeCoinCard,
		"System/Common/Grid/GridRogueGoldCard"
	}
}

function NewMazeGridCard:ctor(...)
	self:initUI()
end

function NewMazeGridCard:initUI()
	self.imgSoldOut = UIControls.Panel(self, "ImgSoldOut")
	self.textBuyNum = UIControls.Label(self, "BgTextBuy/TextNum")
	self.textSaleNum = UIControls.Label(self, "BgTextSale/TextNum")
	self.bgTextBuy = UIControls.Panel(self, "BgTextBuy")
	self.bgTextSale = UIControls.Panel(self, "BgTextSale")
	self.bgTextChoose = UIControls.Panel(self, "BgTextChoose")
	self.imgSel = UIControls.Image(self, "ImgSel")
	self.bgTextUpBat = UIControls.Button(self, "BgTextUpBat")

	self.bgTextUpBat:addEventClick(self.onBgTextUpBatClick)

	self.bgTextDownBat = UIControls.Button(self, "BgTextDownBat")

	self.bgTextDownBat:addEventClick(self.onBgTextDownBatClick)

	self.bgUpBattle = UIControls.Image(self, "BgUpBattle")
	self.bgplastic1 = UIControls.Image(self, "Bgplastic1")
	self.bgplastic2 = UIControls.Image(self, "Bgplastic2")
	self.bgCard = UIControls.Image(self, "BgCard")
	self.bgBtn = UIControls.Image(self, "BgBtn")
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.emptyRaycast = UIControls.Panel(self, "EmptyRaycast")
end

function NewMazeGridCard:setData(itemData, cardType, awardIndex, isRefresh)
	self.actObj = self.mParent.actObj
	self.opId = self.actObj.opId
	self.itemData = itemData
	self.cardType = cardType
	self.awardIndex = awardIndex
	self.coin = self.mParent.coin

	local gridConfig = SHOP_ITEM_MAP[self.itemData.type] or SHOP_ITEM_MAP[Const.NEW_MAZE_SHOP_ITEM_TYPE.Coin]

	self.cardClass = gridConfig[1]
	self.cardPrefab = gridConfig[2]

	if isRefresh then
		if self.cardPanel then
			self.cardPanel:destroy()

			self.cardPanel = nil
		end

		self.cardPanel = self.cardClass(self, "CardPanel", self.cardPrefab, 0, 0, true)
	elseif self.cardPanel == nil then
		self.cardPanel = self.cardClass(self, "CardPanel", self.cardPrefab, 0, 0, true)
	end

	if self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		local losderType

		if self.cardType == Const.NEW_MAZE_SHOP_SALE_CARD then
			losderType = Const.NEW_MAZE_LOSDER_TYPE_REDUCE
		elseif self.itemData.num and self.itemData.num > 0 then
			losderType = Const.NEW_MAZE_LOSDER_TYPE_ADD
		end

		self.cardPanel:setData(self.itemData.id, losderType)
	else
		self.cardPanel:setData(self.itemData.id, self.itemData.num, self.itemData.type)
	end

	if self.cardPanel and self.cardPanel.getIconPath then
		self.gridIconPath = self.cardPanel:getIconPath()
	else
		self.gridIconPath = nil
	end

	self.bgTextChoose:setVisible(self.cardType == Const.NEW_MAZE_TREASURE_CARD)
	self.bgTextBuy:setVisible(self.cardType == Const.NEW_MAZE_SHOP_BUY_CARD)
	self.bgTextSale:setVisible(self.cardType == Const.NEW_MAZE_SHOP_SALE_CARD)

	if self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Hero then
		self.intType = 1
		self.rarity = ResNewMazeHero[self.itemData.id].quality
		self.iconQuality = self.rarity
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Relic then
		self.intType = 2
		self.rarity = ResNewMazeRelic[self.itemData.id].rarity
		self.iconQuality = self.rarity
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo then
		self.intType = 3
		self.rarity = 1
		self.iconQuality = 3
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.RedHeart then
		self.intType = 5
		self.rarity = 1
		self.iconQuality = 3
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Buff then
		self.intType = 6
		self.rarity = ResNewMazeDeBuff[self.itemData.id].quality
		self.iconQuality = self.rarity
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.ShopExp then
		self.intType = 8
		self.rarity = 1
		self.iconQuality = 2
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Solder then
		self.intType = 9
		self.rarity = ResNewMazeEnchanter[self.itemData.id].quality
		self.iconQuality = self.rarity
	elseif self.itemData.type == Const.NEW_MAZE_SHOP_ITEM_TYPE.Potion then
		self.intType = 10
		self.rarity = 1
		self.iconQuality = 2
	end

	self.buyPrice = 0
	self.salePrice = 0

	if self.intType ~= nil and ResNewMazeItemType[self.intType][self.rarity] then
		self.buyPrice = ResNewMazeItemType[self.intType][self.rarity].purchase_price
		self.salePrice = ResNewMazeItemType[self.intType][self.rarity].selling_price
	end

	if self.iconQuality ~= nil then
		local iconBtnNameList = {
			"BtnCardBlue",
			"BtnCardYellow",
			"BtnCardPink"
		}
		local iconCardNameList = {
			"BgCardBlue",
			"BgCardYellow",
			"BgCardPink"
		}

		self.bgBtn:setImage("Atlas/RogueAtlas/RogueStoreAtlas", iconBtnNameList[self.iconQuality])
		self.bgCard:setImage("Atlas/RogueAtlas/RogueStoreAtlas", iconCardNameList[self.iconQuality])

		if self.cardPanel and self.cardPanel.setItemQuality then
			self.cardPanel:setItemQuality(self.iconQuality)
		end
	end

	self.emptyRaycast:setVisible(true)

	if self.cardType == Const.NEW_MAZE_SHOP_BUY_CARD then
		self.textBuyNum:setText(self.buyPrice)
		self.imgSoldOut:setVisible(self.itemData.num and self.itemData.num <= 0)
		self:setBuyCardFontColor()
	elseif self.cardType == Const.NEW_MAZE_SHOP_SALE_CARD then
		self.textSaleNum:setText("+" .. self.salePrice)
	elseif self.cardType == Const.NEW_MAZE_HALO_PREVIEW_CARD then
		self.emptyRaycast:setVisible(false)

		local isUse = utils.tableIsContainsElement(self.mParent.usedHalo or {}, self.itemData.id)

		if isUse then
			self.bgTextUpBat:setVisible(false)
			self.bgTextDownBat:setVisible(true)
			self.bgUpBattle:setVisible(true)
		else
			self.bgTextUpBat:setVisible(true)
			self.bgTextDownBat:setVisible(false)
			self.bgUpBattle:setVisible(false)
		end

		self.bgplastic1:setVisible(false)
		self.bgplastic2:setVisible(false)
		self.bgCard:setVisible(false)
	end
end

function NewMazeGridCard:setBuyCardFontColor()
	if self.cardType == Const.NEW_MAZE_SHOP_BUY_CARD then
		self.coin = self.actObj.actData:getCoin()

		if self.coin < self.buyPrice then
			self.textBuyNum:setFontColor(ResColor.RED)
		else
			self.textBuyNum:setFontColor(ResColor.WHITE)
		end
	end
end

function NewMazeGridCard:onBgTextBuyClick()
	if self.itemData.num <= 0 then
		MsgManager.notice(ResNewMazeDisplay[13060042].desc)

		return
	end

	self.coin = self.actObj.actData:getCoin()

	if self.coin < self.buyPrice then
		MsgManager.notice(ResNewMazeDisplay[13060014].desc)

		return
	end

	UIManager.showConfirmWithId(1074, function()
		self.mParent.curChooseItem = {
			type = self.itemData.type,
			id = self.itemData.id,
			iconPath = self.gridIconPath
		}

		RPC.newMazeShopPurchase(self.opId, nil, self.itemData.type, self.itemData.id)
	end)
end

function NewMazeGridCard:onBgTextSaleClick()
	local function yesFunc()
		RPC.newMazeShopSell(self.opId, nil, self.itemData.type, self.itemData.id)
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(61828), yesFunc, nil, -1)
end

function NewMazeGridCard:onBgTextChooseClick()
	self.mParent.curChooseItem = {
		type = self.itemData.type,
		id = self.itemData.id,
		index = self.awardIndex,
		iconPath = self.gridIconPath
	}

	if self.chooseClick then
		self.chooseClick(self)
	end
end

function NewMazeGridCard:onSensorClick()
	if self.cardType == Const.NEW_MAZE_TREASURE_CARD then
		self:onBgTextChooseClick()
	elseif self.cardType == Const.NEW_MAZE_SHOP_BUY_CARD then
		self:onBgTextBuyClick()
	elseif self.cardType == Const.NEW_MAZE_SHOP_SALE_CARD then
		self:onBgTextSaleClick()
	end
end

function NewMazeGridCard:onBgTextUpBatClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	local maxUserHaloNum = self.mParent.newMazeData:getCurMaxHaloNumByShopLevel()

	if maxUserHaloNum <= #self.mParent.usedHalo then
		MsgManager.notice(string.format(ResNewMazeDisplay[13060015].desc, maxUserHaloNum))

		return
	end

	RPC.newMazeHaloEquip(self.opId, self.itemData.id)
end

function NewMazeGridCard:onBgTextDownBatClick()
	if self.actObj:inFreeze() then
		MsgManager.notice(Lang.get(32793))

		return
	end

	RPC.newMazeHaloUnEquip(self.opId, self.itemData.id)
end

return NewMazeGridCard
