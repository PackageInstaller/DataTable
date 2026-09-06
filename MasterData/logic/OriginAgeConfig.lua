-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originage/config/OriginAgeConfig.lua

module("logic.extensions.originage.config.OriginAgeConfig", package.seeall)

local OriginAgeConfig = class("OriginAgeConfig", BaseConfig)

function OriginAgeConfig:getNames()
	return {
		"origin_age_launch_prize",
		"origin_age_launch_activity",
		"origin_age_launch_show"
	}
end

function OriginAgeConfig:handleConfig(name, content)
	if name == "origin_age_launch_prize" then
		self._origin_age_launch_prize = content
	elseif name == "origin_age_launch_activity" then
		self._origin_age_launch_activity = content
	elseif name == "origin_age_launch_show" then
		self._origin_age_launch_show = content
	end
end

function OriginAgeConfig:getActivityCfgById(id)
	return self._origin_age_launch_activity[id]
end

function OriginAgeConfig:getPrizeyCfgById(id, key)
	if self._origin_age_launch_prize[id] then
		return self._origin_age_launch_prize[id][key]
	end
end

function OriginAgeConfig:getShowCfg(showPlanId)
	return self._origin_age_launch_show[showPlanId]
end

function OriginAgeConfig:getShowData(showPlanId, id)
	if self._origin_age_launch_show[showPlanId] then
		return self._origin_age_launch_show[showPlanId][id]
	end
end

OriginAgeConfig.instance = OriginAgeConfig.New()

return OriginAgeConfig
