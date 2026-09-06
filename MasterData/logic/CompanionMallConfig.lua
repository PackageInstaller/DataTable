-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/config/CompanionMallConfig.lua

module("logic.extensions.companionmall.config.CompanionMallConfig", package.seeall)

local CompanionMallConfig = class("CompanionMallConfig", BaseConfig)

function CompanionMallConfig:getNames()
	return {
		"companion_mall_task",
		"companion_mall_activity",
		"companion_mall_item",
		"companion_mall_preview",
		"address_province",
		"address_city",
		"address_district",
		"companion_mall_select_pack",
		"companion_mall_pack_show"
	}
end

function CompanionMallConfig:handleConfig(name, content)
	if name == "companion_mall_task" then
		self._companion_mall_task = content
	elseif name == "companion_mall_activity" then
		self._companion_mall_activity = content
	elseif name == "companion_mall_item" then
		self._companion_mall_item = content

		self:_initItemGroupDic(content.dataList)
	elseif name == "companion_mall_preview" then
		self._companion_mall_preview = content
	elseif name == "address_province" then
		self._address_province = content

		self:_initProvinceDic(content.dataList)
	elseif name == "address_city" then
		self._address_city = content

		self:_initCityDic(content.dataList)
	elseif name == "address_district" then
		self._address_district = content

		self:_initDirectDic(content.dataList)
	elseif name == "companion_mall_pack_show" then
		self._companion_mall_pack_show = content

		self:_initPackShowDic(content.dataList)
	elseif name == "companion_mall_select_pack" then
		self._companion_mall_select_pack = content

		self:_initSelectPackDic(content.dataList)
	end
end

function CompanionMallConfig:getActivityCfgById(id)
	return self._companion_mall_activity[id]
end

function CompanionMallConfig:getTaskCfgById(activityId, companionId)
	if self._companion_mall_task[activityId] then
		return self._companion_mall_task[activityId][companionId]
	end
end

function CompanionMallConfig:getTaskCfgByTaskId(activityId, companionId, taskId)
	if self._companion_mall_task[activityId] and self._companion_mall_task[activityId][companionId] then
		return self._companion_mall_task[activityId][companionId][taskId]
	end
end

function CompanionMallConfig:getItemCfgs(activityId)
	return self._companion_mall_item[activityId]
end

function CompanionMallConfig:getItemCfgById(activityId, companionId)
	if self._companion_mall_item[activityId] then
		return self._companion_mall_item[activityId][companionId]
	end
end

function CompanionMallConfig:getPreviewCfg(activityId)
	return self._companion_mall_preview[activityId]
end

function CompanionMallConfig:_initProvinceDic(dataList)
	self._provinceNameIdDic = {}

	for i, cfg in ipairs(dataList) do
		self._provinceNameIdDic[cfg.province] = cfg.provinceCode
	end
end

function CompanionMallConfig:_initCityDic(dataList)
	self._cityDic = {}
	self._cityNameIdDic = {}

	for i, cfg in ipairs(dataList) do
		local provinceCode = math.floor(cfg.cityCode / 100)
		local cityList = self._cityDic[provinceCode]

		if cityList == nil then
			cityList = {}
			self._cityDic[provinceCode] = cityList
		end

		table.insert(cityList, cfg)

		self._cityNameIdDic[cfg.city] = cfg.cityCode
	end
end

function CompanionMallConfig:_initDirectDic(dataList)
	self._districtDic = {}
	self._districtNameIdDic = {}

	for i, cfg in ipairs(dataList) do
		local cityCode = math.floor(cfg.districtCode / 100)
		local zoneList = self._districtDic[cityCode]

		if zoneList == nil then
			zoneList = {}
			self._districtDic[cityCode] = zoneList
		end

		table.insert(zoneList, cfg)

		self._districtNameIdDic[cfg.city] = cfg.districtCode
	end
end

function CompanionMallConfig:getProvinceCfgs()
	return self._address_province.dataList
end

function CompanionMallConfig:getCityDic()
	return self._cityDic
end

function CompanionMallConfig:getDistrictDic()
	return self._districtDic
end

function CompanionMallConfig:getProvinceIdByProvince(provinceStr)
	return self._provinceNameIdDic[provinceStr]
end

function CompanionMallConfig:getCityIdByCity(cityStr)
	return self._cityNameIdDic[cityStr]
end

function CompanionMallConfig:getDirectIdByDirect(directStr)
	return self._districtNameIdDic[directStr]
end

function CompanionMallConfig:_initPackShowDic(dataList)
	self._packShowDic = {}

	for i, cfg in ipairs(dataList) do
		local activityId = cfg.activityId
		local groupId = cfg.groupId
		local sortId = cfg.sortId

		if self._packShowDic[activityId] == nil then
			self._packShowDic[activityId] = {}
		end

		if self._packShowDic[activityId][groupId] == nil then
			self._packShowDic[activityId][groupId] = {}
		end

		self._packShowDic[activityId][groupId][sortId] = cfg
	end
end

function CompanionMallConfig:getPackShowCfg(activityId, groupId, sortId)
	if self._packShowDic[activityId] and self._packShowDic[activityId][groupId] then
		return self._packShowDic[activityId][groupId][sortId]
	end
end

function CompanionMallConfig:getPackShowCfgsByGroupId(activityId, groupId)
	if self._packShowDic[activityId] then
		return self._packShowDic[activityId][groupId]
	end
end

function CompanionMallConfig:_initSelectPackDic(dataList)
	self._selectPackDic = {}

	for i, cfg in ipairs(dataList) do
		local activityId = cfg.activityId
		local selectPackId = cfg.selectPackId

		if self._selectPackDic[activityId] == nil then
			self._selectPackDic[activityId] = {}
		end

		self._selectPackDic[activityId][selectPackId] = cfg
	end
end

function CompanionMallConfig:getSelectPackCfg(activityId, selectPackId)
	if self._selectPackDic[activityId] then
		return self._selectPackDic[activityId][selectPackId]
	end
end

function CompanionMallConfig:_initItemGroupDic(dataList)
	self._itemGroupDic = {}

	for i, cfg in ipairs(dataList) do
		local activityId = cfg.activityId
		local packGroupId = cfg.packGroupId

		if packGroupId > 0 then
			if self._itemGroupDic[activityId] == nil then
				self._itemGroupDic[activityId] = {}
			end

			if self._itemGroupDic[activityId][packGroupId] == nil then
				self._itemGroupDic[activityId][packGroupId] = {}
			end

			table.insert(self._itemGroupDic[activityId][packGroupId], cfg)
		end
	end
end

function CompanionMallConfig:getItemGroupCfgs(activityId, packGroupId)
	if self._itemGroupDic[activityId] then
		return self._itemGroupDic[activityId][packGroupId]
	end
end

function CompanionMallConfig:getItemGroupIds(activityId)
	local groupIdList = {}

	if self._itemGroupDic[activityId] then
		for groupId, _ in pairs(self._itemGroupDic[activityId]) do
			table.insert(groupIdList, groupId)
		end
	end

	return groupIdList
end

CompanionMallConfig.instance = CompanionMallConfig.New()

return CompanionMallConfig
