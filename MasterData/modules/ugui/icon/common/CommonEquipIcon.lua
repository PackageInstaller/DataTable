-- chunkname: @modules/ugui/icon/common/CommonEquipIcon.lua

module("modules.ugui.icon.common.CommonEquipIcon", package.seeall)

local CommonEquipIcon = class("CommonEquipIcon", ListScrollCellExtend)

function CommonEquipIcon:onInitView()
	self._imageBg = gohelper.findChildImage(self.viewGO, "bg")
	self._imagerare = gohelper.findChildImage(self.viewGO, "#image_rare")
	self._imagerare2 = gohelper.findChildImage(self.viewGO, "#image_rare2")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "mask/#simage_icon")
	self._iconImage = self._simageicon:GetComponent(gohelper.Type_Image)
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "#go_inteam/#image_heroicon")
	self._countbg = gohelper.findChild(self.viewGO, "layout/#go_num/countbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "layout/#go_num/#txt_num")
	self._gointeam = gohelper.findChild(self.viewGO, "#go_inteam")
	self._goselected = gohelper.findChild(self.viewGO, "#go_selected")
	self._golevel = gohelper.findChild(self.viewGO, "layout/#go_level")
	self._txtlevel = gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level")
	self._txtlevelEn = gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level/lv")
	self._gonum = gohelper.findChild(self.viewGO, "layout/#go_num")
	self.goclickarea = gohelper.findChild(self.viewGO, "#go_clickarea")
	self.gotrial = gohelper.findChild(self.viewGO, "#go_trial")
	self._gorefinecontainer = gohelper.findChild(self.viewGO, "#go_refinecontainer")
	self._txtrefinelv = gohelper.findChildText(self.viewGO, "#go_refinecontainer/#txt_refinelv")
	self._goAddition = gohelper.findChild(self.viewGO, "turnback")
	self._gorecommend = gohelper.findChild(self.viewGO, "#go_recommend")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonEquipIcon:addEvents()
	return
end

function CommonEquipIcon:removeEvents()
	return
end

function CommonEquipIcon:_editableInitView()
	gohelper.setActive(self._imagerare.gameObject, false)
	gohelper.setActive(self._imagerare2.gameObject, false)

	self._showQuality = true
	self._effectGos = {}
	self._effectLoader = MultiAbLoader.New()

	self._effectLoader:setPathList({
		ResUrl.getCommonitemEffect("itemeffect")
	})
	self._effectLoader:startLoad(self.LoadEffect, self)

	self._showLockIcon = true
	self._cantJump = false
	self._hideShowBreakAndLv = false
	self._showCount = true

	transformhelper.setLocalPosXY(self.viewGO.transform, 0, 0)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._isShowSelectedUI = false
	self._isCarrerIconAndRefineVisible = true

	gohelper.setActive(self._gorefinecontainer, false)
	self:hideHeroIcon()

	self._itemType = MaterialEnum.MaterialType.Equip

	self._gorecommend:SetActive(false)
end

function CommonEquipIcon:_editableAddEvents()
	return
end

function CommonEquipIcon:_editableRemoveEvents()
	if self._click then
		self._click:RemoveClickListener()
	end

	self.cus_callback = nil
	self.cus_callback_param = nil
end

local VFX_MIN_LV = 4
local VFX_MAX_LV = 5

function CommonEquipIcon:LoadEffect()
	if gohelper.isNil(self._imagerare) then
		if self._effectLoader then
			self._effectLoader:dispose()

			self._effectLoader = nil
		end

		return
	end

	local prefabGO = self._effectLoader:getFirstAssetItem():GetResource()

	self:isShowQuality(self._showQuality)

	self._effect = gohelper.clone(prefabGO, self._imagerare.gameObject, "itemEffect")

	for i = VFX_MIN_LV, VFX_MAX_LV do
		self._effectGos[i] = gohelper.findChild(self._effect, "effect" .. tostring(i))
	end

	if self._config then
		for i = VFX_MIN_LV, VFX_MAX_LV do
			gohelper.setActive(self._effectGos[i], i == tonumber(self._config.rare) and EquipModel.canShowVfx(self._config))
			gohelper.setActive(gohelper.findChild(self._effectGos[i], "mask"), false)
		end
	end
end

function CommonEquipIcon:setInterceptClick(callback, callbackObj)
	self.interceptCallback = callback
	self.interceptCallbackObj = callbackObj
end

function CommonEquipIcon:_onClick()
	if self.interceptCallback and self.interceptCallback(self.interceptCallbackObj) then
		return
	end

	if self.cus_callback then
		self.cus_callback(self.cus_callback_param)

		return
	end

	MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId, false, nil, self._cantJump)
end

function CommonEquipIcon:customClick(callback, param)
	self.cus_callback = callback
	self.cus_callback_param = param

	self:addClick()
end

function CommonEquipIcon:setCantJump(cantJump)
	self._cantJump = cantJump
end

function CommonEquipIcon:addClick()
	self._click = gohelper.getClickWithAudio(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function CommonEquipIcon:setScale(scale)
	transformhelper.setLocalScale(self.viewGO.transform, scale, scale, scale)
end

function CommonEquipIcon:setLevelScaleAndColor(scale, color)
	transformhelper.setLocalScale(self._golevel.transform, scale, scale, scale)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level"), color)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level/lv"), color)
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(self.viewGO, "layout/#go_num/#txt_num"), color)
end

function CommonEquipIcon:hideLockIcon()
	self._showLockIcon = false
end

function CommonEquipIcon:hideLv(flag)
	self._hideLv = flag

	self._golevel:SetActive(not flag)
end

function CommonEquipIcon:hideLvAndBreak(flag)
	self:hideLv(flag)
end

function CommonEquipIcon:setHideLvAndBreakFlag(flag)
	self._hideShowBreakAndLv = flag
end

function CommonEquipIcon:playEquipAnim(aniName)
	self._animator:Play(aniName)
end

function CommonEquipIcon:_initEquipByMo(equipMo)
	self._mo = equipMo
	self._config = self._mo.config
	self._isLock = self._mo.isLock
	self._count = self._mo.count
	self._level = self._mo.level
	self._breakLv = self._mo.breakLv
	self._refineLv = self._mo.refineLv
	self._itemId = self._config.id
	self._equipTeamPosInfo = EquipChooseListModel.instance:equipInTeam(self._mo.uid)
end

function CommonEquipIcon:_initEquipByConfig(equipCo, quantity)
	self._mo = nil
	self._config = equipCo
	self._itemId = equipCo.id
	self._isLock = false
	self._count = quantity
	self._level = 1
	self._breakLv = 1
	self._refineLv = EquipHelper.getRefineLvByEquipCo(equipCo)
end

function CommonEquipIcon:setMOValue(type, materilId, quantity, uid)
	local equipMo = EquipModel.instance:getEquip(uid)

	if equipMo then
		self:_initEquipByMo(equipMo)
	else
		self:_initEquipByConfig(EquipConfig.instance:getEquipCo(tonumber(materilId)), quantity)
	end

	self:initEquipType()
	self:refreshUI()
end

function CommonEquipIcon:setEquipMO(mo)
	self:_initEquipByMo(mo)
	self:initEquipType()
	self:refreshUI()
end

function CommonEquipIcon:initEquipType()
	self.isExpEquip = EquipHelper.isExpEquip(self._config)
	self.isSpRefineEquip = EquipHelper.isSpRefineEquip(self._config)
	self.isRefineUniversalEquip = EquipHelper.isRefineUniversalMaterials(self._config.id)
	self.isNormalEquip = not self.isExpEquip and not self.isSpRefineEquip and not self.isRefineUniversalEquip
end

function CommonEquipIcon:onUpdateMO(mo)
	self:setEquipMO(mo)
end

function CommonEquipIcon:isUniversalMeterial()
	return self._config.id == 1000
end

function CommonEquipIcon:setBalanceLv(level)
	if not level or not self._mo or tonumber(self._mo.uid) < 0 or level <= self._level then
		return
	end

	self._txtlevel.text = "<color=#bfdaff>" .. level

	SLFramework.UGUI.GuiHelper.SetColor(self._txtlevelEn, "#bfdaff")
end

function CommonEquipIcon:refreshUI()
	if not self._config then
		return
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "equipbar" .. EquipConfig.instance:getRareColor(self._config.rare), nil, self.bgAlpha)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare2, "bgequip" .. tostring(ItemEnum.Color[self._config.rare]), nil, self.bgAlpha)

	if self._effectGos and tabletool.len(self._effectGos) > 0 then
		for i = VFX_MIN_LV, VFX_MAX_LV do
			gohelper.setActive(self._effectGos[i], i == tonumber(self._config.rare) and EquipModel.canShowVfx(self._config))
			gohelper.setActive(gohelper.findChild(self._effectGos[i], "mask"), false)
		end
	end

	self._txtnum.text = GameUtil.numberDisplay(self._count)
	self._txtlevel.text = self._level

	SLFramework.UGUI.GuiHelper.SetColor(self._txtlevelEn, "#E8E7E7")
	gohelper.setActive(self.gotrial, self._mo and self._mo.equipType == EquipEnum.ClientEquipType.TrialEquip)
	gohelper.setActive(self._gorefinecontainer, (self._mo or nil) and (self.isNormalEquip or self.isNormalEquip and self._refineLv > 1))

	if self.isNormalEquip then
		self._txtrefinelv.text = self._refineLv >= EquipConfig.instance:getEquipRefineLvMax() and string.format("<color=#e87826>%s</color>", self._refineLv) or string.format("<color=#E8E7E7>%s</color>", self._refineLv)
	end

	self:_loadIconImage()

	local var_28_0 = EquipHelper.isRefineUniversalMaterials(self._config.id)

	if not var_28_0 then
		var_28_0 = self.isExpEquip

		if not self.isExpEquip then
			var_28_0 = EquipHelper.isSpRefineEquip(self._config)
			var_28_0 = var_28_0 or self._hideShowBreakAndLv
		end
	end

	self:hideLvAndBreak(var_28_0)

	local var_28_1 = not EquipHelper.isRefineUniversalMaterials(self._config.id) and self.isExpEquip and self._showCount or false

	self:isShowCount((false or nil) and true)

	if not self._iconImage.sprite then
		self:_setIconAlpha(0)
	end

	self._golock:SetActive(self._isLock and self._showLockIcon)
end

function CommonEquipIcon:checkRecommend()
	if self._mo then
		local isRecommend = true

		isRecommend = self._mo.recommondIndex

		if self._mo.recommondIndex then
			if self._mo.recommondIndex <= 0 then
				isRecommend = false
			end

			self._gorecommend:SetActive(isRecommend)
		end
	end
end

function CommonEquipIcon:setGrayScale(isGray)
	ZProj.UGUIHelper.SetGrayscale(self._simageicon.gameObject, isGray)
	ZProj.UGUIHelper.SetGrayscale(self._imagerare.gameObject, isGray)
end

function CommonEquipIcon:_loadIconImage()
	if self._overrideIconLoadFunc then
		self._overrideIconLoadFunc(self._overrideIconLoadFuncObj)

		return
	end

	self:_defaultLoadIconFunc()
end

function CommonEquipIcon:_defaultLoadIconFunc()
	self._simageicon:LoadImage(ResUrl.getEquipIcon(self._config.icon), self._loadImageFinish, self)
end

function CommonEquipIcon:setItemIconScale(scale)
	transformhelper.setLocalScale(self._simageicon.transform, scale, scale, scale)
end

function CommonEquipIcon:setItemOffset(offsetX, offsetY)
	recthelper.setAnchor(self._simageicon.transform, offsetX or -1.5, offsetY or 53)
end

function CommonEquipIcon:_overrideLoadIconFunc(loadFunc, funcObj)
	self._overrideIconLoadFunc = loadFunc
	self._overrideIconLoadFuncObj = funcObj
end

function CommonEquipIcon:_loadImageFinish()
	self:_setIconAlpha(self.iconAlpha or 1)
end

function CommonEquipIcon:setAlpha(iconAlpha, bgAlpha)
	self.iconAlpha = iconAlpha
	self.bgAlpha = bgAlpha

	self:_setIconAlpha(self.iconAlpha)
	self:refreshUI()
end

function CommonEquipIcon:_setIconAlpha(value)
	local color = self._iconImage.color

	color.a = value
	self._iconImage.color = color
end

function CommonEquipIcon:showLevel()
	gohelper.setActive(self._gonum, false)

	self._txtlevel.text = self._level
end

function CommonEquipIcon:refreshLock(isLock)
	self._isLock = isLock

	self._golock:SetActive(self._isLock and self._showLockIcon)
end

function CommonEquipIcon:showEquipCount(countbg, count)
	countbg = countbg or self._golevel
	count = count or self._txtlevel

	gohelper.setActive(self._golevel, false)
	gohelper.setActive(self._gonum, false)

	if self.isExpEquip then
		count.text = GameUtil.numberDisplay(self._count)

		gohelper.setActive(countbg, count.text ~= nil)
	else
		self._txtlevel.text = self._level

		gohelper.setActive(countbg, false)
		gohelper.setActive(self._golevel, true)
	end
end

function CommonEquipIcon:isShowAddition(flag)
	gohelper.setActive(self._goAddition, flag)
end

function CommonEquipIcon:isShowCount(flag)
	gohelper.setActive(self._gonum, flag)
end

function CommonEquipIcon:setShowCountFlag(flag)
	self._showCount = flag
end

function CommonEquipIcon:hideExpEquipState()
	gohelper.setActive(self._gorefinecontainer, not self.isExpEquip)
	gohelper.setActive(self._gonum, false)
	gohelper.setActive(self._golevel, not self.isExpEquip)
end

function CommonEquipIcon:showEquipRefineContainer(flag)
	gohelper.setActive(self._gorefinecontainer, flag)
end

function CommonEquipIcon:setCountFontSize(fontsize)
	self._scale = self._scale or fontsize / self._txtnum.fontSize

	transformhelper.setLocalScale(self._countbg.transform, 1, self._scale, 1)

	self._txtnum.fontSize = fontsize

	transformhelper.setLocalScale(self._txtlevel.transform, self._scale, self._scale, self._scale)
	transformhelper.setLocalPosXY(self._txtlevel.transform, 30, 0)
end

function CommonEquipIcon:setLevelPos(posx, posy)
	transformhelper.setLocalPosXY(self._txtlevel.transform, posx, posy)
end

function CommonEquipIcon:setLevelFontColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._txtlevel, color)
end

function CommonEquipIcon:setCarrerIconAndRefineVisible(isVisible)
	if self._isCarrerIconAndRefineVisible == isVisible then
		return
	end

	self._isCarrerIconAndRefineVisible = isVisible
end

function CommonEquipIcon:onSelect(isSelect)
	gohelper.setActive(self._goselected, self._isShowSelectedUI and isSelect)
end

function CommonEquipIcon:setSelectUIVisible(isVisible)
	self._isShowSelectedUI = isVisible
end

function CommonEquipIcon:isShowRefineLv(isShow)
	gohelper.setActive(self._txtrefinelv.gameObject, isShow)
end

function CommonEquipIcon:setRefineLvFontSize(fontSize)
	self._txtrefinelv.fontSize = fontSize
end

function CommonEquipIcon:showHeroIcon(skinCo)
	self._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(skinCo.headIcon))
	gohelper.setActive(self._gointeam, true)
	self:refreshLock(false)
end

function CommonEquipIcon:hideHeroIcon()
	gohelper.setActive(self._gointeam, false)
end

function CommonEquipIcon:setItemColor(color)
	SLFramework.UGUI.GuiHelper.SetColor(self._imageBg, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._iconImage, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._imagerare, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._imagerare2, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._countbg:GetComponent(gohelper.Type_Image), color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtnum, color or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtlevel, color or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level/lv"), color or "#E8E7E7")
end

function CommonEquipIcon:setGetMask(isMask)
	SLFramework.UGUI.GuiHelper.SetColor(self._iconImage, isMask and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._imagerare, isMask and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._imagerare2, isMask and "#666666" or "#FFFFFF")
	SLFramework.UGUI.GuiHelper.SetColor(self._txtlevel, isMask and "#525252" or "#E8E7E7")
	SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildText(self.viewGO, "layout/#go_level/#txt_level/lv"), isMask and "#525252" or "#E8E7E7")
	ZProj.UGUIHelper.SetColorAlpha(self._txtrefinelv, isMask and 0.4 or 1)
end

function CommonEquipIcon:isShowQuality(flag)
	self._showQuality = flag

	gohelper.setActive(self._imageBg, flag)
	gohelper.setActive(self._imagerare, flag)
	gohelper.setActive(self._imagerare2, flag)
end

function CommonEquipIcon:onDestroyView()
	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	self._simageheroicon:UnLoadImage()
	self._simageicon:UnLoadImage()
end

function CommonEquipIcon:isExpiredItem()
	return false
end

return CommonEquipIcon
