-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tuntianchallenge/controller/TunTianChallengeController.lua

module("logic.extensions.tuntianchallenge.controller.TunTianChallengeController", package.seeall)

local TunTianChallengeController = class("TunTianChallengeController", BaseController)

function TunTianChallengeController:ctor()
	return
end

function TunTianChallengeController:onInit()
	GlobalDispatcher:addListener("entertuntianchallenge", self._enterTunTianChallenge, self)
end

function TunTianChallengeController:onReset()
	return
end

function TunTianChallengeController:sendPM_TunTianClgGetInfoReq(activityId)
	TunTianChallengeAgent.instance:sendPM_TunTianClgGetInfoReq(activityId)
end

function TunTianChallengeController:handlePM_TunTianClgGetInfoRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianClgGetInfoRes(msg)
	self:_updateNormalRed(msg.activityId)
	self:_updateExtremeRed(msg.activityId)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianClgGetInfoRes)
end

function TunTianChallengeController:sendPM_TunTianNormalClgFightReq(activityId, slotId, monsterId, form)
	TunTianChallengeAgent.instance:sendPM_TunTianNormalClgFightReq(activityId, slotId, monsterId, form)
end

function TunTianChallengeController:handlePM_TunTianNormalClgFightRes(status, msg)
	if status == 0 then
		TunTianChallengeModel.instance:handlePM_TunTianNormalClgFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TunTianNormalClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function TunTianChallengeController:sendPM_TunTianRefreshNormalClgMonsterReq(activityId)
	TunTianChallengeAgent.instance:sendPM_TunTianRefreshNormalClgMonsterReq(activityId)
end

function TunTianChallengeController:handlePM_TunTianRefreshNormalClgMonsterRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianRefreshNormalClgMonsterRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianRefreshNormalClgMonsterRes)
end

function TunTianChallengeController:sendPM_TunTianGainNormalClgProgressPrizeReq(activityId, dataBitId)
	TunTianChallengeAgent.instance:sendPM_TunTianGainNormalClgProgressPrizeReq(activityId, dataBitId)
end

function TunTianChallengeController:handlePM_TunTianGainNormalClgProgressPrizeRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianGainNormalClgProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianGainNormalClgProgressPrizeRes)
end

function TunTianChallengeController:sendPM_TunTianExtremeClgFightReq(activityId, stageType, stageId, form)
	BattleFacade.instance:registerResultHandler(GameUtil.handler(self._onExtBattleEnd, self, activityId, stageType, stageId))
	TunTianChallengeAgent.instance:sendPM_TunTianExtremeClgFightReq(activityId, stageType, stageId, form)
end

function TunTianChallengeController:handlePM_TunTianExtremeClgFightRes(status, msg)
	if status == 0 then
		TunTianChallengeModel.instance:handlePM_TunTianExtremeClgFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.TunTianExtremeClgFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function TunTianChallengeController:sendPM_TunTianExtremeClgUseNewStageScoreReq(activityId, stageType, stageId, useNewScore, newScore)
	TunTianChallengeAgent.instance:sendPM_TunTianExtremeClgUseNewStageScoreReq(activityId, stageType, stageId, useNewScore, newScore)
end

function TunTianChallengeController:handlePM_TunTianExtremeClgUseNewStageScoreRes(status, msg)
	if status == 0 then
		TunTianChallengeModel.instance:handlePM_TunTianExtremeClgUseNewStageScoreRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.TunTianExtremeClgUseNewStageScoreRes, status)
end

function TunTianChallengeController:sendPM_TunTianGainExtremeClgPrizeReq(activityId)
	TunTianChallengeAgent.instance:sendPM_TunTianGainExtremeClgPrizeReq(activityId)
end

function TunTianChallengeController:handlePM_TunTianGainExtremeClgPrizeRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianGainExtremeClgPrizeRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianGainExtremeClgPrizeRes)
end

function TunTianChallengeController:handlePM_TunTianNotifyNormalClgFightResultRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianNotifyNormalClgFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianNotifyNormalClgFightResultRes)
end

function TunTianChallengeController:handlePM_TunTianNotifyExtremeClgFightResultRes(msg)
	TunTianChallengeModel.instance:handlePM_TunTianNotifyExtremeClgFightResultRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TunTianNotifyExtremeClgFightResultRes)
end

function TunTianChallengeController:_onExtBattleEnd(activityId, stageType, stageId)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

	if isAoqiGodProcessType then
		local activityType = self:getActivityType()

		AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
	end

	local msg = TunTianChallengeModel.instance:getFightResultResMsgOfExtClg()

	if msg and msg.stageType == stageType and checkbool(msg.stashScore) == true then
		local oldScore = TunTianChallengeController.instance:getStageScoreOfExtClg(msg.stageType, msg.stageId)
		local newScore = checknumber(msg.convertScore)

		if oldScore ~= newScore then
			UIStateManager.instance:push(ViewName.TunTianChallengeExtremeSureView, activityId, stageType, stageId, oldScore, newScore)

			return true
		end
	end

	return false
end

function TunTianChallengeController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function TunTianChallengeController:getActivityType()
	return GameEnum.ActivityType.TunTianChallenge
end

function TunTianChallengeController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function TunTianChallengeController:_enterTunTianChallenge(params)
	self:enterTunTianChallenge(checknumber(params[1]))
end

function TunTianChallengeController:enterTunTianChallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.TunTianChallengeMainView, activityId)
end

function TunTianChallengeController:_updateNormalRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_TUNTIAN_CHALLENGE_NORMAL

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and (self:isEnoughLeftFightCountOfNorClg() or self:isHaveCanGetPrizeInProgressOfNorClg(activityId)) or nil) and true)
end

function TunTianChallengeController:_updateExtremeRed(activityId)
	activityId = checknumber(activityId)

	local redId = RedPointModel.ID_TUNTIAN_CHALLENGE_EXTREME

	RedPointController.instance:setRedPointInfo(redId, (self:isInActivityTime(activityId) and self:isCanGainPrizeOfExtClg(activityId) or nil) and true)
end

function TunTianChallengeController:getTryGainPrizeOfNorClgResultAndTips(activityId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeInProgressOfNorClg(dataBitId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "您已领奖"
	elseif not self:isEnoughPrizeInProgressOfNorClg(activityId, dataBitId) then
		result = GameEnum.ResultCode.NotEnoughProgress
		tips = "未满足领奖要求"
	end

	return result, tips
end

function TunTianChallengeController:isHaveCanGetPrizeInProgressOfNorClg(activityId)
	local isHave = false
	local dataList = TunTianChallengeConfig.instance:getTtNorProgressDataList(activityId)

	for _, data in ipairs(dataList) do
		if self:isCanGetPrizeInProgressOfNorClg(activityId, data.dataBitId) then
			isHave = true

			break
		end
	end

	return isHave
end

function TunTianChallengeController:isCanGetPrizeInProgressOfNorClg(activityId, dataBitId)
	local result, tips = self:getTryGainPrizeOfNorClgResultAndTips(activityId, dataBitId)

	return result == GameEnum.ResultCode.Success
end

function TunTianChallengeController:isHasGainPrizeInProgressOfNorClg(dataBitId)
	return TunTianChallengeModel.instance:isHasGainPrizeOfNormalClg(dataBitId)
end

function TunTianChallengeController:isEnoughPrizeInProgressOfNorClg(activityId, dataBitId)
	local curProgress = self:getCurProgressOfNorClg()
	local data = TunTianChallengeConfig.instance:getTtNorProgressData(activityId, dataBitId)
	local needProgress = data.progress

	return needProgress <= curProgress
end

function TunTianChallengeController:getCurProgressOfNorClg()
	return TunTianChallengeModel.instance:getCurProgressOfNorClg()
end

function TunTianChallengeController:getMaxProgressOfNorClg(activityId)
	local cfg = TunTianChallengeConfig.instance:getTtNorProgressDataList(activityId)

	return cfg[#cfg].progress
end

function TunTianChallengeController:enterBattleOfNorClg(activityId, slotId, monsterId)
	local customFmtMo = TunTianChallengeModel.instance:getCustomFmtMoOfNorClg()

	customFmtMo:updateCfg(activityId, slotId, monsterId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function TunTianChallengeController:enterBattleOfExtClg(activityId, stageType, stageId)
	local customFmtMo = TunTianChallengeModel.instance:getCustomFmtMoOfExtClg()

	customFmtMo:updateCfg(activityId, stageType, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function TunTianChallengeController:getTryFightMonsterOfNorClgResultAndTips(activityId, slotId, monsterId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif monsterId <= 0 then
		result = GameEnum.ResultCode.Error
	elseif not self:isEnoughLeftFightCountOfNorClg() then
		result = GameEnum.ResultCode.Error
		tips = "剩余挑战次数不足"
	end

	return result, tips
end

function TunTianChallengeController:getTryRefreshMonsterOfNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif not self:isEnoughLeftRefreshMonsterCountOfNorClg() then
		result = GameEnum.ResultCode.Error
		tips = "剩余刷新次数不足"
	end

	return result, tips
end

function TunTianChallengeController:isEnoughLeftFightCountOfNorClg()
	local leftCount = self:getLeftFightCountOfNorClg()

	return leftCount > 0
end

function TunTianChallengeController:isEnoughLeftRefreshMonsterCountOfNorClg()
	local leftCount = self:getLeftRefreshMonsterCountOfNorClg()

	return leftCount > 0
end

function TunTianChallengeController:getLeftFightCountOfNorClg()
	return TunTianChallengeModel.instance:getLeftFightCountOfNorClg()
end

function TunTianChallengeController:getMaxFightCountOfNorClg(activityId)
	local data = TunTianChallengeConfig.instance:getTtBaseData(activityId)

	return data and data.normalClgDailyCount
end

function TunTianChallengeController:getLeftRefreshMonsterCountOfNorClg()
	return TunTianChallengeModel.instance:getLeftRefreshMonsterCountOfNorClg()
end

function TunTianChallengeController:getMaxRefreshMonsterCountOfNorClg(activityId)
	local data = TunTianChallengeConfig.instance:getTtBaseData(activityId)

	return data and data.normalClgMonsterCount
end

function TunTianChallengeController:getTryFightStageOfExtClgResultAndTips(activityId, stageType, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfExtClg() then
		result = GameEnum.ResultCode.Error
		tips = "您已通关"
	elseif self:isBalancedOfExtClg(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "您已完成平衡"
	end

	return result, tips
end

function TunTianChallengeController:getTryGetPrizeOfExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainPrizeOfExtClg() then
		result = GameEnum.ResultCode.Error
		tips = "您已通关"
	elseif not self:isBalancedOfExtClg(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "您未完成平衡"
	end

	return result, tips
end

function TunTianChallengeController:isCanGainPrizeOfExtClg(activityId)
	local result = TunTianChallengeController.instance:getTryGetPrizeOfExtClgResultAndTips(activityId)

	return result == GameEnum.ResultCode.Success
end

function TunTianChallengeController:isHasGainPrizeOfExtClg()
	return TunTianChallengeModel.instance:isHasGainPrizeOfExtClg()
end

function TunTianChallengeController:isBalancedOfExtClg(activityId)
	local isBalanced = true
	local status, lastScore, thisScore
	local stageTypeCfg = TunTianChallengeConfig.instance:getTtExtStageTypeDataList(activityId)

	for _, data in ipairs(stageTypeCfg) do
		if self:getStageTypeStatusOfExtClg(activityId, data.stageType) ~= TunTianChallengeModel.StageTypeStatus.HasPass then
			isBalanced = false

			break
		else
			thisScore = self:getStageTypeScoreOfExtClg(activityId, data.stageType)
			lastScore = lastScore or thisScore

			if thisScore ~= lastScore then
				isBalanced = false

				break
			else
				lastScore = thisScore
			end
		end
	end

	return isBalanced
end

function TunTianChallengeController:getStageTypeScoreOfExtClg(activityId, stageType)
	local totalScore = 0
	local dataList = TunTianChallengeConfig.instance:getTtExtStageDataList(activityId, stageType)

	for _, data in ipairs(dataList) do
		totalScore = totalScore + self:getStageScoreOfExtClg(stageType, data.stageId)
	end

	return totalScore
end

function TunTianChallengeController:getStageTypeStatusOfExtClg(activityId, stageType)
	local stageTypeStatus = TunTianChallengeModel.StageTypeStatus.HasPass
	local dataList = TunTianChallengeConfig.instance:getTtExtStageDataList(activityId, stageType)

	for _, data in ipairs(dataList) do
		if self:getStageStatusOfExtClg(stageType, data.stageId) ~= TunTianChallengeModel.StageStatus.ChallengeSuc then
			stageTypeStatus = TunTianChallengeModel.StageTypeStatus.NotPass

			break
		end
	end

	return stageTypeStatus
end

function TunTianChallengeController:getStageScoreOfExtClg(stageType, stageId)
	return TunTianChallengeModel.instance:getStageScoreOfExtClg(stageType, stageId)
end

function TunTianChallengeController:getStageStatusOfExtClg(stageType, stageId)
	return TunTianChallengeModel.instance:getStageStatusOfExtClg(stageType, stageId)
end

TunTianChallengeController.instance = TunTianChallengeController.New()

return TunTianChallengeController
