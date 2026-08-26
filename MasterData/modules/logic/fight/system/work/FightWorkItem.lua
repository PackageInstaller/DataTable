-- chunkname: @modules/logic/fight/system/work/FightWorkItem.lua

module("modules.logic.fight.system.work.FightWorkItem", package.seeall)

local FightWorkItem = class("FightWorkItem", FightBaseClass)

FightWorkItem.IS_FIGHT_WORK = true

function FightWorkItem:onConstructor()
	self.CALLBACK = {}
	self.SAFETIME = 0.5
	self.WORK_IS_FINISHED = nil
	self.STARTED = nil
	self.SAFETIMER = nil
	self.FIGHT_WORK_ENTRUSTED = nil
	self.SUCCEEDED = nil
end

function FightWorkItem:start(context)
	return xpcall(FightWorkItem.__start, __G__TRACKBACK__, self, context)
end

function FightWorkItem:__start(context)
	if self.WORK_IS_FINISHED then
		logError("work已经结束了,但是又被调用了start,请检查代码,类名:" .. self.__cname)

		return
	end

	if self.STARTED then
		logError("work已经开始了,但是又被调用了start,请检查代码,类名:" .. self.__cname)

		return
	end

	if self.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了start,请检查代码,类名:" .. self.__cname)

		return
	end

	if self.IS_RELEASING then
		logError("work正在被释放中,但是又被调用了start,请检查代码,类名:" .. self.__cname)

		return
	end

	self.context = self.context or context
	self.STARTED = true
	self.EXCLUSIVETIMER = {}
	self.SAFETIMER = self:com_registTimer(self._fightWorkSafeTimer, self.SAFETIME)

	table.insert(self.EXCLUSIVETIMER, self.SAFETIMER)
	self:beforeStart()

	return self:onStart()
end

function FightWorkItem:cancelFightWorkSafeTimer()
	return self:com_cancelTimer(self.SAFETIMER)
end

function FightWorkItem:_fightWorkSafeTimer()
	logError("战斗保底 fightwork ondone, className = " .. self.__cname)

	return self:onDone(false)
end

function FightWorkItem:_delayAfterPerformance()
	return self:onDone(true)
end

function FightWorkItem:_delayDone()
	return self:onDone(true)
end

function FightWorkItem:finishWork()
	return self:onDone(true)
end

function FightWorkItem:playWorkAndDone(work, context)
	if not work then
		return self:onDone(true)
	end

	work:registFinishCallback(self.finishWork, self)
	self:cancelFightWorkSafeTimer()

	if work.STARTED then
		return
	end

	work:start(context)
end

function FightWorkItem:com_registTimer(callBack, time, param)
	if callBack == self._delayDone or callBack == self._delayAfterPerformance or callBack == self.finishWork then
		self:releaseExclusiveTimer()

		local timer = FightWorkItem.super.com_registTimer(self, callBack, time, param)

		table.insert(self.EXCLUSIVETIMER, timer)

		return timer
	end

	return FightWorkItem.super.com_registTimer(self, callBack, time, param)
end

function FightWorkItem:releaseExclusiveTimer()
	if self.EXCLUSIVETIMER then
		for i = #self.EXCLUSIVETIMER, 1, -1 do
			self:com_cancelTimer(self.EXCLUSIVETIMER[i])
			table.remove(self.EXCLUSIVETIMER, i)
		end
	end
end

function FightWorkItem:com_registWorkDoneFlowSequence()
	local flow = self:com_registCustomFlow(FightWorkDoneFlowSequence)

	flow:registFinishCallback(self.finishWork, self)

	return flow
end

function FightWorkItem:com_registWorkDoneFlowParallel()
	local flow = self:com_registCustomFlow(FightWorkDoneFlowParallel)

	flow:registFinishCallback(self.finishWork, self)

	return flow
end

function FightWorkItem:beforeStart()
	return
end

function FightWorkItem:onStart()
	return
end

function FightWorkItem:beforeClearWork()
	return
end

function FightWorkItem:clearWork()
	return
end

function FightWorkItem:registFinishCallback(callback, handle, param)
	if self.IS_DISPOSED or self.WORK_IS_FINISHED then
		return callback(handle, param)
	end

	table.insert(self.CALLBACK, {
		callback = callback,
		handle = handle,
		param = param
	})
end

function FightWorkItem:onDestructor()
	if self.STARTED then
		self:beforeClearWork()

		return self:clearWork()
	end
end

function FightWorkItem:onDestructorFinish()
	self:playCallback(self.CALLBACK)

	self.CALLBACK = nil
end

function FightWorkItem:playCallback(callbackList)
	if self.WORK_IS_FINISHED or self.STARTED then
		for i, v in ipairs(callbackList) do
			if not self.WORK_IS_FINISHED then
				local playCallback = self.FIGHT_WORK_ENTRUSTED

				if self.CALLBACK_EVEN_IF_UNFINISHED and not self.WORK_IS_FINISHED and self.STARTED then
					playCallback = true
				end

				if self.WORK_IS_FINISHED then
					-- block empty
				end
			end

			::label_21_3::
		end
	end
end

function FightWorkItem:onDone(succeeded)
	if self.FIGHT_WORK_ENTRUSTED then
		self.FIGHT_WORK_ENTRUSTED = nil
	end

	if self.IS_DISPOSED then
		logError("work已经被释放了,但是又被调用了onDone,请检查代码,类名:" .. self.__cname)

		return
	end

	if self.WORK_IS_FINISHED then
		logError("work已经完成了,但是又被调用了onDone,请检查代码,类名:" .. self.__cname)

		return
	end

	self.WORK_IS_FINISHED = true
	self.SUCCEEDED = succeeded

	return self:disposeSelf()
end

function FightWorkItem:onDoneAndKeepPlay()
	local reply = FightMsgMgr.sendMsg(FightMsgId.EntrustFightWork, self)

	if not reply then
		logError("托管fightwork未成功,类名:" .. self.__cname)
		self:onDone(true)

		return
	end

	self.SUCCEEDED = true
	self.IS_ON_DONE_AND_KEEP_PLAY = true

	local callbackList = tabletool.copy(self.CALLBACK)

	self.CALLBACK = {}

	self:playCallback(callbackList)
end

function FightWorkItem:isAlive()
	return not self.IS_DISPOSED and not self.WORK_IS_FINISHED and not self.IS_ON_DONE_AND_KEEP_PLAY
end

function FightWorkItem:disposeSelf()
	if self.FIGHT_WORK_ENTRUSTED then
		return
	end

	FightWorkItem.super.disposeSelf(self)
end

return FightWorkItem
