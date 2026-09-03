-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleUnitStates.lua

BattleUnitState = State
UnitSimpleState = class("UnitSimpleState", BattleUnitState, _M)

function UnitSimpleState:initialize(name, duration)
	super.initialize(self, name)

	self._duration = duration
end

function UnitSimpleState:enter(fsmComp)
	self._elapsed = 0
end

function UnitSimpleState:exit(fsmComp)
	return
end

function UnitSimpleState:update(fsmComp, dt, battleContext)
	local elapsed = self._elapsed + dt

	self._elapsed = elapsed

	if elapsed < self._duration then
		return
	end

	fsmComp:changeState(nil)
end
