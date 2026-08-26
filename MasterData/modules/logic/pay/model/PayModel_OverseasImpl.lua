-- chunkname: @modules/logic/pay/model/PayModel_OverseasImpl.lua

module("modules.logic.pay.model.PayModel_OverseasImpl", package.seeall)

local PayModel_OverseasImpl = LuaUtil.class("PayModel_OverseasImpl", PayModelBase)

function PayModel_OverseasImpl:ctor()
	assert(false, "PayModel_OverseasImpl is an abstract class, please use PayModel instead.")
end

function PayModel_OverseasImpl:onInit()
	PayModel_OverseasImpl.super.onInit(self)

	self._productInfos = {}
	self._hasInitProductInfo = false
end

function PayModel_OverseasImpl:reInit()
	PayModel_OverseasImpl.super.reInit(self)

	self._productInfos = {}
	self._hasInitProductInfo = false
end

function PayModel_OverseasImpl:hasInitProductInfo()
	if BootNativeUtil.isWindows() and GameChannelConfig.isGpGlobal() == false then
		return true
	end

	return self._hasInitProductInfo
end

function PayModel_OverseasImpl:setProductInfo(infoStr)
	if string.nilorempty(infoStr) == false and infoStr ~= "null" then
		local allJson = cjson.decode(infoStr)

		for _, v in pairs(allJson) do
			if BootNativeUtil.isWindows() then
				local goodsId = tonumber(v.productId)

				if goodsId and GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
					self._productInfos[goodsId] = v
				end

				self._hasInitProductInfo = true
			else
				local configList = StoreConfig.instance:getStoreChargeConfigByProductID(v.productId)

				for i, config in ipairs(configList) do
					self._hasInitProductInfo = true

					if GameChannelConfig.isLongCheng() == false and GameChannelConfig.isGpJapan() == false then
						self._productInfos[config.id] = v
					end
				end

				if #configList == 0 then
					logError("找不到对应充值商品：" .. v.productId)
				end
			end
		end
	end
end

function PayModel_OverseasImpl:setOrderInfo(info)
	PayModel_OverseasImpl.super.setOrderInfo(self, info)

	self._orderInfo.currency = info.currency
end

function PayModel_OverseasImpl:getProductInfo(id)
	return self._productInfos[id]
end

function PayModel_OverseasImpl:getProductPrice(id)
	local symbol = self:getProductOriginPriceSymbol(id)
	local num, numStr = self:getProductOriginPriceNum(id)

	return string.format("%s%s", symbol, numStr)
end

function PayModel_OverseasImpl:getProductOriginCurrency(id)
	if self._productInfos[id] and self._productInfos[id].priceCurrencyCode then
		return self._productInfos[id].priceCurrencyCode
	else
		return StoreConfig.instance:getChargeGoodsCurrencyCode(id)
	end
end

function PayModel_OverseasImpl:getProductInfoPrice(id)
	if self._productInfos[id] and self._productInfos[id].price then
		return self._productInfos[id].price
	else
		local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(id)
		local currencyCode = StoreConfig.instance:getChargeGoodsCurrencyCode(id)
		local price = StoreConfig.instance:getChargeGoodsPrice(id)

		if SDKModel.instance:isDmm() then
			return string.format("%spt", price)
		else
			return string.format("%s%s", (PayEnum.CurrencySymbol[currencyCode] or nil) and PayEnum.CurrencySymbol[currencyCode], price)
		end
	end
end

function PayModel_OverseasImpl:_getConfigProductInfoPrice(id)
	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(id)
	local currencyCode = StoreConfig.instance:getChargeGoodsCurrencyCode(id)
	local price = StoreConfig.instance:getChargeGoodsPrice(id)

	return string.format("%s%s", (PayEnum.CurrencySymbol[currencyCode] or nil) and PayEnum.CurrencySymbol[currencyCode], price)
end

function PayModel_OverseasImpl:getProductOriginAmountMicro(id)
	return self._productInfos[id].priceAmountMicros
end

function PayModel_OverseasImpl:getProductOriginPriceSymbol(id)
	local str = self:getProductInfoPrice(id)
	local index = string.find(str, "%d")

	if not index then
		logError("getProductOriginPriceSymbol fail:" .. str)

		str = self:_getConfigProductInfoPrice(id)
		index = string.find(str, "%d")
	end

	return string.sub(str, 0, index - 1)
end

function PayModel_OverseasImpl:getProductOriginPriceNum(id)
	self._tmpNum = 0
	self._tmpNumStr = "0"
	self._tmpIsNoDecimalsCurrency = false

	if not callWithCatch(self._getProductOriginPriceNum, self, id) then
		local str = self:_getConfigProductInfoPrice(id)
		local code = self:getProductOriginCurrency(id)
		local index = string.find(str, "%d")
		local numStr = string.sub(str, index, string.len(str))
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex

		local numStr2 = string.sub(numStr, 1, lastIndex + 1)

		self._tmpNum = string.gsub(numStr2, ",", "")
		self._tmpNum = tonumber(self._tmpNum)
		self._tmpNumStr = numStr
		self._tmpIsNoDecimalsCurrency = self:isNoDecimalsCurrency(code)

		if self._tmpIsNoDecimalsCurrency then
			self._tmpNumStr = math.floor(self._tmpNum)
		end
	end

	if string.nilorempty(self._tmpNum) then
		self._tmpNum = 0
	end

	return self._tmpNum, self._tmpNumStr, self._tmpIsNoDecimalsCurrency
end

function PayModel_OverseasImpl:_getProductOriginPriceNum(id)
	local str = self:getProductInfoPrice(id)
	local code = self:getProductOriginCurrency(id)
	local index = string.find(str, "%d")
	local numStr = string.sub(str, index, string.len(str))
	local reverseStr = string.reverse(numStr)
	local lastIndex = string.find(reverseStr, "%d")

	lastIndex = string.len(reverseStr) - lastIndex

	local numStr2 = string.sub(numStr, 1, lastIndex + 1)
	local num = string.gsub(numStr2, ",", "")

	self._tmpNum = tonumber(num)
	self._tmpIsNoDecimalsCurrency = self:isNoDecimalsCurrency(code)
	self._tmpNumStr = numStr

	if self._tmpIsNoDecimalsCurrency and SDKModel.instance:isDmm() == false then
		self._tmpNumStr = math.floor(num)
	end
end

function PayModel_OverseasImpl:getProductOriginAmount(id)
	self._tmpAmount = 0

	if not callWithCatch(self._getProductOriginAmount, self, id) then
		self._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. self:getProductInfoPrice(id))
	end

	if string.nilorempty(self._tmpAmount) then
		self._tmpAmount = 0

		logError("getProductOriginAmount fail:" .. self:getProductInfoPrice(id))
	end

	return self._tmpAmount
end

function PayModel_OverseasImpl:_getProductOriginAmount(id)
	if BootNativeUtil.isWindows() and self:getProductInfo(id) then
		local originAmountMicro = self:getProductOriginAmountMicro(id)

		self._tmpAmount = originAmountMicro and originAmountMicro or 0

		return
	end

	local str = self:getProductInfoPrice(id)
	local index = string.find(str, "%d")
	local num = string.sub(str, index, string.len(str))
	local reverseStr = string.reverse(num)
	local lastIndex = string.find(reverseStr, "%d")

	lastIndex = string.len(reverseStr) - lastIndex

	local numStr2 = string.sub(num, 1, lastIndex + 1)

	num = string.gsub(numStr2, ",", "")
	num = tonumber(num)
	num = num * 100
	index = string.find(num, "%.")

	if index then
		num = string.sub(num, 0, index - 1)
		num = tonumber(num)
	else
		num = string.sub(num, 0, string.len(num))
		num = tonumber(num)
	end

	self._tmpAmount = num
end

function PayModel_OverseasImpl:getProductPriceScaledSymbol(lua_store_charge_goods_id, symbolSize)
	symbolSize = symbolSize or 30

	local symbol = self:getProductOriginPriceSymbol(lua_store_charge_goods_id)
	local num, numStr = self:getProductOriginPriceNum(lua_store_charge_goods_id)

	if string.nilorempty(symbol) then
		local reverseStr = string.reverse(numStr)
		local lastIndex = string.find(reverseStr, "%d")

		lastIndex = string.len(reverseStr) - lastIndex + 1
		numStr = string.sub(numStr, 1, lastIndex)

		return string.format("%s<size=%s>%s</size>", numStr, symbolSize, (string.sub(numStr, lastIndex + 1, string.len(numStr))))
	else
		return string.format("<size=%s>%s</size>%s", symbolSize, symbol, numStr)
	end
end

function PayModel_OverseasImpl:getGamePayInfo()
	if not self._orderInfo.id then
		return {}
	end

	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self._orderInfo.id)
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local payInfo = {}

	payInfo.gameRoleInfo = self:getGameRoleInfo(true)
	payInfo.gameRoleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)
	payInfo.currency = self._orderInfo.currency
	payInfo.amount = math.ceil(100 * StoreConfig.instance:getBaseChargeGoodsPrice(chargeConfig.id))
	payInfo.goodsId = self._orderInfo.id
	payInfo.goodsName = chargeConfig.name
	payInfo.goodsDesc = chargeConfig.desc
	payInfo.gameOrderId = self._orderInfo.gameOrderId

	if self._orderInfo.passBackParam then
		payInfo.passBackParam = self._orderInfo.passBackParam or ""
	end

	payInfo.notifyUrl = self._orderInfo.notifyUrl
	payInfo.timestamp = self._orderInfo.timestamp
	payInfo.sign = self._orderInfo.sign

	if SLFramework.FrameworkSettings.IsEditor then
		payInfo.productId = ""
	else
		local channelId = SDKMgr.instance:getChannelId()
		local channelIdChargeConfig = StoreConfig.instance:getStoreChargeConfig(self._orderInfo.id, BootNativeUtil.getPackageName() .. "_" .. channelId, true)

		payInfo.productId = channelIdChargeConfig and channelIdChargeConfig.appStoreProductID or StoreConfig.instance:getStoreChargeConfig(self._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID
	end

	payInfo.originCurrency = self:getProductOriginCurrency(self._orderInfo.id)
	payInfo.originAmount = self:getProductOriginAmount(self._orderInfo.id)

	return payInfo
end

return PayModel_OverseasImpl
