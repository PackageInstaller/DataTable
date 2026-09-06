-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/heartofaojiuclg/controller/HeartOfAoJiuClgController.lua

module("logic.extensions.heartofaojiuclg.controller.HeartOfAoJiuClgController", package.seeall)

local HeartOfAoJiuClgController = class("HeartOfAoJiuClgController", BaseController)

function HeartOfAoJiuClgController:onInit()
	return
end

function HeartOfAoJiuClgController:onReset()
	return
end

function HeartOfAoJiuClgController:sendPM_HeartOfAoJiuClgGetInfoReq(activityId)
	HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgGetInfoReq(activityId)
end

function HeartOfAoJiuClgController:handlePM_HeartOfAoJiuClgGetInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HeartOfAoJiuClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HeartOfAoJiuClgGetInfoRes)
end

function HeartOfAoJiuClgController:sendPM_HeartOfAoJiuClgChallengeReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local subMo = self:getSubMo(activityId)
		local msg = subMo:getClgResultMsg()

		if msg and msg.score > 0 then
			local fmtMo = HeartOfAoJiuClgModel.instance:getFmtMo()

			UIStateManager.instance:push(ViewName.HeartOfAoJiuClgStageSurePopView, fmtMo)

			result = true
		end

		return result
	end)
	HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgChallengeReq(activityId, stageId, form)
end

function HeartOfAoJiuClgController:handlePM_HeartOfAoJiuClgChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HeartOfAoJiuClgChallengeRes)
end

function HeartOfAoJiuClgController:sendPM_HeartOfAoJiuClgConfirmReq(activityId, stageId, confirm)
	HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgConfirmReq(activityId, stageId, confirm)
end

function HeartOfAoJiuClgController:handlePM_HeartOfAoJiuClgConfirmRes(status, msg)
	if status == 0 then
		local subMo = self:getSubMo(msg.activityId)

		subMo:handlePM_HeartOfAoJiuClgConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HeartOfAoJiuClgConfirmRes, status, msg)
end

function HeartOfAoJiuClgController:sendPM_HeartOfAoJiuClgResetReq(activityId)
	HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgResetReq(activityId)
end

function HeartOfAoJiuClgController:handlePM_HeartOfAoJiuClgResetRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HeartOfAoJiuClgResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HeartOfAoJiuClgResetRes)
end

function HeartOfAoJiuClgController:sendPM_HeartOfAoJiuClgGetRankInfoReq(activityId)
	HeartOfAoJiuClgAgent.instance:sendPM_HeartOfAoJiuClgGetRankInfoReq(activityId)
end

function HeartOfAoJiuClgController:handlePM_HeartOfAoJiuClgGetRankInfoRes(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_HeartOfAoJiuClgGetRankInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_HeartOfAoJiuClgGetRankInfoRes, msg)
end

function HeartOfAoJiuClgController:handlePM_Notify_HeartOfAoJiuClgChallengeResult(msg)
	local subMo = self:getSubMo(msg.activityId)

	subMo:handlePM_Notify_HeartOfAoJiuClgChallengeResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_Notify_HeartOfAoJiuClgChallengeResult)
end

function HeartOfAoJiuClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.HeartOfAoJiuClg)
end

function HeartOfAoJiuClgController:getSubMo(activityId)
	return HeartOfAoJiuClgModel.instance:getSubMo(activityId)
end

function HeartOfAoJiuClgController:enterBattle(activityId, stageId)
	local fmtMo = HeartOfAoJiuClgModel.instance:getFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

HeartOfAoJiuClgController.instance = HeartOfAoJiuClgController.New()

return HeartOfAoJiuClgController
