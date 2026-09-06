-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/config/CollectClothesConfig.lua

module("logic.extensions.collectclothes.config.CollectClothesConfig", package.seeall)

local CollectClothesConfig = class("CollectClothesConfig", BaseConfig)

function CollectClothesConfig:onInit()
	CollectClothesConfig.super.onInit(self)

	self._collect_clothes = nil
	self._collect_clothes_collection = nil
	self._collect_clothes_prize = nil
end

function CollectClothesConfig:getNames()
	return {
		"collect_clothes",
		"collect_clothes_collection",
		"collect_clothes_prize"
	}
end

function CollectClothesConfig:handleConfig(name, content)
	if name == "collect_clothes" then
		self._collect_clothes = content
	elseif name == "collect_clothes_collection" then
		self._collect_clothes_collection = {}

		for i, v in ipairs(content) do
			for j, conf in ipairs(v) do
				local collectPlanId = conf.collectPlanId

				if not self._collect_clothes_collection[collectPlanId] then
					local array = {}

					table.insert(array, conf)

					self._collect_clothes_collection[collectPlanId] = array
				end
			end
		end

		for i, array in pairs(self._collect_clothes_collection) do
			table.sort(array, function(a, b)
				return a.collectId < b.collectId
			end)
		end
	elseif name == "collect_clothes_prize" then
		self._collect_clothes_prize = {}

		for i, v in ipairs(content) do
			for j, conf in ipairs(v) do
				local prizePlanId = conf.prizePlanId

				if not self._collect_clothes_prize[prizePlanId] then
					local array = {}

					table.insert(array, conf)

					self._collect_clothes_prize[prizePlanId] = array
				end
			end
		end

		for i, array in pairs(self._collect_clothes_prize) do
			table.sort(array, function(a, b)
				return a.prizeId < b.prizeId
			end)
		end
	end
end

function CollectClothesConfig:getActConf(activityId)
	return self._collect_clothes[activityId]
end

function CollectClothesConfig:getCollectionConfigs(collectPlanId)
	return self._collect_clothes_collection[collectPlanId]
end

function CollectClothesConfig:getPrizeConfig(prizePlanId)
	return self._collect_clothes_prize[prizePlanId][1]
end

CollectClothesConfig.instance = CollectClothesConfig.New()

return CollectClothesConfig
