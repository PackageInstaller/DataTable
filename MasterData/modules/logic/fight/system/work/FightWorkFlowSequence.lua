-- chunkname: @modules/logic/fight/system/work/FightWorkFlowSequence.lua

module("modules.logic.fight.system.work.FightWorkFlowSequence", package.seeall)

local FightWorkFlowSequence = class("FightWorkFlowSequence", FightWorkFlowBase)

function FightWorkFlowSequence:onConstructor()
	self._workList = {}
	self._curIndex = 0
	self._startIndex = 0
	self._playStartCount = 0
end

function FightWorkFlowSequence:registWork(class, ...)
	return self:registWorkAtIndex(#self._workList + 1, class, ...)
end

function FightWorkFlowSequence:registWorkAtIndex(index, class, ...)
	local work = self:newClass(class, ...)

	self:addWorkAtIndex(index, work)

	return work
end

function FightWorkFlowSequence:addWork(work)
	if not work then
		return
	end

	if not work.IS_FIGHT_WORK then
		work = FightWorkPlayNormalWork.New(work)
	end

	self:addWorkAtIndex(#self._workList + 1, work)
end

function FightWorkFlowSequence:addWorkAtIndex(index, work)
	if not work then
		return
	end

	work.registFinishCallback(work, self.onWorkItemDone, self, work)
	table.insert(self._workList, index, work)
end

function FightWorkFlowSequence:listen2Work(work)
	self:listen2WorkAtIndex(#self._workList + 1, work)
end

function FightWorkFlowSequence:listen2WorkAtIndex(index, work)
	self:registWorkAtIndex(index, FightWorkListen2WorkDone, work)
end

function FightWorkFlowSequence:onStart()
	self:cancelFightWorkSafeTimer()

	return self:_playNext()
end

function FightWorkFlowSequence:_playNext()
	self._curIndex = self._curIndex + 1

	local work = self._workList[self._curIndex]

	if work then
		if work.WORK_IS_FINISHED or work.IS_DISPOSED then
			return self:_playNext()
		elseif not work.STARTED then
			self._playStartCount = self._playStartCount + 1

			if self._playStartCount == 1 then
				self._startIndex = self._curIndex

				while self._playStartCount ~= 0 do
					local startWork = self._workList[self._startIndex]

					xpcall(startWork.start, __G__TRACKBACK__, startWork, self.context)

					self._playStartCount = self._playStartCount - 1
					self._startIndex = self._startIndex + 1
				end

				if self._curIndex > #self._workList then
					return self:onDone(true)
				end
			elseif self._playStartCount < 1 then
				return self:onDone(true)
			end
		end
	elseif self._playStartCount == 0 then
		return self:onDone(true)
	end
end

function FightWorkFlowSequence:onWorkItemDone(doneWork)
	local work = self._workList[self._curIndex]

	if doneWork == work then
		return self:_playNext()
	end
end

function FightWorkFlowSequence:onDestructor()
	for i = #self._workList, 1, -1 do
		self._workList[i]:disposeSelf()
	end
end

function FightWorkFlowSequence:registWorkAtNext(class, ...)
	return self:registWorkAtIndex(self._curIndex + 1, class, ...)
end

function FightWorkFlowSequence:addWorkAtNext(work)
	if not work then
		return
	end

	self:addWorkAtIndex(self._curIndex + 1, work)
end

function FightWorkFlowSequence:listen2WorkAtNext(work)
	self:listen2WorkAtIndex(self._curIndex + 1, work)
end

return FightWorkFlowSequence
