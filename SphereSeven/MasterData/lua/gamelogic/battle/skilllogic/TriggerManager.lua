
local TriggerManager = BaseClass("EffectManager", Singleton)

local function GenerateTrigger(self, triggerId, skill)
	local z_Trigger = Z_BattleTrigger[triggerId]
	if z_Trigger == nil then
		Logger.LogError("TriggerManager:GenerateTrigger: z_Trigger is nil, triggerId = "..triggerId)
		return nil
	end
	-- local triggerClass = require("GameLogic.Battle.SkillLogic.Trigger." .. TriggerTypeScript[z_Trigger.Type])
	local triggerClass = require("GameLogic.Battle.SkillLogic.Trigger.TriggerConfig")
	if triggerClass == nil then
		Logger.LogError("TriggerManager:GenerateTrigger: triggerCls is nil, trigger type = "..z_Trigger.Type)
		return nil
	end
	local trigger = triggerClass.New(triggerId, skill)

	table.insert(skill.EventActions[z_Trigger.Event], function(skill, targetUnit)
		trigger:Run(skill, targetUnit)
	end)
	return trigger
end

local function Run()
	
end

TriggerManager.GenerateTrigger = GenerateTrigger

return TriggerManager
