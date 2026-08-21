-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/special/BattleUnitCompSpecialHandler_120128.lua

module("logic.battle.unit.comp.special.BattleUnitCompSpecialHandler_120128", package.seeall)

local M = class("BattleUnitCompSpecialHandler_120128", BattleUnitCompSpecialHandler)

function M:onInit()
	self:_setEvent(true)
end

function M:onInitFinish()
	self:handleBorn()
end

function M:handleDie()
	return
end

function M:onReset()
	return
end

function M:onDestroy()
	self:_setEvent(false)
end

function M:_setEvent(isOn)
	if isOn then
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function M:handleDie(deadType, isSanityDeadth)
	local unit = self:_getBodyUnit()

	unit.specialHandler:handleLinkedUnitDie(true)
	self._unit.dieHandler:removeUnitFromScene()
end

function M:handleBorn()
	self:_resetMapAnimation()

	local unit = self:_getBodyUnit()

	unit.specialHandler:handleLinkedUnitBorn(true)
end

function M:_getBodyUnit()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	return unitMgr:getUnitByModelCode(120038)
end

function M:_resetMapAnimation()
	local unit = self._unit

	unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle, UnitAnimState.BothIdle)
	unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle1, UnitAnimState.BothIdle)
	unit.meshModelMover:mapBaseAnimation(UnitAnimState.Idle2, UnitAnimState.BothIdle)
end

function M:_onMeshModelLoaded()
	local unit = self._unit
	local animState = unit.meshModelMover:getMappedAnimation(UnitAnimState.Idle)
	local hitList = UnitAnimState.HitList

	for _, state in ipairs(hitList) do
		unit.meshModel:mapResourceAnimation(state, animState)
	end

	self:_updateFollowRoot()
end

function M:_updateFollowRoot()
	local goInst = self._unit.meshModel:getInst()

	if not goInst then
		return
	end

	self._unit.uiFollow:setMainGameObject(goutil.findChild(goInst, "lhand"))
end

return M
