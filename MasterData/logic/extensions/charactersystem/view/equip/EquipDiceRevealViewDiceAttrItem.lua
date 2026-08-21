-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceRevealViewDiceAttrItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceRevealViewDiceAttrItem", package.seeall)

local M = class("EquipDiceRevealViewDiceAttrItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	local goDice = goutil.findChild(self._mainGo, "d6_reveal_item")

	self._animation = goutil.findChildComponent(self._mainGo, "d6_reveal_item", ComponentType.Animation)
	self._goUnlock = goutil.findChild(goDice, "unlock")
	self._rectMask2D = goutil.findChildComponent(self._mainGo, "d6_reveal_item/unlock", UIComponentType.RectMask2D)
	self._goLock = goutil.findChild(goDice, "lock")
	self._txtAttribute = goutil.findChildComponent(goDice, "unlock/txtD6Attribute", UIComponentType.TextMeshProUGUI)
	self._txtUnlockAttribute = goutil.findChildComponent(goDice, "lock/txtD6Attribute", UIComponentType.TextMeshProUGUI)

	local equipHoleItemGo = goutil.findChild(goDice, "unlock/equip_hole_item")

	self._equipDiceIconItem = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipDiceIconItem)
	self._goImgDi = goutil.findChild(self._mainGo, "imgDi")
	self._txtAddNum = goutil.findChildComponent(self._mainGo, "txtAddNum", UIComponentType.Text)
	self._txtAddNum2 = goutil.findChildComponent(self._mainGo, "txtAddNum2", UIComponentType.Text)
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(goDice, "unlock/click"))

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.EQUIP_REVEAL_DICE, self._activeEffect, self)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_REVEAL_DICE, self._activeEffect, self)
	removetimer(self._playAnim, self)
	removetimer(self._activeAddValue, self)
	removetimer(self._activeEnhanceEffect, self)
	self._btnClick:RemoveClickListener()
	self._equipDiceIconItem:closeEnhanceAni()
	goutil.setActive(self._txtAddNum.gameObject, false)
	goutil.setActive(self._txtAddNum2.gameObject, false)
end

function M:setData(diceStatus, diceAttrMoNew, diceAttrMoOld, unlockLevel)
	self._hasPlayAnimation = false

	self._equipDiceIconItem:setStatus(diceStatus)
	self._equipDiceIconItem:setData(diceAttrMoNew)

	self._diceAttrMoNew = diceAttrMoNew
	self._diceAttrMoOld = diceAttrMoOld
	self._newAddValue = diceAttrMoNew and diceAttrMoNew:getEnhancedAddValue() or 0
	self._oldAddValue = diceAttrMoOld and diceAttrMoOld:getEnhancedAddValue() or 0

	goutil.setActive(self._goImgDi, diceStatus == EquipEnum.DiceStatus.Unlock)

	if diceStatus == EquipEnum.DiceStatus.Lock then
		self._txtUnlockAttribute.text = langF("tip_equip_unlock_dice", unlockLevel or 0)

		goutil.setActive(self._goUnlock, false)
		goutil.setActive(self._goLock, true)
		goutil.setActive(self._txtAddNum.gameObject, false)
		goutil.setActive(self._txtAddNum2.gameObject, false)

		return
	elseif diceStatus == EquipEnum.DiceStatus.Unlocking then
		self._txtUnlockAttribute.text = lang("tip_equip_unlock_dice")
		self._txtAttribute.text = diceAttrMoNew:getDesc(nil, true)

		goutil.setActive(self._goUnlock, false)
		goutil.setActive(self._goLock, true)
		goutil.setActive(self._txtAddNum.gameObject, false)
		goutil.setActive(self._txtAddNum2.gameObject, false)
		settimer(1, self._playAnim, self, false)
		settimer(2, self._activeAddValue, self, false)
	else
		goutil.setActive(self._goUnlock, true)
		goutil.setActive(self._goLock, false)

		self._txtAttribute.text = diceAttrMoNew:getDesc(nil, true)
	end

	settimer(2.5, self._activeEnhanceEffect, self, false)
	self:_updateEnhanceAdd()
end

function M:_updateEnhanceAdd()
	if self._newAddValue <= 0 then
		goutil.setActive(self._txtAddNum.gameObject, false)
		goutil.setActive(self._txtAddNum2.gameObject, false)

		return
	end

	if self._diceAttrMoOld then
		local hadOldAdd = self._oldAddValue > 0

		goutil.setActive(self._txtAddNum.gameObject, hadOldAdd)

		self._txtAddNum.text = EquipUtil.getValueDesc2(self._diceAttrMoNew:getCoDesc(), self._oldAddValue)

		local hadNewAdd = self._newAddValue - self._oldAddValue > 0

		goutil.setActive(self._txtAddNum2.gameObject, hadNewAdd)

		self._txtAddNum2.text = EquipUtil.getValueDesc2(self._diceAttrMoNew:getCoDesc(), self._newAddValue)
	else
		goutil.setActive(self._txtAddNum.gameObject, false)
		goutil.setActive(self._txtAddNum2.gameObject, true)

		self._txtAddNum2.text = EquipUtil.getValueDesc2(self._diceAttrMoNew:getCoDesc(), self._newAddValue)
	end
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._equipDiceIconItem = nil
end

function M:_playAnim()
	if not self._animation then
		return
	end

	goutil.setActive(self._goUnlock, true)
	goutil.setActive(self._goLock, true)
	self._animation:Stop()
	self._animation:Play("d6_attribute_item_unlock_open")
end

function M:_activeEffect(e, group)
	if not self._diceAttrMoNew then
		return
	end

	local isSameGroup = self._diceAttrMoNew:getEnhanceType() == group

	if isSameGroup and self._newAddValue > 0 and not self._hasPlayAnimation then
		removetimer(self._activeEnhanceEffect, self)

		self._hasPlayAnimation = true
		self._rectMask2D.enabled = false

		self._equipDiceIconItem:playAllAni()
	end
end

function M:_activeEnhanceEffect()
	if self._newAddValue > 0 then
		self._rectMask2D.enabled = false

		self._equipDiceIconItem:playEnhanceAni()
	end
end

function M:_activeAddValue()
	if not self._animation then
		return
	end

	goutil.setActive(self._goLock, false)
	self:_updateEnhanceAdd()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_REVEAL_DICE, self._diceAttrMoNew:getEnhanceType())
end

function M:_onClick()
	local buffCodes, tagCodes = self._diceAttrMoNew:getBuffsAndTags()

	if buffCodes then
		ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, self._btnClick.gameObject, false)
	end
end

return M
