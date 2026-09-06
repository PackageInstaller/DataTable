-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/config/HDZeropayConfig.lua

module("logic.extensions.zeropay.config.HDZeropayConfig", package.seeall)

local HDZeropayConfig = class("HDZeropayConfig", BaseConfig)

function HDZeropayConfig:onInit()
	return
end

function HDZeropayConfig:getNames()
	return {
		"new_zero_pay"
	}
end

function HDZeropayConfig:handleConfig(name, content)
	if name == "new_zero_pay" then
		self.new_zero_payCfg = content
	end
end

function HDZeropayConfig:getNewActCfg(actId, giftId)
	if self.new_zero_payCfg[actId] and self.new_zero_payCfg[actId][giftId] then
		return self.new_zero_payCfg[actId][giftId]
	end
end

HDZeropayConfig.instance = HDZeropayConfig.New()

return HDZeropayConfig
