-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/traps/traps/LockCellTrap.lua

LockCellTrap = class("LockCellTrap", TrapEffect, _M)

function LockCellTrap:initialize(config)
	super.initialize(self, config)
end

function LockCellTrap:putTrap(cell, trapObject)
	super.putTrap(self, cell, trapObject)
	cell:setIsLocked(true)

	return true, {
		evt = "LockCell",
		cellId = cell:getId()
	}
end

function LockCellTrap:cancelTrap(cell, trapObject)
	local _cell = trapObject:getEffectValue(self, "targetCell")

	if _cell == nil or _cell ~= cell then
		return false
	end

	cell:setIsLocked(false)
	super.cancelTrap(self, cell, trapObject)

	return true, {
		evt = "UnLockCell",
		cellId = cell:getId()
	}
end
