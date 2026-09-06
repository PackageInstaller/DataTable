-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/data/GdcCardStepMgr.lua

module("logic.extensions.goddesscontest.data.GdcCardStepMgr", package.seeall)

local GdcCardStepMgr = class("GdcCardStepMgr")

function GdcCardStepMgr:ctor(activityId)
	self._activityId = activityId
	self._cardStepCfg = GoddessContestConfig.instance:getCardStepCfg(activityId)
	self._tickingDelta = 1
	self._firstInterVal = GoddessContestController.instance:getFirstStepInterval()
	self._lastInterval = GoddessContestController.instance:getLastStepInterval()

	self:onReset()
end

function GdcCardStepMgr:onReset()
	self._isNeedNotifyStepChange = false
	self._notifyChangeTickTime = 0
	self._intervalList = {}

	for stepId, data in ipairs(self._cardStepCfg) do
		self._intervalList[stepId] = GoddessContestController.instance:getStepInterval(self._activityId, stepId)
	end
end

function GdcCardStepMgr:onEnter()
	self:onReset()
	self:_onTicking()
	settimer(self._tickingDelta, self._onTicking, self)
end

function GdcCardStepMgr:onExit()
	removetimer(self._onTicking, self)

	self._isNeedNotifyStepChange = false
end

function GdcCardStepMgr:onDestroy()
	return
end

function GdcCardStepMgr:_onTicking()
	for stepId, stepInterval in ipairs(self._intervalList) do
		if stepInterval < self._lastInterval then
			self._intervalList[stepId] = GoddessContestController.instance:getStepInterval(self._activityId, stepId)

			if stepInterval ~= self._intervalList[stepId] then
				self._isNeedNotifyStepChange = true
			end
		end
	end

	if self._isNeedNotifyStepChange then
		self._notifyChangeTickTime = self._notifyChangeTickTime + self._tickingDelta

		if self._notifyChangeTickTime >= GdcCardEnum.DelayNotifyStepChangeTime then
			self._isNeedNotifyStepChange = false
			self._notifyChangeTickTime = 0

			GlobalDispatcher:dispatch(GlobalNotify.GoddessContestCardConIntervalChange)
		end
	end
end

return GdcCardStepMgr
