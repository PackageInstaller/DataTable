-- chunkname: @modules/logic/fight/fightcomponent/FightWorkComponent.lua

module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

local FightWorkComponent = class("FightWorkComponent", FightBaseClass)

function FightWorkComponent:onConstructor()
	self.workList = {}
	self.count = 0
end

function FightWorkComponent:registWork(class, ...)
	local work = self:newClass(class, ...)

	self.count = self.count + 1
	self.workList[self.count] = work

	work:registFinishCallback(self.onWorkFinish, self)

	return work
end

function FightWorkComponent:playWork(class, ...)
	local work = self:newClass(class, ...)

	self.count = self.count + 1
	self.workList[self.count] = work

	work:registFinishCallback(self.onWorkFinish, self)

	return work:start()
end

function FightWorkComponent:addWork(work)
	self.count = self.count + 1
	self.workList[self.count] = work

	work:registFinishCallback(self.onWorkFinish, self)

	return work
end

function FightWorkComponent:onWorkFinish()
	self:com_registSingleTimer(self.clearDeadWork, 1)
end

function FightWorkComponent:clearDeadWork()
	local j = 1

	for i = 1, self.count do
		local item = self.workList[i]

		if not item.IS_DISPOSED then
			if i ~= j then
				self.workList[j] = item
				self.workList[i] = nil
			end

			j = j + 1
		else
			self.workList[i] = nil
		end
	end

	self.count = j - 1
end

function FightWorkComponent:getWorkList()
	return self.workList
end

function FightWorkComponent:getAliveWorkList()
	local aliveWorkList = {}

	for i, work in ipairs(self.workList) do
		if work:isAlive() then
			table.insert(aliveWorkList, work)
		end
	end

	return aliveWorkList
end

function FightWorkComponent:hasAliveWork()
	for i, work in ipairs(self.workList) do
		if work:isAlive() then
			return true
		end
	end

	return false
end

function FightWorkComponent:disposeAllWork()
	for i = self.count, 1, -1 do
		self.workList[i]:disposeSelf()
	end

	self:com_registSingleTimer(self.clearDeadWork, 1)
end

function FightWorkComponent:onDestructor()
	for i = self.count, 1, -1 do
		self.workList[i]:disposeSelf()
	end

	self.workList = nil
end

return FightWorkComponent
