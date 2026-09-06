-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoddragonclg/config/OriginGodDragonClgConfig.lua

module("logic.extensions.origingoddragonclg.config.OriginGodDragonClgConfig", package.seeall)

local OriginGodDragonClgConfig = class("OriginGodDragonClgConfig", BaseConfig)

function OriginGodDragonClgConfig:getNames()
	return {
		"origin_god_dragon_clg_activity",
		"origin_god_dragon_clg_creeps",
		"origin_god_dragon_clg_creeps_team",
		"origin_god_dragon_clg_stage",
		"origin_god_dragon_clg_zone"
	}
end

function OriginGodDragonClgConfig:handleConfig(name, content)
	if name == "origin_god_dragon_clg_activity" then
		self._origin_god_dragon_clg_activity = content
	elseif name == "origin_god_dragon_clg_creeps" then
		self._origin_god_dragon_clg_creeps = content
	elseif name == "origin_god_dragon_clg_creeps_team" then
		self._origin_god_dragon_clg_creeps_team = content
	elseif name == "origin_god_dragon_clg_stage" then
		self._origin_god_dragon_clg_stage = content

		self:_handleStageConfig(content.dataList)
	elseif name == "origin_god_dragon_clg_zone" then
		self._origin_god_dragon_clg_zone = content
	end
end

function OriginGodDragonClgConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function OriginGodDragonClgConfig:getActivityData(activityId)
	return self:_safeGet(self._origin_god_dragon_clg_activity, activityId)
end

function OriginGodDragonClgConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._origin_god_dragon_clg_creeps, creepsMasterId)
end

function OriginGodDragonClgConfig:getCreepsData(creepsMasterId, index)
	return self:_safeGet(self._origin_god_dragon_clg_creeps, creepsMasterId, index)
end

function OriginGodDragonClgConfig:getCreepsTeamData(creepsMasterId)
	return self:_safeGet(self._origin_god_dragon_clg_creeps_team, creepsMasterId)
end

function OriginGodDragonClgConfig:getStageDatas(activityId)
	return self:_safeGet(self._origin_god_dragon_clg_stage, activityId)
end

function OriginGodDragonClgConfig:getStageData(activityId, stageId)
	return self:_safeGet(self._origin_god_dragon_clg_stage, activityId, stageId)
end

function OriginGodDragonClgConfig:getStageDataListByZone(activityId, zoneId)
	return self._stageDatasInZone[zoneId]
end

function OriginGodDragonClgConfig:_handleStageConfig(dataList)
	self._stageDatasInZone = {}

	if dataList then
		for _, data in ipairs(dataList) do
			if self._stageDatasInZone[data.zoneId] == nil then
				self._stageDatasInZone[data.zoneId] = {}
			end

			table.insert(self._stageDatasInZone[data.zoneId], data)
		end
	end
end

function OriginGodDragonClgConfig:getZoneDatas(activityId)
	return self:_safeGet(self._origin_god_dragon_clg_zone, activityId)
end

function OriginGodDragonClgConfig:getZoneData(activityId, zoneId)
	return self:_safeGet(self._origin_god_dragon_clg_zone, activityId, zoneId)
end

OriginGodDragonClgConfig.instance = OriginGodDragonClgConfig.New()

return OriginGodDragonClgConfig
