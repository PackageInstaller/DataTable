-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/controller/OriginGoldenDragonClgController.lua

module("logic.extensions.origingoldendragonclg.controller.OriginGoldenDragonClgController", package.seeall)

local OriginGoldenDragonClgController = class("OriginGoldenDragonClgController", BaseController)

function OriginGoldenDragonClgController:onInit()
	self:onReset()
end

function OriginGoldenDragonClgController:onReset()
	self._curSelectProphecyId = 0
	self._curFmtMoMap = {}
end

function OriginGoldenDragonClgController:enterFmtMo(activityId, stageId)
	local fmtmo = self._curFmtMoMap[activityId]

	if fmtmo == nil then
		fmtmo = OriginGoldenDragonClgFmtMo.New()
		self._curFmtMoMap[activityId] = fmtmo
	end

	local stageCfg = OriginGoldenDragonClgConfig.instance:getStageCfgById(activityId, stageId)

	if stageCfg == nil then
		printError("源起黄金圣龙挑战配置不存在, activityId:", activityId, "stageId:", stageId)

		return
	end

	fmtmo:initParams(activityId, stageCfg)
	CustomFmtController.instance:showMissionView(fmtmo)
end

function OriginGoldenDragonClgController:getDefaultActivityId()
	return 617001
end

function OriginGoldenDragonClgController:getCurSelectProphecyId()
	return self._curSelectProphecyId
end

function OriginGoldenDragonClgController:setCurSelectProphecyId(prophecyId)
	self._curSelectProphecyId = prophecyId

	GlobalDispatcher:dispatch(GlobalNotify.OriginGoldenDragonClgChangeProphecyId)
end

function OriginGoldenDragonClgController:_onBattleEnd(activityId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local lastFightInfo = OriginGoldenDragonClgModel.instance:getLastStageClgResult(activityId)

	if lastFightInfo then
		UIStateManager.instance:push(ViewName.OriginGoldenDragonClgResultView, lastFightInfo)
	else
		UIStateManager.instance:push(ViewName.BattleSettlementFailSimple)
	end

	return true
end

function OriginGoldenDragonClgController:getInfo(activityId)
	OriginGoldenDragonClgAgent.instance:sendPM_OriginGoldenDragonClgGetInfoReq(activityId)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgGetInfoRes(msg)
	OriginGoldenDragonClgModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgGetInfoRes)
end

function OriginGoldenDragonClgController:challengeStage(activityId, stageId, prophecyId, form_pb)
	BattleFacade.instance:registerResultHandler(function()
		return self:_onBattleEnd(activityId)
	end)
	OriginGoldenDragonClgAgent.instance:sendPM_OriginGoldenDragonClgChallengeStageReq(activityId, stageId, prophecyId, form_pb)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgChallengeStageRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgChallengeStageRes)
end

function OriginGoldenDragonClgController:gainPrize(activityId, prizeId)
	OriginGoldenDragonClgAgent.instance:sendPM_OriginGoldenDragonClgGainPrizeReq(activityId, prizeId)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgGainPrizeRes(msg)
	OriginGoldenDragonClgModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgGainPrizeRes)
end

function OriginGoldenDragonClgController:resetChallenge(activityId)
	OriginGoldenDragonClgAgent.instance:sendPM_OriginGoldenDragonClgResetChallengeReq(activityId)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgResetChallengeRes(msg)
	OriginGoldenDragonClgModel.instance:onResetChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgResetChallengeRes)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgNotifyStageResultRes(msg)
	OriginGoldenDragonClgModel.instance:onNotifyStageResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgNotifyStageResultRes)
end

function OriginGoldenDragonClgController:confirmResult(activityId, stageId, save)
	OriginGoldenDragonClgAgent.instance:sendPM_OriginGoldenDragonClgConfirmReq(activityId, stageId, save)
end

function OriginGoldenDragonClgController:handlePM_OriginGoldenDragonClgConfirmRes(msg)
	OriginGoldenDragonClgModel.instance:onConfirmResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_OriginGoldenDragonClgConfirmRes)
end

OriginGoldenDragonClgController.instance = OriginGoldenDragonClgController.New()

return OriginGoldenDragonClgController
