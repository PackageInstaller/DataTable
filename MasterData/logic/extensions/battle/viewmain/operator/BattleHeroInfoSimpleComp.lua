-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/operator/BattleHeroInfoSimpleComp.lua

module("logic.extensions.battle.viewmain.operator.BattleHeroInfoSimpleComp", package.seeall)

local M = class("BattleHeroInfoSimpleComp")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
	self:bindEvents()
end

function M:buildUI()
	self._btnClickType1 = Astral.ButtonAdapter.GetFrom(self.mainGO, "click")
	self._txtBloodOfType1 = goutil.findChildTextComponent(self.mainGO, "hint/hp/txtBlood")
	self._txtLevelOfType1 = goutil.findChildTextComponent(self.mainGO, "hint/txtLv")
	self._txtNameOfType1 = goutil.findChildTextComponent(self.mainGO, "nameHint/txtName")
	self._careerOfType1 = UIBattleCareer.New(goutil.findChild(self.mainGO, "nameHint/career"))
	self._sanity = UIBattleSanity.New(goutil.findChild(self.mainGO, "sanity_copy"))
	self._goBuffRoot1 = goutil.findChild(self.mainGO, "buffList")
	self._buffTipsBtn1 = Astral.ButtonAdapter.Get(self._goBuffRoot1)
	self._buffIconList1 = {}
end

function M:destroyUI()
	self:unbindEvents()
	self._sanity:destroy()
	self._careerOfType1:destroy()

	self._txtBloodOfType1 = nil
	self._txtLevelOfType1 = nil
	self._txtNameOfType1 = nil
	self._careerOfType1 = nil
	self._sanity = nil
	self._clickFunc = nil
	self._clickHandler = nil
	self._btnClickType1 = nil
end

function M:bindEvents()
	self._btnClickType1:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClickType1:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)
end

function M:onExit()
	self:_setEvent(false)
	self:clearOperateUnit()
end

function M:setOperateUnit(unit)
	self._unit = unit

	self:_updateViewInfoOfType1()
end

function M:getOperateUnit()
	return self._unit
end

function M:closeExpandPanel()
	if self._isExpanded then
		self._isExpanded = false

		self:_updateExpandState()
	end
end

function M:clearOperateUnit()
	self:_clearBuffIconList1()

	self._unit = false
end

function M:_setEvent(add)
	return
end

function M:setVisible(visible, key)
	goutil.setActive(self.mainGO, visible)
end

function M:_updateViewInfoOfType1()
	local property = self._unit.property

	self._txtNameOfType1.text = property:getName()
	self._txtLevelOfType1.text = property:getLevel()
	self._txtBloodOfType1.text = string.format("%d<size=22>/%d</size>", property:getHp(), property:getMaxHp())

	self._careerOfType1:setCareerAndColorType(property:getCareer(), property:getColorType())

	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)
	local modelCO = ModelConfig.instance:getModelConfig(property:getModelCode())
	local buffComp = self._unit.buff

	self:_clearBuffIconList1()

	local count = 0

	for _, buffMO in pairs(buffComp:getAllBuff()) do
		count = count + 1

		if count <= 4 then
			local buffIcon = BattleBuffIcon:createInstance()

			buffIcon:setBuffMO(buffMO)
			buffIcon:setClickListener(self._onClickBuffIcon, self)
			table.insert(self._buffIconList1, buffIcon)
			goutil.addChildToParent(buffIcon.mainGO, self._goBuffRoot1)
		else
			local buffIcon = BattleBuffIcon:createInstance()

			buffIcon:setClickListener(self._onClickBuffIcon, self)
			table.insert(self._buffIconList1, buffIcon)
			goutil.addChildToParent(buffIcon.mainGO, self._goBuffRoot1)
			buffIcon:setMoreSign(true)

			break
		end
	end

	goutil.setActive(self._goBuffRoot1, count > 0)
	self:_updateSanity()
end

function M:_updateSanity()
	local property = self._unit.property
	local isInStrengthen = BattleUnitUtil.isUnitStrengthening(self._unit)

	self._sanity:setVisible(BattleUnitUtil.isSanityVisibleBySystemOpen(self._unit), BattleConst.SystemOpenKey)
	self._sanity:setSanity(property:getSanity(), isInStrengthen, true)
end

function M:updateViewInfoOnStrengthenChange(sanity, isInStrengthen, isImmediately)
	self._sanity:setSanity(sanity, isInStrengthen, isImmediately)
end

function M:_clearBuffIconList1()
	BattleTableUtil.clearReusableTable(self._buffIconList1)
end

function M:setClickHandler(func, handler)
	self._clickFunc = func
	self._clickHandler = handler
end

function M:_onClickBuffIcon()
	if self._clickFunc then
		self._clickFunc(self._clickHandler)
	end
end

function M:_onClick()
	if self._clickFunc then
		self._clickFunc(self._clickHandler)
	end
end

return M
