-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\SkinShopCellMixin.lua

local ResColor = require("ClientData/ResColor")
local ResItem = require("ClientData/ResItem")
local SkinShopCellMixin = {}
local ShopCellBaseMixin = require("UI/MainState/Trade/ShopCellBaseMixin")

MixinClass(SkinShopCellMixin, ShopCellBaseMixin)

function SkinShopCellMixin:ctorMixin(clickEnabled)
	self:initUI(clickEnabled)
end

function SkinShopCellMixin:initUI(clickEnabled)
	self:initBaseUI(clickEnabled)

	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:setEnable(clickEnabled)

	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.imgSkin = UIControls.Image(self, "ContentPanel/Icon")
	self.txtName = UIControls.Label(self, "ContentPanel/TextName")
	self.imgQuality = UIControls.Image(self, "ContentPanel/ImgQuality")
	self.imgCurrency = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtPrice = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice")
	self.disCountPanel = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.txtOrigPrice = UIControls.ShortNumLabel(self, "ContentPanel/DiscountPanel/TextPrice")
	self.imgDiscount = UIControls.Image(self, "ContentPanel/DiscountPanel/ImgDiscount")
	self.txtDiscount = UIControls.Image(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.imgSP = UIControls.Image(self, "ContentPanel/IconSp")
	self.txtGot = UIControls.Label(self, "ContentPanel/TxtGot")
	self.btnPreview = UIControls.Button(self, "ContentPanel/BtnPreview")

	self.btnPreview:addEventClick(self.onPreviewSkin)
end

function SkinShopCellMixin:setData(shopItem, shopDiscountRate)
	if shopItem == nil then
		self:setVisible(false)

		return
	end

	self.item = shopItem

	self:updateNameAndCount(shopItem)
	self:updateIcon(shopItem)
	self:updateItem(shopItem)
	self:updateLimitAndQuality(shopItem)
	self:updateMoney(shopItem)
	self:_setData()
	self:setVisible(true)
end

function SkinShopCellMixin:_setData()
	return
end

function SkinShopCellMixin:updateMoney(shopItem)
	local data = shopItem.data
	local moneyInfo = data.use[1]
	local resData = ResItem[moneyInfo.ID]
	local moneyAtlasPath = UIConst.ITEM_ICON_PATH .. resData.sourceIconPath
	local iconName = resData.sourceIcon

	self.imgCurrency:setImage(moneyAtlasPath, iconName)

	local hasDiscount = moneyInfo.rate ~= nil
	local showDiscount

	showDiscount = hasDiscount and true or false

	self.disCountPanel:setVisible(showDiscount)

	if showDiscount then
		local discountV = moneyInfo.rate or 10

		if Const.SHOP_DISCOUNT_MODE == 1 then
			discountV = 100 - discountV * 10
		end

		local a, b = math.modf(discountV)
		local strFormat = "%s"

		if b > 0 then
			strFormat = "%.1f"
		end

		self.txtDiscount:setText(string.format(strFormat, discountV))
	end

	self.txtPrice:setNum(moneyInfo.discount)

	if hasDiscount then
		self.txtOrigPrice:setNum(moneyInfo.original or moneyInfo.discount)
		self.txtPrice:setFontColor(ResColor.GREY)
	end
end

function SkinShopCellMixin:updateNameAndCount(shopItem)
	local sellStyle = shopItem.sellStyle
	local sellStylePath = shopItem.sellStylePath

	if sellStyle and sellStylePath then
		self.imgSP:setImage("Atlas/" .. sellStylePath, sellStyle)
		self.imgSP:setVisible(true)
	else
		self.imgSP:setVisible(false)
	end

	local isGet = shopItem.object:isGet()
	local hasBought = shopItem.boughtNum > 0
	local canBuy = isGet or hasBought
	local object = shopItem.object

	self.txtName:setText(object.name)
	self.txtGot:setVisible(canBuy)
	self.btnSelf:setEnable(not canBuy)

	self.isLocked = false

	if canBuy then
		self.imgSP:setVisible(false)
	end

	self.panelContent:setObjGray(not canBuy and shopItem:isLocked())

	if canBuy then
		self.imgLock:setVisible(false)
	else
		self:checkLocked(shopItem)
	end

	self.buyEnable = not canBuy
end

function SkinShopCellMixin:updateItem(shopItem)
	return
end

function SkinShopCellMixin:updateIcon(shopItem)
	local obj = shopItem.object
	local iconInfo = obj:getSkinIconPath()
	local iconQuality = obj:getQualityIconPath()

	self.imgSkin:setImage(iconInfo[1], iconInfo[2])
	self.imgQuality:setImage(iconQuality[1], iconQuality[2])
end

function SkinShopCellMixin:updateLimitAndQuality(shopItem)
	return
end

function SkinShopCellMixin:onPreviewSkin()
	local skinData = self.item.object.clientData

	if skinData then
		local skinPreviewTips = UIManager.getUI("skinPreviewTips")

		skinPreviewTips:setObject(skinData, self.item.object, self)

		if self.item:canBuy() and self.buyEnable then
			skinPreviewTips:onShowSkinBuy(self.item)
		end
	end
end

return SkinShopCellMixin
