-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/model/MoonKingModel.lua

module("logic.extensions.moonking.model.MoonKingModel", package.seeall)

local MoonKingModel = class("MoonKingModel", BaseModel)

function MoonKingModel:ctor()
	self.challengeId = 29
	self.pbChallendId = 45
	self.feinChallengeId = 98
	self.pandoraChanllengeId = 170
	self._moonkingInfo = nil
	self._cacheBuffList = nil
end

function MoonKingModel:onInit()
	MoonKingModel.super.onInit(self)
	self:onReset()
end

function MoonKingModel:onReset()
	self._moonkingInfo = nil
	self._cacheBuffList = nil
end

function MoonKingModel:getMoonkingBaseInfo(challId)
	self._moonkingInfo = self._moonkingInfo or {}

	if self._moonkingInfo[challId] == nil then
		self:_setMoonkingBaseInfo(challId)
	end

	return self._moonkingInfo[challId]
end

function MoonKingModel:_setMoonkingBaseInfo(challId)
	self._moonkingInfo[challId] = {}
	self._moonkingInfo[challId].challengeId = 0
	self._moonkingInfo[challId].curGroupId = 0
	self._moonkingInfo[challId].stageInfos = {}
	self._moonkingInfo[challId].totalScore = 0
	self._moonkingInfo[challId].gainedScorePrizeIds = {}
	self._moonkingInfo[challId].curStageInfo = {}
end

function MoonKingModel:getMoonkingStageList(challId, planId)
	if checknumber(planId) <= 0 then
		return {}, 1
	end

	local planCfgs = MoonKingConfig.instance:getBattleStageCfgs(planId)

	if planCfgs == nil or #planCfgs == 0 then
		return {}, 1
	end

	if self._moonkingInfo == nil or self._moonkingInfo[challId] == nil then
		return planCfgs, 1
	end

	local index = 0
	local targetList = {}

	for i = 1, #planCfgs do
		local isPass, score = self:_getStageIsPass(planCfgs[i].stageId, planCfgs[i].score, self._moonkingInfo[challId].stageInfos)

		table.insert(targetList, {
			difficultyPlanId = planCfgs[i].difficultyPlanId,
			creepsMasterId = planCfgs[i].creepsMasterId,
			score = score,
			stageName = planCfgs[i].stageName,
			stageDes = planCfgs[i].stageDes,
			isOpen = isPass,
			stageId = planCfgs[i].stageId,
			stagePlanId = planCfgs[i].stagePlanId
		})

		if isPass and index < i then
			index = i
		end
	end

	if index < #targetList then
		index = index + 1

		if targetList[index] then
			targetList[index].isOpen = true
		end
	end

	return targetList, index
end

function MoonKingModel:_getStageIsPass(stageId, score, scoreInfos)
	for _, info in pairs(scoreInfos or {}) do
		if info and info.stageId == stageId then
			return true, checknumber(info.roundHistoryBestScore)
		end
	end

	return false, score
end

function MoonKingModel:getMoonkingStageMasters(masterId)
	local masterCfgs = MoonKingConfig.instance:getMasterCreepsCfg(masterId)

	if masterCfgs == nil then
		return
	end

	local targetList = {}

	for _, cfg in pairs(masterCfgs) do
		if cfg and checknumber(cfg.raceId) > 0 and checknumber(cfg.posId) > 0 then
			table.insert(targetList, {
				raceId = cfg.raceId,
				posId = cfg.posId
			})
		end
	end

	return targetList
end

function MoonKingModel:getMoonkingPrizeList(challId, planId)
	if checknumber(planId) <= 0 then
		return {}, 1
	end

	local planCfgs = MoonKingConfig.instance:getBattlePrizeCfgs(planId)

	if planCfgs == nil or #planCfgs == 0 then
		return {}, 1
	end

	if self._moonkingInfo == nil or self._moonkingInfo[challId] == nil or self._moonkingInfo[challId].gainedScorePrizeIds == nil then
		return planCfgs, 1
	end

	local index = 0
	local targetList = {}

	for i = 1, #planCfgs do
		local isFinish = false

		if table.indexof(self._moonkingInfo[challId].gainedScorePrizeIds, planCfgs[i].id) then
			isFinish = true

			if index < i then
				index = i
			end
		end

		table.insert(targetList, {
			id = planCfgs[i].id,
			score = planCfgs[i].score,
			isFinish = isFinish,
			isFull = self._moonkingInfo[challId].totalScore >= planCfgs[i].score,
			prizes = string.split(planCfgs[i].prize, "#")
		})
	end

	if index < #targetList then
		index = index + 1
	end

	return targetList, index
end

function MoonKingModel:getMoonkingStageBuffs(planId)
	planId = checknumber(planId)

	local diffCfgs = MoonKingConfig.instance:getBattleDifficCfgs(planId)

	if diffCfgs == nil then
		return
	end

	local nowTime = ServerTime.now()
	local targetList = {}
	local groupCfg

	for _, cfg in pairs(diffCfgs) do
		groupCfg = nil

		if cfg and checknumber(cfg.optionGroup) > 0 then
			groupCfg = MoonKingConfig.instance:getBattleGroupCfgs(cfg.optionGroup)
		end

		if groupCfg and #groupCfg >= 3 then
			local index = self:_getBuffGroupIsChoise(cfg.optionGroup)

			table.insert(targetList, {
				groupId = cfg.optionGroup,
				groupList = groupCfg,
				curIndex = index,
				curTime = nowTime
			})
		end
	end

	if #targetList > 1 then
		table.sort(targetList, function(a, b)
			return a.groupId < b.groupId
		end)
	end

	return targetList
end

function MoonKingModel:_getBuffGroupIsChoise(groupId)
	if self._moonkingInfo == nil or self._moonkingInfo.curStageInfo == nil or self._moonkingInfo.curStageInfo.lastDifficultyOptionInfos == nil then
		return 0
	end

	for _, info in pairs(self._moonkingInfo.curStageInfo.lastDifficultyOptionInfos) do
		if info and info.optionGroup == groupId then
			return info.optionId
		end
	end

	return 0
end

function MoonKingModel:setMoonkingChooseBuff(list)
	self._cacheBuffList = list
end

function MoonKingModel:getMoonkingChooseBuff()
	return self._cacheBuffList or {}
end

function MoonKingModel:getMoonkingRedpoint(isView)
	local str = string.format("MoonkingViewRed_%s_%s", self.challengeId, LoginModel.instance.userId)
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) ~= 1 then
		return true
	end

	if not isView then
		return RedPointModel.instance:isActiveByServer(182)
	end

	if self._moonkingInfo == nil or self._moonkingInfo[self.challengeId] == nil or checknumber(self._moonkingInfo[self.challengeId].curGroupId) <= 0 then
		return false
	end

	local baseCfg = MoonKingConfig.instance:getBattleBaseCfg(self.challengeId)

	if baseCfg == nil then
		return false
	end

	local prizeList = self:getMoonkingPrizeList(self.challengeId, baseCfg.scorePrizePlanId)

	if prizeList == nil or #prizeList == 0 then
		return false
	end

	for i = 1, #prizeList do
		if prizeList[i] and not prizeList[i].isFinish and prizeList[i].isFull then
			return true
		end
	end

	return false
end

function MoonKingModel:getPaladinRedpoint(isView)
	local str = string.format("PaladinViewRed_%s_%s", self.pbChallendId, LoginModel.instance.userId)
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) ~= 1 then
		return true
	end

	if not isView then
		return RedPointModel.instance:isActiveByServer(302)
	end

	if self._moonkingInfo == nil or self._moonkingInfo[self.pbChallendId] == nil or checknumber(self._moonkingInfo[self.pbChallendId].curGroupId) <= 0 then
		return false
	end

	local baseCfg = MoonKingConfig.instance:getBattleBaseCfg(self.pbChallendId)

	if baseCfg == nil then
		return false
	end

	local prizeList = self:getMoonkingPrizeList(self.pbChallendId, baseCfg.scorePrizePlanId)

	if prizeList == nil or #prizeList == 0 then
		return false
	end

	for i = 1, #prizeList do
		if prizeList[i] and not prizeList[i].isFinish and prizeList[i].isFull then
			return true
		end
	end

	return false
end

function MoonKingModel:getFeinRedpoint(isView)
	local str = string.format("FeinViewRed_%s_%s", self.feinChallengeId, LoginModel.instance.userId)
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) ~= 1 then
		return true
	end

	if not isView then
		return RedPointModel.instance:isActiveByServer(302)
	end

	if self._moonkingInfo == nil or self._moonkingInfo[self.pbChallendId] == nil or checknumber(self._moonkingInfo[self.pbChallendId].curGroupId) <= 0 then
		return false
	end

	local baseCfg = MoonKingConfig.instance:getBattleBaseCfg(self.pbChallendId)

	if baseCfg == nil then
		return false
	end

	local prizeList = self:getMoonkingPrizeList(self.pbChallendId, baseCfg.scorePrizePlanId)

	if prizeList == nil or #prizeList == 0 then
		return false
	end

	for i = 1, #prizeList do
		if prizeList[i] and not prizeList[i].isFinish and prizeList[i].isFull then
			return true
		end
	end

	return false
end

function MoonKingModel:getPandoraRedpoint(isView)
	local str = string.format("PandoraViewRed_%s_%s", self.pandoraChanllengeId, LoginModel.instance.userId)
	local value = GameUtil.getUserDayData(str)

	if checknumber(value) ~= 1 then
		return true
	end

	if not isView then
		return RedPointModel.instance:isActiveByServer(302)
	end

	if self._moonkingInfo == nil or self._moonkingInfo[self.pbChallendId] == nil or checknumber(self._moonkingInfo[self.pbChallendId].curGroupId) <= 0 then
		return false
	end

	local baseCfg = MoonKingConfig.instance:getBattleBaseCfg(self.pbChallendId)

	if baseCfg == nil then
		return false
	end

	local prizeList = self:getMoonkingPrizeList(self.pbChallendId, baseCfg.scorePrizePlanId)

	if prizeList == nil or #prizeList == 0 then
		return false
	end

	for i = 1, #prizeList do
		if prizeList[i] and not prizeList[i].isFinish and prizeList[i].isFull then
			return true
		end
	end

	return false
end

function MoonKingModel:scSendMoonShadowKingChallengeGetInfo(msg)
	if msg == nil or msg.challengeId == nil then
		return
	end

	self:getMoonkingBaseInfo(msg.challengeId)

	self._moonkingInfo[msg.challengeId].challengeId = msg.challengeId
	self._moonkingInfo[msg.challengeId].curGroupId = msg.curGroupId
	self._moonkingInfo[msg.challengeId].stageInfos = msg.stageInfos or {}
	self._moonkingInfo[msg.challengeId].totalScore = msg.totalScore
	self._moonkingInfo[msg.challengeId].gainedScorePrizeIds = msg.gainedScorePrizeIds or {}
end

function MoonKingModel:scSendMoonShadowKingChallengeGetStageInfo(msg)
	if msg == nil or msg.challengeId == nil then
		return
	end

	self._moonkingInfo = self._moonkingInfo or {}

	if self._moonkingInfo[msg.challengeId] == nil then
		self:_setMoonkingBaseInfo(msg.challengeId)
	end

	self._moonkingInfo[msg.challengeId].curStageInfo = msg
end

function MoonKingModel:scSendMoonShadowKingChallengeGainScorePrize(msg)
	if msg == nil or msg.challengeId == nil then
		return
	end

	self._moonkingInfo = self._moonkingInfo or {}

	if self._moonkingInfo[msg.challengeId] == nil then
		self:_setMoonkingBaseInfo(msg.challengeId)
	end

	if self._moonkingInfo[msg.challengeId].gainedScorePrizeIds == nil then
		self._moonkingInfo[msg.challengeId].gainedScorePrizeIds = {}
	end

	table.insert(self._moonkingInfo[msg.challengeId].gainedScorePrizeIds, msg.scorePrizeId)
end

function MoonKingModel:getPaladinPrizeMatCount(matType, matId)
	local cfg = MoonKingConfig.instance:getBattleBaseCfg(MoonKingModel.instance.pbChallendId)

	if cfg == nil or cfg.scorePrizePlanId <= 0 then
		return 0, 0
	end

	local pCfgs = MoonKingConfig.instance:getBattlePrizeCfgs(cfg.scorePrizePlanId)

	if pCfgs == nil or #pCfgs == 0 then
		return 0, 0
	end

	local have, all = 0, 0
	local gspIds = {}

	if self._moonkingInfo and self._moonkingInfo[MoonKingModel.instance.pbChallendId] then
		gspIds = self._moonkingInfo[MoonKingModel.instance.pbChallendId].gainedScorePrizeIds
	end

	for i = 1, #pCfgs do
		if pCfgs[i] and not string.nilorempty(pCfgs[i].prize) then
			local list = string.split(pCfgs[i].prize, ":")

			if list and checknumber(list[1]) == matType and checknumber(list[2]) == matId then
				all = all + checknumber(list[#list])

				if gspIds and table.indexof(gspIds, pCfgs[i].id) then
					have = have + checknumber(list[#list])
				end
			end
		end
	end

	return have, all
end

MoonKingModel.instance = MoonKingModel.New()

return MoonKingModel
