-- chunkname: @modules/logic/fight/system/work/FightWorkFlowParallel.lua

module("modules.logic.fight.system.work.FightWorkFlowParallel", package.seeall)

local FightWorkFlowParallel = class("FightWorkFlowParallel", FightWorkFlowBase)

function FightWorkFlowParallel:onConstructor()
	self._workList = {}
	self._finishCount = 0
end

function FightWorkFlowParallel:registWork(class, ...)
	local work = self:newClass(class, ...)

	self:addWork(work)

	return work
end

function FightWorkFlowParallel:addWork(work)
	if not work then
		return
	end

	if not work.IS_FIGHT_WORK then
		work = FightWorkPlayNormalWork.New(work)
	end

	work.registFinishCallback(work, self.onWorkItemDone, self, work)
	table.insert(self._workList, work)
end

function FightWorkFlowParallel:listen2Work(work)
	return self:registWork(FightWorkListen2WorkDone, work)
end

function FightWorkFlowParallel:onStart()
	self:cancelFightWorkSafeTimer()

	if #self._workList == 0 then
		return self:onDone(true)
	else
		for i, work in ipairs(self._workList) do
			if work.WORK_IS_FINISHED or work.IS_DISPOSED then
				self._finishCount = self._finishCount + 1
			elseif not work.STARTED then
				xpcall(work.start, __G__TRACKBACK__, work, self.context)
			end
		end

		if not self.IS_DISPOSED and self._finishCount == #self._workList then
			return self:onDone(true)
		end
	end
end

function FightWorkFlowParallel:onWorkItemDone(doneWork)
	self._finishCount = self._finishCount + 1

	if self._finishCount == #self._workList then
		return self:onDone(true)
	end
end

function FightWorkFlowParallel:onDestructor()
	for i = #self._workList, 1, -1 do
		self._workList[i]:disposeSelf()
	end
end

return FightWorkFlowParallel
