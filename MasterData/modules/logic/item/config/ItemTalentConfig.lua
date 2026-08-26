-- chunkname: @modules/logic/item/config/ItemTalentConfig.lua

module("modules.logic.item.config.ItemTalentConfig", package.seeall)

local ItemTalentConfig = class("ItemTalentConfig", BaseConfig)

function ItemTalentConfig:ctor()
	self._itemTalentConfig = nil
end

function ItemTalentConfig:reqConfigNames()
	return {
		"talent_upgrade_item"
	}
end

function ItemTalentConfig:onConfigLoaded(configName, configTable)
	if configName == "talent_upgrade_item" then
		self._itemTalentConfig = configTable
	end
end

function ItemTalentConfig:getTalentItemCos()
	return self._itemTalentConfig.configDict
end

function ItemTalentConfig:getTalentItemCo(id)
	return self._itemTalentConfig.configDict[id]
end

ItemTalentConfig.instance = ItemTalentConfig.New()

return ItemTalentConfig
