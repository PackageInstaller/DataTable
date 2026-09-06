-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingorderclg/controller/OriginKingOrderClgController.lua

module("logic.extensions.originkingorderclg.controller.OriginKingOrderClgController", package.seeall)

local OriginKingOrderClgController = class("OriginKingOrderClgController", BaseController)

function OriginKingOrderClgController:onInit()
	return
end

function OriginKingOrderClgController:onReset()
	return
end

function OriginKingOrderClgController:sendPM_OriginKingOrderClgGetInfoReq(activityId)
	OriginKingOrderClgAgent.instance:sendPM_OriginKingOrderClgGetInfoReq(activityId)
end

function OriginKingOrderClgController:handlePM_OriginKingOrderClgGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingOrderClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingOrderClgGetInfoRes)
end

function OriginKingOrderClgController:sendPM_OriginKingOrderClgFightReq(activityId, stageId, form)
	OriginKingOrderClgAgent.instance:sendPM_OriginKingOrderClgFightReq(activityId, stageId, form)
end

function OriginKingOrderClgController:handlePM_OriginKingOrderClgFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingOrderClgFightRes)
end

function OriginKingOrderClgController:handlePM_Notify_OriginKingOrderClgFightRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_Notify_OriginKingOrderClgFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_OriginKingOrderClgFightRes)
end

function OriginKingOrderClgController:sendPM_OriginKingOrderClgResetReq(activityId)
	OriginKingOrderClgAgent.instance:sendPM_OriginKingOrderClgResetReq(activityId)
end

function OriginKingOrderClgController:handlePM_OriginKingOrderClgResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingOrderClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingOrderClgResetRes)
end

function OriginKingOrderClgController:sendPM_OriginKingOrderClgConfirmReq(activityId, stageId, save)
	OriginKingOrderClgAgent.instance:sendPM_OriginKingOrderClgConfirmReq(activityId, stageId, save)
end

function OriginKingOrderClgController:handlePM_OriginKingOrderClgConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_OriginKingOrderClgConfirmRes(msg)

		if msg.changeSetId and msg.changeSetId > 0 then
			MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
			mo:saveChangeSetId(msg.changeSetId)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingOrderClgConfirmRes, status, msg)
end

function OriginKingOrderClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginKingOrderClg)
end

function OriginKingOrderClgController:getSubMo(activityId)
	return OriginKingOrderClgModel.instance:getSubMo(activityId)
end

function OriginKingOrderClgController:enterStageBattle(activityId, stageId)
	local fmtMo = OriginKingOrderClgModel.instance:getFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginKingOrderClgController.instance = OriginKingOrderClgController.New()

return OriginKingOrderClgController
