local var_0_0 = {}
local network = require("network.network")
local net_dispatcher = require("network.net_dispatcher")
local playermodel = require("model.playermodel")
local account_manager = require("controller.account_manager")
local l2utils = require("controller.l2utils")
local recharge_data = require("data.recharge_data")
local shop_timelimit_data = require("data.shop.shop_timelimit_data")
local time_check_manager = require("controller.time_check_manager")

require("view.Layer.PopLayer")

local net_waitinglayer = require("network.net_waitinglayer")

var_0_0.formalert = false
var_0_0.platform = nil
var_0_0.payRequestingHandler = nil

local function var_0_10(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_0 == 0 then
		if var_0_0.payRequestingHandler then
			var_0_0.payRequestingHandler(1, arg_1_1)
		end
	elseif var_0_0.payRequestingHandler then
		var_0_0.payRequestingHandler(0, arg_1_1, arg_1_2)
	end
end

function var_0_0:init(arg_2_1)
	self.platform = FeiyuManager.getplatform()

	FeiyuManager.registerPayHandler(var_0_10)
	self:check_uncomplete_forms(arg_2_1)
	self:init_form_purchase_listener()
	self:initIOSPurchase()
end

function var_0_0.init_form_purchase_listener(arg_3_0)
	net_dispatcher:registerListener(function(arg_4_0)
		arg_3_0:popPurchaseResult(arg_4_0)
	end, "purchase_success")
	net_dispatcher:registerListener(function(arg_5_0)
		local var_5_0 = require("controller.supermarket_privilege_manager"):getInstance()

		var_5_0:removePurchaseWaitingLayer()
		var_5_0:stateUpdate(arg_5_0)
	end, "subscribe_status_change")
end

function var_0_0.initIOSPurchase(arg_6_0)
	if DeviceManager.platform ~= "ios" then
		return
	end

	local ios_purchase_bridge = require("controller.ios_purchase_bridge")

	if not ios_purchase_bridge.canPurchases() then
		return
	end

	local function var_6_1(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
		network:rpc("apple_pay_success", {
			receipt_type = "recharge",
			playerid = arg_7_0,
			productid = arg_7_1,
			token = arg_7_2
		}, function(arg_8_0)
			if arg_7_3 then
				arg_7_3(arg_8_0)
			end
		end)
	end

	ios_purchase_bridge.registerPurchasesVerifyHandler(function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
		local function var_9_0(arg_10_0)
			if arg_10_0.result == 1 then
				ios_purchase_bridge.finishPurchases(arg_9_0, arg_9_1, tostring(arg_9_2), arg_9_3)
			elseif arg_10_0.result == 2 then
				var_6_1(tostring(arg_9_2), arg_9_3, arg_9_1, var_9_0)
			end
		end

		var_6_1(tostring(arg_9_2), arg_9_3, arg_9_1, var_9_0)
	end)
	ios_purchase_bridge.initAOKIPurchases()
end

function var_0_0.getRechargeInfo(arg_11_0, arg_11_1)
	network:rpc("get_recharge_info", {
		client = config.clientmode
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			local var_12_0 = {}

			for iter_12_0, iter_12_1 in pairs(arg_12_0.products) do
				if recharge_data[iter_12_1.id] then
					table.insert(var_12_0, iter_12_1)
				end
			end

			arg_11_0:updateShopLimitAlertData(var_12_0)

			if arg_11_1 then
				arg_11_1(1, var_12_0, arg_12_0.orderList)
			end
		elseif arg_12_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])

			if arg_11_1 then
				arg_11_1(2)
			end
		elseif arg_12_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])

			if arg_11_1 then
				arg_11_1(3)
			end
		elseif arg_11_1 then
			arg_11_1(0)
		end
	end)
end

function var_0_0.check_uncomplete_forms(arg_13_0, arg_13_1)
	network:rpc("check_uncomplete_form", nil, function(arg_14_0)
		if arg_14_0.result == 1 then
			arg_13_0.formalert = true
		end

		if arg_13_1 then
			arg_13_1()
		end
	end)
end

local function var_0_11()
	net_waitinglayer.removeWaitingLayer()
end

local function var_0_12()
	net_waitinglayer.addPurchaseWaitingLayer()
	l2utils:performWithDelay(function()
		var_0_11()
	end, 5)
end

function var_0_0.doPayment(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = recharge_data[arg_18_1]
	local var_18_1 = {
		notifyExt = "{}",
		paySignType = "rsa",
		playerId = tostring(playermodel.playerid),
		playerName = playermodel.nickname,
		playerLevel = tostring(playermodel.grade),
		serverId = FeiyuManager.getServerID(),
		goodsId = recharge_data[arg_18_1].productid,
		goodsName = recharge_data[arg_18_1].name,
		payAmount = tostring(recharge_data[arg_18_1].rmb * 100),
		gameOrderId = arg_18_2
	}
	local var_18_2 = account_manager:getChannel() == "1000" and "0" or "1"

	arg_18_0.payRequestingHandler = function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == 1 then
			FeiyuManager.recordPaySuccess(tostring(playermodel.playerid), FeiyuManager.getServerID(), arg_19_1, tostring(var_18_0.rmb * 100), var_18_0.productid, var_18_2)
			TrackingManager.pay(var_18_1.gameOrderId, FeiyuManager.getplatform(), "CNY", var_18_0.rmb)
			var_0_12()
		elseif arg_18_4 then
			arg_18_4(arg_19_0)
		end
	end, print("PayInfo: ", dump(var_18_1))

	TrackingManager.order(var_18_1.gameOrderId, "CNY", var_18_0.rmb)
	FeiyuManager.recordStartPay(tostring(playermodel.playerid), FeiyuManager.getServerID(), arg_18_2, tostring(var_18_0.rmb * 100), var_18_0.productid, var_18_2)
	FeiyuManager.pay(var_18_1)
end

function var_0_0.requestOrderSign(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = recharge_data[arg_20_1].diamond or 1

	print("Request Order Sign: ", arg_20_1, recharge_data[arg_20_1].productid, recharge_data[arg_20_1].rmb * 100)
	network:rpc("purchase_order_sign", {
		platform = DeviceManager.getChannelID(),
		productid = recharge_data[arg_20_1].productid,
		money = recharge_data[arg_20_1].rmb * 100,
		game_money = var_20_0,
		channelid = account_manager:getChannel()
	}, function(arg_21_0)
		if arg_21_0.result == 1 and arg_20_2 then
			arg_20_2(arg_21_0.outTradeNo, arg_21_0.notifyURL)
		end
	end)
end

function var_0_0.payForAokiSDK(arg_22_0, arg_22_1)
	local var_22_1
	local var_22_2
	local var_22_3
	local var_22_4

	function var_22_1(arg_25_0, arg_25_1)
		local ios_purchase_bridge = require("controller.ios_purchase_bridge")

		ios_purchase_bridge.registerPurchasesHandler(var_22_2)
		ios_purchase_bridge.startPurchases(arg_25_0, arg_25_1)
	end

	function var_22_2(arg_26_0, arg_26_1, arg_26_2)
		if arg_26_0 == 0 then
			var_22_3(arg_26_1, arg_26_2)
		else
			return
		end
	end

	function var_22_3(arg_27_0, arg_27_1)
		var_0_12()

		local playermodel = require("model.playermodel")
		local var_27_1 = recharge_data[arg_22_1].productid

		local function var_27_2(arg_28_0)
			if arg_28_0.result == 1 then
				require("controller.ios_purchase_bridge").finishPurchases(arg_27_0, arg_27_1, tostring(playermodel.playerid), var_27_1)
			elseif arg_28_0.result == 2 then
				var_22_4(tostring(playermodel.playerid), var_27_1, arg_27_1, var_27_2)
			else
				var_0_11()
			end
		end

		var_22_4(tostring(playermodel.playerid), recharge_data[arg_22_1].productid, arg_27_1, var_27_2)
	end

	function var_22_4(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
		require("network.network"):rpc("apple_pay_success", {
			receipt_type = "recharge",
			playerid = tostring(arg_29_0),
			productid = arg_29_1,
			token = arg_29_2
		}, function(arg_30_0)
			if arg_29_3 then
				arg_29_3(arg_30_0)
			end
		end)
	end

	;(function(arg_23_0)
		require("network.network"):rpc("apple_recharge_request", {
			product = arg_23_0
		}, function(arg_24_0)
			if arg_24_0.result == 1 then
				var_22_1(arg_24_0.uuid, arg_24_0.productid)
			end
		end)
	end)(arg_22_1)
end

function var_0_0.runConfirmPayment(arg_31_0, arg_31_1, arg_31_2)
	FeiyuManager.registerLimitPayHandler(function(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
		print("limit pay result: ", arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)

		if arg_32_0 == 0 then
			if require("controller.ios_purchase_bridge").canPurchases() then
				print("Use Aoki Purchase!!!!!!")
				arg_31_0:payForAokiSDK(arg_31_1)
			else
				print("Use Feiyu Purchase!!!!!!")
				arg_31_0:requestOrderSign(arg_31_1, function(arg_33_0, arg_33_1)
					arg_31_0:doPayment(arg_31_1, arg_33_0, arg_33_1, arg_31_2)
				end)
			end
		elseif arg_31_2 then
			arg_31_2(0)
		end
	end)
	FeiyuManager.limitPay(tostring(playermodel.playerid), FeiyuManager.getServerID(), account_manager:getUserID(), tostring(recharge_data[arg_31_1].rmb * 100), "")
end

function var_0_0:confirmPayment(arg_34_1, arg_34_2)
	if arg_34_1 == 1 or arg_34_1 == 90 or arg_34_1 == 365 then
		global_ShowBlockWords("商品无法购买")

		if arg_34_2 then
			arg_34_2(0)
		end

		return
	end

	if self:needCheckHuaweiPrivacy() then
		global_basic_scene:addChild(require("view.Layer.PrivacyPurchaseLayer"):create(function()
			self:runConfirmPayment(arg_34_1, arg_34_2)
		end, function()
			if arg_34_2 then
				arg_34_2(0)
			end
		end), 999)
	elseif require("controller.ios_purchase_bridge").canPurchases() then
		print("Use Aoki Purchase!!!!!!")
		self:payForAokiSDK(arg_34_1)
	else
		self:runConfirmPayment(arg_34_1, arg_34_2)
	end
end

function var_0_0.needCheckHuaweiPrivacy(arg_37_0)
	if config.packagechannel ~= "feiyu" then
		return false
	end

	if account_manager:getChannel() ~= "270054" then
		return false
	end

	if not FySDK.showPrivacyDialog then
		return false
	end

	return not cc.UserDefault:getInstance():getBoolForKey("agreehuaweipurchase", false)
end

function var_0_0.popPurchaseResult(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_1.remain
	local var_38_1 = 0

	if arg_38_1.diamond and arg_38_1.diamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_38_1.diamond
		var_38_1 = var_38_1 + arg_38_1.diamond
	end

	if arg_38_1.extradiamond and arg_38_1.extradiamond > 0 then
		playermodel.diamond = playermodel.diamond + arg_38_1.extradiamond
		var_38_1 = var_38_1 + arg_38_1.extradiamond
	end

	if arg_38_1.gold and arg_38_1.gold > 0 then
		playermodel.gold = playermodel.gold + arg_38_1.gold
	end

	global_update_gold_stone_diamond(arg_38_1.gold, nil, var_38_1)

	if arg_38_1.sp and arg_38_1.sp > 0 then
		playermodel.strengthpoint = playermodel.strengthpoint + arg_38_1.sp

		GlobalUpdateSp()
	end

	local var_38_2

	if arg_38_1.items then
		var_38_2 = {}

		local item_manager = require("controller.item_manager")

		for iter_38_0, iter_38_1 in pairs(arg_38_1.items) do
			table.insert(var_38_2, {
				entityid = iter_38_1.entityid,
				itemid = iter_38_1.itemid,
				dropNum = item_manager:setItemByServerItem(iter_38_1),
				horcrux_attr = iter_38_1.horcrux_attr
			})
		end
	end

	local var_38_4 = {
		id = arg_38_1.product,
		name = recharge_data[arg_38_1.product].name,
		diamond = arg_38_1.diamond,
		extradiamond = arg_38_1.extradiamond,
		remain = var_38_0,
		gold = arg_38_1.gold,
		sp = arg_38_1.sp,
		items = var_38_2
	}

	if global_basic_scene and (var_38_4.items and next(var_38_4.items) or var_38_4.gold or var_38_4.diamond) then
		var_38_4.openType = var_38_4.items == nil and 2 or 1

		LayerManager:pushInLayer("PopPurchaseResultLayer", var_38_4)
	elseif recharge_data[arg_38_1.product].type == require("controller.supermarket_privilege_recharge_manager"):getInstance().SHOP_TYPE then
		LayerManager:pushInLayer("PrivilegeSuccessTipsLayer")
	else
		global_ShowBlockWords("购买" .. recharge_data[arg_38_1.product].name .. "成功")
	end

	playermodel.haverecharge = true

	local var_38_5 = cc.EventCustom:new("purchase_success")

	var_38_5.id = arg_38_1.product
	var_38_5.remain = var_38_0

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_38_5)
	var_0_11()
	AnalyticManager.pay(recharge_data[arg_38_1.product].rmb, 21, var_38_1)
	AnalyticManager.purchaseSuccess({
		product = arg_38_1.product
	})
	AnalyticManager["purchase" .. arg_38_1.product]({
		purchasetime = playermodel.rechargecount,
		rolenum = playermodel:getOwnedServantNum(),
		grade = playermodel.grade,
		class = playermodel.class
	})

	playermodel.rechargecount = playermodel.rechargecount + 1
	playermodel.rechargeamountxinxiya = playermodel.rechargeamountxinxiya + recharge_data[arg_38_1.product].rmb
	playermodel.rechargeamount = playermodel.rechargeamount + recharge_data[arg_38_1.product].rmb
end

function var_0_0:checkalert()
	if self.formalert then
		cc.Director:getInstance():getRunningScene():addChild(PopLayer:PurchaseAlert(), 10004)

		self.formalert = false
	end
end

function var_0_0:updateShopLimitAlertData(arg_40_1)
	if not arg_40_1 then
		print("????????????大兄弟你数据没传")

		return
	end

	self.shopLimitAlert = self.shopLimitAlert or {}

	if not self.cacheProductsData then
		self.cacheProductsData = self:intersectRecharge(arg_40_1)

		self:updateRechargeCacheData(self.cacheProductsData)
	else
		local var_40_0 = self:intersectRecharge(arg_40_1)

		if not self:compareWithCache(var_40_0) then
			self:updateRechargeCacheData(var_40_0)

			self.cacheProductsData = var_40_0
		end
	end
end

function var_0_0.intersectRecharge(arg_41_0, arg_41_1)
	local var_41_0 = {}
	local var_41_1 = {}

	for iter_41_0, iter_41_1 in pairs(shop_timelimit_data) do
		if iter_41_1.rechargeid and recharge_data[iter_41_1.rechargeid] then
			iter_41_1.price = recharge_data[iter_41_1.rechargeid].rmb
		end

		table.insert(var_41_1, iter_41_1)
	end

	local var_41_2 = {}

	if var_41_1 and next(var_41_1) then
		for iter_41_2, iter_41_3 in pairs(var_41_1) do
			local var_41_3 = {}

			if iter_41_3.showchannel then
				for iter_41_4, iter_41_5 in pairs(split(iter_41_3.showchannel, ",")) do
					table.insert(var_41_3, iter_41_5)
				end
			end

			local account_manager = require("controller.account_manager")

			if (not next(var_41_3) or var_41_3[account_manager:getChannel()] or account_manager:getChannel() == "palmpi") and iter_41_3.order and arg_41_1[iter_41_3.rechargeid] then
				iter_41_3.have_bought = arg_41_1[iter_41_3.rechargeid].have_bought
				iter_41_3.buy_limit = arg_41_1[iter_41_3.rechargeid].buy_limit
				iter_41_3.new_tag = arg_41_1[iter_41_3.rechargeid].new_tag
				var_41_2[iter_41_2] = iter_41_3
				var_41_0[iter_41_3.group] = var_41_0[iter_41_3.group] or {}

				table.insert(var_41_0[iter_41_3.group], iter_41_3)
			end
		end
	end

	return var_41_2, var_41_0
end

function var_0_0:compareWithCache(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(arg_42_1) do
		if self.cacheProductsData[iter_42_0] then
			if iter_42_1.have_bought > self.cacheProductsData[iter_42_0].have_bought then
				return false
			end
		else
			return false
		end
	end

	return true
end

function var_0_0:updateRechargeCacheData(arg_43_1)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_43_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_43_0 == "nil" then
			local var_43_1 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_43_1:write((json.encode((self:formatRechargeCacheData(arg_43_1)))))
			var_43_1:flush()
			var_43_1:close()
		else
			local var_43_2 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_43_2:write((json.encode((self:formatRechargeCacheData(arg_43_1, (json.decode(var_43_0)))))))
			var_43_2:flush()
			var_43_2:close()
		end
	else
		local var_43_3 = assert(io.open(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

		var_43_3:write((json.encode((self:formatRechargeCacheData(arg_43_1)))))
		var_43_3:flush()
		var_43_3:close()
	end
end

function var_0_0:formatRechargeCacheData(arg_44_1, arg_44_2)
	local var_44_0 = {}
	local var_44_1 = {}
	local var_44_2 = arg_44_2 and arg_44_2["id" .. playermodel.playerid]

	if arg_44_2 and arg_44_2["id" .. playermodel.playerid] then
		for iter_44_0, iter_44_1 in pairs(arg_44_1) do
			local var_44_3

			if not var_44_2["shop_" .. iter_44_1.id] then
				var_44_3 = 2
			else
				if var_44_2["shop_" .. iter_44_1.id].alert then
					var_44_3 = var_44_2["shop_" .. iter_44_1.id].alert
				end

				if iter_44_1.new_tag and iter_44_1.new_tag == 1 then
					var_44_3 = var_44_3 and var_44_3 > 1 and var_44_3 or 1
				end

				if shop_timelimit_data[iter_44_1.id] and shop_timelimit_data[iter_44_1.id].end_alert_time then
					local var_44_4 = time_check_manager:getCurTime()

					if var_44_4 > global_get_time_by_date(shop_timelimit_data[iter_44_1.id].end_alert_time) and not global_check_same_day(var_44_4, var_44_2["shop_" .. iter_44_1.id].click_time) then
						var_44_3 = 3
					end
				end
			end

			iter_44_1.alert = var_44_3

			local var_44_5 = {
				alert = var_44_3,
				have_bought = iter_44_1.have_bought
			}

			var_44_5.click_time = var_44_2["shop_" .. iter_44_1.id] and var_44_2["shop_" .. iter_44_1.id].click_time
			var_44_5.group = shop_timelimit_data[iter_44_1.id].group
			var_44_1["shop_" .. iter_44_1.id] = var_44_5
		end
	else
		for iter_44_2, iter_44_3 in pairs(arg_44_1) do
			local var_44_6

			if shop_timelimit_data[iter_44_3.id] and shop_timelimit_data[iter_44_3.id].end_alert_time and time_check_manager:getCurTime() > global_get_time_by_date(shop_timelimit_data[iter_44_3.id].end_alert_time) then
				var_44_6 = 3
			end

			var_44_6 = var_44_6 and var_44_6 > 2 and var_44_6 or 2
			iter_44_3.alert = var_44_6
			var_44_1["shop_" .. iter_44_3.id] = {
				alert = var_44_6,
				have_bought = iter_44_3.have_bought
			}
		end
	end

	self:formatAlertData(var_44_1)

	var_44_0["id" .. playermodel.playerid] = var_44_1

	return var_44_0
end

function var_0_0:formatAlertData(arg_45_1)
	local var_45_0 = {
		{},
		{},
		{}
	}
	local var_45_1 = {}

	for iter_45_0, iter_45_1 in pairs(arg_45_1) do
		if iter_45_1.alert then
			local var_45_2 = tonumber(split(iter_45_0, "_")[2])
			local var_45_3 = shop_timelimit_data[var_45_2] and shop_timelimit_data[var_45_2].group

			if var_45_3 and not var_45_1[var_45_3] then
				table.insert(var_45_0[iter_45_1.alert], var_45_3)

				var_45_1[var_45_3] = true
			end
		end
	end

	self:setShopLimitAlertData(var_45_0)
	print("alert =========", dump(var_45_0))
end

function var_0_0.deletAlertInCache(arg_46_0, arg_46_1, arg_46_2)
	if cc.FileUtils:getInstance():isFileExist(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt") then
		local var_46_0 = cc.FileUtils:getInstance():getStringFromFile(cc.FileUtils:getInstance():getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt")

		if var_46_0 == "nil" then
			print("Error:recharge_alert_cache_data.txt doesn't exist")

			return
		else
			local var_46_1 = json.decode(var_46_0)

			for iter_46_0, iter_46_1 in pairs(var_46_1["id" .. playermodel.playerid]) do
				if iter_46_1.group and iter_46_1.group == arg_46_1 then
					if iter_46_1.alert then
						iter_46_1.alert = nil
					end

					iter_46_1.click_time = arg_46_2
				end
			end

			arg_46_0.cacheProductsData = var_46_1["id" .. playermodel.playerid]

			local var_46_2 = cc.FileUtils:getInstance()
			local var_46_3 = assert(io.open(var_46_2:getWritablePath() .. "/recharge_alert_cache_data" .. playermodel.playerid .. ".txt", "w+"))

			var_46_3.write(var_46_2, (json.encode(var_46_1)))
			var_46_3:flush()
			var_46_3:close()
		end
	else
		print("Error:recharge_alert_cache_data.txt doesn't exist")

		return
	end
end

function var_0_0.setShopLimitAlertData(arg_47_0, arg_47_1)
	arg_47_0.shopLimitAlert = arg_47_1
end

function var_0_0:getShopLimitAlertData()
	return self.shopLimitAlert
end

function var_0_0.getCommodityPriceStr(arg_49_0, arg_49_1)
	return CITY_CURRENCY_LIST.CN .. (recharge_data[arg_49_1][CITY_KEY_LIST.CN] or "")
end

return var_0_0
