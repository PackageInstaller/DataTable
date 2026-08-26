-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyItemIcon.lua

module("modules.logic.sp01.odyssey.view.OdysseyItemIcon", package.seeall)

local OdysseyItemIcon = class("OdysseyItemIcon", LuaCompBase)

function OdysseyItemIcon:ctor(param)
	self.param = param
end

function OdysseyItemIcon:init(go)
	self:__onInit()

	self.go = go
	self._imageRare = gohelper.findChildImage(self.go, "rare")
	self._simageIcon = gohelper.findChildSingleImage(self.go, "icon")
	self._goExpIcon = gohelper.findChild(self.go, "expIcon")
	self._goTalentIcon = gohelper.findChild(self.go, "talentIcon")
	self._goUnknowSuitIcon = gohelper.findChild(self.go, "unknowSuitIcon")
	self._goCount = gohelper.findChild(self.go, "countbg")
	self._txtCount = gohelper.findChildText(self.go, "count")
	self._goSuit = gohelper.findChild(self.go, "suit")
	self._imageSuit = gohelper.findChildImage(self.go, "suit/image_suitIcon")
	self._goHero = gohelper.findChild(self.go, "hero")
	self._simageHeroIcon = gohelper.findChildSingleImage(self.go, "hero/simage_heroIcon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "click")
	self.fontSize = self._txtCount.fontSize
	self.countBgScale = transformhelper.getLocalScale(self._goCount.transform)
end

function OdysseyItemIcon:addEventListeners()
	self._btnClick:AddClickListener(self.onClick, self)
end

function OdysseyItemIcon:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function OdysseyItemIcon:onClick()
	if self.rewardItemType == OdysseyEnum.RewardItemType.OuterItem then
		if self.type and self.type > 0 and self.itemId and self.itemId > 0 then
			MaterialTipController.instance:showMaterialInfo(self.type, self.itemId)
		end
	else
		local viewParam = {}

		viewParam.itemId = self.itemId
		viewParam.clickPos = GamepadController.instance:getMousePosition()

		OdysseyController.instance:showItemTipView(viewParam)
	end
end

function OdysseyItemIcon:initRewardItemInfo(rewardType, param1, param2)
	if rewardType == OdysseyEnum.RewardItemType.Item then
		self:initItemInfo(rewardType, param1, param2)
	elseif rewardType == OdysseyEnum.RewardItemType.OuterItem then
		self:initOuterItemInfo(rewardType, param1, param2)
	elseif rewardType == OdysseyEnum.RewardItemType.Exp then
		self:showExpItem(param1)
	elseif rewardType == OdysseyEnum.RewardItemType.Talent then
		self:showTalentItem(param1)
	end
end

function OdysseyItemIcon:initItemInfo(type, id, count)
	self:hideItemIcon()
	gohelper.setActive(self._simageIcon, true)
	gohelper.setActive(self._btnClick.gameObject, true)

	self.rewardItemType = type
	self.itemId = id
	self.itemCount = count
	self.itemConfig = OdysseyConfig.instance:getItemConfig(self.itemId)

	if self.itemConfig.type == OdysseyEnum.ItemType.Item then
		self._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.itemConfig.icon))
	elseif self.itemConfig.type == OdysseyEnum.ItemType.Equip then
		self._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.itemConfig.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. self.itemConfig.rare)

	self._txtCount.text = self.itemCount

	self:refreshItemEquipState()
	self:setFontScale()
end

function OdysseyItemIcon:initOuterItemInfo(itemType, dataParam, count)
	self:hideItemIcon()
	gohelper.setActive(self._simageIcon, true)
	gohelper.setActive(self._btnClick.gameObject, true)

	self.rewardItemType = itemType
	self.type = dataParam.type
	self.itemId = dataParam.id
	self.itemCount = count
	self.itemConfig, self.iconUrl = ItemModel.instance:getItemConfigAndIcon(self.type, self.itemId, true)

	self._simageIcon:LoadImage(self.iconUrl)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. OdysseyEnum.OuterItemRareColor[self.itemConfig.rare])

	self._txtCount.text = self.itemCount

	self:setFontScale()
end

function OdysseyItemIcon:showTalentItem(talentPointCount)
	self:hideItemIcon()
	gohelper.setActive(self._goTalentIcon, true)

	self._txtCount.text = talentPointCount

	local rareConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TalentItemRare)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. tonumber(rareConstCo.value))
	self:setFontScale()
end

function OdysseyItemIcon:showExpItem(expCount)
	self:hideItemIcon()
	gohelper.setActive(self._goExpIcon, true)

	self._txtCount.text = expCount

	local rareConstCo = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ExpItemRare)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. tonumber(rareConstCo.value))
	self:setFontScale()
end

function OdysseyItemIcon:showUnknowSuitIcon(rare)
	self:hideItemIcon()
	gohelper.setActive(self._goUnknowSuitIcon, true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. rare)
	self:setShowCountState(false)
end

function OdysseyItemIcon:hideItemIcon()
	gohelper.setActive(self._simageIcon, false)
	gohelper.setActive(self._goSuit, false)
	gohelper.setActive(self._goHero, false)
	gohelper.setActive(self._goExpIcon, false)
	gohelper.setActive(self._goTalentIcon, false)
	gohelper.setActive(self._goUnknowSuitIcon, false)
	gohelper.setActive(self._btnClick.gameObject, false)
end

function OdysseyItemIcon:refreshItemEquipState()
	local isEquip = self.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(self._goHero, isEquip and false)

	local showSuit = self.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(self._goSuit, showSuit)

	if showSuit then
		local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(self.itemConfig.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageSuit, suitConfig.icon)
	end
end

function OdysseyItemIcon:setFontScale(scale)
	local parentTrans = self.go.transform.parent
	local parentScale = parentTrans and transformhelper.getLocalScale(parentTrans) or 1

	transformhelper.setLocalScale(self._goCount.transform, self.countBgScale, scale or self.countBgScale / parentScale, self.countBgScale)

	self._txtCount.fontSize = self.fontSize * (scale or 1 / parentScale)
end

function OdysseyItemIcon:setShowCountState(showCountState)
	gohelper.setActive(self._goCount, showCountState)
	gohelper.setActive(self._txtCount.gameObject, showCountState)
end

function OdysseyItemIcon:destroy()
	self:__onDispose()
	self._simageIcon:UnLoadImage()
end

return OdysseyItemIcon
