local var_0_0 = lx
local var_0_1 = HMSDKManager.Instance
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.user
local var_0_4 = gamecore.prompt
local var_0_5 = lx.json_decode
local var_0_6 = gamecore.AccountPlatform
local var_0_8 = lx.json_encode
local var_0_9 = gameconfig.shop_config
local var_0_10 = gamecore.UILoader
local var_0_11 = gamecore.UserDataManager
local var_0_12 = gamecore.Language
local var_0_13 = gamecore.NetworkManager
local var_0_14 = "moefantasy.com"

local function var_0_15(arg_1_0)
	return (arg_1_0 or nil) and (arg_1_0.h5_domain or var_0_14)
end

local function var_0_16(arg_2_0)
	if not var_0_1 then
		return
	end

	if not pcall(function()
		return
	end) then
		return
	end

	local var_2_0 = var_0_15(arg_2_0)

	pcall(function()
		var_0_1:SetWechatH5Domain(var_2_0)
	end)
end

local function var_0_17(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if not var_0_1 then
		return false
	end

	if not pcall(function()
		return
	end) then
		return false
	end

	local var_5_0, var_5_1 = pcall(function()
		var_0_1:Pay(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	end)

	return var_5_0
end

local function var_0_18(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
	var_0_16(arg_8_0)

	return var_0_17(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6, arg_8_7)
end

lx.define_class("PayManager", function(arg_9_0)
	function arg_9_0:init()
		self._xiaomi_order_pay_done_sent_ms = nil
		self._xiaomi_internal_waiting_order_pay_done_resp = nil
		self._xiaomi_quiet_network_reconnect_until_ms = nil

		self:payResultCallback()
		self:iapPaySuccessCallback()
		self:iapPayFailCallback()
		self:hoolaiPayResultCallback()

		local var_10_0 = app:getSystem():getChannel()

		if var_10_0 == "xiaomi" or var_10_0 == var_0_2.channel.android_xiaomi then
			self:xiaomiPayResultCallback()
		end

		if var_10_0 == "yyb" or var_10_0 == var_0_2.channel.android_yyb then
			self:yybPayResultCallback()
		end

		self:googlePayPurchaseData()
		self:googlePayPurchaseSignature()
		self:googlePaySuccess()
		self:googlePayUserCancel()
		self:googlePayPurchaseFail()
		self:googlePayQueryFail()
	end

	function arg_9_0.verifyReceipt(arg_11_0)
		local var_11_0 = var_0_11:getDataByID("receipt", (var_0_3:get_account_id()))

		if not var_11_0 or var_11_0 == "" then
			return
		end

		local var_11_1 = var_0_5(var_11_0)

		if not var_11_1 then
			return
		end

		var_0_3:req_OrderPayDoneReq({
			is_succeed = true,
			order_id = var_11_1.order_id,
			receipt = var_11_1.receipt
		})
	end

	function arg_9_0.serverVerify(arg_12_0)
		var_0_11:setDataByID("receipt", var_0_3:get_account_id(), "")
	end

	function arg_9_0.saveCreateiOSOrder(arg_13_0, arg_13_1)
		var_0_11:setDataByID("iospay", var_0_3:get_account_id(), arg_13_1)
	end

	function arg_9_0.waitVerifyReceipt(arg_14_0)
		local var_14_0 = var_0_11:getDataByID("iospay", (var_0_3:get_account_id()))

		if var_14_0 == "1" or var_14_0 == "" then
			return
		end

		local var_14_1 = var_0_6:getProvideContent()
		local var_14_2

		if var_14_1 == nil then
			do return end

			var_14_2 = {
				is_succeed = true
			}
		end

		var_14_2.order_id = var_0_5(var_14_0).order_id
		var_14_2.receipt = var_14_1

		var_0_3:req_OrderPayDoneReq(var_14_2)
	end

	function arg_9_0:pay(arg_15_1)
		local var_15_0 = var_0_10:getInstance("loading")

		if var_15_0 then
			var_15_0:show(true)
			var_15_0:set_mask_active(true)
		end

		local var_15_1 = app:getSystem():getChannel()
		local var_15_2 = var_0_5(arg_15_1.extra_info)

		self._order_id = tostring((var_15_2 or nil) and (var_15_2.trans_id or arg_15_1.order_id))

		if var_15_1 == "xiaomi" or var_15_1 == var_0_2.channel.android_xiaomi then
			local var_15_4 = tostring((var_15_2 or nil) and (var_15_2.trans_id or arg_15_1.order_id))

			self._order_id_for_server = tostring(arg_15_1.order_id)

			local var_15_5 = var_15_2 and tonumber(var_15_2.price) or 0

			if not var_15_5 or var_15_5 <= 0 then
				local var_15_6 = var_15_2 and tonumber(var_15_2.total_fee) or 0

				var_15_5 = var_15_6 and var_15_6 > 0 and math.floor(var_15_6 / 100) or 0
			end

			local var_15_7 = var_15_5

			if var_15_5 <= 0 and arg_15_1.goods_id then
				local var_15_9, var_15_10 = pcall(function()
					return var_0_9.find_object_by_id(arg_15_1.goods_id)
				end)

				if var_15_9 and var_15_10 and var_15_10.price then
					if (tonumber(var_15_10.price) or 0) > 0 then
						var_15_7 = math.floor(tonumber(var_15_10.price) or 0)
					end
				end
			end

			local var_15_12

			if var_15_2 then
				var_15_12 = var_15_2.account_id or ""
			end

			self._xiaomi_order_pay_done_sent_ms = nil
			self._xiaomi_internal_waiting_order_pay_done_resp = nil
			self._xiaomi_quiet_network_reconnect_until_ms = nil

			var_0_13:cancelPendingRequestByName("user.OrderPayDoneReq")
			XiaomiSDKBridge.Instance:PayByAmount(var_15_7, var_15_4, var_15_12)

			return
		end

		if var_15_1 == "yyb" then
			local var_15_14 = tostring((var_15_2 or nil) and (var_15_2.offer_id or var_15_2.midasAppkey or var_15_2.midas_appkey or ""))
			local var_15_15 = tostring((var_15_2 or nil) and (var_15_2.zone_id or "1"))

			self._yyb_order_id = tostring(arg_15_1.order_id)

			local var_15_16 = tostring((var_15_2 or nil) and (var_15_2.bill_no or var_15_2.order_id or ""))
			local var_15_17 = "order_id=" .. (self._yyb_order_id or "") .. "&trans_id=" .. tostring((var_15_2 or nil) and (var_15_2.trans_id or ""))
			local var_15_18 = arg_15_1.goods_id

			if not arg_15_1.goods_id then
				if var_15_2 then
					var_15_18 = var_15_2.goods_id or "0"
				end
			end

			local var_15_19 = tostring(var_15_18)
			local var_15_20 = tostring((var_15_2 or nil) and (var_15_2.title or "道具"))
			local var_15_21 = tonumber(var_15_2 and var_15_2.price) or 0

			if var_15_21 <= 0 and arg_15_1.goods_id then
				local var_15_22, var_15_23 = pcall(function()
					return var_0_9.find_object_by_id(arg_15_1.goods_id)
				end)

				if var_15_22 and var_15_23 then
					if var_15_23.name and var_15_20 == "道具" then
						local var_15_24 = tostring(var_15_23.name)
					end

					local var_15_25 = tonumber(var_15_23.price)

					if var_15_25 and var_15_25 > 0 then
						var_15_21 = math.floor(var_15_25)
					end
				end
			end

			if var_15_21 <= 0 then
				-- block empty
			end

			YYBSDKBridge.Instance:BuyGoods6(var_15_14, var_15_16, var_15_15, var_15_17)

			return
		end

		if var_15_1 == var_0_2.channel.iOS_cn or var_15_1 == var_0_2.channel.iOS_jp then
			local var_15_27 = var_0_9.find_object_by_id(arg_15_1.goods_id).iosIapId

			self:saveCreateiOSOrder(var_0_8({
				goods_id = var_15_27,
				order_id = self._order_id
			}))
			var_0_17(var_15_27, "", "", "", "", "", "")
		elseif var_15_1 == "hm_android_jp" then
			var_0_17(var_0_9.find_object_by_id(arg_15_1.goods_id).iosIapId, "", "", "", "", "")
		elseif var_15_1 == var_0_2.channel.android_cn or var_15_1 == var_0_2.channel.taptap or var_15_1 == var_0_2.channel.android_cn_small then
			var_0_18(var_15_2, var_15_2.account_id, var_15_2.order_id, var_15_2.goods_id, var_15_2.title, var_15_2.price, var_15_2.sign, "")
		else
			var_0_18(var_15_2, var_15_2.account_id, var_15_2.order_id, var_15_2.goods_id, var_15_2.title, var_15_2.price, var_15_2.sign, var_15_2.trans_id)
		end
	end

	function arg_9_0.payResultCallback(arg_18_0)
		function var_0_1.payResult(arg_19_0, arg_19_1)
			if arg_19_0 ~= 0 and arg_19_0 ~= 1 then
				var_0_10:createInstance("loading"):show(false)
				var_0_4:show(var_0_12:getNowLang("errorcode_192"))
			end

			var_0_3:req_OrderPayDoneReq({
				order_id = arg_19_1,
				is_succeed = arg_19_0 == 0
			})
		end
	end

	function arg_9_0.iapPaySuccessCallback(arg_20_0)
		function var_0_1.iapResult(arg_21_0)
			local var_21_0 = var_0_10:getInstance("loading")

			if var_21_0 then
				var_21_0:show(true)
				var_21_0:set_mask_active(true)
			end

			arg_20_0:__save_receipt(arg_20_0._order_id, arg_21_0)
			var_0_3:req_OrderPayDoneReq({
				is_succeed = true,
				order_id = arg_20_0._order_id,
				receipt = arg_21_0
			})
		end
	end

	function arg_9_0.iapPayFailCallback(arg_22_0)
		function var_0_1.iapFailed()
			var_0_4:show(var_0_12:getNowLang("errorcode_192"))
			arg_22_0:saveCreateiOSOrder("1")
			var_0_3:req_OrderPayDoneReq({
				is_succeed = false,
				order_id = arg_22_0._order_id
			})
		end
	end

	function arg_9_0.hoolaiPayResultCallback(arg_24_0)
		function var_0_1.hoolaiPayCallback(arg_25_0)
			local var_25_0 = false
			local var_25_1 = var_0_0.json_decode(arg_25_0)

			if var_25_1.resultCode == var_0_2.hoolai_callback_type.Type_Pay_Success then
				var_25_0 = true
			end

			if var_25_1.resultCode == var_0_2.hoolai_callback_type.Type_Pay_Fail then
				var_25_0 = false

				var_0_10:createInstance("loading"):show(false)
				var_0_4:show(var_0_12:getNowLang("errorcode_192"))
			end

			var_0_3:req_OrderPayDoneReq({
				order_id = arg_24_0._order_id,
				is_succeed = var_25_0
			})
		end
	end

	function arg_9_0.xiaomiPayResultCallback(arg_26_0)
		local var_26_0 = app:getSystem():getChannel()

		if var_26_0 ~= "xiaomi" and var_26_0 ~= var_0_2.channel.android_xiaomi then
			return
		end

		function XiaomiSDKBridge.Instance.xiaomiPayCallback(arg_27_0)
			local var_27_0 = {}

			for iter_27_0 in string.gmatch(arg_27_0, "[^|]+") do
				table.insert(var_27_0, iter_27_0)
			end

			if #var_27_0 < 2 then
				return
			end

			local var_27_1 = tonumber(var_27_0[1])
			local var_27_3 = var_0_10:getInstance("loading")

			if var_27_3 then
				var_27_3:show(false)
			end

			if var_27_1 == 0 then
				arg_26_0._xiaomi_internal_waiting_order_pay_done_resp = true
				arg_26_0._last_verify_was_xiaomi_internal = true

				var_0_13:cancelPendingRequestByName("user.OrderPayDoneReq")

				local var_27_5 = {
					is_succeed = true
				}

				var_27_5.order_id = arg_26_0._order_id_for_server or var_27_0[2]

				var_0_3:req_OrderPayDoneReq(var_27_5)

				arg_26_0._xiaomi_order_pay_done_sent_ms = var_0_0.Time:getTime()
			elseif var_27_1 == -12 or var_27_1 == -18004 then
				arg_26_0._xiaomi_order_pay_done_sent_ms = nil
				arg_26_0._xiaomi_internal_waiting_order_pay_done_resp = nil
			elseif var_27_1 == -18005 then
				arg_26_0._xiaomi_order_pay_done_sent_ms = nil
				arg_26_0._xiaomi_internal_waiting_order_pay_done_resp = nil
			else
				arg_26_0._xiaomi_order_pay_done_sent_ms = nil
				arg_26_0._xiaomi_internal_waiting_order_pay_done_resp = nil
			end
		end
	end

	function arg_9_0.yybPayResultCallback(arg_28_0)
		local var_28_0 = app:getSystem():getChannel()

		if var_28_0 ~= "yyb" and var_28_0 ~= var_0_2.channel.android_yyb then
			return
		end

		function YYBSDKBridge.Instance.yybPayCallback(arg_29_0)
			local var_29_0 = {}

			for iter_29_0 in string.gmatch(arg_29_0, "[^|]+") do
				table.insert(var_29_0, iter_29_0)
			end

			local var_29_1 = var_0_10:getInstance("loading")

			if var_29_1 then
				var_29_1:show(false)
			end

			if #var_29_0 < 1 then
				return
			end

			local var_29_2 = tonumber(var_29_0[1]) or -1

			if not tonumber(var_29_0[2]) then
				-- block empty
			end

			if var_29_2 == 0 then
				var_0_13:cancelPendingRequestByName("user.OrderPayDoneReq")
				var_0_3:req_OrderPayDoneReq({
					is_succeed = true,
					order_id = arg_28_0._yyb_order_id
				})
			elseif var_29_2 == 1 then
				-- block empty
			else
				var_0_4:show(var_0_12:getNowLang("errorcode_192"))
				var_0_3:req_OrderPayDoneReq({
					is_succeed = false,
					order_id = arg_28_0._yyb_order_id
				})
			end
		end
	end

	function arg_9_0.googlePaySuccess(arg_30_0)
		function var_0_1.googlePaySucess(arg_31_0)
			local var_31_0 = var_0_8({
				inapp_data_signature = arg_30_0._google_pay_signature,
				inapp_purchase_data = encode.base64_encode(arg_30_0._google_pay_json)
			})

			arg_30_0:__save_receipt(arg_30_0._order_id, var_31_0)
			var_0_3:req_OrderPayDoneReq({
				is_succeed = true,
				order_id = arg_30_0._order_id,
				receipt = var_31_0
			})
		end
	end

	function arg_9_0.googlePayPurchaseData(arg_32_0)
		function var_0_1.googlePayPurchaseData(arg_33_0)
			arg_32_0._google_pay_json = string.gsub(arg_33_0, "Purchase. Json: ", "")
		end
	end

	function arg_9_0.googlePayPurchaseSignature(arg_34_0)
		function var_0_1.googlePayPurchaseSignature(arg_35_0)
			arg_34_0._google_pay_signature = arg_35_0
		end
	end

	function arg_9_0.googlePayUserCancel(arg_36_0)
		function var_0_1.googlePayUserCancel(arg_37_0)
			local var_37_0 = var_0_10:getInstance("loading")

			if var_37_0 then
				var_37_0:show(false)
			end

			var_0_3:req_OrderPayDoneReq({
				is_succeed = false,
				order_id = arg_36_0._order_id
			})
		end
	end

	function arg_9_0.googlePayPurchaseFail(arg_38_0)
		function var_0_1.googlePayPurchaseFail(arg_39_0)
			local var_39_0 = var_0_10:getInstance("loading")

			if var_39_0 then
				var_39_0:show(false)
			end

			var_0_3:req_OrderPayDoneReq({
				is_succeed = false,
				order_id = arg_38_0._order_id
			})
		end
	end

	function arg_9_0.googlePayQueryFail(arg_40_0)
		function var_0_1.googlePayQueryFailCallback(arg_41_0)
			local var_41_0 = var_0_10:getInstance("loading")

			if var_41_0 then
				var_41_0:show(false)
			end

			var_0_4:show(var_0_12:getNowLang("operatingfastnotice"))
		end
	end

	function arg_9_0.__hoolai_pay_success(arg_42_0, arg_42_1)
		return
	end

	function arg_9_0.__hoolai_pay_fail(arg_43_0, arg_43_1)
		return
	end

	function arg_9_0.__save_receipt(arg_44_0, arg_44_1, arg_44_2)
		var_0_11:setDataByID("receipt", var_0_3:get_account_id(), var_0_8({
			order_id = arg_44_1,
			receipt = arg_44_2
		}))
	end
end)

return function()
	local var_45_0 = var_0_0.class("PayManager")

	var_45_0._order_id = nil
	var_45_0._yyb_order_id = nil
	var_45_0._ipa_account_id_list = {}

	return var_45_0
end
