-- chunkname: @modules/ugui/icon/common/CommonItemIcon.lua

module("modules.ugui.icon.common.CommonItemIcon", package.seeall)

local CommonItemIcon = class("CommonItemIcon", ListScrollCell)

function CommonItemIcon:init(go)
	self.go = go
	self.tr = go.transform
	self._countbg = gohelper.findChild(go, "countbg")
	self._txtQuantity = gohelper.findChildText(go, "count")
	self._icon = gohelper.findChildSingleImage(go, "icon")
	self._goheadiconmask = gohelper.findChild(go, "headiconmask")
	self._playerheadicon = gohelper.findChildSingleImage(go, "headiconmask/playerheadicon")
	self._iconImage = self._icon:GetComponent(gohelper.Type_Image)
	self._txtequiplv = gohelper.findChildText(go, "#txt_equiplv")
	self._iconbg = gohelper.findChildImage(go, "quality")
	self._nameTxt = gohelper.findChildText(go, "txt")
	self._deadline = gohelper.findChild(go, "deadline")
	self._deadline1 = gohelper.findChild(go, "deadline1")
	self._imagetimebg = gohelper.findChildImage(self._deadline, "timebg")
	self._imagetimeicon = gohelper.findChildImage(self._deadline, "timetxt/timeicon")
	self._timetxt = gohelper.findChildText(self._deadline, "timetxt")
	self._formattxt = gohelper.findChildText(self._deadline, "timetxt/format")
	self._deadlineEffect = gohelper.findChild(self._deadline, "#effect")
	self._goequipcarerr = gohelper.findChild(go, "click/#go_equipcareer")
	self._gorefinebg = gohelper.findChild(go, "click/#go_equipcareer/#go_refinebg")
	self._goboth = gohelper.findChild(go, "click/#go_equipcareer/#go_both")
	self._txtrefinelv = gohelper.findChildText(go, "click/#go_equipcareer/#txt_refinelv")
	self._imagecareer = gohelper.findChildImage(go, "click/#go_equipcareer/#go_both/#image_carrer")
	self._goframe = gohelper.findChild(go, "headiconmask/#go_frame")
	self._goframenode = gohelper.findChild(go, "headiconmask/#go_framenode")
	self._goAddition = gohelper.findChild(go, "turnback")
	self._click = gohelper.getClick(go)
	self._ani = go:GetComponent(typeof(UnityEngine.Animator))
	self._ani.enabled = false
	self._effectGos = {}
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	self._effectLoader:startLoad(self.LoadEffect, self)

	self._isEnableClick = true
	self._isShowCount = true
	self._refreshDeadline = false
	self.canShowDeadLine = true
	self._inPack = false

	gohelper.setActive(self._txtequiplv.gameObject, false)

	self._frameloader = MultiAbLoader.New()
end

function CommonItemIcon:LoadEffect()
	if gohelper.isNil(self._iconbg) then
		if self._effectLoader then
			self._effectLoader:dispose()

			self._effectLoader = nil
		end

		return
	end

	local prefabGO = self._effectLoader:getFirstAssetItem():GetResource()

	self._effect = gohelper.clone(prefabGO, self._iconbg.gameObject, "itemEffect")

	for i = 4, 5 do
		self._effectGos[i] = gohelper.findChild(self._effect, "effect" .. tostring(i))
	end

	if self._showeffectrare then
		self:showEffect(self._showeffectrare)
	end
end

function CommonItemIcon:playAnimation(ani)
	self._ani.enabled = true

	if ani then
		self._ani:Play(ani, 0, 0)
	else
		self._ani:Play("commonitemicon_in")
	end
end

function CommonItemIcon:setAlpha(iconAlpha, bgAlpha)
	self.iconAlpha = iconAlpha

	local rare = self:getRare()

	UISpriteSetMgr.instance:setCommonSprite(self._iconbg, "bgequip" .. tostring(ItemEnum.Color[rare]), nil, bgAlpha)

	if self._iconImage.sprite then
		local color = self._iconImage.color

		color.a = iconAlpha
		self._iconImage.color = color
	end
end

function CommonItemIcon:getRare()
	if not self._config.rare then
		return self._config.rare
	end
end

function CommonItemIcon:setItemColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._goframe:GetComponent(gohelper.Type_Image), color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._playerheadicon:GetComponent(gohelper.Type_Image), color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._iconbg, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._iconImage, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._countbg:GetComponent(gohelper.Type_Image), color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtQuantity, color or "#EBE6E6")
end

function CommonItemIcon:setAutoPlay(autoPlay)
	self._ani.enabled = autoPlay
end

function CommonItemIcon:setWidth(width)
	recthelper.setWidth(self.go.transform, width)
end

function CommonItemIcon:setHeight(height)
	recthelper.setHeight(self.go.transform, height)
end

function CommonItemIcon:setWidtAndHeight(value)
	recthelper.setWidth(self.go.transform, value)
	recthelper.setHeight(self.go.transform, value)
end

function CommonItemIcon:getQuality()
	return self._iconbg
end

function CommonItemIcon:getIcon()
	return self._icon
end

function CommonItemIcon:getCountBg()
	return self._countbg
end

function CommonItemIcon:getCount()
	return self._txtQuantity
end

function CommonItemIcon:getDeadline1()
	return self._deadline1
end

function CommonItemIcon:setCountText(str)
	self._txtQuantity.text = str
end

function CommonItemIcon:addEventListeners()
	self._click:AddClickListener(self._onClick, self)
end

function CommonItemIcon:removeEventListeners()
	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end
end

function CommonItemIcon:setIconWithAndHeight(value)
	recthelper.setWidth(self._icon.transform, value)
	recthelper.setHeight(self._icon.transform, value)
end

function CommonItemIcon:isEnableClick(flag)
	self._isEnableClick = flag
end

function CommonItemIcon:isShowQuality(flag)
	gohelper.setActive(self._iconbg.gameObject, flag)
	gohelper.setActive(self._effect, self._isCfgNeedVfx and flag)
end

function CommonItemIcon:isShowEffect(flag)
	if flag then
		self._showeffectrare = self._showeffectrare or false
	end

	gohelper.setActive(self._effect, self._isCfgNeedVfx and flag)
end

function CommonItemIcon:isShowName(flag)
	gohelper.setActive(self._nameTxt.gameObject, flag)
end

function CommonItemIcon:isShowCount(flag)
	self._isShowCount = flag

	gohelper.setActive(self._txtQuantity.gameObject, flag)
	gohelper.setActive(self._countbg.gameObject, flag)
end

function CommonItemIcon:isShowAddition(flag)
	gohelper.setActive(self._goAddition, flag)
end

function CommonItemIcon:isShowRefinelv(flag)
	gohelper.setActive(self._txtrefinelv.gameObject, flag)
end

function CommonItemIcon:isShowEquiplv(flag)
	gohelper.setActive(self._txtequiplv.gameObject, flag)
end

function CommonItemIcon:showName(nameText)
	gohelper.setActive(self._nameTxt.gameObject, false)

	nameText = nameText or self._nameTxt

	gohelper.setActive(nameText.gameObject, true)

	local nameLength = GameUtil.utf8len(self._config.name) > 7 and 12 or 14

	nameText.text = GameUtil.getBriefName(self._config.name, nameLength)
end

function CommonItemIcon:setNameType(str)
	self._nameTxt.text = string.format(str, self._config.name)
end

function CommonItemIcon:setScale(scale)
	transformhelper.setLocalScale(self.tr, scale, scale, scale)
end

function CommonItemIcon:setItemIconScale(scale)
	transformhelper.setLocalScale(self._icon.transform, scale, scale, scale)
end

function CommonItemIcon:setCountFontSize(fontsize)
	self._scale = self._scale or fontsize / self._txtQuantity.fontSize

	transformhelper.setLocalScale(self._countbg.transform, 1, self._scale, 1)

	self._txtQuantity.fontSize = fontsize
end

function CommonItemIcon:setInPack(value)
	self._inPack = value
end

function CommonItemIcon:setConsume(consume)
	self._isConsume = consume
end

function CommonItemIcon:setCanShowDeadLine(canShowDeadLine)
	self.canShowDeadLine = canShowDeadLine

	self:showNormalDeadline()
end

function CommonItemIcon:showNormalDeadline()
	gohelper.setActive(self._deadline, false)

	if self.canShowDeadLine then
		gohelper.setActive(self._deadline1, self:isExpiredItem())
	else
		gohelper.setActive(self._deadline1, false)
	end
end

function CommonItemIcon:SetCountLocalY(localY)
	if self._txtQuantity then
		recthelper.setAnchorY(self._txtQuantity.transform, localY)
	end
end

function CommonItemIcon:SetCountBgLocalY(localY)
	if self._countbg then
		recthelper.setAnchorY(self._countbg.transform, localY)
	end
end

function CommonItemIcon:SetCountBgHeight(height)
	if self._countbg then
		recthelper.setHeight(self._countbg.transform, height)
	end
end

function CommonItemIcon:refreshDeadline(notrealtime)
	gohelper.setActive(self._deadline, true)
	gohelper.setActive(self._deadline1, false)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	self._lasthasday = nil

	if not self:_isItemHasDeadline() then
		gohelper.setActive(self._deadline, false)
	else
		self._refreshDeadline = true

		self:_onRefreshDeadline()

		if not notrealtime then
			TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
		end
	end
end

function CommonItemIcon:_isItemHasDeadline()
	if self._itemType == MaterialEnum.MaterialType.Item then
		if not self._expireTime or self._expireTime == "" or self._expireTime == 0 then
			return false
		end

		if self._config.isTimeShow == 0 then
			return false
		end

		return true
	elseif self._itemType == MaterialEnum.MaterialType.PowerPotion then
		return self._config.expireType ~= 0 and self._expireTime ~= 0
	elseif self._itemType == MaterialEnum.MaterialType.NewInsight then
		return self._expireTime > 0 and self._expireTime ~= ItemEnum.NoExpiredNum
	elseif self._itemType == MaterialEnum.MaterialType.TalentItem then
		return self._expireTime ~= 0
	end
end

function CommonItemIcon:_isLimitPowerPotion()
	if not self._itemUid and self._config.expireType == 1 then
		return true
	end

	return false
end

function CommonItemIcon:_onRefreshDeadline()
	self._hasday = false

	if not self:_isItemHasDeadline() then
		gohelper.setActive(self._deadline, false)

		return
	end

	local limitSec = self._expireTime - ServerTime.now()

	if limitSec <= 0 then
		if self._itemType == MaterialEnum.MaterialType.PowerPotion then
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(self._deadline, false)

			return
		elseif self._itemType == MaterialEnum.MaterialType.NewInsight then
			return
		elseif self._itemType == MaterialEnum.MaterialType.TalentItem then
			return
		end
	end

	self._timetxt.text, self._formattxt.text, self._hasday = TimeUtil.secondToRoughTime(limitSec, true)

	if self._itemType == MaterialEnum.MaterialType.NewInsight and self._config.expireHours ~= ItemEnum.NoExpiredNum or self._itemType == MaterialEnum.MaterialType.PowerPotion or self._itemType == MaterialEnum.MaterialType.TalentItem then
		gohelper.setActive(self._deadline, true)
	else
		gohelper.setActive(self._deadline, self._config.isTimeShow == 1)
	end

	if self._lasthasday == nil or self._lasthasday ~= self._hasday then
		UISpriteSetMgr.instance:setCommonSprite(self._imagetimebg, self._hasday and "daojishi_01" or "daojishi_02")
		UISpriteSetMgr.instance:setCommonSprite(self._imagetimeicon, self._hasday and "daojishiicon_01" or "daojishiicon_02")
		SLFramework.UGUI.GuiHelper.SetColor(self._timetxt, self._hasday and "#98D687" or "#E99B56")
		SLFramework.UGUI.GuiHelper.SetColor(self._formattxt, self._hasday and "#98D687" or "#E99B56")
		gohelper.setActive(self._deadlineEffect, not self._hasday)

		self._lasthasday = self._hasday
	end
end

function CommonItemIcon:showStackableNum()
	if (not self._config.isStackable or self._config.isStackable == 1) and self._itemQuantity >= 1 then
		self._txtQuantity.text = self:_getQuantityText(self._itemQuantity)

		gohelper.setActive(self._countbg, true)
	else
		self._txtQuantity.text = ""

		gohelper.setActive(self._countbg, false)
	end
end

function CommonItemIcon:showEffect(rare)
	self._showeffectrare = rare

	if self._isCfgNeedVfx then
		gohelper.setActive(self._effect, self._isCfgNeedVfx)

		if self._isCfgNeedVfx and self._effectGos and tabletool.len(self._effectGos) > 0 then
			for i = 4, 5 do
				gohelper.setActive(self._effectGos[i], i == rare)
			end
		end
	end
end

function CommonItemIcon:setCantJump(cantJump)
	self._cantJump = cantJump
end

function CommonItemIcon:setRecordFarmItem(recordFarmItem)
	self._recordFarmItem = recordFarmItem
end

function CommonItemIcon:setQuantityColor(quantityColor)
	self._quantityColor = quantityColor
end

function CommonItemIcon:setQuantityText(quantityColor)
	local ownQuantity = ItemModel.instance:getItemQuantity(self._itemType, self._itemId)
	local quantityStr = GameUtil.numberDisplay(self._itemQuantity)

	if self._itemType == MaterialEnum.MaterialType.Currency then
		if ownQuantity < self._itemQuantity then
			quantityStr = string.format("<color=%s>%s</color>", quantityColor, quantityStr)
		end
	else
		local ownQuantityStr = GameUtil.numberDisplay(ownQuantity)

		quantityStr = ownQuantity < self._itemQuantity and string.format("<color=%s>%s</color>/%s", quantityColor, ownQuantityStr, quantityStr) or string.format("%s/%s", ownQuantityStr, quantityStr)
	end

	self._txtQuantity.text = quantityStr
end

function CommonItemIcon:showStackableNum2(countbg, txtQuantity)
	countbg = countbg or self._countbg
	txtQuantity = txtQuantity or self._txtQuantity

	if (self._itemType == MaterialEnum.MaterialType.Hero or self._itemType == MaterialEnum.MaterialType.HeroSkin or self._itemType == MaterialEnum.MaterialType.PlayerCloth or self._itemType == MaterialEnum.MaterialType.PlayerCloth) and self._itemQuantity <= 1 then
		txtQuantity.text = ""

		gohelper.setActive(countbg, false)
	elseif (not self._config.isStackable or self._config.isStackable == 1 or self._itemType == MaterialEnum.MaterialType.Equip or tonumber(self._config.subType) == ItemEnum.SubType.Portrait) and self._itemQuantity then
		txtQuantity.text = self:_getQuantityText(self._itemQuantity)

		gohelper.setActive(countbg, true)
	else
		txtQuantity.text = ""

		gohelper.setActive(countbg, false)
	end
end

function CommonItemIcon:_getQuantityText(quantity)
	if self._quantityColor then
		return string.format("<color=%s>%s</color>", self._quantityColor, GameUtil.numberDisplay(quantity))
	else
		return GameUtil.numberDisplay(quantity)
	end
end

function CommonItemIcon:setMOValue(materilType, materilId, quantity, materilUid, isIcon, extraParam)
	self._itemType = tonumber(materilType)
	self._itemId = materilId
	self._itemQuantity = tonumber(quantity)
	self._itemUid = materilUid

	local specificIcon = extraParam and extraParam.specificIcon
	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, isIcon)

	self._config = config

	if self._itemType == MaterialEnum.MaterialType.PowerPotion then
		local powerdeadline = ItemPowerModel.instance:getPowerItemDeadline(self._itemUid)

		self._expireTime = powerdeadline and powerdeadline > 0 and ItemConfig.instance:getPowerItemCo(self._itemId).expireType ~= 0 and powerdeadline or 0
	elseif self._itemType == MaterialEnum.MaterialType.TalentItem then
		local talentdeadline = ItemTalentModel.instance:getTalentItemDeadline(self._itemUid)

		self._expireTime = talentdeadline and talentdeadline > 0 and talentdeadline or 0
	elseif self._itemType == MaterialEnum.MaterialType.NewInsight then
		if self._itemUid then
			self._expireTime = ItemInsightModel.instance:getInsightItemDeadline(self._itemUid)
		else
			local itemCfg = ItemConfig.instance:getInsightItemCo(tonumber(self._itemId))

			self._expireTime = itemCfg.expireHours
		end
	elseif self._itemType == MaterialEnum.MaterialType.SpecialExpiredItem then
		if self._itemUid then
			local deadline = ItemExpireModel.instance:getExpireItemDeadline(self._itemUid)

			self._expireTime = deadline and deadline > 0 and ItemConfig.instance:getPowerItemCo(self._itemId).expireType ~= 0 and deadline or 0
		end
	else
		self._expireTime = string.nilorempty(self._config.expireTime) and 0 or TimeUtil.stringToTimestamp(self._config.expireTime)
	end

	if specificIcon then
		icon = specificIcon
	end

	local isPortrait = tonumber(config.subType) == ItemEnum.SubType.Portrait

	if string.nilorempty(icon) then
		logError("icon为空")
	else
		if not self._iconImage.sprite then
			self:_setIconAlpha(0)
		end

		if isPortrait then
			self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._playerheadicon)

			self._liveHeadIcon:setLiveHead(config.id, nil, nil, function(self, liveIcon)
				if not self.iconAlpha then
					liveIcon:setAlpha(self.iconAlpha)
				end
			end, self)

			local effectArr = string.split(self._config.effect, "#")

			if #effectArr > 1 and self._config.id == tonumber(effectArr[#effectArr]) then
				gohelper.setActive(self._goframe, false)
				gohelper.setActive(self._goframenode, true)

				if not self.frame and not self.isloading then
					self.isloading = true

					local framePath = "ui/viewres/common/effect/frame.prefab"

					self._frameloader:addPath(framePath)
					self._frameloader:startLoad(self._onFrameLoadCallback, self)
				end
			else
				gohelper.setActive(self._goframe, true)
				gohelper.setActive(self._goframenode, false)
			end
		else
			self._icon:LoadImage(icon, self._loadImageFinish, self)
		end
	end

	self:refreshItemEffect()

	if tonumber(materilType) == MaterialEnum.MaterialType.Hero and not isIcon or tonumber(materilType) == MaterialEnum.MaterialType.HeroSkin or tonumber(materilType) == MaterialEnum.MaterialType.Equip then
		recthelper.setWidth(self._icon.transform, 248)
		recthelper.setHeight(self._icon.transform, 248)
		self:_setIconPos(0, 0)
	elseif tonumber(materilType) == MaterialEnum.MaterialType.BlockPackage or tonumber(materilType) == MaterialEnum.MaterialType.SpecialBlock then
		self:_setIconPos(-1, 12.5)
	else
		recthelper.setWidth(self._icon.transform, 256)
		recthelper.setHeight(self._icon.transform, 256)
		self:_setIconPos(0, -7)
	end

	if config.rare then
		if not config.rare then
			local rare = 5

			self:setIconBg("bgequip" .. tostring(ItemEnum.Color[rare]))

			self._isCfgNeedVfx = ItemModel.canShowVfx(self._itemType, config, rare)

			gohelper.setActive(self._goheadiconmask.gameObject, isPortrait)
			gohelper.setActive(self._icon.gameObject, not isPortrait)
			self:showStackableNum2()
			self:refreshEquipInfo()

			if self._inPack then
				self:refreshDeadline()
			else
				self:showNormalDeadline()
			end

			self:showEffect(rare)
		end
	end
end

function CommonItemIcon:setRoomBuildingLevel(roomBuildingLevel)
	self._roomBuildingLevel = roomBuildingLevel
end

function CommonItemIcon:setSpecificIcon(icon)
	if string.nilorempty(icon) or not self._icon then
		return
	end

	self._icon:UnLoadImage()
	self._icon:LoadImage(icon, self._loadImageFinish, self)
end

function CommonItemIcon:refreshItemEffect()
	local hasEffect = ItemEnum.ItemIconEffect[string.format("%s#%s", self._itemType, self._itemId)]

	if hasEffect then
		local effectPath = string.format("ui/viewres/common/effect/propitem_%s_%s.prefab", self._itemType, self._itemId)

		if effectPath == self.iconEffectPath then
			return
		end

		if self.iconEffectGo then
			gohelper.destroy(self.iconEffectGo)

			self.iconEffectGo = nil
		end

		self.iconEffectPath = effectPath

		if self._iconEffectloader then
			self._iconEffectloader:dispose()

			self._iconEffectloader = nil
		end

		self._iconEffectloader = MultiAbLoader.New()

		self._iconEffectloader:addPath(effectPath)
		self._iconEffectloader:startLoad(self._onIconEffectLoadCallback, self)
	else
		gohelper.setActive(self.iconEffectGo, false)
	end
end

function CommonItemIcon:_onIconEffectLoadCallback()
	if not self._iconEffectloader then
		return
	end

	local path = self.iconEffectPath
	local assetItem = self._iconEffectloader:getAssetItem(path)
	local mainPrefab = assetItem:GetResource(path)

	self.iconEffectGo = gohelper.clone(mainPrefab, self._icon.gameObject, path)
end

function CommonItemIcon:_setIconPos(posX, posY)
	if self._iconPosX == posX and self._iconPosY == posY then
		return
	end

	self._iconPosX = posX
	self._iconPosY = posY

	transformhelper.setLocalPosXY(self._icon.transform, posX, posY)
end

function CommonItemIcon:setIconBg(bg)
	UISpriteSetMgr.instance:setCommonSprite(self._iconbg, bg)
end

function CommonItemIcon:setItemOffset(offsetX, offsetY)
	recthelper.setAnchor(self._icon.transform, offsetX or -1, offsetY or 0)
end

function CommonItemIcon:_onFrameLoadCallback()
	self.isloading = false

	local framePrefab = self._frameloader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")
end

function CommonItemIcon:_setFrameMaskable(state)
	local framemask = gohelper.findChild(self._goframenode, "frame/quxian")

	if framemask then
		local framemaskImage = framemask:GetComponent(gohelper.Type_Image)

		framemaskImage.maskable = state
	end
end

function CommonItemIcon:_loadImageFinish()
	self:_setIconAlpha(self.iconAlpha or 1)

	if self._icon.gameObject.activeSelf then
		gohelper.setActive(self._icon, false)
		gohelper.setActive(self._icon, true)
	end
end

function CommonItemIcon:_setIconAlpha(value)
	local color = self._iconImage.color

	color.a = value
	self._iconImage.color = color
end

function CommonItemIcon:onUpdateMO(mo)
	self:setMOValue(mo.materilType, mo.materilId, mo.quantity)
end

function CommonItemIcon:refreshEquipInfo()
	if self._itemType == MaterialEnum.MaterialType.Equip then
		local equipCo = EquipConfig.instance:getEquipCo(tonumber(self._itemId))
		local isNormalEquip = EquipHelper.isNormalEquip(equipCo)

		if isNormalEquip then
			gohelper.setActive(self._goequipcarerr, true)

			self._txtrefinelv.text = 1

			local equipCareer = EquipHelper.getEquipSkillCareer(equipCo.id, 1)
			local isHasSkillBaseDesc = EquipHelper.isHasSkillBaseDesc(self._config.id, (not self._refineLv or nil) and 1)

			if not string.nilorempty(equipCareer) and isHasSkillBaseDesc then
				local skillCareerIconName = EquipHelper.getSkillCarrerSpecialIconName(equipCareer)

				UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, skillCareerIconName)
				gohelper.setActive(self._gorefinebg, false)
				gohelper.setActive(self._goboth, true)
			else
				gohelper.setActive(self._gorefinebg, true)
				gohelper.setActive(self._goboth, false)
			end

			gohelper.setActive(self._txtQuantity.gameObject, false)
			gohelper.setActive(self._countbg.gameObject, false)
			gohelper.setActive(self._txtequiplv.gameObject, true)

			self._txtequiplv.text = "Lv. 1"
		else
			gohelper.setActive(self._goequipcarerr, false)
		end
	else
		gohelper.setActive(self._txtequiplv.gameObject, false)
		gohelper.setActive(self._txtQuantity.gameObject, true)
		gohelper.setActive(self._goequipcarerr, false)
	end
end

function CommonItemIcon:hideEquipLvAndCount()
	if self._itemType == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(self._txtequiplv.gameObject, false)

		local equipCo = EquipConfig.instance:getEquipCo(tonumber(self._itemId))
		local isNormalEquip = EquipHelper.isNormalEquip(equipCo)

		gohelper.setActive(self._txtequiplv.gameObject, false)
		gohelper.setActive(self._goequipcarerr, false)
		self:isShowCount(not isNormalEquip)
	end
end

function CommonItemIcon:setGetMask(isMask)
	SLFramework.UGUI.GuiHelper.SetColor(self._iconImage, isMask and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._iconbg, isMask and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtQuantity, isMask and "#525252" or "#EBE6E6")
	ZProj.UGUIHelper.SetColorAlpha(self._countbg:GetComponent(gohelper.Type_Image), isMask and 0.8 or 1)
end

function CommonItemIcon:onDestroy()
	if self._icon then
		self._icon:UnLoadImage()

		self._icon = nil
	end

	if self._playerheadicon then
		self._playerheadicon:UnLoadImage()

		self._playerheadicon = nil
	end

	if self._refreshDeadline then
		TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	if self._frameloader then
		self._frameloader:dispose()

		self._frameloader = nil
	end

	if self._iconEffectloader then
		self._iconEffectloader:dispose()

		self._iconEffectloader = nil
	end
end

function CommonItemIcon:customOnClickCallback(callback, params, targetParam)
	self._customCallback = callback
	self.params = params
	self._targetParam = targetParam
end

function CommonItemIcon:setOnBeforeClickCallback(callback, callbackObj, param)
	self.onBeforeClickCallback = callback
	self.onBeforeClickCallbackObj = callbackObj
	self.onBeforeClickParam = param
end

function CommonItemIcon:setJumpFinishCallback(callback, callbackObj, param)
	self.jumpFinishCallback = callback
	self.jumpFinishCallbackObj = callbackObj
	self.jumpFinishCallbackParam = param
end

function CommonItemIcon:setInterceptClick(callback, callbackObj)
	self.interceptCallback = callback
	self.interceptCallbackObj = callbackObj
end

function CommonItemIcon:_onClick()
	if not self._isEnableClick then
		return
	end

	if self.interceptCallback and self.interceptCallback(self.interceptCallbackObj) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if self._customCallback then
		return self._customCallback(self.params, self._targetParam)
	end

	if self.onBeforeClickCallback then
		self.onBeforeClickCallback(self.onBeforeClickCallbackObj, self.onBeforeClickParam, self)
	end

	local extraParam = {
		roomBuildingLevel = self._roomBuildingLevel
	}

	MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId, self._inPack, self._itemUid, self._cantJump, self._recordFarmItem, nil, self._itemQuantity, self._isConsume, self.jumpFinishCallback, self.jumpFinishCallbackObj, self.jumpFinishCallbackParam, extraParam)
end

function CommonItemIcon:isExpiredItem()
	return self:_isItemHasDeadline() or self:_isLimitPowerPotion()
end

return CommonItemIcon
