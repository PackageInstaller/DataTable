-- chunkname: @modules/logic/dungeon/model/RoleStoryMO.lua

module("modules.logic.dungeon.model.RoleStoryMO", package.seeall)

local RoleStoryMO = pureTable("RoleStoryMO")

function RoleStoryMO:init(storyId)
	self.id = storyId
	self.progress = 0
	self.getReward = false
	self.cfg = RoleStoryConfig.instance:getStoryById(storyId)
	self.order = self.cfg.order
	self.maxProgress, self.episodeCount = self:caleMaxProgress()
	self.hasUnlock = false
	self.startTime = 0
	self.endTime = 0
	self.startTimeResident = 0
	self.endTimeResident = 0
	self.rewards = GameUtil.splitString2(self.cfg.bonus, true)
	self.getScoreBonus = {}
	self.score = 0
	self.addscore = 0
	self.wave = 0
	self.maxWave = 1
	self.getChallengeReward = false

	self:refreshOrder()

	self.dispatchDict = {}
	self._dispatchHeroDict = {}
end

function RoleStoryMO:getCost()
	if self:isActTime() then
		local unlockcost = string.splitToNumber(self.cfg.unlock, "#")

		return unlockcost[1], unlockcost[2], unlockcost[3]
	end

	local unlockcost = string.splitToNumber(self.cfg.permanentUnlock, "#")

	return unlockcost[1], unlockcost[2], unlockcost[3]
end

function RoleStoryMO:updateInfo(info)
	self.progress = info.progress
	self.getReward = info.getReward
	self.hasUnlock = info.unlock
	self.getScoreBonus = {}

	self:addScoreBonus(info.getScoreBonus)

	self.score = info.score
	self.wave = info.challengeWave
	self.maxWave = info.challengeMaxWave
	self.getChallengeReward = info.getChallengeReward

	self:refreshOrder()

	self.dispatchDict = {}

	for i = 1, #info.dispatchInfos do
		self:updateDispatch(info.dispatchInfos[i])
	end

	self:updateDispatchHeroDict()
end

function RoleStoryMO:updateDispatch(dispatchInfo)
	if not dispatchInfo then
		return
	end

	local dispatchId = dispatchInfo.id
	local dispatchMo = self:getDispatchMo(dispatchId)

	dispatchMo:updateInfo(dispatchInfo)
end

function RoleStoryMO:updateDispatchTime(dispatchInfo)
	if not dispatchInfo then
		return
	end

	local dispatchId = dispatchInfo.dispatchId
	local dispatchMo = self:getDispatchMo(dispatchId)

	dispatchMo:updateTime(dispatchInfo)

	for i = 1, #dispatchInfo.dispatchInfos do
		self:updateDispatch(dispatchInfo.dispatchInfos[i])
	end

	self:updateDispatchHeroDict()
end

function RoleStoryMO:resetDispatch(info)
	local dispatchMo = self:getDispatchMo(info.dispatchId)

	dispatchMo:resetDispatch()
	self:updateDispatchHeroDict()
end

function RoleStoryMO:completeDispatch(info)
	local dispatchMo = self:getDispatchMo(info.dispatchId)

	dispatchMo:completeDispatch()
	self:updateDispatchHeroDict()
end

function RoleStoryMO:updateTime(info)
	self.startTime = info.startTime
	self.endTime = info.endTime
	self.startTimeResident = info.startTimeResident
	self.endTimeResident = info.endTimeResident
end

function RoleStoryMO:updateScore(info)
	self.addscore = info.score - self.score
	self.score = info.score
	self.wave = info.wave
	self.maxWave = info.maxWave
end

function RoleStoryMO:refreshOrder()
	self.getRewardOrder = self.getReward and 0 or 1
	self.getUnlockOrder = self.hasUnlock and 0 or 1
	self.hasRewardUnget = self:canGetReward() and 1 or 0
end

function RoleStoryMO:caleMaxProgress()
	local chapterId = self.cfg.chapterId
	local list = DungeonConfig.instance:getChapterEpisodeCOList(chapterId)
	local count = 0
	local episodeCount = 0

	if list then
		for k, v in ipairs(list) do
			count = count + 1
			episodeCount = episodeCount + 1
		end
	end

	return count, episodeCount
end

function RoleStoryMO:canGetReward()
	if not self.hasUnlock then
		return false
	end

	if self.getReward then
		return false
	end

	if self.progress and self.maxProgress then
		return self.progress >= self.maxProgress
	end

	return false
end

function RoleStoryMO:getActTime()
	return self.startTime, self.endTime
end

function RoleStoryMO:getResidentTime()
	return self.startTimeResident, self.endTimeResident
end

function RoleStoryMO:isActTime()
	local nowTime = ServerTime.now()

	return nowTime >= self.startTime and nowTime <= self.endTime
end

function RoleStoryMO:isResidentTime()
	local nowTime = ServerTime.now()

	return nowTime >= self.startTimeResident and nowTime <= self.endTimeResident
end

function RoleStoryMO:addScoreBonus(list)
	if list then
		for i = 1, #list do
			self.getScoreBonus[list[i]] = true
		end
	end
end

function RoleStoryMO:isBonusHasGet(id)
	return self.getScoreBonus[id]
end

function RoleStoryMO:getScore()
	return self.score
end

function RoleStoryMO:getAddScore()
	return self.addscore
end

function RoleStoryMO:hasScoreReward()
	local red = false
	local rewardList = RoleStoryConfig.instance:getRewardList(self.id)

	if rewardList then
		for i, v in ipairs(rewardList) do
			if self.score >= v.score and not self:isBonusHasGet(v.id) then
				red = true

				break
			end
		end
	end

	return red
end

function RoleStoryMO:getDispatchMo(dispatchId)
	local dispatchMo = self.dispatchDict[dispatchId]

	if not dispatchMo then
		dispatchMo = RoleStoryDispatchMO.New()

		dispatchMo:init(dispatchId, self.id)

		self.dispatchDict[dispatchId] = dispatchMo
	end

	return dispatchMo
end

function RoleStoryMO:getDispatchState(dispatchId)
	local mo = self:getDispatchMo(dispatchId)

	if mo then
		return mo:getDispatchState()
	end
end

function RoleStoryMO:getNormalDispatchList()
	local list = {}

	for k, v in pairs(self.dispatchDict) do
		if v.config.type == RoleStoryEnum.DispatchType.Normal then
			table.insert(list, v)
		end
	end

	return list
end

function RoleStoryMO:isScoreFull()
	local scoreList = RoleStoryConfig.instance:getRewardList(self.id)
	local maxScoreConfig = scoreList and scoreList[#scoreList]

	if not maxScoreConfig then
		return true
	end

	return self.score >= maxScoreConfig.score
end

function RoleStoryMO:updateDispatchHeroDict()
	self._dispatchHeroDict = {}

	for _, dispatchMo in pairs(self.dispatchDict) do
		if dispatchMo:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
			for _, v in pairs(dispatchMo.heroIds) do
				self._dispatchHeroDict[v] = true
			end
		end
	end
end

function RoleStoryMO:isHeroDispatching(heroId)
	return self._dispatchHeroDict[heroId]
end

function RoleStoryMO:hasNewDispatchFinish()
	local hasNew = false

	for k, v in pairs(self.dispatchDict) do
		if v:isNewFinish() then
			hasNew = true
		end
	end

	return hasNew
end

function RoleStoryMO:canPlayNormalDispatchUnlockAnim()
	local key = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, self.id)
	local flag = PlayerPrefsHelper.getNumber(key, 0)

	return flag == 0
end

function RoleStoryMO:setPlayNormalDispatchUnlockAnimFlag()
	local key = string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, self.id)

	PlayerPrefsHelper.setNumber(key, 1)
end

function RoleStoryMO:getType()
	if self.id < NecrologistStoryEnum.RoleStoryId.V3A1 then
		return RoleStoryEnum.RoleStoryType.Old
	end

	return RoleStoryEnum.RoleStoryType.New
end

return RoleStoryMO
