-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleWeakPointSimpleComp.lua

module("logic.battle.uilib.UIBattleWeakPointSimpleComp", package.seeall)

local M = class("UIBattleWeakPointSimpleComp")
local kTextColor = "#FFFFFFFF"

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()

	self._showBroken = true
end

function M:buildUI()
	self._goNormal = goutil.findChild(self.mainGO, "normal")
	self._goTingZhi = goutil.findChild(self.mainGO, "tingzhi")
	self._rollingFillPercentTxt = UIEffectUtil.getTextRollingEffect(goutil.findChild(self._goNormal, "txtFill"))

	self._rollingFillPercentTxt:setFormatPattern("%d%%")

	self._forcastUnitEntityId = false

	self:setPercentTextVisible(true)
end

function M:destroyUI()
	self._imgBlood = nil
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function M:updateBaseInfo(unit)
	local maxHp = unit.property:getWeakPointMaxHp()
	local curHp = unit.property:getWeakPointHp()
	local fillAmount = curHp / maxHp

	if curHp <= 0 then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goTingZhi, true)
	else
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)
		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fillAmount))
	end

	self:_setRollingFillPercentTxtAnimation(false)
end

function M:setPercentTextVisible(visible)
	self._rollingFillPercentTxt:setVisible(visible)
end

function M:forecast(unit, toWeakPointHp, setValueAtOnce)
	toWeakPointHp = toWeakPointHp or 0

	local maxHp = unit.property:getWeakPointMaxHp()
	local fromHp = unit.property:getWeakPointHp()
	local toHp = math.max(0, toWeakPointHp)
	local fromFillAmount = fromHp / maxHp
	local toFillAmount = toHp / maxHp
	local entityId = unit.property:getEntityId()

	if self._forcastUnitEntityId ~= entityId then
		self._forcastUnitEntityId = entityId

		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fromFillAmount))
	end

	local isWeakPointHpChanged = fromHp ~= toHp
	local isWeakPointWillBroken = not unit.property:isWeakPointBroken() and toHp <= 0

	if isWeakPointWillBroken then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goTingZhi, true)
	elseif not isWeakPointHpChanged then
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)
		self:_setRollingFillPercentTxtAnimation(false)
	else
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)
		self:_setRollingFillPercentTxtAnimation(false)

		if setValueAtOnce then
			self._rollingFillPercentTxt:setValue(self:_formatPercentValue(toFillAmount))
		else
			self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fromFillAmount))
			self._rollingFillPercentTxt:rollToValue(self:_formatPercentValue(toFillAmount), 0.5)
		end
	end
end

function M:updatePerformance(unit)
	local maxHp = unit.property:getWeakPointMaxHp()
	local toHp = math.max(0, unit.property:getWeakPointHp())
	local isWeakPointWillBroken = not unit.property:isWeakPointBroken() and toHp <= 0

	if isWeakPointWillBroken then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goTingZhi, true)
		self:_setRollingFillPercentTxtAnimation(false)
	else
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)

		local toFillAmount = toHp / maxHp

		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(toFillAmount))
		self:_setRollingFillPercentTxtAnimation(false)
	end
end

function M:_formatPercentValue(fillAmount)
	return BattleUnitUtil.formatWeakPointValue(fillAmount)
end

function M:_setRollingFillPercentTxtAnimation(enabled)
	return
end

function M:startWeakPointFillScroll(fillAmount)
	if fillAmount <= 0 then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goTingZhi, true)
	else
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)
		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fillAmount))
	end
end

function M:setWeakPointFillAmount(fillAmount)
	if fillAmount <= 0 then
		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goTingZhi, true)
	else
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goTingZhi, false)
		self._rollingFillPercentTxt:setValue(self:_formatPercentValue(fillAmount))
	end
end

return M
