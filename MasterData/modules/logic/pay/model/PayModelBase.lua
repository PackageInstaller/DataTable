-- chunkname: @modules/logic/pay/model/PayModelBase.lua

module("modules.logic.pay.model.PayModelBase", package.seeall)

local PayModelBase = LuaUtil.class("PayModelBase", BaseModel)

function PayModelBase:ctor()
	assert(false, "PayModelBase is an abstract class, please use PayModel instead.")
end

function PayModelBase:onInit()
	self._chargeInfos = {}
	self._orderInfo = {}
	self._sandboxEnable = false
	self._sandboxBalance = 0
end

function PayModelBase:reInit()
	self._chargeInfos = {}
	self._orderInfo = {}
	self._sandboxEnable = false
	self._sandboxBalance = 0
end

function PayModelBase:setSandboxInfo(sandboxEnable, sandboxBalance)
	self._sandboxEnable = sandboxEnable
	self._sandboxBalance = sandboxBalance
end

function PayModelBase:updateSandboxBalance(sandboxBalance)
	self._sandboxBalance = sandboxBalance
end

function PayModelBase:setChargeInfo(info)
	for _, v in ipairs(info) do
		self._chargeInfos[v.id] = v
	end
end

function PayModelBase:setOrderInfo(info)
	self._orderInfo = {}
	self._orderInfo.id = info.id

	if info.passBackParam then
		self._orderInfo.passBackParam = info.passBackParam
	end

	if info.notifyUrl then
		self._orderInfo.notifyUrl = info.notifyUrl or ""
	end

	self._orderInfo.gameOrderId = info.gameOrderId
	self._orderInfo.timestamp = info.timestamp
	self._orderInfo.sign = info.sign
	self._orderInfo.serverId = info.serverId
end

function PayModelBase:clearOrderInfo()
	self._orderInfo = {}
end

function PayModelBase:getSandboxEnable()
	return self._sandboxEnable
end

function PayModelBase:getSandboxBalance()
	return self._sandboxBalance
end

function PayModelBase:getOrderInfo()
	return self._orderInfo
end

function PayModelBase:getGamePayInfo()
	if not self._orderInfo.id then
		return {}
	end

	local chargeConfig = StoreConfig.instance:getChargeGoodsConfig(self._orderInfo.id)
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local payInfo = {}

	payInfo.gameRoleInfo = self:getGameRoleInfo(true)
	payInfo.gameRoleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)
	payInfo.amount = math.ceil(100 * chargeConfig.price)
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
	payInfo.productId = BootNativeUtil.isIOS() and StoreConfig.instance:getStoreChargeConfig(self._orderInfo.id, BootNativeUtil.getPackageName()).appStoreProductID or ""

	return payInfo
end

function PayModelBase:getGameRoleInfo(pay)
	local playerinfo = PlayerModel.instance:getPlayinfo()
	local freeDiamond = CurrencyModel.instance:getFreeDiamond()
	local diamond = CurrencyModel.instance:getDiamond()
	local roleInfo = {}

	roleInfo.roleId = tostring(playerinfo.userId)
	roleInfo.roleName = tostring(playerinfo.name)
	roleInfo.currentLevel = tonumber(playerinfo.level)
	roleInfo.vipLevel = 0

	local serverId = tostring(LoginModel.instance.serverId)
	local lastEpisodeConfig = DungeonConfig.instance:getEpisodeCO(playerinfo.lastEpisodeId)
	local curProgress = lastEpisodeConfig and tostring(lastEpisodeConfig.name .. lastEpisodeConfig.id) or ""

	roleInfo.serverId = (pay and self._orderInfo.serverId > 0 or nil) and self._orderInfo.serverId
	roleInfo.serverName = tostring(LoginModel.instance.serverName)
	roleInfo.roleCTime = tonumber(playerinfo.registerTime)
	roleInfo.loginTime = tonumber(playerinfo.lastLoginTime)
	roleInfo.logoutTime = tonumber(playerinfo.lastLogoutTime)
	roleInfo.accountRegisterTime = tonumber(playerinfo.registerTime)
	roleInfo.giveCurrencyNum = freeDiamond
	roleInfo.paidCurrencyNum = diamond
	roleInfo.currencyNum = freeDiamond + diamond
	roleInfo.currentProgress = curProgress
	roleInfo.roleEstablishTime = tonumber(playerinfo.registerTime)
	roleInfo.guildLevel = tonumber(playerinfo.level)
	roleInfo.roleType = StatModel.instance:getRoleType()
	roleInfo.gameEnv = VersionValidator.instance:isInReviewing() and 1 or 0

	return roleInfo
end

function PayModelBase:getQuickUseInfo()
	if not self._orderInfo then
		return
	end

	local goodsId = self._orderInfo.id

	if not goodsId then
		return
	end

	local chargeGoodsConfig = StoreConfig.instance:getChargeGoodsConfig(goodsId)

	if not chargeGoodsConfig then
		return
	end

	local quickUseItemList = chargeGoodsConfig.quickUseItemList

	if string.nilorempty(quickUseItemList) then
		return
	end

	local itemList = GameUtil.splitString2(quickUseItemList, true, "|", "#")

	if not itemList or #itemList == 0 then
		return
	end

	return {
		goodsId = goodsId,
		chargeGoodsConfig = chargeGoodsConfig,
		itemList = itemList
	}
end

function PayModelBase:isNoDecimalsCurrency(enumCurrencyCode)
	return PayEnum.NoDecimalsCurrency[enumCurrencyCode] ~= nil
end

function PayModelBase:getProductPrice(lua_store_charge_goods_id)
	assert(false, "please override this function!!")
end

function PayModelBase:getProductOriginPriceNum(lua_store_charge_goods_id)
	assert(false, "please override this function!!")
end

function PayModelBase:getProductOriginCurrency(lua_store_charge_goods_id)
	assert(false, "please override this function!!")
end

function PayModelBase:getProductOriginPriceSymbol(lua_store_charge_goods_id)
	assert(false, "please override this function!!")
end

function PayModelBase:getProductPriceScaledSymbol(lua_store_charge_goods_id, symbolSize)
	assert(false, "please override this function!!")
end

return PayModelBase
