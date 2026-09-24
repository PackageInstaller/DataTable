local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_5 = gameenum.common_type
local var_0_8 = table.sort

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg()
		if self._sort_type_state and self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)

			self:__select_click_down_btn()
			self:set_select_panel()

			local var_2_0 = var_0_2:getInstance("equip_list")

			if var_2_0 and (not var_2_0._is_use_equip or var_2_0._filter_name) then
				var_2_0._sort_type = 1

				if var_2_0._filter_name then
					var_2_0:update_equip_input_field()
				else
					var_2_0:__update_cell_list()
				end
			else
				var_2_0:_show_already_use_equip(true)
			end
		elseif self._sort_type_state and self._sort_type_state == 2 then
			self:__select_click_up_btn()
			self:set_select_panel()

			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)

			local var_2_1 = var_0_2:getInstance("equip_list")

			if var_2_1 and (not var_2_1._is_use_equip or var_2_1._filter_name) then
				var_2_1._sort_type = 2

				if var_2_1._filter_name then
					var_2_1:update_equip_input_field()
				else
					var_2_1:__update_cell_list()
				end
			else
				var_2_1:_show_already_use_equip(true)
			end
		end

		self:setVisible(false)
	end

	function arg_1_0:sort_ship_equip_info_list(arg_3_1)
		if self._sort_type_state == 1 then
			if self._sort_type_num == 1 then
				self:_sort_type_down(arg_3_1)
			elseif self._sort_type_num == 2 then
				self:_sort_star_down(arg_3_1)
			elseif self._sort_type_num == 3 then
				self:_sort_hp_down(arg_3_1)
			elseif self._sort_type_num == 4 then
				self:_sort_atk_down(arg_3_1)
			elseif self._sort_type_num == 5 then
				self:_sort_def_down(arg_3_1)
			elseif self._sort_type_num == 6 then
				self:_sort_torpedo_down(arg_3_1)
			elseif self._sort_type_num == 7 then
				self:_sort_miss_down(arg_3_1)
			elseif self._sort_type_num == 8 then
				self:_sort_air_def_down(arg_3_1)
			elseif self._sort_type_num == 9 then
				self:_sort_antisub_down(arg_3_1)
			elseif self._sort_type_num == 10 then
				self:_sort_aircraft_atk_down(arg_3_1)
			elseif self._sort_type_num == 11 then
				self:_sort_radar_down(arg_3_1)
			elseif self._sort_type_num == 12 then
				self:_sort_luck_down(arg_3_1)
			elseif self._sort_type_num == 13 then
				self:_sort_hit_down(arg_3_1)
			elseif self._sort_type_num == 14 then
				self:_sort_missile_hit_down(arg_3_1)
			elseif self._sort_type_num == 15 then
				self:_sort_missile_tmd_down(arg_3_1)
			elseif self._sort_type_num == 16 then
				self:_sort_aluminium_use_down(arg_3_1)
			elseif self._sort_type_num == 17 then
				self:_sort_air_def_correct_down(arg_3_1)
			elseif self._sort_type_num == 18 then
				self:_sort_air_def_rate_down(arg_3_1)
			end
		elseif self._sort_type_num == 1 then
			self:_sort_type_up(arg_3_1)
		elseif self._sort_type_num == 2 then
			self:_sort_star_up(arg_3_1)
		elseif self._sort_type_num == 3 then
			self:_sort_hp_up(arg_3_1)
		elseif self._sort_type_num == 4 then
			self:_sort_atk_up(arg_3_1)
		elseif self._sort_type_num == 5 then
			self:_sort_def_up(arg_3_1)
		elseif self._sort_type_num == 6 then
			self:_sort_torpedo_up(arg_3_1)
		elseif self._sort_type_num == 7 then
			self:_sort_miss_up(arg_3_1)
		elseif self._sort_type_num == 8 then
			self:_sort_air_def_up(arg_3_1)
		elseif self._sort_type_num == 9 then
			self:_sort_antisub_up(arg_3_1)
		elseif self._sort_type_num == 10 then
			self:_sort_aircraft_atk_up(arg_3_1)
		elseif self._sort_type_num == 11 then
			self:_sort_radar_up(arg_3_1)
		elseif self._sort_type_num == 12 then
			self:_sort_luck_up(arg_3_1)
		elseif self._sort_type_num == 13 then
			self:_sort_hit_up(arg_3_1)
		elseif self._sort_type_num == 14 then
			self:_sort_missile_hit_up(arg_3_1)
		elseif self._sort_type_num == 15 then
			self:_sort_missile_tmd_up(arg_3_1)
		elseif self._sort_type_num == 16 then
			self:_sort_aluminium_use_up(arg_3_1)
		elseif self._sort_type_num == 17 then
			self:_sort_air_def_correct_up(arg_3_1)
		elseif self._sort_type_num == 18 then
			self:_sort_air_def_rate_up(arg_3_1)
		end
	end

	function arg_1_0:__onClick_bg_sort_info_sort_down()
		self._sort_type_state = 1
		self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)
		self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)
	end

	function arg_1_0:__onClick_bg_sort_info_sort_up()
		self._sort_type_state = 2
		self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)
		self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)
	end

	function arg_1_0:__select_click_up_btn()
		if self._sort_type_num == 1 then
			self:select_sort_up_1()
		elseif self._sort_type_num == 2 then
			self:select_sort_up_2()
		elseif self._sort_type_num == 3 then
			self:select_sort_up_3()
		elseif self._sort_type_num == 4 then
			self:select_sort_up_4()
		elseif self._sort_type_num == 5 then
			self:select_sort_up_5()
		elseif self._sort_type_num == 6 then
			self:select_sort_up_6()
		elseif self._sort_type_num == 7 then
			self:select_sort_up_7()
		elseif self._sort_type_num == 8 then
			self:select_sort_up_8()
		elseif self._sort_type_num == 9 then
			self:select_sort_up_9()
		elseif self._sort_type_num == 10 then
			self:select_sort_up_10()
		elseif self._sort_type_num == 11 then
			self:select_sort_up_11()
		elseif self._sort_type_num == 12 then
			self:select_sort_up_12()
		elseif self._sort_type_num == 13 then
			self:select_sort_up_13()
		elseif self._sort_type_num == 14 then
			self:select_sort_up_14()
		elseif self._sort_type_num == 15 then
			self:select_sort_up_15()
		elseif self._sort_type_num == 16 then
			self:select_sort_up_16()
		elseif self._sort_type_num == 17 then
			self:select_sort_up_17()
		elseif self._sort_type_num == 18 then
			self:select_sort_up_18()
		end
	end

	function arg_1_0:__select_click_down_btn()
		if self._sort_type_num == 1 then
			self:select_sort_down_1()
		elseif self._sort_type_num == 2 then
			self:select_sort_down_2()
		elseif self._sort_type_num == 3 then
			self:select_sort_down_3()
		elseif self._sort_type_num == 4 then
			self:select_sort_down_4()
		elseif self._sort_type_num == 5 then
			self:select_sort_down_5()
		elseif self._sort_type_num == 6 then
			self:select_sort_down_6()
		elseif self._sort_type_num == 7 then
			self:select_sort_down_7()
		elseif self._sort_type_num == 8 then
			self:select_sort_down_8()
		elseif self._sort_type_num == 9 then
			self:select_sort_down_9()
		elseif self._sort_type_num == 10 then
			self:select_sort_down_10()
		elseif self._sort_type_num == 11 then
			self:select_sort_down_11()
		elseif self._sort_type_num == 12 then
			self:select_sort_down_12()
		elseif self._sort_type_num == 13 then
			self:select_sort_down_13()
		elseif self._sort_type_num == 14 then
			self:select_sort_down_14()
		elseif self._sort_type_num == 15 then
			self:select_sort_down_15()
		elseif self._sort_type_num == 16 then
			self:select_sort_down_16()
		elseif self._sort_type_num == 17 then
			self:select_sort_down_17()
		elseif self._sort_type_num == 18 then
			self:select_sort_down_18()
		end
	end

	function arg_1_0:select_sort_down_1()
		self:_sort_type_down(self._equip_list)
	end

	function arg_1_0._sort_type_down(arg_9_0, arg_9_1)
		var_0_8(arg_9_1, function(arg_10_0, arg_10_1)
			if arg_10_0.type == arg_10_1.type then
				if arg_10_0.star == arg_10_1.star then
					return arg_10_0.cid > arg_10_1.cid
				else
					return arg_10_0.star > arg_10_1.star
				end
			else
				return arg_10_0.type > arg_10_1.type
			end
		end)
	end

	function arg_1_0:select_sort_up_1()
		self:_sort_type_down(self._equip_list)
	end

	function arg_1_0._sort_type_up(arg_12_0, arg_12_1)
		var_0_8(arg_12_1, function(arg_13_0, arg_13_1)
			if arg_13_0.type == arg_13_1.type then
				if arg_13_0.star == arg_13_1.star then
					return arg_13_0.cid > arg_13_1.cid
				else
					return arg_13_0.star > arg_13_1.star
				end
			else
				return arg_13_0.type < arg_13_1.type
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype1()
		self._now_select_sort_layer_type = "sorttypes1"

		for iter_14_0 = 1, 18 do
			self._sort_type[iter_14_0].image.sprite = iter_14_0 == 1 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 1
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype2()
		self._now_select_sort_layer_type = "sorttypes2"

		for iter_15_0 = 1, 18 do
			self._sort_type[iter_15_0].image.sprite = iter_15_0 == 2 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 2
	end

	function arg_1_0:select_sort_down_2()
		self:_sort_type_up(self._equip_list)
	end

	function arg_1_0._sort_star_down(arg_17_0, arg_17_1)
		var_0_8(arg_17_1, function(arg_18_0, arg_18_1)
			if arg_18_0.star == arg_18_1.star then
				if arg_18_0.type == arg_18_1.type then
					return arg_18_0.cid > arg_18_1.cid
				else
					return arg_18_0.type < arg_18_1.type
				end
			else
				return arg_18_0.star > arg_18_1.star
			end
		end)
	end

	function arg_1_0:select_sort_up_2()
		self:_sort_star_up(self._equip_list)
	end

	function arg_1_0._sort_star_up(arg_20_0, arg_20_1)
		var_0_8(arg_20_1, function(arg_21_0, arg_21_1)
			if arg_21_0.star == arg_21_1.star then
				if arg_21_0.type == arg_21_1.type then
					return arg_21_0.cid > arg_21_1.cid
				else
					return arg_21_0.type < arg_21_1.type
				end
			else
				return arg_21_0.star < arg_21_1.star
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype3()
		self._now_select_sort_layer_type = "sorttypes3"

		for iter_22_0 = 1, 18 do
			self._sort_type[iter_22_0].image.sprite = iter_22_0 == 3 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 3
	end

	function arg_1_0:select_sort_down_3()
		self:_sort_hp_down(self._equip_list)
	end

	function arg_1_0._sort_hp_down(arg_24_0, arg_24_1)
		var_0_8(arg_24_1, function(arg_25_0, arg_25_1)
			if arg_25_0.hp == arg_25_1.hp then
				if arg_25_0.type == arg_25_1.type then
					if arg_25_0.star == arg_25_1.star then
						return arg_25_0.cid > arg_25_1.cid
					else
						return arg_25_0.star > arg_25_1.star
					end
				else
					return arg_25_0.type < arg_25_1.type
				end
			else
				return arg_25_0.hp > arg_25_1.hp
			end
		end)
	end

	function arg_1_0:select_sort_up_3()
		self:_sort_hp_up(self._equip_list)
	end

	function arg_1_0:_sort_hp_up(arg_27_1)
		var_0_8(self._equip_list, function(arg_28_0, arg_28_1)
			if arg_28_0.hp == arg_28_1.hp then
				if arg_28_0.type == arg_28_1.type then
					if arg_28_0.star == arg_28_1.star then
						return arg_28_0.cid > arg_28_1.cid
					else
						return arg_28_0.star > arg_28_1.star
					end
				else
					return arg_28_0.type < arg_28_1.type
				end
			else
				return arg_28_0.hp < arg_28_1.hp
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype4()
		self._now_select_sort_layer_type = "sorttypes4"

		for iter_29_0 = 1, 18 do
			self._sort_type[iter_29_0].image.sprite = iter_29_0 == 4 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 4
	end

	function arg_1_0:select_sort_down_4()
		self:_sort_atk_down(self._equip_list)
	end

	function arg_1_0._sort_atk_down(arg_31_0, arg_31_1)
		var_0_8(arg_31_1, function(arg_32_0, arg_32_1)
			if arg_32_0.atk == arg_32_1.atk then
				if arg_32_0.type == arg_32_1.type then
					if arg_32_0.star == arg_32_1.star then
						return arg_32_0.cid > arg_32_1.cid
					else
						return arg_32_0.star > arg_32_1.star
					end
				else
					return arg_32_0.type < arg_32_1.type
				end
			else
				return arg_32_0.atk > arg_32_1.atk
			end
		end)
	end

	function arg_1_0:select_sort_up_4(arg_33_1)
		self:_sort_atk_up(self._equip_list)
	end

	function arg_1_0._sort_atk_up(arg_34_0, arg_34_1)
		var_0_8(arg_34_1, function(arg_35_0, arg_35_1)
			if arg_35_0.atk == arg_35_1.atk then
				if arg_35_0.type == arg_35_1.type then
					if arg_35_0.star == arg_35_1.star then
						return arg_35_0.cid > arg_35_1.cid
					else
						return arg_35_0.star > arg_35_1.star
					end
				else
					return arg_35_0.type < arg_35_1.type
				end
			else
				return arg_35_0.atk < arg_35_1.atk
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype5()
		self._now_select_sort_layer_type = "sorttypes5"

		for iter_36_0 = 1, 18 do
			self._sort_type[iter_36_0].image.sprite = iter_36_0 == 5 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 5
	end

	function arg_1_0:select_sort_down_5()
		self:_sort_atk_down(self._equip_list)
	end

	function arg_1_0._sort_def_down(arg_38_0, arg_38_1)
		var_0_8(arg_38_1, function(arg_39_0, arg_39_1)
			if arg_39_0.def == arg_39_1.def then
				if arg_39_0.type == arg_39_1.type then
					if arg_39_0.star == arg_39_1.star then
						return arg_39_0.cid > arg_39_1.cid
					else
						return arg_39_0.star > arg_39_1.star
					end
				else
					return arg_39_0.type < arg_39_1.type
				end
			else
				return arg_39_0.def > arg_39_1.def
			end
		end)
	end

	function arg_1_0:select_sort_up_5()
		self:_sort_def_up(self._equip_list)
	end

	function arg_1_0._sort_def_up(arg_41_0, arg_41_1)
		var_0_8(arg_41_1, function(arg_42_0, arg_42_1)
			if arg_42_0.def == arg_42_1.def then
				if arg_42_0.type == arg_42_1.type then
					if arg_42_0.star == arg_42_1.star then
						return arg_42_0.cid > arg_42_1.cid
					else
						return arg_42_0.star > arg_42_1.star
					end
				else
					return arg_42_0.type < arg_42_1.type
				end
			else
				return arg_42_0.def < arg_42_1.def
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype6()
		self._now_select_sort_layer_type = "sorttypes6"

		for iter_43_0 = 1, 18 do
			self._sort_type[iter_43_0].image.sprite = iter_43_0 == 6 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 6
	end

	function arg_1_0:select_sort_down_6()
		self:_sort_torpedo_down(self._equip_list)
	end

	function arg_1_0._sort_torpedo_down(arg_45_0, arg_45_1)
		var_0_8(arg_45_1, function(arg_46_0, arg_46_1)
			if arg_46_0.torpedo == arg_46_1.torpedo then
				if arg_46_0.type == arg_46_1.type then
					if arg_46_0.star == arg_46_1.star then
						return arg_46_0.cid > arg_46_1.cid
					else
						return arg_46_0.star > arg_46_1.star
					end
				else
					return arg_46_0.type < arg_46_1.type
				end
			else
				return arg_46_0.torpedo > arg_46_1.torpedo
			end
		end)
	end

	function arg_1_0:select_sort_up_6()
		self:_sort_torpedo_up(self._equip_list)
	end

	function arg_1_0._sort_torpedo_up(arg_48_0, arg_48_1)
		var_0_8(arg_48_1, function(arg_49_0, arg_49_1)
			if arg_49_0.torpedo == arg_49_1.torpedo then
				if arg_49_0.type == arg_49_1.type then
					if arg_49_0.star == arg_49_1.star then
						return arg_49_0.cid > arg_49_1.cid
					else
						return arg_49_0.star > arg_49_1.star
					end
				else
					return arg_49_0.type < arg_49_1.type
				end
			else
				return arg_49_0.torpedo < arg_49_1.torpedo
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype7()
		self._now_select_sort_layer_type = "sorttypes7"

		for iter_50_0 = 1, 18 do
			self._sort_type[iter_50_0].image.sprite = iter_50_0 == 7 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 7
	end

	function arg_1_0:select_sort_down_7()
		self:_sort_miss_up(self._equip_list)
	end

	function arg_1_0._sort_miss_up(arg_52_0, arg_52_1)
		var_0_8(arg_52_1, function(arg_53_0, arg_53_1)
			if arg_53_0.miss == arg_53_1.miss then
				if arg_53_0.type == arg_53_1.type then
					if arg_53_0.star == arg_53_1.star then
						return arg_53_0.cid > arg_53_1.cid
					else
						return arg_53_0.star > arg_53_1.star
					end
				else
					return arg_53_0.type < arg_53_1.type
				end
			else
				return arg_53_0.miss < arg_53_1.miss
			end
		end)
	end

	function arg_1_0:select_sort_up_7()
		self:_sort_miss_down(self._equip_list)
	end

	function arg_1_0._sort_miss_down(arg_55_0, arg_55_1)
		var_0_8(arg_55_1, function(arg_56_0, arg_56_1)
			if arg_56_0.miss == arg_56_1.miss then
				if arg_56_0.type == arg_56_1.type then
					if arg_56_0.star == arg_56_1.star then
						return arg_56_0.cid > arg_56_1.cid
					else
						return arg_56_0.star > arg_56_1.star
					end
				else
					return arg_56_0.type < arg_56_1.type
				end
			else
				return arg_56_0.miss > arg_56_1.miss
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype8()
		self._now_select_sort_layer_type = "sorttypes8"

		for iter_57_0 = 1, 18 do
			self._sort_type[iter_57_0].image.sprite = iter_57_0 == 8 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 8
	end

	function arg_1_0:select_sort_down_8()
		self:_sort_air_def_down(self._equip_list)
	end

	function arg_1_0._sort_air_def_down(arg_59_0, arg_59_1)
		var_0_8(arg_59_1, function(arg_60_0, arg_60_1)
			if arg_60_0.air_def == arg_60_1.air_def then
				if arg_60_0.type == arg_60_1.type then
					if arg_60_0.star == arg_60_1.star then
						return arg_60_0.cid > arg_60_1.cid
					else
						return arg_60_0.star > arg_60_1.star
					end
				else
					return arg_60_0.type < arg_60_1.type
				end
			else
				return arg_60_0.air_def > arg_60_1.air_def
			end
		end)
	end

	function arg_1_0:select_sort_up_8()
		self:_sort_air_def_up(self._equip_list)
	end

	function arg_1_0._sort_air_def_up(arg_62_0, arg_62_1)
		var_0_8(arg_62_1, function(arg_63_0, arg_63_1)
			if arg_63_0.air_def == arg_63_1.air_def then
				if arg_63_0.type == arg_63_1.type then
					if arg_63_0.star == arg_63_1.star then
						return arg_63_0.cid > arg_63_1.cid
					else
						return arg_63_0.star > arg_63_1.star
					end
				else
					return arg_63_0.type < arg_63_1.type
				end
			else
				return arg_63_0.air_def < arg_63_1.air_def
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype9()
		self._now_select_sort_layer_type = "sorttypes9"

		for iter_64_0 = 1, 18 do
			self._sort_type[iter_64_0].image.sprite = iter_64_0 == 9 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 9
	end

	function arg_1_0:select_sort_down_9()
		self:_sort_antisub_down(self._equip_list)
	end

	function arg_1_0._sort_antisub_down(arg_66_0, arg_66_1)
		var_0_8(arg_66_1, function(arg_67_0, arg_67_1)
			if arg_67_0.antisub == arg_67_1.antisub then
				if arg_67_0.type == arg_67_1.type then
					if arg_67_0.star == arg_67_1.star then
						return arg_67_0.cid > arg_67_1.cid
					else
						return arg_67_0.star > arg_67_1.star
					end
				else
					return arg_67_0.type < arg_67_1.type
				end
			else
				return arg_67_0.antisub > arg_67_1.antisub
			end
		end)
	end

	function arg_1_0:select_sort_up_9()
		self:_sort_antisub_up(self._equip_list)
	end

	function arg_1_0._sort_antisub_up(arg_69_0, arg_69_1)
		var_0_8(arg_69_1, function(arg_70_0, arg_70_1)
			if arg_70_0.antisub == arg_70_1.antisub then
				if arg_70_0.type == arg_70_1.type then
					if arg_70_0.star == arg_70_1.star then
						return arg_70_0.cid > arg_70_1.cid
					else
						return arg_70_0.star > arg_70_1.star
					end
				else
					return arg_70_0.type < arg_70_1.type
				end
			else
				return arg_70_0.antisub < arg_70_1.antisub
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype10()
		self._now_select_sort_layer_type = "sorttypes10"

		for iter_71_0 = 1, 18 do
			self._sort_type[iter_71_0].image.sprite = iter_71_0 == 10 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 10
	end

	function arg_1_0:select_sort_down_10()
		self:_sort_aircraft_atk_down(self._equip_list)
	end

	function arg_1_0._sort_aircraft_atk_down(arg_73_0, arg_73_1)
		var_0_8(arg_73_1, function(arg_74_0, arg_74_1)
			if arg_74_0.aircraft_atk == arg_74_1.aircraft_atk then
				if arg_74_0.type == arg_74_1.type then
					if arg_74_0.star == arg_74_1.star then
						return arg_74_0.cid > arg_74_1.cid
					else
						return arg_74_0.star > arg_74_1.star
					end
				else
					return arg_74_0.type < arg_74_1.type
				end
			else
				return arg_74_0.aircraft_atk > arg_74_1.aircraft_atk
			end
		end)
	end

	function arg_1_0:select_sort_up_10()
		self:_sort_aircraft_atk_up(self._equip_list)
	end

	function arg_1_0._sort_aircraft_atk_up(arg_76_0, arg_76_1)
		var_0_8(arg_76_1, function(arg_77_0, arg_77_1)
			if arg_77_0.aircraft_atk == arg_77_1.aircraft_atk then
				if arg_77_0.type == arg_77_1.type then
					if arg_77_0.star == arg_77_1.star then
						return arg_77_0.cid > arg_77_1.cid
					else
						return arg_77_0.star > arg_77_1.star
					end
				else
					return arg_77_0.type < arg_77_1.type
				end
			else
				return arg_77_0.aircraft_atk < arg_77_1.aircraft_atk
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype11()
		self._now_select_sort_layer_type = "sorttypes11"

		for iter_78_0 = 1, 18 do
			self._sort_type[iter_78_0].image.sprite = iter_78_0 == 11 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 11
	end

	function arg_1_0:select_sort_down_11()
		self:_sort_radar_down(self._equip_list)
	end

	function arg_1_0._sort_radar_down(arg_80_0, arg_80_1)
		var_0_8(arg_80_1, function(arg_81_0, arg_81_1)
			if arg_81_0.radar == arg_81_1.radar then
				if arg_81_0.type == arg_81_1.type then
					if arg_81_0.star == arg_81_1.star then
						return arg_81_0.cid > arg_81_1.cid
					else
						return arg_81_0.star > arg_81_1.star
					end
				else
					return arg_81_0.type < arg_81_1.type
				end
			else
				return arg_81_0.radar > arg_81_1.radar
			end
		end)
	end

	function arg_1_0:select_sort_up_11()
		self:_sort_radar_up(self._equip_list)
	end

	function arg_1_0._sort_radar_up(arg_83_0, arg_83_1)
		var_0_8(arg_83_1, function(arg_84_0, arg_84_1)
			if arg_84_0.radar == arg_84_1.radar then
				if arg_84_0.type == arg_84_1.type then
					if arg_84_0.star == arg_84_1.star then
						return arg_84_0.cid > arg_84_1.cid
					else
						return arg_84_0.star > arg_84_1.star
					end
				else
					return arg_84_0.type < arg_84_1.type
				end
			else
				return arg_84_0.radar < arg_84_1.radar
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype12()
		self._now_select_sort_layer_type = "sorttypes12"

		for iter_85_0 = 1, 18 do
			self._sort_type[iter_85_0].image.sprite = iter_85_0 == 12 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 12
	end

	function arg_1_0:select_sort_down_12()
		self:_sort_luck_down(self._equip_list)
	end

	function arg_1_0._sort_luck_down(arg_87_0, arg_87_1)
		var_0_8(arg_87_1, function(arg_88_0, arg_88_1)
			if arg_88_0.luck == arg_88_1.luck then
				if arg_88_0.type == arg_88_1.type then
					if arg_88_0.star == arg_88_1.star then
						return arg_88_0.cid > arg_88_1.cid
					else
						return arg_88_0.star > arg_88_1.star
					end
				else
					return arg_88_0.type < arg_88_1.type
				end
			else
				return arg_88_0.luck > arg_88_1.luck
			end
		end)
	end

	function arg_1_0:select_sort_up_12()
		self:_sort_luck_up(self._equip_list)
	end

	function arg_1_0._sort_luck_up(arg_90_0, arg_90_1)
		var_0_8(arg_90_1, function(arg_91_0, arg_91_1)
			if arg_91_0.luck == arg_91_1.luck then
				if arg_91_0.type == arg_91_1.type then
					if arg_91_0.star == arg_91_1.star then
						return arg_91_0.cid > arg_91_1.cid
					else
						return arg_91_0.star > arg_91_1.star
					end
				else
					return arg_91_0.type < arg_91_1.type
				end
			else
				return arg_91_0.luck < arg_91_1.luck
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype13()
		self._now_select_sort_layer_type = "sorttypes13"

		for iter_92_0 = 1, 18 do
			self._sort_type[iter_92_0].image.sprite = iter_92_0 == 13 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 13
	end

	function arg_1_0:select_sort_down_13()
		self:_sort_hit_down(self._equip_list)
	end

	function arg_1_0._sort_hit_down(arg_94_0, arg_94_1)
		var_0_8(arg_94_1, function(arg_95_0, arg_95_1)
			if arg_95_0.hit == arg_95_1.hit then
				if arg_95_0.type == arg_95_1.type then
					if arg_95_0.star == arg_95_1.star then
						return arg_95_0.cid > arg_95_1.cid
					else
						return arg_95_0.star > arg_95_1.star
					end
				else
					return arg_95_0.type < arg_95_1.type
				end
			else
				return arg_95_0.hit > arg_95_1.hit
			end
		end)
	end

	function arg_1_0:select_sort_up_13()
		self:_sort_hit_up(self._equip_list)
	end

	function arg_1_0._sort_hit_up(arg_97_0, arg_97_1)
		var_0_8(arg_97_1, function(arg_98_0, arg_98_1)
			if arg_98_0.hit == arg_98_1.hit then
				if arg_98_0.type == arg_98_1.type then
					if arg_98_0.star == arg_98_1.star then
						return arg_98_0.cid > arg_98_1.cid
					else
						return arg_98_0.star > arg_98_1.star
					end
				else
					return arg_98_0.type < arg_98_1.type
				end
			else
				return arg_98_0.hit < arg_98_1.hit
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype14()
		self._now_select_sort_layer_type = "sorttypes14"

		for iter_99_0 = 1, 18 do
			self._sort_type[iter_99_0].image.sprite = iter_99_0 == 14 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 14
	end

	function arg_1_0:select_sort_down_14()
		self:_sort_missile_hit_down(self._equip_list)
	end

	function arg_1_0._sort_missile_hit_down(arg_101_0, arg_101_1)
		var_0_8(arg_101_1, function(arg_102_0, arg_102_1)
			if arg_102_0.missile_hit == arg_102_1.missile_hit then
				if arg_102_0.type == arg_102_1.type then
					if arg_102_0.star == arg_102_1.star then
						return arg_102_0.cid > arg_102_1.cid
					else
						return arg_102_0.star > arg_102_1.star
					end
				else
					return arg_102_0.type < arg_102_1.type
				end
			else
				return arg_102_0.missile_hit > arg_102_1.missile_hit
			end
		end)
	end

	function arg_1_0:select_sort_up_14()
		self:_sort_missile_hit_up(self._equip_list)
	end

	function arg_1_0._sort_missile_hit_up(arg_104_0, arg_104_1)
		var_0_8(arg_104_1, function(arg_105_0, arg_105_1)
			if arg_105_0.missile_hit == arg_105_1.missile_hit then
				if arg_105_0.type == arg_105_1.type then
					if arg_105_0.star == arg_105_1.star then
						return arg_105_0.cid > arg_105_1.cid
					else
						return arg_105_0.star > arg_105_1.star
					end
				else
					return arg_105_0.type < arg_105_1.type
				end
			else
				return arg_105_0.missile_hit < arg_105_1.missile_hit
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype15()
		self._now_select_sort_layer_type = "sorttypes15"

		for iter_106_0 = 1, 18 do
			self._sort_type[iter_106_0].image.sprite = iter_106_0 == 15 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 15
	end

	function arg_1_0:select_sort_down_15()
		self:_sort_missile_tmd_down(self._equip_list)
	end

	function arg_1_0._sort_missile_tmd_down(arg_108_0, arg_108_1)
		var_0_8(arg_108_1, function(arg_109_0, arg_109_1)
			if arg_109_0.missile_tmd == arg_109_1.missile_tmd then
				if arg_109_0.type == arg_109_1.type then
					if arg_109_0.star == arg_109_1.star then
						return arg_109_0.cid > arg_109_1.cid
					else
						return arg_109_0.star > arg_109_1.star
					end
				else
					return arg_109_0.type < arg_109_1.type
				end
			else
				return arg_109_0.missile_tmd > arg_109_1.missile_tmd
			end
		end)
	end

	function arg_1_0:select_sort_up_15()
		self:_sort_missile_tmd_up(self._equip_list)
	end

	function arg_1_0._sort_missile_tmd_up(arg_111_0, arg_111_1)
		var_0_8(arg_111_1, function(arg_112_0, arg_112_1)
			if arg_112_0.missile_tmd == arg_112_1.missile_tmd then
				if arg_112_0.type == arg_112_1.type then
					if arg_112_0.star == arg_112_1.star then
						return arg_112_0.cid > arg_112_1.cid
					else
						return arg_112_0.star > arg_112_1.star
					end
				else
					return arg_112_0.type < arg_112_1.type
				end
			else
				return arg_112_0.missile_tmd < arg_112_1.missile_tmd
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype16()
		self._now_select_sort_layer_type = "sorttypes16"

		for iter_113_0 = 1, 18 do
			self._sort_type[iter_113_0].image.sprite = iter_113_0 == 16 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 16
	end

	function arg_1_0:select_sort_down_16()
		self:_sort_aluminium_use_up(self._equip_list)
	end

	function arg_1_0._sort_aluminium_use_down(arg_115_0, arg_115_1)
		var_0_8(arg_115_1, function(arg_116_0, arg_116_1)
			if arg_116_0.aluminium_use == arg_116_1.aluminium_use then
				if arg_116_0.type == arg_116_1.type then
					if arg_116_0.star == arg_116_1.star then
						return arg_116_0.cid > arg_116_1.cid
					else
						return arg_116_0.star > arg_116_1.star
					end
				else
					return arg_116_0.type < arg_116_1.type
				end
			else
				return arg_116_0.aluminium_use > arg_116_1.aluminium_use
			end
		end)
	end

	function arg_1_0:select_sort_up_16()
		self:_sort_aluminium_use_up(self._equip_list)
	end

	function arg_1_0._sort_aluminium_use_up(arg_118_0, arg_118_1)
		var_0_8(arg_118_1, function(arg_119_0, arg_119_1)
			if arg_119_0.aluminium_use == arg_119_1.aluminium_use then
				if arg_119_0.type == arg_119_1.type then
					if arg_119_0.star == arg_119_1.star then
						return arg_119_0.cid > arg_119_1.cid
					else
						return arg_119_0.star > arg_119_1.star
					end
				else
					return arg_119_0.type < arg_119_1.type
				end
			else
				return arg_119_0.aluminium_use < arg_119_1.aluminium_use
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype17()
		self._now_select_sort_layer_type = "sorttypes17"

		for iter_120_0 = 1, 18 do
			self._sort_type[iter_120_0].image.sprite = iter_120_0 == 17 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 17
	end

	function arg_1_0:select_sort_down_17()
		self:_sort_air_def_correct_down(self._equip_list)
	end

	function arg_1_0._sort_air_def_correct_down(arg_122_0, arg_122_1)
		var_0_8(arg_122_1, function(arg_123_0, arg_123_1)
			if arg_123_0.air_def_correct == arg_123_1.air_def_correct then
				if arg_123_0.type == arg_123_1.type then
					if arg_123_0.star == arg_123_1.star then
						return arg_123_0.cid > arg_123_1.cid
					else
						return arg_123_0.star > arg_123_1.star
					end
				else
					return arg_123_0.type < arg_123_1.type
				end
			else
				return arg_123_0.air_def_correct > arg_123_1.air_def_correct
			end
		end)
	end

	function arg_1_0:select_sort_up_17()
		self:_sort_air_def_correct_up(self._equip_list)
	end

	function arg_1_0._sort_air_def_correct_up(arg_125_0, arg_125_1)
		var_0_8(arg_125_1, function(arg_126_0, arg_126_1)
			if arg_126_0.air_def_correct == arg_126_1.air_def_correct then
				if arg_126_0.type == arg_126_1.type then
					if arg_126_0.star == arg_126_1.star then
						return arg_126_0.cid > arg_126_1.cid
					else
						return arg_126_0.star > arg_126_1.star
					end
				else
					return arg_126_0.type < arg_126_1.type
				end
			else
				return arg_126_0.air_def_correct < arg_126_1.air_def_correct
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype18()
		self._now_select_sort_layer_type = "sorttypes18"

		for iter_127_0 = 1, 18 do
			self._sort_type[iter_127_0].image.sprite = iter_127_0 == 18 and self:loadSprite(var_0_5.sort_type_const.selected1) or self:loadSprite(var_0_5.sort_type_const.btn1)
		end

		self._sort_type_num = 18
	end

	function arg_1_0:select_sort_down_18()
		self:_sort_air_def_rate_down(self._equip_list)
	end

	function arg_1_0._sort_air_def_rate_down(arg_129_0, arg_129_1)
		var_0_8(arg_129_1, function(arg_130_0, arg_130_1)
			if arg_130_0.air_def_rate == arg_130_1.air_def_rate then
				if arg_130_0.type == arg_130_1.type then
					if arg_130_0.star == arg_130_1.star then
						return arg_130_0.cid > arg_130_1.cid
					else
						return arg_130_0.star > arg_130_1.star
					end
				else
					return arg_130_0.type < arg_130_1.type
				end
			else
				return arg_130_0.air_def_rate > arg_130_1.air_def_rate
			end
		end)
	end

	function arg_1_0:select_sort_up_18()
		self:_sort_air_def_rate_up(self._equip_list)
	end

	function arg_1_0._sort_air_def_rate_up(arg_132_0, arg_132_1)
		var_0_8(arg_132_1, function(arg_133_0, arg_133_1)
			if arg_133_0.air_def_rate == arg_133_1.air_def_rate then
				if arg_133_0.type == arg_133_1.type then
					if arg_133_0.star == arg_133_1.star then
						return arg_133_0.cid > arg_133_1.cid
					else
						return arg_133_0.star > arg_133_1.star
					end
				else
					return arg_133_0.type < arg_133_1.type
				end
			else
				return arg_133_0.air_def_rate < arg_133_1.air_def_rate
			end
		end)
	end

	function arg_1_0:__onClick_bg_select_info_cancel()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_select_info_confirm()
		if self._sort_type_state and self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)

			self:__select_click_down_btn()
			self:set_select_panel()

			local var_135_0 = var_0_2:getInstance("equip_list")

			if var_135_0 and not var_135_0._is_use_equip then
				var_135_0._sort_type = 1

				if var_135_0._filter_name then
					var_135_0:update_equip_input_field()
					var_135_0:__update_cell_list()
				else
					var_135_0:__update_cell_list()
				end
			else
				var_135_0:_show_already_use_equip(true)
			end
		elseif self._sort_type_state and self._sort_type_state == 2 then
			self:__select_click_up_btn()
			self:set_select_panel()

			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_5.sort_type_const.selected1)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_5.sort_type_const.btn1)

			local var_135_1 = var_0_2:getInstance("equip_list")

			if var_135_1 and not var_135_1._is_use_equip then
				var_135_1._sort_type = 2

				if var_135_1._filter_name then
					var_135_1:update_equip_input_field()
					var_135_1:__update_cell_list()
				else
					var_135_1:__update_cell_list()
				end
			else
				var_135_1:_show_already_use_equip(true)
			end
		end

		self:setVisible(false)
	end

	function arg_1_0:set_select_panel()
		local var_136_0 = var_0_2:getInstance("equip_list")

		var_136_0._control.equip_content.sort_type_btn.type.text.text = var_0_1:getNowLang("sorttype")

		local var_136_1 = {
			"type",
			"rarity",
			"hp",
			"atk",
			"def",
			"equip3",
			"miss",
			"airdef",
			"antisub",
			"aircraftatk",
			"radar",
			"cardattribute5",
			"hit",
			"missilehit",
			"missiletmd",
			"aluminium_use",
			"air_def_correct",
			"air_def_rate"
		}

		var_136_0._control.equip_content.sort_type_btn.type_txt.text.text = self._sort_type_state == 1 and var_0_1:getNowLang(var_136_1[self._sort_type_num]) .. var_0_1:getNowLang("arrow_down") or var_0_1:getNowLang(var_136_1[self._sort_type_num]) .. var_0_1:getNowLang("arrow_up")
		var_136_0._sort_type_num = self._sort_type_num
	end
end

function var_0_0.extend_obj(arg_137_0)
	return
end

return var_0_0
