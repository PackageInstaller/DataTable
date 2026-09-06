-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/config/DivineMiMengLiClgConfig.lua

module("logic.extensions.divinemimengliclg.config.DivineMiMengLiClgConfig", package.seeall)

local DivineMiMengLiClgConfig = class("DivineMiMengLiClgConfig", BaseConfig)

function DivineMiMengLiClgConfig:onInit()
	DivineMiMengLiClgConfig.super.onInit(self)
end

function DivineMiMengLiClgConfig:getNames()
	return {
		"divine_mimengli_clg_activity",
		"divine_mimengli_clg_stage",
		"divine_mimengli_clg_team",
		"divine_mimengli_clg_creeps_master",
		"divine_mimengli_clg_creeps",
		"divine_mimengli_clg_pet",
		"divine_mimengli_clg_buff"
	}
end

function DivineMiMengLiClgConfig:handleConfig(name, content)
	if name == "divine_mimengli_clg_activity" then
		self._divine_mimengli_clg_activity = content
	elseif name == "divine_mimengli_clg_stage" then
		self._divine_mimengli_clg_stage = content
	elseif name == "divine_mimengli_clg_team" then
		self._divine_mimengli_clg_team = content
	elseif name == "divine_mimengli_clg_creeps_master" then
		self._divine_mimengli_clg_creeps_master = content
	elseif name == "divine_mimengli_clg_creeps" then
		self._divine_mimengli_clg_creeps = content
	elseif name == "divine_mimengli_clg_pet" then
		self._divine_mimengli_clg_pet = content
	elseif name == "divine_mimengli_clg_buff" then
		self._divine_mimengli_clg_buff = content
	end
end

function DivineMiMengLiClgConfig:getActData(activityId)
	return self._divine_mimengli_clg_activity[activityId]
end

function DivineMiMengLiClgConfig:getStageCfg(activityId)
	return self._divine_mimengli_clg_stage[activityId]
end

function DivineMiMengLiClgConfig:getStageData(activityId, stageId)
	if self._divine_mimengli_clg_stage[activityId] then
		return self._divine_mimengli_clg_stage[activityId][stageId]
	end
end

function DivineMiMengLiClgConfig:getStageType(activityId, stageId)
	local data = self:getStageData(activityId, stageId)

	return (data or nil) and (data.type or 0)
end

function DivineMiMengLiClgConfig:getTeamCfg(activityId, stageId)
	local data = self:getStageData(activityId, stageId)

	if data then
		if not data.stagePlanId then
			local stagePlanId = 0

			return self._divine_mimengli_clg_team[stagePlanId]
		end
	end
end

function DivineMiMengLiClgConfig:getTeamData(activityId, stageId, teamId)
	local cfg = self:getTeamCfg(activityId, stageId)

	return (cfg or nil) and (cfg[teamId] or nil)
end

function DivineMiMengLiClgConfig:getMasterData(creepsMasterId)
	return self._divine_mimengli_clg_creeps_master[creepsMasterId]
end

function DivineMiMengLiClgConfig:getCreepsCfg(creepsMasterId)
	return self._divine_mimengli_clg_creeps[creepsMasterId]
end

function DivineMiMengLiClgConfig:getPetData(creepsId)
	return self._divine_mimengli_clg_pet[creepsId]
end

function DivineMiMengLiClgConfig:getBuffCfg(activityId, stageId)
	local data = self:getStageData(activityId, stageId)

	if data then
		if not data.buffPlanId then
			local buffPlanId = 0

			return self._divine_mimengli_clg_buff[buffPlanId]
		end
	end
end

function DivineMiMengLiClgConfig:getBuffData(activityId, stageId, buffId)
	local cfg = self:getBuffCfg(activityId, stageId)

	return (cfg or nil) and (cfg[buffId] or nil)
end

function DivineMiMengLiClgConfig:getBuffDataByCount(activityId, stageId, signBuffCount)
	local result
	local cfg = self:getBuffCfg(activityId, stageId)

	if cfg then
		local low, high = 1, #cfg

		while low <= high do
			local mid = math.floor((low + high) / 2)

			if signBuffCount >= cfg[mid].signBuffCount then
				result = cfg[mid]
				low = mid + 1
			else
				high = mid - 1
			end
		end
	end

	return result
end

DivineMiMengLiClgConfig.instance = DivineMiMengLiClgConfig.New()

return DivineMiMengLiClgConfig
