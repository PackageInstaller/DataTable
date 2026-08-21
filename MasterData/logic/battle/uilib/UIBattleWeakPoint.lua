-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleWeakPoint.lua

module("logic.battle.uilib.UIBattleWeakPoint", package.seeall)

local M = class("UIBattleWeakPoint")

function M:ctor(mainGO_1, mainGO_2)
	self.mainGO_1 = mainGO_1
	self.mainGO_2 = mainGO_2
	self._hasWeakPoint = false

	self:buildUI()
end

function M:buildUI()
	self._weakPointComp = UIBattleWeakPointSimpleComp.New(self.mainGO_1)

	if self.mainGO_2 then
		self._weakPointHintView = BattleBossWeakPointHintView.New(self.mainGO_2)
	end

	self._isPercentTextVisible = true
end

function M:destroyUI()
	self._hasWeakPoint = false

	self._weakPointComp:destroy()

	self._weakPointComp = false

	if self._weakPointHintView then
		self._weakPointHintView:destroy()
	end

	self._weakPointHintView = false
end

function M:destroy()
	self:destroyUI()

	self.mainGO_1 = nil
	self.mainGO_2 = nil
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO_1, visible)

	if self.mainGO_2 then
		goutil.setActive(self.mainGO_2, visible)
	end

	if self._visibleFunc then
		self._visibleFunc(self._visibleHandler, visible)
	end
end

function M:setPercentTextVisible(visible)
	self._isPercentTextVisible = visible

	if self._hasWeakPoint then
		self._weakPointComp:setPercentTextVisible(visible)
	end
end

function M:setVisibleCallBack(visibleFunc, visibleHandler)
	self._visibleFunc = visibleFunc
	self._visibleHandler = visibleHandler
end

function M:updateBaseInfo(unit)
	self._unit = unit

	if not unit or not unit.property:isShowWeakPoint() then
		self:setVisible(false)

		self._hasWeakPoint = false

		return
	end

	self._hasWeakPoint = true

	self:setVisible(true)
	self._weakPointComp:updateBaseInfo(unit)
	self._weakPointComp:setPercentTextVisible(self._isPercentTextVisible)

	if self._weakPointHintView then
		self._weakPointHintView:updateBaseInfo(unit)
	end
end

function M:forecast(unit, toWeakPointHp, setValueAtOnce)
	unit = unit or self._unit

	if not unit.property:isShowWeakPoint() then
		self._hasWeakPoint = false

		self:setVisible(false)

		return
	end

	if unit.property:isWeakPointBroken() then
		self:updateBaseInfo(unit)

		return
	end

	self:setVisible(true)
	self._weakPointComp:forecast(unit, toWeakPointHp, setValueAtOnce)
	self._weakPointComp:setPercentTextVisible(true)

	if self._weakPointHintView then
		self._weakPointHintView:forecast(unit, toWeakPointHp)
	end
end

function M:clearForecast()
	self:updateBaseInfo(self._unit)

	if self._weakPointHintView then
		self._weakPointHintView:clearForecast()
	end
end

function M:updatePerformance(unit)
	unit = unit or self._unit

	if not unit.property:isShowWeakPoint() then
		self:setVisible(false)

		return
	end

	if unit.property:isWeakPointBroken() then
		self:updateBaseInfo(unit)

		return
	end

	self:setVisible(true)
	self._weakPointComp:updatePerformance(unit)
	self._weakPointComp:setPercentTextVisible(true)

	if self._weakPointHintView then
		self._weakPointHintView:updatePerformance(unit)
	end
end

function M:startWeakPointFillScroll(fromWeakPointHp, toWeakPointHp)
	local unit = self._unit

	if not unit or not unit.property:isShowWeakPoint() or unit.property:isWeakPointBroken() or not fromWeakPointHp then
		return
	end

	self._weakPointComp:startWeakPointFillScroll(fromWeakPointHp)

	if self._weakPointHintView then
		self._weakPointHintView:startWeakPointFillScroll(fromWeakPointHp)
	end
end

function M:setWeakPointFillAmount(toWeakPointHp)
	local unit = self._unit

	if not unit or not unit.property:isShowWeakPoint() or unit.property:isWeakPointBroken() then
		return
	end

	self._weakPointComp:setWeakPointFillAmount(toWeakPointHp)

	if self._weakPointHintView then
		self._weakPointHintView:setWeakPointFillAmount(toWeakPointHp)
	end
end

return M
