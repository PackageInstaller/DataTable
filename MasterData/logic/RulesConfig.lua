-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rules/config/RulesConfig.lua

module("logic.extensions.rules.config.RulesConfig", package.seeall)

local RulesConfig = class("RulesConfig", BaseConfig)

function RulesConfig:getNames()
	return {
		"rules",
		"rules_img"
	}
end

function RulesConfig:handleConfig(name, content)
	if name == "rules" then
		self._rules = content
	elseif name == "rules_img" then
		self._rules_img = content
	end
end

function RulesConfig:getRuleCo(key)
	return self._rules[key]
end

function RulesConfig:getRuleImgCfg(key)
	return self._rules_img[key]
end

RulesConfig.instance = RulesConfig.New()

return RulesConfig
