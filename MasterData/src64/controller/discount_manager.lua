local var_0_0 = {}
local item_manager = require("controller.item_manager")
local time_check_manager = require("controller.time_check_manager")
local net_dispatcher = require("network.net_dispatcher")
local network = require("network.network")
local bachelor_coupons_data = require("data.bachelor_coupons_data")
local item_data = require("data.item_data")

net_dispatcher:registerListener(function(arg_1_0)
	local var_1_0 = cc.Director:getInstance()

	if var_1_0 then
		var_1_0:getRunningScene():getChildByName("rob_panel"):runAction(cc.RemoveSelf:create())
	end
end, "rob_end")
net_dispatcher:registerListener(function(arg_2_0)
	global_runHorseLight(arg_2_0.msg)
end, "rob_start_alert")

function var_0_0.getAllCoupons(arg_3_0)
	return item_manager:filterItem(KITEM_COUPONS)
end

function var_0_0.shopCanUseCoupin(arg_4_0, arg_4_1)
	if type(arg_4_1) == "number" then
		arg_4_1 = "1-" .. arg_4_1
	end

	if not arg_4_1 then
		return true
	end

	return not ({})[arg_4_1]
end

function var_0_0.isCouponsCanUse(arg_5_0, arg_5_1)
	if item_manager:getItemNumber(arg_5_1) <= 0 then
		return false
	end

	if not item_data[arg_5_1].starttime and not item_data[arg_5_1].finishtime then
		return true
	end

	local var_5_0 = global_get_time_by_date(item_data[arg_5_1].starttime)
	local var_5_1 = global_get_time_by_date(item_data[arg_5_1].finishtime)
	local var_5_2 = time_check_manager:getCurTime()

	if not var_5_1 and not var_5_0 then
		return true
	end

	if not var_5_1 then
		return var_5_0 <= var_5_2
	end

	if not var_5_0 then
		return var_5_2 <= var_5_1
	end

	return var_5_0 <= var_5_2 and var_5_2 <= var_5_1
end

function var_0_0:getAllMyCoupons()
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs((self:getAllCoupons())) do
		local var_6_1 = {
			id = iter_6_1
		}

		var_6_1.num = item_manager:getItemNumber(iter_6_1) or 0

		table.insert(var_6_0, var_6_1)
	end

	return var_6_0
end

function var_0_0:getCanUseByItemType(arg_7_1, arg_7_2)
	local var_7_0 = time_check_manager:getCurTime()

	if not self:isCouponsCanUse(arg_7_1.id) then
		return false
	else
		local var_7_1 = 1

		while arg_7_1["useitem" .. 1] do
			if arg_7_1["useitem" .. 1] == arg_7_2 then
				return true
			end

			var_7_1 = var_7_1 + 1
		end
	end

	return false
end

function var_0_0:getCanUseByCurrency(arg_8_1, arg_8_2)
	if not self:isCouponsCanUse(arg_8_1.id) then
		return false
	else
		local var_8_0 = 1

		while arg_8_1["usecurrency" .. 1] do
			if arg_8_1["usecurrency" .. 1] == arg_8_2 then
				return true
			end

			var_8_0 = var_8_0 + 1
		end
	end

	return false
end

function var_0_0:getCouponsByShopId(arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(bachelor_coupons_data) do
		if (not iter_9_1.limit_use_num or arg_9_3 >= iter_9_1.limit_use_num) and self:getCanUseByItemType(iter_9_1, item_data[arg_9_1].bag_item_type) and self:getCanUseByCurrency(iter_9_1, arg_9_2) then
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0:getCanUseCoupin(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not self:shopCanUseCoupin(arg_10_4) then
		return {}
	end

	return self:getCouponsByShopId(arg_10_1, arg_10_2, arg_10_3)
end

function var_0_0:getLastPriceByItem(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = self:getCouponsByShopId(arg_11_1, arg_11_2, arg_11_3)
	local var_11_1 = item_manager:getItemNumber(arg_11_2)

	if not var_11_0 or not next(var_11_0) then
		return var_11_1
	end

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.discount1 == -1 then
			return 999
		elseif var_11_1 < item_manager:getItemNumber(arg_11_2) + iter_11_1.discount1 then
			var_11_1 = item_manager:getItemNumber(arg_11_2) + iter_11_1.discount1
		end
	end

	return var_11_1
end

function var_0_0.getCouponsDiscount(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return 0
	end

	if item_data[arg_12_1].discount1 == -1 then
		return 999
	else
		return item_data[arg_12_1].discount1
	end
end

return var_0_0
