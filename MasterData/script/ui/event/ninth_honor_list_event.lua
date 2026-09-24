local var_0_0 = {}
local var_0_3 = gamecore.UILoader
local var_0_6 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onScaleButtonClick_bg_top_return_btn()
		self:setVisible(false)

		if self.enter_type == var_0_6.pve_active_type.score_event then
			local var_2_0 = var_0_3:getInstance("score_push_map")

			if var_2_0 then
				var_2_0:show()
			else
				var_0_3:createInstance("score_push_map"):show()
			end
		elseif self.enter_type == var_0_6.pve_active_type.strike_event then
			local var_2_1 = var_0_3:getInstance("strike_main")

			if var_2_1 then
				var_2_1:show()
			else
				var_0_3:createInstance("strike_main"):show()
			end
		elseif self.enter_type == var_0_6.pve_active_type.normal then
			local var_2_2 = var_0_3:getInstance("fearlessness_sea")

			if var_2_2 then
				var_2_2:show()
			else
				var_0_3:createInstance("fearlessness_sea"):show()
			end
		else
			local var_2_3 = var_0_3:getInstance("ninth_main_map")

			if var_2_3 then
				var_2_3:show()
			else
				var_0_3:createInstance("ninth_main_map"):show()
			end
		end

		var_0_3:destroyInstance("ninth_honor_list")
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_1(arg_3_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_2(arg_4_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_3(arg_5_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_4(arg_6_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_1_btn_5(arg_7_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_1(arg_8_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_2(arg_9_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_3(arg_10_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_2_btn_4(arg_11_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_1(arg_12_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_2(arg_13_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_3(arg_14_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_4(arg_15_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_3_btn_5(arg_16_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_1(arg_17_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_2(arg_18_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_3(arg_19_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_4(arg_20_0)
		return
	end

	function arg_1_0.__onClick_bg_rank_title_rank_title_4_btn_5(arg_21_0)
		return
	end

	function arg_1_0.__onClick_bg_visit_friend_layer_close_btn(arg_22_0)
		return
	end

	function arg_1_0.__onClick_bg_visit_friend_layer_visit_btn(arg_23_0)
		return
	end
end

function var_0_0.extend_obj(arg_24_0)
	return
end

return var_0_0
