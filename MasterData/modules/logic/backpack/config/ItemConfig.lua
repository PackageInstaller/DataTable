-- chunkname: @modules/logic/backpack/config/ItemConfig.lua

module("modules.logic.backpack.config.ItemConfig", package.seeall)

local ItemConfig = class("ItemConfig", BaseConfig)

function ItemConfig:ctor()
	self._itemConfig = nil
	self._itemUseConfig = nil
	self._itemSpecialConfig = nil
	self._itemPowerConfig = nil
	self._itemInsightConfig = nil
	self._itemUseTipConfig = nil
end

function ItemConfig:reqConfigNames()
	return {
		"item",
		"item_use",
		"item_specialitem",
		"power_item",
		"item_category_show",
		"insight_item",
		"specialexpired_item",
		"item_use_tip"
	}
end

function ItemConfig:onConfigLoaded(configName, configTable)
	if configName == "item" then
		self._itemConfig = configTable
	elseif configName == "item_use" then
		self._itemUseConfig = configTable
	elseif configName == "item_specialitem" then
		self._itemSpecialConfig = configTable
	elseif configName == "power_item" then
		self._itemPowerConfig = configTable
	elseif configName == "item_category_show" then
		self._itemCategoryShow = configTable
	elseif configName == "insight_item" then
		self._itemInsightConfig = configTable
	elseif configName == "specialexpired_item" then
		self._specialExpiredItemConfig = configTable
	elseif configName == "item_use_tip" then
		self._itemUseTipConfig = configTable
	end
end

function ItemConfig:getItemsCo()
	return self._itemConfig.configDict
end

function ItemConfig:getItemCo(propId)
	return self._itemConfig.configDict[propId]
end

function ItemConfig:getItemsUseCo()
	return self._itemUseConfig.configDict
end

function ItemConfig:getItemUseCo(itemId)
	return self._itemUseConfig.configDict[itemId]
end

function ItemConfig:getItemsSpecialCo()
	return self._itemSpecialConfig.configDict
end

function ItemConfig:getItemSpecialCo(itemId)
	return self._itemSpecialConfig.configDict[itemId]
end

function ItemConfig:getItemsPowerCo()
	return self._itemPowerConfig.configDict
end

function ItemConfig:getPowerItemCo(itemId)
	return self._itemPowerConfig.configDict[itemId]
end

function ItemConfig:getItemsInsightCo()
	return self._itemInsightConfig.configDict
end

function ItemConfig:getInsightItemCo(itemId)
	return self._itemInsightConfig.configDict[itemId]
end

function ItemConfig:getItemsSpecialExpiredItemCo()
	return self._specialExpiredItemConfig.configDict
end

function ItemConfig:getItemSpecialExpiredItemCo(itemId)
	return self._specialExpiredItemConfig.configDict[itemId]
end

function ItemConfig:getItemNameById(propId)
	return self._itemConfig.configDict[propId] and self._itemConfig.configDict[propId].name
end

function ItemConfig:getItemIconById(propId)
	return self._itemConfig.configDict[propId] and self._itemConfig.configDict[propId].icon
end

function ItemConfig:getItemUseTipConfigById(propId)
	return self._itemUseTipConfig.configDict[propId]
end

function ItemConfig:getItemListBySubType(subType)
	if not self._subTypeDict then
		self._subTypeDict = {}

		for _, config in ipairs(self._itemConfig.configList) do
			local propList = self._subTypeDict[config.subType]

			if not propList then
				propList = {}
				self._subTypeDict[config.subType] = propList
			end

			table.insert(propList, config)
		end
	end

	return self._subTypeDict[subType]
end

function ItemConfig:getStackItemList(list)
	local newList = {}

	for i, item in ipairs(list) do
		local materialType = tonumber(item[1])
		local materialId = tonumber(item[2])
		local quantity = tonumber(item[3])
		local config = ItemModel.instance:getItemConfig(tonumber(item[1]), tonumber(item[2]))

		if config then
			local stackable = self:isItemStackable(materialType, materialId)

			if stackable then
				local sItem = {}

				sItem[1] = materialType
				sItem[2] = materialId
				sItem[3] = quantity

				table.insert(newList, sItem)
			else
				for j = 1, quantity do
					local sItem = {}

					sItem[1] = materialType
					sItem[2] = materialId
					sItem[3] = 1

					table.insert(newList, sItem)
				end
			end
		else
			logError(string.format("getStackItemList no config, type: %s, id: %s", materialType, materialId))
		end
	end

	return newList
end

function ItemConfig:isItemStackable(materialType, materialId)
	local stackable = true
	local config = self:getItemConfig(tonumber(materialType), tonumber(materialId))

	if materialType == MaterialEnum.MaterialType.Item then
		stackable = not config.isStackable or config.isStackable == 1
	elseif materialType == MaterialEnum.MaterialType.Hero or materialType == MaterialEnum.MaterialType.HeroSkin or materialType == MaterialEnum.MaterialType.EquipCard or materialType == MaterialEnum.MaterialType.PlayerCloth or materialType == MaterialEnum.MaterialType.Season123EquipCard then
		stackable = false
	elseif materialType == MaterialEnum.MaterialType.Equip then
		stackable = config.isExpEquip and config.isExpEquip == 1
	end

	return stackable
end

function ItemConfig:getItemCategroyShow(category)
	return self._itemCategoryShow.configDict[category]
end

function ItemConfig:getItemConfig(type, id)
	type = tonumber(type)
	id = tonumber(id)

	local config
	local getFunc = ItemConfigGetDefine.instance:getItemConfigFunc(type)

	return getFunc and getFunc(id) or self:getItemSpecialCo(type)
end

function ItemConfig:isUniqueByCo(type, itemConfig)
	if type ~= MaterialEnum.MaterialType.Equip then
		return false
	end

	return itemConfig.upperLimit and itemConfig.upperLimit == 1
end

function ItemConfig:isUniqueById(type, id)
	return self:isUniqueByCo(type, self:getItemConfig(type, id))
end

function ItemConfig:getRewardGroupRateInfoList(itemEffect)
	itemEffect = tonumber(itemEffect)

	local rewardCO = lua_reward.configDict[itemEffect]
	local list = {}
	local i = 0

	repeat
		i = i + 1

		local rewardGroup = rewardCO["rewardGroup" .. i]

		if string.nilorempty(rewardGroup) then
			return list
		end

		local strList = string.split(rewardGroup, ":")

		if strList then
			local group = strList[1]

			DungeonConfig.instance:_calcRewardGroupRateInfoList(list, group)
		end
	until not strList or #strList == 0

	return list
end

ItemConfig.instance = ItemConfig.New()

return ItemConfig
