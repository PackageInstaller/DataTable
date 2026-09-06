-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/config/XingJiangConfig.lua

module("logic.extensions.xingjiang.config.XingJiangConfig", package.seeall)

local XingJiangConfig = class("XingJiangConfig", BaseConfig)

XingJiangConfig.compareType = {
	[""] = 0,
	[GameEnum.EQUAL_TO] = 1,
	[GameEnum.LESS_THAN] = 2,
	[GameEnum.GREATER_THAN] = 3
}

function XingJiangConfig:onInit()
	XingJiangConfig.super.onInit(self)
end

function XingJiangConfig:getNames()
	return {
		"xingjiang_formula_challenge_activity",
		"xingjiang_formula_challenge_stage",
		"xingjiang_formula_challenge_team",
		"xingjiang_formula_challenge_monster",
		"xingjiang_formula_challenge_creeps",
		"xingjiang_formula_challenge_sign",
		"xingjiang_formula_challenge_task_page",
		"xingjiang_formula_challenge_task",
		"xingjiang_future_challenge_activity",
		"xingjiang_future_challenge_stage",
		"xingjiang_future_challenge_monster",
		"xingjiang_future_challenge_creeps"
	}
end

function XingJiangConfig:handleConfig(name, content)
	if name == "xingjiang_formula_challenge_activity" then
		self._planCfg = content
	elseif name == "xingjiang_formula_challenge_stage" then
		self._stageCfg = content
	elseif name == "xingjiang_formula_challenge_team" then
		self._teamCfg = content
	elseif name == "xingjiang_formula_challenge_sign" then
		self._signCfg = content
	elseif name == "xingjiang_formula_challenge_monster" then
		self._teamCreepCfg = content
	elseif name == "xingjiang_formula_challenge_creeps" then
		self._creepCfg = content
	elseif name == "xingjiang_formula_challenge_task_page" then
		self._taskPageCfgs = content
	elseif name == "xingjiang_formula_challenge_task" then
		self._taskCfg = content

		self:handleTaskCfgs(content)
	elseif name == "xingjiang_future_challenge_activity" then
		self._planCfg2 = content
	elseif name == "xingjiang_future_challenge_stage" then
		self._stageCfg2 = content
	elseif name == "xingjiang_future_challenge_monster" then
		self._teamCreepCfg2 = content
	elseif name == "xingjiang_future_challenge_creeps" then
		self._creepCfg2 = content
	end
end

function XingJiangConfig:getPlanCfg(actid)
	return self._planCfg[actid]
end

function XingJiangConfig:getStageCfgs(actid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return self._stageCfg[planid]
end

function XingJiangConfig:getStageCount(actid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return #self._stageCfg[planid]
end

function XingJiangConfig:getTeamCfgs(actid, sid)
	local planid = self:getPlanCfg(actid).challengePlanId

	return self._teamCfg[planid][sid]
end

function XingJiangConfig:getCreepCfgs(creepId)
	return self._creepCfg[creepId]
end

function XingJiangConfig:getTeamCfg(masterId)
	return self._teamCreepCfg[masterId]
end

function XingJiangConfig:getSignCfgs(actid)
	local planid = self:getPlanCfg(actid).signInPlanId

	return self._signCfg[planid]
end

function XingJiangConfig:getTaskCfgs(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskCfg[planid]
end

function XingJiangConfig:getTaskData(actid, taskId)
	local taskCfg = self:getTaskCfgs(actid)

	return taskCfg[taskId]
end

function XingJiangConfig:handleTaskCfgs(content)
	self._taskQueues = {}

	for taskPlanId, taskCfg in ipairs(content) do
		local queue = {}

		for _, data in ipairs(taskCfg) do
			local pageId = data.pageId

			queue[pageId] = queue[pageId] or {}

			table.insert(queue[pageId], data)
		end

		for _, list in ipairs(queue) do
			ArraySort.sortOn(list, "taskId")
		end

		self._taskQueues[taskPlanId] = queue
	end
end

function XingJiangConfig:getTaskQueue(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskQueues[planid]
end

function XingJiangConfig:getTaskPageCfg(actid)
	local planid = self:getPlanCfg(actid).taskPlanId

	return self._taskPageCfgs[planid]
end

function XingJiangConfig:getPlan2Cfg(actid)
	return self._planCfg2[actid]
end

function XingJiangConfig:getStage2Cfgs(actid)
	local planid = self:getPlan2Cfg(actid).challengePlanId

	return self._stageCfg2[planid]
end

function XingJiangConfig:getCreep2Cfgs(creepId)
	return self._creepCfg2[creepId]
end

function XingJiangConfig:getTeam2Cfg(masterId)
	return self._teamCreepCfg2[masterId]
end

XingJiangConfig.instance = XingJiangConfig.New()

return XingJiangConfig
