-- chunkname: @modules/logic/versionactivity1_4/act128/config/Activity128Config.lua

module("modules.logic.versionactivity1_4.act128.config.Activity128Config", package.seeall)

local Activity128Config = class("Activity128Config", BaseConfig)

function Activity128Config:ctor()
	return
end

function Activity128Config:reqConfigNames()
	return {
		"activity128_stage",
		"activity128_episode",
		"activity128_rewards",
		"activity128_task",
		"activity128_countboss",
		"activity128_const",
		"activity128_assess",
		"activity128_evaluate",
		"activity128_enhance",
		"monster_group",
		"monster",
		"monster_template",
		"battle",
		"episode",
		"skin",
		"assassin_style_zongmao",
		"activity128_gallery",
		"activity128_level",
		"activity128_tag",
		"activity128_conceal_desc",
		"activity128_bosstype",
		"activity128_expand_bond",
		"activity128_boss_type"
	}
end

function Activity128Config:onConfigLoaded(configName, configTable)
	if configName == "activity128_stage" then
		-- block empty
	elseif configName == "activity128_episode" then
		-- block empty
	elseif configName == "activity128_rewards" then
		self:__getOrCreateStageRewardList()
	elseif configName == "activity128_task" then
		self:__getOrCreateTaskList()
		self:_initActLayer4rewards()
	elseif configName == "activity128_countboss" then
		-- block empty
	elseif configName == "activity128_const" then
		-- block empty
	elseif configName == "activity128_evaluate" then
		-- block empty
	elseif configName == "activity128_enhance" then
		-- block empty
	elseif configName == "activity128_expand_bond" then
		self:_initExpandBond()
	end
end

local function getSceneLevelCO(sceneId)
	return lua_scene_level.configDict[sceneId]
end

local function getSceneLevelResName(sceneId)
	return getSceneLevelCO(sceneId).resName
end

local function getBattleCO(battleId)
	return lua_battle.configDict[battleId]
end

local function getMonsterGroupIdsByBattleId(battleId)
	return getBattleCO(battleId).monsterGroupIds
end

local function getMonsterGroupCO(monsterGroupId)
	return lua_monster_group.configDict[monsterGroupId]
end

local function getMonsterCO(monsterId)
	return lua_monster.configDict[monsterId]
end

local function getDungeonEpisodeCO(episodeId)
	return lua_episode.configDict[episodeId]
end

local function getMonsterTemplateCO(templateId)
	return lua_monster_template.configDict[templateId]
end

local function getMonsterTemplateCOByMonsterCO(monsterCO)
	return getMonsterTemplateCO(monsterCO.template)
end

local function getStages(activityId)
	return lua_activity128_stage.configDict[activityId]
end

local function getStageCO(activityId, stage)
	return lua_activity128_stage.configDict[activityId][stage]
end

local function getEpisodeStages(activityId, stage)
	return lua_activity128_episode.configDict[activityId][stage]
end

local function getEpisodeCO(activityId, stage, layer)
	return lua_activity128_episode.configDict[activityId][stage][layer]
end

local function getAchievementTaskCO(activityId, stage, taskId)
	return lua_activity128_episode.configDict[activityId][stage][taskId]
end

local function getCountBossCO(battleId)
	return lua_activity128_countboss.configDict[battleId]
end

local function getEvaluateCO(id)
	return lua_activity128_evaluate.configDict[id]
end

function Activity128Config:__getOrCreateStageRewardList()
	local activityId = self:getActivityId()

	if self.__cumulativeRewards then
		return self.__cumulativeRewards
	end

	local res = {}

	self.__cumulativeRewards = res

	if lua_activity128_rewards.configDict[activityId] then
		for _, v in pairs(lua_activity128_rewards.configDict[activityId]) do
			local stage = v.stage

			res[stage] = res[stage] or {}

			table.insert(res[stage], v)
		end
	end

	for _, rewardList in pairs(res) do
		table.sort(rewardList, function(a, b)
			if a.rewardPointNum ~= b.rewardPointNum then
				return a.rewardPointNum < b.rewardPointNum
			end

			return a.id < b.id
		end)
	end

	return res
end

function Activity128Config:__getOrCreateTaskList()
	local activityId = self:getActivityId()

	if self.__taskList then
		return self.__taskList
	end

	local res = {}

	self.__taskList = res

	for _, v in ipairs(lua_activity128_task.configList) do
		local isOnline = v.isOnline

		if isOnline and activityId == v.activityId and v.totalTaskType == 0 then
			res[#res + 1] = v
		end
	end

	return res
end

function Activity128Config:getStageRewardList(stage)
	self:__getOrCreateStageRewardList()

	return self.__cumulativeRewards[stage]
end

function Activity128Config:getAllTaskList()
	return self:__getOrCreateTaskList()
end

function Activity128Config:getTaskCO(id)
	return lua_activity128_task.configDict[id]
end

function Activity128Config:getStages(activityId)
	activityId = activityId or self:getActivityId()

	return getStages(activityId)
end

function Activity128Config:getStageCO(stage, activityId)
	activityId = activityId or self:getActivityId()

	return getStageCO(activityId, stage)
end

function Activity128Config:getStageCOMaxPoints(stage)
	local stageRewardList = self:getStageRewardList(stage)
	local maxStageRewardCO = stageRewardList[#stageRewardList]

	return maxStageRewardCO.rewardPointNum
end

function Activity128Config:getEpisodeStages(stage, activityId)
	activityId = activityId or self:getActivityId()

	return getEpisodeStages(activityId, stage)
end

function Activity128Config:getEpisodeCO(stage, layer, activityId)
	activityId = activityId or self:getActivityId()

	return getEpisodeCO(activityId, stage, layer)
end

function Activity128Config:getDungeonEpisodeId(stage, layer, activityId)
	local co = self:getEpisodeCO(stage, layer, activityId)

	return co and co.episodeId
end

function Activity128Config:getDungeonEpisodeCO(stage, layer, activityId)
	local episodeId = self:getDungeonEpisodeId(stage, layer, activityId)

	return getDungeonEpisodeCO(episodeId, activityId)
end

function Activity128Config:getDungeonBattleId(stage, layer)
	local co = self:getDungeonEpisodeCO(stage, layer)

	return co.battleId
end

function Activity128Config:getDungeonBattleCO(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)

	return getBattleCO(battleId)
end

function Activity128Config:getDungeonBattleScenceIds(stage, layer)
	return self:getDungeonBattleCO(stage, layer).sceneIds
end

function Activity128Config:getAchievementTaskCO(stage, taskId)
	local activityId = self:getActivityId()

	return getAchievementTaskCO(activityId, stage, taskId)
end

function Activity128Config:isInfinite(stage, layer)
	local type = self:getEpisodeCO(stage, layer).type

	return type == 1
end

function Activity128Config:getStageCOOpenDay(stage)
	return self:getStageCO(stage).openDay
end

function Activity128Config:getEpisodeCOOpenDay(stage)
	local stageEpisode = self:getEpisodeStages(stage)

	if stageEpisode then
		local key, value = next(stageEpisode)

		if key then
			return value.openDay
		end
	end
end

function Activity128Config:getBattleCOByASL(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)

	return getBattleCO(battleId)
end

function Activity128Config:getMonsterGroupBossId(monsterGroupId)
	return getMonsterGroupCO(monsterGroupId).bossId
end

function Activity128Config:getBattleMaxPoints(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)

	return getCountBossCO(battleId).maxPoints
end

function Activity128Config:getFinalMonsterId(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)

	return tonumber(getCountBossCO(battleId).finalMonsterId)
end

function Activity128Config:getDungeonBattleSceneResName(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)
	local battleCO = getBattleCO(battleId)
	local sceneIds = string.splitToNumber(battleCO.sceneIds, "#")
	local sceneId = sceneIds[1]

	return getSceneLevelResName(sceneId)
end

function Activity128Config:getDungeonBattleMonsterSkinCOs(stage, layer)
	local battleId = self:getDungeonBattleId(stage, layer)
	local monsterGroupIds = getMonsterGroupIdsByBattleId(battleId)
	local monsterGroupIdList = string.splitToNumber(monsterGroupIds, "#")
	local monsterGroupId = monsterGroupIdList[1]
	local monsterIds = getMonsterGroupCO(monsterGroupId).monster
	local monsterIdList = string.splitToNumber(monsterIds, "#")
	local res = {}

	for _, monsterId in ipairs(monsterIdList) do
		local skinId = getMonsterCO(monsterId).skinId

		res[#res + 1] = FightConfig.instance:getSkinCO(skinId)
	end

	return res
end

function Activity128Config:getConst(id)
	local CO = lua_activity128_const.configDict[id]

	return CO.value1, CO.value2
end

function Activity128Config:tryGetStageAndLayerByEpisodeId(episodeId)
	for _, v in ipairs(lua_activity128_episode.configList) do
		if v.episodeId == episodeId then
			local episodeCo = lua_episode.configDict[episodeId]

			if episodeCo then
				local chapterCo = lua_chapter.configDict[episodeCo.chapterId]

				if chapterCo and self:isCurActivityIds(chapterCo.actId) then
					return v.stage, v.layer, chapterCo.actId
				end
			end
		end
	end
end

function Activity128Config:tryGetStageNextLayer(stage, layer)
	local episodeStages = self:getEpisodeStages(stage)

	for _, layerCO in ipairs(episodeStages) do
		local nextLayer = layerCO.layer

		if layer + 1 == nextLayer then
			return nextLayer
		end
	end
end

function Activity128Config:getEvaluateConfig(id)
	return (getEvaluateCO(id))
end

local ETimeFmt = {
	GEqual_1Day = 1,
	GEqual_1Hour = 2,
	GEqual_1Second = 4,
	GEqual_1Min = 3
}
local _defaultStyle = {
	[ETimeFmt.GEqual_1Day] = "v1a4_bossrushleveldetail_remain_days_hours",
	[ETimeFmt.GEqual_1Hour] = "v1a4_bossrushleveldetail_remain_hours",
	[ETimeFmt.GEqual_1Min] = "v1a4_bossrushleveldetail_remain_mins",
	[ETimeFmt.GEqual_1Second] = "v1a4_bossrushleveldetail_remain_1min"
}
local _unlockStyle = {
	[ETimeFmt.GEqual_1Day] = "v1a4_bossrushleveldetail_unlock_days_hours",
	[ETimeFmt.GEqual_1Hour] = "v1a4_bossrushleveldetail_unlock_hours",
	[ETimeFmt.GEqual_1Min] = "v1a4_bossrushleveldetail_unlock_mins",
	[ETimeFmt.GEqual_1Second] = "v1a4_bossrushleveldetail_unlock_1min"
}

Activity128Config.ETimeFmtStyle = {
	Default = _defaultStyle,
	UnLock = _unlockStyle
}

function Activity128Config:getRemainTimeStrWithFmt(seconds, eTimeFmtStyle)
	eTimeFmtStyle = eTimeFmtStyle or Activity128Config.ETimeFmtStyle.Default

	local day, hour, min, sec = TimeUtil.secondsToDDHHMMSS(seconds)

	if day >= 1 then
		local tag = {
			day,
			hour
		}

		return GameUtil.getSubPlaceholderLuaLang(luaLang(eTimeFmtStyle[ETimeFmt.GEqual_1Day]), tag)
	end

	if hour >= 1 then
		return formatLuaLang(eTimeFmtStyle[ETimeFmt.GEqual_1Hour], hour)
	end

	if min >= 1 then
		return formatLuaLang(eTimeFmtStyle[ETimeFmt.GEqual_1Min], min)
	end

	return luaLang(eTimeFmtStyle[ETimeFmt.GEqual_1Second])
end

function Activity128Config:getRemainTimeStr(endServerTs, eTimeFmtStyle)
	local offsetSecond = endServerTs - ServerTime.now()

	return self:getRemainTimeStrWithFmt(offsetSecond, eTimeFmtStyle)
end

function Activity128Config:checkActivityId(activityId, index)
	local actId = self:getActivityId(index)

	if actId ~= activityId then
		self._actIds = nil
		actId = self:getActivityId(index)
	end

	return actId == activityId
end

function Activity128Config:getActivityIds()
	if self._actIds then
		return self._actIds
	end

	self:refreshCurActivityIds()

	return self._actIds
end

function Activity128Config:getActivityId(index)
	index = index or 1

	local actIds = self:getActivityIds()

	return actIds[index]
end

function Activity128Config:refreshCurActivityIds()
	self._actIds = ActivityConfig.instance:getConstAsNumList(ActivityEnum.ConstId.BossRushAct)
end

function Activity128Config:isCurActivityIds(activityId)
	local actIds = self:getActivityIds()

	for _, actId in ipairs(actIds) do
		if actId == activityId then
			return true
		end
	end

	return false
end

function Activity128Config:getActRoleEnhance()
	local actId = self:getActivityId()

	return lua_activity128_enhance.configDict[actId]
end

function Activity128Config:_initActLayer4rewards()
	self.layer4Rewards = {}

	for _, co in ipairs(lua_activity128_task.configList) do
		if co.totalTaskType == 1 then
			local actCos = self.layer4Rewards[co.activityId]

			if not actCos then
				actCos = {}
				self.layer4Rewards[co.activityId] = actCos
			end

			local stageCos = actCos[co.stage]

			if not stageCos then
				stageCos = {}
				actCos[co.stage] = stageCos
			end

			table.insert(stageCos, co)
		end
	end
end

function Activity128Config:getActLayer4rewards(stage)
	local actId = self:getActivityId()

	if self.layer4Rewards[actId] then
		return self.layer4Rewards[actId][stage]
	end

	return {}
end

function Activity128Config:getAllGalleryBossCos()
	return lua_activity128_gallery.configList
end

function Activity128Config:getGalleryBossCo(bossType)
	return lua_activity128_gallery.configDict[bossType]
end

function Activity128Config:getAllLevelCos()
	return lua_activity128_level.configList
end

function Activity128Config:getLevelCo(level)
	return lua_activity128_level.configDict[level]
end

function Activity128Config:getTagCo(id)
	return lua_activity128_tag.configDict[id]
end

function Activity128Config:getConcealCo(episodeId)
	return lua_activity128_conceal_desc.configDict[episodeId]
end

function Activity128Config:_initExpandBond()
	self._expandBondCoDict = {}

	for _, co in ipairs(lua_activity128_expand_bond.configList) do
		self._expandBondCoDict[co.activityId] = self._expandBondCoDict[co.activityId] or {}

		table.insert(self._expandBondCoDict[co.activityId], co)
	end
end

function Activity128Config:getExpandBondCosByActId(activityId)
	return self._expandBondCoDict[activityId]
end

function Activity128Config:getBossTypeConfig(bossType)
	return lua_activity128_boss_type.configDict[bossType]
end

function Activity128Config:getBossTypeParams(bossType)
	self._bossTypeParams = self._bossTypeParams or {}

	if self._bossTypeParams[bossType] then
		return self._bossTypeParams[bossType]
	end

	local co = self:getBossTypeConfig(bossType)
	local params = {}

	if co then
		if not string.nilorempty(co.recommendStrategy) then
			params.recommendStrategy = string.splitToNumber(co.recommendStrategy, "#")
		end

		if not string.nilorempty(co.career_weak) then
			params.careerWeak = string.splitToNumber(co.career_weak, "#")
		end
	end

	self._bossTypeParams[bossType] = params

	return params
end

function Activity128Config:getBossRecommendStrategy(bossType)
	local param = self:getBossTypeParams(bossType)

	if param and param.recommendStrategy then
		return param.recommendStrategy
	end

	local handbookCo = self:getGalleryBossCo(bossType)

	if handbookCo and not string.nilorempty(handbookCo.recommendStrategy) then
		param = param or {}
		param.recommendStrategy = string.splitToNumber(handbookCo.recommendStrategy, "#")

		return param.recommendStrategy
	end
end

return Activity128Config
