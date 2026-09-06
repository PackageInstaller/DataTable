-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gashapon/config/GashaponConfig.lua

module("logic.extensions.gashapon.config.GashaponConfig", package.seeall)

local GashaponConfig = class("GashaponConfig", BaseConfig)

function GashaponConfig:onInit()
	GashaponConfig.super.onInit(self)

	self._gashaponCostCfg = nil
	self._gashaponPrizeCfg = nil
end

function GashaponConfig:getNames()
	return {
		"gashapon_activity",
		"gashapon_prize"
	}
end

function GashaponConfig:handleConfig(name, content)
	if name == "gashapon_activity" then
		self._gashaponCostCfg = content
	elseif name == "gashapon_prize" then
		self._gashaponPrizeCfg = content
	end
end

function GashaponConfig:getCfgById(id)
	return self._gashaponCostCfg[id]
end

function GashaponConfig:getPrizeById(pool, id)
	return self._gashaponPrizeCfg[pool][id]
end

GashaponConfig.instance = GashaponConfig.New()

return GashaponConfig
