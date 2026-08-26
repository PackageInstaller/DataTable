-- chunkname: @modules/logic/commonprop/view/CommonPropListItem.lua

module("modules.logic.commonprop.view.CommonPropListItem", package.seeall)

local CommonPropListItem = class("CommonPropListItem", CommonPropItemIcon)

CommonPropListItem.hasOpen = false

function CommonPropListItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonPropListItem:addEvents()
	return
end

function CommonPropListItem:removeEvents()
	return
end

function CommonPropListItem:_editableInitView()
	CommonPropListItem.super._editableInitView(self)
end

function CommonPropListItem:setMOValue(type, id, quantity, uid, isIcon, isGold, roomBuildingLevel)
	self._isEquip = tonumber(type) == MaterialEnum.MaterialType.Equip
	self._type = type
	self._id = id
	self._quantity = quantity
	self._uid = uid
	self._isGold = isGold
	self._roomBuildingLevel = roomBuildingLevel

	if CommonPropListItem.hasOpen then
		self:_playInEffect()
	else
		TaskDispatcher.runDelay(self._playInEffect, self, 0.06 * self._index)
	end

	gohelper.setActive(self._nameTxt.gameObject, CommonPropListItem.hasOpen and self._isEquip)
	gohelper.setActive(self._goequip, CommonPropListItem.hasOpen and self._isEquip)
	gohelper.setActive(self._goitem, CommonPropListItem.hasOpen and not self._isEquip)
end

function CommonPropListItem:_playInEffect()
	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._type, self._id)
	local rare = config.rare

	if not config.rare then
		if self._type == MaterialEnum.MaterialType.PlayerCloth or self._type == MaterialEnum.MaterialType.Antique or self._type == MaterialEnum.MaterialType.TalentItem then
			rare = 5
		elseif self._type == MaterialEnum.MaterialType.UnlockVoucher then
			rare = UnlockVoucherConfig.instance:getVoucherRare(self._id)
		end
	end

	for k, v in ipairs(self._rareInGos) do
		if k == rare then
			gohelper.setActive(v, true)

			local anim = v:GetComponent(typeof(UnityEngine.Animation))

			if not CommonPropListItem.hasOpen then
				if self._index <= 10 then
					gohelper.setActive(v, true)
					anim:Play()
				else
					gohelper.setActive(v, false)
				end

				TaskDispatcher.runDelay(self._setItem, self, 0.5)
			else
				gohelper.setActive(v, false)
				self:_setItem()
			end
		else
			gohelper.setActive(v, false)
		end
	end

	self:showHighQualityEffect(self._type, config, rare)
end

function CommonPropListItem:_setItem()
	gohelper.setActive(self._nameTxt.gameObject, self._isEquip)
	gohelper.setActive(self._goequip, self._isEquip)
	gohelper.setActive(self._goitem, not self._isEquip)
	gohelper.setActive(self._gogold, self._isGold)

	if self._index == 10 then
		CommonPropListItem.hasOpen = true
	end

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._type, self._id)

	if self._isEquip then
		if not self._equipIcon then
			self._equipIcon = IconMgr.instance:getCommonEquipIcon(self._goequip, 1)

			self._equipIcon:addClick()
		end

		self._equipIcon:setMOValue(self._type, self._id, self._quantity, self._uid)
		self._equipIcon:setCantJump(true)
		self._equipIcon:isShowRefineLv(true)
		self._equipIcon:playEquipAnim(UIAnimationName.Open)

		self._nameTxt.text = config.name
	else
		self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._goitem)

		self._itemIcon:setMOValue(self._type, self._id, self._quantity, self._uid, true)
		self._itemIcon:refreshDeadline(true)
		self._itemIcon:showName()
		self._itemIcon:playAnimation()
		self._itemIcon:setCantJump(true)

		local newIcon

		if self._type == MaterialEnum.MaterialType.Building and self._roomBuildingLevel and self._roomBuildingLevel > 0 then
			local levelConfig = RoomConfig.instance:getLevelGroupConfig(self._id, self._roomBuildingLevel)

			newIcon = levelConfig and ResUrl.getRoomBuildingPropIcon(levelConfig.icon)
		end

		self._itemIcon:setSpecificIcon(newIcon)
		self._itemIcon:setRoomBuildingLevel(self._roomBuildingLevel)
	end

	if self.callback then
		self:callback()
	end
end

function CommonPropListItem:hideName()
	if self._isEquip then
		self._nameTxt.text = ""
	elseif self._itemIcon then
		self._itemIcon:isShowName()
	end
end

function CommonPropListItem:onDestroy()
	self.callback = nil

	TaskDispatcher.cancelTask(self._playInEffect, self)
	TaskDispatcher.cancelTask(self._setItem, self)
end

return CommonPropListItem
