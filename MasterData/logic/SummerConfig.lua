-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summer/config/SummerConfig.lua

module("logic.extensions.summer.config.SummerConfig", package.seeall)

local SummerConfig = class("SummerConfig", BaseConfig)

function SummerConfig:onInit()
	SummerConfig.super.onInit(self)

	self._SummerCostCfg = nil
	self._SummerPrizeCfg = nil
end

function SummerConfig:getNames()
	return {}
end

function SummerConfig:handleConfig(name, content)
	return
end

function SummerConfig:getCfgById(id)
	return self._SummerCostCfg[id]
end

function SummerConfig:getPrizeById(pool, id)
	return self._SummerPrizeCfg[pool][id]
end

SummerConfig.instance = SummerConfig.New()

return SummerConfig
