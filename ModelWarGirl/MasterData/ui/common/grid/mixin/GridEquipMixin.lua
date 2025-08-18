-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridEquipMixin.lua

local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local GridEquipMixin = {}
local UIConst = UIConst

function GridEquipMixin:initUI()
	GridItemMixin.initUI(self)

	self.panelAttr = UIControls.Panel(self, self.basePath .. "AttrPanel")
	self.textMain = UIControls.Label(self, self.basePath .. "AttrPanel/Text")
	self.imgMain = UIControls.Image(self, self.basePath .. "AttrPanel/Icon")
	self.imgSuit = UIControls.Image(self, self.basePath .. "IconSuit")
	self.panelEnhance = UIControls.Panel(self, self.basePath .. "BgUpgrade")
	self.imgEnhance = UIControls.Image(self, self.basePath .. "BgUpgrade")
	self.textEnhance = UIControls.Label(self, self.basePath .. "BgUpgrade/Text")
	self.panelStar = UIControls.Panel(self, self.basePath .. "StarPanel")
	self.imgStep = UIControls.Image(self, self.basePath .. "StarPanel/Icon")
	self.panelWearing = UIControls.Panel(self, self.basePath .. "IconState")
	self.imgIconState = UIControls.Image(self, self.basePath .. "IconState")
	self.bgHero = UIControls.Image(self, self.basePath .. "BgHero")

	if UIControls.checkControlFunc(self, self.basePath .. "BgHero/Bg") then
		self.imgHeroBg = UIControls.Image(self, self.basePath .. "BgHero/Bg")
	end

	self.imgHero = UIControls.Image(self, self.basePath .. "BgHero/IconHero")
	self.inBag = false
end

function GridItemMixin:hideBgHeroAndShowStar(isHide)
	if self.bgHero then
		self.bgHero:setVisible(not isHide)
	end

	if self.panelStar then
		self.panelStar:setVisible(isHide)
	end
end

function GridEquipMixin:refreshSpeSuitInfo()
	if self.object:isDefineHeroEquip() and self.imgHero then
		local isWearedInOther = false
		local wearedGid = self.preInWearing or self.object.inWearing

		if wearedGid and CurAvatar.heroDic[wearedGid] then
			local wearedHero = CurAvatar.heroDic[wearedGid]

			if self.object:getDefineHeroId() ~= wearedHero.id then
				isWearedInOther = true
			end
		end

		if isWearedInOther then
			self.bgHero:setImageGray(true)
			self.imgHero:setImageGray(true)

			if self.imgHeroBg then
				self.imgHeroBg:setImageGray(true)
			end
		else
			self.bgHero:setImageGray(false)
			self.imgHero:setImageGray(false)

			if self.imgHeroBg then
				self.imgHeroBg:setImageGray(false)
			end
		end
	end
end

function GridEquipMixin:_setObj(object)
	GridItemMixin._setObj(self, object)

	if object:isDefineHeroEquip() and self.imgHero then
		local fakeHero = BaseObject.GetObject(object.resDefineEffctData[1].hero_id)
		local iconPath = fakeHero:getQIconPath()

		self.bgHero:setVisible(true)
		self.panelStar:setVisible(false)

		if iconPath then
			self.imgHero:setImage(iconPath[1], iconPath[2])
		end
	else
		self.panelStar:setVisible(true)
		self.bgHero:setVisible(false)
	end

	self:refreshSpeSuitInfo()
	self.panelAttr:setVisible(self.inBag)

	local mainIcon = ClientUtils.getRolePropIconByType(object.mainProp)

	if mainIcon then
		self.imgMain:setImage(mainIcon[1], mainIcon[2])
	end

	if ResEquipMainProp[object.mainProp] and ResEquipMainProp[object.mainProp][object.level] then
		local zhName, valueStr = ClientUtils.getRolePropZhNameByType(object.mainProp, object.mainPropValue)

		self.textMain:setText(valueStr)
	end

	local suitPath = object:getSuitPath()

	if suitPath then
		self.imgSuit:setVisible(true)
		self.imgSuit:setImage(suitPath[1], suitPath[2])
	else
		self.imgSuit:setVisible(false)
	end

	if object.enhanceLevel and object.enhanceLevel > 0 then
		self.panelEnhance:setVisible(true)
		self.textEnhance:setText("+" .. object.enhanceLevel)
	else
		self.panelEnhance:setVisible(false)
	end

	local iconStatePath = "Atlas/CommonAtlas/GridAtlas/GridAtlas01"

	if object.inWearing then
		if object.isLock == Const.EQUIP_STATE_LOCK then
			self.imgIconState:setImage(iconStatePath, "IconEquipLock")
		else
			self.imgIconState:setImage(iconStatePath, "IconEquip")
		end

		self.panelWearing:setVisible(true)
	elseif object.isLock == Const.EQUIP_STATE_LOCK then
		self.imgIconState:setImage(iconStatePath, "IconLock")
		self.panelWearing:setVisible(true)
	else
		self.panelWearing:setVisible(false)
	end

	local stepPath = object:getEquipStepPath()

	if stepPath then
		self.imgStep:setImage(stepPath[1], stepPath[2])
	end
end

function GridEquipMixin:clear()
	GridItemMixin.clear(self)
end

function GridEquipMixin:openTipsPanel(fromHold)
	if not fromHold then
		if self.mEnableTips then
			if self.object.itemType == Const.ITEM_TYPE_EQUIP then
				UIManager.getUI("equipTips"):show(self, self.mTipsConfig, self.uiConfig)
			elseif self.object.itemType == Const.ITEM_TYPE_EQUIP_TEMPLETE then
				UIManager.getUI("equipTempleteTips"):show(self)
			end
		end
	elseif self.mEnableHoldTips then
		UIManager.getUI("equipTips"):show(self, self.mTipsConfig, self.uiConfig)
	elseif self.object.itemType == Const.ITEM_TYPE_EQUIP_TEMPLETE then
		UIManager.getUI("equipTempleteTips"):show(self)
	end
end

function GridItemMixin:closeTipsPanel()
	UIManager.tryHideUI("equipTips")
end

setmetatable(GridEquipMixin, {
	__index = GridItemMixin
})

return GridEquipMixin
