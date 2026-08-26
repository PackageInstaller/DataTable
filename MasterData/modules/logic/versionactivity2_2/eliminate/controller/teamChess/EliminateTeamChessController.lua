-- chunkname: @modules/logic/versionactivity2_2/eliminate/controller/teamChess/EliminateTeamChessController.lua

module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.EliminateTeamChessController", package.seeall)

local EliminateTeamChessController = class("EliminateTeamChessController", BaseController)

function EliminateTeamChessController:onInit()
	return
end

function EliminateTeamChessController:reInit()
	self:clear()
end

function EliminateTeamChessController:handleTeamFight(fight)
	EliminateTeamChessModel.instance:handleCurTeamChessWarFightInfo(fight)
end

function EliminateTeamChessController:handleServerTeamFight(fight)
	EliminateTeamChessModel.instance:handleServerTeamChessWarFightInfo(fight)
end

function EliminateTeamChessController:handleWarChessRoundEndReply(result)
	EliminateTeamChessModel.instance:setCurTeamRoundStepState(EliminateTeamChessEnum.TeamChessRoundType.settlement)
	EliminateTeamChessController.instance:handleTeamFightTurn(result.turn, not result.isFinish)
	EliminateTeamChessController.instance:handleServerTeamFight(result.fight)
	EliminateLevelModel.instance:setNeedChangeTeamToEliminate(not result.isFinish)
end

function EliminateTeamChessController:handleTeamFightResult(result)
	EliminateTeamChessModel.instance:handleTeamFightResult(result)
	self:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessFightResult))
end

function EliminateTeamChessController:handleTeamFightTurn(turn, needCheckRound)
	EliminateTeamChessModel.instance:handleTeamFightTurn(turn)
	self:buildFlowByTurn()
	self:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessServerDataDiff))

	if needCheckRound then
		self:buildSeqFlow(EliminateTeamChessStepUtil.createStep(nil, EliminateTeamChessEnum.StepWorkType.teamChessCheckRoundState))
	end
end

function EliminateTeamChessController:buildFlowByTurn()
	local stepList = EliminateTeamChessModel.instance:getTeamChessStepList()

	if stepList == nil or #stepList == 0 then
		return
	end

	local lens = #stepList

	for i = 1, lens do
		local stepMo = table.remove(stepList, 1)
		local steps = stepMo:buildSteps()

		for _, step in ipairs(steps) do
			self:buildSeqFlow(step)
		end
	end
end

function EliminateTeamChessController:buildSeqFlow(step)
	local needStart = self._seqStepFlow == nil

	self._seqStepFlow = self._seqStepFlow or FlowSequence.New()

	self._seqStepFlow:addWork(step)

	if needStart and self._canStart then
		self:startSeqStepFlow()
	end
end

function EliminateTeamChessController:setStartStepFlow(state)
	self._canStart = state
end

function EliminateTeamChessController:startSeqStepFlow()
	if self._seqStepFlow ~= nil and self._seqStepFlow.status ~= WorkStatus.Running and #self._seqStepFlow:getWorkList() > 0 then
		self:dispatchEvent(EliminateChessEvent.TeamChessOnFlowStart)
		self._seqStepFlow:registerDoneListener(self.seqFlowDone, self)
		self._seqStepFlow:start()
	end
end

function EliminateTeamChessController:seqFlowDone(isSuccess)
	self:dispatchEvent(EliminateChessEvent.TeamChessOnFlowEnd, isSuccess)

	self._seqStepFlow = nil
end

function EliminateTeamChessController:sendWarChessPiecePlaceRequest(id, uid, strongholdId, extraParams, cb, cbTarget)
	local type = EliminateTeamChessEnum.ChessPlaceType.place

	if uid ~= nil then
		type = EliminateTeamChessEnum.ChessPlaceType.activeMove
	end

	logNormal("sendWarChessPiecePlaceRequest", type, id, strongholdId, uid, extraParams)
	WarChessRpc.instance:sendWarChessPiecePlaceRequest(type, id, strongholdId, uid, extraParams, cb, cbTarget)
end

function EliminateTeamChessController:sendWarChessRoundEndRequest(cb, cbTarget)
	WarChessRpc.instance:sendWarChessRoundEndRequest(cb, cbTarget)
end

function EliminateTeamChessController:createPlaceSkill(soliderId, soliderUid, strongholdId)
	self._soliderPlaceSkill = EliminateTeamChessModel.instance:createPlaceMo(soliderId, soliderUid, strongholdId)
end

function EliminateTeamChessController:getPlaceSkill()
	return self._soliderPlaceSkill
end

function EliminateTeamChessController:setShowSkillEntityState(active)
	if self._soliderPlaceSkill then
		local teamType = self._soliderPlaceSkill:getNeedSelectSoliderType()

		if active then
			TeamChessUnitEntityMgr.instance:setTempShowModeAndCacheByTeamType(teamType, EliminateTeamChessEnum.ModeType.Outline)
		else
			TeamChessUnitEntityMgr.instance:restoreTempShowModeAndCacheByTeamType(teamType)
		end
	end
end

function EliminateTeamChessController:checkAndReleasePlaceSkill()
	if self._soliderPlaceSkill then
		return self._soliderPlaceSkill:releaseSkill(self.clearTemp, self)
	end

	return false
end

function EliminateTeamChessController:addTempChessAndPlace(soliderId, soliderUid, strongholdId)
	local stronghold = EliminateTeamChessModel.instance:getStronghold(strongholdId)
	local chessPiece, index = stronghold:addTempPiece(EliminateTeamChessEnum.TeamChessTeamType.player, soliderId)

	self:dispatchEvent(EliminateChessEvent.AddStrongholdChess, chessPiece, strongholdId, index)
	self:setShowSkillEntityState(true)
end

function EliminateTeamChessController:removeTempChessAndPlace(strongholdId)
	local stronghold = EliminateTeamChessModel.instance:getStronghold(strongholdId)
	local tempUid = EliminateTeamChessEnum.tempPieceUid

	stronghold:removeChess(tempUid)
	self:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, strongholdId, tempUid)
	self:setShowSkillEntityState(false)
end

function EliminateTeamChessController:clearTemp()
	self:clearReleasePlaceSkill()
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)
end

function EliminateTeamChessController:clearReleasePlaceSkill()
	if self._soliderPlaceSkill and self._soliderPlaceSkill:needClearTemp() then
		self:removeTempChessAndPlace(self._soliderPlaceSkill._strongholdId)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessSelectEffectEnd)

	self._soliderPlaceSkill = nil
end

function EliminateTeamChessController:clear()
	self._canStart = false

	if self._seqStepFlow then
		self._seqStepFlow:onDestroyInternal()

		self._seqStepFlow = nil
	end

	self:clearReleasePlaceSkill()
	TeamChessUnitEntityMgr.instance:clear()
	EliminateTeamChessModel.instance:clear()
end

EliminateTeamChessController.instance = EliminateTeamChessController.New()

return EliminateTeamChessController
