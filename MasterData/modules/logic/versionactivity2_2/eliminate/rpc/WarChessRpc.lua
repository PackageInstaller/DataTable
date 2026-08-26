-- chunkname: @modules/logic/versionactivity2_2/eliminate/rpc/WarChessRpc.lua

module("modules.logic.versionactivity2_2.eliminate.rpc.WarChessRpc", package.seeall)

local WarChessRpc = class("WarChessRpc", BaseRpc)

function WarChessRpc:sendWarChessCharacterSkillRequest(skillId, param, moduleType, callback, callbackobj)
	local msg = WarChessModule_pb.WarChessCharacterSkillRequest()

	msg.skillId = skillId
	msg.params = param
	msg.moduleType = moduleType

	self:sendMsg(msg, callback, callbackobj)
end

function WarChessRpc:onReceiveWarChessCharacterSkillReply(resultCode, msg)
	if resultCode == 0 then
		local curRound = EliminateLevelModel.instance:getCurRoundType()

		if curRound == EliminateEnum.RoundType.TeamChess then
			EliminateTeamChessController.instance:handleServerTeamFight(msg.fight)
			EliminateTeamChessController.instance:handleTeamFightTurn(msg.turn, false)
		end
	end
end

function WarChessRpc:sendWarChessRoundEndRequest(callback, callbackobj)
	local msg = WarChessModule_pb.WarChessRoundEndRequest()

	self:sendMsg(msg, callback, callbackobj)
end

function WarChessRpc:onReceiveWarChessRoundEndReply(resultCode, msg)
	if resultCode == 0 then
		EliminateTeamChessController.instance:handleWarChessRoundEndReply(msg)
	end
end

function WarChessRpc:sendWarChessPiecePlaceRequest(type, id, strongholdId, uid, extraParams, callback, callbackobj)
	local msg = WarChessModule_pb.WarChessPiecePlaceRequest()

	msg.pieceId = id
	msg.strongholdId = strongholdId
	msg.type = type
	msg.pieceUid = uid and uid or 9999
	msg.extraParams = extraParams and extraParams or ""

	self:sendMsg(msg, callback, callbackobj)
end

function WarChessRpc:onReceiveWarChessPiecePlaceReply(resultCode, msg)
	if resultCode == 0 then
		local turn = msg.turn

		if turn == nil or turn.step == nil then
			EliminateTeamChessController.instance:clearReleasePlaceSkill()
		else
			EliminateTeamChessController.instance:handleTeamFightTurn(msg.turn, false)
		end

		EliminateLevelController.instance:updatePlayerExtraWinCondition(msg.extraWinCondition)
	end
end

function WarChessRpc:sendWarChessPieceSellRequest(uid, strongholdId, callback, callbackobj)
	local msg = WarChessModule_pb.WarChessPieceSellRequest()

	msg.strongholdId = strongholdId
	msg.uid = uid

	self:sendMsg(msg, callback, callbackobj)
end

function WarChessRpc:onReceiveWarChessPieceSellReply(resultCode, msg)
	if resultCode == 0 then
		EliminateTeamChessController.instance:handleServerTeamFight(msg.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(msg.turn, false)
		EliminateLevelController.instance:updatePlayerExtraWinCondition(msg.fight.extraWinCondition)
	end
end

function WarChessRpc:onReceiveWarChessRoundStartPush(resultCode, msg)
	if resultCode == 0 then
		EliminateTeamChessController.instance:handleTeamFight(msg.initFight)
		EliminateTeamChessController.instance:handleServerTeamFight(msg.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(msg.turn, true)
	end
end

function WarChessRpc:onReceiveWarChessFightResultPush(resultCode, msg)
	if resultCode == 0 then
		EliminateTeamChessController.instance:handleTeamFightResult(msg.fightResult)
		EliminateRpc.instance:sendGetMatch3WarChessFacadeInfoRequest()
	end
end

function WarChessRpc:sendWarChessMyRoundStartRequest(callback, callbackobj)
	local msg = WarChessModule_pb.WarChessMyRoundStartRequest()

	msg.moduleType = 0

	self:sendMsg(msg, callback, callbackobj)
end

function WarChessRpc:onReceiveWarChessMyRoundStartReply(resultCode, msg)
	if resultCode == 0 then
		if EliminateLevelModel.instance:needPlayShowView() then
			local step = EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessBeginViewShow)

			EliminateTeamChessController.instance:buildSeqFlow(step)
		end

		EliminateTeamChessController.instance:handleServerTeamFight(msg.fight)
		EliminateTeamChessController.instance:handleTeamFightTurn(msg.turn, false)
	end
end

WarChessRpc.instance = WarChessRpc.New()

return WarChessRpc
