-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyEquipItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyEquipItem", package.seeall)

local OdysseyEquipItem = class("OdysseyEquipItem", ListScrollCellExtend)

function OdysseyEquipItem:onInitView()
	self._imageRare = gohelper.findChildImage(self.viewGO, "rare")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "icon")
	self._goCount = gohelper.findChild(self.viewGO, "countbg")
	self._txtCount = gohelper.findChildText(self.viewGO, "count")
	self._goSuit = gohelper.findChild(self.viewGO, "suit")
	self._imageSuit = gohelper.findChildImage(self.viewGO, "suit/image_suitIcon")
	self._goHero = gohelper.findChild(self.viewGO, "hero")
	self._simageHeroIcon = gohelper.findChildSingleImage(self.viewGO, "hero/simage_heroIcon")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "click")
	self._goSelect = gohelper.findChild(self.viewGO, "go_select")
	self._goReddot = gohelper.findChild(self.viewGO, "go_reddot")
	self._goExpIcon = gohelper.findChild(self.viewGO, "expIcon")
	self._goTalentIcon = gohelper.findChild(self.viewGO, "talentIcon")
	self.fontSize = self._txtCount.fontSize
	self.countBgScale = transformhelper.getLocalScale(self._goCount.transform)
	self._goUnknowSuitIcon = gohelper.findChild(self.viewGO, "unknowSuitIcon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyEquipItem:_editableInitView()
	self._enableDeselect = true

	self:hideIcon()
end

function OdysseyEquipItem:hideIcon()
	gohelper.setActive(self._goSuit, false)
	gohelper.setActive(self._goHero, false)
	gohelper.setActive(self._goExpIcon, false)
	gohelper.setActive(self._goTalentIcon, false)
	gohelper.setActive(self._goUnknowSuitIcon, false)
end

function OdysseyEquipItem:addEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function OdysseyEquipItem:removeEvents()
	self._btnClick:RemoveClickListener()
end

function OdysseyEquipItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	if self._isSelect then
		OdysseyItemModel.instance:setHasClickItem(self.mo.uid)
		gohelper.setActive(self._goReddot, false)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshBagReddot)
	end
end

function OdysseyEquipItem:onClick()
	logNormal("奥德赛道具点击 id: " .. tostring(self.itemId) .. "uid : " .. tostring(self.mo.uid))

	if self.itemConfig.type == OdysseyEnum.ItemType.Item then
		local haveItem = OdysseyItemModel.instance:getItemCount(self.itemId) > 0

		if haveItem == false then
			logNormal("奥德赛 任务道具数量不足")

			return
		end
	end

	if self._isSelect then
		local haveSelect = self._enableDeselect

		if haveSelect and self.bagType == OdysseyEnum.BagType.Bag then
			return
		end

		if haveSelect then
			self._view:selectCell(self._index, false)
		else
			self._view:selectCell(self._index, true)
		end

		OdysseyItemModel.instance:setHasClickItem(self.mo.uid)
		OdysseyController.instance:dispatchEvent(OdysseyEvent.OnEquipItemSelect, (not haveSelect or nil) and (self.mo or nil))
		gohelper.setActive(self._goReddot, false)
	end
end

function OdysseyEquipItem:onUpdateMO(mo)
	self.mo = mo
	self.bagType = mo.type

	local itemMo = mo.itemMo

	self.itemId = itemMo.id
	self.itemConfig = itemMo.config
	self.isNewFlag = itemMo:isNew()

	self:initItemInfo()
end

function OdysseyEquipItem:initItemInfo()
	gohelper.setActive(self._goSuit, (self.itemType == OdysseyEnum.ItemType.Equip or nil) and self.itemConfig and self.itemConfig.suitId > 0)

	if self.itemConfig.type == OdysseyEnum.ItemType.Item then
		local haveItem = OdysseyItemModel.instance:getItemCount(self.itemId) > 0

		gohelper.setActive(self._simageIcon, haveItem)
		gohelper.setActive(self._goUnknowSuitIcon, not haveItem)

		if haveItem then
			self._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.itemConfig.icon))
		end
	elseif self.itemConfig.type == OdysseyEnum.ItemType.Equip then
		gohelper.setActive(self._simageIcon, true)
		self._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(self.itemConfig.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageRare, "odyssey_item_quality" .. self.itemConfig.rare)

	local isHasClickItem = OdysseyItemModel.instance:isHasClickItem(self.mo.uid)

	gohelper.setActive(self._goReddot, not isHasClickItem and self.isNewFlag)
	self:setShowCountState(false)
	self:refreshItemEquipState()
	self:refreshEquipSuitState()
	self:setFontScale()
end

function OdysseyEquipItem:refreshItemEquipState()
	local showEquip = self.bagType == OdysseyEnum.BagType.FightPrepare and self.itemConfig.type == OdysseyEnum.ItemType.Equip
	local haveHero = false

	if showEquip then
		local curHeroGroupMo = OdysseyHeroGroupModel.instance:getCurHeroGroup()
		local equipInfo = curHeroGroupMo.odysseyEquipDic[self.mo.uid]

		if equipInfo then
			local heroId = equipInfo.heroId

			if heroId ~= 0 then
				local skinCo

				if heroId < 0 then
					local trialCo = lua_hero_trial.configDict[-heroId][0]

					skinCo = SkinConfig.instance:getSkinCo(trialCo.skin)
				else
					local heroMo = HeroModel.instance:getByHeroId(heroId)

					skinCo = SkinConfig.instance:getSkinCo(heroMo.skin)
				end

				if skinCo == nil then
					logError("奥德赛角色活动 角色皮肤表id为空：装备uid：" .. tostring(self.mo.uid))
				else
					haveHero = true

					local heroIconPath = ResUrl.getRoomHeadIcon(skinCo.headIcon)

					self._simageHeroIcon:LoadImage(heroIconPath)
				end
			end
		end
	end

	gohelper.setActive(self._goHero, showEquip and haveHero)
end

function OdysseyEquipItem:refreshEquipSuitState()
	local showSuit = self.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(self._goSuit, showSuit)

	if showSuit then
		local suitConfig = OdysseyConfig.instance:getEquipSuitConfig(self.itemConfig.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(self._imageSuit, suitConfig.icon)
	end
end

function OdysseyEquipItem:setFontScale(scale)
	local parentTrans = self.viewGO.transform.parent
	local parentScale = parentTrans and transformhelper.getLocalScale(parentTrans) or 1

	transformhelper.setLocalScale(self._goCount.transform, self.countBgScale, scale or self.countBgScale / parentScale, self.countBgScale)

	self._txtCount.fontSize = self.fontSize * (scale or 1 / parentScale)
end

function OdysseyEquipItem:setShowCountState(showCountState)
	gohelper.setActive(self._goCount, showCountState)
	gohelper.setActive(self._txtCount, showCountState)
end

return OdysseyEquipItem
