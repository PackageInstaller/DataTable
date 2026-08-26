-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeHeroTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeHeroTipsView", package.seeall)

local ArcadeHeroTipsView = class("ArcadeHeroTipsView", ArcadeTipsChildViewBase)

function ArcadeHeroTipsView:init(go)
	self.viewGO = go
	self._txtname = gohelper.findChildText(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#txt_name")
	self._gohp = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#go_hp")
	self._gohpItem = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#go_hp/go_hpitem")
	self._gomonster = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/monster")
	self._simagemonstericon = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/monster/mask/simage_icon")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/simage_icon")
	self._gobase = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#go_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#go_base/go_baseitem")
	self._txtdesc = gohelper.findChildText(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHeroTipsView:addEventListeners()
	return
end

function ArcadeHeroTipsView:removeEventListeners()
	return
end

function ArcadeHeroTipsView:_editableInitView()
	ArcadeHeroTipsView.super._editableInitView(self)

	self._attrItemList = self:getUserDataTb_()
	self._hpItemList = self:getUserDataTb_()

	gohelper.setActive(self._gobase, true)
	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._gohpItem, false)
	gohelper.setActive(self._gomonster, false)
	gohelper.setActive(self._simageheroicon.gameObject, true)
end

function ArcadeHeroTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNewMonster = false

	if self._isInSide then
		if not self._entityType or self._entityType ~= mo.entityType or not self._uid or self._uid ~= mo.uid then
			self._showNewMonster = true
		end

		self._entityType = mo.entityType
		self._uid = mo.uid
		self._entityMO = ArcadeGameModel.instance:getMOWithType(self._entityType, self._uid)
	else
		if not self._heroMo or mo.heroMo and self._heroMo.id ~= mo.heroMo.id then
			self._showNewMonster = true
		end

		self._heroMo = mo.heroMo
	end

	ArcadeHeroTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeHeroTipsView:isPlayOpenAnim()
	return self._showNewMonster or self._isChange
end

function ArcadeHeroTipsView:refreshView()
	local name, desc, icon

	if self._isInSide then
		if self._entityMO then
			name = self._entityMO:getName()
			desc = self._entityMO:getDesc()
			icon = self._entityMO:getIcon()
		end
	else
		if not self._heroMo then
			return
		end

		name = self._heroMo.co.name
		desc = self._heroMo.co.desc
		icon = self._heroMo.handbookMo:getIcon()
	end

	self._txtname.text = name
	self._txtdesc.text = desc

	if string.nilorempty(icon) then
		gohelper.setActive(self._simageheroicon, false)
		gohelper.setActive(self._gomonster, false)
	else
		local isUseImg = false

		if self._isInSide then
			isUseImg = self._entityMO and self._entityMO:getTipIsUseImg()
		end

		local iconPath = ResUrl.getEliminateIcon(icon)

		if isUseImg then
			self._simagemonstericon:LoadImage(iconPath, self.onLoadImgFinished, self)
		else
			self._simageheroicon:LoadImage(iconPath)
		end

		gohelper.setActive(self._gomonster, isUseImg)
		gohelper.setActive(self._simageheroicon, not isUseImg)
	end

	self:_refreshAttribute()
	self:_refreshHp()
end

function ArcadeHeroTipsView:onLoadImgFinished()
	if not self._simagemonstericon then
		return
	end

	local trans = self._simagemonstericon.transform

	self._simagemonstericon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	if self._entityMO then
		local posArr = self._entityMO:getImgOffsetArr()
		local posX = posArr and tonumber(posArr[1])
		local posY = posArr and tonumber(posArr[2])

		if posX and posY then
			transformhelper.setLocalPosXY(trans, posX, posY)
		end

		if self._entityMO then
			local scaleArr = self._entityMO:getImgScaleArr()
			local scaleX = scaleArr and tonumber(scaleArr[1])
			local scaleY = scaleArr and tonumber(scaleArr[2])

			if posX and posY then
				transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
			end
		end
	end
end

function ArcadeHeroTipsView:_refreshHp()
	if self._isInSide then
		if self._entityMO then
			local isHaveHpBar = self._entityMO:getIsHaveHPBar()

			if isHaveHpBar then
				local curHp = self._entityMO:getHp()
				local hpCap = self._entityMO:getAttributeValue(ArcadeGameEnum.BaseAttr.hpCap) or 0
				local maxShowCount = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.MaxShowHpCount, true)
				local showHpCount = math.min(hpCap, maxShowCount)

				for i = 1, showHpCount do
					local item = self:_getHpItem(i)
					local belongHpSeqIndex = ArcadeGameHelper.getHPSeqIndex(curHp, showHpCount, i)

					if belongHpSeqIndex and belongHpSeqIndex >= 0 then
						local imgIndex = ArcadeConfig.instance:getHpColorImgIndex(belongHpSeqIndex)
						local img = string.format("v3a3_eliminate_heart_%s", imgIndex)

						UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imgIcon, img)
						gohelper.setActive(item.golight, true)
					else
						gohelper.setActive(item.golight, false)
					end

					gohelper.setActive(item.go, true)
				end

				for i = showHpCount + 1, #self._hpItemList do
					local item = self._hpItemList[i]

					if item then
						gohelper.setActive(item.go, false)
					end
				end
			end

			gohelper.setActive(self._gohp, isHaveHpBar)
		end
	else
		local hp = self._heroMo.handbookMo:getHp() or 0
		local layer = (math.ceil(hp / ArcadeEnum.HeartShowCount) - 1) % #ArcadeEnum.HeartIcon + 1
		local index = (hp - 1) % ArcadeEnum.HeartShowCount + 1

		for i = 1, ArcadeEnum.HeartShowCount do
			local item = self:_getHpItem(i)
			local iconIndex = i <= index and layer or layer - 1

			if iconIndex > 0 then
				local icon = ArcadeEnum.HeartIcon[iconIndex]

				UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imgIcon, icon)
			end

			gohelper.setActive(item.imgIcon.gameObject, iconIndex > 0)
			gohelper.setActive(item.go.gameObject, true)
		end
	end
end

function ArcadeHeroTipsView:_getHpItem(index)
	local item = self._hpItemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gohpItem, "hp_" .. index)

		item.go = go
		item.imgIcon = gohelper.findChildImage(go, "light")
		item.golight = gohelper.findChild(go, "light")
		self._hpItemList[index] = item
	end

	return item
end

function ArcadeHeroTipsView:_refreshAttribute()
	if self._isInSide then
		if self._entityMO then
			local isHaveHpBar = self._entityMO:getIsHaveHPBar()

			if isHaveHpBar then
				local showAttrList = {
					{
						id = ArcadeGameEnum.BaseAttr.attack
					},
					{
						id = ArcadeGameEnum.BaseAttr.defense
					}
				}
				local lastAttr

				if self._entityType == ArcadeGameEnum.EntityType.Character then
					lastAttr = {
						isRes = true,
						id = ArcadeGameEnum.CharacterResource.RespawnTimes
					}
				elseif self._entityType == ArcadeGameEnum.EntityType.Monster then
					lastAttr = {
						id = ArcadeGameEnum.BaseAttr.hp
					}
				end

				if lastAttr then
					table.insert(showAttrList, lastAttr)
				end

				gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseitem)
				gohelper.setActive(self._gobase, true)
			else
				gohelper.setActive(self._gobase, false)
			end
		end
	else
		local attrList = self._heroMo:getAttribute()

		for type, item in pairs(self._attrItemList) do
			local isShow = attrList and attrList[type]

			gohelper.setActive(item.go, isShow)
		end

		if attrList then
			for type, attr in pairs(attrList) do
				local item = self:_getAttributeItem(type)

				item.txtNum.text = attr:getValue()

				local param = ArcadeEnum.AttributeParams[type]

				UISpriteSetMgr.instance:setV3a3EliminateSprite(item.imgIcon, param.Icon, true)
				gohelper.setActive(item.go, true)
				gohelper.setSibling(item.go, param.Sort)
			end
		end
	end
end

function ArcadeHeroTipsView:_onCreateAttrItem(obj, data, index)
	local id = data.id
	local imagebase = gohelper.findChildImage(obj, "#txt_num/#image_base")
	local icon = ArcadeConfig.instance:getAttributeIcon(id)

	UISpriteSetMgr.instance:setV3a3EliminateSprite(imagebase, icon, true)

	local value = 0
	local txtNum = gohelper.findChildText(obj, "#txt_num")

	if self._entityMO then
		if data.isRes then
			if self._entityType == ArcadeGameEnum.EntityType.Character then
				value = self._entityMO:getResourceCount(id)
			end
		else
			value = id == ArcadeGameEnum.BaseAttr.hp and self._entityMO:getHp() or self._entityMO:getAttributeValue(id)
		end
	end

	txtNum.text = value
end

function ArcadeHeroTipsView:_getAttributeItem(type)
	local item = self._attrItemList[type]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gobaseitem, "attr_" .. type)

		item.go = go
		item.txtNum = gohelper.findChildText(go, "#txt_num")
		item.imgIcon = gohelper.findChildImage(go, "#txt_num/#image_base")
		self._attrItemList[type] = item
	end

	return item
end

function ArcadeHeroTipsView:onDestroy()
	self._simageheroicon:UnLoadImage()
	self._simagemonstericon:UnLoadImage()
end

return ArcadeHeroTipsView
