-- chunkname: @modules/logic/fight/system/work/FightWorkFunction.lua

module("modules.logic.fight.system.work.FightWorkFunction", package.seeall)

local FightWorkFunction = class("FightWorkFunction", FightWorkItem)

function FightWorkFunction:onConstructor(func, target, ...)
	self._func = func
	self._target = target
	self._param = {
		...
	}
	self._paramCount = select("#", ...)
end

function FightWorkFunction:onStart()
	self._func(self._target, unpack(self._param, 1, self._paramCount))

	if not self.IS_DISPOSED and not self.IS_RELEASING then
		self:onDone(true)
	end
end

return FightWorkFunction
