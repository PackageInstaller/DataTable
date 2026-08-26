-- chunkname: @modules/logic/fightuiswitch/config/FightUISwitchConfig.lua

module("modules.logic.fightuiswitch.config.FightUISwitchConfig", package.seeall)

local FightUISwitchConfig = class("FightUISwitchConfig", BaseConfig)

function FightUISwitchConfig:reqConfigNames()
	return {
		"fight_ui_style",
		"fight_ui_effect"
	}
end

function FightUISwitchConfig:onInit()
	return
end

function FightUISwitchConfig:onConfigLoaded(configName, configTable)
	if configName == "fight_ui_style" then
		self._fight_ui_style = configTable

		self:_initFightUIStyleConfig()
	elseif configName == "fight_ui_effect" then
		self._fight_ui_effect = configTable
	end
end

function FightUISwitchConfig:_initFightUIStyleConfig()
	self._itemStyleCoList = {}

	for _, config in ipairs(self._fight_ui_style.configList) do
		self._itemStyleCoList[config.itemId] = self._itemStyleCoList[config.itemId] or {}

		table.insert(self._itemStyleCoList[config.itemId], config)
	end
end

function FightUISwitchConfig:getFightUIStyleCoById(id)
	return self._fight_ui_style.configDict[id]
end

function FightUISwitchConfig:getFightUIStyleCoList()
	return self._fight_ui_style.configList
end

function FightUISwitchConfig:getFightUIEffectConfigById(id)
	return self._fight_ui_effect.configDict[id]
end

function FightUISwitchConfig:getStyleCosByItemId(itemId)
	return self._itemStyleCoList[itemId]
end

FightUISwitchConfig.instance = FightUISwitchConfig.New()

return FightUISwitchConfig
