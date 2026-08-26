-- chunkname: @modules/logic/toast/config/ToastConfig.lua

module("modules.logic.toast.config.ToastConfig", package.seeall)

local ToastConfig = class("ToastConfig", BaseConfig)

function ToastConfig:ctor()
	self.toastConfig = nil
end

function ToastConfig:reqConfigNames()
	return {
		"toast"
	}
end

function ToastConfig:onConfigLoaded(configName, configTable)
	if configName == "toast" then
		self.toastConfig = configTable
	end
end

function ToastConfig:getToastCO(id)
	return self.toastConfig.configDict[id]
end

ToastConfig.instance = ToastConfig.New()

return ToastConfig
