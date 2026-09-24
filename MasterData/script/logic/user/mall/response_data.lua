local var_0_0 = {}
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_5 = gameenum.error_type
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.PayManager
local var_0_8 = lx

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:ShopBuyResp(arg_2_1)
		if arg_2_1.result == 0 then
			if arg_2_1.name ~= "" then
				self._name = arg_2_1.name
			end

			if arg_2_1.reward == nil or #arg_2_1.reward == 0 then
				self:__show_success_prompt()
			end

			self:__get_mall_shop_buy_success(arg_2_1)
		elseif arg_2_1.result == 165 then
			if arg_2_1.name ~= "" then
				self._name = arg_2_1.name
			end

			self:__get_mall_shop_buy_success(arg_2_1)
			var_0_2:show(var_0_5:get_err_msg(arg_2_1.result))
		else
			var_0_2:show(var_0_5:get_err_msg(arg_2_1.result))
		end
	end

	function arg_1_0:MultiShopBuyResp(arg_3_1)
		if arg_3_1.result == 0 then
			if arg_3_1.reward == nil or #arg_3_1.reward == 0 then
				self:__show_success_prompt()
			end

			self:__get_mall_shop_buy_success(arg_3_1)
		elseif arg_3_1.result == 165 then
			self:__get_mall_shop_buy_success(arg_3_1)
			var_0_2:show(var_0_5:get_err_msg(arg_3_1.result))
		else
			var_0_2:show(var_0_5:get_err_msg(arg_3_1.result))
		end
	end

	function arg_1_0.CreatePayOrderResp(arg_4_0, arg_4_1)
		local var_4_1 = tostring(rawget(arg_4_1, "order_id") or "nil")
		local var_4_2 = rawget(arg_4_1, "extra_info")
		local var_4_3 = tostring(var_4_2 or "nil")

		if type(var_4_2) == "table" then
			local var_4_8 = tostring(var_4_2.offer_id or "")
			local var_4_9 = tostring(var_4_2.bill_no or var_4_2.order_id or "")
			local var_4_10 = tostring(var_4_2.zone_id or "")
		end

		if arg_4_1.result == 0 then
			local var_4_11 = var_0_3:getInstance("mall_shop")

			if var_4_11 then
				var_4_11:create_order_data_resp(arg_4_1)
			end
		else
			var_0_3:createInstance("loading"):show(false)
			var_0_2:show(var_0_5:get_err_msg(arg_4_1.result))
		end
	end

	function arg_1_0.OrderPayDoneResp(arg_5_0, arg_5_1)
		if arg_5_1.result == 0 then
			-- block empty
		else
			if var_0_7._last_verify_was_xiaomi_internal then
				-- block empty
			end

			var_0_3:createInstance("loading"):show(false)
		end

		var_0_7._last_verify_was_xiaomi_internal = nil
		var_0_7._xiaomi_internal_waiting_order_pay_done_resp = nil

		if arg_5_1.result == 0 then
			var_0_7._xiaomi_order_pay_done_sent_ms = nil
			var_0_7._xiaomi_quiet_network_reconnect_until_ms = var_0_8.Time:getTime() + 5000
		else
			var_0_7._xiaomi_order_pay_done_sent_ms = nil
			var_0_7._xiaomi_quiet_network_reconnect_until_ms = nil
		end

		var_0_7:saveCreateiOSOrder("1")
		var_0_7:serverVerify()
	end

	function arg_1_0.VoucherShopBuyResp(arg_6_0, arg_6_1)
		if arg_6_1.result == 0 then
			local var_6_1 = var_0_3:getInstance("voucher_shop")

			var_6_1._control.buy_msgbox.gameObject:SetActive(false)
			var_6_1:__initial_func("resp")
			var_6_1:__init_shop_skin_data()
			var_6_1:__update_cell()
			var_6_1:__update_cell_side()

			if arg_6_1.reward and next(arg_6_1.reward) then
				if arg_6_1.reward[1].type == var_0_6.reward_type.ship_skin then
					var_0_3:createInstance("reward_tip"):show_by_enter_type(arg_6_1.reward[1].id, var_0_6.enter_get_ship_type.mall_shop, function()
						arg_6_0:__show_voucher_skin_detail(arg_6_1.reward)
					end)
				elseif arg_6_1.reward[1].type == var_0_6.reward_type.item then
					(var_0_3:getInstance("msgbox") or var_0_3:createInstance("msgbox")):showOnes(arg_6_1.reward, nil, nil, var_0_4:getNowLang("logget"), var_0_6.msg_type.rewards)
				end
			end
		else
			var_0_2:show(var_0_5:get_err_msg(arg_6_1.result))
		end
	end

	function arg_1_0.__show_voucher_skin_detail(arg_8_0, arg_8_1)
		if arg_8_1 and next(arg_8_1) and #arg_8_1 > 1 then
			var_0_3:createInstance("reward_tip"):show_by_enter_type(arg_8_1[2].id, var_0_6.enter_get_ship_type.mall_shop)
		end
	end

	function arg_1_0:__get_mall_shop_buy_success(arg_9_1)
		local var_9_0 = var_0_3:getInstance("mall_shop")

		if var_9_0 then
			var_9_0:update_user_res_data(true)
			var_9_0:update_data(true)
		end

		local var_9_1 = var_0_3:getActiveInstance("ship_detail")

		if var_9_1 and not var_9_1.is_marry then
			var_9_1:update_price_btn_state()
		end

		local var_9_2 = var_0_3:getInstance("dock")

		if var_9_2 then
			var_9_2:buy_dock_resp()
		end

		local var_9_3 = var_0_3:getInstance("bathroom")

		if var_9_3 and self._bathroom_buy_type == var_0_6.bathroom_buy_type.extension then
			var_9_3:buy_repair_resp()
		end

		local var_9_4 = var_0_3:getInstance("bathroom_change_style")

		if var_9_4 and self._bathroom_buy_type == var_0_6.bathroom_buy_type.style then
			var_9_4:__buy_resp()
		end

		local var_9_5 = var_0_3:getInstance("fight_prepare")

		if var_9_5 and not var_0_3:getInstance("ship_detail") then
			var_0_2:show(var_0_4:getNowLang("shopbuysuccess"))
			var_9_5:update_damage_control_count()
		end

		local var_9_6 = var_0_3:getInstance("fight_info")

		if var_9_6 then
			var_0_2:show(var_0_4:getNowLang("shopbuysuccess"))
			var_9_6:set_damagecontrol_num()
		end

		local var_9_7 = var_0_3:getInstance(var_0_6:get_battle_name())

		if var_9_7 then
			var_0_2:show(var_0_4:getNowLang("shopbuysuccess"))
			var_9_7:set_damagecontrol_num()
		end

		local var_9_8 = var_0_3:getInstance("home")

		if var_9_8 then
			var_9_8:__show_data()
		end

		if #arg_9_1.reward ~= 0 then
			local var_9_9 = var_0_3:createInstance("acquire_image")

			if var_9_9 then
				var_9_9:Show_Info(arg_9_1)
			end
		end
	end

	function arg_1_0.__show_success_prompt(arg_10_0)
		local var_10_0 = var_0_3:getInstance("shop_bounced")

		if var_10_0 and var_10_0:get_curr_enter_panel() == var_0_6.buy_enter_type.fight_prepare then
			print("改名成功")
			var_0_2:show(var_0_4:getNowLang("shopbuysuccess"))
		end
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
