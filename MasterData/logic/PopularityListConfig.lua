-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/popularitylist/config/PopularityListConfig.lua

module("logic.extensions.popularitylist.config.PopularityListConfig", package.seeall)

local PopularityListConfig = class("PopularityListConfig", BaseConfig)

function PopularityListConfig:onInit()
	PopularityListConfig.super.onInit(self)
end

function PopularityListConfig:getNames()
	return {
		"popularity_list_base",
		"popularity_list",
		"popularity_list_common",
		"popularity_list_item",
		"popularity_list_item_detail",
		"popularity_list_text",
		"popularity_list_vip_times_plan",
		"popularity_list_daily_times_plan",
		"year_version"
	}
end

function PopularityListConfig:handleConfig(name, content)
	if name == "popularity_list_base" then
		self._actCfg = content
	elseif name == "popularity_list_common" then
		self._commonCfg = content
	elseif name == "popularity_list" then
		self._baseCfgs = content
	elseif name == "popularity_list_item" then
		self._itemCfgs = content

		self:_handleItemDataList(content.dataList)
	elseif name == "popularity_list_item_detail" then
		self._itemDetailCfg = content
	elseif name == "popularity_list_text" then
		self._textCfg = content
	elseif name == "popularity_list_vip_times_plan" then
		self._popularity_list_vip_times_plan = content
	elseif name == "popularity_list_daily_times_plan" then
		self._popularity_list_daily_times_plan = content
	elseif name == "year_version" then
		self._yearVersionCfgs = content
	end
end

function PopularityListConfig:getPlActData(activityId)
	return self._actCfg[activityId]
end

function PopularityListConfig:getPlCommonData(activityId)
	local actData = self:getPlActData(activityId)

	if actData then
		return self._commonCfg[actData.comPlanId]
	end
end

function PopularityListConfig:getPlCommonValue(activityId, key)
	local data = self:getPlCommonData(activityId)

	if data then
		return data[key]
	end
end

function PopularityListConfig:getPlBaseCfg(activityId)
	return self._baseCfgs[activityId]
end

function PopularityListConfig:getPlBaseData(activityId, m_type)
	return self._baseCfgs[activityId][m_type]
end

function PopularityListConfig:getDailyVotePlanData(planId)
	return self._popularity_list_daily_times_plan[planId]
end

function PopularityListConfig:getVipVotePlanData(planId, lvl)
	if self._popularity_list_vip_times_plan[planId] then
		return self._popularity_list_vip_times_plan[planId][lvl]
	end
end

function PopularityListConfig:getPlItemeCfg(activityId)
	return self._itemCfgs[activityId]
end

function PopularityListConfig:getPlItemData(activityId, id)
	return self._itemCfgs[activityId][id]
end

function PopularityListConfig:_handleItemDataList(dataList)
	self._itemCfgsByType = {}

	for _, data in ipairs(dataList) do
		if self._itemCfgsByType[data.activityId] == nil then
			self._itemCfgsByType[data.activityId] = {}
		end

		if self._itemCfgsByType[data.activityId][data.type] == nil then
			self._itemCfgsByType[data.activityId][data.type] = {}
		end

		table.insert(self._itemCfgsByType[data.activityId][data.type], data)
	end
end

function PopularityListConfig:getPlItemCfgByType(activityId, m_type)
	return self._itemCfgsByType[activityId][m_type]
end

function PopularityListConfig:getPlItemDetailData(skinId)
	return self._itemDetailCfg[skinId]
end

function PopularityListConfig:getTextValue(key, ...)
	local params = {
		...
	}

	return #params > 0 and string.format(self._textCfg[key].value, unpack(params)) or self._textCfg[key].value
end

function PopularityListConfig:getPlYearVersionCfg(activityId)
	return self._yearVersionCfgs[activityId]
end

function PopularityListConfig:getPlYearVersionData(activityId, versionId)
	if self._yearVersionCfgs[activityId] then
		return self._yearVersionCfgs[activityId][versionId]
	end
end

PopularityListConfig.instance = PopularityListConfig.New()

return PopularityListConfig
