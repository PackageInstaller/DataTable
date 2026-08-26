-- chunkname: @modules/logic/store/config/StoreConfig.lua

module("modules.logic.store.config.StoreConfig", package.seeall)

local StoreConfig = class("StoreConfig", BaseConfig)

function StoreConfig:ctor()
	self._storeEntranceConfig = nil
	self._storeGoodsConfig = nil
	self._storeRecommendConfig = nil
	self._storeConfig = nil
	self._storeChargeConfig = nil
	self._storeChargeGoodsConfig = nil
	self._dailyReleasePackageCfg = nil
	self._storeMonthAddCfg = nil
	self._critterStoreGoods = {}
	self._preGoodsIdDict = nil
	self._decorateProduct2GoodsId = {}
	self._roomProduct2GoodsId = {}
	self._configPriceKey = "price"
	self._configBasePriceKey = "price"
	self._configCurrencyCodeKey = "currencyCode"
	self._configOriginalCostKey = "originalCost"

	if GameChannelConfig.isLongCheng() then
		self._configBasePriceKey = "pricekr"
		self._configPriceKey = "pricekr"
		self._configCurrencyCodeKey = "currencyCodekr"
		self._configOriginalCostKey = "originalCostkr"
	elseif GameChannelConfig.isGpJapan() then
		self._configBasePriceKey = "pricejp"
		self._configPriceKey = "pricejp"
		self._configCurrencyCodeKey = "currencyCodejp"
		self._configOriginalCostKey = "originalCostjp"
	end

	self._storeChargeConditional2GoodsId = nil
end

function StoreConfig:reqConfigNames()
	return {
		"store_entrance",
		"store_goods",
		"store",
		"store_recommend",
		"store_charge",
		"store_charge_goods",
		"month_card",
		"slow_release_gift",
		"store_charge_optional",
		"month_card_added",
		"store_charge_conditional"
	}
end

function StoreConfig:onConfigLoaded(configName, configTable)
	if configName == "store_entrance" then
		self._storeEntranceConfig = configTable
	elseif configName == "store_goods" then
		self._storeGoodsConfig = configTable

		self:initPreGoodsIdDict(configTable)
	elseif configName == "store" then
		self._storeConfig = configTable
	elseif configName == "store_recommend" then
		self._storeRecommendConfig = configTable
	elseif configName == "store_charge" then
		self._storeChargeConfig = configTable
	elseif configName == "store_charge_goods" then
		self:initStoreChargeGoodsConfig(configTable)
	elseif configName == "month_card" then
		self._monthCardConfig = configTable
	elseif configName == "slow_release_gift" then
		self._dailyReleasePackageCfg = configTable
	elseif configName == "store_charge_optional" then
		self._chargeOptionalConfig = configTable
	elseif configName == "month_card_added" then
		self._storeMonthAddCfg = configTable
	elseif configName == "store_charge_conditional" then
		self._storeChargeConditionalConfig = configTable
	end
end

function StoreConfig:initPreGoodsIdDict(configTable)
	self._preGoodsIdDict = {}
	self._roomProduct2GoodsId = {}

	for id, cfg in pairs(configTable.configDict) do
		if cfg.preGoodsId ~= 0 then
			self._preGoodsIdDict[cfg.preGoodsId] = id
		end

		local storeId = tonumber(cfg.storeId)

		if storeId == StoreEnum.StoreId.NewRoomStore or storeId == StoreEnum.StoreId.OldRoomStore then
			local roomProductType, roomProductId
			local arr = GameUtil.splitString2(cfg.product, true)

			if arr and #arr == 1 then
				local productItem = arr[1]
				local type = productItem[1]

				if type == MaterialEnum.MaterialType.Building or type == MaterialEnum.MaterialType.BlockPackage then
					roomProductType = type
					roomProductId = productItem[2]
				end
			end

			if roomProductType and roomProductId then
				local product2GoodsIdDict = self._roomProduct2GoodsId[roomProductType]

				if not product2GoodsIdDict then
					product2GoodsIdDict = {}
					self._roomProduct2GoodsId[roomProductType] = product2GoodsIdDict
				end

				product2GoodsIdDict[roomProductId] = cfg.id
			end
		elseif storeId == StoreEnum.StoreId.CritterStore then
			local arr = string.splitToNumber(cfg.product, "#")

			self._critterStoreGoods[arr[2]] = self._critterStoreGoods[arr[2]] or {}

			table.insert(self._critterStoreGoods[arr[2]], cfg)
		elseif storeId == StoreEnum.StoreId.NewDecorateStore or storeId == StoreEnum.StoreId.OldDecorateStore then
			local arr = string.splitToNumber(cfg.product, "#")

			self._decorateProduct2GoodsId[arr[2]] = self._decorateProduct2GoodsId[arr[2]] or {}
			self._decorateProduct2GoodsId[arr[2]] = cfg
		end
	end
end

function StoreConfig:initStoreChargeGoodsConfig(configTable)
	self._storeChargeGoodsConfig = configTable
	self._skin2ChargeGoodsCfg = {}

	for _, cfg in ipairs(self._storeChargeGoodsConfig.configList) do
		if cfg.belongStoreId == StoreEnum.StoreId.Skin then
			local arr = GameUtil.splitString2(cfg.item, true)
			local skinId

			if arr and #arr == 1 then
				local item = arr[1]

				if item[1] == MaterialEnum.MaterialType.HeroSkin then
					skinId = item[2]
				end
			end

			if skinId then
				self._skin2ChargeGoodsCfg[skinId] = cfg
			end
		end
	end
end

function StoreConfig:getSkinChargeGoodsCfg(skinId)
	return self._skin2ChargeGoodsCfg[skinId]
end

function StoreConfig:getSkinChargePrice(skinId)
	local price, originalPrice
	local cfg = self:getSkinChargeGoodsCfg(skinId)

	if cfg then
		price = cfg.price
		originalPrice = cfg.originalCost
	end

	return price, originalPrice
end

function StoreConfig:getSkinChargeGoodsId(skinId)
	local id
	local cfg = self:getSkinChargeGoodsCfg(skinId)

	return (cfg or nil) and cfg.id
end

function StoreConfig:getTabConfig(tabId)
	local config = self._storeEntranceConfig.configDict[tabId]

	if not config then
		tabId = StoreEnum.StoreId2TabId[tabId]
		config = self._storeEntranceConfig.configDict[tabId]
	end

	return config
end

function StoreConfig:getGoodsConfig(goodsId, notError)
	local config = self._storeGoodsConfig.configDict[goodsId]

	if not config and not notError then
		logError("找不到商品: " .. tostring(goodsId))
	end

	return config
end

function StoreConfig:getCharageGoodsCfgListByPoolId(poolId)
	if not self._poolId2CharageGoodsCfgListDic and self._storeChargeGoodsConfig and self._storeChargeConditionalConfig then
		self._poolId2CharageGoodsCfgListDic = {}

		for _, goodsCfg in ipairs(self._storeChargeGoodsConfig.configList) do
			local condCfg = self:getChargeConditionalConfig(goodsCfg.taskid)
			local poolIds

			if condCfg then
				if not string.nilorempty(condCfg.idsStr) then
					poolIds = string.splitToNumber(condCfg.idsStr, "#")
				end

				if condCfg.id ~= 0 then
					poolIds = poolIds or {}

					if not tabletool.indexOf(poolIds, condCfg.id) then
						table.insert(poolIds, condCfg.id)
					end
				end
			end

			if poolIds then
				for _idx, tPoolId in ipairs(poolIds) do
					self._poolId2CharageGoodsCfgListDic[tPoolId] = self._poolId2CharageGoodsCfgListDic[tPoolId] or {}

					table.insert(self._poolId2CharageGoodsCfgListDic[tPoolId], goodsCfg)
				end
			end
		end
	end

	return self._poolId2CharageGoodsCfgListDic and self._poolId2CharageGoodsCfgListDic[poolId]
end

function StoreConfig:getChargeGoodsIdByConditionalId(conditionalId)
	if not self._storeChargeConditional2GoodsId then
		self._storeChargeConditional2GoodsId = {}

		for _, chargeConfig in ipairs(self._storeChargeGoodsConfig.configList) do
			if chargeConfig.taskid then
				self._storeChargeConditional2GoodsId[chargeConfig.taskid] = chargeConfig.id
			end
		end
	end

	return self._storeChargeConditional2GoodsId[conditionalId]
end

function StoreConfig:getChargeGoodsConfig(chargeGoodsId, notShowError)
	local config = self._storeChargeGoodsConfig.configDict[chargeGoodsId]

	if not config and notShowError ~= true then
		logError("找不到充值商品: " .. tostring(chargeGoodsId))
	end

	return config
end

function StoreConfig:findChargeConditionalConfigByGoodsId(chargeGoodsId)
	local cfg = self:getChargeGoodsConfig(chargeGoodsId, true)

	if cfg then
		return self:getChargeConditionalConfig(cfg.taskid)
	end
end

function StoreConfig:getChargeConditionalConfig(sccId)
	return self._storeChargeConditionalConfig.configDict[sccId]
end

function StoreConfig:getChargeGoodsPrice(chargeGoodsId, notShowError)
	local config = self:getChargeGoodsConfig(chargeGoodsId, notShowError)

	if config then
		return config[self._configPriceKey]
	end

	return 0
end

function StoreConfig:getBaseChargeGoodsPrice(chargeGoodsId, notShowError)
	local config = self:getChargeGoodsConfig(chargeGoodsId, notShowError)

	if config then
		return config[self._configBasePriceKey]
	end

	return 0
end

function StoreConfig:getChargeGoodsCurrencyCode(chargeGoodsId, notShowError)
	local config = self:getChargeGoodsConfig(chargeGoodsId, notShowError)

	if config then
		return config[self._configCurrencyCodeKey]
	end

	return "USD"
end

function StoreConfig:getChargeGoodsOriginalCost(chargeGoodsId, notShowError)
	local config = self:getChargeGoodsConfig(chargeGoodsId, notShowError)

	if config then
		return config[self._configOriginalCostKey]
	end

	return 0
end

function StoreConfig:getAllChargeGoodsConfig()
	return self._storeChargeGoodsConfig.configDict
end

function StoreConfig:getStoreChargeConfig(goodId, packageName)
	local config = self._storeChargeConfig.configDict[goodId][packageName]

	if not config then
		logError("找不到充值商品相关配置: " .. tostring(goodId) .. packageName)
	end

	return config
end

function StoreConfig:getStoreChargeConfigByProductID(appStoreProductID)
	local config = self._storeChargeConfig.configDict
	local packageName = BootNativeUtil.getPackageName()
	local list = {}

	for goodId, v in pairs(config) do
		if v[packageName] and v[packageName].appStoreProductID == appStoreProductID then
			table.insert(list, v[packageName])
		end
	end

	return list
end

function StoreConfig:getStoreRecommendConfig(goodId)
	local config = self._storeRecommendConfig.configDict[goodId]

	if not config then
		logError("找不到充值商品相关配置: " .. tostring(goodId))
	end

	return config
end

function StoreConfig:getStoreConfig(storeId)
	local config = self._storeConfig.configDict[storeId]

	if not config then
		logError("找不到商店: " .. tostring(storeId))
	end

	return config
end

function StoreConfig:getAllStoreIds()
	local storeIds = {}
	local storeConfigDict = self._storeConfig.configDict

	for _, storeConfig in pairs(storeConfigDict) do
		table.insert(storeIds, storeConfig.id)
	end

	return storeIds
end

function StoreConfig:getTabHierarchy(tabId)
	local tabConfig = self:getTabConfig(tabId)

	if not tabConfig then
		return 0
	end

	if not self:hasTab(tabConfig.belongFirstTab) and not self:hasTab(tabConfig.belongSecondTab) then
		return 1
	elseif not self:hasTab(tabConfig.belongSecondTab) then
		return 2
	else
		return 3
	end
end

function StoreConfig:isPackageStore(storeId)
	local belongStore = self:getTabConfig(storeId)

	if belongStore and belongStore.belongFirstTab == StoreEnum.StoreId.Package then
		return true
	end

	return false
end

function StoreConfig:getMonthCardConfig(goodsId)
	if goodsId == StoreEnum.LittleMonthCardGoodsId then
		local littleMonthConfig = self._storeMonthAddCfg.configDict[goodsId]

		if littleMonthConfig ~= nil then
			return self._monthCardConfig.configDict[littleMonthConfig.month_id]
		end
	end

	return self._monthCardConfig.configDict[goodsId]
end

function StoreConfig:getDailyReleasePackageCfg(goodsId)
	return self._dailyReleasePackageCfg.configDict[goodsId]
end

function StoreConfig:getOpenTimeDiff(openTimeStamp, closeTimeStamp, nowTimeStamp)
	if closeTimeStamp <= openTimeStamp then
		logError("结束时间比开启时间早")
	elseif nowTimeStamp < openTimeStamp then
		return nowTimeStamp - openTimeStamp
	elseif nowTimeStamp < closeTimeStamp then
		return closeTimeStamp - nowTimeStamp
	end

	return 0
end

function StoreConfig:hasTab(tabId)
	return tabId and tabId ~= 0
end

function StoreConfig:getRemain(goodsConfig, remain, offlineTime)
	if remain <= 0 then
		return nil
	end

	local maxBuyCount = goodsConfig.maxBuyCount
	local refreshTime = StoreHelper.getShowRefreshTimeByGoodsCfg(goodsConfig)

	if refreshTime == StoreEnum.RefreshTime.Forever then
		if maxBuyCount > 0 then
			if goodsConfig.jumpId ~= 0 then
				return formatLuaLang("store_limitget", remain)
			elseif offlineTime > 0 then
				return string.format("%s:%d", luaLang("store_buylimit"), remain)
			else
				return string.format("%s:%d", luaLang("store_buylimit_forever"), remain)
			end
		else
			return nil
		end
	elseif refreshTime == StoreEnum.RefreshTime.Day then
		return string.format("%s:%d", luaLang("store_buylimit_day"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Week then
		return string.format("%s:%d", luaLang("store_buylimit_week"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Month then
		return string.format("%s:%d", luaLang("store_buylimit_month"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Version then
		return string.format("%s:%d", luaLang("store_buylimit_version"), remain)
	else
		return string.format("%s:%d", luaLang("store_buylimit"), remain)
	end
end

function StoreConfig:getRemainText(maxBuyCount, refreshTime, remain, offlineTime)
	if refreshTime == StoreEnum.RefreshTime.Forever then
		if maxBuyCount > 0 then
			if offlineTime > 0 then
				return string.format("%s: %d", luaLang("store_buylimit"), remain)
			else
				return string.format("%s: %d", luaLang("store_buylimit_forever"), remain)
			end
		else
			return nil
		end
	elseif refreshTime == StoreEnum.RefreshTime.Day then
		return string.format("%s: %d", luaLang("store_buylimit_day"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Week then
		return string.format("%s: %d", luaLang("store_buylimit_week"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Month then
		return string.format("%s: %d", luaLang("store_buylimit_month"), remain)
	elseif refreshTime == StoreEnum.RefreshTime.Version then
		return string.format("%s: %d", luaLang("store_buylimit_version"), remain)
	else
		return string.format("%s: %d", luaLang("store_buylimit"), remain)
	end
end

function StoreConfig:getChargeRemainText(maxBuyCount, refreshTime, remain, offlineTime)
	if refreshTime == StoreEnum.ChargeRefreshTime.Forever then
		if maxBuyCount > 0 then
			if offlineTime > 0 then
				return string.format("%s: %d", luaLang("store_buylimit"), remain)
			else
				return string.format("%s: %d", luaLang("store_buylimit_forever"), remain)
			end
		else
			return nil
		end
	elseif refreshTime == StoreEnum.ChargeRefreshTime.MonthCard then
		local monthCardInfo = StoreModel.instance:getMonthCardInfo()

		if monthCardInfo then
			local remainDay = monthCardInfo:getRemainDay()

			if remainDay == StoreEnum.MonthCardStatus.NotPurchase then
				return nil
			elseif remainDay == StoreEnum.MonthCardStatus.NotEnoughOneDay then
				return luaLang("not_enough_one_day")
			else
				return formatLuaLang("remain_day", remainDay)
			end
		else
			return nil
		end
	elseif refreshTime == StoreEnum.ChargeRefreshTime.Day then
		return string.format("%s: %d", luaLang("store_buylimit_day"), remain)
	elseif refreshTime == StoreEnum.ChargeRefreshTime.Week then
		return string.format("%s: %d", luaLang("store_buylimit_week"), remain)
	elseif refreshTime == StoreEnum.ChargeRefreshTime.Month then
		return string.format("%s: %d", luaLang("store_buylimit_month"), remain)
	else
		return string.format("%s: %d", luaLang("store_buylimit"), remain)
	end
end

function StoreConfig:hasNextGood(goodId)
	return self._preGoodsIdDict[goodId] ~= nil
end

function StoreConfig:getRoomProductGoodsId(type, id)
	local result

	if self._roomProduct2GoodsId then
		if not self._roomProduct2GoodsId[type] then
			result = self._roomProduct2GoodsId[type][id]
		end
	end

	return result
end

function StoreConfig:getRoomCritterProductGoods(id)
	return self._critterStoreGoods[id] or {}
end

function StoreConfig:getChargeOptionalGroup(chargeGoodsId)
	local config = self._chargeOptionalConfig.configDict[chargeGoodsId]

	if not config then
		logError("充值商品ID未配置充值自选礼包表" .. tostring(chargeGoodsId))
	end

	return config
end

function StoreConfig:getMonthCardAddConfig(cardId)
	return self._storeMonthAddCfg.configDict[cardId]
end

function StoreConfig:getSeasonCardMultiFactor()
	return CommonConfig.instance:getConstNum(2501)
end

function StoreConfig:getDecorateGoodsCfgById(materialId)
	return self._decorateProduct2GoodsId[materialId]
end

function StoreConfig:getDecorateGoodsIdById(materialId)
	local id
	local cfg = self:getDecorateGoodsCfgById(materialId)

	return (cfg or nil) and cfg.id
end

StoreConfig.instance = StoreConfig.New()

return StoreConfig
