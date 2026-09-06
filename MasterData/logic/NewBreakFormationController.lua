-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newbreakformation/controller/NewBreakFormationController.lua

module("logic.extensions.newbreakformation.controller.NewBreakFormationController", package.seeall)

local NewBreakFormationController = class("NewBreakFormationController", BaseController)

function NewBreakFormationController:ctor()
	return
end

function NewBreakFormationController:onInit()
	self:onReset()
end

function NewBreakFormationController:onReset()
	return
end

function NewBreakFormationController:handlePM_NewBreachFormationInfoRes(msg)
	NewBreakFormationModel.instance:setInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewBreachFormationInfoRes)
end

function NewBreakFormationController:handlePM_NewBreachFormationChallengeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewBreachFormationChallengeRes)
end

function NewBreakFormationController:handlePM_NewBreachFormationNotifyChallengeRes(msg)
	if msg.isWin == true and msg.isBeatRecord == true then
		if not NewBreakFormationModel.instance:getRecordScore(msg.seasonId) then
			NewBreakFormationModel.instance:recordCurScore(msg.seasonId)
		end

		NewBreakFormationModel.instance:setStageInfo(msg)
	end

	local param = {}

	param.scoreList = {}

	local maxScore = checknumber(NewBreakFormationModel.instance:getTotalScoreByStage(msg.seasonId, msg.tabId, msg.stageId))

	table.insert(param.scoreList, langPara("挑战积分：%d", checknumber(msg.currentScore)))
	table.insert(param.scoreList, langPara("本赛季最高分：%d", maxScore))
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.GodDiShiTian, param)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewBreachFormationNotifyChallengeRes)
end

function NewBreakFormationController:handlePM_NewBreachFormationGainScorePrizeRes(msg)
	NewBreakFormationModel.instance:setPrizeInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewBreachFormationGainScorePrizeRes)
end

function NewBreakFormationController:handlePM_NewBreachFormationRankViewRes(msg)
	NewBreakFormationModel.instance:setRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.handlePM_NewBreachFormationRankViewRes)
end

function NewBreakFormationController:getSeasonId()
	local seasonCfgs = NewBreakFormationConfig.instance:getSeasonCfgs()
	local latestSeasonId = -1
	local seasonId = -1
	local now = ServerTime.now()

	for i, v in ipairs(seasonCfgs) do
		local startTimeStamp = GameUtil.string2time(v.startDateTime)
		local endTimeStamp = GameUtil.string2time(v.endDateTime)

		if startTimeStamp < now then
			latestSeasonId = v.seasonId

			if now < endTimeStamp then
				seasonId = v.seasonId
			end
		end
	end

	return seasonId, latestSeasonId
end

function NewBreakFormationController:getPeriodId(periodPlanId)
	local periodId = -1
	local periodCfgs = NewBreakFormationConfig.instance:getPeriodCfgs(periodPlanId)
	local now = ServerTime.now()

	for i, v in ipairs(periodCfgs) do
		local startTimeStamp = GameUtil.string2time(v.startDateTime)
		local endTimeStamp = GameUtil.string2time(v.endDateTime)

		if startTimeStamp < now and now < endTimeStamp then
			periodId = v.periodId
		end
	end

	return periodId
end

NewBreakFormationController.instance = NewBreakFormationController.New()

return NewBreakFormationController
