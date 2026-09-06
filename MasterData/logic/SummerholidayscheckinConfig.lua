-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerholidayscheckin/config/SummerholidayscheckinConfig.lua

module("logic.extensions.summerholidayscheckin.config.SummerholidayscheckinConfig", package.seeall)

local SummerholidayscheckinConfig = class("SummerholidayscheckinConfig", BaseConfig)

function SummerholidayscheckinConfig:onInit()
	return
end

function SummerholidayscheckinConfig:getNames()
	return {
		"summer_holidays_check_in",
		"summer_holidays_check_in_prize"
	}
end

function SummerholidayscheckinConfig:handleConfig(name, content)
	if name == "summer_holidays_check_in" then
		self._summer_holidays_check_in = content
	elseif name == "summer_holidays_check_in_prize" then
		self._summer_holidays_check_in_prize = content
	end
end

function SummerholidayscheckinConfig:getPrizeCfgs(activityId)
	return self._summer_holidays_check_in_prize[activityId]
end

function SummerholidayscheckinConfig:getActCfg(activityId)
	return self._summer_holidays_check_in[activityId]
end

SummerholidayscheckinConfig.instance = SummerholidayscheckinConfig.New()

return SummerholidayscheckinConfig
