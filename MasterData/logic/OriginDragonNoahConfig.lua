-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindragonnoah/config/OriginDragonNoahConfig.lua

module("logic.extensions.origindragonnoah.config.OriginDragonNoahConfig", package.seeall)

local OriginDragonNoahConfig = class("OriginDragonNoahConfig", BaseConfig)

function OriginDragonNoahConfig:onInit()
	OriginDragonNoahConfig.super.onInit(self)

	self._sortScorePlanMap = {}
end

function OriginDragonNoahConfig:getNames()
	return {
		"origin_dragon_noah_clg_activity",
		"origin_dragon_noah_clg_stage",
		"origin_dragon_noah_clg_score_plan",
		"origin_dragon_noah_clg_monster",
		"origin_dragon_noah_clg_creeps"
	}
end

function OriginDragonNoahConfig:handleConfig(name, content)
	if name == "origin_dragon_noah_clg_activity" then
		self._origin_dragon_noah_clg_activity = content
	elseif name == "origin_dragon_noah_clg_stage" then
		self._origin_dragon_noah_clg_stage = content
	elseif name == "origin_dragon_noah_clg_score_plan" then
		self._origin_dragon_noah_clg_score_plan = content

		self:_getSortScorePlanMap()
	elseif name == "origin_dragon_noah_clg_monster" then
		self._origin_dragon_noah_clg_monster = content
	elseif name == "origin_dragon_noah_clg_creeps" then
		self._origin_dragon_noah_clg_creeps = content
	end
end

function OriginDragonNoahConfig:getActCfg(activityId)
	return self._origin_dragon_noah_clg_activity[activityId]
end

function OriginDragonNoahConfig:getStageCfgs(activityId)
	return self._origin_dragon_noah_clg_stage[activityId]
end

function OriginDragonNoahConfig:getStageCfgById(activityId, stageId)
	return self._origin_dragon_noah_clg_stage[activityId] and self._origin_dragon_noah_clg_stage[activityId][stageId]
end

function OriginDragonNoahConfig:getScorePlanCfgsByBuffSignId(activityId, buffSignIndex)
	return self._origin_dragon_noah_clg_score_plan[activityId] and self._origin_dragon_noah_clg_score_plan[activityId][buffSignIndex]
end

function OriginDragonNoahConfig:_getSortScorePlanMap()
	for i, cfg in ipairs(self._origin_dragon_noah_clg_score_plan.dataList) do
		local activityId = cfg.activityId

		self._sortScorePlanMap[activityId] = self._sortScorePlanMap[activityId] or {}

		local curSortScorePlanMap = self._sortScorePlanMap[activityId]
		local buffSignIdx = cfg.buffSignIndex

		curSortScorePlanMap[buffSignIdx] = curSortScorePlanMap[buffSignIdx] or {}

		local curBuffSignList = curSortScorePlanMap[buffSignIdx]

		table.insert(curBuffSignList, cfg)
	end

	for k, map in pairs(self._sortScorePlanMap) do
		for k2, v2 in pairs(map) do
			table.sort(v2, function(a, b)
				return a.count < b.count
			end)
		end
	end
end

function OriginDragonNoahConfig:getBuffSignSortList(activityId, buffSignIdx)
	return self._sortScorePlanMap[activityId] and self._sortScorePlanMap[activityId][buffSignIdx]
end

function OriginDragonNoahConfig:getCreepMasterCfg(creepMasterId)
	return self._origin_dragon_noah_clg_monster[creepMasterId]
end

function OriginDragonNoahConfig:getCreepsCfg(creepMasterId)
	return self._origin_dragon_noah_clg_creeps[creepMasterId]
end

function OriginDragonNoahConfig:getCreepMasterId(activityId, stageId)
	local stageCfg = self:getStageCfgById(activityId, stageId)

	return stageCfg and stageCfg.creepsMasterId
end

function OriginDragonNoahConfig:getCreepFirstRaceId(creepMasterId)
	local creepCfgs = self:getCreepsCfg(creepMasterId)
	local beforeIdx = math.huge
	local beforeRaceId = 0

	for idx, cfg in pairs(creepCfgs) do
		if idx < beforeIdx then
			beforeIdx = idx
			beforeRaceId = cfg.raceId
		end
	end

	return beforeRaceId
end

function OriginDragonNoahConfig:getScorePlanCfgSortList(activityId, buffSignIndex)
	local buffCfgs = self:getScorePlanCfgsByBuffSignId(activityId, buffSignIndex)
	local buffList = {}

	for _, cfg in pairs(buffCfgs) do
		table.insert(buffList, cfg)
	end

	table.sort(buffList, function(a, b)
		return a.count < b.count
	end)

	return buffList
end

function OriginDragonNoahConfig:getbuffRuleList(activityId, buffSignIndex)
	local buffList = self:getBuffSignSortList(activityId, buffSignIndex)
	local buffRuleList = {}

	for i, cfg in ipairs(buffList) do
		if i ~= 1 then
			local buffRule = {}
			local preCfg = buffList[i - 1]

			buffRule.areaDesc = string.format("%d-%d", preCfg.count, cfg.count - 1)
			buffRule.score = preCfg.score

			table.insert(buffRuleList, buffRule)
		end
	end

	local cfg = buffList[#buffList]
	local buffRule = {}

	buffRule.areaDesc = string.format("%d及以上", cfg.count)
	buffRule.score = cfg.score

	table.insert(buffRuleList, buffRule)

	return buffRuleList
end

OriginDragonNoahConfig.instance = OriginDragonNoahConfig.New()

return OriginDragonNoahConfig
