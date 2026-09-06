-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendten/config/GoldendTenConfig.lua

module("logic.extensions.goldendten.config.GoldendTenConfig", package.seeall)

local GoldendTenConfig = class("GoldendTenConfig", BaseConfig)

function GoldendTenConfig:onInit()
	GoldendTenConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function GoldendTenConfig:getNames()
	return {
		"golden_ten_activity",
		"golden_ten_prize"
	}
end

function GoldendTenConfig:handleConfig(name, content)
	if name == "golden_ten_activity" then
		self._actCfgs = content
	elseif name == "golden_ten_prize" then
		self._prizeCfgs = content
	end
end

function GoldendTenConfig:getActCfgById(id)
	return self._actCfgs[id]
end

function GoldendTenConfig:getPrizeCfgsById(id)
	return self._prizeCfgs[id]
end

GoldendTenConfig.instance = GoldendTenConfig.New()

return GoldendTenConfig
