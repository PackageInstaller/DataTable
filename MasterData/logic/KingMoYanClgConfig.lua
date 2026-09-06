-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/config/KingMoYanClgConfig.lua

module("logic.extensions.kingmoyanclg.config.KingMoYanClgConfig", package.seeall)

local KingMoYanClgConfig = class("KingMoYanClgConfig", BaseConfig)

function KingMoYanClgConfig:onInit()
	KingMoYanClgConfig.super.onInit(self)
end

function KingMoYanClgConfig:getNames()
	return {
		"king_mo_yan_clg_activity",
		"king_mo_yan_clg_stage",
		"king_mo_yan_clg_buff",
		"king_mo_yan_clg_team",
		"king_mo_yan_clg_creeps",
		"king_mo_yan_clg_support"
	}
end

function KingMoYanClgConfig:handleConfig(name, content)
	if name == "king_mo_yan_clg_activity" then
		self._king_mo_yan_clg_activity = content
	elseif name == "king_mo_yan_clg_stage" then
		self._king_mo_yan_clg_stage = content
	elseif name == "king_mo_yan_clg_buff" then
		self._king_mo_yan_clg_buff = content
	elseif name == "king_mo_yan_clg_team" then
		self._king_mo_yan_clg_team = content
	elseif name == "king_mo_yan_clg_creeps" then
		self._king_mo_yan_clg_creeps = content
	elseif name == "king_mo_yan_clg_support" then
		self._king_mo_yan_clg_support = content
	end
end

function KingMoYanClgConfig:getActData(activityId)
	return self._king_mo_yan_clg_activity[activityId]
end

function KingMoYanClgConfig:getStageCfg(activityId)
	return self._king_mo_yan_clg_stage[activityId]
end

function KingMoYanClgConfig:getStageData(activityId, stageId)
	if self._king_mo_yan_clg_stage[activityId] then
		return self._king_mo_yan_clg_stage[activityId][stageId]
	end
end

function KingMoYanClgConfig:getBuffCfg(activityId)
	return self._king_mo_yan_clg_buff[activityId]
end

function KingMoYanClgConfig:getBuffData(activityId, buffId)
	if self._king_mo_yan_clg_buff[activityId] then
		return self._king_mo_yan_clg_buff[activityId][buffId]
	end
end

function KingMoYanClgConfig:getBuffDataByNum(activityId, num)
	local data
	local cfg = self._king_mo_yan_clg_buff[activityId]

	if cfg then
		for _, v in ipairs(cfg) do
			if num >= v.num then
				data = v
			else
				break
			end
		end
	end

	return data
end

function KingMoYanClgConfig:getMasterData(creepsMasterId)
	return self._king_mo_yan_clg_team[creepsMasterId]
end

function KingMoYanClgConfig:getCreepsCfg(creepsMasterId)
	return self._king_mo_yan_clg_creeps[creepsMasterId]
end

function KingMoYanClgConfig:getSupportData(creepsId)
	return self._king_mo_yan_clg_support[creepsId]
end

KingMoYanClgConfig.instance = KingMoYanClgConfig.New()

return KingMoYanClgConfig
