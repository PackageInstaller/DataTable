local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.util_func
local var_0_5 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:play_in_out_animation(false, function()
			var_0_1:destroyInstance("equip_map")

			if var_0_1:getInstance("equip_datail") then
				var_0_1:destroyInstance("equip_datail")
			end

			var_0_4.return_home_with_menu_active()
		end)

		local var_2_0 = var_0_1:getInstance("home")

		if var_2_0 and var_0_5:get_secretary_info().rand_secretary_flag == 1 then
			var_2_0:updata_model()
		end
	end

	function arg_1_0:__onClick_type_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0:__onClick_type_layer()
		self:__clear_input_field_name()
		self:__check_type_selection()

		self._type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_5_0, iter_5_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_5_1 then
				self._type_toggle_data[iter_5_0] = iter_5_1
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()
		self:__update_cell()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_btn_series_confirm_btn()
		self:__check_type_selection()

		self._type_toggle_data = {}
		self._type_toggle_data.all = self._toggle_type_group_obj._rule_a.set.all

		for iter_6_0, iter_6_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
			if iter_6_1 then
				self._type_toggle_data[iter_6_0] = iter_6_1
			end
		end

		self._control.type_layer:SetActive(false)
		self:__change_type_text()
		self:__update_cell()
	end

	function arg_1_0:__onClick_type_layer_btn_series_cancel_btn()
		self:show_sort_layer(false)

		self._need_revert = true
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_type_group_obj_rule_a.all ~= self._toggle_type_group_obj._rule_a.set.all then
			self._control.type_layer.type_group.toggle_group.all.toggle.isOn = self._last_toggle_type_group_obj_rule_a.all
		end

		for iter_8_0, iter_8_1 in pairs(self._last_toggle_type_group_obj_rule_b) do
			if iter_8_1 ~= self._toggle_type_group_obj._rule_b.set[iter_8_0] then
				self._control.type_layer.type_group.toggle_group[iter_8_0].toggle.isOn = iter_8_1
			end
		end
	end

	function arg_1_0:__check_type_selection()
		if self._toggle_type_group_obj then
			for iter_9_0, iter_9_1 in pairs(self._toggle_type_group_obj._rule_b.set) do
				if iter_9_0 == self._last_type then
					self._toggle_type_group_obj._rule_b.set[iter_9_0] = true
					self._toggle_type_group_obj._rule_a.set.all = false
				else
					self._toggle_type_group_obj._rule_b.set[iter_9_0] = false
				end
			end

			if self._last_type == "all" then
				self._toggle_type_group_obj._rule_a.set.all = true
			end
		end
	end

	function arg_1_0.__onToggle_type_layer_own_group_toggle_group_all(arg_10_0)
		arg_10_0._own_toggle_data = "all"
	end

	function arg_1_0.__onToggle_type_layer_own_group_toggle_group_own_type(arg_11_0)
		arg_11_0._own_toggle_data = "own"
	end

	function arg_1_0.__onToggle_type_layer_own_group_toggle_group_not_own_type(arg_12_0)
		arg_12_0._own_toggle_data = "not_own"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_all(arg_13_0)
		arg_13_0._last_type = "all"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_main_gun(arg_14_0)
		arg_14_0._last_type = "main_gun"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_sub_gun(arg_15_0)
		arg_15_0._last_type = "sub_gun"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_torpedo(arg_16_0)
		arg_16_0._last_type = "torpedo"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_torpedo_plane(arg_17_0)
		arg_17_0._last_type = "torpedo_plane"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_fighter(arg_18_0)
		arg_18_0._last_type = "fighter"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_bomber(arg_19_0)
		arg_19_0._last_type = "bomber"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_spy_plane(arg_20_0)
		arg_20_0._last_type = "spy_plane"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_radar(arg_21_0)
		arg_21_0._last_type = "radar"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_module(arg_22_0)
		arg_22_0._last_type = "module"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_bullet(arg_23_0)
		arg_23_0._last_type = "bullet"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_aagun(arg_24_0)
		arg_24_0._last_type = "aagun"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_special_torpedo(arg_25_0)
		arg_25_0._last_type = "special_torpedo"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_repairs(arg_26_0)
		arg_26_0._last_type = "repairs"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_anti_sub(arg_27_0)
		arg_27_0._last_type = "anti_sub"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_missile_launcher(arg_28_0)
		arg_28_0._last_type = "missile_launcher"
	end

	function arg_1_0.__onToggle_type_layer_type_group_toggle_group_missile(arg_29_0)
		arg_29_0._last_type = "missile"
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		if not self._toggle_type_group_obj then
			self._toggle_type_group_obj._rule_a.set = {
				all = true
			}
			self._toggle_type_group_obj._rule_b.set = {
				bomber = false,
				anti_sub = false,
				bullet = false,
				torpedo = false,
				module = false,
				spy_plane = false,
				missile = false,
				torpedo_plane = false,
				sub_gun = false,
				aagun = false,
				fighter = false,
				main_gun = false,
				missile_launcher = false,
				repairs = false,
				radar = false
			}
		end

		self._last_toggle_type_group_obj_rule_a = var_0_4.little_clone(self._toggle_type_group_obj._rule_a.set)
		self._last_toggle_type_group_obj_rule_b = var_0_4.little_clone(self._toggle_type_group_obj._rule_b.set)
	end

	function arg_1_0:__change_type_text()
		local var_31_0 = false
		local var_31_1

		if self._type_toggle_data.all then
			var_31_1 = false
		elseif var_0_4.dict_lenght(self._type_toggle_data) <= 2 then
			for iter_31_0, iter_31_1 in pairs(self._type_toggle_data) do
				if iter_31_0 ~= "all" then
					var_31_1 = iter_31_0 == "missile_launcher" and var_0_3:getNowLang("equip32") or iter_31_0 == "missile" and var_0_3:getNowLang("equip34") or var_0_3:getNowLang("equip" .. tostring(var_0_2.equip_type[iter_31_0]))
				end
			end
		else
			var_31_0 = true
		end

		local var_31_2 = self._own_toggle_data == "own" and var_0_3:getNowLang("medaltypegain") or self._own_toggle_data == "not_own" and var_0_3:getNowLang("medaltypeungain") or false

		self._control.type_btn.type_txt.text.text = var_31_0 and var_0_3:getNowLang("multiselect") or var_31_1 and var_31_2 and var_31_1 .. "+" .. var_31_2 or (var_31_2 or var_31_1) and (var_31_2 or var_31_1) or var_0_3:getNowLang("questall")
	end
end

function var_0_0.extend_obj(arg_32_0)
	return
end

return var_0_0
