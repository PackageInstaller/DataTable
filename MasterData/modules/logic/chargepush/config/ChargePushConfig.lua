-- chunkname: @modules/logic/chargepush/config/ChargePushConfig.lua

module("modules.logic.chargepush.config.ChargePushConfig", package.seeall)

local ChargePushConfig = class("ChargePushConfig", BaseConfig)

function ChargePushConfig:ctor()
	return
end

function ChargePushConfig:reqConfigNames()
	return {
		"store_push_goods"
	}
end

function ChargePushConfig:onConfigLoaded(configName, configTable)
	if configName == "store_push_goods" then
		self._chargePushGoodsConfig = configTable
	end
end

function ChargePushConfig:getPushGoodsConfig(id)
	local co = self._chargePushGoodsConfig.configDict[id]

	if not co then
		logError(string.format("chargepushgoods config is nil, id:%s", id))
	end

	return co
end

ChargePushConfig.instance = ChargePushConfig.New()

return ChargePushConfig
