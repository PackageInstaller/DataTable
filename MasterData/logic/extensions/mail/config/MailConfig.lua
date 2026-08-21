-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mail/config/MailConfig.lua

module("logic.extensions.mail.config.MailConfig", package.seeall)

local M = class("MailConfig", BaseConfig)

function M:getNames()
	return {
		ConfigName.Mail
	}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

function M:getMailConfig(key)
	local cfg = self:getConfig(ConfigName.Mail)

	if cfg then
		return cfg[key]
	end

	printError(string.format("no config with name: t_%s", cfgName))
end

M.instance = M.New()

return M
