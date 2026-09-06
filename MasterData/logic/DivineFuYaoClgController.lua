-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefuyaoclg/controller/DivineFuYaoClgController.lua

module("logic.extensions.divinefuyaoclg.controller.DivineFuYaoClgController", package.seeall)

local DivineFuYaoClgController = class("DivineFuYaoClgController", BaseController)

function DivineFuYaoClgController:onInit()
	return
end

function DivineFuYaoClgController:onReset()
	return
end

function DivineFuYaoClgController:sendPM_DivineFuYaoClgInfoReq(activityId)
	DivineFuYaoClgAgent.instance:sendPM_DivineFuYaoClgInfoReq(activityId)
end

function DivineFuYaoClgController:handlePM_DivineFuYaoClgInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DivineFuYaoClgInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineFuYaoClgInfoRes, msg)
end

function DivineFuYaoClgController:sendPM_DivineFuYaoClgNormalChallengeReq(activityId, stageId, form)
	DivineFuYaoClgAgent.instance:sendPM_DivineFuYaoClgNormalChallengeReq(activityId, stageId, form)
end

function DivineFuYaoClgController:handlePM_DivineFuYaoClgNormalChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineFuYaoClgNormalChallengeRes, msg)
end

function DivineFuYaoClgController:handlePM_NotifyFuYaoClgNormalChallengeFinishRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_NotifyFuYaoClgNormalChallengeFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyFuYaoClgNormalChallengeFinishRes, msg)
end

function DivineFuYaoClgController:sendPM_DivineFuYaoClgExtremeChallengeReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local subMo = self:getSubMo(activityId)
		local msg = subMo:getExtremeFinishMsg()

		if msg and msg.isWin then
			local fmtMo = DivineFuYaoClgModel.instance:getExtremeFmtMo()

			UIStateManager.instance:push(ViewName.DivineFuYaoClgExtResultPopView, fmtMo)

			result = true
		end

		return result
	end)
	DivineFuYaoClgAgent.instance:sendPM_DivineFuYaoClgExtremeChallengeReq(activityId, stageId, form)
end

function DivineFuYaoClgController:handlePM_DivineFuYaoClgExtremeChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineFuYaoClgExtremeChallengeRes, msg)
end

function DivineFuYaoClgController:sendPM_DivineFuYaoClgExtremeConfirmReq(activityId, stageId, save)
	DivineFuYaoClgAgent.instance:sendPM_DivineFuYaoClgExtremeConfirmReq(activityId, stageId, save)
end

function DivineFuYaoClgController:handlePM_DivineFuYaoClgExtremeConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_DivineFuYaoClgExtremeConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineFuYaoClgExtremeConfirmRes, status, msg)
end

function DivineFuYaoClgController:sendPM_DivineFuYaoClgExtremeResetReq(activityId)
	DivineFuYaoClgAgent.instance:sendPM_DivineFuYaoClgExtremeResetReq(activityId)
end

function DivineFuYaoClgController:handlePM_DivineFuYaoClgExtremeResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_DivineFuYaoClgExtremeResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineFuYaoClgExtremeResetRes, msg)
end

function DivineFuYaoClgController:handlePM_NotifyFuYaoClgExtremeChallengeFinishRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_NotifyFuYaoClgExtremeChallengeFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyFuYaoClgExtremeChallengeFinishRes, msg)
end

function DivineFuYaoClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineFuYaoClg)
end

function DivineFuYaoClgController:getSubMo(activityId)
	return DivineFuYaoClgModel.instance:getSubMo(activityId)
end

function DivineFuYaoClgController:enterBattleNormal(activityId, stageId)
	local fmtMo = DivineFuYaoClgModel.instance:getNormalFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineFuYaoClgController:enterBattleExtreme(activityId, stageId)
	local fmtMo = DivineFuYaoClgModel.instance:getExtremeFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

DivineFuYaoClgController.instance = DivineFuYaoClgController.New()

return DivineFuYaoClgController
