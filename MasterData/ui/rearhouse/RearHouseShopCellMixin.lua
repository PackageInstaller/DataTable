-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseShopCellMixin.lua

local ResColor = require("ClientData/ResColor")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResItem = require("ClientData/ResItem")
local RearHouseShopCellMixin = {}
local ShopCellBaseMixin = require("UI/MainState/Trade/ShopCellBaseMixin")

MixinClass(RearHouseShopCellMixin, ShopCellBaseMixin)

function RearHouseShopCellMixin:ctorMixin(clickEnabled, checkNeedConvertObject)
	self.checkNeedConvertObject = checkNeedConvertObject

	self:initUI(clickEnabled)
end

function RearHouseShopCellMixin:initUI(clickEnabled)
	self:initBaseUI(clickEnabled)

	self.btnSelf = UIControls.Button(self, "")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.imgIcon = UIControls.Image(self, "ContentPanel/Icon")
	self.txtName = UIControls.Label(self, "ContentPanel/TextName")
	self.imgQuality = UIControls.Image(self, "ContentPanel/ImgQuality")
	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.imgSoldOut = UIControls.Image(self, "ContentPanel/ImgSoldOut")
	self.panelMoney = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.imgMoney = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtMoney = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice")
	self.panelMoneyDiscount = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.txtMoneyDc = UIControls.ShortNumLabel(self, "ContentPanel/DiscountPanel/TextPrice")
	self.txtRateDc = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.imgCommand = UIControls.Image(self, "ContentPanel/IconSp")

	self.btnSelf:setEnable(clickEnabled)
	self.txtLimit:setJumpDisplayMode(UIControls.Label.JumpDisplayMode.TIME)
	self.txtLimit:setJumpPostfixByMode(UIControls.Label.JumpAttachType.DAY_POSTFIX, Lang.get(30548))

	self.panelComFortable = UIControls.Panel(self, "ContentPanel/BgInfo/BgConfortable")
	self.txtComfortable = UIControls.Label(self, "ContentPanel/BgInfo/BgConfortable/TextNum")
	self.panelBgKg = UIControls.Panel(self, "ContentPanel/BgInfo/BgKg")
	self.txtKg = UIControls.Label(self, "ContentPanel/BgInfo/BgKg/TextNum")
	self.panelBgInfo = UIControls.Panel(self, "ContentPanel/BgInfo")
	self.txtHaveNum = UIControls.Label(self, "ContentPanel/TextHave")

	if UIControls.checkControlFunc(self, "ContentPanel/IconChange") then
		self.animContentPanel = UIControls.UIAni(self, "ContentPanel")
		self.mask = UIControls.Panel(self, "ContentPanel/Mask")
		self.iconChange = UIControls.Panel(self, "ContentPanel/IconChange")
		self.changeImgIcon = UIControls.Image(self, "ContentPanel/Mask/Icon")
		self.changeImgQuality = UIControls.Image(self, "ContentPanel/Mask/ImgQuality")
		self.changeTextNum = UIControls.ShortNumLabel(self, "ContentPanel/Mask/TextNum")
	end
end

function RearHouseShopCellMixin:setData(shopItem, shopDiscountRate)
	if shopItem == nil then
		self:setVisible(false)

		return
	end

	self.item = shopItem

	self:updateNameAndCount(shopItem)
	self:updateIcon(shopItem)
	self:updateLimitAndQuality(shopItem)
	self:updateMoney(shopItem)
	self:RefreshConvertObject()
	self:setVisible(true)
end

function RearHouseShopCellMixin:updateMoney(shopItem)
	local data = shopItem.data
	local moneyInfo = data.use[1]
	local resData = ResItem[moneyInfo.ID]
	local moneyAtlasPath = UIConst.ITEM_ICON_PATH .. resData.sourceIconPath
	local iconName = resData.sourceIcon

	self.imgMoney:setImage(moneyAtlasPath, iconName)

	local hasDiscount = moneyInfo.rate ~= nil
	local showDiscount = hasDiscount and not shopItem:isSoldOut() and shopItem.sellStyle == nil

	self.panelMoneyDiscount:setVisible(showDiscount)

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

		self.txtRateDc:setText(string.format(strFormat, discountV))
	end

	if hasDiscount then
		self.txtMoney:setNum(moneyInfo.discount)
		self.txtMoneyDc:setNum(moneyInfo.original or moneyInfo.discount)
		self.txtMoney:setFontColor(ResColor.GREY)
	else
		self.txtMoney:setNum(moneyInfo.discount)
	end
end

function RearHouseShopCellMixin:updateNameAndCount(shopItem)
	local sellStyle = shopItem.sellStyle
	local sellStylePath = shopItem.sellStylePath

	if sellStyle and sellStylePath then
		self.imgCommand:setImage("Atlas/" .. sellStylePath, sellStyle)
		self.imgCommand:setVisible(true)
	else
		self.imgCommand:setVisible(false)
	end

	local isSoldOut = shopItem:isSoldOut()
	local isLocked = shopItem:isLocked()

	self.panelContent:setObjGray(isSoldOut or isLocked)
	self:checkLocked(shopItem)

	local object = shopItem.object

	self.txtName:setText(object.name)

	local comfortable = shopItem:getComfortable()

	if comfortable then
		self.panelComFortable:setVisible(true)
		self.txtComfortable:setText(comfortable)
	else
		self.panelComFortable:setVisible(false)
	end

	local weight = shopItem:getWeight()

	if weight then
		self.panelBgKg:setVisible(true)
		self.txtKg:setText(weight)
	else
		self.panelBgKg:setVisible(false)
	end

	self.panelBgInfo:setVisible(weight ~= nil or comfortable ~= nil)

	if shopItem:isRearHouseType() then
		self.txtHaveNum:setVisible(true)
		self.txtHaveNum:setText(string.format(Lang.get(30716), CurAvatar:getItemNumById(shopItem.object.id)))
	else
		self.txtHaveNum:setVisible(false)
	end
end

function RearHouseShopCellMixin:updateItem(shopItem)
	local object = shopItem.object
	local isEquip = object:isEquip()
	local isFrag = object:isFragmentItem()
	local isArtifact = object:isArtifact()

	self.panelEquip:setVisible(isEquip)
	self.panelFrag:setVisible(isFrag)
	self.imgArtifactCareer:setVisible(isArtifact)

	if isEquip then
		local suitPath = object:getSuitPath()

		if suitPath then
			self.imgEquipSuit:setImage(suitPath[1], suitPath[2])
		else
			self.imgEquipSuit:setVisible(false)
		end

		self.txtEquipStar:setText(object.level or 0)
	elseif isFrag then
		local starPath = object:getFragHeroStarPath()

		if starPath then
			self.imgFragStar:setImage(starPath[1], starPath[2])
		end

		self.imgFragStar:setVisible(starPath ~= nil)
	elseif isArtifact then
		local careerPath = object:getCareerIconPath()

		if careerPath then
			self.imgArtifactCareer:setImage(careerPath[1], careerPath[2])
		end
	end
end

function RearHouseShopCellMixin:updateIcon(shopItem)
	local object = shopItem.object
	local iconPath = object:getIconPath()

	if iconPath then
		local isFrag = object:isFragmentItem()

		if isFrag then
			self.panelFragIcon:setVisible(true)
			self.imgIcon:setVisible(false)
			self.imgFragIcon:setImage(iconPath[1], iconPath[2])
		else
			self.imgIcon:setVisible(true)
			self.imgIcon:setImage(iconPath[1], iconPath[2])
		end
	else
		self.panelFragIcon:setVisible(false)
		self.imgIcon:setVisible(false)
	end
end

function RearHouseShopCellMixin:RefreshConvertObject()
	if self.iconChange then
		local object = self.item.object
		local checkConvertObject = self.checkNeedConvertObject and not self.item:isSoldOut() and BaseObject.checkConvertObject(object)

		self.mask:setVisible(checkConvertObject)
		self.iconChange:setVisible(checkConvertObject)

		if checkConvertObject then
			local convertObj = BaseObject.getConvertObject(object)
			local iconPath = convertObj:getIconPath()

			if iconPath then
				self.changeImgIcon:setImage(iconPath[1], iconPath[2])
			end

			if convertObj.num and convertObj.num > 1 then
				self.changeTextNum:setNum(convertObj.num, "x")
			else
				self.changeTextNum:setText("")
			end

			self.animContentPanel:startAniLoop("LoopChangeStore")
		else
			self.animContentPanel:stopAni("LoopChangeStore")
		end
	end
end

function RearHouseShopCellMixin:updateLimitAndQuality(shopItem)
	local isSoldOut = shopItem:isSoldOut()
	local isLocked = shopItem:isLocked()
	local itemQuality = Const.ITEM_QUALITY_UNKNOWN

	if isSoldOut or isLocked then
		-- block empty
	else
		itemQuality = shopItem.object.quality
	end

	if isSoldOut then
		self.txtLimit:setVisible(false)
		self.imgSoldOut:setVisible(true)
	else
		self.imgSoldOut:setVisible(false)
		self.txtLimit:setVisible(true)
	end

	local staticHint, recoverTick = shopItem:getHint()

	if staticHint then
		self.txtLimit:setText(staticHint, false, true)
	else
		self.txtLimit:jumpTo(recoverTick, 0, recoverTick)
	end

	local qualityPath = UIConst.REARHOUSE_SHOP_QUALITY_CONFIG[itemQuality]

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end
end

return RearHouseShopCellMixin
