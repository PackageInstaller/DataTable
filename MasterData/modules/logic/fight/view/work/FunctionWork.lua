-- chunkname: @modules/logic/fight/view/work/FunctionWork.lua

module("modules.logic.fight.view.work.FunctionWork", package.seeall)

local FunctionWork = class("FunctionWork", BaseWork)

function FunctionWork:ctor(func, target, ...)
	self:setParam(func, target, ...)
end

function FunctionWork:setParam(func, target, a1, a2, a3, a4, a5)
	self._func = func
	self._target = target
	self._a1 = a1
	self._a2 = a2
	self._a3 = a3
	self._a4 = a4
	self._a5 = a5
end

function FunctionWork:onStart()
	self._func(self._target, self._a1, self._a2, self._a3, self._a4, self._a5)
	self:onDone(true)
end

return FunctionWork
