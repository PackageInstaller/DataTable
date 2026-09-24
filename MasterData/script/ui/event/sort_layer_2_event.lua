local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_4 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_bg()
		if self._sort_type_state and self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)

			self:__select_click_down_btn()
			self:__update_parent_data(self._now_select_sort_layer_type, self._now_select_sort_layer_num)
			self:set_select_panel(self._now_select_sort_layer_num)
		elseif self._sort_type_state and self._sort_type_state == 2 then
			self:__select_click_up_btn()
			self:__update_parent_data(self._now_select_sort_layer_type, self._now_select_sort_layer_num)
			self:set_select_panel(self._now_select_sort_layer_num)

			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
		end

		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_sort_info_sort_up()
		self._sort_type_state = 2
		self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)
		self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
	end

	function arg_1_0:__select_click_up_btn()
		if self._now_select_sort_layer_num == 1 then
			self:select_sort_up_1()
		elseif self._now_select_sort_layer_num == 2 then
			self:select_sort_up_2()
		elseif self._now_select_sort_layer_num == 3 then
			self:select_sort_up_3()
		elseif self._now_select_sort_layer_num == 4 then
			self:select_sort_up_4()
		elseif self._now_select_sort_layer_num == 5 then
			self:select_sort_up_5()
		elseif self._now_select_sort_layer_num == 6 then
			self:select_sort_up_6()
		elseif self._now_select_sort_layer_num == 7 then
			self:select_sort_up_7()
		elseif self._now_select_sort_layer_num == 8 then
			self:select_sort_up_8()
		elseif self._now_select_sort_layer_num == 9 then
			self:select_sort_up_9()
		elseif self._now_select_sort_layer_num == 10 then
			self:select_sort_up_10()
		elseif self._now_select_sort_layer_num == 11 then
			self:select_sort_up_11()
		elseif self._now_select_sort_layer_num == 12 then
			self:select_sort_up_12()
		elseif self._now_select_sort_layer_num == 13 then
			self:select_sort_up_13()
		elseif self._now_select_sort_layer_num == 14 then
			self:select_sort_up_14()
		elseif self._now_select_sort_layer_num == 15 then
			self:select_sort_up_15()
		elseif self._now_select_sort_layer_num == 16 then
			self:select_sort_up_16()
		elseif self._now_select_sort_layer_num == 17 then
			self:select_sort_up_17()
		elseif self._now_select_sort_layer_num == 18 then
			self:select_sort_up_18()
		elseif self._now_select_sort_layer_num == 19 then
			self:select_sort_up_19()
		end
	end

	function arg_1_0:__onClick_bg_sort_info_sort_down()
		self._sort_type_state = 1
		self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)
		self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
	end

	function arg_1_0:__select_click_down_btn()
		if self._now_select_sort_layer_num == 1 then
			self:select_sort_down_1()
		elseif self._now_select_sort_layer_num == 2 then
			self:select_sort_down_2()
		elseif self._now_select_sort_layer_num == 3 then
			self:select_sort_down_3()
		elseif self._now_select_sort_layer_num == 4 then
			self:select_sort_down_4()
		elseif self._now_select_sort_layer_num == 5 then
			self:select_sort_down_5()
		elseif self._now_select_sort_layer_num == 6 then
			self:select_sort_down_6()
		elseif self._now_select_sort_layer_num == 7 then
			self:select_sort_down_7()
		elseif self._now_select_sort_layer_num == 8 then
			self:select_sort_down_8()
		elseif self._now_select_sort_layer_num == 9 then
			self:select_sort_down_9()
		elseif self._now_select_sort_layer_num == 10 then
			self:select_sort_down_10()
		elseif self._now_select_sort_layer_num == 11 then
			self:select_sort_down_11()
		elseif self._now_select_sort_layer_num == 12 then
			self:select_sort_down_12()
		elseif self._now_select_sort_layer_num == 13 then
			self:select_sort_down_13()
		elseif self._now_select_sort_layer_num == 14 then
			self:select_sort_down_14()
		elseif self._now_select_sort_layer_num == 15 then
			self:select_sort_down_15()
		elseif self._now_select_sort_layer_num == 16 then
			self:select_sort_down_16()
		elseif self._now_select_sort_layer_num == 17 then
			self:select_sort_down_17()
		elseif self._now_select_sort_layer_num == 18 then
			self:select_sort_down_18()
		elseif self._now_select_sort_layer_num == 19 then
			self:select_sort_down_19()
		end
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype1()
		self._now_select_sort_layer_type = "sorttypes1"

		for iter_7_0 = 1, 19 do
			self._sort_type[iter_7_0].image.sprite = iter_7_0 == 1 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 1
	end

	function arg_1_0:select_sort_down_1()
		self:set_sort_func(function(arg_9_0, arg_9_1)
			if arg_9_0.level == arg_9_1.level then
				if arg_9_0.type == arg_9_1.type then
					if arg_9_0.cid == arg_9_1.cid then
						return arg_9_0.id < arg_9_1.id
					else
						return arg_9_0.cid > arg_9_1.cid
					end
				else
					return arg_9_0.type < arg_9_1.type
				end
			else
				return arg_9_0.level > arg_9_1.level
			end
		end)
	end

	function arg_1_0:select_sort_up_1()
		self:set_sort_func(function(arg_11_0, arg_11_1)
			if arg_11_0.level == arg_11_1.level then
				if arg_11_0.type == arg_11_1.type then
					if arg_11_0.cid == arg_11_1.cid then
						return arg_11_0.id < arg_11_1.id
					else
						return arg_11_0.cid > arg_11_1.cid
					end
				else
					return arg_11_0.type < arg_11_1.type
				end
			else
				return arg_11_0.level < arg_11_1.level
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype2()
		self._now_select_sort_layer_type = "sorttypes2"

		for iter_12_0 = 1, 19 do
			self._sort_type[iter_12_0].image.sprite = iter_12_0 == 2 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 2
	end

	function arg_1_0:select_sort_down_2()
		self:set_sort_func(function(arg_14_0, arg_14_1)
			if arg_14_0.type == arg_14_1.type then
				if arg_14_0.level == arg_14_1.level then
					if arg_14_0.cid == arg_14_1.cid then
						return arg_14_0.id < arg_14_1.id
					else
						return arg_14_0.cid > arg_14_1.cid
					end
				else
					return arg_14_0.level > arg_14_1.level
				end
			else
				return arg_14_0.type > arg_14_1.type
			end
		end)
	end

	function arg_1_0:select_sort_up_2()
		self:set_sort_func(function(arg_16_0, arg_16_1)
			if arg_16_0.type == arg_16_1.type then
				if arg_16_0.level == arg_16_1.level then
					if arg_16_0.cid == arg_16_1.cid then
						return arg_16_0.id > arg_16_1.id
					else
						return arg_16_0.cid > arg_16_1.cid
					end
				else
					return arg_16_0.level > arg_16_1.level
				end
			else
				return arg_16_0.type < arg_16_1.type
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype3()
		print("3333333333")

		self._now_select_sort_layer_type = "sorttypes3"

		for iter_17_0 = 1, 19 do
			self._sort_type[iter_17_0].image.sprite = iter_17_0 == 3 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 3
	end

	function arg_1_0:select_sort_down_3()
		self:set_sort_func(function(arg_19_0, arg_19_1)
			if arg_19_0.star == arg_19_1.star then
				if arg_19_0.type == arg_19_1.type then
					if arg_19_0.level == arg_19_1.level then
						return arg_19_0.cid > arg_19_1.cid
					else
						return arg_19_0.level > arg_19_1.level
					end
				else
					return arg_19_0.type < arg_19_1.type
				end
			else
				return arg_19_0.star > arg_19_1.star
			end
		end)
	end

	function arg_1_0:select_sort_up_3()
		self:set_sort_func(function(arg_21_0, arg_21_1)
			if arg_21_0.star == arg_21_1.star then
				if arg_21_0.level == arg_21_1.level then
					if arg_21_0.type == arg_21_1.type then
						return arg_21_0.cid > arg_21_1.cid
					else
						return arg_21_0.type < arg_21_1.type
					end
				else
					return arg_21_0.level > arg_21_1.level
				end
			else
				return arg_21_0.star < arg_21_1.star
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype4()
		print("4444444444")

		self._now_select_sort_layer_type = "sorttypes4"

		for iter_22_0 = 1, 19 do
			self._sort_type[iter_22_0].image.sprite = iter_22_0 == 4 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 4
	end

	function arg_1_0:select_sort_down_4()
		self:set_sort_func(function(arg_24_0, arg_24_1)
			if arg_24_0.data_tmp.hp == arg_24_1.data_tmp.hp then
				if arg_24_0.level == arg_24_1.level then
					if arg_24_0.type == arg_24_1.type then
						return arg_24_0.cid > arg_24_1.cid
					else
						return arg_24_0.type < arg_24_1.type
					end
				else
					return arg_24_0.level > arg_24_1.level
				end
			else
				return arg_24_0.data_tmp.hp > arg_24_1.data_tmp.hp
			end
		end)
	end

	function arg_1_0:select_sort_up_4()
		self:set_sort_func(function(arg_26_0, arg_26_1)
			if arg_26_0.data_tmp.hp == arg_26_1.data_tmp.hp then
				if arg_26_0.level == arg_26_1.level then
					if arg_26_0.type == arg_26_1.type then
						return arg_26_0.cid > arg_26_1.cid
					else
						return arg_26_0.type < arg_26_1.type
					end
				else
					return arg_26_0.level > arg_26_1.level
				end
			else
				return arg_26_0.data_tmp.hp < arg_26_1.data_tmp.hp
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype5()
		self._now_select_sort_layer_type = "sorttypes5"

		for iter_27_0 = 1, 19 do
			self._sort_type[iter_27_0].image.sprite = iter_27_0 == 5 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 5
	end

	function arg_1_0:select_sort_down_5()
		self:set_sort_func(function(arg_29_0, arg_29_1)
			if arg_29_0.data_tmp.atk == arg_29_1.data_tmp.atk then
				if arg_29_0.level == arg_29_1.level then
					if arg_29_0.type == arg_29_1.type then
						return arg_29_0.cid > arg_29_1.cid
					else
						return arg_29_0.type < arg_29_1.type
					end
				else
					return arg_29_0.level > arg_29_1.level
				end
			else
				return arg_29_0.data_tmp.atk > arg_29_1.data_tmp.atk
			end
		end)
	end

	function arg_1_0:select_sort_up_5()
		self:set_sort_func(function(arg_31_0, arg_31_1)
			if arg_31_0.data_tmp.atk == arg_31_1.data_tmp.atk then
				if arg_31_0.level == arg_31_1.level then
					if arg_31_0.type == arg_31_1.type then
						return arg_31_0.cid > arg_31_1.cid
					else
						return arg_31_0.type < arg_31_1.type
					end
				else
					return arg_31_0.level > arg_31_1.level
				end
			else
				return arg_31_0.data_tmp.atk < arg_31_1.data_tmp.atk
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype6()
		self._now_select_sort_layer_type = "sorttypes6"

		for iter_32_0 = 1, 19 do
			self._sort_type[iter_32_0].image.sprite = iter_32_0 == 6 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 6
	end

	function arg_1_0:select_sort_down_6()
		self:set_sort_func(function(arg_34_0, arg_34_1)
			if arg_34_0.data_tmp.def == arg_34_1.data_tmp.def then
				if arg_34_0.level == arg_34_1.level then
					if arg_34_0.type == arg_34_1.type then
						return arg_34_0.cid > arg_34_1.cid
					else
						return arg_34_0.type < arg_34_1.type
					end
				else
					return arg_34_0.level > arg_34_1.level
				end
			else
				return arg_34_0.data_tmp.def > arg_34_1.data_tmp.def
			end
		end)
	end

	function arg_1_0:select_sort_up_6()
		self:set_sort_func(function(arg_36_0, arg_36_1)
			if arg_36_0.data_tmp.def == arg_36_1.data_tmp.def then
				if arg_36_0.level == arg_36_1.level then
					if arg_36_0.type == arg_36_1.type then
						return arg_36_0.cid > arg_36_1.cid
					else
						return arg_36_0.type < arg_36_1.type
					end
				else
					return arg_36_0.level > arg_36_1.level
				end
			else
				return arg_36_0.data_tmp.def < arg_36_1.data_tmp.def
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype7()
		self._now_select_sort_layer_type = "sorttypes7"

		for iter_37_0 = 1, 19 do
			self._sort_type[iter_37_0].image.sprite = iter_37_0 == 7 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 7
	end

	function arg_1_0:select_sort_down_7()
		self:set_sort_func(function(arg_39_0, arg_39_1)
			if arg_39_0.data_tmp.torpedo == arg_39_1.data_tmp.torpedo then
				if arg_39_0.level == arg_39_1.level then
					if arg_39_0.type == arg_39_1.type then
						return arg_39_0.cid > arg_39_1.cid
					else
						return arg_39_0.type < arg_39_1.type
					end
				else
					return arg_39_0.level > arg_39_1.level
				end
			else
				return arg_39_0.data_tmp.torpedo > arg_39_1.data_tmp.torpedo
			end
		end)
	end

	function arg_1_0:select_sort_up_7()
		self:set_sort_func(function(arg_41_0, arg_41_1)
			if arg_41_0.data_tmp.torpedo == arg_41_1.data_tmp.torpedo then
				if arg_41_0.level == arg_41_1.level then
					if arg_41_0.type == arg_41_1.type then
						return arg_41_0.cid > arg_41_1.cid
					else
						return arg_41_0.type < arg_41_1.type
					end
				else
					return arg_41_0.level > arg_41_1.level
				end
			else
				return arg_41_0.data_tmp.torpedo < arg_41_1.data_tmp.torpedo
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype8()
		self._now_select_sort_layer_type = "sorttypes8"

		for iter_42_0 = 1, 19 do
			self._sort_type[iter_42_0].image.sprite = iter_42_0 == 8 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 8
	end

	function arg_1_0:select_sort_down_8()
		self:set_sort_func(function(arg_44_0, arg_44_1)
			if arg_44_0.data_tmp.miss == arg_44_1.data_tmp.miss then
				if arg_44_0.level == arg_44_1.level then
					if arg_44_0.type == arg_44_1.type then
						return arg_44_0.cid > arg_44_1.cid
					else
						return arg_44_0.type < arg_44_1.type
					end
				else
					return arg_44_0.level > arg_44_1.level
				end
			else
				return arg_44_0.data_tmp.miss > arg_44_1.data_tmp.miss
			end
		end)
	end

	function arg_1_0:select_sort_up_8()
		self:set_sort_func(function(arg_46_0, arg_46_1)
			if arg_46_0.data_tmp.miss == arg_46_1.data_tmp.miss then
				if arg_46_0.level == arg_46_1.level then
					if arg_46_0.type == arg_46_1.type then
						return arg_46_0.cid > arg_46_1.cid
					else
						return arg_46_0.type < arg_46_1.type
					end
				else
					return arg_46_0.level > arg_46_1.level
				end
			else
				return arg_46_0.data_tmp.miss < arg_46_1.data_tmp.miss
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype9()
		self._now_select_sort_layer_type = "sorttypes9"

		for iter_47_0 = 1, 19 do
			self._sort_type[iter_47_0].image.sprite = iter_47_0 == 9 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 9
	end

	function arg_1_0:select_sort_down_9()
		self:set_sort_func(function(arg_49_0, arg_49_1)
			if arg_49_0.data_tmp.air_def == arg_49_1.data_tmp.air_def then
				if arg_49_0.level == arg_49_1.level then
					if arg_49_0.type == arg_49_1.type then
						return arg_49_0.cid > arg_49_1.cid
					else
						return arg_49_0.type < arg_49_1.type
					end
				else
					return arg_49_0.level > arg_49_1.level
				end
			else
				return arg_49_0.data_tmp.air_def > arg_49_1.data_tmp.air_def
			end
		end)
	end

	function arg_1_0:select_sort_up_9()
		self:set_sort_func(function(arg_51_0, arg_51_1)
			if arg_51_0.data_tmp.air_def == arg_51_1.data_tmp.air_def then
				if arg_51_0.level == arg_51_1.level then
					if arg_51_0.type == arg_51_1.type then
						return arg_51_0.cid > arg_51_1.cid
					else
						return arg_51_0.type < arg_51_1.type
					end
				else
					return arg_51_0.level > arg_51_1.level
				end
			else
				return arg_51_0.data_tmp.air_def < arg_51_1.data_tmp.air_def
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype10()
		self._now_select_sort_layer_type = "sorttypes10"

		for iter_52_0 = 1, 19 do
			self._sort_type[iter_52_0].image.sprite = iter_52_0 == 10 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 10
	end

	function arg_1_0:select_sort_down_10()
		self:set_sort_func(function(arg_54_0, arg_54_1)
			if arg_54_0.data_tmp.antisub == arg_54_1.data_tmp.antisub then
				if arg_54_0.level == arg_54_1.level then
					if arg_54_0.type == arg_54_1.type then
						return arg_54_0.cid > arg_54_1.cid
					else
						return arg_54_0.type < arg_54_1.type
					end
				else
					return arg_54_0.level > arg_54_1.level
				end
			else
				return arg_54_0.data_tmp.antisub > arg_54_1.data_tmp.antisub
			end
		end)
	end

	function arg_1_0:select_sort_up_10()
		self:set_sort_func(function(arg_56_0, arg_56_1)
			if arg_56_0.data_tmp.antisub == arg_56_1.data_tmp.antisub then
				if arg_56_0.level == arg_56_1.level then
					if arg_56_0.type == arg_56_1.type then
						return arg_56_0.cid > arg_56_1.cid
					else
						return arg_56_0.type < arg_56_1.type
					end
				else
					return arg_56_0.level > arg_56_1.level
				end
			else
				return arg_56_0.data_tmp.antisub < arg_56_1.data_tmp.antisub
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype11()
		self._now_select_sort_layer_type = "sorttypes11"

		for iter_57_0 = 1, 19 do
			self._sort_type[iter_57_0].image.sprite = iter_57_0 == 11 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 11
	end

	function arg_1_0:select_sort_down_11()
		self:set_sort_func(function(arg_59_0, arg_59_1)
			if arg_59_0.data_tmp.speed == arg_59_1.data_tmp.speed then
				if arg_59_0.level == arg_59_1.level then
					if arg_59_0.type == arg_59_1.type then
						return arg_59_0.cid > arg_59_1.cid
					else
						return arg_59_0.type < arg_59_1.type
					end
				else
					return arg_59_0.level > arg_59_1.level
				end
			else
				return arg_59_0.data_tmp.speed > arg_59_1.data_tmp.speed
			end
		end)
	end

	function arg_1_0:select_sort_up_11()
		self:set_sort_func(function(arg_61_0, arg_61_1)
			if arg_61_0.data_tmp.speed == arg_61_1.data_tmp.speed then
				if arg_61_0.level == arg_61_1.level then
					if arg_61_0.type == arg_61_1.type then
						return arg_61_0.cid > arg_61_1.cid
					else
						return arg_61_0.type < arg_61_1.type
					end
				else
					return arg_61_0.level > arg_61_1.level
				end
			else
				return arg_61_0.data_tmp.speed < arg_61_1.data_tmp.speed
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype12()
		self._now_select_sort_layer_type = "sorttypes2"

		for iter_62_0 = 1, 19 do
			self._sort_type[iter_62_0].image.sprite = iter_62_0 == 12 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 12
	end

	function arg_1_0:select_sort_down_12()
		self:set_sort_func(function(arg_64_0, arg_64_1)
			if arg_64_0.data_tmp.radar == arg_64_1.data_tmp.radar then
				if arg_64_0.level == arg_64_1.level then
					if arg_64_0.type == arg_64_1.type then
						return arg_64_0.cid > arg_64_1.cid
					else
						return arg_64_0.type < arg_64_1.type
					end
				else
					return arg_64_0.level > arg_64_1.level
				end
			else
				return arg_64_0.data_tmp.radar > arg_64_1.data_tmp.radar
			end
		end)
	end

	function arg_1_0:select_sort_up_12()
		self:set_sort_func(function(arg_66_0, arg_66_1)
			if arg_66_0.data_tmp.radar == arg_66_1.data_tmp.radar then
				if arg_66_0.level == arg_66_1.level then
					if arg_66_0.type == arg_66_1.type then
						return arg_66_0.cid > arg_66_1.cid
					else
						return arg_66_0.type < arg_66_1.type
					end
				else
					return arg_66_0.level > arg_66_1.level
				end
			else
				return arg_66_0.data_tmp.radar < arg_66_1.data_tmp.radar
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype13()
		self._now_select_sort_layer_type = "sorttypes13"

		for iter_67_0 = 1, 19 do
			self._sort_type[iter_67_0].image.sprite = iter_67_0 == 13 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 13
	end

	function arg_1_0:select_sort_down_13()
		self:set_sort_func(function(arg_69_0, arg_69_1)
			if arg_69_0.data_tmp.luck == arg_69_1.data_tmp.luck then
				if arg_69_0.level == arg_69_1.level then
					if arg_69_0.type == arg_69_1.type then
						return arg_69_0.cid > arg_69_1.cid
					else
						return arg_69_0.type < arg_69_1.type
					end
				else
					return arg_69_0.level > arg_69_1.level
				end
			else
				return arg_69_0.data_tmp.luck > arg_69_1.data_tmp.luck
			end
		end)
	end

	function arg_1_0:select_sort_up_13()
		self:set_sort_func(function(arg_71_0, arg_71_1)
			if arg_71_0.data_tmp.luck == arg_71_1.data_tmp.luck then
				if arg_71_0.level == arg_71_1.level then
					if arg_71_0.type == arg_71_1.type then
						return arg_71_0.cid > arg_71_1.cid
					else
						return arg_71_0.type < arg_71_1.type
					end
				else
					return arg_71_0.level > arg_71_1.level
				end
			else
				return arg_71_0.data_tmp.luck < arg_71_1.data_tmp.luck
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype14()
		self._now_select_sort_layer_type = "sorttypes14"

		for iter_72_0 = 1, 19 do
			self._sort_type[iter_72_0].image.sprite = iter_72_0 == 14 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 14
	end

	function arg_1_0:select_sort_down_14()
		self:set_sort_func(function(arg_74_0, arg_74_1)
			if arg_74_0.statistics.create_time == arg_74_1.statistics.create_time then
				if arg_74_0.level == arg_74_1.level then
					if arg_74_0.type == arg_74_1.type then
						return arg_74_0.cid > arg_74_1.cid
					else
						return arg_74_0.type < arg_74_1.type
					end
				else
					return arg_74_0.level > arg_74_1.level
				end
			else
				return arg_74_0.statistics.create_time > arg_74_1.statistics.create_time
			end
		end)
	end

	function arg_1_0:select_sort_up_14()
		self:set_sort_func(function(arg_76_0, arg_76_1)
			if arg_76_0.statistics.create_time == arg_76_1.statistics.create_time then
				if arg_76_0.level == arg_76_1.level then
					if arg_76_0.type == arg_76_1.type then
						return arg_76_0.cid > arg_76_1.cid
					else
						return arg_76_0.type < arg_76_1.type
					end
				else
					return arg_76_0.level > arg_76_1.level
				end
			else
				return arg_76_0.statistics.create_time < arg_76_1.statistics.create_time
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype15()
		self._now_select_sort_layer_type = "sorttypes15"

		for iter_77_0 = 1, 19 do
			self._sort_type[iter_77_0].image.sprite = iter_77_0 == 15 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 15
	end

	function arg_1_0:select_sort_down_15()
		self:set_sort_func(function(arg_79_0, arg_79_1)
			if arg_79_0.love == arg_79_1.love then
				if arg_79_0.level == arg_79_1.level then
					if arg_79_0.type == arg_79_1.type then
						return arg_79_0.cid > arg_79_1.cid
					else
						return arg_79_0.type < arg_79_1.type
					end
				else
					return arg_79_0.level > arg_79_1.level
				end
			else
				return arg_79_0.love > arg_79_1.love
			end
		end)
	end

	function arg_1_0:select_sort_up_15()
		self:set_sort_func(function(arg_81_0, arg_81_1)
			if arg_81_0.love == arg_81_1.love then
				if arg_81_0.level == arg_81_1.level then
					if arg_81_0.type == arg_81_1.type then
						return arg_81_0.cid > arg_81_1.cid
					else
						return arg_81_0.type < arg_81_1.type
					end
				else
					return arg_81_0.level > arg_81_1.level
				end
			else
				return arg_81_0.love < arg_81_1.love
			end
		end)
	end

	function arg_1_0:__onClick_bg_select_info_cancel()
		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_select_info_confirm()
		if self._sort_type_state and self._sort_type_state == 1 then
			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)

			self:__select_click_down_btn()
			self:__update_parent_data(self._now_select_sort_layer_type, self._now_select_sort_layer_num)
			self:set_select_panel(self._now_select_sort_layer_num)
		elseif self._sort_type_state and self._sort_type_state == 2 then
			self:__select_click_up_btn()
			self:__update_parent_data(self._now_select_sort_layer_type, self._now_select_sort_layer_num)
			self:set_select_panel(self._now_select_sort_layer_num)

			self._control.bg.sort_info.sort_up.image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)
			self._control.bg.sort_info.sort_down.image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)
		end

		self:setVisible(false)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype16()
		self._now_select_sort_layer_type = "sorttypes16"

		for iter_84_0 = 1, 19 do
			self._sort_type[iter_84_0].image.sprite = iter_84_0 == 16 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 16
	end

	function arg_1_0:select_sort_down_16()
		self:set_sort_func(function(arg_86_0, arg_86_1)
			if arg_86_0.bullet == arg_86_1.bullet then
				if arg_86_0.level == arg_86_1.level then
					if arg_86_0.type == arg_86_1.type then
						return arg_86_0.cid > arg_86_1.cid
					else
						return arg_86_0.type < arg_86_1.type
					end
				else
					return arg_86_0.level > arg_86_1.level
				end
			else
				return arg_86_0.bullet > arg_86_1.bullet
			end
		end)
	end

	function arg_1_0:select_sort_up_16()
		self:set_sort_func(function(arg_88_0, arg_88_1)
			if arg_88_0.bullet == arg_88_1.bullet then
				if arg_88_0.level == arg_88_1.level then
					if arg_88_0.type == arg_88_1.type then
						return arg_88_0.cid > arg_88_1.cid
					else
						return arg_88_0.type < arg_88_1.type
					end
				else
					return arg_88_0.level > arg_88_1.level
				end
			else
				return arg_88_0.bullet < arg_88_1.bullet
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype17()
		self._now_select_sort_layer_type = "sorttypes17"

		for iter_89_0 = 1, 19 do
			self._sort_type[iter_89_0].image.sprite = iter_89_0 == 17 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 17
	end

	function arg_1_0:select_sort_down_17()
		self:set_sort_func(function(arg_91_0, arg_91_1)
			if arg_91_0.oil == arg_91_1.oil then
				if arg_91_0.level == arg_91_1.level then
					if arg_91_0.type == arg_91_1.type then
						return arg_91_0.cid > arg_91_1.cid
					else
						return arg_91_0.type < arg_91_1.type
					end
				else
					return arg_91_0.level > arg_91_1.level
				end
			else
				return arg_91_0.oil > arg_91_1.oil
			end
		end)
	end

	function arg_1_0:select_sort_up_17()
		self:set_sort_func(function(arg_93_0, arg_93_1)
			if arg_93_0.oil == arg_93_1.oil then
				if arg_93_0.level == arg_93_1.level then
					if arg_93_0.type == arg_93_1.type then
						return arg_93_0.cid > arg_93_1.cid
					else
						return arg_93_0.type < arg_93_1.type
					end
				else
					return arg_93_0.level > arg_93_1.level
				end
			else
				return arg_93_0.oil < arg_93_1.oil
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype18()
		self._now_select_sort_layer_type = "sorttypes18"

		for iter_94_0 = 1, 19 do
			self._sort_type[iter_94_0].image.sprite = iter_94_0 == 18 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 18
	end

	function arg_1_0:select_sort_down_18()
		self:set_sort_func(function(arg_96_0, arg_96_1)
			if arg_96_0.ship_index == arg_96_1.ship_index then
				if arg_96_0.level == arg_96_1.level then
					if arg_96_0.type == arg_96_1.type then
						return arg_96_0.cid > arg_96_1.cid
					else
						return arg_96_0.type < arg_96_1.type
					end
				else
					return arg_96_0.level > arg_96_1.level
				end
			else
				return arg_96_0.ship_index > arg_96_1.ship_index
			end
		end)
	end

	function arg_1_0:select_sort_up_18()
		self:set_sort_func(function(arg_98_0, arg_98_1)
			if arg_98_0.ship_index == arg_98_1.ship_index then
				if arg_98_0.level == arg_98_1.level then
					if arg_98_0.type == arg_98_1.type then
						return arg_98_0.cid > arg_98_1.cid
					else
						return arg_98_0.type < arg_98_1.type
					end
				else
					return arg_98_0.level > arg_98_1.level
				end
			else
				return arg_98_0.ship_index < arg_98_1.ship_index
			end
		end)
	end

	function arg_1_0:__onClick_bg_sort_btn_group_sorttype19()
		self._now_select_sort_layer_type = "sorttypes19"

		for iter_99_0 = 1, 19 do
			self._sort_type[iter_99_0].image.sprite = iter_99_0 == 19 and self:loadSprite(var_0_2.sort_type_const.selected1) or self:loadSprite(var_0_2.sort_type_const.btn1)
		end

		self._now_select_sort_layer_num = 19
	end

	function arg_1_0:select_sort_down_19()
		if var_0_4:get_cook_common_state() then
			self:set_sort_func(function(arg_101_0, arg_101_1)
				if arg_101_0.cook_exp == arg_101_1.cook_exp then
					if arg_101_0.level == arg_101_1.level then
						if arg_101_0.type == arg_101_1.type then
							return arg_101_0.cid > arg_101_1.cid
						else
							return arg_101_0.type < arg_101_1.type
						end
					else
						return arg_101_0.level > arg_101_1.level
					end
				else
					return arg_101_0.cook_exp > arg_101_1.cook_exp
				end
			end)
		else
			self:set_sort_func(function(arg_102_0, arg_102_1)
				if arg_102_0.tactics_exp == arg_102_1.tactics_exp then
					if arg_102_0.level == arg_102_1.level then
						if arg_102_0.type == arg_102_1.type then
							return arg_102_0.cid > arg_102_1.cid
						else
							return arg_102_0.type < arg_102_1.type
						end
					else
						return arg_102_0.level > arg_102_1.level
					end
				else
					return arg_102_0.tactics_exp > arg_102_1.tactics_exp
				end
			end)
		end
	end

	function arg_1_0:select_sort_up_19()
		if var_0_4:get_cook_common_state() then
			self:set_sort_func(function(arg_104_0, arg_104_1)
				if arg_104_0.cook_exp == arg_104_1.cook_exp then
					if arg_104_0.level == arg_104_1.level then
						if arg_104_0.type == arg_104_1.type then
							return arg_104_0.cid > arg_104_1.cid
						else
							return arg_104_0.type < arg_104_1.type
						end
					else
						return arg_104_0.level > arg_104_1.level
					end
				else
					return arg_104_0.cook_exp < arg_104_1.cook_exp
				end
			end)
		else
			self:set_sort_func(function(arg_105_0, arg_105_1)
				if arg_105_0.tactics_exp == arg_105_1.tactics_exp then
					if arg_105_0.level == arg_105_1.level then
						if arg_105_0.type == arg_105_1.type then
							return arg_105_0.cid > arg_105_1.cid
						else
							return arg_105_0.type < arg_105_1.type
						end
					else
						return arg_105_0.level > arg_105_1.level
					end
				else
					return arg_105_0.tactics_exp < arg_105_1.tactics_exp
				end
			end)
		end
	end

	function arg_1_0:__update_parent_data(arg_106_1, arg_106_2)
		self:__change_img(arg_106_2)

		local var_106_0 = var_0_1:getInstance("select_member")
		local var_106_1 = var_0_1:getInstance("tactics_select_member")

		if var_106_0 then
			var_106_0:__update_edge_mask()
		elseif var_106_1 then
			var_106_1:__update_edge_mask()
		end

		if self._click_listener then
			print("有事件回调")
			self._click_listener(self._source_data, arg_106_1)
		end
	end

	function arg_1_0:__change_img(arg_107_1)
		self._control.bg.sort_btn_group["sorttype" .. self._sort_id].image.sprite = self:loadSprite(var_0_2.sort_type_const.btn2)

		self:set_sort_id(arg_107_1)

		self._control.bg.sort_btn_group["sorttype" .. self._sort_id].image.sprite = self:loadSprite(var_0_2.sort_type_const.selected2)

		self:setVisible(false)
	end

	function arg_1_0:set_select_panel(arg_108_1)
		for iter_108_0 = 1, 19 do
			if iter_108_0 == arg_108_1 then
				self._control.bg.sort_btn_group["sorttype" .. arg_108_1].image.sprite = self:loadSprite(var_0_2.sort_type_const.selected1)
			else
				self._control.bg.sort_btn_group["sorttype" .. iter_108_0].image.sprite = self:loadSprite(var_0_2.sort_type_const.btn1)
			end
		end
	end
end

function var_0_0.extend_obj(arg_109_0)
	return
end

return var_0_0
