local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_3 = gamecore.UILoader
local var_0_4 = gamecore.Language
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_main_minus_btn()
		self:__click_minus_btn()
	end

	function arg_1_0.__onLongClick_main_minus_btn(arg_3_0)
		arg_3_0._is_long_click_minus_btn = true
	end

	function arg_1_0:__onClick_main_plus_btn()
		self:__click_plus_btn()
	end

	function arg_1_0.__onLongClick_main_plus_btn(arg_5_0)
		arg_5_0._is_long_click_plus_btn = true
	end

	function arg_1_0:__onClick_main_quitbtn()
		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.back))
		self:__close_curr_panel()

		if self._enter_panel_type == var_0_6.buy_enter_type.mall_shop then
			var_0_3:getInstance("change_user_layer"):setVisible(true)
		end
	end

	function arg_1_0:__onClick_main_confirmbtn()
		self.confirm_func = nil

		self:_play_into_se(var_0_6:get_audio_url(var_0_6.common_icon.music_path, var_0_6.open))
		self:__close_curr_panel()

		local var_7_1 = var_0_3:getInstance("msgbox")
		local var_7_2 = var_0_1:get_use_info_data()
		local var_7_3 = var_0_4:getNowLang("shopbuyconfirmtitle")

		if self._enter_type == "spoils" then
			var_0_1:req_MultiSpoilsBuyReq(self._goods_info.id, self._goods_count)
		elseif self._enter_type == "exploit" then
			var_0_1:req_MultiSpoilsBuyReq(self._goods_info.id, self._goods_count)
		elseif self._enter_type == "combat" then
			self._goods_info.count = self._goods_count

			local var_7_5 = self._goods_info

			local function var_7_6()
				var_0_1:req_MultiSixthShopBuyReq(var_7_5)
			end

			if var_7_1 then
				if self._goods_info.id == var_0_6.shop_item_id.combat_ship_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_2"), var_7_6, nil, var_7_3, nil, nil, true)
				elseif self._goods_info.id == var_0_6.shop_item_id.combat_teach_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_3"), var_7_6, nil, var_7_3, nil, nil, true)
				else
					var_0_1:req_MultiSixthShopBuyReq(self._goods_info)
				end
			else
				var_7_1 = var_0_3:createInstance("msgbox")

				if self._goods_info.id == var_0_6.shop_item_id.combat_ship_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_2"), var_7_6, nil, var_7_3, nil, nil, true)
				elseif self._goods_info.id == var_0_6.shop_item_id.combat_teach_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_3"), var_7_6, nil, var_7_3, nil, nil, true)
				else
					var_0_1:req_MultiSixthShopBuyReq(self._goods_info)
				end
			end
		elseif self._enter_type == "furniture" then
			self._goods_info.count = self._goods_count

			var_0_1:req_MultiBuyFurnitureBoxReq(self._goods_info)
		else
			self._goods_info.count = self._goods_count

			local var_7_7 = self._goods_info

			local function var_7_8()
				var_0_1:req_MultiShopBuyReq(var_7_7)
			end

			if var_7_1 then
				if self._goods_info.id == var_0_6.shop_item_id.shop_ship_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_1"), var_7_8, nil, var_7_3, nil, nil, true)
				elseif self._goods_info.id == var_0_6.shop_item_id.shop_teach_card then
					var_7_1:show(var_0_4:getNowLang("teaching_tip_2"), var_7_8, nil, var_7_3, nil, nil, true)
				else
					var_0_1:req_MultiShopBuyReq(self._goods_info)
				end
			else
				local var_7_9 = var_0_3:createInstance("msgbox")

				if self._goods_info.id == var_0_6.shop_item_id.shop_ship_card then
					var_7_9:show(var_0_4:getNowLang("teaching_tip_1"), var_7_8, nil, var_7_3, nil, nil, true)
				elseif self._goods_info.id == var_0_6.shop_item_id.shop_teach_card then
					var_7_9:show(var_0_4:getNowLang("teaching_tip_2"), var_7_8, nil, var_7_3, nil, nil, true)
				else
					var_0_1:req_MultiShopBuyReq(self._goods_info)
				end
			end
		end
	end

	function arg_1_0:__onClick_main_closebtn()
		self:__close_curr_panel()
	end
end

function var_0_0.extend_obj(arg_11_0)
	return
end

return var_0_0
