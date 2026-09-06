-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/config/GrowUpRoadConfig.lua

module("logic.extensions.growup.config.GrowUpRoadConfig", package.seeall)

local GrowUpRoadConfig = class("GrowUpRoadConfig", BaseConfig)

function GrowUpRoadConfig:onInit()
	GrowUpRoadConfig.super.onInit(self)
end

function GrowUpRoadConfig:getNames()
	return {
		"pet_growth_path",
		"pet_growth_path_task",
		"pet_growth_path_strengthen",
		"pet_growth_common",
		"pet_growth_sham_pet"
	}
end

function GrowUpRoadConfig:handleConfig(name, content)
	if name == "pet_growth_path" then
		self._activity = content
		self._activityById = {}

		for i, list in ipairs(content) do
			for k, cfg in pairs(list) do
				self._activityById[k] = cfg
			end
		end
	elseif name == "pet_growth_path_task" then
		self._task = content
	elseif name == "pet_growth_path_strengthen" then
		self._strengthen = content
	elseif name == "pet_growth_common" then
		self._common = content
	elseif name == "pet_growth_sham_pet" then
		self._shamPet = content
	end
end

function GrowUpRoadConfig:getActivity()
	return self._activity
end

function GrowUpRoadConfig:getActivityById(id)
	return self._activity[id]
end

function GrowUpRoadConfig:getActivityByActivityId(activityId)
	return self._activityById[activityId]
end

function GrowUpRoadConfig:getTaskByPlanId(planId)
	return self._task[planId]
end

function GrowUpRoadConfig:getStrengthById(planId)
	return self._strengthen[planId]
end

function GrowUpRoadConfig:getCommonValue(key)
	return self._common[key].value
end

function GrowUpRoadConfig:getShamPetById(raceId)
	return self._shamPet[raceId]
end

GrowUpRoadConfig.instance = GrowUpRoadConfig.New()

return GrowUpRoadConfig
