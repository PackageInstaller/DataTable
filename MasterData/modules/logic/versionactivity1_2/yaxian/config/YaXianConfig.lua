-- chunkname: @modules/logic/versionactivity1_2/yaxian/config/YaXianConfig.lua

module("modules.logic.versionactivity1_2.yaxian.config.YaXianConfig", package.seeall)

local YaXianConfig = class("YaXianConfig", BaseConfig)

function YaXianConfig:ctor()
	self.chapterConfig = nil
	self.chapterId2EpisodeList = nil
	self.mapConfig = nil
	self.interactObjectConfig = nil
	self.episodeConfig = nil
	self.skillConfig = nil
	self.toothConfig = nil
	self.toothUnlockEpisodeIdDict = {}
	self.toothUnlockSkillIdDict = {}
	self.toothUnlockHeroTemplateDict = {}
end

function YaXianConfig:reqConfigNames()
	return {
		"activity115_chapter",
		"activity115_episode",
		"activity115_map",
		"activity115_interact_object",
		"activity115_tooth",
		"activity115_bonus",
		"activity115_skill"
	}
end

function YaXianConfig:onConfigLoaded(configName, configTable)
	if configName == "activity115_chapter" then
		self.chapterConfig = configTable
	elseif configName == "activity115_episode" then
		self.episodeConfig = configTable

		self:initEpisode()
	elseif configName == "activity115_map" then
		self.mapConfig = configTable
	elseif configName == "activity115_interact_object" then
		self.interactObjectConfig = configTable
	elseif configName == "activity115_skill" then
		self.skillConfig = configTable
	elseif configName == "activity115_tooth" then
		self.toothConfig = configTable
	end
end

function YaXianConfig:initEpisode()
	self.chapterId2EpisodeList = {}

	for _, episodeCo in ipairs(self.episodeConfig.configList) do
		self.chapterId2EpisodeList[episodeCo.chapterId] = self.chapterId2EpisodeList[episodeCo.chapterId] or {}

		table.insert(self.chapterId2EpisodeList[episodeCo.chapterId], episodeCo)

		if episodeCo.tooth ~= 0 then
			self.toothUnlockEpisodeIdDict[episodeCo.tooth] = episodeCo.id

			if episodeCo.unlockSkill ~= 0 then
				self.toothUnlockSkillIdDict[episodeCo.tooth] = episodeCo.unlockSkill
			end

			if episodeCo.trialTemplate ~= 0 then
				self.toothUnlockHeroTemplateDict[episodeCo.tooth] = episodeCo.trialTemplate
			end
		end
	end

	for _, episodeList in ipairs(self.chapterId2EpisodeList) do
		table.sort(episodeList, function(a, b)
			return a.id < b.id
		end)
	end
end

function YaXianConfig:getChapterConfigList()
	return self.chapterConfig.configList
end

function YaXianConfig:getChapterConfig(chapterId)
	return self.chapterConfig.configDict[YaXianEnum.ActivityId][chapterId]
end

function YaXianConfig:getMapConfig(actId, mapId)
	if self.mapConfig.configDict[actId] then
		return self.mapConfig.configDict[actId][mapId]
	end

	return nil
end

function YaXianConfig:getEpisodeConfig(actId, episodeId)
	if self.episodeConfig.configDict[actId] then
		return self.episodeConfig.configDict[actId][episodeId]
	end

	return nil
end

function YaXianConfig:getPreEpisodeConfig(actId, episodeId)
	return self:getEpisodeConfig(actId, episodeId - 1)
end

function YaXianConfig:getEpisodeCanFinishInteractCount(episodeCo)
	if not episodeCo then
		return 0
	end

	self.episodeCanFinishInteractCountDict = self.episodeCanFinishInteractCountDict or {}

	if self.episodeCanFinishInteractCountDict[episodeCo.mapId] then
		return self.episodeCanFinishInteractCountDict[episodeCo.mapId]
	end

	local mapCo = self:getMapConfig(episodeCo.activityId, episodeCo.mapId)

	if not mapCo then
		self.episodeCanFinishInteractCountDict[episodeCo.mapId] = 0

		return 0
	end

	local objList = cjson.decode(mapCo.objects)
	local canFinishCount = 0

	for _, co in ipairs(objList) do
		if self:checkInteractCanFinish(self:getInteractObjectCo(co.actId, co.id)) then
			canFinishCount = canFinishCount + 1
		end
	end

	self.episodeCanFinishInteractCountDict[episodeCo.mapId] = canFinishCount

	return canFinishCount
end

function YaXianConfig:checkInteractCanFinish(interactCo)
	return interactCo and interactCo.interactType == YaXianGameEnum.InteractType.Enemy
end

function YaXianConfig:getConditionList(episodeCo)
	if not episodeCo then
		return {}
	end

	local conditionList = GameUtil.splitString2(episodeCo.extStarCondition, true, "|", "#")

	conditionList = conditionList or {}

	table.insert(conditionList, {
		YaXianGameEnum.ConditionType.PassEpisode
	})

	return conditionList
end

function YaXianConfig:getInteractObjectCo(actId, interactId)
	if self.interactObjectConfig.configDict[actId] then
		return self.interactObjectConfig.configDict[actId][interactId]
	end

	return nil
end

function YaXianConfig:getSkillConfig(actId, skillId)
	if self.skillConfig.configDict[actId] then
		return self.skillConfig.configDict[actId][skillId]
	end

	return nil
end

function YaXianConfig:getThroughSkillDistance()
	if not self.throughSkillDistance then
		local config = self:getSkillConfig(YaXianEnum.ActivityId, YaXianGameEnum.SkillId.ThroughWall)

		self.throughSkillDistance = config and tonumber(config.param)
	end

	return self.throughSkillDistance
end

function YaXianConfig:getToothConfig(id)
	return self.toothConfig.configDict[YaXianEnum.ActivityId][id]
end

function YaXianConfig:getToothUnlockEpisode(toothId)
	return self.toothUnlockEpisodeIdDict and self.toothUnlockEpisodeIdDict[toothId]
end

function YaXianConfig:getToothUnlockSkill(toothId)
	return self.toothUnlockSkillIdDict and self.toothUnlockSkillIdDict[toothId]
end

function YaXianConfig:getToothUnlockHeroTemplate(toothId)
	return self.toothUnlockHeroTemplateDict and self.toothUnlockHeroTemplateDict[toothId]
end

function YaXianConfig:getMaxBonusScore()
	if not self.maxBonusScore then
		self.maxBonusScore = 0

		for _, bonusCo in ipairs(lua_activity115_bonus.configList) do
			if bonusCo.needScore > self.maxBonusScore then
				self.maxBonusScore = bonusCo.needScore
			end
		end
	end

	return self.maxBonusScore
end

YaXianConfig.instance = YaXianConfig.New()

return YaXianConfig
