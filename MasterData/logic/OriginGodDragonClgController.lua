-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/controller/OriginGodDragonClgController.lua

module("logic.extensions.origingoddragonclg.controller.OriginGodDragonClgController", package.seeall)

local OriginGodDragonClgController = class("OriginGodDragonClgController", BaseController)

function OriginGodDragonClgController:onInit()
	return
end

function OriginGodDragonClgController:onReset()
	return
end

function OriginGodDragonClgController:sendPM_OriginGodDragonClgInfoReq(activityId)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonClgInfoReq(activityId)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonClgInfoRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginGodDragonClgInfoRes(msg)

	local costItemMat = mo:getCostItemMat()
	local costItemNum = mo:getCurCostItemNum()

	MaterialFacade.instance:UpdateMaterial(costItemMat.matType, costItemMat.matId, costItemNum)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonClgInfoRes)
end

function OriginGodDragonClgController:sendPM_OriginGodDragonClgChallengeReq(activityId, zoneId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local subMo = self:getSubMo(activityId)
		local msg = subMo:getFightResultMsg()

		if msg and msg.isWin then
			local stageType = subMo:getStageType(stageId)

			if stageType == OriginGodDragonClgEnum.StageType.Nor then
				UIStateManager.instance:push(ViewName.OriginGodDragonClgWinResultView, activityId)
			else
				UIStateManager.instance:push(ViewName.OriginGodDragonClgBanPetSureView, activityId, stageId)
			end

			result = true
		end

		return result
	end)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonClgChallengeReq(activityId, zoneId, stageId, form)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonClgChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonClgChallengeRes)
end

function OriginGodDragonClgController:sendPM_OriginGodDragonClgConfirmReq(activityId, zoneId, stageId, confirm)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonClgConfirmReq(activityId, zoneId, stageId, confirm)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonClgConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getSubMo(msg.activityId)

		mo:handlePM_OriginGodDragonClgConfirmRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonClgConfirmRes)
end

function OriginGodDragonClgController:sendPM_OriginGodDragonEffectBuffReq(activityId, zoneId, stageId)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonEffectBuffReq(activityId, zoneId, stageId)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonEffectBuffRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginGodDragonEffectBuffRes(msg)

	local costItemMat = mo:getCostItemMat()
	local costItemNum = mo:getCurCostItemNum()

	MaterialFacade.instance:UpdateMaterial(costItemMat.matType, costItemMat.matId, costItemNum)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonEffectBuffRes)
end

function OriginGodDragonClgController:sendPM_OriginGodDragonBacktrackReq(activityId, zoneId, stageId)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonBacktrackReq(activityId, zoneId, stageId)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonBacktrackRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginGodDragonBacktrackRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonBacktrackRes)
end

function OriginGodDragonClgController:sendPM_OriginGodDragonResetReq(activityId)
	OriginGodDragonClgAgent.instance:sendPM_OriginGodDragonResetReq(activityId)
end

function OriginGodDragonClgController:handlePM_OriginGodDragonResetRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_OriginGodDragonResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_OriginGodDragonResetRes)
end

function OriginGodDragonClgController:handlePM_NotifyOriginGodDragonChallengeFinishRes(msg)
	local mo = self:getSubMo(msg.activityId)

	mo:handlePM_NotifyOriginGodDragonChallengeFinishRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyOriginGodDragonChallengeFinishRes)
end

function OriginGodDragonClgController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.OriginGodDragonClg)
end

function OriginGodDragonClgController:getSubMo(activityId)
	return OriginGodDragonClgModel.instance:getSubMo(activityId)
end

function OriginGodDragonClgController:isInOpenTime(activityId)
	local data = OriginGodDragonClgConfig.instance:getActivityData(activityId)
	local openTime = data and data.openTime

	return GameUtil.getTimePeriod(openTime, nil) == GameUtil.inTimePeriod
end

function OriginGodDragonClgController:enterStageBattle(activityId, stageId)
	local fmtMo = OriginGodDragonClgModel.instance:getFmtMo(activityId)

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

OriginGodDragonClgController.instance = OriginGodDragonClgController.New()

return OriginGodDragonClgController
