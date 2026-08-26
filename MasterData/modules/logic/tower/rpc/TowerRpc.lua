-- chunkname: @modules/logic/tower/rpc/TowerRpc.lua

module("modules.logic.tower.rpc.TowerRpc", package.seeall)

local TowerRpc = class("TowerRpc", BaseRpc)

function TowerRpc:onInit()
	return
end

function TowerRpc:reInit()
	return
end

function TowerRpc:sendGetTowerInfoRequest(callback, callbackObj)
	local req = TowerModule_pb.GetTowerInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveGetTowerInfoReply(resultCode, msg)
	if resultCode == 0 then
		TowerModel.instance:onReceiveGetTowerInfoReply(msg)
		TowerController.instance:dispatchEvent(TowerEvent.TowerUpdate)
	end
end

function TowerRpc:sendTowerMopUpRequest(times, callback, callbackObj)
	local req = TowerModule_pb.TowerMopUpRequest()

	req.times = times

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveTowerMopUpReply(resultCode, msg)
	if resultCode == 0 then
		TowerModel.instance:updateMopUpTimes(msg.mopUpTimes)
		TowerController.instance:dispatchEvent(TowerEvent.TowerMopUp, msg.mopUpTimes)
	end
end

function TowerRpc:sendTowerActiveTalentRequest(bossId, talentId, callback, callbackObj)
	local req = TowerModule_pb.TowerActiveTalentRequest()

	req.bossId = bossId
	req.talentId = talentId

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveTowerActiveTalentReply(resultCode, msg)
	if resultCode == 0 then
		TowerAssistBossModel.instance:onTowerActiveTalent(msg)
		TowerController.instance:dispatchEvent(TowerEvent.ActiveTalent, msg.talentId)
	end
end

function TowerRpc:sendTowerResetTalentRequest(bossId, talentId, callback, callbackObj)
	local req = TowerModule_pb.TowerResetTalentRequest()

	req.bossId = bossId
	req.talentId = talentId

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveTowerResetTalentReply(resultCode, msg)
	if resultCode == 0 then
		TowerAssistBossModel.instance:onTowerResetTalent(msg)
		TowerController.instance:dispatchEvent(TowerEvent.ResetTalent, msg.talentId)
	end
end

function TowerRpc:sendTowerRenameTalentPlanRequest(bossId, planName, callback, callbackObj)
	local req = TowerModule_pb.TowerRenameTalentPlanRequest()

	req.bossId = bossId
	req.planName = planName

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveTowerRenameTalentPlanReply(resultCode, msg)
	if resultCode == 0 then
		TowerAssistBossModel.instance:onTowerRenameTalentPlan(msg)
		TowerController.instance:dispatchEvent(TowerEvent.RenameTalentPlan, msg.planName)
	end
end

function TowerRpc:sendTowerChangeTalentPlanRequest(bossId, planId)
	local req = TowerModule_pb.TowerChangeTalentPlanRequest()

	req.bossId = bossId
	req.planId = planId

	return self:sendMsg(req)
end

function TowerRpc:onReceiveTowerChangeTalentPlanReply(resultCode, msg)
	if resultCode == 0 then
		TowerController.instance:dispatchEvent(TowerEvent.ChangeTalentPlan, msg)
	end
end

function TowerRpc:sendTowerResetSubEpisodeRequest(towerType, towerId, layerId, subEpisode, callback, callbackObj)
	local req = TowerModule_pb.TowerResetSubEpisodeRequest()

	req.towerType = towerType
	req.towerId = towerId
	req.layerId = layerId
	req.subEpisode = subEpisode

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveTowerResetSubEpisodeReply(resultCode, msg)
	if resultCode == 0 then
		TowerModel.instance:resetTowerSubEpisode(msg)
		TowerController.instance:dispatchEvent(TowerEvent.OnTowerResetSubEpisode, msg)
	end
end

function TowerRpc:sendStartTowerBattleRequest(param, callback, callbackObj)
	local req = TowerModule_pb.StartTowerBattleRequest()
	local towerParam = TowerModel.instance:getRecordFightParam()

	req.type = towerParam.towerType
	req.towerId = towerParam.towerId or 0
	req.layerId = towerParam.layerId or 0
	req.difficulty = towerParam.difficulty or 0
	req.talentPlanId = TowerAssistBossModel.instance:getLimitedTrialBossTalentPlan(towerParam)

	self:packStartTowerBattleRequest(req, param)

	return self:sendMsg(req, callback, callbackObj)
end

function TowerRpc:onReceiveStartTowerBattleReply(resultCode, msg)
	FightRpc.instance:onReceiveTestFightReply(resultCode, msg and msg.startDungeonReply)
end

function TowerRpc:packStartTowerBattleRequest(req, param)
	local dungeonReq = req.startDungeonRequest
	local fightParam = param.fightParam

	dungeonReq.chapterId = param.chapterId
	dungeonReq.episodeId = param.episodeId
	dungeonReq.isRestart = not not param.isRestart
	dungeonReq.isBalance = HeroGroupBalanceHelper.getIsBalanceMode()
	dungeonReq.multiplication = param.multiplication or 1
	dungeonReq.useRecord = not not param.useRecord

	if fightParam then
		fightParam:setReqFightGroup(dungeonReq)
		FightModel.instance:recordFightGroup(dungeonReq.fightGroup)
	end
end

function TowerRpc:onReceiveTowerBattleFinishPush(resultCode, msg)
	if resultCode == 0 then
		TowerModel.instance:onReceiveTowerBattleFinishPush(msg)
	end
end

TowerRpc.instance = TowerRpc.New()

return TowerRpc
