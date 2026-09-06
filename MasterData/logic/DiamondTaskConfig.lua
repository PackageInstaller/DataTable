-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/diamondtask/config/DiamondTaskConfig.lua

module("logic.extensions.diamondtask.config.DiamondTaskConfig", package.seeall)

local DiamondTaskConfig = class("DiamondTaskConfig", BaseConfig)

function DiamondTaskConfig:onInit()
	DiamondTaskConfig.super.onInit(self)

	self._taskCfg = nil
	self._scoreCfg = nil
	self._scoreTypeCfg = nil
end

function DiamondTaskConfig:getNames()
	return {
		"diamond_task",
		"diamond_task_activity_score_plan",
		"diamond_task_type_to_plan",
		"diamond_task_common_config"
	}
end

function DiamondTaskConfig:handleConfig(name, content)
	if name == "diamond_task" then
		self._taskCfg = content
	elseif name == "diamond_task_activity_score_plan" then
		self._scoreCfg = content
	elseif name == "diamond_task_type_to_plan" then
		self._scoreTypeCfg = content
	elseif name == "diamond_task_common_config" then
		self.diamond_task_common_configCfg = content
	end
end

function DiamondTaskConfig:getTaskCommValue(id)
	if self.diamond_task_common_configCfg[id] then
		return self.diamond_task_common_configCfg[id].value
	end

	return ""
end

function DiamondTaskConfig:getTaskCfgById(id)
	return self._taskCfg[id]
end

function DiamondTaskConfig:getTaskCfgs()
	return table.values(self._taskCfg)
end

function DiamondTaskConfig:getPlanId(period, weekday)
	local cfg = self._scoreTypeCfg[period]

	for k, v in pairs(cfg) do
		if string.nilorempty(v.onlineTimeRange) then
			return v.planId
		end

		local strs = string.split(v.onlineTimeRange, "#")

		if GameUtil.checkIsInTimePeriod(strs[1], strs[2]) then
			return v.planId
		end
	end
end

function DiamondTaskConfig:getPlanCfgs(planId)
	return self._scoreCfg[planId]
end

DiamondTaskConfig.instance = DiamondTaskConfig.New()

return DiamondTaskConfig
