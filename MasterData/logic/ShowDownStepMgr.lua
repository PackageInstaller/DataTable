-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/data/ShowDownStepMgr.lua

module("logic.extensions.showdown.data.ShowDownStepMgr", package.seeall)

local ShowDownStepMgr = class("ShowDownStepMgr")

ShowDownStepMgr.MgrState_Running = "MgrState_Running"
ShowDownStepMgr.MgrState_Standby = "MgrState_Standby"

function ShowDownStepMgr:ctor(activityId)
	self._activityId = activityId
	self._mgrState = ShowDownStepMgr.MgrState_Standby
	self._tickingDelta = 1
	self._stepTimeList = {}
	self._voteStepTimeList = {}
	self._stepCfg = ShowDownConfig.instance:getStepCfg(self._activityId)

	if self._stepCfg then
		for stepId, stepData in ipairs(self._stepCfg) do
			if self._stepTimeList then
				local startStamp, endStamp = ShowDownController.instance:getStepTimeStamp(self._activityId, stepId, stepId + 1)

				if startStamp == 0 or endStamp == 0 then
					printError(string.format("ShowDownStepMgr:ctor, stepId = %s, 缺失startTime or endTime", stepId, stepId + 1))
				end

				self._stepTimeList[stepId] = {
					startStamp + 5,
					endStamp + 5
				}
			end

			if stepData.canGuess then
				local startStamp, endStamp = ShowDownController.instance:getStepTimeStamp(self._activityId, stepId, stepId + 1)

				for i = stepId, 1, -1 do
					local data = self._stepCfg[i]

					if data and data.canGuess then
						local s, e = ShowDownController.instance:getStepTimeStamp(self._activityId, i, i + 1)

						startStamp = s
					else
						break
					end
				end

				for i = stepId, #self._stepCfg do
					local data = self._stepCfg[i]

					if data and data.canGuess then
						local s, e = ShowDownController.instance:getStepTimeStamp(self._activityId, i, i + 1)

						endStamp = e
					else
						break
					end
				end

				self._voteStepTimeList[stepId] = {
					startStamp,
					endStamp
				}
			end
		end
	else
		printError(string.format("ShowDownStepMgr:ctor, stepCfg is nil, activityId = %s", activityId))
	end

	self._curClientStepId = 0
	self._nextStepId = 0
	self._maxStepId = #self._stepTimeList
end

function ShowDownStepMgr:onEnter()
	self._oldFitStepId = -1
	self._curClientStepId = 0
	self._nextStepId = 0
	self._curServerStepId = 0
	self._curTimeStamp = ServerTime.now()

	self:_onTicking()
	settimer(self._tickingDelta, self._onTicking, self)

	self._mgrState = ShowDownStepMgr.MgrState_Running

	GlobalDispatcher:addListener(GlobalNotify.HandlePM_ShowDown_GetStepInfoRes, self._updateServerStepId, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_ShowDown_NotifyStepChangeRes, self._updateServerStepId, self)
end

function ShowDownStepMgr:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_ShowDown_GetStepInfoRes, self._updateServerStepId, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandlePM_ShowDown_NotifyStepChangeRes, self._updateServerStepId, self)

	self._mgrState = ShowDownStepMgr.MgrState_Standby
	self._curTimeStamp = 0

	removetimer(self._onTicking, self)
end

function ShowDownStepMgr:onDestroy()
	return
end

function ShowDownStepMgr:_onTicking()
	self._curTimeStamp = ServerTime.now()
end

function ShowDownStepMgr:_updateServerStepId()
	self._curServerStepId = ShowDownController.instance:getShowDownMo(self._activityId):getCurStepId()

	self:_onTicking()
	GlobalDispatcher:dispatch(GlobalNotify.ShowDownStepChange, self._activityId)
end

function ShowDownStepMgr:getCurStepId()
	return self._curServerStepId
end

function ShowDownStepMgr:getMgrState()
	return self._mgrState
end

function ShowDownStepMgr:getLeftTimeStampToNext(stepId)
	return Mathf.Max(self:getStepEndTimeStamp(stepId) - self._curTimeStamp, 0)
end

function ShowDownStepMgr:getLeftTimeStampToNextInVote(stepId)
	return Mathf.Max(((self._voteStepTimeList[stepId] or nil) and self._voteStepTimeList[stepId][2]) - self._curTimeStamp, 0)
end

function ShowDownStepMgr:getStepEndTimeStamp(stepId)
	return self._stepTimeList[stepId][2]
end

return ShowDownStepMgr
