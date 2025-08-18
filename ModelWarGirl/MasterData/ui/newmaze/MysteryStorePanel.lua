-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\MysteryStorePanel.lua

local CommonGiftCell = require("UI/Common/CommonGiftCell")
local ShopCellMixin = require("UI/MainState/Trade/ShopCellMixin")
local ShopItem = require("UI/MainState/Trade/ShopItem")
local MysteryShopCellChild = Class("MysteryShopCellChild", UIControls.Child)

MixinClass(MysteryShopCellChild, ShopCellMixin, true)

function MysteryShopCellChild:ctor()
	self:ctorMixin(true)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onCellClick)

	self.textDiscount2Price = UIControls.Label(self, "ContentPanel/DiscountPanel2/TextPrice")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")
end

function MysteryShopCellChild:onCellClick(sender)
	if self.mEventClick ~= nil then
		self.mEventClick(self.item)
	end
end

local MysteryGiftCellChild = Class("MysteryGiftCellChild", CommonGiftCell)

function MysteryGiftCellChild:ctor()
	return
end

local MysteryStorePanel = Class("MysteryStorePanel", UIControls.Child)

function MysteryStorePanel:ctor(...)
	self.CELL_INFO = {
		[Const.MYSTERY_SHOP_TYPE_ITEM] = {
			prePath = "System/Rogue/GridRogueMysteryStoreItem",
			cellType = MysteryShopCellChild
		},
		[Const.MYSTERY_SHOP_TYPE_GIFT] = {
			prePath = "System/Rogue/GridRogueMysteryStoreGift",
			cellType = MysteryGiftCellChild
		}
	}
	self.qualityBgId = 5

	self:initUI()
end

function MysteryStorePanel:initUI(...)
	if UIControls.checkControlFunc(self, "BgPanel/BtnClose") then
		self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

		self.btnClose:addEventClick(self.onBtnCloseClick)
	end

	self.textChat = UIControls.Label(self, "BgPanel/HeroPanel/BgTextChat/TextChat")
	self.cells = {}
end

function MysteryStorePanel:setData(items, shopSubType)
	self.shopType = Const.MYSTERY_SHOP_TYPE
	self.shopSubType = shopSubType
	self.shopItems = items

	for i, data in ipairs(self.shopItems) do
		local cellType = self.CELL_INFO[data.type].cellType
		local prePath = self.CELL_INFO[data.type].prePath
		local cell = self.cells[i]

		cell = cell or cellType(self, "BgPanel/GiftList/Content", prePath, 0, 0, true)

		if data.type == Const.MYSTERY_SHOP_TYPE_ITEM then
			local shopItem = ShopItem(0, data.id, data.buyCount, CurAvatar:getTimeCounter(Const.TimeTICounterTypeShop, data.id))

			cell:setQualityAtlsPath(self.qualityBgId)
			cell:setData(shopItem)

			cell.mEventClick = Slot(self._onShopItemClick, self)

			cell.imgSoldOut:setVisible(shopItem:isSoldOut())
			cell.textDiscount2Price:setText()
		else
			cell:setData(data.id)

			cell.mEventClick = Slot(self._onGiftClick, self)

			if cell.isSoldOut and cell.TextLimit then
				cell.TextLimit:setText(Lang.get(44))
				cell.TextLimit:setVisible(true)
			end
		end

		self.cells[i] = cell
	end
end

function MysteryStorePanel:_onShopItemClick(item)
	if not item:canBuy() then
		local hint = item:getClickHint()

		if hint ~= nil then
			MsgManager.notice(hint)
		end
	else
		item.isFromMystery = true

		if item.object.isSkin and item.object:isSkin() then
			local ui = UIManager.getUI("skinBuyBox")

			ui:showShopItem(item, self, Slot(self.onBuyCB, self))
			ui:bindWindow(self)
			ui:setGoRechargeCallBack(Slot(self.hideDlg, self))
		elseif item.object.isPetGem and item.object:isPetGem() then
			local ui = UIManager.getUI("buyPetGemConfirmDlg")

			ui:showShopItem(item, self, Slot(self.onBuyCB, self))
			ui:bindWindow(self)
			ui:setGoRechargeCallBack(Slot(self.hideDlg, self))
		else
			local ui = UIManager.getUI("shopBuyBox")

			ui:showShopItem(item, self, Slot(self.onBuyCB, self))
			ui:bindWindow(self)
			ui:setGoRechargeCallBack(Slot(self.hideDlg, self))
		end
	end
end

function MysteryStorePanel:hideDlg()
	self.mParent:setVisible(false)
end

function MysteryStorePanel:onBuyCB(exchgid, count)
	self.uiBox = nil

	RPC.shopExchange(0, exchgid, count, 0, self.shopType, self.shopSubType)
end

function MysteryStorePanel:_onGiftClick(sender)
	if sender.isSoldOut == true then
		MsgManager.notice(Lang.get(30596))
	else
		local ui = UIManager.getUI("giftBuyBox")

		self.curCellID = sender.rechargeId

		local item = sender.product

		item.special = {
			type = Const.RECHARGE_SPECIAL_TYPE.MYSTERYSHOP,
			mystery_shop_data = {
				sub_type = self.shopSubType
			}
		}

		ui:showShopItem(item, self, nil, sender.rechargeId)
		ui:bindWindow(self)

		if sender.product.price == 0 then
			ui:onItemBuy()
		else
			ui:setVisible(true)
		end
	end
end

function MysteryStorePanel:setCloseCB(func)
	self.closeFunc = func
end

function MysteryStorePanel:onBtnCloseClick()
	RPC.mysteryShopExit(self.shopSubType)

	if self.closeFunc then
		self.closeFunc()
	end
end

return MysteryStorePanel
