-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeManager.lua

local SDKConst = require("SDK/SDKConst")
local utils = require("Common/utils")
local UserData = require("Helper/UserData")
local json = require("cjson")
local UrlConfig = require("Network/UrlConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local ResRecharge = require("ClientData/ResRecharge")
local ResRechargeShow = require("ClientData/ResRechargeShow")
local ResRechargeResultInfo = require("ClientData/ResRechargeResultInfo")
local OpenServerConst = require("Network/OpenServerConst")
local EventConst = require("EventConst")
local Analytics = require("SDK/Analytics")
local RechargeConst = require("System/Recharge/RechargeConst")
local Product = require("System/Recharge/Product")
local VersionUtils = require("System/VersionUtils")
local RemoteController = require("SDK/Plugin/RemoteController")
local Time = Time
local Const = Const
local RechargeManager = {}
local ClientUtils = ClientUtils
local ChannelUtil = ChannelUtil
local RECHARGE_ERROR_CODE = RechargeConst.RECHARGE_ERROR_CODE
local PaymentEvent = SDKConst.PaymentEvent
local PurchaseState = SDKConst.PurchaseState
local AttName = SDKConst.AttName
local SDKPayType = SDKConst.PayType
local ResponseCode = SDKConst.ResponseCode
local RECHARGE_CHANNEL = RechargeConst.RECHARGE_CHANNEL

RechargeManager.RETRY_TIMER_BASE_TICK = 1
RechargeManager.PRODUCT_RETRY_INTERVALS = {
	4,
	6,
	8,
	10,
	12
}
RechargeManager.TRIGGER_REFRESH_TIME = 300
RechargeManager.OPEN_ORDER_TIME_OUT = 8
RechargeManager.OPEN_ORDER_TIME_OUT_FREE = 1
RechargeManager.RECHARGE_TYPE_WEEK_CARD = 2
RechargeManager.RECHARGE_TYPE_MONTH_CARD = 3
RechargeManager.nowProductName = nil
RechargeManager.tempRechrageId = nil

local actionType = {
	VERIFY_RECEIPT = 2,
	REQUEST_PRODUCTS_STORE = 0
}

RechargeManager.AbnormalCancelTime = 2
RechargeManager.currencySign = ChannelUtil.getCurrencySign()
RechargeManager.curPlatformType = DeviceHelper.isAndroid() and 0 or DeviceHelper.isIOS() and 1 or DeviceHelper.isWindows() and 0
RechargeManager._isBaseInited = false
RechargeManager._requestGameProductsTime = -9999999
RechargeManager._prepareProductsTime = -9999999

local RECHARGE_METHOD = {
	MONEY = "kRechargeUseTypeNone",
	REBATE = "kRechargeUseTypeRebate",
	REFUND = "kRechargeUseTypeRefund"
}

RechargeManager.RECHARGE_METHOD = RECHARGE_METHOD

function RechargeManager.loadProducts()
	if not RechargeManager.isInited() then
		if not RechargeManager.isLoading() then
			RechargeManager._init()
		end
	elseif not RechargeManager.refreshGameProducts(false) then
		EventCenter.sendEvent(EventConst.RECHARGE_PRODUCTS_LOAD_END, true)
	end
end

function RechargeManager.refreshGameProducts(forceMode)
	if forceMode or math.abs(Time.time - RechargeManager._requestGameProductsTime) > RechargeManager.TRIGGER_REFRESH_TIME then
		RechargeManager._initBase()
		RechargeManager._removeRequestProductsAndStore()

		RechargeManager._isGameProductsLoaded = false

		RechargeManager._requestProductsAndStore()

		return true
	else
		return false
	end
end

function RechargeManager.destroy()
	RechargeManager._reset()
end

function RechargeManager.isInited()
	return RechargeManager._isBaseInited and RechargeManager._isGameProductsLoaded and RechargeManager._isPlatformProductsLoaded
end

function RechargeManager.isInitFailed()
	return not RechargeManager.isLoading() and not RechargeManager.isInited()
end

function RechargeManager.isLoading()
	return RechargeManager._isLoading == true
end

function RechargeManager.getRechargeId(shortId)
	shortId = shortId and shortId % 10000

	return RechargeManager._rechargeIDDict[shortId]
end

function RechargeManager.getProductByRechargeId(shortId, rechargeType)
	local rechargeId = RechargeManager.getRechargeId(shortId)

	if RechargeManager._producstsLut == nil then
		return nil
	end

	local product = RechargeManager._producstsLut[rechargeId]

	return product
end

function RechargeManager.getNestedId(rechargeId)
	local passedDict = {}
	local nowRechrageId = rechargeId

	for index = 1, 100 do
		local product = RechargeManager.getProductByRechargeId(nowRechrageId)

		if product and product.buyTimesLeft <= 0 and product.nestedId then
			local nestProduct = RechargeManager.getProductByRechargeId(product.nestedId)

			if nestProduct then
				local limitState = nestProduct.unlockStage
				local limitVip = nestProduct.unlockVip
				local limitLock = limitState and not CurAvatar:mainStageStatePassed(limitState[1], limitState[2], limitState[3])
				local vipLock = limitVip and limitVip > (CurAvatar.vipLevel or 0)

				if limitState and limitVip then
					if limitLock and vipLock then
						return nowRechrageId, passedDict
					end
				elseif limitLock or vipLock then
					return nowRechrageId, passedDict
				end

				passedDict[nowRechrageId] = true
				nowRechrageId = product.nestedId
			else
				return nowRechrageId, passedDict
			end
		else
			return nowRechrageId, passedDict
		end
	end
end

function RechargeManager.startRecharge(shortId, rechargeArgs)
	if not RechargeManager._checkAccount() then
		return
	end

	local rechargeId = RechargeManager.getRechargeId(shortId)

	if RechargeManager._canUseRefund(rechargeId) then
		RechargeManager._showDeduct(rechargeId, RECHARGE_METHOD.REFUND, Functor(RechargeManager.startRechargeWithMethod, rechargeArgs))
	elseif RechargeManager._canUseRebate(rechargeId) then
		RechargeManager._showDeduct(rechargeId, RECHARGE_METHOD.REBATE, Functor(RechargeManager.startRechargeWithMethod, rechargeArgs))
	else
		RechargeManager.startRechargeWithMethod(rechargeArgs, rechargeId, RECHARGE_METHOD.MONEY)
	end
end

function RechargeManager.startRechargeWithMethod(rechargeArgs, rechargeId, method)
	if RechargeManager._channelImp:overrideStartRecharge(rechargeId) then
		-- block empty
	else
		RechargeManager._startRechargeWithPayType(nil, rechargeId, method, rechargeArgs)
	end
end

function RechargeManager._startRechargeWithPayType(payType, rechargeId, method, rechargeArgs)
	local productId = RechargeManager._getProductIdFromRechargeId(rechargeId)
	local errorCode = RechargeManager._doRechargePipline(rechargeId, productId, payType, method, rechargeArgs)

	if errorCode == RECHARGE_ERROR_CODE.UNFINISHED_PRODUCT_ID then
		RechargeManager._showUnfinishedProductTip(productId)
	else
		local product = RechargeManager.getProductByRechargeId(rechargeId)

		if product.isFree and (errorCode == RECHARGE_ERROR_CODE.SUCCESS or errorCode == RECHARGE_ERROR_CODE.IN_TRANSACTION) then
			return
		end

		local msg = RechargeConst.ERROR_CODE_MSG[errorCode]

		if msg then
			MsgManager.notice(msg)
		end
	end
end

function RechargeManager._init()
	RechargeManager._initBase(true)
	RechargeManager._removeRequestProductsAndStore()
	RechargeManager._requestProductsAndStore()
end

function RechargeManager._initBase(forceMode)
	if not RechargeManager._isBaseInited or forceMode then
		RechargeManager._reset()
		RechargeManager._initRetry()
		EventCenter.addEventListener(EventConst.NEW_DAY, RechargeManager._onNewDay)

		RechargeManager._timerSdkPayLock = Timer.New(RechargeManager._onSdkPayLockRelease, 2, 1)
		RechargeManager._persistData = ClientUtils.string2Table(UserData.loadCommonData(RechargeConst.KEY_IAP_PERSIST_DATA))

		local rechargeChannel = ChannelUtil.getRechargeChannel()

		RechargeManager._rechargeChannel = rechargeChannel

		RechargeManager._initRechargeId()

		if RechargeManager._channelImp == nil then
			RechargeManager._channelImp = RechargeManager._getRechargeChannelImp(rechargeChannel)
		end

		RechargeManager._isBaseInited = true
	end
end

function RechargeManager._initRechargeId()
	local rechargeIDDict = {}
	local prefix = ChannelUtil.getRechargeIDChannel()

	for rechargeId, _ in pairs(ResRecharge) do
		local shortId = rechargeId % 10000

		if prefix then
			rechargeId = 10000 * prefix + shortId
		end

		rechargeIDDict[shortId] = rechargeId
	end

	RechargeManager._rechargeIDDict = rechargeIDDict
end

function RechargeManager._reset()
	RechargeManager._destroyRetry()

	RechargeManager._requestGameProductsTime = -9999999
	RechargeManager._prepareProductsTime = -9999999
	RechargeManager._isLoading = false
	RechargeManager._isGameProductsLoaded = false
	RechargeManager._isPlatformProductsLoaded = false
	RechargeManager._gameProducts = {}
	RechargeManager._platformProducts = {}
	RechargeManager._products = {}
	RechargeManager._producstsLut = {}
	RechargeManager._curTransRechargeId = nil
	RechargeManager._curTransOrderId = nil
	RechargeManager._openOrderLockTime = nil

	EventCenter.removeEventListener(EventConst.NEW_DAY, RechargeManager._onNewDay)

	if RechargeManager._timerSdkPayLock then
		RechargeManager._timerSdkPayLock:Stop()

		RechargeManager._timerSdkPayLock = nil
	end

	RechargeManager._isBaseInited = false
end

function RechargeManager._canUseRefund(rechargeId)
	local product = RechargeManager.getProductByRechargeId(rechargeId)

	if product == nil then
		return false
	end

	local productPrice = product.refundCoin

	if productPrice and productPrice <= CurAvatar:getMoneyByType(Const.MONEY_TYPE_REFUND_COIN) and productPrice > 0 then
		return true
	end

	return false
end

function RechargeManager._canUseRebate(rechargeId)
	local product = RechargeManager.getProductByRechargeId(rechargeId)

	if product == nil then
		return false
	end

	local productPrice = product.priceTextRebate

	if productPrice <= ClientUtils.getMoney(510022) and productPrice > 0 then
		return true
	end

	return false
end

function RechargeManager._showDeduct(rechargeId, method, callback)
	local DeductConfirmBox = UIManager.getUI("deductConfirmBox", true)

	if DeductConfirmBox then
		DeductConfirmBox:SetTextContent(rechargeId, method, callback)
	end
end

function RechargeManager._checkProductsLoaded()
	if RechargeManager.isInited() then
		RechargeManager._prepareProducts()
		RechargeManager._removeRequestProductsAndStore()
		EventCenter.sendEvent(EventConst.RECHARGE_PRODUCTS_LOAD_END, true)
	end
end

function RechargeManager._getRechargeChannelImp(rechargeChannel)
	local impPath = ChannelUtil.getRechargeImpPath()
	local impCls = require(impPath)

	return impCls.GetInstance()
end

function RechargeManager._requestProductsAndStore()
	RechargeManager._initBase()

	local newRetry = {
		retryTimes = 0,
		countdown = 0,
		actionType = actionType.REQUEST_PRODUCTS_STORE,
		action = RechargeManager._doRequestProductsAndStore,
		stopCallback = RechargeManager._onRequestProductAndStoreFinish,
		retryIntervals = RechargeManager.PRODUCT_RETRY_INTERVALS
	}

	RechargeManager._isLoading = true

	RechargeManager._addRetryAction(newRetry)
end

function RechargeManager._removeRequestProductsAndStore()
	RechargeManager._removeRetry(actionType.REQUEST_PRODUCTS_STORE)
end

function RechargeManager._doRequestProductsAndStore()
	RechargeManager._initBase()

	if RechargeManager.isInited() then
		RechargeManager._removeRequestProductsAndStore()
	end

	RechargeManager._onGetToken()
end

function RechargeManager._onGetToken()
	RechargeManager._requestGameProductsTime = Time.time

	RPC.rechargeListGet()

	if not RechargeManager._isPlatformProductsLoaded then
		SDKAgent.getProductInfo(RechargeManager.onPlatformProductsLoaded)
	end
end

function RechargeManager.updateGameProductCanBuyCount(item)
	local changeDic = {}

	for _, canBuyCountItem in ipairs(item) do
		changeDic[canBuyCountItem.recharge_id] = canBuyCountItem.can_buy_count
	end

	for idx, gameData in pairs(RechargeManager._gameProducts) do
		if changeDic[gameData.recharge_id] then
			RechargeManager._gameProducts[idx].can_buy_count = changeDic[gameData.recharge_id]

			local product = RechargeManager.getProductByRechargeId(gameData.recharge_id)

			if product then
				product.buyTimesLeft = changeDic[gameData.recharge_id]
			end
		end
	end
end

function RechargeManager._setPlatformProducts(platformProducts)
	if platformProducts then
		RechargeManager._platformProducts = platformProducts
		RechargeManager._isPlatformProductsLoaded = true
	else
		RechargeManager._isPlatformProductsLoaded = false
	end
end

function RechargeManager._prepareProducts()
	local products = RechargeManager._products
	local productsLut = RechargeManager._producstsLut
	local platformProducts = RechargeManager._platformProducts

	for _, gameData in pairs(RechargeManager._gameProducts) do
		local productId = gameData.product_id
		local platformData = platformProducts[productId]

		if platformData then
			local platformType = platformData.platform

			if RechargeManager._isPlatformAvaliable(platformType) then
				local product = productsLut[gameData.recharge_id]

				if product == nil then
					product = Product.create(gameData, platformData)

					if product then
						local rechargeType = product.rechargeType
						local indexPriority = product.indexPriority

						if products[rechargeType] == nil then
							products[rechargeType] = {}
						end

						local productsSameType = products[rechargeType]
						local i = 1

						for _, productCompare in ipairs(productsSameType) do
							if productCompare and indexPriority >= productCompare.indexPriority then
								i = i + 1
							else
								break
							end
						end

						table.insert(productsSameType, i, product)

						productsLut[product.rechargeId] = product
					end
				else
					Product.update(product, gameData, platformData)
				end

				if product then
					product:setGetLeftTimes(CurAvatar:getRechargeLeftGetCount(product.mulityLinkId))
				end
			end
		end
	end

	RechargeManager._prepareProductsTime = Time.time
end

function RechargeManager._doRechargePipline(rechargeId, productId, payType, method, rechargeArgs)
	if not RechargeManager.isInited() then
		RechargeManager.loadProducts()

		return RECHARGE_ERROR_CODE.NOT_INITED
	end

	if rechargeId == nil then
		return RECHARGE_ERROR_CODE.INVALID_PRODUCT_ID
	end

	local product = RechargeManager.getProductByRechargeId(rechargeId)

	if product == nil then
		return RECHARGE_ERROR_CODE.INVALID_PRODUCT_ID
	end

	if RechargeManager._channelImp:isFinishedButNotVerified(productId) then
		return RECHARGE_ERROR_CODE.UNFINISHED_PRODUCT_ID
	end

	if not RechargeManager._isRoleConnected() then
		return RECHARGE_ERROR_CODE.INVALID_GAME_INFO
	end

	if product.buyTimesLeft and product.buyTimesLeft <= 0 then
		return RECHARGE_ERROR_CODE.PRODUCT_SOLD_OUT
	end

	local isLimit, notice = SDKAgent.isAgeLimit()

	if isLimit then
		if notice == 1 then
			return RECHARGE_ERROR_CODE.QUERY_AGE
		elseif notice == 2 then
			return RECHARGE_ERROR_CODE.NOT_INPUT_BIRTHDAY
		else
			return RECHARGE_ERROR_CODE.UNKNOWN
		end
	end

	local isFree = product.isFree

	if not isFree then
		RechargeManager._setCurTransaction()
	end

	local openOrderLocked = RechargeManager._openOrderLockTime ~= nil and math.abs(RechargeManager._openOrderLockTime - Time.time) < RechargeManager.OPEN_ORDER_TIME_OUT

	if openOrderLocked or RechargeManager._timerSdkPayLock:IsRunning() then
		return RECHARGE_ERROR_CODE.IN_TRANSACTION
	end

	if RechargeManager._requestOpenOrder(rechargeId, payType, isFree, method, rechargeArgs) then
		return RECHARGE_ERROR_CODE.SUCCESS
	else
		return RECHARGE_ERROR_CODE.INVALID_GAME_INFO
	end
end

function RechargeManager._requestOpenOrder(rechargeId, payType, isFree, method, rechargeArgs)
	local order = RechargeManager._getOpenOrder(rechargeId, payType)

	if order then
		if not isFree then
			RechargeManager._setCurTransaction(rechargeId)

			RechargeManager._openOrderLockTime = Time.time
		else
			RechargeManager._openOrderLockTime = Time.time - RechargeManager.OPEN_ORDER_TIME_OUT + RechargeManager.OPEN_ORDER_TIME_OUT_FREE
		end

		rechargeArgs = rechargeArgs or {}

		RPC.rechargeGenerateOrderID(order.channelAccount, order.rechargeId, order.productId, order.gemAmount, order.firstBonus, order.normalBonus, method, rechargeArgs.chooseResult, rechargeArgs.special)

		return true
	else
		return false
	end
end

function RechargeManager.onRechargeGenerateOrderIDResp(resp_code, svr_nodeid, channel_account, recharge_id, product_id, orderid, extend_str, opensvr_code, anti_data, gift_type)
	local ResRecharge = require("ClientData/ResRecharge")

	if recharge_id ~= 0 then
		RechargeManager.nowProductName = ResRecharge[recharge_id].product_name
		RechargeManager.tempRechrageId = recharge_id
	end

	local isSucc = true

	if resp_code == "kGenOrderIDCodeAntiAddiction" then
		isSucc = false

		local msg = Lang.get(55377)

		if not ChannelUtil.isHuawei() then
			if anti_data.age == 1 then
				msg = Lang.get(48085)
			elseif anti_data.age == 2 then
				if anti_data.anti_code == "kGenOrderIDReasonOverrunSingle" then
					msg = Lang.get(48086)
				elseif anti_data.anti_code == "kGenOrderIDReasonOverrunMonth" then
					msg = Lang.get(48087)
				end
			elseif anti_data.age == 3 then
				if anti_data.anti_code == "kGenOrderIDReasonOverrunSingle" then
					msg = Lang.get(48088)
				elseif anti_data.anti_code == "kGenOrderIDReasonOverrunMonth" then
					msg = Lang.get(48089)
				end
			end
		end

		MsgManager.notice(msg)
	elseif resp_code == "kGenOrderIDCodeUseRefund" or resp_code == "kGenOrderIDCodeUseRebate" then
		isSucc = true
	else
		if resp_code ~= "kGenOrderIDCodeSuccess" then
			isSucc = false
		end

		local extendInfo = ClientUtils.string2Table(extend_str)
		local curRechargeId = RechargeManager._getCurTransaction()

		if isSucc and curRechargeId ~= recharge_id then
			ClientUtils.trySendException("Warning:Unexpected Recharge State", string.format("rechargeId mismatch (%s ~= %s) when calling onRechargeGenerateOrderIDResp", tostring(curRechargeId), tostring(recharge_id)))

			isSucc = false
		end

		local playerInfo = RechargeManager._getPlayerInfo()

		if isSucc and (playerInfo == nil or svr_nodeid ~= playerInfo.serverId) then
			Analytics.sendMonitorWarning("recharge_failed", "invalid playerInfo or serverId mismatch: ")

			isSucc = false
		end

		local sdkOrder

		if isSucc then
			RechargeManager._setCurTransaction(recharge_id, orderid)
			RechargeManager._channelImp:sdkPay(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
		else
			RechargeManager._setCurTransaction()
			MsgManager.notice(Lang.get(30073))
		end
	end

	RechargeManager._openOrderLockTime = nil
end

function RechargeManager._setCurTransaction(rechargeId, openOrderId)
	RechargeManager._curTransRechargeId = rechargeId
	RechargeManager._curTransOrderId = openOrderId
end

function RechargeManager._getCurTransaction()
	return RechargeManager._curTransRechargeId, RechargeManager._curTransOrderId
end

function RechargeManager.onRechargeFinish(isSucc, data)
	RechargeManager._initBase()

	local channelImp = RechargeManager._channelImp
	local curRechargeId, curOrderId
	local curProductId, curOrderId = data[AttName.PRODUCT_ID], data[AttName.OPEN_ORDER_ID]
	local savedRechargeId, savedOrderId = RechargeManager._getCurTransaction()

	if curOrderId then
		if savedOrderId == curOrderId then
			curRechargeId, curOrderId = savedRechargeId, savedOrderId

			RechargeManager._setCurTransaction()
		end
	elseif curProductId then
		local product = RechargeManager.getProductByRechargeId(savedRechargeId)

		if product then
			savedProductId = product.productId

			if curProductId == savedProductId then
				curRechargeId, curOrderId = savedRechargeId, savedOrderId

				RechargeManager._setCurTransaction()
			end
		end
	else
		curRechargeId, curOrderId = RechargeManager._getCurTransaction()

		RechargeManager._setCurTransaction()
	end

	if isSucc then
		if RechargeManager.isInited() then
			RechargeManager._onBoughtBySDK(curRechargeId, curOrderId)
		end
	else
		if curRechargeId then
			RPC.rechargeCancelOrder(curRechargeId, curOrderId or "")
		end

		RechargeManager._showPayError(data)
	end

	if isSucc then
		channelImp:verifyOnRechargeFinish(data, curOrderId)
	end
end

function RechargeManager._showUnfinishedProductTip(productId)
	local curPlayerInfo = RechargeManager._getPlayerInfo()
	local recordedPlayerInfo, msg

	if curPlayerInfo == nil then
		msg = RechargeConst.UNFINISHED_TIP_NO_ROLE

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msg)
	else
		if recordedPlayerInfo == nil then
			msg = RechargeConst.UNFINISHED_TIP_NO_RECORD
		else
			msg = string.format(RechargeConst.UNFINISHED_TIP_HAS_RECORD, recordedPlayerInfo.serverName, recordedPlayerInfo.playerName)
		end

		if msg ~= nil then
			local forceVerify = Slot(RechargeManager._forceVerifyProduct, productId)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, forceVerify, nil)
		end
	end
end

function RechargeManager._forceVerifyProduct(productId)
	RechargeManager._channelImp:verifyWithProductId(productId, true)
end

function RechargeManager._onGameProductsLoaded(requestSucc, gameProductList)
	if not RechargeManager._isBaseInited then
		return
	end

	local gameProducts = RechargeManager._gameProducts

	for _, gameProduct in pairs(gameProductList) do
		local rechargeID = gameProduct.recharge_id
		local gameData = gameProducts[rechargeID]

		if gameData == nil then
			gameData = {}
			gameProducts[rechargeID] = gameData
		end

		gameData.recharge_id = gameProduct.recharge_id
		gameData.product_id = gameProduct.product_id
		gameData.recharge_num = gameProduct.recharge_num
		gameData.first_bonus = gameProduct.first_bonus
		gameData.normal_bonus = gameProduct.normal_bonus
		gameData.period = gameProduct.period
		gameData.fisrt_recharge_flag = gameProduct.fisrt_recharge_flag
		gameData.can_buy_count = gameProduct.can_buy_count
	end

	if requestSucc then
		RechargeManager._isGameProductsLoaded = true

		RechargeManager._checkProductsLoaded()
	end
end

function RechargeManager.onPlatformProductsLoaded(isSucc, products)
	if isSucc and products ~= nil then
		RechargeManager._setPlatformProducts(RechargeManager._parsePlatformProducts(products))
		RechargeManager._checkProductsLoaded()
	end
end

function RechargeManager._parsePlatformProducts(sdkProducts)
	local products = {}

	for _, sdkProduct in pairs(sdkProducts) do
		local newProduct = {}

		newProduct.productId = tostring(sdkProduct[AttName.PRODUCT_ID])
		newProduct.productName = sdkProduct[AttName.ITEM_NAME]
		newProduct.price = sdkProduct[AttName.REAL_PRICE]
		newProduct.platform = tonumber(sdkProduct[AttName.ITEM_PLATFORM])
		products[newProduct.productId] = newProduct

		local currencyCode = sdkProduct[AttName.CURRENCY_CODE]

		if currencyCode == nil then
			currencyCode = ChannelUtil.getCurrencyCode()
		end

		newProduct.currencyCode = currencyCode
	end

	return products
end

function RechargeManager._onRequestProductAndStoreFinish()
	local isSucc = RechargeManager.isInited()

	RechargeManager._isLoading = false
end

function RechargeManager._onBoughtBySDK(rechargeId, openOrderId)
	local product = RechargeManager.getProductByRechargeId(rechargeId)

	if product and product.buyTimesLeft then
		product.buyTimesLeft = math.max(product.buyTimesLeft - 1, 0)

		if RechargeManager.isInited() then
			EventCenter.sendEvent(EventConst.RECHARGE_PRODUCTS_LOAD_END, true)
		end

		product.isFirstRecharge = false

		local currencyCode = product.currencyCode
		local productId = product.productId

		SDKAgent.sendPurchaseInfo(product.price, currencyCode, productId, openOrderId)
	end
end

function RechargeManager.onRoleLogin()
	RechargeManager._channelImp:verifyAll()
end

function RechargeManager._onSdkPayLockRelease()
	return
end

function RechargeManager._onNewDay()
	RechargeManager.refreshGameProducts(true)
end

function RechargeManager.onRechargeDeliverNotify(recharge_id, order_id, deliver_num, deliver_online, item_id, normal_item, expect_item, deliver_free_num, pay_currency, use_refund)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_RECHARGE_DELIVER, recharge_id)
	RechargeManager.refreshGameProducts(true)

	local welType = CurAvatar:getRechage2WelType(recharge_id)
	local nmlAwards = {
		attr = normal_item.attr,
		item = normal_item.item,
		hero = normal_item.hero,
		equip = normal_item.equip,
		artifact = normal_item.artifact
	}
	local spcAwards = {
		attr = expect_item.attr,
		item = expect_item.item,
		hero = expect_item.hero,
		equip = expect_item.equip,
		artifact = expect_item.artifact
	}
	local spcCount = 0

	for _, data in pairs(expect_item) do
		spcCount = spcCount + 1
	end

	local function _slot4CB()
		if not use_refund or use_refund ~= 1 then
			CurAvatar:checkActGiftDrawRechargeNotice(recharge_id)
		end
	end

	if welType == Const.WELFARETYPE_RECHARGEGIFT then
		local item = {}

		if RegionUtils.isJP() then
			item.type = Const.MONEY_TYPE_DIAMOND
			item.value = deliver_free_num

			table.insert(nmlAwards.attr, 1, item)

			item = {
				type = Const.MONEY_TYPE_DIAMOND_BUY,
				value = deliver_num
			}

			table.insert(nmlAwards.attr, 1, item)
		else
			item.type = Const.MONEY_TYPE_DIAMOND
			item.value = deliver_num + deliver_free_num

			table.insert(nmlAwards.attr, 1, item)
		end

		UIManager.getUI("rechargeResultBox", true):onShow(nmlAwards.attr, nmlAwards.item, nmlAwards.hero, nmlAwards.equip, nmlAwards.artifact, nil, _slot4CB)
	elseif welType == Const.WELFARETYPE_MONTHCARD then
		local dayAwards = spcCount ~= 0 and spcAwards or nil

		UIManager.getUI("monthCardResultBox", true):setData(recharge_id, nmlAwards, dayAwards, _slot4CB)
	elseif welType == Const.WELFARETYPE_BPAWARD then
		local ui = UIManager.getUI("mallDlg", nil, false)

		if ui then
			ui:refreshWelData(welType)
		end
	elseif welType == Const.WELFARETYPE_PRIVILEGEMONTHCARD then
		local dayAwards = spcCount ~= 0 and spcAwards or nil

		UIManager.getUI("privilegeMonthCardResultDlg", true):setData(recharge_id, nmlAwards, dayAwards, _slot4CB)
	elseif ResRechargeShow[recharge_id] then
		local type = ResRechargeShow[recharge_id].type

		if type == Const.RECHARGE_SHOW_TYPE_GIFT then
			local ui = UIManager.getUI("showRechargeGiftDlg")

			if ui then
				ui:bindWindow(ui)
				ui:setShow(recharge_id)
				ui:setVisible(true)
			end
		end
	else
		local pushGiftUI = UIManager.getUI("welfarePushGiftDlg", nil, false)

		if pushGiftUI then
			pushGiftUI:setVisible(false)
		end

		local rechargeData = ResRecharge[recharge_id] or {}
		local rechargeType = rechargeData.recharge_type

		if rechargeType ~= Const.RECHARGE_TYPE_MULTIPLE then
			local uiName
			local resultInfo = rechargeType and ResRechargeResultInfo[rechargeType] or nil

			if resultInfo and resultInfo.ui_name then
				uiName = resultInfo.ui_name
			end

			if rechargeType == Const.RECHARGE_TYPE_MONTHCARD then
				local dayAwards = spcCount ~= 0 and spcAwards or nil

				if rechargeData.spec_result == 1 then
					UIManager.getUI("monthCardResultBox2", true):setData(recharge_id, nmlAwards, dayAwards, _slot4CB)
				else
					UIManager.getUI("monthCardResultBox", true):setData(recharge_id, nmlAwards, dayAwards, _slot4CB)
				end
			elseif uiName ~= nil then
				UIManager.getUI(uiName, true):onShow(nmlAwards.attr, nmlAwards.item, nmlAwards.hero, nmlAwards.equip, nmlAwards.artifact, nil, _slot4CB)
			else
				UIManager.getUI("rechargeResultBox", true):onShow(nmlAwards.attr, nmlAwards.item, nmlAwards.hero, nmlAwards.equip, nmlAwards.artifact, nil, _slot4CB)
			end
		else
			MsgManager.clientNotice(395)

			if not use_refund or use_refund ~= 1 then
				CurAvatar:checkActGiftDrawRechargeNotice(recharge_id)
			end
		end
	end

	if ResRecharge[recharge_id] and ResRecharge[recharge_id].vocal_group_id then
		CueManager.playGroupVocal(ResRecharge[recharge_id].vocal_group_id)
	end

	CurAvatar:_showListAttrHeros(nmlAwards.hero)
	RechargeManager._checkTestSDKInfo(recharge_id, pay_currency)
	EventCenter.sendEvent(EventConst.RECHARGE_DELIVER)
end

function RechargeManager._checkTestSDKInfo(recharge_id, pay_currency)
	local rechargeData = ResRecharge[recharge_id]

	if rechargeData then
		if rechargeData.product_id == "com.xgjoy.antman.6" then
			if recharge_id == 100026 then
				SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.MONTH_CARD_6)
			else
				SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.PAY_6)
			end
		elseif rechargeData.product_id == "com.xgjoy.antman.12" then
			SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.PAY_12)
		elseif rechargeData.product_id == "com.xgjoy.antman.30" then
			SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.PAY_30)
		elseif rechargeData.product_id == "com.xgjoy.antman.98" then
			if recharge_id == 100027 then
				SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.MONTH_CARD_98)
			else
				SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.PAY_98)
			end
		end

		if not RegionUtils.isTW() then
			if RegionUtils.isSEA() then
				local data = Analytics.getBiliSeaSendLogPubParameter()

				data.payamount = rechargeData.cost_money
				data.product_id = rechargeData.product_id
				data.currency = pay_currency

				ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
					eventName = "af_buy",
					eventValue = ClientUtils.table2String(data)
				})
				ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
					eventName = "G_buy",
					eventValue = ClientUtils.table2String(data)
				})
			else
				SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.PAY)
			end
		end
	end
end

function RechargeManager._initRetry()
	RechargeManager._retryQueue = {}
	RechargeManager._retryTimer = Timer.New(RechargeManager._pollRetry, RechargeManager.RETRY_TIMER_BASE_TICK, -1)
end

function RechargeManager._destroyRetry()
	if RechargeManager._retryTimer then
		RechargeManager._retryTimer:Stop()

		RechargeManager._retryTimer = nil
	end

	RechargeManager._retryQueue = {}
end

function RechargeManager._addRetryAction(retryAction)
	table.insert(RechargeManager._retryQueue, retryAction)

	if not RechargeManager._retryTimer:IsRunning() then
		RechargeManager._retryTimer:Restart()
	end

	RechargeManager._pollRetry()
end

function RechargeManager._removeRetry(targetType, filter)
	local retryQueue = RechargeManager._retryQueue

	if retryQueue == nil then
		return
	end

	for i = #retryQueue, 1, -1 do
		local curRetry = retryQueue[i]

		if curRetry.actionType == targetType then
			local remove = true

			if filter then
				for k, v in pairs(filter) do
					if curRetry[k] ~= v then
						remove = false
					end
				end
			end

			if remove then
				curRetry.countdown = nil
			end
		end
	end

	RechargeManager._pollRetry()
end

function RechargeManager._pollRetry()
	local tick
	local timeNow = Time.time

	tick = RechargeManager._lastPollTime == nil and 0 or timeNow - RechargeManager._lastPollTime
	RechargeManager._lastPollTime = timeNow

	local retryQueue = RechargeManager._retryQueue
	local stopTimer = true
	local queueLength = retryQueue == nil and 0 or #retryQueue

	for i = queueLength, 1, -1 do
		local curRetry = retryQueue[i]
		local stopRetry = false

		if curRetry.countdown == nil then
			stopRetry = true
		else
			curRetry.countdown = curRetry.countdown - tick

			if curRetry.countdown <= 0 then
				curRetry.retryTimes = curRetry.retryTimes + 1

				local newDuration = curRetry.retryIntervals and curRetry.retryIntervals[curRetry.retryTimes]

				if newDuration then
					curRetry.countdown = newDuration

					if curRetry.action ~= nil then
						curRetry.action(curRetry)
					end
				else
					stopRetry = true
				end
			end
		end

		if stopRetry then
			local callback = curRetry.stopCallback

			table.remove(retryQueue, i)

			curRetry = nil

			if callback then
				callback()
			end
		end

		if curRetry then
			stopTimer = false
		end
	end

	if stopTimer then
		RechargeManager._retryTimer:Stop()

		RechargeManager._lastPollTime = nil
	end
end

function RechargeManager._getPlayerInfo()
	local ca = CurAvatar
	local result

	if ca and ca.isAvatar then
		local info = {}

		info.uid = ca.playerUid
		info.openId = ca.playerOpenId
		info.playerName = ca.playerName

		local serverInfo = SvrListManager.getSelectedSvrInfo()

		if serverInfo then
			info.serverId = serverInfo.id
			info.serverName = serverInfo.name
			result = info
		end
	end

	return result
end

function RechargeManager._getOpenOrder(rechargeId, payType)
	if RechargeManager._isRoleConnected() then
		local order = {}

		order.channelAccount = SDKAgent.getUserID()

		local product = RechargeManager.getProductByRechargeId(rechargeId)
		local payTypeEnum

		if payType ~= nil then
			payTypeEnum = RechargeConst.PAY_TYPE_ENUM[payType]
		end

		if product then
			order.rechargeId = product.rechargeId
			order.productId = tostring(product.productId)
			order.gemAmount = product.rechargeNum
			order.firstBonus = product.firstBonus
			order.normalBonus = product.normalBonus
			order.payTypeEnum = payTypeEnum
			order.extendStr = RechargeManager._channelImp:getOpenOrderReqExtendStr()

			return order
		end
	end

	return nil
end

function RechargeManager._getProductIdFromRechargeId(rechargeId)
	local rechargeData = ResRecharge[rechargeId]
	local productId = rechargeData.product_id

	return productId
end

function RechargeManager.getProducts(rechargeType)
	return RechargeManager._products[rechargeType]
end

function RechargeManager._isPlatformAvaliable(platformType)
	return platformType == RechargeManager.curPlatformType or platformType == 2 and (RechargeManager.curPlatformType == 0 or RechargeManager.curPlatformType == 1) or not IS_PUBLISH_VERSION
end

function RechargeManager._isRoleConnected()
	local ca = CurAvatar

	return AccountManager.isLoggedIn() and ca and ca.isAvatar
end

function RechargeManager._checkAccount()
	if RegionUtils.isCN() then
		if ChannelUtil.isPlat then
			return true
		elseif SDKAgent.isGuest() then
			SDKAgent.bindGuest(SDKConst.Tip.GUEST_FORBID_RECHARGE, nil)

			return false
		end
	end

	return true
end

function RechargeManager._showPayError(data)
	local msg = Lang.get(30074)

	if not RegionUtils.isJP() then
		if data then
			local reason = data[AttName.PAY_RESULT_REASON]

			if reason then
				if string.find(reason, "cancel") or string.find(reason, Lang.get(7)) then
					msg = Lang.get(30075)
				else
					Analytics.logRechargeError("pay_error", reason)
				end
			end
		end
	else
		local code = tonumber(data[AttName.PAY_RESULT_CODE])
		local extraErrorCode = tonumber(data.extraErrorCode)

		if VersionUtils.isOldVersionSDK_jp() then
			if code == -2081 then
				code = -397000
				extraErrorCode = -2081
			elseif code == 206 then
				code = -390009
			end
		end

		if code == -397000 and extraErrorCode and extraErrorCode == -2081 then
			msg = "未成年者の支払限度額に達しているため購入できません。"
		elseif code == -390009 then
			msg = "支払いは取り消されました。"
		else
			msg = string.format("購入に失敗しました。お時間をあけてから再起動した後で再度お試しください（エラーコード：%s, %s）", code, extraErrorCode)

			UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(8), msg)

			return
		end
	end

	MsgManager.notice(msg)
end

function RechargeManager._setProductRecord(productId, info)
	if productId and info then
		if RechargeManager._persistData == nil then
			RechargeManager._persistData = {}
		end

		local persistData = RechargeManager._persistData

		if persistData.productRecords == nil then
			persistData.productRecords = {}
		end

		local productRecords = persistData.productRecords

		productRecords[productId] = info

		UserData.saveCommonData(RechargeConst.KEY_IAP_PERSIST_DATA, ClientUtils.table2String(RechargeManager._persistData))
	end
end

function RechargeManager._getProductRecord(productId)
	if RechargeManager._persistData ~= nil then
		local productRecords = RechargeManager._persistData.productRecords

		if productRecords then
			return productRecords[productId]
		end
	end

	return nil
end

function RechargeManager.checkAbnormalCancel()
	local requestPayTime = RechargeManager._requestPayTime

	if requestPayTime then
		local time = os.time() - requestPayTime

		if time <= RechargeManager.AbnormalCancelTime then
			MsgManager.notice(Lang.get(30076))
		end
	end
end

function RechargeManager.getProductRemainTime(rechargeId)
	local product = RechargeManager.getProductByRechargeId(rechargeId)

	if product then
		return product:getProductRemainTime()
	end
end

return RechargeManager
