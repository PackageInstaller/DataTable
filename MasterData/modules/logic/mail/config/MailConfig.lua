-- chunkname: @modules/logic/mail/config/MailConfig.lua

module("modules.logic.mail.config.MailConfig", package.seeall)

local MailConfig = class("MailConfig", BaseConfig)

function MailConfig:ctor()
	self._mailConfig = nil
end

function MailConfig:reqConfigNames()
	return {
		"mail"
	}
end

function MailConfig:onConfigLoaded(configName, configTable)
	if configName == "mail" then
		self._mailConfig = configTable
	end
end

function MailConfig:getCategoryCO()
	return self._mailConfig.configDict
end

function MailConfig:getPropDetailCO(mailid)
	return self._mailConfig.configDict[mailid]
end

MailConfig.instance = MailConfig.New()

return MailConfig
