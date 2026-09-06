-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redstargodsell/config/RedstargodsellConfig.lua

module("logic.extensions.redstargodsell.config.RedstargodsellConfig", package.seeall)

local RedstargodsellConfig = class("RedstargodsellConfig", BaseConfig)

function RedstargodsellConfig:onInit()
	RedstargodsellConfig.super.onInit(self)

	self._saleCfg = nil
end

function RedstargodsellConfig:getNames()
	return {
		"monopoly_sale"
	}
end

function RedstargodsellConfig:handleConfig(name, content)
	if name == "monopoly_sale" then
		self._saleCfg = content
	end
end

function RedstargodsellConfig:getSaleCfg(actId, giftId)
	return self._saleCfg[actId][giftId]
end

RedstargodsellConfig.instance = RedstargodsellConfig.New()

return RedstargodsellConfig
