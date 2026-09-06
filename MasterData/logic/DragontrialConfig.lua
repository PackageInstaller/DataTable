-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragontrial/config/DragontrialConfig.lua

module("logic.extensions.dragontrial.config.DragontrialConfig", package.seeall)

local DragontrialConfig = class("DragontrialConfig", BaseConfig)

function DragontrialConfig:onInit()
	return
end

function DragontrialConfig:getNames()
	return {
		"dragon_trial_activity",
		"dragon_trial_buy_times_cost",
		"dragon_trial_monster",
		"dragon_trial_creeps",
		"dragon_trial_pet",
		"dragon_trial_damage_prize",
		"dragon_trial_rank",
		"dragon_trial_daily_task",
		"dragon_trial_develop_task_tab",
		"dragon_trial_strengthen_task",
		"dragon_trial_common_value",
		"dragon_second_trial_damage_reward_show"
	}
end

function DragontrialConfig:handleConfig(name, content)
	if name == "dragon_trial_activity" then
		self._dragon_trial_activity = content
	elseif name == "dragon_trial_buy_times_cost" then
		self._dragon_trial_buy_times_cost = content
	elseif name == "dragon_trial_monster" then
		self._dragon_trial_monster = content
	elseif name == "dragon_trial_creeps" then
		self._dragon_trial_creeps = content
	elseif name == "dragon_trial_pet" then
		self._dragon_trial_pet = content
	elseif name == "dragon_trial_damage_prize" then
		self._dragon_trial_damage_prize = content
	elseif name == "dragon_trial_rank" then
		self._dragon_trial_rank = content
	elseif name == "dragon_trial_daily_task" then
		self._dragon_trial_daily_task = content
	elseif name == "dragon_trial_develop_task_tab" then
		self._dragon_trial_develop_task_tab = content
	elseif name == "dragon_trial_strengthen_task" then
		self._dragon_trial_strengthen_task = content

		self:_handleDevelopTask(content.dataList)
	elseif name == "dragon_trial_common_value" then
		self._dragon_trial_common_value = content
	elseif name == "dragon_second_trial_damage_reward_show" then
		self._dragon_second_trial_damage_reward_show = content
	end
end

function DragontrialConfig:_handleDevelopTask(dataList)
	local list = {}

	for i, v in ipairs(dataList) do
		list[v.activityId] = list[v.activityId] or {}
		list[v.activityId][v.raceId] = list[v.activityId][v.raceId] or {}

		table.insert(list[v.activityId][v.raceId], v)
	end

	self._develop_task_showtype = list
end

function DragontrialConfig:getActCfg(activityId)
	return self._dragon_trial_activity[activityId]
end

function DragontrialConfig:getStageCfgs(planId)
	return self._dragon_trial_monster[planId]
end

function DragontrialConfig:getSysPetsByPlanId(planId)
	if not self._dragon_trial_pet[planId] then
		printError("_dragon_trial_pet 缺失 planId", planId)
	end

	return self._dragon_trial_pet[planId] or {}
end

function DragontrialConfig:getStageById(planId, stageId)
	return self._dragon_trial_monster[planId][stageId]
end

function DragontrialConfig:getSysPetCfg(planId, creepsId)
	return self._dragon_trial_pet[planId][creepsId]
end

function DragontrialConfig:getCreeps(creepsMasterId)
	return self._dragon_trial_creeps[creepsMasterId]
end

function DragontrialConfig:getBuyTimeCfgs(planId)
	return self._dragon_trial_buy_times_cost[planId]
end

function DragontrialConfig:getRankCfgs()
	local dic = {}

	for k, v in pairs(self._dragon_trial_rank) do
		if checknumber(k) > 0 then
			local list = TableUtil.toList(v)

			table.sort(list, function(a, b)
				return a.leaf < b.leaf
			end)

			dic[k] = list
		end
	end

	return TableUtil.toList(dic)
end

function DragontrialConfig:getRankCfg(root, leaf)
	return self._dragon_trial_rank[root][leaf]
end

function DragontrialConfig:getDevelopTaskTabCfgs()
	return self._dragon_trial_develop_task_tab.dataList
end

function DragontrialConfig:getDevelopTaskTabCfg(raceId)
	return self._dragon_trial_develop_task_tab[raceId]
end

function DragontrialConfig:getDevelopTaskTabCfg(activityId)
	return self._dragon_trial_develop_task_tab[activityId] or {}
end

function DragontrialConfig:getDevelopTaskCfgsByRaceId(activityId, raceId)
	if self._develop_task_showtype[activityId] then
		return self._develop_task_showtype[activityId][raceId] or {}
	end

	return {}
end

function DragontrialConfig:getDailyTaskCfgs(activityId)
	return self._dragon_trial_daily_task[activityId]
end

function DragontrialConfig:getDailyTaskCfg(activityId, taskId)
	return self._dragon_trial_daily_task[activityId][taskId]
end

function DragontrialConfig:getDamagePrizeShowCfgs()
	return self._dragon_second_trial_damage_reward_show.dataList
end

function DragontrialConfig:getCommonValue(key)
	return self._dragon_trial_common_value[key].value
end

DragontrialConfig.instance = DragontrialConfig.New()

return DragontrialConfig
