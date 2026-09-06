-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zeropay/config/ZeropayConfig.lua

module("logic.extensions.zeropay.config.ZeropayConfig", package.seeall)

local ZeropayConfig = class("ZeropayConfig", BaseConfig)

function ZeropayConfig:onInit()
	return
end

function ZeropayConfig:getNames()
	return {
		"zero_pay"
	}
end

function ZeropayConfig:handleConfig(name, content)
	if name == "zero_pay" then
		self._zero_payCfg = content
	end
end

function ZeropayConfig:getCfg(actId, giftId)
	return self._zero_payCfg[actId][giftId]
end

ZeropayConfig.instance = ZeropayConfig.New()

return ZeropayConfig
