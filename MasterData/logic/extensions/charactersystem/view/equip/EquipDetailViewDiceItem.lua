-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDetailViewDiceItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDetailViewDiceItem", package.seeall)

local M = class("EquipDetailViewDiceItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()

	self._data = nil
end

function M:_buildUI()
	self._txtAttribute = goutil.findChildComponent(self._mainGo, "txtDesc", UIComponentType.TextMeshProUGUI)
	self._txtAddNum = goutil.findChildComponent(self._mainGo, "txtDesc/txtAddNum", UIComponentType.Text)
	self._groupAttribute = self._txtAttribute.gameObject:GetComponent(ComponentType.CanvasGroup)

	local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item")

	self._equipDiceIconItem = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipDiceIconItem)

	self._equipDiceIconItem:setHoleBgVisible(true)

	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "click"))

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:setData(diceStatus, diceAttrMo, unlockLevel)
	self._diceStatus = diceStatus

	self._equipDiceIconItem:setStatus(diceStatus)
	goutil.setActive(self._goImgDi, EquipEnum.DiceStatus.CanUnLock)
	goutil.setActive(self._txtAddNum.gameObject, false)

	if diceStatus == EquipEnum.DiceStatus.Lock and unlockLevel then
		self._txtAttribute.text = langF("tip_equip_unlock_dice", unlockLevel)
		self._groupAttribute.alpha = 0.2

		return
	elseif diceStatus == EquipEnum.DiceStatus.CanUnLock then
		self._txtAttribute.text = lang("tip_equip_unlock_dice")
		self._groupAttribute.alpha = 1

		return
	end

	self._groupAttribute.alpha = 1
	self._data = diceAttrMo
	self._txtAttribute.text = diceAttrMo:getDesc(nil, true)

	self._equipDiceIconItem:setData(diceAttrMo)

	local addValue = diceAttrMo:getEnhancedAddValue()

	if addValue > 0 then
		self._txtAddNum.text = EquipUtil.getValueDesc(diceAttrMo:getCoDesc(), addValue)
	end

	goutil.setActive(self._txtAddNum.gameObject, addValue > 0)
end

function M:setPos(go)
	goutil.addChildToParent(self._mainGo, go)

	local x, y, z = GameUtils.getPos(go)

	GameUtils.setPos(self._mainGo, x, y, z)
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:closeEnhanceAni()
	self._equipDiceIconItem:closeEnhanceAni()
end

function M:playEnhanceAni()
	self._equipDiceIconItem:playEnhanceAni()
end

function M:_onClick()
	if self._diceStatus ~= EquipEnum.DiceStatus.Unlock or not self._data then
		return
	end

	local buffCodes, tagCodes = self._data:getBuffsAndTags()

	if buffCodes then
		ToolTipsMgr.showSkillBuffTagSideTipsWithCodes(buffCodes, tagCodes, self._btnClick.gameObject, false)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self._equipDiceIconItem = nil

	self._btnClick:RemoveClickListener()
end

return M
