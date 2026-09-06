-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/config/GodLongYanConfig.lua

module("logic.extensions.godlongyan.config.GodLongYanConfig", package.seeall)

local GodLongYanConfig = class("GodLongYanConfig", BaseConfig)

function GodLongYanConfig:onInit()
	GodLongYanConfig.super.onInit(self)
end

function GodLongYanConfig:getNames()
	return {
		"timed_challenge_god_long_yan",
		"timed_challenge_god_long_yan_game",
		"timed_challenge_god_long_yan_game_stage",
		"timed_challenge_god_long_yan_game_prop",
		"timed_challenge_god_long_yan_params",
		"timed_challenge_god_long_yan_monster",
		"timed_challenge_god_long_yan_creeps",
		"timed_challenge_god_long_yan_buff"
	}
end

function GodLongYanConfig:handleConfig(name, content)
	if name == "timed_challenge_god_long_yan" then
		self._glyCfg = content
	elseif name == "timed_challenge_god_long_yan_game" then
		self._gameCfg = content
	elseif name == "timed_challenge_god_long_yan_game_stage" then
		self._gameStageCfgs = content
	elseif name == "timed_challenge_god_long_yan_game_prop" then
		self._gamePropCfg = content
	elseif name == "timed_challenge_god_long_yan_params" then
		self._glyParamsCfg = content
	elseif name == "timed_challenge_god_long_yan_monster" then
		self._glyMonsterCfgs = content
	elseif name == "timed_challenge_god_long_yan_creeps" then
		self._glyCreppsCfgs = content
	elseif name == "timed_challenge_god_long_yan_buff" then
		self._glyBuffCfgs = content

		self:handleBuffConfig(content)
	end
end

function GodLongYanConfig:handleBuffConfig(cfgs)
	self._buffPlanMap = {}
	self._buffPlanList = {}
	self._buffPlanMaxLvl = {}

	local list = cfgs.dataList

	for i, v in ipairs(list) do
		local planId = v.planId

		self._buffPlanList[planId] = self._buffPlanList[planId] or {}
		self._buffPlanMap[planId] = self._buffPlanMap[planId] or {}
		self._buffPlanMaxLvl[planId] = self._buffPlanMaxLvl[planId] or {}

		if self._buffPlanMap[planId][v.buffType] == nil then
			self._buffPlanMap[planId][v.buffType] = {}
			self._buffPlanMaxLvl[planId][v.buffType] = {}

			table.insert(self._buffPlanList[planId], v.buffType)
		end

		self._buffPlanMap[planId][v.buffType][v.level] = v
		self._buffPlanMaxLvl[planId][v.buffType] = math.max(v.level, checknumber(self._buffPlanMaxLvl[planId][v.buffType]))
	end

	for k, v in pairs(self._buffPlanMap) do
		local list = self._buffPlanList[k]

		ArraySort.sortOn(list)
	end
end

function GodLongYanConfig:getGlyCfg()
	return self._glyCfg
end

function GodLongYanConfig:getCommonValue(key)
	if self._glyParamsCfg[key] then
		return self._glyParamsCfg[key].value
	end

	return ""
end

function GodLongYanConfig:getGlyData(challengeId)
	return self._glyCfg[challengeId]
end

function GodLongYanConfig:getGameData(challengeId)
	local glyCfg = self:getGlyData(challengeId)

	return self:getGameDataById(glyCfg.gamePlanId)
end

function GodLongYanConfig:getGameDataById(gamePlanId)
	return self._gameCfg[gamePlanId]
end

function GodLongYanConfig:getGlyParamValue(key)
	return self._glyParamsCfg[key].value
end

function GodLongYanConfig:getDayGameTimes()
	local value = self:getGlyParamValue("DAILY_GAME_TIMES")

	return checknumber(value)
end

function GodLongYanConfig:getMaxScorePerGame()
	local value = self:getGlyParamValue("MAX_SCORE_PER_GAME")

	return checknumber(value)
end

function GodLongYanConfig:getGameStageCfg(gamePlanId)
	return self._gameStageCfgs[gamePlanId]
end

function GodLongYanConfig:getGameStageData(gamePlanId, stageIdx)
	return self:getGameStageCfg(gamePlanId)[stageIdx]
end

function GodLongYanConfig:getGameAreaData(gamePlanId, stageIdx, areaIdx)
	return self:getGameStageData(gamePlanId, stageIdx)[areaIdx]
end

function GodLongYanConfig:getStageTime(gamePlanId, stageIdx)
	local stageTime = 0
	local stageData = self:getGameStageData(gamePlanId, stageIdx)

	for areaIdx, areaData in ipairs(stageData) do
		stageTime = stageTime + areaData.areaTime + areaData.areaDuration
	end

	return stageTime
end

function GodLongYanConfig:getGamePropData(propId)
	return self._gamePropCfg[propId]
end

function GodLongYanConfig:getBuffByIdAndLvl(planId, type, lvl)
	if self._buffPlanMap[planId] and self._buffPlanMap[planId][type] then
		return self._buffPlanMap[planId][type][lvl]
	end

	return {}
end

function GodLongYanConfig:getBuffListByPlanId(planId)
	return self._glyBuffCfgs[planId]
end

function GodLongYanConfig:getTotalUpgradeCostNum(planId, type, lvl)
	local num = 0

	if self._buffPlanMap[planId] and self._buffPlanMap[planId][type] then
		local list = self._buffPlanMap[planId][type]

		for i, v in ipairs(list) do
			if lvl >= v.level then
				num = num + v.upgradeCostNum
			end
		end
	end

	return num
end

function GodLongYanConfig:getBuffMaxLvl(planId, type)
	if self._buffPlanMaxLvl[planId] then
		local lvl = checknumber(self._buffPlanMaxLvl[planId][type])

		return math.max(1, lvl)
	end

	return 1
end

function GodLongYanConfig:getCreepsCfgList(monsterPlan)
	return self._glyMonsterCfgs[monsterPlan]
end

function GodLongYanConfig:getCreepsMasterList(creepsMasterId)
	return self._glyCreppsCfgs[creepsMasterId]
end

GodLongYanConfig.instance = GodLongYanConfig.New()

return GodLongYanConfig
