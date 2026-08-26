-- chunkname: @modules/logic/fight/fightcomponent/FightWorkParallelComponent.lua

module("modules.logic.fight.fightcomponent.FightWorkParallelComponent", package.seeall)

local FightWorkParallelComponent = class("FightWorkParallelComponent", FightBaseClass)

function FightWorkParallelComponent:onConstructor()
	self.workParallel = {}
	self.callback = nil
	self.callbackHandle = nil
	self.finishCount = 0
end

function FightWorkParallelComponent:registFinishCallback(callback, handle)
	self.callback = callback
	self.callbackHandle = handle
end

function FightWorkParallelComponent:clearFinishCallback()
	self.callback = nil
	self.callbackHandle = nil
end

function FightWorkParallelComponent:addWork(work, context)
	self:addWorkList({
		work
	}, context)
end

function FightWorkParallelComponent:addWorkList(workList, context)
	for i, work in ipairs(workList) do
		work:registFinishCallback(self._onWorkFinish, self)
		table.insert(self.workParallel, {
			work = work,
			context = context
		})
	end

	for i, work in ipairs(workList) do
		work:start(context)
	end
end

function FightWorkParallelComponent:_onWorkFinish()
	self.finishCount = self.finishCount + 1

	if self.finishCount == #self.workParallel and self.callback then
		self.callback(self.callbackHandle)
	end
end

function FightWorkParallelComponent:onDestructor()
	for i = #self.workParallel, 1, -1 do
		self.workParallel[i].work:disposeSelf()
	end

	self:clearFinishCallback()
end

return FightWorkParallelComponent
