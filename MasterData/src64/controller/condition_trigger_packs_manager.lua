local var_0_0 = {}
local item_manager = require("controller.item_manager")
local var_0_3 = 3
local twist_config_data = require("data.twist_config_data")
local network = require("network.network")
local var_0_6 = {
	[BOOSTER_PACKS] = function(arg_1_0)
		if not arg_1_0.hero_items then
			return
		end

		for iter_1_0, iter_1_1 in ipairs(arg_1_0.hero_items) do
			if item_manager:getItemNumber(iter_1_1) == 8 then
				return true
			end
		end

		return false
	end,
	[PROMOTION_PACKS] = function(arg_2_0)
		if not arg_2_0.quickGuajiType then
			return
		end

		if arg_2_0.quickGuajiType == var_0_3 or arg_2_0.quick_fight_times <= 1 then
			local var_2_0 = os.date("%m-%d", (require("controller.time_check_manager"):getCurTime()))

			if RoleDefault:getInstance():getStringForKey("quickGuaji_trigger_date", "") == var_2_0 then
				return false
			end

			RoleDefault:getInstance():setStringForKey("quickGuaji_trigger_date", var_2_0)

			return true
		end

		return false
	end,
	[WEAPOM_PACKS] = function(arg_3_0)
		if not arg_3_0.curStar then
			return
		end

		if arg_3_0.curStar >= 5 then
			return true
		end

		return false
	end,
	[ASSISTS_PACKS] = function(arg_4_0)
		if not arg_4_0.curMode then
			return
		end

		return arg_4_0.curMode >= 4
	end,
	[SKINS_PACKS] = function(arg_5_0)
		local var_5_0
		local var_5_1

		if not arg_5_0.twistid then
			do return end

			var_5_0 = twist_config_data[arg_5_0.twistid].currency and item_manager:getItemNumber(twist_config_data[arg_5_0.twistid].currency) or 0
			var_5_1 = twist_config_data[arg_5_0.twistid].once_twist_ticket and item_manager:getItemNumber(twist_config_data[arg_5_0.twistid].once_twist_ticket) or 0
		end

		if twist_config_data[arg_5_0.twistid].is_skin_twist then
			return var_5_0 + var_5_1 + item_manager:getItemNumber(6800601) < 10
		end

		return false
	end
}

function var_0_0.check_trigger_condition(arg_6_0, arg_6_1)
	if not arg_6_1.shop_type or not var_0_6[arg_6_1.shop_type] then
		return
	end

	if not var_0_6[arg_6_1.shop_type](arg_6_1) then
		return
	end

	network:rpc("condition_packs_trigger", {
		shop_type = arg_6_1.shop_type
	}, function(arg_7_0)
		hx_print("get_condition_packs_active")
		print_lua_table(arg_7_0)

		if arg_7_0.result == 1 or arg_7_0.result == 3 then
			LayerManager:pushInLayer("PopNewRulePacksLayer", {
				shop_type = arg_6_1.shop_type
			})
			cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("condition_packs_trigger"))

			if arg_6_1.shop_type == ASSISTS_PACKS then
				if TopcostLayer.getInstance() then
					TopcostLayer.getInstance():showTopcostLayer()
				end

				if ListButtonLayer.getInstance() then
					ListButtonLayer.getInstance():showLayer()
				end

				return
			end
		elseif arg_7_0.result == 2 then
			-- block empty
		elseif arg_7_0.result == 4 then
			-- block empty
		end
	end)
end

function var_0_0.get_condition_packs_active(arg_8_0, arg_8_1)
	network:rpc("get_condition_packs_active", {}, function(arg_9_0)
		hx_print("get_condition_packs_active")
		print_lua_table(arg_9_0)

		if arg_9_0.result == 1 and arg_8_1 then
			arg_8_1(arg_9_0)
		end
	end)
end

return var_0_0
