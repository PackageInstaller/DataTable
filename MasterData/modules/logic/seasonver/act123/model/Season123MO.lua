-- chunkname: @modules/logic/seasonver/act123/model/Season123MO.lua

module("modules.logic.seasonver.act123.model.Season123MO", package.seeall)

local Season123MO = pureTable("Season123MO")

function Season123MO:updateInfo(info)
	self.activityId = info.activityId
	self.stage = info.stage or 0
	self.retailId = info.act123Retail and info.act123Retail.id or nil

	self:setUnlockAct123EquipIds(info.unlockAct123EquipIds)
	self:initItems(info.act123Equips)
	self:initStages(info.act123Stage)

	self.heroGroupSnapshot = Season123HeroGroupUtils.buildSnapshotHeroGroups(info.heroGroupSnapshot)
	self.heroGroupSnapshotSubId = info.heroGroupSnapshotSubId
	self.retailHeroGroups = Season123HeroGroupUtils.buildSnapshotHeroGroups(info.retailHeroGroupSnapshot)
	self.unlockIndexes = {}
	self.unlockIndexSet = {}

	self:updateUnlockIndexes(info.unlockEquipIndexs)
	self:updateTrial(info.trial)
	Season123CardPackageModel.instance:initData(self.activityId)
end

function Season123MO:updateInfoBattle(info)
	self.stage = info.stage

	self:updateUnlockIndexes(info.unlockEquipIndexs)
	self:initStages(info.act123Stage)
	self:updateTrial(info.trial)
end

function Season123MO:initStages(stages)
	self.stageList = {}
	self.stageMap = {}

	for i = 1, #stages do
		local stageData = stages[i]
		local stageMO = Season123StageMO.New()

		stageMO:init(stageData, self.activityId)
		table.insert(self.stageList, stageMO)

		self.stageMap[stageData.stage] = stageMO
	end
end

function Season123MO:initItems(itemInfos)
	self.itemMap = {}

	for i = 1, #itemInfos do
		local infoData = itemInfos[i]
		local itemMO = Season123ItemMO.New()

		itemMO:setData(infoData)

		self.itemMap[infoData.uid] = itemMO
	end
end

function Season123MO:updateStages(stages)
	local needAdd = false

	for i = 1, #stages do
		local stageData = stages[i]
		local stageMO = self.stageMap[stageData.stage]

		if not stageMO then
			stageMO = Season123StageMO.New()

			stageMO:init(stageData, self.activityId)
			table.insert(self.stageList, stageMO)

			needAdd = true
			self.stageMap[stageData.stage] = stageMO
		else
			stageMO:init(stageData)
		end
	end

	if needAdd then
		table.sort(self.stageList, function(a, b)
			return a.stage < b.stage
		end)
	end
end

function Season123MO:updateEpisodes(stage, episodes)
	local stageMO = self.stageMap[stage]

	if not stageMO then
		return
	end

	stageMO:updateEpisodes(episodes)
end

function Season123MO:updateUnlockIndexes(unlockIndexes)
	if not unlockIndexes or #unlockIndexes < 1 then
		return
	end

	self.unlockIndexes = {}
	self.unlockIndexSet = {}

	for i = 1, #unlockIndexes do
		self.unlockIndexes = unlockIndexes[i]
		self.unlockIndexSet[unlockIndexes[i]] = true
	end
end

function Season123MO:updateTrial(trial)
	self.trial = trial and trial.id ~= 0 and trial.id or 0
end

function Season123MO:getStageMO(stage)
	return self.stageMap[stage]
end

function Season123MO:getCurrentStage()
	return self:getStageMO(self.stage)
end

function Season123MO:getCurHeroGroup()
	return self.heroGroupSnapshot[self.heroGroupSnapshotSubId]
end

function Season123MO:getAllItemMap()
	return self.itemMap
end

function Season123MO:getItemMO(itemUid)
	if self.itemMap then
		return self.itemMap[itemUid]
	end
end

function Season123MO:getItemIdByUid(itemUid)
	if self.itemMap and self.itemMap[itemUid] then
		return self.itemMap[itemUid].itemId
	end
end

function Season123MO:isNotInStage()
	return self.stage == 0
end

function Season123MO:getTotalRound(stage)
	local round = 0
	local stageMO = self.stageMap[stage]

	if not stageMO then
		return 0
	end

	for _, episodeMO in pairs(stageMO.episodeMap) do
		round = round + episodeMO.round
	end

	return round
end

function Season123MO:isStageSlotUnlock(stage, unlockIndex)
	self._stage2UnlockSets = self._stage2UnlockSets or {}

	local unlockSet = self._stage2UnlockSets[stage]

	if not unlockSet then
		unlockSet = {}

		local episodeCOList = Season123Config.instance:getSeasonEpisodeStageCos(self.activityId, stage)

		if episodeCOList then
			for i, episodeCO in ipairs(episodeCOList) do
				if i ~= #episodeCOList then
					local unlocks = string.splitToNumber(episodeCO.unlockEquipIndex, "#")

					for _, unlockIndex in pairs(unlocks) do
						unlockSet[unlockIndex] = true
					end
				end
			end
		end

		self._stage2UnlockSets[stage] = unlockSet
	end

	return unlockSet[unlockIndex]
end

function Season123MO:setUnlockAct123EquipIds(unlockEquipIds)
	self.unlockAct123EquipIds = {}

	for i, v in ipairs(unlockEquipIds) do
		self.unlockAct123EquipIds[v] = v
	end
end

function Season123MO:initStageRewardConfig()
	self.stageRewardMap = self.stageRewardMap or {}

	local seasonMOTasks = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Season123) or {}

	for taskId, taskMO in pairs(seasonMOTasks) do
		if taskMO.config and taskMO.config.seasonId == self.activityId and taskMO.config.isRewardView == Activity123Enum.TaskRewardViewType then
			local paramList = Season123Config.instance:getTaskListenerParamCache(taskMO.config)
			local stage = tonumber(paramList[1])

			if not self.stageRewardMap[stage] then
				self.stageRewardMap[stage][taskId] = taskMO
				self.stageRewardMap[stage] = self.stageRewardMap[stage]
			end
		end
	end
end

function Season123MO:getStageRewardCount(stageId)
	self:initStageRewardConfig()

	local rewardMOMap = self.stageRewardMap[stageId]
	local totalRewardCount = Season123Config.instance:getRewardTaskCount(self.activityId, stageId)

	if not rewardMOMap then
		return 0, totalRewardCount
	end

	local hasGetCount = 0

	for taskId, taskMO in pairs(rewardMOMap) do
		if taskMO.finishCount >= taskMO.config.maxFinishCount or taskMO.hasFinished then
			hasGetCount = hasGetCount + 1
		end
	end

	return hasGetCount, totalRewardCount
end

function Season123MO:updateBonus(stage, bonusIds)
	local stageMO = self:getStageMO(stage)

	if not stageMO then
		return
	end

	return stageMO:updateBonus(bonusIds)
end

function Season123MO:setSnapshotByHeroGroup(subId, param)
	self.heroGroupSnapshot[subId] = Season123HeroGroupUtils.buildSingleSnapshotHeroGroup(param.groupInfo)
end

return Season123MO
