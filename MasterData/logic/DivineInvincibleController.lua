-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineinvincible/controller/DivineInvincibleController.lua

module("logic.extensions.divineinvincible.controller.DivineInvincibleController", package.seeall)

local DivineInvincibleController = class("DivineInvincibleController", BaseController)

function DivineInvincibleController:onInit()
	return
end

function DivineInvincibleController:onReset()
	return
end

function DivineInvincibleController:sendPM_DivineInvincibleClgExtremeInfoReq(activityId)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgExtremeInfoReq(activityId)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgExtremeInfoRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineInvincibleClgExtremeInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineInvincibleClgExtremeInfoRes)
end

function DivineInvincibleController:sendPM_DivineInvincibleClgExtremeFightReq(activityId, stageId, form)
	BattleFacade.instance:registerResultHandler(function()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local result = false
		local mo = self:getClgMo(activityId)
		local msg = mo:getExtFightMsg()

		if msg and msg.isWin then
			local fmtMo = DivineInvincibleModel.instance:getExtremeFmtMo()

			UIStateManager.instance:push(ViewName.DivineInvincibleExtResultSureView, activityId, fmtMo)

			result = true
		end

		return result
	end)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgExtremeFightReq(activityId, stageId, form)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgExtremeFightRes(msg)
	return
end

function DivineInvincibleController:sendPM_DivineInvincibleClgExtremeConfirmReq(activityId, posId)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgExtremeConfirmReq(activityId, posId)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgExtremeConfirmRes(status, msg)
	if status == 0 then
		local mo = self:getClgMo(msg.activityId)

		mo:handlePM_DivineInvincibleClgExtremeConfirmRes(msg)

		if msg:HasField("changeSetId") then
			mo:saveChangeSetId(msg.changeSetId)
		end

		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	end

	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineInvincibleClgExtremeConfirmRes, status)
end

function DivineInvincibleController:sendPM_DivineInvincibleClgExtremeResetReq(activityId)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgExtremeResetReq(activityId)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgExtremeResetRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineInvincibleClgExtremeResetRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineInvincibleClgExtremeResetRes)
end

function DivineInvincibleController:sendPM_DivineInvincibleClgNormalInfoReq(activityId)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgNormalInfoReq(activityId)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgNormalInfoRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineInvincibleClgNormalInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineInvincibleClgNormalInfoRes)
end

function DivineInvincibleController:sendPM_DivineInvincibleClgNormalFightReq(activityId, indexId, form)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgNormalFightReq(activityId, indexId, form)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgNormalFightRes(msg)
	return
end

function DivineInvincibleController:sendPM_DivineInvincibleClgNormalGainPrizeReq(activityId, prizeId)
	DivineInvincibleClgAgent.instance:sendPM_DivineInvincibleClgNormalGainPrizeReq(activityId, prizeId)
end

function DivineInvincibleController:handlePM_DivineInvincibleClgNormalGainPrizeRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_DivineInvincibleClgNormalGainPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_DivineInvincibleClgNormalGainPrizeRes)
end

function DivineInvincibleController:handlePM_NotifyDivineInvincibleClgExtremeFightResultRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_NotifyDivineInvincibleClgExtremeFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyDivineInvincibleClgExtremeFightResultRes)
end

function DivineInvincibleController:handlePM_NotifyDivineInvincibleClgNormalFightResultRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_NotifyDivineInvincibleClgNormalFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyDivineInvincibleClgNormalFightResultRes)
end

function DivineInvincibleController:getActivityId()
	return 473001
end

function DivineInvincibleController:getActivityType()
	return GameEnum.ActivityType.DivineInvincible
end

function DivineInvincibleController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function DivineInvincibleController:getClgMo(activityId)
	return DivineInvincibleModel.instance:getClgMo(activityId)
end

function DivineInvincibleController:enterBattleExtreme(activityId, stageId)
	local fmtMo = DivineInvincibleModel.instance:getExtremeFmtMo()

	fmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function DivineInvincibleController:enterBattleNormal(activityId, stageId, creepsMasterId)
	local fmtMo = DivineInvincibleModel.instance:getNormalFmtMo()

	fmtMo:updateCfg(activityId, stageId, creepsMasterId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

DivineInvincibleController.instance = DivineInvincibleController.New()

return DivineInvincibleController
