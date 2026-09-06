-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/config/ItemRecycleConfig.lua

module("logic.extensions.itembag.config.ItemRecycleConfig", package.seeall)

local ItemRecycleConfig = class("ItemRecycleConfig", BaseConfig)

function ItemRecycleConfig:onInit()
	ItemRecycleConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function ItemRecycleConfig:getNames()
	return {
		"resource_convert_quality_tab",
		"resource_convert_define_plan",
		"resource_convert_define_activity",
		"resource_convert_quality_plan",
		"resource_convert_quality_activity"
	}
end

function ItemRecycleConfig:handleConfig(name, content)
	if name == "resource_convert_quality_tab" then
		self._resource_convert_quality_tab = content
	elseif name == "resource_convert_define_plan" then
		self._resource_convert_define_plan = content
	elseif name == "resource_convert_define_activity" then
		self._resource_convert_define_activity = content
	elseif name == "resource_convert_quality_plan" then
		self._resource_convert_quality_plan = content
	elseif name == "resource_convert_quality_activity" then
		self._resource_convert_quality_activity = content
	end
end

function ItemRecycleConfig:getTabList()
	return self._resource_convert_quality_tab.dataList
end

function ItemRecycleConfig:getTabCfgById(id)
	return self._resource_convert_quality_tab[id]
end

function ItemRecycleConfig:getQualityActivityList()
	return self._resource_convert_quality_activity.dataList
end

function ItemRecycleConfig:getQualityBaseList()
	return self._resource_convert_quality_plan.dataList
end

function ItemRecycleConfig:getActivityList()
	return self._resource_convert_define_activity.dataList
end

function ItemRecycleConfig:getBaseList()
	return self._resource_convert_define_plan.dataList
end

ItemRecycleConfig.instance = ItemRecycleConfig.New()

return ItemRecycleConfig
