-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/controller/LuYinJiaDeController.lua

module("logic.extensions.luyinjiade.controller.LuYinJiaDeController", package.seeall)

local LuYinJiaDeController = class("LuYinJiaDeController", BaseController)

function LuYinJiaDeController:getSkinId(activityId)
	return LuYinJiaDeConfig.instance:getSkinId(activityId)
end

function LuYinJiaDeController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(self:getSkinId(activityId))
end

function LuYinJiaDeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function LuYinJiaDeController:sendPM_LuYinJiaDeClgGetInfoReq(activityId)
	LuYinJiaDeAgent.instance:sendPM_LuYinJiaDeClgGetInfoReq(activityId)
end

function LuYinJiaDeController:handlePM_LuYinJiaDeClgGetInfoRes(msg)
	LuYinJiaDeModel.instance:handlePM_LuYinJiaDeClgGetInfoRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuYinJiaDeClgGetInfoRes)
end

function LuYinJiaDeController:sendPM_LuYinJiaDeClgGodRankViewReq(activityId)
	LuYinJiaDeAgent.instance:sendPM_LuYinJiaDeClgGodRankViewReq(activityId)
end

function LuYinJiaDeController:handlePM_LuYinJiaDeClgGodRankViewRes(msg)
	LuYinJiaDeModel.instance:handlePM_LuYinJiaDeClgGodRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuYinJiaDeClgGodRankViewRes, msg)
end

function LuYinJiaDeController:sendPM_LuYinJiaDeClgDailyRankViewReq(activityId)
	LuYinJiaDeAgent.instance:sendPM_LuYinJiaDeClgDailyRankViewReq(activityId)
end

function LuYinJiaDeController:handlePM_LuYinJiaDeClgDailyRankViewRes(msg)
	LuYinJiaDeModel.instance:handlePM_LuYinJiaDeClgDailyRankViewRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuYinJiaDeClgDailyRankViewRes, msg)
end

function LuYinJiaDeController:sendPM_LuYinJiaDeClgFightReq(activityId, stageId, form)
	LuYinJiaDeAgent.instance:sendPM_LuYinJiaDeClgFightReq(activityId, stageId, form)
end

function LuYinJiaDeController:handlePM_LuYinJiaDeClgNotifyFightRes(msg)
	local preInfo = LuYinJiaDeModel.instance:getInfo(msg.activityId)
	local newPreInfo = {}

	newPreInfo.stageList = preInfo.stageList
	newPreInfo.signBuffId = preInfo.signBuffId

	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onResFightEnd, self, msg, newPreInfo))
	LuYinJiaDeModel.instance:handlePM_LuYinJiaDeClgNotifyFightRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PM_LuYinJiaDeClgNotifyFightRes)
end

function LuYinJiaDeController:_onResFightEnd(msg, preInfo)
	if preInfo.stageList then
		local params = {}

		params.activityId = msg.activityId
		params.stageId = msg.stageId
		params.curDamage = msg.curDamage
		params.signBuffId = msg.signBuffId
		params.curStageScore = msg.curStageScore
		params.curspecialScore = msg.curspecialScore
		params.preStageInfo = preInfo.stageList
		params.preSignBuffId = preInfo.signBuffId

		UIStateManager.instance:push(ViewName.LuYinJiaDeChallengeFightEndView, params)

		return true
	end
end

function LuYinJiaDeController:enterBattleClg(activityId, stageId)
	local customFmtMo = LuYinJiaDeModel.instance:getFmtMo(activityId)

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function LuYinJiaDeController:getTotalScore(activityId)
	local info = LuYinJiaDeModel.instance:getInfo(activityId)
	local totalScore = 0

	for idx, stageInfo in pairs(info.stageList) do
		totalScore = totalScore + stageInfo.stageScore + stageInfo.specialScore
	end

	return totalScore
end

function LuYinJiaDeController:canShowDailyRank(activityId)
	local actCfg = LuYinJiaDeConfig.instance:getActData(activityId)
	local startTime = actCfg.dailyRankStartTime
	local endTime = actCfg.dailyRankEndTime
	local isInChallengeTime = self:isInChallengeTime(activityId)

	if not GameUtil.isEmptyString(startTime) and not GameUtil.isEmptyString(endTime) then
		return GameUtil.checkIsInTimePeriod(startTime, endTime, false) and isInChallengeTime
	end
end

function LuYinJiaDeController:isInChallengeTime(activityId)
	local actCfg = LuYinJiaDeConfig.instance:getActData(activityId)
	local challengeClosedTimeRange = actCfg.challengeClosedTimeRange
	local arr = string.split(challengeClosedTimeRange, "-")

	return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
end

LuYinJiaDeController.instance = LuYinJiaDeController.New()

return LuYinJiaDeController
