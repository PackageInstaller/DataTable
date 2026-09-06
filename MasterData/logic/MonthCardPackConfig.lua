-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcardspack/config/MonthCardPackConfig.lua

module("logic.extensions.monthcardspack.config.MonthCardPackConfig", package.seeall)

local MonthCardPackConfig = class("MonthCardPackConfig", BaseConfig)

function MonthCardPackConfig:getNames()
	return {
		"month_card_pack"
	}
end

function MonthCardPackConfig:handleConfig(name, content)
	if name == "month_card_pack" then
		self._monthCardPackCfg = content
	end
end

function MonthCardPackConfig:getActivities()
	return self._monthCardPackCfg.dataList
end

function MonthCardPackConfig:getActivityCo(activityId)
	return self._monthCardPackCfg[activityId]
end

MonthCardPackConfig.instance = MonthCardPackConfig.New()

return MonthCardPackConfig
