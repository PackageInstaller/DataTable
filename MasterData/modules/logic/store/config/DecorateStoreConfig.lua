-- chunkname: @modules/logic/store/config/DecorateStoreConfig.lua

module("modules.logic.store.config.DecorateStoreConfig", package.seeall)

local DecorateStoreConfig = class("DecorateStoreConfig", BaseConfig)

function DecorateStoreConfig:ctor()
	self._storeDecorateConfig = nil
end

function DecorateStoreConfig:reqConfigNames()
	return {
		"store_decorate"
	}
end

function DecorateStoreConfig:onConfigLoaded(configName, configTable)
	if configName == "store_decorate" then
		self._storeDecorateConfig = configTable
	end
end

function DecorateStoreConfig:getDecorateConfig(goodId)
	return self._storeDecorateConfig.configDict[goodId]
end

function DecorateStoreConfig:getBundleGoodsIdList(goodId)
	local goodIdList = {}

	for k, v in pairs(self._storeDecorateConfig.configDict) do
		if v.fatherGoods == goodId then
			table.insert(goodIdList, v)
		end
	end

	return goodIdList
end

DecorateStoreConfig.instance = DecorateStoreConfig.New()

return DecorateStoreConfig
