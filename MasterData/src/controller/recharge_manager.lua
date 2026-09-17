if DeviceManager.getPackageChannel() == "FY" then
	if config.packagechannel == "palmpi" then
		return require("controller.recharge.recharge_palmpi")
	elseif config.packagechannel == "feiyu" then
		return require("controller.recharge.recharge_feiyu")
	end
end

local var_0_0 = {}
local network = require("network.network")
local l2utils = require("controller.l2utils")
local playermodel = require("model.playermodel")
local recharge_data = require("data.recharge_data")
local net_dispatcher = require("network.net_dispatcher")
local account_manager = require("controller.account_manager")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local time_check_manager = require("controller.time_check_manager")
local net_waitinglayer = require("network.net_waitinglayer")

var_0_0.formalert = false
var_0_0.platform = nil
var_0_0.payRequestingHandler = nil

function removeWaitingLayer()
	net_waitinglayer.removeWaitingLayer()
end

function addWaitingLayer()
	net_waitinglayer.addPurchaseWaitingLayer()
	l2utils:performWithDelay(function()
		removeWaitingLayer()
	end, 5)
end

local var_0_10 = require((string.format("controller.recharge.recharge_%s", (DeviceManager.getPackageChannel()))))

function var_0_0:init(arg_4_1)
	var_0_10:init()

	self.platform = DeviceManager.platform

	self:check_uncomplete_forms(arg_4_1)
	self:init_form_purchase_listener()
	self:initIOSPurchase()
end

function var_0_0.init_form_purchase_listener(arg_5_0)
	net_dispatcher:registerListener(function(arg_6_0)
		arg_5_0:popPurchaseResult(arg_6_0)
	end, "purchase_success")
	net_dispatcher:registerListener(function(arg_7_0)
		local var_7_0 = require("controller.supermarket_privilege_manager"):getInstance()

		var_7_0:removePurchaseWaitingLayer()
		var_7_0:stateUpdate(arg_7_0)
	end, "subscribe_status_change")
end

function var_0_0.initIOSPurchase(arg_8_0)
	if DeviceManager.platform ~= "ios" then
		return
	end

	local ios_purchase_bridge = require("controller.ios_purchase_bridge")

	if not ios_purchase_bridge.canPurchases() then
		return
	end

	local function var_8_1(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		network:rpc("apple_pay_success", {
			receipt_type = "recharge",
			playerid = arg_9_0,
			productid = arg_9_1,
			token = arg_9_2
		}, function(arg_10_0)
			if arg_9_3 then
				arg_9_3(arg_10_0)
			end
		end)
	end

	ios_purchase_bridge.registerPurchasesVerifyHandler(function(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
		local function var_11_0(arg_12_0)
			if arg_12_0.result == 1 then
				ios_purchase_bridge.finishPurchases(arg_11_0, arg_11_1, tostring(arg_11_2), arg_11_3)
			elseif arg_12_0.result == 2 then
				var_8_1(tostring(arg_11_2), arg_11_3, arg_11_1, var_11_0)
			end
		end

		var_8_1(tostring(arg_11_2), arg_11_3, arg_11_1, var_11_0)
	end)
	ios_purchase_bridge.initAOKIPurchases()
end

function var_0_0.getRechargeInfo(arg_13_0, arg_13_1)
	network:rpc("get_recharge_info", {
		client = config.clientmode
	}, function(arg_14_0)
		if arg_14_0.result == 1 then
			local var_14_0 = {}

			for iter_14_0, iter_14_1 in pairs(arg_14_0.products) do
				if recharge_data[iter_14_1.id] then
					table.insert(var_14_0, iter_14_1)
				end
			end

			arg_13_0:updateShopLimitAlertData(var_14_0)

			if arg_13_1 then
				arg_13_1(1, var_14_0, arg_14_0.orderList)
			end
		elseif arg_14_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])

			if arg_13_1 then
				arg_13_1(2)
			end
		elseif arg_14_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])

			if arg_13_1 then
				arg_13_1(3)
			end
		elseif arg_13_1 then
			arg_13_1(0)
		end
	end)
end

function var_0_0.check_uncomplete_forms(arg_15_0, arg_15_1)
	network:rpc("check_uncomplete_form", nil, function(arg_16_0)
		if arg_16_0.result == 1 then
			arg_15_0.formalert = true
		end

		if arg_15_1 then
			arg_15_1()
		end
	end)
end

function var_0_0.requestOrderSign(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = recharge_data[arg_17_1].diamond or 1

	print("Request Order Sign : ", arg_17_1, recharge_data[arg_17_1].productid, recharge_data[arg_17_1].rmb * 100)

	local var_17_1
	local var_17_2

	if SDKManager and SDKManager.getRiskControlInfo then
		var_17_2 = SDKManager:getRiskControlInfo()
	end

	if var_0_10 and var_0_10.getExtra then
		var_17_1 = var_0_10.getExtra()
	end

	local var_17_3

	if account_manager.getChannelUid then
		var_17_3 = account_manager:getChannelUid()
	end

	print("Request Order Sign:", DeviceManager.getChannelID(), recharge_data[arg_17_1].productid, recharge_data[arg_17_1].rmb * 100, var_17_0, account_manager:getChannel(), var_17_2, var_17_3)
	network:rpc("purchase_order_sign", {
		platform = DeviceManager.getChannelID(),
		productid = recharge_data[arg_17_1].productid,
		money = recharge_data[arg_17_1].rmb * 100,
		game_money = var_17_0,
		channelid = account_manager:getChannel(),
		douyin_risk = var_17_2,
		channel_uid = var_17_3,
		extra = var_17_1
	}, function(arg_18_0)
		print(dump(arg_18_0), "Request Order Sign")

		if arg_18_0.result == 1 and arg_17_2 then
			arg_17_2(arg_18_0.outTradeNo, arg_18_0.notifyURL, arg_18_0.sign, arg_18_0.extra, arg_18_0.douyin_param)
		end
	end)
end

function var_0_0.payForAokiSDK(arg_19_0, arg_19_1)
	local var_19_1
	local var_19_2
	local var_19_3
	local var_19_4

	function var_19_1(arg_22_0, arg_22_1)
		local ios_purchase_bridge = require("controller.ios_purchase_bridge")

		ios_purchase_bridge.registerPurchasesHandler(var_19_2)
		ios_purchase_bridge.startPurchases(arg_22_0, arg_22_1)
	end

	function var_19_2(arg_23_0, arg_23_1, arg_23_2)
		if arg_23_0 == 0 then
			var_19_3(arg_23_1, arg_23_2)
		else
			return
		end
	end

	function var_19_3(arg_24_0, arg_24_1)
		addWaitingLayer()

		local playermodel = require("model.playermodel")
		local var_24_1 = recharge_data[arg_19_1].productid

		local function var_24_2(arg_25_0)
			if arg_25_0.result == 1 then
				require("controller.ios_purchase_bridge").finishPurchases(arg_24_0, arg_24_1, tostring(playermodel.playerid), var_24_1)
			elseif arg_25_0.result == 2 then
				var_19_4(tostring(playermodel.playerid), var_24_1, arg_24_1, var_24_2)
			else
				removeWaitingLayer()
			end
		end

		var_19_4(tostring(playermodel.playerid), recharge_data[arg_19_1].productid, arg_24_1, var_24_2)
	end

	function var_19_4(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
		require("network.network"):rpc("apple_pay_success", {
			receipt_type = "recharge",
			playerid = tostring(arg_26_0),
			productid = arg_26_1,
			token = arg_26_2
		}, function(arg_27_0)
			if arg_26_3 then
				arg_26_3(arg_27_0)
			end
		end)
	end

	;(function(arg_20_0)
		require("network.network"):rpc("apple_recharge_request", {
			product = arg_20_0
		}, function(arg_21_0)
			if arg_21_0.result == 1 then
				var_19_1(arg_21_0.uuid, arg_21_0.productid)
			end
		end)
	end)(arg_19_1)
end

function var_0_0:runConfirmPayment(arg_28_1, arg_28_2)
	self:requestOrderSign(arg_28_1, function(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		AnalyticManager.process_payment({
			product = arg_28_1
		})
		var_0_10:doPayment(arg_28_1, arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_28_2)
	end)
end

function var_0_0:confirmPayment(arg_30_1, arg_30_2)
	if arg_30_1 == 1 or arg_30_1 == 90 or arg_30_1 == 365 then
		global_ShowBlockWords("商品无法购买")

		if arg_30_2 then
			arg_30_2(0)
		end

		return
	end

	if self:needCheckHuaweiPrivacy() then
		global_basic_scene:addChild(require("view.Layer.PrivacyPurchaseLayer"):create(function()
			self:runConfirmPayment(arg_30_1, arg_30_2)
		end, function()
			if arg_30_2 then
				arg_30_2(0)
			end
		end), 999)
	elseif require("controller.ios_purchase_bridge").canPurchases() then
		print("Use Aoki Purchase!!!!!!")
		self:payForAokiSDK(arg_30_1)
	else
		self:runConfirmPayment(arg_30_1, arg_30_2)
	end
end

function var_0_0.needCheckHuaweiPrivacy(arg_33_0)
	return false
end

function var_0_0.popPurchaseResult(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_1.remain
	local var_34_1 = 0

	if arg_34_1.diamond and arg_34_1.diamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_34_1.diamond
		var_34_1 = var_34_1 + arg_34_1.diamond
	end

	if arg_34_1.extradiamond and arg_34_1.extradiamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_34_1.extradiamond
		var_34_1 = var_34_1 + arg_34_1.extradiamond
	end

	if arg_34_1.gold and arg_34_1.gold > 0 then
		playermodel.gold = playermodel.gold + arg_34_1.gold
	end

	global_update_gold_stone_diamond(arg_34_1.gold, nil, var_34_1)

	if arg_34_1.sp and arg_34_1.sp > 0 then
		playermodel.strengthpoint = playermodel.strengthpoint + arg_34_1.sp

		GlobalUpdateSp()
	end

	local var_34_2

	if arg_34_1.items then
		var_34_2 = {}

		local item_manager = require("controller.item_manager")

		for iter_34_0, iter_34_1 in pairs(arg_34_1.items) do
			table.insert(var_34_2, {
				entityid = iter_34_1.entityid,
				itemid = iter_34_1.itemid,
				dropNum = item_manager:setItemByServerItem(iter_34_1),
				horcrux_attr = iter_34_1.horcrux_attr
			})
		end
	end

	local var_34_4 = {
		id = arg_34_1.product,
		name = recharge_data[arg_34_1.product].name,
		diamond = arg_34_1.diamond,
		extradiamond = arg_34_1.extradiamond,
		remain = var_34_0,
		gold = arg_34_1.gold,
		sp = arg_34_1.sp,
		items = var_34_2
	}

	if global_basic_scene and (var_34_4.items and next(var_34_4.items) or var_34_4.gold or var_34_4.diamond) then
		var_34_4.openType = var_34_4.items == nil and 2 or 1

		LayerManager:pushInLayer("PopPurchaseResultLayer", var_34_4)
	elseif recharge_data[arg_34_1.product].type == require("controller.supermarket_privilege_recharge_manager"):getInstance().SHOP_TYPE then
		LayerManager:pushInLayer("PrivilegeSuccessTipsLayer")
	else
		global_ShowBlockWords("购买" .. recharge_data[arg_34_1.product].name .. "成功")
	end

	playermodel.haverecharge = true

	local var_34_5 = cc.EventCustom:new("purchase_success")

	var_34_5.id = arg_34_1.product
	var_34_5.remain = var_34_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_34_5)
	removeWaitingLayer()
	AnalyticManager.pay(recharge_data[arg_34_1.product].rmb, 21, var_34_1)
	AnalyticManager.purchaseSuccess({
		product = arg_34_1.product
	})
	AnalyticManager["purchase" .. arg_34_1.product]({
		purchasetime = playermodel.rechargecount,
		rolenum = playermodel:getOwnedServantNum(),
		grade = playermodel.grade,
		class = playermodel.class
	})

	playermodel.rechargecount = playermodel.rechargecount + 1
	playermodel.rechargeamountxinxiya = playermodel.rechargeamountxinxiya + recharge_data[arg_34_1.product].rmb
	playermodel.rechargeamount = playermodel.rechargeamount + recharge_data[arg_34_1.product].rmb
end

function var_0_0:checkalert()
	if self.formalert then
		cc.Director:getInstance():getRunningScene():addChild(PopLayer:PurchaseAlert(), 10004)

		self.formalert = false
	end
end

function var_0_0:updateShopLimitAlertData(arg_36_1)
	if not arg_36_1 then
		print("????????????大兄弟你数据没传")

		return
	end

	self.shopLimitAlert = self.shopLimitAlert or {}

	if not self.cacheProductsData then
		self.cacheProductsData = self:intersectRecharge(arg_36_1)

		self:updateRechargeCacheData(self.cacheProductsData)
	else
		local var_36_0 = self:intersectRecharge(arg_36_1)

		if not self:compareWithCache(var_36_0) then
			self:updateRechargeCacheData(var_36_0)

			self.cacheProductsData = var_36_0
		end
	end
end

function var_0_0.intersectRecharge(arg_37_0, arg_37_1)
	local var_37_0 = {}
	local var_37_1 = {}

	for iter_37_0, iter_37_1 in pairs(shop_timelimit_data) do
		if iter_37_1.rechargeid and recharge_data[iter_37_1.rechargeid] then
			iter_37_1.price = recharge_data[iter_37_1.rechargeid].rmb
		end

		table.insert(var_37_1, iter_37_1)
	end

	local var_37_2 = {}

	if var_37_1 and next(var_37_1) then
		for iter_37_2, iter_37_3 in pairs(var_37_1) do
			local var_37_3 = {}

			if iter_37_3.showchannel then
				for iter_37_4, iter_37_5 in pairs(split(iter_37_3.showchannel, ",")) do
					table.insert(var_37_3, iter_37_5)
				end
			end

			local account_manager = require("controller.account_manager")

			if (not next(var_37_3) or var_37_3[account_manager:getChannel()] or account_manager:getChannel() == "palmpi") and iter_37_3.order and arg_37_1[iter_37_3.rechargeid] then
				iter_37_3.have_bought = arg_37_1[iter_37_3.rechargeid].have_bought
				iter_37_3.buy_limit = arg_37_1[iter_37_3.rechargeid].buy_limit
				iter_37_3.new_tag = arg_37_1[iter_37_3.rechargeid].new_tag
				var_37_2[iter_37_2] = iter_37_3
				var_37_0[iter_37_3.group] = var_37_0[iter_37_3.group] or {}

				table.insert(var_37_0[iter_37_3.group], iter_37_3)
			end
		end
	end

	return var_37_2, var_37_0
end

function var_0_0:compareWithCache(arg_38_1)
	for iter_38_0, iter_38_1 in pairs(arg_38_1) do
		if self.cacheProductsData[iter_38_0] then
			if iter_38_1.have_bought > self.cacheProductsData[iter_38_0].have_bought then
				return false
			end
		else
			return false
		end
	end

	return true
end

function var_0_0:updateRechargeCacheData(arg_39_1)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_39_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_39_0 == "nil" then
			local var_39_1 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_39_1:write((json.encode((self:formatRechargeCacheData(arg_39_1)))))
			var_39_1:flush()
			var_39_1:close()
		else
			local var_39_2 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_39_2:write((json.encode((self:formatRechargeCacheData(arg_39_1, (json.decode(var_39_0)))))))
			var_39_2:flush()
			var_39_2:close()
		end
	else
		local var_39_3 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

		var_39_3:write((json.encode((self:formatRechargeCacheData(arg_39_1)))))
		var_39_3:flush()
		var_39_3:close()
	end
end

function var_0_0:formatRechargeCacheData(arg_40_1, arg_40_2)
	local var_40_0 = {}
	local var_40_1 = {}
	local var_40_2 = arg_40_2 and arg_40_2["id" .. playermodel.playerid]

	if arg_40_2 and arg_40_2["id" .. playermodel.playerid] then
		for iter_40_0, iter_40_1 in pairs(arg_40_1) do
			local var_40_3

			if not var_40_2["shop_" .. iter_40_1.id] then
				var_40_3 = 2
			else
				if var_40_2["shop_" .. iter_40_1.id].alert then
					var_40_3 = var_40_2["shop_" .. iter_40_1.id].alert
				end

				if iter_40_1.new_tag and iter_40_1.new_tag == 1 then
					var_40_3 = var_40_3 and var_40_3 > 1 and var_40_3 or 1
				end

				if shop_timelimit_data[iter_40_1.id] and shop_timelimit_data[iter_40_1.id].end_alert_time then
					local var_40_4 = time_check_manager:getCurTime()

					if var_40_4 > global_get_time_by_date(shop_timelimit_data[iter_40_1.id].end_alert_time) and not global_check_same_day(var_40_4, var_40_2["shop_" .. iter_40_1.id].click_time) then
						var_40_3 = 3
					end
				end
			end

			iter_40_1.alert = var_40_3

			local var_40_5 = {
				alert = var_40_3,
				have_bought = iter_40_1.have_bought
			}

			var_40_5.click_time = var_40_2["shop_" .. iter_40_1.id] and var_40_2["shop_" .. iter_40_1.id].click_time
			var_40_5.group = shop_timelimit_data[iter_40_1.id].group
			var_40_1["shop_" .. iter_40_1.id] = var_40_5
		end
	else
		for iter_40_2, iter_40_3 in pairs(arg_40_1) do
			local var_40_6

			if shop_timelimit_data[iter_40_3.id] and shop_timelimit_data[iter_40_3.id].end_alert_time and time_check_manager:getCurTime() > global_get_time_by_date(shop_timelimit_data[iter_40_3.id].end_alert_time) then
				var_40_6 = 3
			end

			var_40_6 = var_40_6 and var_40_6 > 2 and var_40_6 or 2
			iter_40_3.alert = var_40_6
			var_40_1["shop_" .. iter_40_3.id] = {
				alert = var_40_6,
				have_bought = iter_40_3.have_bought
			}
		end
	end

	self:formatAlertData(var_40_1)

	var_40_0["id" .. playermodel.playerid] = var_40_1

	return var_40_0
end

function var_0_0:formatAlertData(arg_41_1)
	local var_41_0 = {
		{},
		{},
		{}
	}
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if iter_41_1.alert then
			local var_41_2 = tonumber(split(iter_41_0, "_")[2])
			local var_41_3 = shop_timelimit_data[var_41_2] and shop_timelimit_data[var_41_2].group

			if var_41_3 and not var_41_1[var_41_3] then
				table.insert(var_41_0[iter_41_1.alert], var_41_3)

				var_41_1[var_41_3] = true
			end
		end
	end

	self:setShopLimitAlertData(var_41_0)
	print("alert =========", dump(var_41_0))
end

function var_0_0.deletAlertInCache(arg_42_0, arg_42_1, arg_42_2)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_42_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_42_0 == "nil" then
			print("Error:recharge_alert_cache_data.txt doesn't exist")

			return
		else
			local var_42_1 = json.decode(var_42_0)

			for iter_42_0, iter_42_1 in pairs(var_42_1["id" .. playermodel.playerid]) do
				if iter_42_1.group and iter_42_1.group == arg_42_1 then
					if iter_42_1.alert then
						iter_42_1.alert = nil
					end

					iter_42_1.click_time = arg_42_2
				end
			end

			arg_42_0.cacheProductsData = var_42_1["id" .. playermodel.playerid]

			local var_42_2 = cc.FileUtils:getInstance()
			local var_42_3 = assert(io.open(var_42_2:getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_42_3.write(var_42_2, (json.encode(var_42_1)))
			var_42_3:flush()
			var_42_3:close()
		end
	else
		print("Error:recharge_alert_cache_data.txt doesn't exist")

		return
	end
end

function var_0_0.setShopLimitAlertData(arg_43_0, arg_43_1)
	arg_43_0.shopLimitAlert = arg_43_1
end

function var_0_0:getShopLimitAlertData()
	return self.shopLimitAlert
end

function var_0_0.getCommodityPriceStr(arg_45_0, arg_45_1)
	return CITY_CURRENCY_LIST.CN .. (recharge_data[arg_45_1][CITY_KEY_LIST.CN] or "")
end

return var_0_0
