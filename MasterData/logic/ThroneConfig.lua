-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/throne/config/ThroneConfig.lua

module("logic.extensions.throne.config.ThroneConfig", package.seeall)

local ThroneConfig = class("ThroneConfig", BaseConfig)

function ThroneConfig:onInit()
	return
end

function ThroneConfig:getNames()
	return {
		"throne_config",
		"throne_lv_strategy",
		"throne_achievement_config",
		"throne_common_config"
	}
end

function ThroneConfig:handleConfig(name, content)
	if name == "throne_config" then
		self._throne_config = content
		self._throne_configShowType = {}

		for k, v in ipairs(content.dataList) do
			self._throne_configShowType[v.showType] = self._throne_configShowType[v.showType] or {}

			table.insert(self._throne_configShowType[v.showType], v)
		end
	elseif name == "throne_lv_strategy" then
		self._throne_lv_strategy = content
	elseif name == "throne_achievement_config" then
		self._throne_achievement_config = content
	elseif name == "throne_common_config" then
		self._throne_common_config = content
	end
end

function ThroneConfig:getThroneCfgs()
	return self._throne_config.dataList
end

function ThroneConfig:getThroneCfg(id)
	return self._throne_config[id]
end

function ThroneConfig:getThroneByShowType(id)
	if id == GameEnum.ThroneTabType.All then
		return self._throne_config.dataList
	end

	return self._throne_configShowType[id] or {}
end

function ThroneConfig:getAchievementCfgs()
	return self._throne_achievement_config
end

function ThroneConfig:getDailyPrizeStr()
	return self._throne_common_config.DAILY_PRIZE.value
end

function ThroneConfig:getLvStrategyCfg(id)
	return self._throne_lv_strategy[id]
end

ThroneConfig.instance = ThroneConfig.New()

return ThroneConfig
