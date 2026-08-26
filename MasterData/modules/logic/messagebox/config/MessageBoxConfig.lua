-- chunkname: @modules/logic/messagebox/config/MessageBoxConfig.lua

module("modules.logic.messagebox.config.MessageBoxConfig", package.seeall)

local MessageBoxConfig = class("MessageBoxConfig", BaseConfig)

function MessageBoxConfig:ctor()
	self._messageBoxConfig = nil
end

function MessageBoxConfig:reqConfigNames()
	return {
		"messagebox"
	}
end

function MessageBoxConfig:onConfigLoaded(configName, configTable)
	if configName == "messagebox" then
		self._messageBoxConfig = configTable
	end
end

function MessageBoxConfig:getMessageBoxCO(id)
	return self._messageBoxConfig.configDict[id]
end

function MessageBoxConfig:getMessage(id)
	local messageBoxConfig = self:getMessageBoxCO(id)

	if not messageBoxConfig then
		logError("找不到弹窗配置, id: " .. tostring(id))
	end

	return (messageBoxConfig or nil) and (messageBoxConfig.content or "")
end

function MessageBoxConfig:getMessageTitle(id)
	local messageBoxConfig = self:getMessageBoxCO(id)

	if not messageBoxConfig then
		logError("找不到弹窗标题配置, id: " .. tostring(id))
	end

	return (messageBoxConfig or nil) and (messageBoxConfig.title or "")
end

MessageBoxConfig.instance = MessageBoxConfig.New()

return MessageBoxConfig
