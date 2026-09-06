-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingofradiantgoldclg/controller/KingOfRadiantGoldClgController.lua

module("logic.extensions.kingofradiantgoldclg.controller.KingOfRadiantGoldClgController", package.seeall)

local KingOfRadiantGoldClgController = class("KingOfRadiantGoldClgController", BaseController)

function KingOfRadiantGoldClgController:onInit()
	return
end

function KingOfRadiantGoldClgController:onReset()
	return
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgInfoReq(activityId)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgInfoReq(activityId)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgInfoRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_KingOfRadiantGoldClgInfoRes(msg)
	self:_updateBuffRed(msg.activityId)
	self:_updateFinialPrizeRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgInfoRes)
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgChallengeReq(activityId, challengeId, stageId, form)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgChallengeReq(activityId, challengeId, stageId, form)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgChallengeRes)
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgUpgradeBuffReq(activityId, buffId)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgUpgradeBuffReq(activityId, buffId)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgUpgradeBuffRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_KingOfRadiantGoldClgUpgradeBuffRes(msg)
	self:_updateBuffRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgUpgradeBuffRes)
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgResetBuffReq(activityId, buffId)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgResetBuffReq(activityId, buffId)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgResetBuffRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_KingOfRadiantGoldClgResetBuffRes(msg)
	self:_updateBuffRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgResetBuffRes)
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgOneKeyPassReq(activityId, leftNum)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgOneKeyPassReq(activityId, leftNum)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgOneKeyPassRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_KingOfRadiantGoldClgOneKeyPassRes(msg)
	self:_updateBuffRed(msg.activityId)
	self:_updateFinialPrizeRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgOneKeyPassRes)
end

function KingOfRadiantGoldClgController:sendPM_KingOfRadiantGoldClgGainPetReq(activityId)
	KingOfRadiantGoldClgAgent.instance:sendPM_KingOfRadiantGoldClgGainPetReq(activityId)
end

function KingOfRadiantGoldClgController:handlePM_KingOfRadiantGoldClgGainPetRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_KingOfRadiantGoldClgGainPetRes(msg)
	self:_updateBuffRed(msg.activityId)
	self:_updateFinialPrizeRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_KingOfRadiantGoldClgGainPetRes)
end

function KingOfRadiantGoldClgController:handlePM_NotifyKingOfRadiantGoldClgFinishRes(msg)
	local mo = self:getClgMo(msg.activityId)

	mo:handlePM_NotifyKingOfRadiantGoldClgFinishRes(msg)
	self:_updateBuffRed(msg.activityId)
	self:_updateFinialPrizeRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.HandlePM_NotifyKingOfRadiantGoldClgFinishRes)
end

function KingOfRadiantGoldClgController:getActivityId()
	return 462001
end

function KingOfRadiantGoldClgController:getActivityType()
	return GameEnum.ActivityType.KingOfRadiantGoldClg
end

function KingOfRadiantGoldClgController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function KingOfRadiantGoldClgController:getClgMo(activityId)
	return KingOfRadiantGoldClgModel.instance:getClgMo(activityId)
end

function KingOfRadiantGoldClgController:enterBattle(activityId, challengeId, stageId)
	local fmtMo = KingOfRadiantGoldClgModel.instance:getFmtMo()

	fmtMo:updateCfg(activityId, challengeId, stageId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function KingOfRadiantGoldClgController:_updateBuffRed(activityId)
	local isActivated = not (isActivated and not self:isInActivityTime(activityId))

	if isActivated then
		local mo = self:getClgMo(activityId)

		isActivated = mo:isCanUpdateBuffInAll()
	end

	local redPointId = RedPointModel.ID_KingOfRadiantGoldClg_Buff

	RedPointController.instance:setRedPointInfo(redPointId, isActivated)
end

function KingOfRadiantGoldClgController:_updateFinialPrizeRed(activityId)
	local isActivated = not (isActivated and not self:isInActivityTime(activityId))

	if isActivated then
		local mo = self:getClgMo(activityId)
		local result = mo:getTryResultAndTipsGetFinalPrize(false)

		isActivated = result == GameEnum.ResultCode.Success
	end

	local redPointId = RedPointModel.ID_KingOfRadiantGoldClg_FinialPrize

	RedPointController.instance:setRedPointInfo(redPointId, isActivated)
end

KingOfRadiantGoldClgController.instance = KingOfRadiantGoldClgController.New()

return KingOfRadiantGoldClgController
