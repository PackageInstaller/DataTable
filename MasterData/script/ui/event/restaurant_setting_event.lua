local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
		self:setVisible(false)
		var_0_1:createInstance("restaurant"):show(var_0_2.enter_restaurant_type.cook_setting)
		self:__reset_type_layer()

		self._control.menu_list.type_btn.txt.text.text = var_0_3:getNowLang("countrytype") .. var_0_3:getNowLang("country0")
	end

	function arg_1_0:__onClick_cooker()
		var_0_1:createInstance("select_member"):show_by_type(var_0_2.enter_select_member_type.restaurant)
		self:setVisible(false)
	end

	function arg_1_0:__onClick_menu_list_type_btn()
		self:show_country_layer(true)
	end

	function arg_1_0:__onClick_country_layer()
		self:show_country_layer(false)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_all()
		self:__toggle_event("all", self._toggle_style_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_J_country()
		self:__toggle_event("J_country", self._toggle_style_group.J_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_G_country()
		self:__toggle_event("G_country", self._toggle_style_group.G_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_E_country()
		self:__toggle_event("E_country", self._toggle_style_group.E_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_U_country()
		self:__toggle_event("U_country", self._toggle_style_group.U_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_I_country()
		self:__toggle_event("I_country", self._toggle_style_group.I_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_F_country()
		self:__toggle_event("F_country", self._toggle_style_group.F_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_S_country()
		self:__toggle_event("S_country", self._toggle_style_group.S_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_C_country()
		self:__toggle_event("C_country", self._toggle_style_group.C_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_general()
		self:__toggle_event("general", self._toggle_style_group.general.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_get()
		self:__toggle_event("get", self._toggle_style_group.get.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_not_get()
		self:__toggle_event("not_get", self._toggle_style_group.not_get.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_country_layer_toggle_group_can_set()
		self:__toggle_event("can_set", self._toggle_style_group.can_set.toggle.isOn)
	end

	function arg_1_0:__onClick_my_menu_single_food_able_1_food_quality()
		self:set_cookbook_layer(false, self._now_used_cookbook_data[1])
	end

	function arg_1_0:__onClick_my_menu_single_food_able_2_food_quality()
		self:set_cookbook_layer(false, self._now_used_cookbook_data[2])
	end

	function arg_1_0:__onClick_my_menu_single_food_able_3_food_quality()
		self:set_cookbook_layer(false, self._now_used_cookbook_data[3])
	end

	function arg_1_0:__onClick_cookbook_info_close_btn()
		self._control.cookbook_info:SetActive(false)
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_all(arg_23_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_J_country(arg_24_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_G_country(arg_25_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_E_country(arg_26_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_U_country(arg_27_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_I_country(arg_28_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_F_country(arg_29_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_S_country(arg_30_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_C_country(arg_31_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_general(arg_32_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_get(arg_33_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_not_get(arg_34_0)
		return
	end

	function arg_1_0.__onToggle_country_layer_toggle_group_can_set(arg_35_0)
		return
	end

	function arg_1_0:__toggle_event(arg_36_1, arg_36_2)
		self._style_toggle_data = {}

		if arg_36_2 then
			self._style_toggle_data = {
				arg_36_1
			}
			self._control.menu_list.type_btn.txt.text.text = var_0_3:getNowLang("countrytype") .. var_0_3:getNowLang(arg_36_1 == "all" and "country0" or arg_36_1 == "general" and "country99" or arg_36_1 == "get" and "medaltypegain" or arg_36_1 == "not_get" and "nothave" or arg_36_1 == "can_set" and "canset" or "country" .. tostring(var_0_2.filter_country[arg_36_1]))

			self:update_cookbook_list()
			self:show_country_layer(false)
		end
	end

	function arg_1_0:__reset_type_layer()
		for iter_37_0, iter_37_1 in pairs(self._toggle_style_group) do
			iter_37_1.toggle.isOn = false
		end

		self._toggle_style_group.all.toggle.isOn = true
	end
end

function var_0_0.extend_obj(arg_38_0)
	return
end

return var_0_0
