-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originashlessdragon/controller/OriginAshlessDragonController.lua

module("logic.extensions.originashlessdragon.controller.OriginAshlessDragonController", package.seeall)

local OriginAshlessDragonController = class("OriginAshlessDragonController", BaseController)

function OriginAshlessDragonController:onInit()
	return
end

function OriginAshlessDragonController:onReset()
	return
end

function OriginAshlessDragonController:sendPM_OriginAshlessDragonGetInfoReq(activityId)
	OriginAshlessDragonAgent.instance:sendPM_OriginAshlessDragonGetInfoReq(activityId)
end

function OriginAshlessDragonController:handlePM_OriginAshlessDragonGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAshlessDragonGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAshlessDragonGetInfoRes)
end

function OriginAshlessDragonController:sendPM_OriginAshlessDragonChallengeReq(activityId, phaseId, stageId, form_pb, investBudget)
	OriginAshlessDragonAgent.instance:sendPM_OriginAshlessDragonChallengeReq(activityId, phaseId, stageId, form_pb, investBudget)
end

function OriginAshlessDragonController:handlePM_OriginAshlessDragonChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAshlessDragonChallengeRes)
end

function OriginAshlessDragonController:sendPM_OriginAshlessDragonConfirmReq(activityId, phaseId, stageId, save)
	OriginAshlessDragonAgent.instance:sendPM_OriginAshlessDragonConfirmReq(activityId, phaseId, stageId, save)
end

function OriginAshlessDragonController:handlePM_OriginAshlessDragonConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_OriginAshlessDragonConfirmRes(msg)

		if msg:HasField("changeSetId") then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			mo:saveChangeSetId(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAshlessDragonConfirmRes, status, msg)
end

function OriginAshlessDragonController:sendPM_OriginAshlessDragonResetReq(activityId, phaseId)
	OriginAshlessDragonAgent.instance:sendPM_OriginAshlessDragonResetReq(activityId, phaseId)
end

function OriginAshlessDragonController:handlePM_OriginAshlessDragonResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginAshlessDragonResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginAshlessDragonResetRes)
end

function OriginAshlessDragonController:handlePM_Notify_OriginAshlessDragonChallengeEndRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_Notify_OriginAshlessDragonChallengeEndRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_OriginAshlessDragonChallengeEndRes)
end

function OriginAshlessDragonController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginAshlessDragon)
end

function OriginAshlessDragonController:getSubMo(activityId)
	return OriginAshlessDragonModel.instance:getSubMo(activityId)
end

function OriginAshlessDragonController:enterStageBattle(activityId, phaseId, stageId, investBudget)
	local fmtMo = OriginAshlessDragonModel.instance:getFmtMo(activityId)

	fmtMo:updateCfg(activityId, phaseId, stageId, investBudget)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginAshlessDragonController.instance = OriginAshlessDragonController.New()

return OriginAshlessDragonController
