-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cashback/config/CashBackConfig.lua

module("logic.extensions.cashback.config.CashBackConfig", package.seeall)

local CashBackConfig = class("CashBackConfig", BaseConfig)

function CashBackConfig:onInit()
	CashBackConfig.super.onInit(self)
end

function CashBackConfig:getNames()
	return {
		"cash_back_prize",
		"cash_back_activity"
	}
end

function CashBackConfig:handleConfig(name, content)
	if name == "cash_back_prize" then
		self._prizeCfgs = content
	elseif name == "cash_back_activity" then
		self._actCfg = content
	end
end

function CashBackConfig:getPrizeCfgByActId(actId)
	return self._prizeCfgs[actId]
end

function CashBackConfig:getActCfgById(actId)
	return self._actCfg[actId]
end

CashBackConfig.instance = CashBackConfig.New()

return CashBackConfig
