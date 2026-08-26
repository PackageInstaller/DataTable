-- chunkname: @modules/ugui/icon/common/CommonPropItemIcon.lua

module("modules.ugui.icon.common.CommonPropItemIcon", package.seeall)

local CommonPropItemIcon = class("CommonPropItemIcon", ListScrollCellExtend)

function CommonPropItemIcon:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPropItemIcon:addEvents()
	return
end

function CommonPropItemIcon:removeEvents()
	return
end

function CommonPropItemIcon:_editableInitView()
	self.go = self.viewGO
	self._goitem = gohelper.findChild(self.viewGO, "go_item")
	self._goequip = gohelper.findChild(self.viewGO, "go_equip")
	self._gogold = gohelper.findChild(self.viewGO, "#go_gold")
	self._nameTxt = gohelper.findChildText(self.viewGO, "txt")
	self._rareInGos = self:getUserDataTb_()
	self._hightQualityEffect = self:getUserDataTb_()

	for i = 1, 6 do
		local go = gohelper.findChild(self.viewGO, "vx/" .. tostring(i))

		table.insert(self._rareInGos, go)
	end

	for i = 4, 5 do
		local go = gohelper.findChild(self.viewGO, "vx/" .. tostring(i) .. "/#teshudaoju")

		table.insert(self._hightQualityEffect, i, go)
	end

	gohelper.setActive(self._nameTxt.gameObject, false)
end

function CommonPropItemIcon:_editableAddEvents()
	return
end

function CommonPropItemIcon:_editableRemoveEvents()
	return
end

function CommonPropItemIcon:onUpdateMO(mo)
	self:setMOValue(mo.materilType, mo.materilId, mo.quantity, mo.uid, mo.isIcon, mo.isGold, mo.roomBuildingLevel)
end

function CommonPropItemIcon:setMOValue(type, id, quantity, uid, isIcon, isGold, roomBuildingLevel)
	self._type = tonumber(type)

	if self._type == MaterialEnum.MaterialType.Equip then
		if not self._equipIcon then
			self._equipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

			self._equipIcon:addClick()
		end

		self._equipIcon:setMOValue(type, id, quantity, uid)
	else
		self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._goitem)

		if self._itemIcon and self._itemIcon.setQuantityColor then
			self._itemIcon:setQuantityColor(self._quantityColor)
		end

		self._itemIcon:setMOValue(type, id, quantity, uid, isIcon)

		local newIcon

		if type == MaterialEnum.MaterialType.Building and roomBuildingLevel and roomBuildingLevel > 0 then
			local levelConfig = RoomConfig.instance:getLevelGroupConfig(id, roomBuildingLevel)

			newIcon = levelConfig and ResUrl.getRoomBuildingPropIcon(levelConfig.icon)
		end

		self._itemIcon:setSpecificIcon(newIcon)
		self._itemIcon:setRoomBuildingLevel(roomBuildingLevel)
	end

	gohelper.setActive(self._goequip, self._type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(self._goitem, self._type ~= MaterialEnum.MaterialType.Equip)
	gohelper.setActive(self._gogold, isGold)

	self._isEquip = self._type == MaterialEnum.MaterialType.Equip
end

function CommonPropItemIcon:setAlpha(iconAlpha, bgAlpha)
	if self._equipIcon then
		self._equipIcon:setAlpha(iconAlpha, bgAlpha)
	end

	if self._itemIcon then
		self._itemIcon:setAlpha(iconAlpha, bgAlpha)
	end
end

function CommonPropItemIcon:hideEffect()
	for k, v in pairs(self._rareInGos) do
		gohelper.setActive(v, false)
	end
end

function CommonPropItemIcon:showVxEffect(itemType, id)
	itemType = tonumber(itemType)

	local config, icon = ItemModel.instance:getItemConfigAndIcon(itemType, id)
	local rare = config.rare

	if itemType == MaterialEnum.MaterialType.PlayerCloth then
		rare = rare or 5
	end

	for k, v in pairs(self._rareInGos) do
		gohelper.setActive(v, false)
		gohelper.setActive(v, k == rare)
	end
end

function CommonPropItemIcon:showHighQualityEffect(itemType, config, rare)
	itemType = tonumber(itemType)

	if itemType == MaterialEnum.MaterialType.PlayerCloth then
		rare = rare or 5
	end

	local canShowVfx = ItemModel.canShowVfx(itemType, config, rare)

	for k, v in pairs(self._hightQualityEffect) do
		if k == rare and canShowVfx then
			gohelper.setActive(v, false)
			gohelper.setActive(v, true)
		else
			gohelper.setActive(v, false)
		end
	end
end

function CommonPropItemIcon:setItemIconScale(scale)
	if self._itemIcon then
		self._itemIcon:setItemIconScale(scale)
	end

	if self._equipIcon and self._isEquip then
		self._equipIcon:setItemIconScale(scale)
	end
end

function CommonPropItemIcon:setItemOffset(anchorX, anchorY)
	if self._itemIcon then
		self._itemIcon:setItemOffset(anchorX, anchorY)
	end

	if self._equipIcon then
		self._equipIcon:setItemOffset(anchorX, anchorY)
	end
end

function CommonPropItemIcon:setCountTxtSize(fontsize)
	if self._itemIcon then
		self._itemIcon:setCountFontSize(fontsize)
	end

	if self._equipIcon then
		self._equipIcon:setCountFontSize(fontsize)
	end
end

function CommonPropItemIcon:setScale(scale)
	if self._itemIcon then
		self._itemIcon:setScale(scale)
	end

	if self._equipIcon and self._isEquip then
		self._equipIcon:setScale(scale)
	end
end

function CommonPropItemIcon:setPropItemScale(scale)
	transformhelper.setLocalScale(self.viewGO.transform, scale, scale, scale)
end

function CommonPropItemIcon:showName(txt)
	if self._itemIcon then
		self._itemIcon:showName(txt)
	end
end

function CommonPropItemIcon:setNameType(str)
	if self._itemIcon then
		self._itemIcon:setNameType(str)
	end
end

function CommonPropItemIcon:customOnClickCallback(callback, param)
	if self._equipIcon and self._isEquip then
		self._equipIcon:customClick(callback, param)
	end

	if self._itemIcon then
		self._itemIcon:customOnClickCallback(callback, param)
	end
end

function CommonPropItemIcon:setInterceptClick(callback, callbackObj)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setInterceptClick(callback, callbackObj)
	end

	if self._itemIcon then
		self._itemIcon:setInterceptClick(callback, callbackObj)
	end
end

function CommonPropItemIcon:setOnBeforeClickCallback(callback, callbackObj, param)
	if self._itemIcon then
		self._itemIcon:setOnBeforeClickCallback(callback, callbackObj, param)
	end
end

function CommonPropItemIcon:showStackableNum()
	if self._itemIcon and self._itemIcon.showStackableNum then
		self._itemIcon:showStackableNum()
	end
end

function CommonPropItemIcon:setFrameMaskable(state)
	if self._itemIcon and self._itemIcon._setFrameMaskable then
		self._itemIcon:_setFrameMaskable(state)
	end
end

function CommonPropItemIcon:isShowCount(flag)
	if self._itemIcon and self._itemIcon.isShowCount then
		self._itemIcon:isShowCount(flag)
	end
end

function CommonPropItemIcon:isShowQuality(flag)
	if self._itemIcon and self._itemIcon.isShowQuality then
		self._itemIcon:isShowQuality(flag)
	end

	if self._equipIcon and self._isEquip then
		self._equipIcon:isShowQuality(flag)
	end
end

function CommonPropItemIcon:isShowEquipAndItemCount(flag)
	if self._itemIcon and self._itemIcon.isShowCount then
		self._itemIcon:isShowCount(flag)
	end

	if self._equipIcon and self._isEquip then
		self._equipIcon:isShowCount(flag)
	end
end

function CommonPropItemIcon:setHideLvAndBreakFlag(flag)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setHideLvAndBreakFlag(flag)
	end
end

function CommonPropItemIcon:setShowCountFlag(flag)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setShowCountFlag(flag)
	end
end

function CommonPropItemIcon:isShowName(flag)
	if self._itemIcon and self._itemIcon.isShowName then
		self._itemIcon:isShowName(flag)
	end
end

function CommonPropItemIcon:isShowEffect(flag)
	if self._itemIcon and self._itemIcon.isShowEffect then
		self._itemIcon:isShowEffect(flag)
	end
end

function CommonPropItemIcon:isShowAddition(flag)
	if self._itemIcon and self._itemIcon.isShowAddition then
		self._itemIcon:isShowAddition(flag)
	elseif self._isEquip and self._equipIcon then
		self._equipIcon:isShowAddition(flag)
	end
end

function CommonPropItemIcon:ShowEquipCount(countbg, count)
	if self._isEquip and self._equipIcon then
		self._equipIcon:showEquipCount(countbg, count)
	end
end

function CommonPropItemIcon:isShowEquipCount(flag)
	if self._isEquip and self._equipIcon then
		self._equipIcon:isShowCount(flag)
	end
end

function CommonPropItemIcon:hideExpEquipState()
	if self._isEquip and self._equipIcon then
		self._equipIcon:hideExpEquipState()
	end
end

function CommonPropItemIcon:hideEquipLvAndBreak(flag)
	if self._isEquip and self._equipIcon then
		self._equipIcon:hideLvAndBreak(flag)
	end
end

function CommonPropItemIcon:showEquipRefineContainer(flag)
	if self._isEquip and self._equipIcon then
		self._equipIcon:showEquipRefineContainer(flag)
	end
end

function CommonPropItemIcon:setCantJump(cantJump)
	if self._itemIcon and self._itemIcon.setCantJump then
		self._itemIcon:setCantJump(cantJump)
	end

	if self._equipIcon and self._equipIcon.setCantJump then
		self._equipIcon:setCantJump(cantJump)
	end
end

function CommonPropItemIcon:setRecordFarmItem(recordFarmItem)
	if self._itemIcon and self._itemIcon.setRecordFarmItem then
		self._itemIcon:setRecordFarmItem(recordFarmItem)
	end
end

function CommonPropItemIcon:setQuantityColor(quantityColor)
	self._quantityColor = quantityColor

	if self._itemIcon and self._itemIcon.setQuantityColor then
		self._itemIcon:setQuantityColor(quantityColor)
	end
end

function CommonPropItemIcon:setQuantityText(color)
	if self._itemIcon then
		self._itemIcon:setQuantityText(color)
	end
end

function CommonPropItemIcon:setItemColor(color)
	if self._itemIcon then
		self._itemIcon:setItemColor(color)
	end

	if self._equipIcon then
		self._equipIcon:setItemColor(color)
	end
end

function CommonPropItemIcon:showStackableNum2(countbg, txtQuantity)
	if self._itemIcon and self._itemIcon.showStackableNum2 then
		self._itemIcon:showStackableNum2(countbg, txtQuantity)
	end
end

function CommonPropItemIcon:setCountText(str)
	if self._itemIcon then
		self._itemIcon:setCountText(str)
	end
end

function CommonPropItemIcon:getItemIcon()
	return (self._isEquip or nil) and (self._equipIcon or self._itemIcon)
end

function CommonPropItemIcon:isEquipIcon()
	return self._isEquip
end

function CommonPropItemIcon:setCountFontSize(fontsize)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setCountFontSize(fontsize)
	else
		self._itemIcon:setCountFontSize(fontsize)
	end
end

function CommonPropItemIcon:setEquipLevelScaleAndColor(scale, color)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setLevelScaleAndColor(scale, color)
	end
end

function CommonPropItemIcon:setCarrerIconAndRefineVisible(flag)
	if self._equipIcon and self._isEquip then
		self._equipIcon:setCarrerIconAndRefineVisible(flag)
	end
end

function CommonPropItemIcon:playAnimation()
	if self._itemIcon then
		self._itemIcon:playAnimation()
	end
end

function CommonPropItemIcon:setAutoPlay(autoPlay)
	if self._itemIcon then
		self._itemIcon:setAutoPlay(autoPlay)
	end
end

function CommonPropItemIcon:setConsume(consume)
	if self._itemIcon then
		self._itemIcon:setConsume(consume)
	end
end

function CommonPropItemIcon:isShowEquipRefineLv(isShow)
	if self._isEquip then
		self._equipIcon:isShowRefineLv(isShow)
	end
end

function CommonPropItemIcon:SetCountLocalY(localY)
	if self._itemIcon and self._itemIcon._txtQuantity then
		recthelper.setAnchorY(self._itemIcon._txtQuantity.transform, localY)
	end

	if self._equipIcon and self._equipIcon._txtnum then
		recthelper.setAnchorY(self._equipIcon._txtnum.transform, localY - 39.6)
	end
end

function CommonPropItemIcon:SetCountBgHeight(height)
	if self._itemIcon and self._itemIcon._countbg then
		recthelper.setHeight(self._itemIcon._countbg.transform, height)
	end

	if self._equipIcon and self._equipIcon._countbg then
		recthelper.setHeight(self._equipIcon._countbg.transform, height)
	end
end

function CommonPropItemIcon:SetCountBgScale(scalex, scaley, scalez)
	if self._itemIcon and self._itemIcon._countbg then
		transformhelper.setLocalScale(self._itemIcon._countbg.transform, scalex, scaley, scalez)
	end

	if self._equipIcon and self._equipIcon._countbg then
		transformhelper.setLocalScale(self._equipIcon._countbg.transform, scalex, scaley, scalez)
	end
end

function CommonPropItemIcon:setGetMask(isMask)
	if self._itemIcon then
		self._itemIcon:setGetMask(isMask)
	end

	if self._equipIcon then
		self._equipIcon:setGetMask(isMask)
	end
end

function CommonPropItemIcon:setIconBg(bgStr)
	if self._itemIcon then
		self._itemIcon:setIconBg(bgStr)
	end
end

function CommonPropItemIcon:setCanShowDeadLine(canShowDeadLine)
	if self._itemIcon then
		self._itemIcon:setCanShowDeadLine(canShowDeadLine)
	end
end

function CommonPropItemIcon:isExpiredItem()
	if self._itemIcon then
		return self._itemIcon:isExpiredItem()
	end

	if self._equipIcon then
		return self._equipIcon:isExpiredItem()
	end
end

return CommonPropItemIcon
