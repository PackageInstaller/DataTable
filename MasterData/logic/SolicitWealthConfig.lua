-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/solicitwealth/config/SolicitWealthConfig.lua

module("logic.extensions.solicitwealth.config.SolicitWealthConfig", package.seeall)

local SolicitWealthConfig = class("SolicitWealthConfig", BaseConfig)

SolicitWealthConfig.SWITCHVIEW = "SolicitWealthConfig.SWITCHVIEW"
SolicitWealthConfig.UNLOCK = "SolicitWealthConfig.UNLOCK"

function SolicitWealthConfig:onInit()
	SolicitWealthConfig.super.onInit(self)
end

function SolicitWealthConfig:getNames()
	return {
		"money_cat_config",
		"money_cat_prize",
		"money_cat_level"
	}
end

function SolicitWealthConfig:handleConfig(name, content)
	if name == "money_cat_config" then
		self._moneyCatConfig = content
	elseif name == "money_cat_prize" then
		self._moneyCatPrize = content
	elseif name == "money_cat_level" then
		self._moneyCatLevel = content
	end
end

function SolicitWealthConfig:getConfig()
	return self._moneyCatConfig
end

function SolicitWealthConfig:getConfigByKey(key)
	return self._moneyCatConfig[key].value
end

function SolicitWealthConfig:getPrize()
	return self._moneyCatPrize
end

function SolicitWealthConfig:getPrizeById(id)
	return self._moneyCatPrize[id]
end

function SolicitWealthConfig:getLevel()
	return self._moneyCatLevel
end

function SolicitWealthConfig:getLevelById(id)
	return self._moneyCatLevel[id]
end

SolicitWealthConfig.instance = SolicitWealthConfig.New()

return SolicitWealthConfig
