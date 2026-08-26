-- chunkname: @modules/logic/necrologiststory/config/NecrologistStoryV3A9Config.lua

module("modules.logic.necrologiststory.config.NecrologistStoryV3A9Config", package.seeall)

local NecrologistStoryV3A9Config = class("NecrologistStoryV3A9Config", NecrologistStoryVersionConfigBase)

function NecrologistStoryV3A9Config:ctor()
	return
end

function NecrologistStoryV3A9Config:reqConfigNames()
	return {
		"hero_story_mode_v3a9_item",
		"hero_story_mode_v3a9_base",
		"hero_story_mode_v3a9_item_new",
		"hero_story_mode_v3a9_item_new_star"
	}
end

function NecrologistStoryV3A9Config:onLoadhero_story_mode_v3a9_item(configTable)
	self._itemConfig = configTable
end

function NecrologistStoryV3A9Config:onLoadhero_story_mode_v3a9_base(configTable)
	self._baseConfig = configTable
end

function NecrologistStoryV3A9Config:onLoadhero_story_mode_v3a9_item_new(configTable)
	self._itemNewConfig = configTable
end

function NecrologistStoryV3A9Config:onLoadhero_story_mode_v3a9_item_new_star(configTable)
	self._itemNewStarConfig = configTable
end

function NecrologistStoryV3A9Config:getBaseList()
	local list = {}

	for _, v in pairs(self._baseConfig.configDict) do
		table.insert(list, v)
	end

	table.sort(list, SortUtil.keyLower("id"))

	return list
end

function NecrologistStoryV3A9Config:getBaseConfig(id)
	return self._baseConfig.configDict[id]
end

function NecrologistStoryV3A9Config:getItemConfig(id)
	return self._itemConfig.configDict[id]
end

function NecrologistStoryV3A9Config:getItemList()
	return self._itemConfig.configList
end

function NecrologistStoryV3A9Config:getItemNewsConfig(itemDict)
	local maxStar = 0
	local result
	local configCount = 0
	local randomConfig

	for _, v in ipairs(self._itemNewConfig.configList) do
		configCount = configCount + 1

		local itemIds = string.splitToNumber(v.item, "#")
		local star = 5

		for _, itemId in ipairs(itemIds) do
			if not itemDict[itemId] then
				star = star - 1
			end
		end

		if maxStar < star then
			maxStar = star
			result = v
		end

		if NecrologistStoryPlayerPrefs.instance:isExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, v.id) then
			randomConfig = v
		end
	end

	if randomConfig == nil then
		randomConfig = self._itemNewConfig.configList[math.random(1, configCount)]

		NecrologistStoryPlayerPrefs.instance:setExist(NecrologistStoryEnum.PrefsKey.V3A9ItemOldTag, randomConfig.id)
	end

	return result, maxStar, randomConfig
end

function NecrologistStoryV3A9Config:getLevelConfig(starCount)
	for _, v in ipairs(self._itemNewStarConfig.configList) do
		if starCount >= v.min and starCount <= v.max then
			return v
		end
	end
end

function NecrologistStoryV3A9Config:getItemListByGroupId(groupId)
	local list = {}

	for _, v in ipairs(self._itemConfig.configList) do
		if v.group == groupId then
			table.insert(list, v)
		end
	end

	return list
end

NecrologistStoryV3A9Config.instance = NecrologistStoryV3A9Config.New()

return NecrologistStoryV3A9Config
