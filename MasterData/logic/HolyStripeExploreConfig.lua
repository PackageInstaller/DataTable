-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripeexplore/config/HolyStripeExploreConfig.lua

module("logic.extensions.holystripeexplore.config.HolyStripeExploreConfig", package.seeall)

local HolyStripeExploreConfig = class("HolyStripeExploreConfig", BaseConfig)

function HolyStripeExploreConfig:onInit()
	HolyStripeExploreConfig.super.onInit(self)
end

function HolyStripeExploreConfig:getNames()
	return {
		"ling_wen_explore_prize",
		"ling_wen_explore_map",
		"ling_wen_explore_number",
		"ling_wen_explore_param",
		"ling_wen_explore_speed"
	}
end

function HolyStripeExploreConfig:handleConfig(name, content)
	if name == "ling_wen_explore_prize" then
		self._prizeCfgs = content
	elseif name == "ling_wen_explore_map" then
		self._mapCfgs = content
	elseif name == "ling_wen_explore_number" then
		self._numberCfgs = content
	elseif name == "ling_wen_explore_speed" then
		self._speedCfgs = content
	elseif name == "ling_wen_explore_param" then
		self._commonCfgs = content
	end
end

function HolyStripeExploreConfig:getPrizeCfgById(id)
	return self._prizeCfgs[id]
end

function HolyStripeExploreConfig:getMapCfgById(id)
	return self._mapCfgs[id]
end

function HolyStripeExploreConfig:getSpeedById(id)
	return (self._speedCfgs[id] or nil) and (self._speedCfgs[id] or 1)
end

function HolyStripeExploreConfig:getCommonValue(key)
	if self._commonCfgs[key] then
		return self._commonCfgs[key].value
	end
end

function HolyStripeExploreConfig:getNumberListById(id)
	local dataList = {}
	local cfg = self._numberCfgs[id]

	if cfg then
		for i = 1, cfg.num1 do
			table.insert(dataList, 1)
		end

		for i = 1, cfg.num2 do
			table.insert(dataList, 2)
		end

		for i = 1, cfg.num3 do
			table.insert(dataList, 3)
		end

		for i = 1, cfg.num4 do
			table.insert(dataList, 4)
		end

		for i = 1, cfg.num5 do
			table.insert(dataList, 5)
		end

		for i = 1, cfg.num4 do
			table.insert(dataList, 6)
		end
	end

	return dataList
end

HolyStripeExploreConfig.instance = HolyStripeExploreConfig.New()

return HolyStripeExploreConfig
