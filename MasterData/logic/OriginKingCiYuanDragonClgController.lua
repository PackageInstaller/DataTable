-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingciyuandragonclg/controller/OriginKingCiYuanDragonClgController.lua

module("logic.extensions.originkingciyuandragonclg.controller.OriginKingCiYuanDragonClgController", package.seeall)

local OriginKingCiYuanDragonClgController = class("OriginKingCiYuanDragonClgController", BaseController)

function OriginKingCiYuanDragonClgController:onInit()
	return
end

function OriginKingCiYuanDragonClgController:onReset()
	return
end

function OriginKingCiYuanDragonClgController:sendPM_OriginKingCiYuanDragonClgGetInfoReq(activityId)
	OriginKingCiYuanDragonClgAgent.instance:sendPM_OriginKingCiYuanDragonClgGetInfoReq(activityId)
end

function OriginKingCiYuanDragonClgController:handlePM_OriginKingCiYuanDragonClgGetInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingCiYuanDragonClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingCiYuanDragonClgGetInfoRes, msg)
end

function OriginKingCiYuanDragonClgController:sendPM_OriginKingCiYuanDragonClgFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local subMo = self:getSubMo(activityId)
		local msg = subMo:getFightResultMsg()

		if msg and msg.isWin then
			UIStateManager.instance:push(ViewName.OriginKingCiYuanDragonClgSurePopView, activityId)

			result = true
		end

		return result
	end)
	OriginKingCiYuanDragonClgAgent.instance:sendPM_OriginKingCiYuanDragonClgFightReq(activityId, stageId, form)
end

function OriginKingCiYuanDragonClgController:handlePM_OriginKingCiYuanDragonClgFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingCiYuanDragonClgFightRes, msg)
end

function OriginKingCiYuanDragonClgController:handlePM_OriginKingCiYuanDragonClgNotifyFightRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingCiYuanDragonClgNotifyFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingCiYuanDragonClgNotifyFightRes, msg)
end

function OriginKingCiYuanDragonClgController:sendPM_OriginKingCiYuanDragonClgConfirmReq(activityId, stageId)
	OriginKingCiYuanDragonClgAgent.instance:sendPM_OriginKingCiYuanDragonClgConfirmReq(activityId, stageId)
end

function OriginKingCiYuanDragonClgController:handlePM_OriginKingCiYuanDragonClgConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_OriginKingCiYuanDragonClgConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingCiYuanDragonClgConfirmRes, status, msg)
end

function OriginKingCiYuanDragonClgController:sendPM_OriginKingCiYuanDragonClgResetReq(activityId)
	OriginKingCiYuanDragonClgAgent.instance:sendPM_OriginKingCiYuanDragonClgResetReq(activityId)
end

function OriginKingCiYuanDragonClgController:handlePM_OriginKingCiYuanDragonClgResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginKingCiYuanDragonClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginKingCiYuanDragonClgResetRes, msg)
end

function OriginKingCiYuanDragonClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginKingCiYuanDragonClg)
end

function OriginKingCiYuanDragonClgController:getSubMo(activityId)
	return OriginKingCiYuanDragonClgModel.instance:getSubMo(activityId)
end

function OriginKingCiYuanDragonClgController:enterStageChallenge(activityId, stageId)
	local fmtMo = OriginKingCiYuanDragonClgModel.instance:getFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginKingCiYuanDragonClgController.instance = OriginKingCiYuanDragonClgController.New()

return OriginKingCiYuanDragonClgController
