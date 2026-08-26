-- chunkname: @modules/logic/store/config/DecorateStoreConfig.lua

module("modules.logic.store.config.DecorateStoreConfig", package.seeall)

local DecorateStoreConfig = class("DecorateStoreConfig", BaseConfig)

function DecorateStoreConfig:ctor()
	self._storeDecorateConfig = nil
end

function DecorateStoreConfig:reqConfigNames()
	return {
		"store_decorate",
		"store_bundle"
	}
end

function DecorateStoreConfig:onConfigLoaded(configName, configTable)
	if configName == "store_decorate" then
		self._storeDecorateConfig = configTable
	elseif configName == "store_bundle" then
		self:_onLoadStoreBundleConfig(configTable)
	end
end

function DecorateStoreConfig:getDecorateConfig(goodId)
	return self._storeDecorateConfig.configDict[goodId]
end

function DecorateStoreConfig:_onLoadStoreBundleConfig(configTable)
	self._sonGoodsIdList = {}
	self._sonGoodsId2FatherId = {}

	for _, bundleCo in ipairs(configTable.configList) do
		local sonGoodsIdList = string.splitToNumber(bundleCo.sonGoods, "|")

		self._sonGoodsIdList[bundleCo.fatherGoods] = sonGoodsIdList

		for _, sonGoodsId in ipairs(sonGoodsIdList) do
			self._sonGoodsId2FatherId[sonGoodsId] = bundleCo.fatherGoods
		end
	end
end

function DecorateStoreConfig:getSonGoodsIdList(goodsId)
	return self._sonGoodsIdList and self._sonGoodsIdList[goodsId]
end

function DecorateStoreConfig:isFatherOrSonGoods(goodsId)
	return lua_store_bundle.configDict[goodsId] ~= nil or self._sonGoodsId2FatherId[goodsId] ~= nil
end

function DecorateStoreConfig:getFatherGoodsId(goodsId)
	if lua_store_bundle.configDict[goodsId] ~= nil then
		return goodsId
	end

	return self._sonGoodsId2FatherId[goodsId]
end

DecorateStoreConfig.instance = DecorateStoreConfig.New()

return DecorateStoreConfig
