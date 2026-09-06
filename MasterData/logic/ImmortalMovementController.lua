-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/controller/ImmortalMovementController.lua

module("logic.extensions.immortalmovement.controller.ImmortalMovementController", package.seeall)

local ImmortalMovementController = class("ImmortalMovementController", BaseController)

function ImmortalMovementController:onInit()
	self:onReset()
end

function ImmortalMovementController:onReset()
	self._fmtMoMap = {}
end

function ImmortalMovementController:openMissionview(activityId, stageId)
	local fmtMo = self._fmtMoMap[activityId]

	if not fmtMo then
		fmtMo = ImmortalMovementFmtMo.New()
		self._fmtMoMap[activityId] = fmtMo
	end

	fmtMo:initParams(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function ImmortalMovementController:getInfo(activityId)
	ImmortalMovementAgent.instance:sendPM_ImmortalMovementInfoReq(activityId)
end

function ImmortalMovementController:handleGetInfo(msg)
	ImmortalMovementModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ImmortalMovementGetInfo)
end

function ImmortalMovementController:unlockScore(activityId, scoreId)
	ImmortalMovementAgent.instance:sendPM_ImmortalMovementUnlockScoreReq(activityId, scoreId)
end

function ImmortalMovementController:handleUnlockScore(msg)
	ImmortalMovementModel.instance:onUnlockScore(msg)
	GlobalDispatcher:dispatch(GlobalNotify.ImmortalMovementUnlockScore)
end

function ImmortalMovementController:startChallenge(activityId, form_pb, stageId)
	ImmortalMovementAgent.instance:sendPM_ImmortalMovementChallengeReq(activityId, form_pb, stageId)
end

function ImmortalMovementController:handleNotifyChallenge(msg)
	local info = GameUtil.pbToTable(msg)

	BattleFacade.instance:registerResultHandler(nil, nil)
	BattleFacade.instance:registerResultHandler(function()
		ViewMgr.instance:open(ViewName.ImmortalMoveResultView, info)

		return true
	end)
end

function ImmortalMovementController:getCurDay(activityId)
	local activityType = ActivityDefineController.instance:getActTypeByActId(activityId)

	if activityType > 0 then
		local startTimeStamp, endTimeStamp = ActivityDefineController.instance:getStartTimeAndEndTime(activityType, activityId)
		local nowTime = ServerTime.now()
		local cfgs = ImmortalMovementConfig.instance:getGroupCfgs(activityId) or {}

		if #cfgs > 0 then
			local day = math.ceil((nowTime - startTimeStamp) / 86400)
			local days = #cfgs

			day = day % days

			if day == 0 then
				day = days
			end

			return day
		end
	end

	return 0
end

ImmortalMovementController.instance = ImmortalMovementController.New()

return ImmortalMovementController
