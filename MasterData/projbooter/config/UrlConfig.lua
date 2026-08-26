-- chunkname: @projbooter/config/UrlConfig.lua

module("projbooter.config.UrlConfig", package.seeall)

local UrlConfig = class("UrlConfig")

function UrlConfig.getConfig()
	if not UrlConfig._config then
		local cfg = GameConfig.UrlCfg

		logNormal("UrlConfig.getConfig() =\n " .. cfg)

		UrlConfig._config = cjson.decode(cfg)
	end

	return UrlConfig._config
end

return UrlConfig
