-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceRevealView.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceRevealView", package.seeall)

local M = class("EquipDiceRevealView", ViewComponent)
local kAttributeMaxNum = 2

function M:buildUI()
	self._btnClose = self:getBtn("common_full_tips_bg_1933710455")
	self._goBackItem = self:getGo("rewards_detail_item_2141037416")
	self._goEquipAttrsParent = self:getGo("equip_show_view_1641194648")
	self._goEquipAttrs = {}

	for i = 1, kAttributeMaxNum do
		local go = goutil.findChild(self._goEquipAttrsParent, "item" .. i)

		self._goEquipAttrs[i] = Astral.LuaComponentContainer.Add(go, EquipDiceRevealViewAttrItem)
	end

	self._goDice = self:getGo("equip_show_view_576538409")
	self._diceItemList = {}

	for i = 1, 4 do
		local go = goutil.findChild(self._goDice, "item" .. i)
		local item = Astral.LuaComponentContainer.Add(go, EquipDiceRevealViewDiceAttrItem)

		self._diceItemList[i] = item
	end

	self._goItem = self:getGo("1&rewards_detail_item_2141037416")
	self._itemCell = Astral.LuaComponentContainer.Add(self._goItem, ItemCell)

	goutil.setActive(self._goBackItem, true)
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	for i = 1, #self._diceItemList do
		self._diceItemList[i]:onEnter()
	end

	self._hadAddValue = false

	local openParam = self:getOpenParam()

	self._equipmentDataNew = openParam[1]
	self._equipmentDataOld = openParam[2]

	if not self._equipmentDataNew then
		return
	end

	self._itemCell:updateData(self._equipmentDataNew)
	self:_refreshDiceAttrs()
	self:_refreshAttr()
	self:_playAnimation()
end

function M:_refreshDiceAttrs()
	local totalNum = self._equipmentDataNew:getExtraDiceAttrNum()

	if self._equipmentDataNew:hasOriginalD6() then
		totalNum = totalNum + 1
	end

	local diceList = self._equipmentDataNew:getAllDiceAttr()
	local unlockLevelList = EquipmentConfig.instance:getConstNumList("DiceAttrUnlockLevels")
	local index = 1

	for i = index, totalNum do
		local diceAttrMO = diceList[i]

		if diceAttrMO and diceAttrMO:getEnhancedAddValue() > 0 then
			self._hadAddValue = true
		end

		local oldDiceAttrMO

		if diceAttrMO then
			oldDiceAttrMO = self._equipmentDataOld:getDiceAttrById(diceAttrMO:getAttrId())
		end

		if diceAttrMO and not oldDiceAttrMO then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlocking, diceAttrMO, oldDiceAttrMO)
		elseif diceAttrMO and oldDiceAttrMO then
			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Unlock, diceAttrMO, oldDiceAttrMO)
		else
			local unlockLevel = self._equipmentDataNew:hasOriginalD6() and unlockLevelList[i - 1] or unlockLevelList[i]

			self._diceItemList[i]:setData(EquipEnum.DiceStatus.Lock, diceAttrMO, oldDiceAttrMO, unlockLevel)
		end

		self._diceItemList[index]:setVisible(true)

		index = index + 1
	end

	for i = index, #self._diceItemList do
		self._diceItemList[i]:setVisible(false)
	end
end

function M:_playAnimation()
	self._isCanClose = false
	self._guiAnimation = self._viewPresentor:getGuiAnimation()

	self._guiAnimation:StopTimelineAni()

	local aniName = self._hadAddValue and "open1" or "open2"
	local time = self._guiAnimation:GetTrackEndTime(aniName)

	settimer(time, self._onAnimationPlayEnd, self, false)
	self._guiAnimation:PlayAniByName(aniName)
end

function M:_onAnimationPlayEnd()
	self._isCanClose = true
end

function M:_refreshAttr()
	local attrList = self._equipmentDataNew:getAttrList()
	local index = 1

	for i = index, kAttributeMaxNum do
		local newValue = attrList[i]
		local oldValue = self._equipmentDataOld:getAttrById(attrList[i]:getAttrId())

		self._goEquipAttrs[i]:setData(newValue, oldValue)
		self._goEquipAttrs[i]:setVisible(true)

		index = index + 1
	end

	for i = index, #self._goEquipAttrs do
		self._goEquipAttrs[i]:setVisible(false)
	end
end

function M:onExit()
	for i = 1, #self._diceItemList do
		self._diceItemList[i]:onExit()
	end

	GlobalDispatcher:dispatchEvent(EventType.EQUIP_REVEAL_DICE_ClOSE)
	removetimer(self._onAnimationPlayEnd, self)
	removetimer(self._close, self)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	else
		GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self._handleJump, self)
	end
end

function M:destroyUI()
	return
end

function M:_onClickClose()
	if ViewMgr.instance:isOpen(ViewName.ToolTipsEquipView) then
		ViewMgr.instance:close(ViewName.ToolTipsEquipView)

		return
	end

	if not self._isCanClose then
		return
	end

	removetimer(self._close, self)
	self._guiAnimation:StopTimelineAni()

	local aniName = "close1"
	local time = self._guiAnimation:GetTrackEndTime(aniName)

	self._guiAnimation:PlayAniByName(aniName)
	settimer(time, self._close, self, false)
end

function M:_close()
	self._guiAnimation:StopTimelineAni()
	self:close()
end

return M
