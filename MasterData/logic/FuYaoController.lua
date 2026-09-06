-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/controller/FuYaoController.lua

module("logic.extensions.fuyaochallenge.controller.FuYaoController", package.seeall)

local FuYaoController = class("FuYaoController", BaseController)

function FuYaoController:ctor()
	return
end

function FuYaoController:onInit()
	self:onReset()
end

function FuYaoController:onReset()
	GlobalDispatcher:addListener("enterfuyaochallenge", self._enterFuYaoChallenge, self)
end

function FuYaoController:sendPM_FuyaoGetInfoReq(activityId)
	FuyaoChallengeAgent.instance:sendPM_FuyaoGetInfoReq(activityId)
end

function FuYaoController:handlePM_FuyaoGetInfoRes(status, msg)
	FuYaoModel.instance:setFuyaoInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FuyaoGetInfoRes, msg)
end

function FuYaoController:sendPM_FuyaoCommonChallengeReq(activityId, puzzleId, form)
	FuyaoChallengeAgent.instance:sendPM_FuyaoCommonChallengeReq(activityId, puzzleId, form)
end

function FuYaoController:handlePM_FuyaoCommonChallengeRes(status, msg)
	return
end

function FuYaoController:handlePM_FuyaoNotifyCommonChallengeResultRes(status, msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	BattleSettlementModel.instance:setChangeSetId(msg.changeSetId)
end

function FuYaoController:sendPM_FuyaoExtremeChallengeReq(activityId, stageId, form)
	FuyaoChallengeAgent.instance:sendPM_FuyaoExtremeChallengeReq(activityId, stageId, form)
end

function FuYaoController:handlePM_FuyaoExtremeChallengeRes(status, msg)
	return
end

function FuYaoController:handlePM_FuyaoNotifyExtremeChallengeResultRes(status, msg)
	return
end

function FuYaoController:_enterFuYaoChallenge(params)
	self:enterFuYaoChallenge(checknumber(params[1]))
end

function FuYaoController:enterFuYaoChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.FuYaoChallengeView, activityId)
end

function FuYaoController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function FuYaoController:getActivityType()
	return GameEnum.ActivityType.FuYaoChallenge
end

function FuYaoController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function FuYaoController:openChallengeForm(activityId, challengeId, creepsMasterId, isExtreme)
	CustomFmtController.instance:showMissionView(FuYaoModel.instance:getChallengeFmtMo(activityId, challengeId, creepsMasterId, isExtreme))
end

function FuYaoController:fightResult(activityId, isExtreme)
	if not isExtreme then
		return
	end

	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = self:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		return false
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

function FuYaoController:getFristNoPassId()
	local passPuzzles = FuYaoModel.instance:getPassPuzzles()
	local puzzleCfg = FuYaoConfig.instance:getFuyaoCommonCfg(FuYaoModel.instance:getActivityId())

	if #passPuzzles <= 0 then
		return 1
	end

	local id = 1

	for _, v in pairs(passPuzzles) do
		if v == id then
			id = v + 1
		end
	end

	return Mathf.Clamp(id, 1, #puzzleCfg)
end

function FuYaoController:isPuzzlesClearance()
	local passPuzzles = FuYaoModel.instance:getPassPuzzles()
	local puzzleCfg = FuYaoConfig.instance:getFuyaoCommonCfg(FuYaoModel.instance:getActivityId())
	local isClearance = true

	for _, v in pairs(puzzleCfg) do
		if not TableUtil.isHad(passPuzzles, v.puzzleId) then
			isClearance = false
		end
	end

	return isClearance
end

function FuYaoController:isExtremeClearance()
	return not TableUtil.isHad(FuYaoModel.instance:getExtremeScores(), -1)
end

function FuYaoController:isPassScore()
	local totalScore = FuYaoConfig.instance:getFuyaoChallengeCfg(FuYaoModel.instance:getActivityId()).extremePassScore
	local curScore = FuYaoModel.instance:getCurScore()

	return totalScore <= curScore
end

function FuYaoController:isClearanceExtreme()
	return self:isExtremeClearance() and self:isPassScore()
end

FuYaoController.instance = FuYaoController.New()

return FuYaoController
