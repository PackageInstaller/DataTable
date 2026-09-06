-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/arena/config/GoodsConfig.lua

module("logic.extensions.arena.config.GoodsConfig", package.seeall)

local GoodsConfig = class("GoodsConfig", BaseConfig)

function GoodsConfig:onInit()
	GoodsConfig.super.onInit(self)

	self._goods = nil
end

function GoodsConfig:getNames()
	return {
		"goods"
	}
end

function GoodsConfig:handleConfig(name, content)
	if name == "goods" then
		self._goods = content
	end
end

function GoodsConfig:getCfg(id)
	return self._goods[id]
end

function GoodsConfig:getCfgPrice(id)
	local cfg = self:getCfg(id)

	if cfg then
		return cfg.price
	end

	return 0
end

GoodsConfig.instance = GoodsConfig.New()

return GoodsConfig
