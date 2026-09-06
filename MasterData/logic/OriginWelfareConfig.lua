-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originwelfare/config/OriginWelfareConfig.lua

module("logic.extensions.originwelfare.config.OriginWelfareConfig", package.seeall)

local OriginWelfareConfig = class("OriginWelfareConfig", BaseConfig)

function OriginWelfareConfig:onInit()
	OriginWelfareConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function OriginWelfareConfig:getNames()
	return {
		"origin_welfare_activity",
		"origin_welfare_redgod_jumpto"
	}
end

function OriginWelfareConfig:handleConfig(name, content)
	if name == "origin_welfare_activity" then
		self._origin_welfare_activity = content
	elseif name == "origin_welfare_redgod_jumpto" then
		self._origin_welfare_redgod_jumpto = content
	end
end

function OriginWelfareConfig:getActCfg(activityId)
	return self._origin_welfare_activity[activityId]
end

function OriginWelfareConfig:getRedGodJumpToCfgs(activityId)
	return self._origin_welfare_redgod_jumpto[activityId]
end

OriginWelfareConfig.instance = OriginWelfareConfig.New()

return OriginWelfareConfig
