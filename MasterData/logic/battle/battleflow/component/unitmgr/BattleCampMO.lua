-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/unitmgr/BattleCampMO.lua

module("logic.battle.battleflow.component.unitmgr.BattleCampMO", package.seeall)

local BattleCampMO = class("BattleCampMO", AbstractGlobalReusable)

function BattleCampMO:ctor(campId)
	self._campId = campId
	self._units = {}
end

function BattleCampMO:reuse(campId)
	self._campId = campId
end

function BattleCampMO:reset()
	self._campId = false

	BattleTableUtil.clearTable(self._units)
end

function BattleCampMO:destroy()
	self._campId = nil
	self._units = nil
end

function BattleCampMO:addUnit(unit)
	table.insert(self._units, unit)
end

function BattleCampMO:removeUnit(unit)
	table.removebyvalue(self._units, unit)
end

function BattleCampMO:getUnits()
	return self._units
end

function BattleCampMO:isEmpty()
	return #self._units <= 0
end

return BattleCampMO
