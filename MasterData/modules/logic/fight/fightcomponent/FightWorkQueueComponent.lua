-- chunkname: @modules/logic/fight/fightcomponent/FightWorkQueueComponent.lua

module("modules.logic.fight.fightcomponent.FightWorkQueueComponent", package.seeall)

local FightWorkQueueComponent = class("FightWorkQueueComponent", FightBaseClass)

function FightWorkQueueComponent:onConstructor()
	self.workQueue = {}
	self.callback = nil
	self.callbackHandle = nil
end

function FightWorkQueueComponent:registFinishCallback(callback, handle)
	self.callback = callback
	self.callbackHandle = handle
end

function FightWorkQueueComponent:clearFinishCallback()
	self.callback = nil
	self.callbackHandle = nil
end

function FightWorkQueueComponent:addWork(work, context)
	self:addWorkList({
		work
	}, context)
end

function FightWorkQueueComponent:addWorkList(workList, context)
	local immediately = #self.workQueue == 0

	for i, work in ipairs(workList) do
		work:registFinishCallback(self._onWorkFinish, self)
		table.insert(self.workQueue, {
			work = work,
			context = context
		})
	end

	if immediately then
		self:_onWorkFinish()
	end
end

function FightWorkQueueComponent:_onWorkFinish()
	local list = self.workQueue
	local tab = table.remove(list, 1)

	if tab then
		return tab.work:start(tab.context)
	elseif self.callback then
		self.callback(self.callbackHandle)
	end
end

function FightWorkQueueComponent:onDestructor()
	for i = #self.workQueue, 1, -1 do
		self.workQueue[i].work:disposeSelf()
	end

	self:clearFinishCallback()
end

return FightWorkQueueComponent
