-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\RelicStoreCellMixin.lua

local ResColor = require("ClientData/ResColor")
local RelicStoreCellMixin = {}
local ShopCellBaseMixin = require("UI/MainState/Trade/ShopCellBaseMixin")

MixinClass(RelicStoreCellMixin, ShopCellBaseMixin)

function RelicStoreCellMixin:ctorMixin(clickEnabled)
	self:initUI(clickEnabled)
end

function RelicStoreCellMixin:initUI(clickEnabled)
	self:initBaseUI(clickEnabled)

	self.btnSelf = UIControls.Button(self, "")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.imgIcon = UIControls.Image(self, "ContentPanel/RelicPanel/Icon")
	self.imgHave = UIControls.Image(self, "ContentPanel/ImgHave")
	self.txtName = UIControls.Label(self, "ContentPanel/TextName")
	self.imgQuality = UIControls.Image(self, "ContentPanel/ImgQuality")
	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.panelMoney = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.imgMoney1 = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtMoney1 = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice")
	self.imgMoney2 = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency2")
	self.txtMoney2 = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice2")
	self.panelRelic = UIControls.Panel(self, "ContentPanel/RelicPanel")
	self.imgRelicHero = UIControls.Image(self, "ContentPanel/RelicPanel/ImgHero")
	self.imgRelicSkillType = UIControls.Image(self, "ContentPanel/RelicPanel/IconSkillType")
	self.imgRelicGroup = UIControls.Image(self, "ContentPanel/RelicPanel/IconGroup")
	self.imgRelicCareer = UIControls.Image(self, "ContentPanel/RelicPanel/IconCareer")

	self.btnSelf:setEnable(clickEnabled)
	self.txtLimit:setJumpDisplayMode(UIControls.Label.JumpDisplayMode.TIME)
	self.txtLimit:setJumpPostfixByMode(UIControls.Label.JumpAttachType.DAY_POSTFIX, Lang.get(30548))
end

function RelicStoreCellMixin:setData(shopItem, shopDiscountRate)
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
	self:setVisible(true)
end

function RelicStoreCellMixin:updateMoney(shopItem)
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

function RelicStoreCellMixin:updateNameAndCount(shopItem)
	local sellStyle = shopItem.sellStyle
	local sellStylePath = shopItem.sellStylePath

	self.panelContent:setObjGray(shopItem.isRelicValid ~= 1)

	local object = shopItem.object

	self.txtName:setText(object.name)
end

function RelicStoreCellMixin:updateItem(shopItem)
	local object = shopItem.object
	local headPath = object:getHeroHeadPath()

	if headPath then
		self.imgRelicHero:setImage(headPath[1], headPath[2])
		self.imgRelicHero:setVisible(true)
	else
		self.imgRelicHero:setVisible(false)
	end

	local campPath = object:getHeroCampPath()

	if campPath then
		self.imgRelicGroup:setImage(campPath[1], campPath[2])
		self.imgRelicGroup:setVisible(true)
	else
		self.imgRelicGroup:setVisible(false)
	end

	local careerPath = object:getHeroCareerPath()

	if careerPath and not self.imgRelicHero:getVisible() then
		self.imgRelicCareer:setImage(careerPath[1], careerPath[2])
		self.imgRelicCareer:setVisible(true)
	else
		self.imgRelicCareer:setVisible(false)
	end

	local skillTypePath = object:getSkillTypePath()

	if skillTypePath then
		self.imgRelicSkillType:setImage(skillTypePath[1], skillTypePath[2])
		self.imgRelicSkillType:setVisible(true)
	else
		self.imgRelicSkillType:setVisible(false)
	end

	self.panelRelic:setVisible(true)
end

function RelicStoreCellMixin:updateIcon(shopItem)
	local object = shopItem.object
	local resId = object.id

	self.imgIcon:setVisible(false)

	local iconPath = object:getIconPath()

	if iconPath then
		self.imgIcon:setVisible(true)
		self.imgIcon:setImage(iconPath[1], iconPath[2])
	end
end

function RelicStoreCellMixin:updateLimitAndQuality(shopItem)
	self:checkLocked(shopItem)

	local itemQuality = Const.ITEM_QUALITY_UNKNOWN

	if shopItem:isLocked() then
		self.imgHave:setVisible(false)
		self.txtLimit:setText("")
	else
		local isSoldOut = shopItem:isSoldOut()
		local isHave = CurAvatar.bagRelics ~= nil and CurAvatar.bagRelics[shopItem.object.id] ~= nil

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

	local qualityPath = UIConst.SHOP_QUALITY_CONFIG[itemQuality]

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end
end

return RelicStoreCellMixin
