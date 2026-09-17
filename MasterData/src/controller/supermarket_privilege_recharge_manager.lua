local SupermarketPrivilegeRechargeManager = class("SupermarketPrivilegeRechargeManager", (require("controller.base_manager")))

SupermarketPrivilegeRechargeManager.MULTITON_MSG = "SupermarketPrivilegeRechargeManager instancealready constructed!"
SupermarketPrivilegeRechargeManager.SHOP_TYPE = 107
SupermarketPrivilegeRechargeManager.BUY_TYPE = {
	YEAR = 100007,
	MONTH = 30501,
	SEASON = 30502
}

function SupermarketPrivilegeRechargeManager:ctor()
	SupermarketPrivilegeRechargeManager.super.ctor(self)

	self._info = {
		remain = 0
	}
	self._config = {}

	for iter_1_0, iter_1_1 in pairs((require("data.privilege_conf"))) do
		self._config[#self._config + 1] = iter_1_1
	end

	table.sort(self._config, function(arg_2_0, arg_2_1)
		return arg_2_0.id < arg_2_1.id
	end)
end

function SupermarketPrivilegeRechargeManager:requestInfo(arg_3_1)
	require("network.network"):rpc("get_recharge_info", {
		client = config.clientmode,
		types = {
			SupermarketPrivilegeRechargeManager.SHOP_TYPE
		}
	}, function(arg_4_0)
		if arg_4_0.result == 1 then
			if arg_4_0.products and arg_4_0.products[1] then
				self._info = {
					remain = arg_4_0.products[1].remain,
					data = {}
				}

				for iter_4_0 = 1, #arg_4_0.products do
					self._info.data[arg_4_0.products[iter_4_0].id] = arg_4_0.products[iter_4_0]
				end

				self:handlerInfo(arg_4_0)
			else
				self._info = {
					remain = 0
				}
			end
		elseif arg_4_0.result == 2 then
			global_riseWord(L_RECHARGE_GET_INFO[2])
		elseif arg_4_0.result == 3 then
			global_riseWord(L_RECHARGE_GET_INFO[3])
		end
	end)
end

function SupermarketPrivilegeRechargeManager:requestBuy(arg_5_1, arg_5_2)
	if not self._info or not self._info.data then
		return
	end

	local var_5_0 = self._info.data[arg_5_2]
	local recharge_data = require("data.recharge_data")

	require("network.network"):rpc("get_recharge_items_drop", {
		id = self._info.data[arg_5_2].id
	}, function(arg_6_0)
		if recharge_data[var_5_0.id].dropid_ext then
			if var_5_0.have_bought and var_5_0.buy_limit and var_5_0.have_bought >= var_5_0.buy_limit and var_5_0.have_bought_ext and var_5_0.have_bought_ext >= var_5_0.buy_limit then
				global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

				return
			end
		elseif var_5_0.have_bought and var_5_0.buy_limit and var_5_0.have_bought >= var_5_0.buy_limit then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)

			return
		end

		self:requestCheck(arg_5_1, arg_5_2)
	end)
end

function SupermarketPrivilegeRechargeManager:requestCheck(arg_7_1, arg_7_2)
	local var_7_0 = self._info.data[arg_7_2]

	require("network.network"):rpc("check_recharge", {
		id = self._info.data[arg_7_2].id,
		client = config.clientmode
	}, function(arg_8_0)
		if arg_8_0.result == 1 then
			local playermodel = require("model.playermodel")

			AnalyticManager.clickPurchaseItem({
				product = var_7_0.id,
				rolenum = playermodel:getOwnedServantNum(),
				grade = playermodel.grade,
				class = playermodel.class
			})
			require("controller.recharge_manager"):confirmPayment(var_7_0.id)

			if arg_7_1 then
				arg_7_1(arg_8_0)
			end
		elseif arg_8_0.result == 2 then
			print("测试模式")
		elseif arg_8_0.result == 3 then
			global_ShowBlockWords(L_RECAHRGE_GOODS_UNAVAILABLE)
		elseif arg_8_0.result == 4 then
			global_ShowBlockWords(L_RECHARGE_OUT_TIME)
		elseif arg_8_0.result == 5 then
			global_ShowBlockWords(L_RECHARGE_BUY_LIMIT)
		elseif arg_8_0.result == 6 then
			global_ShowBlockWords(L_RECHARGE_CARD_LIMIT)
		end
	end)
end

function SupermarketPrivilegeRechargeManager:handlerInfo(arg_9_1)
	self:updateLayer()
end

function SupermarketPrivilegeRechargeManager:updateLayer()
	if self.layer then
		self.layer:updateLayer()
	end
end

function SupermarketPrivilegeRechargeManager:updateRed()
	if self.layer then
		self.layer:updateRed()
	end
end

function SupermarketPrivilegeRechargeManager:buySuccess(arg_12_1)
	for iter_12_0, iter_12_1 in pairs(SupermarketPrivilegeRechargeManager.BUY_TYPE) do
		if iter_12_1 == arg_12_1.id then
			self._info.remain = arg_12_1.remain

			for iter_12_2, iter_12_3 in pairs(self._info.data) do
				iter_12_3.remain = arg_12_1.remain

				if iter_12_3.id == arg_12_1.id then
					iter_12_3.have_bought = iter_12_3.have_bought + 1
				end
			end

			if self.layer then
				self.layer:buySuccess()
			end

			break
		end
	end
end

function SupermarketPrivilegeRechargeManager:isOpenPrivilege()
	return self._info.remain > require("controller.time_check_manager"):getCurTime()
end

function SupermarketPrivilegeRechargeManager:getExpirationDateString()
	if self:isOpenPrivilege() then
		return (os.date("%y-%m-%d %H:%M:%S", (self:getRemain())))
	end

	return "暂未开通"
end

function SupermarketPrivilegeRechargeManager:getMonthlyCardPrice()
	return 18
end

function SupermarketPrivilegeRechargeManager:getRemain()
	return self._info.remain
end

function SupermarketPrivilegeRechargeManager:getRemainDay()
	local var_17_0 = self._info.remain - require("controller.time_check_manager"):getCurTime()

	return (var_17_0 > 0 or nil) and math.floor(var_17_0 / 86400)
end

function SupermarketPrivilegeRechargeManager:getConfig()
	return self._config
end

function SupermarketPrivilegeRechargeManager:getGoldDropMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[6].value)
end

function SupermarketPrivilegeRechargeManager:getSpDropMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[7].value)
end

function SupermarketPrivilegeRechargeManager:getWarCompetitivePointMarkup()
	return (self:isOpenPrivilege() or nil) and tonumber(self._config[5].value)
end

function SupermarketPrivilegeRechargeManager:getTextInfoByType(arg_22_1)
	local var_22_0 = {
		str = "",
		size = 26,
		color = "FFF6D0",
		font = FONT_W5
	}

	if self._info.data[arg_22_1] then
		var_22_0.str = require("controller.recharge_manager"):getCommodityPriceStr(self._info.data[arg_22_1].id)
	end

	return var_22_0
end

return SupermarketPrivilegeRechargeManager
