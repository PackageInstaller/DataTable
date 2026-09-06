-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/model/MaterialChallengeModel.lua

module("logic.extensions.materialchallenge.model.MaterialChallengeModel", package.seeall)

local json = require("cjson")
local MaterialChallengeModel = class("MaterialChallengeModel", BaseModel)

function MaterialChallengeModel:onInit()
	self:onReset()
end

function MaterialChallengeModel:onReset()
	self._notifyAfterChallengeRes = nil
	self._infoRes = nil
	self._challengeRes = nil
	self._dailyTaskRewardRes = nil
	self._oneKeyDailyTaskRewardRes = nil
	self._sweepsByTimesRes = nil
	self._sweepAutoRes = nil
	self._simpleProgressInfoRes = nil
	self._buyTimes = {}
	self._freeStrenghtTimes = {}
	self._stageLists = {}
	self._rewardMultiplyTimes = {}
	self._baseTimes = 0
end

function MaterialChallengeModel:onNotifyAfterChallengeRes(msg)
	self._notifyAfterChallengeRes = msg

	if msg.isWin then
		self:_updateSimpleProgressInfoRes(msg.typeId, msg.stageId)
	end
end

function MaterialChallengeModel:onInfoRes(msg)
	self._infoRes = msg
	self._buyTimes[msg.typeId] = msg.buyTimes
	self._freeStrenghtTimes[msg.typeId] = msg.freeStrenghtTimes

	self:_updateStageEvaluateList(msg.typeId, msg.stages)
end

function MaterialChallengeModel:onChallengeRes(msg)
	self._challengeRes = msg
end

function MaterialChallengeModel:onDailyTaskRewardRes(msg)
	self._dailyTaskRewardRes = msg

	self:updateDailyTaskReward(msg.typeId, msg.index)
end

function MaterialChallengeModel:onOneKeyDailyTaskRewardRes(msg)
	self._oneKeyDailyTaskRewardRes = msg

	self:updateOneKeyDailyTaskReward(msg.typeId)
end

function MaterialChallengeModel:onSweepsByTimesRes(msg)
	self._sweepsByTimesRes = msg
end

function MaterialChallengeModel:onSweepAutoRes(msg)
	self._sweepAutoRes = msg
end

function MaterialChallengeModel:onSimpleProgressInfoRes(msg)
	self._simpleProgressInfoRes = msg

	if self._simpleProgressInfoRes then
		local infos = self._simpleProgressInfoRes.infos

		for i, v in ipairs(infos) do
			self._buyTimes[v.typeId] = v.buyTimes
			self._freeStrenghtTimes[v.typeId] = v.freeStrengthTimes
		end
	end
end

function MaterialChallengeModel:onNotifyBaseMultiplyTimesChangeRes(msg)
	self._baseTimes = msg.baseTimes
end

function MaterialChallengeModel:resetSimpleProgressInfo()
	if self._simpleProgressInfoRes then
		local infos = self._simpleProgressInfoRes.infos

		for i, v in ipairs(infos) do
			v.buyTimes = 0
			v.freeStrengthTimes = 0
			v.fightTimes = 0
			self._buyTimes[v.typeId] = v.buyTimes
			self._freeStrenghtTimes[v.typeId] = v.freeStrengthTimes
		end
	end
end

function MaterialChallengeModel:getFreeStrenghtMaxTimes(chapterId)
	local times = 0

	if chapterId == GameEnum.ResCopyType.Exp then
		times = VipModel.instance:getTimesWithoutEnergyOfExpCopy()
	elseif chapterId == GameEnum.ResCopyType.Coin then
		times = VipModel.instance:getTimesWithoutEnergyOfCoinCopy()
	elseif chapterId == GameEnum.ResCopyType.Stargod then
		times = VipModel.instance:getTimesWithoutEnergyOfStarCopy()
	elseif chapterId == GameEnum.ResCopyType.Equip then
		times = VipModel.instance:getTimesWithoutEnergyOfEquipCopy()
	end

	return times
end

function MaterialChallengeModel:consumeFreeStrenghtTimes(typeId, times)
	self._freeStrenghtTimes[typeId] = (self._freeStrenghtTimes[typeId] or 0) + (times or 1)
end

function MaterialChallengeModel:getFreeStrenghtTimes(typeId)
	if self._freeStrenghtTimes[typeId] then
		return self._freeStrenghtTimes[typeId]
	end

	return 0
end

function MaterialChallengeModel:onBuyChallengeTimesRes(msg)
	self._buyTimes[msg.typeId] = msg.buyTimes
end

function MaterialChallengeModel:getBuyTimes(typeId)
	if self._buyTimes[typeId] then
		return self._buyTimes[typeId]
	end

	return 0
end

function MaterialChallengeModel:updateDailyTaskReward(typeId, index)
	if self._infoRes and self._infoRes.typeId == typeId then
		local index = index + 1

		for i, v in ipairs(self._infoRes.dailyTaskReward) do
			if index == i then
				self._infoRes.dailyTaskReward[i] = true
			end
		end
	end
end

function MaterialChallengeModel:updateOneKeyDailyTaskReward(typeId)
	if self._infoRes and self._infoRes.typeId == typeId then
		local list = self._infoRes.dailyTaskReward

		for i, v in ipairs(list) do
			local index = i - 1
			local isCanGet = self:isCanGetReward(typeId, index)

			if isCanGet then
				list[i] = true
			end
		end
	end
end

function MaterialChallengeModel:_updateSimpleProgressInfoRes(typeId, curStageId)
	if self._simpleProgressInfoRes then
		local infos = self._simpleProgressInfoRes.infos

		for i, v in ipairs(infos) do
			if v.typeId == typeId then
				v.fightTimes = v.fightTimes + 1

				if v.fightTimes >= 0 then
					v.fightTimes = v.fightTimes or 0
				end

				if curStageId > v.curStageId then
					v.curStageId = curStageId
				end
			end
		end
	end
end

function MaterialChallengeModel:_updateStageEvaluateList(chapterId, stages)
	self._stageLists = self._stageLists or {}
	self._stageLists[chapterId] = self._stageLists[chapterId] or {}

	for i, v in ipairs(stages) do
		self._stageLists[chapterId][v.stageId] = checknumber(v.max)
	end
end

function MaterialChallengeModel:getStageEvaluate(chapterId, stageId)
	if self._stageLists and self._stageLists[chapterId] and self._stageLists[chapterId][stageId] then
		return self._stageLists[chapterId][stageId]
	end

	return 0
end

function MaterialChallengeModel:getStageEvaluateLevelTxt(chapterId, stageId)
	local score = self:getStageEvaluate(chapterId, stageId)
	local cfg = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

	if cfg and cfg.rewardScore then
		local cfgEvaluates = MaterialChallengeConfig.instance:getEvaluateCfgs(cfg.rewardScore)
		local count = #cfgEvaluates

		if count > 0 then
			for i = count, 1, -1 do
				if score >= cfgEvaluates[i].processorSection then
					return cfgEvaluates[i].evaluate
				end
			end

			return cfgEvaluates[1].evaluate
		end
	end

	return "nil"
end

function MaterialChallengeModel:isAllStageScoreS(chapterId)
	local stageCfgs = MaterialChallengeConfig.instance:getStages(chapterId)

	for i, v in ipairs(stageCfgs) do
		local scoreTxt = self:getStageEvaluateLevelTxt(chapterId, v.stageId)
		local isMaxScore = scoreTxt == "S"

		if not isMaxScore then
			printInfo("test 有关卡不为S评分", chapterId, v.stageId, scoreTxt)

			return false
		end
	end

	return true
end

function MaterialChallengeModel:isStagePassed(chapterId, stageId)
	if not self._simpleProgressInfoRes then
		return false
	end

	local infos = self._simpleProgressInfoRes.infos

	for k, v in ipairs(infos) do
		if chapterId == v.typeId then
			if v.curStageId > 0 and stageId <= v.curStageId then
				return true
			end

			break
		end
	end

	return false
end

function MaterialChallengeModel:getCostLimitCount(chapterId)
	local curCount = 0
	local totalCount = 0
	local cfg = MaterialChallengeConfig.instance:getChapter(chapterId)

	totalCount = cfg and cfg.resourceChapterDailyLimit or 0

	if not self._simpleProgressInfoRes then
		curCount = 0
	else
		local infos = self._simpleProgressInfoRes.infos

		for i, v in ipairs(infos) do
			if v.typeId == chapterId then
				curCount = Mathf.Max(0, v.fightTimes) - self:getBuyTimes(v.typeId)
			end
		end
	end

	return curCount, totalCount
end

function MaterialChallengeModel:leftCostCount(chapterId)
	local curCount, totalCount = self:getCostLimitCount(chapterId)
	local result = totalCount - curCount

	return result >= 0 and result or 0
end

function MaterialChallengeModel:isChapterPassed(chapterId)
	local curFinishCount, chapterTotalCount = self:getStageFinishCount(chapterId)

	if curFinishCount ~= 0 and curFinishCount == chapterTotalCount then
		return true
	else
		return false
	end
end

function MaterialChallengeModel:isChapterUnlock(chapterId)
	return self:isStageUnlock(chapterId, 1)
end

function MaterialChallengeModel:isStageUnlock(chapterId, stageId)
	local cfg = MaterialChallengeConfig.instance:getStageById(chapterId, stageId)

	if cfg then
		if cfg.unlockId == 0 then
			return true
		end

		return (FuncOpenModel.instance:getFuncIsOpen(cfg.unlockId))
	end

	return false
end

function MaterialChallengeModel:_getChapterProgress(chapterId)
	local infos = self._simpleProgressInfoRes.infos

	for i, v in ipairs(infos) do
		if v.typeId == chapterId then
			return v
		end
	end

	return nil
end

function MaterialChallengeModel:getStageFinishCount(chapterId)
	local chapterProgress = self:_getChapterProgress(chapterId)
	local stageCfgs = MaterialChallengeConfig.instance:getStages(chapterId)
	local curFinishCount = 0
	local chapterTotalCount = #stageCfgs

	if chapterProgress == nil then
		return curFinishCount, chapterTotalCount
	end

	if chapterProgress.curStageId > 0 and chapterProgress.curStageId == #stageCfgs then
		curFinishCount = chapterTotalCount

		return chapterTotalCount, chapterTotalCount
	else
		for i = 1, chapterTotalCount do
			if stageCfgs[i].stageId == chapterProgress.curStageId then
				curFinishCount = chapterProgress.curStageId

				return chapterProgress.curStageId, chapterTotalCount
			end
		end

		return curFinishCount, chapterTotalCount
	end
end

function MaterialChallengeModel:curOpenStageNum(chapterId)
	local curProgress = self:_getChapterProgress(chapterId)

	if curProgress then
		local stages = MaterialChallengeConfig.instance:getStages(chapterId)

		return curProgress.curStageId == #stages and #stages or curProgress.curStageId + 1
	else
		return 0
	end
end

function MaterialChallengeModel:curDailyTaskValue(chapterId)
	if self._infoRes and self._infoRes.typeId == chapterId then
		return checknumber(self._infoRes.dailyTaskValue)
	end

	return 0
end

function MaterialChallengeModel:curDailyTaskProgress(chapterId)
	if self._infoRes and self._infoRes.typeId == chapterId then
		return self._infoRes.dailyTaskProgress
	end

	return 0
end

function MaterialChallengeModel:isGetedReward(chapterId, index)
	if self._infoRes and self._infoRes.typeId == chapterId then
		local list = self._infoRes.dailyTaskReward

		for i, v in ipairs(list) do
			if i == index + 1 then
				return v
			end
		end
	end

	return false
end

function MaterialChallengeModel:isCanGetReward(chapterId, index)
	if self:isGetedReward(chapterId, index) then
		return false
	end

	if self._infoRes and self._infoRes.typeId == chapterId then
		local progress = self._infoRes.dailyTaskProgress
		local curValue = checknumber(self._infoRes.dailyTaskValue)
		local cfgs = MaterialChallengeConfig.instance:getProcessorSectionCfgs(chapterId, progress)

		if cfgs and cfgs[index + 1] and curValue >= cfgs[index + 1].processorSection then
			return true
		end
	end

	return false
end

function MaterialChallengeModel:isOneKeyCanClick(chapterId)
	for i = 0, 2 do
		local isCanGet = self:isCanGetReward(chapterId, i)

		if isCanGet then
			return true
		end
	end

	return false
end

function MaterialChallengeModel:addChallengeCount(chapterId, num)
	if self._simpleProgressInfoRes then
		local infos = self._simpleProgressInfoRes.infos

		for i, v in ipairs(infos) do
			if v.typeId == chapterId then
				v.fightTimes = v.fightTimes + num

				if v.fightTimes >= 0 then
					v.fightTimes = v.fightTimes or 0
				end

				break
			end
		end
	end
end

function MaterialChallengeModel:getScore()
	local params = BattleSettlementModel.instance:getParams()
	local rewardScore = params.rewardScore
	local conditionType = BattleModel.instance:getConditionType()
	local conditionParams = BattleModel.instance:getConditionParams()
	local reward = ""
	local cfg = BattleSettlementConfig.instance:getBattleWinnerOpTypeCfgByType(conditionType)

	if not cfg then
		return GameEnum.Score.D, reward
	end

	local jConditionParams = json.decode(conditionParams)
	local score = checknumber(jConditionParams[cfg.paramNames[1]])
	local cfgEvaluate = self:getEveluateCfg(rewardScore, score)

	if cfgEvaluate then
		return cfgEvaluate.evaluate, cfgEvaluate.reward
	end

	return GameEnum.Score.D, reward
end

function MaterialChallengeModel:getEveluateCfg(rewardScore, score)
	local cfgEvaluates = MaterialChallengeConfig.instance:getEvaluateCfgs(rewardScore)

	if cfgEvaluates and #cfgEvaluates > 0 then
		local count = #cfgEvaluates

		for i = count, 1, -1 do
			if score >= cfgEvaluates[i].processorSection then
				return cfgEvaluates[i]
			end
		end

		return cfgEvaluates[1]
	end

	return nil
end

function MaterialChallengeModel:setRewardMultiplyTimes(msg)
	self._rewardMultiplyTimes = msg.infos
	self._baseTimes = msg.baseTimes
end

function MaterialChallengeModel:getMaterialDoubleTimes(campaignId)
	local cfg = ActivityPopupConfig.instance:getCampaignCfg(campaignId)

	if cfg.dailyLimitTimes < 0 then
		return -1
	end

	local leftTime = 0

	for i, v in ipairs(self._rewardMultiplyTimes) do
		if v.campaignId == campaignId then
			leftTime = math.max(0, cfg.dailyLimitTimes - v.times)

			break
		end
	end

	return leftTime
end

function MaterialChallengeModel:getMaterialDoubleTimesWithChapterId(chapterId)
	local list = ActivityPopupConfig.instance:getCfgByEffectType(GameEnum.CampaignType.Material)
	local campaignId = 0

	for i, v in ipairs(list) do
		if ActivityDefineController.instance:_isIdMatch(v.validatorParam, chapterId) then
			local needBreak = false

			for i, v0 in ipairs(self._rewardMultiplyTimes) do
				if v0.campaignId == v.id then
					campaignId = v.id
					needBreak = true

					break
				end
			end

			if needBreak then
				break
			end
		end
	end

	return (campaignId > 0 or nil) and self:getMaterialDoubleTimes(campaignId)
end

function MaterialChallengeModel:getMainPlotDoubleTimes()
	local list = ActivityPopupConfig.instance:getCfgByEffectType(GameEnum.CampaignType.Plot)
	local mainRewardTimes = PlotCopyModel.instance:getRewardMultiplyTime()

	for i, v in ipairs(list) do
		if ActivityDefineController.instance:_isIdMatch(v.validatorParam, 0) then
			local cfg = ActivityPopupConfig.instance:getCampaignCfg(v.id)

			if cfg.dailyLimitTimes < 0 then
				return -1
			end

			if mainRewardTimes and mainRewardTimes[v.id] then
				return cfg.dailyLimitTimes - mainRewardTimes[v.id]
			end
		end
	end

	return 0
end

function MaterialChallengeModel:getMaterialDoubleTimesDesc(chapterId)
	local list = ActivityPopupConfig.instance:getCfgByEffectType(GameEnum.CampaignType.Material)
	local campaignId = 0

	for i, v in ipairs(list) do
		if ActivityDefineController.instance:_isIdMatch(v.validatorParam, chapterId) then
			local needBreak = false

			for i, v0 in ipairs(self._rewardMultiplyTimes) do
				if v0.campaignId == v.id then
					campaignId = v.id
					needBreak = true

					break
				end
			end

			if needBreak then
				break
			end
		end
	end

	if campaignId > 0 then
		local leftTime = self:getMaterialDoubleTimes(campaignId)
		local desc = "今日剩余翻倍次数："

		desc = leftTime < 0 and desc .. "不限" or desc .. leftTime .. "次"

		return desc
	else
		return "暂无翻倍活动"
	end
end

function MaterialChallengeModel:addChallengeDoubleRewardCount(chapterId, num)
	local list = ActivityPopupConfig.instance:getCfgByEffectType(GameEnum.CampaignType.Material)
	local campaignId = 0
	local serverIds = {}

	for i, v in ipairs(self._rewardMultiplyTimes) do
		serverIds[v.campaignId] = v
	end

	for i, v in ipairs(list) do
		if serverIds[v.id] and ActivityDefineController.instance:_isIdMatch(v.validatorParam, chapterId) then
			campaignId = v.id

			break
		end
	end

	if campaignId > 0 and serverIds[campaignId] then
		serverIds[campaignId].times = serverIds[campaignId].times + num
	end
end

function MaterialChallengeModel:getBaseUseTimesById()
	return self._baseTimes
end

function MaterialChallengeModel:getOriginalCurFormation()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation()
end

function MaterialChallengeModel:_getCurFormation()
	return PetHireModel.instance:getFormationMoByFormId(PetHireModel.ID_TYPE_NORMAL)
end

function MaterialChallengeModel:getAllShowPetList()
	local pets = BagPetsController.instance:getFightBagPet() or {}

	pets = PetHireModel.instance:appendListByHirePets(pets)

	return pets
end

MaterialChallengeModel.instance = MaterialChallengeModel.New()

return MaterialChallengeModel
