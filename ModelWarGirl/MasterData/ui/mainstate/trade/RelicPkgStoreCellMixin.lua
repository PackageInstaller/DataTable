-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\RelicPkgStoreCellMixin.lua

local ResColor = require("ClientData/ResColor")
local RelicPkgStoreCellMixin = {}

function RelicPkgStoreCellMixin:ctorMixin(clickEnabled)
	self:initUI(clickEnabled)
end

function RelicPkgStoreCellMixin:initUI(clickEnabled)
	self.btnSelf = UIControls.Button(self, "")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.imgIcon = UIControls.Image(self, "ContentPanel/RelicPackPanel/Icon")
	self.imgHave = UIControls.Image(self, "ContentPanel/ImgHave")
	self.imgLock = UIControls.Image(self, "ContentPanel/ImgLock")
	self.bgLock = UIControls.Panel(self, "ContentPanel/ImgLock/BgCondition")
	self.textLock = UIControls.Label(self, "ContentPanel/ImgLock/BgCondition/Text")
	self.imgRelicSpecialSign = UIControls.Image(self, "ContentPanel/BgEn")
	self.txtName = UIControls.Label(self, "ContentPanel/TextName")
	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.panelMoney = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.imgMoney1 = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtMoney1 = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice")
	self.imgMoney2 = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency2")
	self.txtMoney2 = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice2")

	self.btnSelf:setEnable(clickEnabled)
	self.txtLimit:setJumpDisplayMode(UIControls.Label.JumpDisplayMode.TIME)
	self.txtLimit:setJumpPostfixByMode(UIControls.Label.JumpAttachType.DAY_POSTFIX, Lang.get(30548))
end

function RelicPkgStoreCellMixin:setData(shopItem, shopDiscountRate)
	if shopItem == nil then
		self:setVisible(false)

		return
	end

	self.item = shopItem

	self:updateNameAndCount(shopItem)
	self:updateIcon(shopItem)
	self:updateLimitAndQuality(shopItem)
	self:updateMoney(shopItem)
	self:setVisible(true)
end

function RelicPkgStoreCellMixin:updateMoney(shopItem)
	local data = shopItem.data

	for idx = 1, 2 do
		local moneyInfo = data.use[idx]

		self["imgMoney" .. idx]:setVisible(moneyInfo ~= nil)
		self["txtMoney" .. idx]:setVisible(moneyInfo ~= nil)

		if moneyInfo then
			local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

			if moneyPath then
				self["imgMoney" .. idx]:setImage(moneyPath[1], moneyPath[2])
			else
				local itemPath = BaseObject.getItemIconPath(moneyInfo.ID)

				if itemPath then
					self["imgMoney" .. idx]:setImage(itemPath[1], itemPath[2])
				end
			end

			self["txtMoney" .. idx]:setNum(moneyInfo.discount)
		end
	end
end

function RelicPkgStoreCellMixin:updateNameAndCount(shopItem)
	local sellStyle = shopItem.sellStyle
	local sellStylePath = shopItem.sellStylePath

	self.panelContent:setObjGray(shopItem.isRelicValid ~= 1)

	local object = shopItem.object

	self.txtName:setText(object.name)
end

function RelicPkgStoreCellMixin:updateIcon(shopItem)
	local object = shopItem.object
	local resId = object.id
	local iconPath = object:getIconPath()

	self.imgIcon:setVisible(false)

	if iconPath then
		self.imgIcon:setVisible(true)
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end

	local speicalSignPath = UIConst.RELIC_SPEICAL_SIGN_PATH[object.resData.extend_args1]

	if speicalSignPath then
		self.imgRelicSpecialSign:setImage(speicalSignPath[1], speicalSignPath[2])
	end
end

function RelicPkgStoreCellMixin:updateLimitAndQuality(shopItem)
	local itemQuality = Const.ITEM_QUALITY_UNKNOWN

	if shopItem:isLocked() then
		self.imgLock:setVisible(true)
		self.imgHave:setVisible(false)
		self.txtLimit:setText("")

		if shopItem.shortLockHint then
			self.bgLock:setVisible(true)
			self.textLock:setText(shopItem.shortLockHint)
		elseif shopItem.lockHint and shopItem.lockHint ~= "" then
			self.bgLock:setVisible(true)
			self.textLock:setText(shopItem.lockHint)
		else
			self.bgLock:setVisible(false)
			self.textLock:setText("")
		end
	else
		self.imgLock:setVisible(false)

		local isSoldOut = shopItem:isSoldOut()
		local isHave = not CurAvatar:isRelicBagCanUse(shopItem.object)

		self.imgHave:setVisible(isHave)

		local hintColor = ResColor.GREYLIGHT

		if isSoldOut then
			-- block empty
		else
			itemQuality = shopItem.object.quality
			hintColor = ResColor.WHITE
		end

		self.txtLimit:setFontColor(hintColor)

		local staticHint, recoverTick = shopItem:getHint()

		if staticHint then
			self.txtLimit:setText(staticHint, false, true)
		else
			self.txtLimit:jumpTo(recoverTick, 0, recoverTick)
		end
	end
end

return RelicPkgStoreCellMixin
