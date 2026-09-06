-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesswaken/config/GoddessWakenConfig.lua

module("logic.extensions.goddesswaken.config.GoddessWakenConfig", package.seeall)

local GoddessWakenConfig = class("GoddessWakenConfig", BaseConfig)

function GoddessWakenConfig:onInit()
	GoddessWakenConfig.super.onInit(self)

	self.goddess_waken_activity = nil
	self.goddess_waken_pet = nil
	self.goddess_waken_quality_plan = nil
	self.goddess_waken_task = nil
	self.goddess_waken_const = nil
	self.goddess_waken_ui = nil
end

function GoddessWakenConfig:getNames()
	return {
		"goddess_waken_activity",
		"goddess_waken_pet",
		"goddess_waken_quality_plan",
		"goddess_waken_task",
		"goddess_waken_const",
		"goddess_waken_ui"
	}
end

function GoddessWakenConfig:handleConfig(name, content)
	if name == "goddess_waken_activity" then
		self.goddess_waken_activity = content
	elseif name == "goddess_waken_pet" then
		self.goddess_waken_pet = content
	elseif name == "goddess_waken_quality_plan" then
		self.goddess_waken_quality_plan = content
	elseif name == "goddess_waken_task" then
		self.goddess_waken_task = content
	elseif name == "goddess_waken_const" then
		self.goddess_waken_const = content
	elseif name == "goddess_waken_ui" then
		self.goddess_waken_ui = content
	end
end

function GoddessWakenConfig:getActivityCfg(id)
	return self.goddess_waken_activity[id]
end

function GoddessWakenConfig:getPetCfg(petPlanId, goddessId)
	if self.goddess_waken_pet[petPlanId] then
		return self.goddess_waken_pet[petPlanId][goddessId]
	end
end

function GoddessWakenConfig:getPetList(petPlanId)
	return self.goddess_waken_pet[petPlanId] or {}
end

function GoddessWakenConfig:getPlanCfg(qualityPlanId, qualityId)
	if self.goddess_waken_quality_plan[qualityPlanId] then
		return self.goddess_waken_quality_plan[qualityPlanId][qualityId]
	end
end

function GoddessWakenConfig:getPlanList(qualityPlanId)
	return self.goddess_waken_quality_plan[qualityPlanId] or {}
end

function GoddessWakenConfig:getTaskCfg(taskPlanId, taskId)
	if self.goddess_waken_task[taskPlanId] then
		return self.goddess_waken_task[taskPlanId][taskId]
	end
end

function GoddessWakenConfig:getTaskList(taskPlanId)
	return self.goddess_waken_task[taskPlanId] or {}
end

function GoddessWakenConfig:getTaskTypeList(taskPlanId)
	local dataList = self:getTaskList(taskPlanId) or {}
	local list = {}

	for i, v in ipairs(dataList) do
		list[v.showType] = list[v.showType] or {}

		table.insert(list[v.showType], v)
	end

	return list
end

function GoddessWakenConfig:getConstValue(key)
	if self.goddess_waken_const[key] then
		return self.goddess_waken_const[key].value
	end
end

function GoddessWakenConfig:getUICfg(planId, goddessId)
	if self.goddess_waken_ui[planId] then
		return self.goddess_waken_ui[planId][goddessId]
	end
end

GoddessWakenConfig.instance = GoddessWakenConfig.New()

return GoddessWakenConfig
