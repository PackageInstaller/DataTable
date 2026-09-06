-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/view/component/LoadingCompProgress.lua

module(..., package.seeall)

local LoadingCompProgress = class("LoadingCompProgress", LoadingCompBase)

function LoadingCompProgress:onInit()
	self.TIME_TO_END = 5
	self.FINISH_TIME_TO_END = 0.3
	self._finishTime = 0
	self._targetProgress = 0
	self._startTime = 0
	self._curProgress = 0
	self._totalProgress = 1
	self._progressing = false
end

function LoadingCompProgress:onReset()
	self._curProgress = 0
	self._totalProgress = 1
	self._progressing = false
end

function LoadingCompProgress:onEnter()
	self._startTime = Time.time
	self._finishTime = 0
	self._curProgress = 0
	self._targetProgress = 0
	self._progressing = true

	self:_setTimerOn(true)
end

function LoadingCompProgress:onExit()
	self:_setTimerOn(false)
end

function LoadingCompProgress:getTotalProgress()
	return self._totalProgress
end

function LoadingCompProgress:getCurProgress()
	return self._curProgress
end

function LoadingCompProgress:setTargetProgress(value)
	if value <= self._targetProgress then
		return
	end

	self._targetProgress = value
end

function LoadingCompProgress:setLoadingTips(tips)
	self:dispatch(LoadingNotify.OnLoadingTipsUpdate, tips)
end

function LoadingCompProgress:isProgressing()
	return self._progressing
end

function LoadingCompProgress:_setCurProgress(value)
	if value <= self._curProgress then
		return
	end

	self._curProgress = value

	self:notifyProgressUpdate()
end

function LoadingCompProgress:toString()
	return self._curProgress / self._totalProgress
end

function LoadingCompProgress:notifyProgressUpdate()
	self:dispatch(LoadingNotify.OnProgressUpdate)
end

function LoadingCompProgress:_setTimerOn(isOn)
	if isOn then
		Scheduler.removeListener(self._onTimer, self)
		Scheduler.addListener(0, self._onTimer, self, true)
	else
		Scheduler.removeListener(self._onTimer, self)
	end
end

function LoadingCompProgress:_onTimer()
	local toSetProgress = self._totalProgress

	if self._targetProgress >= self._totalProgress and self._finishTime < self.FINISH_TIME_TO_END then
		local leftProgress = self._totalProgress - self._curProgress
		local leftTime = self.FINISH_TIME_TO_END - self._finishTime
		local dt = Time.deltaTime

		toSetProgress = self._curProgress + leftProgress / leftTime * dt
		self._finishTime = self._finishTime + dt
	elseif self._curProgress < self._totalProgress then
		toSetProgress = (Time.time - self._startTime) / self.TIME_TO_END * self._totalProgress
	end

	if toSetProgress < 0 then
		toSetProgress = 0
	elseif toSetProgress > self._targetProgress then
		toSetProgress = self._targetProgress
	end

	if toSetProgress > self._curProgress then
		self:_setCurProgress(toSetProgress)
	end

	if self._curProgress >= self._totalProgress then
		if self._progressing then
			self._progressing = false
		else
			self:_setTimerOn(false)

			if self._loading:isWaitAndDoClose() == true then
				self._loading:hide(true)
			end

			LoadingFacade.instance:invokeLoadingListener()
		end
	end
end

return LoadingCompProgress
