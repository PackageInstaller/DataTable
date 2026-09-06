-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dualdragonchallenge/controller/DualdragonchallengeController.lua

module("logic.extensions.dualdragonchallenge.controller.DualdragonchallengeController", package.seeall)

local DualdragonchallengeController = class("DualdragonchallengeController", BaseController)

function DualdragonchallengeController:ctor()
	return
end

function DualdragonchallengeController:onInit()
	self:onReset()
end

function DualdragonchallengeController:onReset()
	self._extremeFmtMo = nil
	self._universalFmtMo = nil

	GlobalDispatcher:addListener("enterdualdragonclg", self._enterdualdragonclg, self)
end

function DualdragonchallengeController:enterUniversalMission(activityId, creepsMasterId)
	self._universalFmtMo = self._universalFmtMo or DualdragonUniversalChallengeFmtMo.New()

	self._universalFmtMo:initParams(activityId, creepsMasterId)
	CustomFmtController.instance:showMissionView(self._universalFmtMo)
end

function DualdragonchallengeController:enterExtremeMission(activityId, groupId, stageId)
	self._extremeFmtMo = self._extremeFmtMo or DualdragonExtremeChallengeFmtMo.New()

	self._extremeFmtMo:initParams(activityId, groupId, stageId)
	CustomFmtController.instance:showMissionView(self._extremeFmtMo)
end

function DualdragonchallengeController:resetExtreme()
	if self._resetInfo then
		DualdragonchallengeModel.instance:resetExtreme(self._resetInfo.activityId, self._resetInfo.groupId, self._resetInfo.stageId)
	end
end

function DualdragonchallengeController:sendPM_DualDragonResetExtremeReq(activityId, groupId, stageId)
	self._resetInfo = {
		activityId = activityId,
		groupId = groupId,
		stageId = stageId
	}

	DualDragonChallengeAgent.instance:sendPM_DualDragonResetExtremeReq(activityId, groupId, stageId)
end

function DualdragonchallengeController:sendPM_DualDragonExtremeChallengeReq(activityId, groupId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		return false
	end)
	DualDragonChallengeAgent.instance:sendPM_DualDragonExtremeChallengeReq(activityId, groupId, stageId, form)
end

function DualdragonchallengeController:handlePM_DualDragonExtremeChallengeRes(msg)
	return
end

function DualdragonchallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DualDragon)
end

function DualdragonchallengeController:_enterdualdragonclg(params)
	self:enterdualdragonclg(checknumber(params[1]))
end

function DualdragonchallengeController:enterdualdragonclg(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.DualdragonchallengemainView, activityId)
end

DualdragonchallengeController.instance = DualdragonchallengeController.New()

return DualdragonchallengeController
