-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/social/config/SocialConfig.lua

module("logic.extensions.social.config.SocialConfig", package.seeall)

local SocialConfig = class("SocialConfig", BaseConfig)

function SocialConfig:onInit()
	SocialConfig.super.onInit(self)

	self._cofigtemplateCfg = nil
end

function SocialConfig:getNames()
	return {
		"mail_template",
		"mail_other_config"
	}
end

function SocialConfig:handleConfig(name, content)
	if name == "mail_template" then
		self._cofigtemplateCfg = content
	elseif name == "mail_other_config" then
		self._mail_other_config = content
	end
end

function SocialConfig:getCfgById(id)
	return self._cofigtemplateCfg[id]
end

function SocialConfig:getConfigCfgByKey(key)
	local obj = self._mail_other_config[key]

	if obj then
		return obj.value
	end

	return nil
end

SocialConfig.instance = SocialConfig.New()

return SocialConfig
