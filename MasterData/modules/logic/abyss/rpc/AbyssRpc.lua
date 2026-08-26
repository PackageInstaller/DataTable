-- chunkname: @modules/logic/abyss/rpc/AbyssRpc.lua

module("modules.logic.abyss.rpc.AbyssRpc", package.seeall)

local AbyssRpc = class("AbyssRpc", BaseRpc)

function AbyssRpc:sendGetAct229InfoRequest(activityId, callback, callbackObj)
	local req = Activity229Module_pb.GetAct229InfoRequest()

	req.activityId = activityId

	self:sendMsg(req, callback, callbackObj)
end

function AbyssRpc:onReceiveGetAct229InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stages = msg.stages

	AbyssModel.instance:updateInfo(activityId, stages)
end

function AbyssRpc:sendAct229ResetStageRequest(activityId, stageId, callback, callbackObj)
	local req = Activity229Module_pb.Act229ResetStageRequest()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req, callback, callbackObj)
end

function AbyssRpc:onReceiveAct229ResetStageReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId

	AbyssModel.instance:onResetStage(activityId, stageId)
end

function AbyssRpc:sendStartAct229BattleRequest(param, callback, callbackObj)
	local startDungeonRequest = TowerModule_pb.StartTowerBattleRequest()
	local req = Activity229Module_pb.StartAct229BattleRequest()

	req.activityId = param.activityId
	req.stageId = param.stageId

	self:packStartAbyssBattleRequest(req, param)
	self:sendMsg(req, callback, callbackObj)
end

function AbyssRpc:packStartAbyssBattleRequest(req, param)
	local dungeonReq = req.startDungeonRequest
	local fightParam = param.fightParam

	dungeonReq.chapterId = param.chapterId
	dungeonReq.episodeId = param.episodeId
	dungeonReq.isRestart = not not param.isRestart
	dungeonReq.isBalance = HeroGroupBalanceHelper.getIsBalanceMode()
	dungeonReq.multiplication = param.multiplication or 1
	dungeonReq.useRecord = not not param.useRecord
	dungeonReq.params = AbyssController.instance:getFightCustomParam()

	if fightParam then
		fightParam:setReqFightGroup(dungeonReq)
		FightModel.instance:recordFightGroup(dungeonReq.fightGroup)
	end
end

function AbyssRpc:onReceiveStartAct229BattleReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	FightRpc.instance:onReceiveTestFightReply(resultCode, msg and msg.startDungeonReply)
end

function AbyssRpc:onReceiveAct229BattleFinishPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local round = msg.round
	local star = msg.star
	local minRound = msg.lastMinRound

	AbyssModel.instance:onBattleFinishPush(activityId, stageId, round, star, minRound)
end

function AbyssRpc:sendAct229ModifyStageSubIdRequest(activityId, stageSubIds, callback, callbackObj)
	local req = Activity229Module_pb.Act229ModifyStageSubIdRequest()

	req.activityId = activityId

	for _, data in ipairs(stageSubIds) do
		local no = req.stageSubIds:add()

		no.stageId = data.stageId
		no.heroGroupSubId = data.heroGroupSubId
	end

	self:sendMsg(req, callback, callbackObj)
end

function AbyssRpc:onReceiveAct229ModifyStageSubIdReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stages = msg.stages

	AbyssModel.instance:updateInfo(activityId, stages)
end

function AbyssRpc:sendAct229ModifySkillRequest(activityId, stageId, skillIds, callback, callbackObj)
	local req = Activity229Module_pb.Act229ModifySkillRequest()

	req.activityId = activityId
	req.stageId = stageId

	for _, skillId in ipairs(skillIds) do
		req.skillIds:append(skillId)
	end

	self:sendMsg(req, callback, callbackObj)
end

function AbyssRpc:onReceiveAct229ModifySkillReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local skillIds = msg.skillIds
	local stageMo = AbyssModel.instance:getStageInfoMo(activityId, stageId)

	stageMo.skillId = skillIds[1]
end

function AbyssRpc:onReceiveAct229StageTeamSubIdPush(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local activityId = msg.activityId
	local stageSubIds = msg.stageSubIds

	AbyssModel.instance:onUpdateTimePush(activityId, stageSubIds)
end

AbyssRpc.instance = AbyssRpc.New()

return AbyssRpc
