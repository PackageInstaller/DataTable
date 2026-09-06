-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/controller/FarnasController.lua

module("logic.extensions.farnas.controller.FarnasController", package.seeall)

local FarnasController = class("FarnasController", BaseController)

function FarnasController:ctor()
	return
end

function FarnasController:onInit()
	GlobalDispatcher:addListener("enterfarnaschallenge", self._enterFarnaschallenge, self)
	self:onReset()
end

function FarnasController:onReset()
	self:clearCacheNorInfoList()
end

function FarnasController:_enterFarnaschallenge(params)
	self:enterFarnaschallenge(checknumber(params[1]))
end

function FarnasController:enterFarnaschallenge(activityId)
	if checknumber(activityId) <= 0 then
		activityId = self:getActivityId()
	end

	if not self:isInActivityTime(activityId) then
		FloatWordMgr.instance:show("不在活动开始时间内")

		return
	end

	UIStateManager.instance:push(ViewName.FarnasmainView, activityId)
end

function FarnasController:getActivityId()
	return ActivityDefineController.instance:getActivityIdByType(self:getActivityType())
end

function FarnasController:getActivityType()
	return GameEnum.ActivityType.Farnas
end

function FarnasController:isInActivityTime(activityId)
	local activityType = self:getActivityType()

	return ActivityDefineController.instance:isInActivityTimeById(activityType, activityId)
end

function FarnasController:getRaceId(activityId)
	return PetSkinConfig.instance:getPetSkinRaceId(FarnasConfig.instance:getSkinId(activityId))
end

function FarnasController:getTryEnterNorClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间内"
	elseif self:hasGainAllNormalClgPrize(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已通关"
	end

	return result, tips
end

function FarnasController:getTryEnterExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.NotInTime
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize(activityId) then
		result = GameEnum.ResultCode.IsHasGain
		tips = "已通关"
	end

	return result, tips
end

function FarnasController:getTryFightExtClgResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize(activityId) or self:isPassOfExtStage(stageId) then
		result = GameEnum.ResultCode.Error
		tips = "当前关卡已通关"
	end

	return result, tips
end

function FarnasController:getTryFightNorClgResultAndTips(activityId, dataBitId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isGetMaxScore(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "已达到最高积分奖励"
	end

	return result, tips
end

function FarnasController:getTryGetPrizeExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:isHasGainExtremeClgPrize(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "奖励已领取"
	elseif not self:isPassAllOfExtStage(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "存在未通关关卡"
	end

	return result, tips
end

function FarnasController:getTryRefreshExtClgResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if not self:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在活动时间内"
	elseif self:getPassCountOfExtStage(activityId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "无需重置"
	elseif self:isHasGainExtremeClgPrize(activityId) or self:isPassAllOfExtStage(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "所有关卡已通关"
	end

	return result, tips
end

function FarnasController:isHasGainExtremeClgPrize(activityId)
	return FarnasModel.instance:isHasGainExtremeClgPrize(activityId)
end

function FarnasController:isPassAllOfExtStage(activityId)
	local result = true
	local cfgs = FarnasConfig.instance:getExtStageCfgs(activityId)

	for _, data in ipairs(cfgs) do
		if not self:isPassOfExtStage(activityId, data.stageId) then
			result = false

			break
		end
	end

	return result
end

function FarnasController:isPassOfExtStage(activityId, stageId)
	return FarnasModel.instance:isPassOfExtStage(activityId, stageId)
end

function FarnasController:getProgressOfNorClg()
	return FarnasModel.instance:getProgressOfNorClg()
end

function FarnasController:hasGainAllNormalClgPrize(activityId)
	return FarnasModel.instance:hasGainAllNormalClgPrize(activityId)
end

function FarnasController:isCanGainPrizeOfNorClg(activityId, dataBitId)
	return self:isEnoughGainPrizeOfNorClg(activityId, dataBitId) and not self:isHasGainPrizeOfNorClg(activityId, dataBitId)
end

function FarnasController:isEnoughGainPrizeOfNorClg(activityId, dataBitId)
	local data = FarnasConfig.instance:getNorProgressCfg(activityId, dataBitId)
	local cur = self:getProgressOfNorClg()

	return cur >= data.progress
end

function FarnasController:isHasGainPrizeOfNorClg(activityId, dataBitId)
	local list = FarnasModel.instance:getProgressPrizeGainedBitIdListOfNorClg(activityId)

	return table.indexof(list, dataBitId) ~= false
end

function FarnasController:getNormalClgTodayGroupId(activityId)
	return FarnasModel.instance:getNormalClgTodayGroupId(activityId)
end

function FarnasController:getBestScoreOfNorClg(activityId, dataBitId)
	local infos = FarnasModel.instance:getNormalClgStageInfo(activityId)

	if not infos then
		return 0
	end

	for i, v in ipairs(infos) do
		if v.dataBitId == dataBitId then
			return v.bestScore
		end
	end

	return 0
end

function FarnasController:getDetailInfoListOfNorClg(activityId, groupId, dataBitId)
	local key = self:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	local value = GameUtil.getUserDayData(key)
	local infoList = GameUtil.jsonToTable(value)

	return infoList or {}
end

function FarnasController:saveDetailInfoListOfNorClg(activityId, groupId, dataBitId, infoList)
	local tempInfoList = self:getDetailInfoListOfNorClg(activityId, groupId, dataBitId)
	local totalScore = checknumber(tempInfoList.totalScore)

	if totalScore > 0 and totalScore >= infoList.totalScore then
		return
	end

	local key = self:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	local value = GameUtil.jsonToString(infoList)

	GameUtil.saveUserDayData(key, value)
end

function FarnasController:getDetailInfoListKeyOfNorClg(activityId, groupId, dataBitId)
	return string.format("FarnasClgNor_%s_%s_%s", activityId, groupId, dataBitId)
end

function FarnasController:getAllLockedRaceIdOfExtStage(activityId)
	local raceIdPool = {}
	local cfgs = FarnasConfig.instance:getExtStageCfgs(activityId)

	for _, data in ipairs(cfgs) do
		local list = self:getLockedRaceIdListOfExtStage(activityId, data.stageId)

		for _, raceId in ipairs(list) do
			raceIdPool[raceId] = raceId
		end
	end

	return (TableUtil.toList(raceIdPool))
end

function FarnasController:getLockedRaceIdOfExtStage(activityId, stageId)
	return (self:getLockedRaceIdListOfExtStage(activityId, stageId))
end

function FarnasController:getLockedRaceIdListOfExtStage(activityId, stageId)
	return FarnasModel.instance:getLockedRaceIdListOfExtStage(activityId, stageId)
end

function FarnasController:getPassCountOfExtStage(activityId)
	local result = 0
	local cfgs = FarnasConfig.instance:getExtStageCfgs(activityId)

	for _, data in ipairs(cfgs) do
		if self:isPassOfExtStage(activityId, data.stageId) then
			result = result + 1
		end
	end

	return result
end

function FarnasController:enterBattleOfNorClg(activityId, groupId, dataBitId)
	local customFmtMo = FarnasModel.instance:getCustomFmtMoOfNor()

	customFmtMo:updateCfg(activityId, groupId, dataBitId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FarnasController:enterBattleOfExtClg(activityId, stageId)
	local customFmtMo = FarnasModel.instance:getCustomFmtMoOfExt()

	customFmtMo:updateCfg(activityId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function FarnasController:handlePM_FarnasClgNormalFightRes(msg)
	BattleFacade.instance:startFarnasClgNorBattle()
end

function FarnasController:handlePM_FarnasClgNotifyNormalFightResultRes(msg)
	FarnasModel.instance:handlePM_FarnasClgNotifyNormalFightResultRes(msg)

	FarnasModel.instance.isNormalFightWin = msg.win

	if msg.win then
		local activityId = msg.activityId
		local groupId = FarnasModel.instance:getNormalClgTodayGroupId(activityId)
		local dataBitId = msg.dataBitId
		local actCfg = FarnasConfig.instance:getActCfg(activityId)
		local infoList = {
			totalScore = msg.curFightScore,
			ruleResult = {},
			normalClgWinBaseScore = actCfg.normalClgWinBaseScore,
			bestScore = msg.bestScore
		}

		for idx, v in ipairs(msg.ruleResult) do
			local info = GameUtil.pbToTable(v)

			table.insert(infoList.ruleResult, info)
		end

		self._cacheNorInfoList = infoList

		FarnasModel.instance:updateNormalClgStageBestScore(dataBitId, msg.bestScore)
		self:saveDetailInfoListOfNorClg(activityId, groupId, dataBitId, infoList)
	end
end

function FarnasController:enterClgNorResultView()
	local msg = FarnasModel.instance:getFightResultResOfNorClg()

	if msg == nil then
		BattleController.instance:endBattle()
	else
		local activityId = msg.activityId
		local groupId = FarnasModel.instance:getNormalClgTodayGroupId(activityId)
		local dataBitId = msg.dataBitId

		local function callBack()
			BattleController.instance:endBattle()
		end

		UIStateManager.instance:push(ViewName.FarnasnordetailView, activityId, groupId, dataBitId, callBack)
	end
end

function FarnasController:enterClgExtResultView()
	local msg = FarnasModel.instance:getExtFightResultRes()

	if msg == nil then
		BattleController.instance:endBattle()
	else
		local activityId = msg.activityId
		local stageId = msg.stageId
		local confirmNum = checknumber(msg.confirmNum)
		local stageData = FarnasConfig.instance:getExtStageCfg(activityId, stageId)

		if stageData then
			if not stageData.dodgeCount then
				local isPass = msg.win

				if isPass then
					ViewMgr.instance:open(ViewName.FarnasextsuccessView)
				else
					ViewMgr.instance:open(ViewName.FarnasextfailView)
				end
			end
		end
	end
end

function FarnasController:regFightResultInExt(activityId)
	local function handleBattleEnd()
		BattleFacade.instance:registerResultHandler(nil, nil)

		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = self:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end

		local msg = FarnasModel.instance:getExtFightResultRes()

		if msg == nil then
			BattleController.instance:endBattle()

			return false
		else
			local activityId = msg.activityId
			local stageId = msg.stageId
			local confirmNum = checknumber(msg.confirmNum)
			local stageData = FarnasConfig.instance:getExtStageCfg(activityId, stageId)

			if stageData then
				if not stageData.dodgeCount then
					local isPass = msg.win

					if msg.passExtremeClg then
						ViewMgr.instance:open(ViewName.FarnasextallpassView)
					elseif isPass then
						ViewMgr.instance:open(ViewName.FarnasextsuccessView)
					else
						ViewMgr.instance:open(ViewName.FarnasextfailView)
					end

					return true
				end
			end
		end
	end

	BattleFacade.instance:registerResultHandler(GameUtil.handler(handleBattleEnd), self)
end

function FarnasController:handlePM_FarnasClgExtremeFightRes(msg)
	return
end

function FarnasController:handlePM_FarnasClgNotifyExtremeFightResultRes(msg)
	FarnasModel.instance:handlePM_FarnasClgNotifyExtremeFightResultRes(msg)
end

function FarnasController:isGetMaxScore(activityId)
	local infos = FarnasModel.instance:getNormalClgStageInfo(activityId)

	if not infos then
		return false
	end

	local bestScore = 0

	for i, v in ipairs(infos) do
		bestScore = bestScore + v.bestScore
	end

	local norCfgs = FarnasConfig.instance:getNorProgressCfgs(self:getActivityId())

	return ((norCfgs or nil) and norCfgs[#norCfgs].progress) <= bestScore
end

function FarnasController:getAllLockedRaceIdOfExtStage(activityId)
	local raceIdPool = {}
	local cfgs = FarnasConfig.instance:getExtStageCfgs(activityId)

	for _, data in ipairs(cfgs) do
		local list = self:getLockedRaceIdListOfExtStage(activityId, data.stageId)

		for _, raceId in ipairs(list) do
			raceIdPool[raceId] = raceId
		end
	end

	return (TableUtil.toList(raceIdPool))
end

function FarnasController:getLockedRaceIdListOfExtStage(activityId, stageId)
	return FarnasModel.instance:getLockedRaceIdListOfExtStage(activityId, stageId)
end

function FarnasController:setInfo(msg)
	FarnasModel.instance:setInfo(msg)
	self:_calRedPoint()
end

function FarnasController:gainNormalClgPrize(activityId, dataBitId)
	FarnasModel.instance:gainNormalClgPrize(activityId, dataBitId)
	self:_calRedPoint()
end

function FarnasController:gainExtremeClgPrize(activityId)
	FarnasModel.instance:gainExtremeClgPrize(activityId)
	self:_calRedPoint()
end

function FarnasController:_calRedPoint()
	local activityId = self:getActivityId()
	local norPrizeDot = false
	local extPrizeDot = false

	if activityId > 0 then
		local progressCfgs = FarnasConfig.instance:getNorProgressCfgs(activityId)

		for i, v in ipairs(progressCfgs) do
			if self:isCanGainPrizeOfNorClg(activityId, v.dataBitId) then
				norPrizeDot = true

				break
			end
		end

		extPrizeDot = not self:isHasGainExtremeClgPrize(activityId) and self:isPassAllOfExtStage(activityId)
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Farnas_NorPrize, norPrizeDot)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_Farnas_ExtPrize, extPrizeDot)
end

function FarnasController:getCacheNorInfoList()
	return self._cacheNorInfoList or {}
end

function FarnasController:clearCacheNorInfoList()
	self._cacheNorInfoList = nil
end

FarnasController.instance = FarnasController.New()

return FarnasController
