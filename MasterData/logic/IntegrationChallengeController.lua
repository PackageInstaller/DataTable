-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/twindragonchallenge/controller/IntegrationChallengeController.lua

module("logic.extensions.twindragonchallenge.controller.IntegrationChallengeController", package.seeall)

local IntegrationChallengeController = class("IntegrationChallengeController", BaseController)

IntegrationChallengeController.PM_ICGetMainBoardInfoRes = "IntegrationChallengeController.PM_ICGetMainBoardInfoRes"
IntegrationChallengeController.PM_ICGetChallengeBoardInfoRes = "IntegrationChallengeController.PM_ICGetChallengeBoardInfoRes"
IntegrationChallengeController.PM_ICSetNewRoundsRes = "IntegrationChallengeController.PM_ICSetNewRoundsRes"
IntegrationChallengeController.PM_ICIntegrateRes = "IntegrationChallengeController.PM_ICIntegrateRes"
IntegrationChallengeController.PM_ICBuyEndRes = "IntegrationChallengeController.PM_ICBuyEndRes"
IntegrationChallengeController.PM_ICAddBuffLevelRes = "IntegrationChallengeController.PM_ICAddBuffLevelRes"

function IntegrationChallengeController:onInit()
	IntegrationChallengeController.super.onInit(self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self)
end

function IntegrationChallengeController:onReset()
	IntegrationChallengeController.super.onReset(self)

	self._challengeId = nil
end

function IntegrationChallengeController:removeListener()
	GlobalDispatcher:removeListener(GlobalNotify.BattleSuccessExit, self._battleSuccessExit, self)
end

function IntegrationChallengeController:handlePM_ICGetMainBoardInfoRes(msg)
	IntegrationChallengeModel.instance:setChallengeStatus(msg.challengeStatus)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICGetMainBoardInfoRes)
end

function IntegrationChallengeController:handlePM_ICGetChallengeBoardInfoRes(msg)
	IntegrationChallengeModel.instance:setRound(msg.roundList)
	IntegrationChallengeModel.instance:setBuffLevel(msg.buffLevel)
	IntegrationChallengeModel.instance:setHasGainedBuff(msg.hasGainedBuff)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICGetChallengeBoardInfoRes)
end

function IntegrationChallengeController:sendPM_ICSetNewRoundsReq(challengeId, stageId, isReset)
	self._sendStage = stageId

	IntegrationChallengeAgent:sendPM_ICSetNewRoundsReq(challengeId, isReset)
end

function IntegrationChallengeController:handlePM_ICSetNewRoundsRes(msg)
	local round = IntegrationChallengeModel.instance:getRound()

	round[self._sendStage] = msg.rounds

	IntegrationChallengeModel.instance:setRound(round)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICSetNewRoundsRes)
end

function IntegrationChallengeController:sendPM_ICChallengeReq(challengeId, type, stageId)
	self._challengeId = challengeId
	self._type = type

	IntegrationChallengeAgent.instance:sendPM_ICChallengeReq(challengeId, type, stageId)
end

function IntegrationChallengeController:handlePM_ICChallengeEndRes(msg)
	local oldStatus = IntegrationChallengeModel.instance:getChallengeStatus()

	if oldStatus == 0 and msg.challengeStatus == 1 then
		IntegrationChallengeModel.instance:setFinishChallenge(true)
	end

	IntegrationChallengeModel.instance:setChallengeStatus(msg.challengeStatus)

	if msg.isWin and self._type == 1 and msg.oldRounds > 0 then
		self._oldRound = msg.oldRounds
		self._newRound = msg.newRounds
		self._stage = msg.stage
	end
end

function IntegrationChallengeController:handlePM_ICAddBuffLevelRes(msg)
	IntegrationChallengeModel.instance:setBuffLevel(msg.buffLevel)
	IntegrationChallengeModel.instance:setHasGainedBuff(true)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICAddBuffLevelRes)
end

function IntegrationChallengeController:_onSceneLoadedFinish()
	if self._challengeId and SceneMgr.instance:getCurSceneType() ~= SceneType.Battle then
		UIStateManager.instance:push(ViewName.HeartGrowUpView)

		if IntegrationChallengeModel.instance:getChallengeStatus() ~= 1 then
			UIStateManager.instance:push(ViewName.TwinDragonChallengeView)
		end

		if self._stage then
			UIStateManager.instance:push(ViewName.ChallengewinresultView, self._challengeId, self._stage, self._newRound, self._oldRound)

			self._stage = nil
		end

		self._challengeId = nil
		self._type = nil
	end
end

function IntegrationChallengeController:handlePM_ICIntegrateRes(msg)
	IntegrationChallengeModel.instance:setChallengeStatus(msg.challengeStatus)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICIntegrateRes)
end

function IntegrationChallengeController:handlePM_ICBuyEndRes(msg)
	IntegrationChallengeModel.instance:setChallengeStatus(msg.challengeStatus)
	GlobalDispatcher:dispatch(IntegrationChallengeController.PM_ICBuyEndRes)
end

IntegrationChallengeController.instance = IntegrationChallengeController.New()

return IntegrationChallengeController
