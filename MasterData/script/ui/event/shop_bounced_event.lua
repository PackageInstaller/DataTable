local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.prompt
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.UILoader
local var_0_5 = string.format
local var_0_6 = gamecore.util_func
local var_0_7 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_quitbtn()
		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.back))
		self:__close_curr_panel()

		if self._enter_panel_type == var_0_7.buy_enter_type.mall_shop then
			var_0_4:getInstance("change_user_layer"):setVisible(true)
		end
	end

	function arg_1_0:__onClick_main_confirmbtn()
		self.confirm_func = nil

		self:_play_into_se(var_0_7:get_audio_url(var_0_7.common_icon.music_path, var_0_7.open))
		self:__close_curr_panel()

		local var_3_0 = var_0_1:get_use_info_data()
		local var_3_1 = self._now_select_item_data.is_sale and self._now_select_item_data.discount or self._now_select_item_data.price

		if var_3_1 > var_3_0.diamond and self._enter_panel_type ~= var_0_7.buy_enter_type.exchange_shop_panel then
			var_0_2:show(var_0_3:getNowLang("errorcode_010"))

			return
		end

		if var_3_1 > var_3_0.furniture_point and self._enter_panel_type == var_0_7.buy_enter_type.exchange_shop_panel then
			var_0_2:show(var_0_3:getNowLang("errorcode_277"))

			return
		end

		if self._enter_panel_type == var_0_7.buy_enter_type.mall_shop then
			if var_0_6:filter_spec_chars(self._now_select_item_data.name) then
				local var_3_2 = var_0_3:getNowLang("errorcode-129")

				var_0_2:show(string.sub(var_3_2, 11, #var_3_2))

				return
			end

			var_0_1:req_ShopBuyChangeNameCardReq(self._now_select_item_data)
		elseif self._enter_panel_type == var_0_7.buy_enter_type.school then
			if self:__get_curr_teacher_info() then
				var_0_1:req_CollageExpandReq()
			end
		elseif self._enter_panel_type == var_0_7.buy_enter_type.exchange_shop_panel then
			var_0_1:req_BuyFurnitureBoxReq(self._now_select_item_data)
		elseif self._enter_panel_type == var_0_7.buy_enter_type.dormitory then
			var_0_1:req_RoomExtendReq()
		elseif self._enter_panel_type == var_0_7.buy_enter_type.exchangel_campaign_panel then
			var_0_1:req_RefreshCampaignReq()
		elseif self._enter_panel_type == var_0_7.buy_enter_type.combat_shop then
			if self.confirm_func then
				self.confirm_func()
			end
		elseif self._enter_panel_type == var_0_7.buy_enter_type.buff_stone_shop then
			if self.confirm_func then
				self.confirm_func()
			end
		else
			local var_3_3 = var_0_3:getNowLang("shopbuyconfirmtitle")
			local var_3_5 = var_0_4:getInstance("msgbox")
			local var_3_6 = self._now_select_item_data

			local function var_3_7()
				var_0_1:req_ShopBuyReq(var_3_6)
			end

			if var_3_5 then
				if self._enter_panel_type == "mall" and self._now_select_item_data.id == var_0_7.shop_item_id.shop_ship_card then
					var_3_5:show(var_0_3:getNowLang("teaching_tip_1"), var_3_7, nil, var_3_3, nil, nil, true)
				else
					var_0_1:req_ShopBuyReq(self._now_select_item_data)
				end
			elseif self._enter_panel_type == "mall" and self._now_select_item_data.id == var_0_7.shop_item_id.shop_ship_card then
				var_0_4:createInstance("msgbox"):show(var_0_3:getNowLang("teaching_tip_1"), var_3_7, nil, var_3_3, nil, nil, true)
			else
				var_0_1:req_ShopBuyReq(self._now_select_item_data)
			end
		end
	end

	function arg_1_0:__onClick_main_closebtn()
		self:__close_curr_panel()
	end

	function arg_1_0:__get_curr_teacher_info()
		local var_6_0 = true

		if self._now_select_item_data.is_get then
			local var_6_1 = var_0_1:get_class_total_info()

			if #var_0_1:get_teacher_total_info() <= #var_6_1 then
				var_6_0 = false

				if #var_6_1 + 1 > var_0_7.college_const.class_max_num then
					var_0_2:show(var_0_3:getNowLang("errorcode_287"))
				else
					var_0_2:show(var_0_5(var_0_3:getNowLang("teacher_not_enough"), #var_6_1 + 1))
				end
			end
		end

		return var_6_0
	end

	function arg_1_0:__close_curr_panel()
		if self.buy_enter_type == var_0_7.buy_enter_type.exchange_shop_panel then
			var_0_7:play_in_out_animation(self._control.maskbg.uITweenSequence, false, function()
				var_0_4:destroyInstance("shop_bounced")
			end)
		else
			var_0_4:destroyInstance("shop_bounced")
		end
	end
end

function var_0_0.extend_obj(arg_9_0)
	return
end

return var_0_0
