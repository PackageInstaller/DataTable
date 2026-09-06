-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemizongclg/config/DivineMiZongClgConfig.lua

module("logic.extensions.divinemizongclg.config.DivineMiZongClgConfig", package.seeall)

local DivineMiZongClgConfig = class("DivineMiZongClgConfig", BaseConfig)

function DivineMiZongClgConfig:getNames()
	return {
		"divine_mizong_clg",
		"divine_mizong_clg_stage",
		"divine_mizong_clg_star_prize",
		"divine_mizong_clg_buff",
		"divine_mizong_clg_progress_prize",
		"divine_mizong_clg_creeps_master",
		"divine_mizong_clg_creeps"
	}
end

function DivineMiZongClgConfig:handleConfig(name, content)
	if name == "divine_mizong_clg" then
		self._divine_mizong_clg = content
	elseif name == "divine_mizong_clg_stage" then
		self._divine_mizong_clg_stage = content
	elseif name == "divine_mizong_clg_star_prize" then
		self._divine_mizong_clg_star_prize = content
	elseif name == "divine_mizong_clg_buff" then
		self._divine_mizong_clg_buff = content
	elseif name == "divine_mizong_clg_progress_prize" then
		self._divine_mizong_clg_progress_prize = content
	elseif name == "divine_mizong_clg_creeps_master" then
		self._divine_mizong_clg_creeps_master = content
	elseif name == "divine_mizong_clg_creeps" then
		self._divine_mizong_clg_creeps = content
	end
end

function DivineMiZongClgConfig:getActData(activityId)
	return self._divine_mizong_clg[activityId]
end

function DivineMiZongClgConfig:getUpgradeItem(activityId)
	local data = self:getActData(activityId)

	return data and data.upgradeItem
end

function DivineMiZongClgConfig:getStageCfg(activityId)
	return self._divine_mizong_clg_stage[activityId]
end

function DivineMiZongClgConfig:getStageData(activityId, stageId)
	if self._divine_mizong_clg_stage[activityId] then
		return self._divine_mizong_clg_stage[activityId][stageId]
	end
end

function DivineMiZongClgConfig:getStartPrizeCfg(activityId, stageId)
	local data = self:getStageData(activityId, stageId)

	if data then
		if not data.starPrizePlan then
			local starPrizePlan = 0

			return self._divine_mizong_clg_star_prize[starPrizePlan]
		end
	end
end

function DivineMiZongClgConfig:getStartPrizeData(activityId, stageId, star)
	local cfg = self:getStartPrizeCfg(activityId, stageId)

	return cfg and cfg[star]
end

function DivineMiZongClgConfig:getBuffCfgs(activityId)
	return self._divine_mizong_clg_buff[activityId]
end

function DivineMiZongClgConfig:getBuffCfg(activityId, buffType)
	if self._divine_mizong_clg_buff[activityId] then
		return self._divine_mizong_clg_buff[activityId][buffType]
	end
end

function DivineMiZongClgConfig:getBuffData(activityId, buffType, buffLevel)
	if self._divine_mizong_clg_buff[activityId] and self._divine_mizong_clg_buff[activityId][buffType] then
		return self._divine_mizong_clg_buff[activityId][buffType][buffLevel]
	end
end

function DivineMiZongClgConfig:getMaxLevelBuff(activityId, buffType)
	local cfg = self:getBuffCfg(activityId, buffType)

	return (cfg or nil) and (#cfg or 0)
end

function DivineMiZongClgConfig:getProgressPrizeCfg(activityId)
	return self._divine_mizong_clg_progress_prize[activityId]
end

function DivineMiZongClgConfig:getProgressPrizeData(activityId, prizeId)
	if self._divine_mizong_clg_progress_prize[activityId] then
		return self._divine_mizong_clg_progress_prize[activityId][prizeId]
	end
end

function DivineMiZongClgConfig:getMasterData(creepsMasterId)
	return self._divine_mizong_clg_creeps_master[creepsMasterId]
end

function DivineMiZongClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_mizong_clg_creeps[creepsMasterId]
end

DivineMiZongClgConfig.instance = DivineMiZongClgConfig.New()

return DivineMiZongClgConfig
