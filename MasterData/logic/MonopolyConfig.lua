-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/config/MonopolyConfig.lua

module(..., package.seeall)

local MonopolyConfig = class("MonopolyConfig", BaseConfig)

function MonopolyConfig:onInit()
	return
end

function MonopolyConfig:getNames()
	return {
		"monopoly_config",
		"monopoly_step",
		"monopoly_event",
		"monopoly_extra_bonus",
		"monopoly_step_level"
	}
end

function MonopolyConfig:handleConfig(name, content)
	if name == "monopoly_config" then
		self._monopoly = content
	elseif name == "monopoly_step" then
		self._monopoly_step = content
	elseif name == "monopoly_event" then
		self._monopoly_event = content
	elseif name == "monopoly_extra_bonus" then
		self._monopoly_extra_bonus = content
	elseif name == "monopoly_step_level" then
		local upgradePlan = {}

		for k, v in pairs(content) do
			upgradePlan[k] = {}

			for j, eachLevelCfg in pairs(v) do
				table.insert(upgradePlan[k], eachLevelCfg)
			end
		end

		for k, v in pairs(upgradePlan) do
			table.sort(v, function(a, b)
				return a.rewardLevel < b.rewardLevel
			end)
		end

		self._monopoly_step_level = upgradePlan
	end
end

function MonopolyConfig:getAllVersions()
	return self._monopoly
end

function MonopolyConfig:getRoundCfg(id, round)
	return self._monopoly_step[id][round]
end

function MonopolyConfig:getMonopolyConfigById(activityId)
	return self._monopoly[activityId]
end

function MonopolyConfig:getAllMounts()
	return self._mount.dataList
end

function MonopolyConfig:getMountCo(id)
	return self._mount[id]
end

function MonopolyConfig:getMonopolyEvent(id)
	return self._monopoly_event[id]
end

function MonopolyConfig:getExtraBonus(planId)
	local data = {}

	for k, v in ipairs(self._monopoly_extra_bonus.dataList) do
		if planId == v.planId then
			table.insert(data, v)
		end
	end

	return data
end

function MonopolyConfig:getLevelPlan(planId)
	return self._monopoly_step_level[planId]
end

MonopolyConfig.instance = MonopolyConfig.New()

return MonopolyConfig
