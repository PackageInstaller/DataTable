-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originaruishiclg/config/OriginaruishiclgConfig.lua

module("logic.extensions.originaruishiclg.config.OriginaruishiclgConfig", package.seeall)

local OriginaruishiclgConfig = class("OriginaruishiclgConfig", BaseConfig)
local table_insert = table.insert

function OriginaruishiclgConfig:onInit()
	return
end

function OriginaruishiclgConfig:getNames()
	return {
		"origin_aruishi_clg_team",
		"origin_aruishi_clg_stage",
		"origin_aruishi_clg_creeps",
		"origin_aruishi_clg_activity"
	}
end

function OriginaruishiclgConfig:handleConfig(name, content)
	if name == "origin_aruishi_clg_team" then
		self._origin_aruishi_clg_team = content
	elseif name == "origin_aruishi_clg_stage" then
		self._origin_aruishi_clg_stage = content

		self:_onHandleFloorCfgs(content)
	elseif name == "origin_aruishi_clg_creeps" then
		self._origin_aruishi_clg_creeps = content
	elseif name == "origin_aruishi_clg_activity" then
		self._origin_aruishi_clg_activity = content
	end
end

function OriginaruishiclgConfig:_onHandleFloorCfgs(content)
	self._floorCfgs = {}

	for _, v in ipairs(content.dataList) do
		self._floorCfgs[v.activityId] = self._floorCfgs[v.activityId] or {}
		self._floorCfgs[v.activityId][v.floorId] = self._floorCfgs[v.activityId][v.floorId] or {}

		table_insert(self._floorCfgs[v.activityId][v.floorId], v)
	end

	for activityId, v in pairs(self._floorCfgs) do
		for floorId, vv in pairs(v) do
			table.sort(vv, function(a, b)
				return a.stageId < b.stageId
			end)
		end
	end
end

function OriginaruishiclgConfig:getActCfg(activityId)
	return self._origin_aruishi_clg_activity[activityId]
end

function OriginaruishiclgConfig:getStageCfgs(activityId)
	return self._origin_aruishi_clg_stage[activityId]
end

function OriginaruishiclgConfig:getStageData(activityId, stageId)
	return self._origin_aruishi_clg_stage[activityId] and self._origin_aruishi_clg_stage[activityId][stageId]
end

function OriginaruishiclgConfig:getFloorCfgs(activityId)
	return self._floorCfgs[activityId]
end

function OriginaruishiclgConfig:getFloorCfg(activityId, floor)
	local floorCfgs = self:getFloorCfgs(activityId)

	return floorCfgs and floorCfgs[floor]
end

function OriginaruishiclgConfig:getCreepsCfgs(creepsMasterId)
	return self._origin_aruishi_clg_creeps[creepsMasterId]
end

function OriginaruishiclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_aruishi_clg_team[creepsMasterId]
end

OriginaruishiclgConfig.instance = OriginaruishiclgConfig.New()

return OriginaruishiclgConfig
