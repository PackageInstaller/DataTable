-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/config/OrigindarkmoyanclgConfig.lua

module("logic.extensions.origindarkmoyanclg.config.OrigindarkmoyanclgConfig", package.seeall)

local OrigindarkmoyanclgConfig = class("OrigindarkmoyanclgConfig", BaseConfig)

function OrigindarkmoyanclgConfig:onInit()
	return
end

function OrigindarkmoyanclgConfig:getNames()
	return {
		"origin_dark_mo_yan_clg_creeps_master",
		"origin_dark_mo_yan_clg_activity",
		"origin_dark_mo_yan_clg_creeps",
		"origin_dark_mo_yan_clg_line_buff",
		"origin_dark_mo_yan_clg_cell",
		"origin_dark_mo_yan_clg_stage"
	}
end

function OrigindarkmoyanclgConfig:handleConfig(name, content)
	if name == "origin_dark_mo_yan_clg_creeps_master" then
		self._origin_dark_mo_yan_clg_creeps_master = content
	elseif name == "origin_dark_mo_yan_clg_activity" then
		self._origin_dark_mo_yan_clg_activity = content
	elseif name == "origin_dark_mo_yan_clg_creeps" then
		self._origin_dark_mo_yan_clg_creeps = content
	elseif name == "origin_dark_mo_yan_clg_line_buff" then
		self._origin_dark_mo_yan_clg_line_buff = content
	elseif name == "origin_dark_mo_yan_clg_cell" then
		self._origin_dark_mo_yan_clg_cell = content
	elseif name == "origin_dark_mo_yan_clg_stage" then
		self._origin_dark_mo_yan_clg_stage = content
	end
end

function OrigindarkmoyanclgConfig:getActivityCfg(activityId)
	return self._origin_dark_mo_yan_clg_activity[activityId]
end

function OrigindarkmoyanclgConfig:getStageCfgs(activityId)
	return self._origin_dark_mo_yan_clg_stage[activityId]
end

function OrigindarkmoyanclgConfig:getStageCfg(activityId, stageId)
	local cfgs = self:getStageCfgs(activityId)

	return cfgs[stageId]
end

function OrigindarkmoyanclgConfig:getCellCfgs(activityId, stageId)
	local list = {}

	for i, v in ipairs(self._origin_dark_mo_yan_clg_cell.dataList) do
		if v.activityId == activityId and v.stageId == stageId then
			table.insert(list, v)
		end
	end

	return list
end

function OrigindarkmoyanclgConfig:getCellCfg(activityId, stageId, x, y)
	return self._origin_dark_mo_yan_clg_cell[activityId][stageId][x][y]
end

function OrigindarkmoyanclgConfig:getCellXCount(activityId, stageId)
	return #self._origin_dark_mo_yan_clg_cell[activityId][stageId]
end

function OrigindarkmoyanclgConfig:getCellYCount(activityId, stageId, x)
	return #(self._origin_dark_mo_yan_clg_cell[activityId][stageId][x] or {})
end

function OrigindarkmoyanclgConfig:getCellLineCfgsByX(activityId, stageId, x)
	return self._origin_dark_mo_yan_clg_cell[activityId][stageId][x]
end

function OrigindarkmoyanclgConfig:getCellLineCfgsByY(activityId, stageId, y)
	local list = {}

	for i, v in ipairs(self._origin_dark_mo_yan_clg_cell.dataList) do
		if v.activityId == activityId and v.stageId == stageId and v.y == y then
			table.insert(list, v)
		end
	end

	return list
end

function OrigindarkmoyanclgConfig:getCreepsCfg(creepsMasterId)
	return self._origin_dark_mo_yan_clg_creeps[creepsMasterId]
end

function OrigindarkmoyanclgConfig:getCreepsMasterCfg(creepsMasterId)
	return self._origin_dark_mo_yan_clg_creeps_master[creepsMasterId]
end

function OrigindarkmoyanclgConfig:getLineBuffCfg(activityId, stageId, lineType, num)
	return self._origin_dark_mo_yan_clg_line_buff[activityId][stageId][lineType][num]
end

OrigindarkmoyanclgConfig.instance = OrigindarkmoyanclgConfig.New()

return OrigindarkmoyanclgConfig
