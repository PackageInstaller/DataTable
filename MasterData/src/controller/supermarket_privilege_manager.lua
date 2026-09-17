local SupermarketPrivilegeManager = class("SupermarketPrivilegeManager", (require("controller.base_manager")))

SupermarketPrivilegeManager.MULTITON_MSG = "SupermarketPrivilegeManager instancealready constructed!"
SupermarketPrivilegeManager.SHOP_TYPE = 105
SupermarketPrivilegeManager.SUBSCRIBE_STATUS = {
	Have = 1,
	Cancel = 2,
	No = 0
}
SupermarketPrivilegeManager.PROTOCOL_KEY = "SupermarketPrivilege_Key"

function SupermarketPrivilegeManager:ctor()
	SupermarketPrivilegeManager.super.ctor(self)

	self._info = {
		remain = 0,
		subscribe_status = SupermarketPrivilegeManager.SUBSCRIBE_STATUS.No
	}
	self._protocolState = require("controller.RoleDefault"):getInstance():getBoolForKey(SupermarketPrivilegeManager.PROTOCOL_KEY, false)
	self._config = {}

	for iter_1_0, iter_1_1 in pairs((require("data.privilege_conf"))) do
		self._config[#self._config + 1] = iter_1_1
	end

	table.sort(self._config, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)
end

function SupermarketPrivilegeManager:requestInfo(arg_3_1)
	require("network.network"):rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			105
		}
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.products and arg_4_0.products[1] then
				self._info = arg_4_0.products[1]

				if require("controller.device_manager").platform == "android" then
					for iter_4_0, iter_4_1 in pairs(arg_4_0.products) do
						if iter_4_1.id == 98001 then
							self._info = iter_4_1

							break
						end
					end
				end
			else
				self._info = {
					remain = 0,
					subscribe_status = SupermarketPrivilegeManager.SUBSCRIBE_STATUS.No
				}
			end

			self:handlerInfo(arg_4_0)
		elseif arg_4_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])
		elseif arg_4_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])
		end
	end)
end

function SupermarketPrivilegeManager:requestBuyMonthlyCard(arg_5_1)
	local var_5_0 = self._info

	if not self:getProtocolState() then
		global_ShowBlockWords("请先确认同意协议")

		return
	end

	if self:haveSubscribe() then
		global_ShowBlockWords("当前已订阅")

		return
	end

	if not self:canClientSubscribe() then
		global_ShowBlockWords("无法发起订阅")

		return
	end

	local recharge_data = require("data.recharge_data")

	require("network.network"):rpc("get_recharge_items_drop", {
		id = self._info.id
	}, function(arg_6_0)
		arg_6_0.id = var_5_0.id

		function arg_6_0.sureCallback(arg_7_0)
			if recharge_data[var_5_0.id].dropid_ext then
				if var_5_0.have_bought and var_5_0.buy_limit and var_5_0.have_bought >= var_5_0.buy_limit and var_5_0.have_bought_ext and var_5_0.have_bought_ext >= var_5_0.buy_limit then
					global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

					return
				end
			elseif var_5_0.have_bought and var_5_0.buy_limit and var_5_0.have_bought >= var_5_0.buy_limit then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

				return
			end

			self:requestCheck(arg_7_0)
		end

		LayerManager:pushInLayer("PrivilegePurchaseConfirmationLayer", arg_6_0, var_5_0)
	end)
end

function SupermarketPrivilegeManager:requestCheck(arg_8_1)
	local var_8_0 = self._info

	require("network.network"):rpc("check_recharge", {
		id = self._info.id,
		client = config.clientmode
	}, function(arg_9_0)
		if arg_9_0.result == 1 then
			local playermodel = require("model.playermodel")

			AnalyticManager.clickPurchaseItem({
				product = var_8_0.id,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			self:requestSubscribe()

			if arg_8_1 then
				arg_8_1(arg_9_0)
			end
		elseif arg_9_0.result == 2 then
			print("测试模式")
		elseif arg_9_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_9_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_9_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_9_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

local l2utils = require("controller.l2utils")
local net_waitinglayer = require("network.net_waitinglayer")

local function var_0_3()
	net_waitinglayer.removeWaitingLayer()
end

local function var_0_4()
	net_waitinglayer.addPurchaseWaitingLayer()
	l2utils:performWithDelay(function()
		var_0_3()
	end, 5)
end

function SupermarketPrivilegeManager:addPurchaseWaitingLayer()
	var_0_4()
end

function SupermarketPrivilegeManager:removePurchaseWaitingLayer()
	var_0_3()
end

function SupermarketPrivilegeManager:canClientSubscribe()
	if DeviceManager.platform == "android" then
		return self:canAndroidClientSubscribe()
	elseif DeviceManager.platform == "ios" then
		return self:canIosClientSubscribe()
	else
		return self:canWin32ClientSubscribe()
	end
end

function SupermarketPrivilegeManager:canAndroidClientSubscribe()
	if not cc.Native.checkPackageInstalled then
		return false
	end

	if not cc.Native:checkPackageInstalled("com.eg.android.AlipayGphone") then
		return false
	end

	return true
end

function SupermarketPrivilegeManager:canIosClientSubscribe()
	return require("controller.ios_purchase_bridge").canPurchases()
end

function SupermarketPrivilegeManager:canWin32ClientSubscribe()
	return true
end

function SupermarketPrivilegeManager:requestSubscribe()
	if DeviceManager.platform == "android" then
		self:requestSubscribeAndroid()
	elseif DeviceManager.platform == "ios" then
		self:requestSubscribeIos()
	else
		self:requestSubscribeWin32()
	end
end

function SupermarketPrivilegeManager:requestSubscribeAndroid()
	require("network.network"):rpc("get_subscribe_url", {
		channel = "android",
		product = self._info.id
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			self:addPurchaseWaitingLayer()
			FySDK.requestSubscribe(arg_21_0.url)
		end
	end)
end

function SupermarketPrivilegeManager:requestSubscribeIos()
	local var_22_0 = 0
	local var_22_1 = {
		98001,
		98004,
		98005
	}
	local var_22_5
	local var_22_6
	local var_22_7
	local var_22_8

	local function var_22_9()
		var_22_0 = var_22_0 + 1

		return var_22_1[var_22_0]
	end

	local function var_22_10()
		return var_22_1[var_22_0]
	end

	local function var_22_11(arg_25_0)
		require("network.network"):rpc("get_subscribe_url", {
			channel = "apple",
			product = arg_25_0
		}, function(arg_26_0)
			if arg_26_0.result == 1 then
				var_22_5(arg_26_0.uuid, arg_26_0.productid)
			end
		end)
	end

	function var_22_5(arg_27_0, arg_27_1)
		local ios_purchase_bridge = require("controller.ios_purchase_bridge")

		ios_purchase_bridge.registerPurchasesHandler(var_22_6)
		ios_purchase_bridge.startPurchases(arg_27_0, arg_27_1)
	end

	function var_22_6(arg_28_0, arg_28_1, arg_28_2)
		if arg_28_0 == 0 then
			var_22_7(arg_28_1, arg_28_2)
		elseif arg_28_0 == 2 then
			local var_28_0 = var_22_9()

			if var_28_0 then
				var_22_11(var_28_0)
			else
				global_ShowBlockWords("此账号已进行过订阅")
			end
		else
			return
		end
	end

	function var_22_7(arg_29_0, arg_29_1)
		self:addPurchaseWaitingLayer()

		local playermodel = require("model.playermodel")
		local var_29_1 = var_22_10()

		local function var_29_2(arg_30_0)
			if arg_30_0.result == 1 then
				require("controller.ios_purchase_bridge").finishPurchases(arg_29_0, arg_29_1, tostring(playermodel.playerid), var_29_1)
			elseif arg_30_0.result == 2 then
				var_22_8(tostring(playermodel.playerid), var_29_1, arg_29_1, var_29_2)
			else
				self:removePurchaseWaitingLayer()
			end
		end

		var_22_8(tostring(playermodel.playerid), var_29_1, arg_29_1, var_29_2)
	end

	function var_22_8(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		require("network.network"):rpc("apple_pay_success", {
			playerid = tostring(arg_31_0),
			productid = arg_31_1,
			token = arg_31_2
		}, function(arg_32_0)
			if arg_31_3 then
				arg_31_3(arg_32_0)
			end
		end)
	end

	;(nil)((nil)())
end

function SupermarketPrivilegeManager:requestSubscribeWin32()
	self:addPurchaseWaitingLayer()
	require("network.network"):rpc("get_subscribe_url", {
		channel = "windows",
		product = self._info.id
	}, function(arg_34_0)
		return
	end)
end

function SupermarketPrivilegeManager:handlerInfo(arg_35_1)
	self:updateLayer()
end

function SupermarketPrivilegeManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function SupermarketPrivilegeManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function SupermarketPrivilegeManager:getMonthlyBtnInfo()
	local var_38_0 = {}

	var_38_0.str = "已购买"
	var_38_0.font = FONT_W5
	var_38_0.size = 30
	var_38_0.color = "FFF6D0"
	var_38_0.btnTexturePath = "SupermarketPrivilegeLayer/monthly_subscription_btn_off.png"
	var_38_0.bShowFirstBuyImg = false

	if not self:haveSubscribe() then
		var_38_0.bShowFirstBuyImg = true
		var_38_0.btnTexturePath = "SupermarketPrivilegeLayer/monthly_subscription_btn_on.png"
		var_38_0.str = "￥" .. self:getMonthlyCardPrice()
	end

	if self:isDeductFail() then
		var_38_0.btnTexturePath = "SupermarketPrivilegeLayer/deduct_fail.png"
	end

	return var_38_0
end

function SupermarketPrivilegeManager:isOpenPrivilege()
	return self._info.remain > require("controller.time_check_manager"):getCurTime()
end

function SupermarketPrivilegeManager:getExpirationDateString()
	if self:isOpenPrivilege() then
		return (os.date("%y-%m-%d %H:%M:%S", (self:getRemain())))
	end

	return "暂未开通"
end

function SupermarketPrivilegeManager:getMonthlyCardPrice()
	return 18
end

function SupermarketPrivilegeManager:getRemain()
	return self._info.remain
end

function SupermarketPrivilegeManager:getRemainDay()
	local var_43_0 = self._info.remain - require("controller.time_check_manager"):getCurTime()

	return (var_43_0 > 0 or nil) and math.floor(var_43_0 / 86400)
end

function SupermarketPrivilegeManager:getConfig()
	return self._config
end

function SupermarketPrivilegeManager:getSkills()
	return nil
end

function SupermarketPrivilegeManager:getSubscribeStatus()
	return self._info.subscribe_status
end

function SupermarketPrivilegeManager:haveSubscribe()
	return SupermarketPrivilegeManager.SUBSCRIBE_STATUS.Have == self:getSubscribeStatus()
end

function SupermarketPrivilegeManager:canSubscribe()
	return SupermarketPrivilegeManager.SUBSCRIBE_STATUS.Have ~= self:getSubscribeStatus()
end

function SupermarketPrivilegeManager:getGoldDropMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[6].value)
end

function SupermarketPrivilegeManager:getSpDropMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[7].value)
end

function SupermarketPrivilegeManager:getWarCompetitivePointMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[5].value)
end

function SupermarketPrivilegeManager:stateUpdate(arg_52_1)
	UpdataTableData(self._info, arg_52_1)

	if arg_52_1.subscribe_deduct_fail then
		LayerManager:pushInLayer("PrivilegeSuccessTipsLayer")
	else
		self._info.subscribe_deduct_fail = nil

		if self:getSubscribeStatus() ~= SupermarketPrivilegeManager.SUBSCRIBE_STATUS.Have and self:getSubscribeStatus() == SupermarketPrivilegeManager.SUBSCRIBE_STATUS.Have then
			LayerManager:pushInLayer("PrivilegeSuccessTipsLayer")
		end
	end

	if self.layer then
		self.layer:stateUpdate()
	end
end

function SupermarketPrivilegeManager:getProtocolState()
	if self:haveSubscribe() then
		return true
	end

	return self._protocolState
end

function SupermarketPrivilegeManager:setProtocolState(arg_54_1)
	if self:haveSubscribe() then
		return
	end

	self._protocolState = arg_54_1

	require("controller.RoleDefault"):getInstance():setBoolForKey(SupermarketPrivilegeManager.PROTOCOL_KEY, arg_54_1)

	if self.layer then
		self.layer:updateXieyiGouImg()
	end
end

function SupermarketPrivilegeManager:isDeductFail()
	if self._info.subscribe_deduct_fail then
		return true
	end

	return false
end

return SupermarketPrivilegeManager
