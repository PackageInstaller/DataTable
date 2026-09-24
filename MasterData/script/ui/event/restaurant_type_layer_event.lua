local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.Language

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:setVisible(false)
		var_0_1:set_cook_common_state(false)

		local var_2_0 = var_0_2:getInstance("select_member")

		if var_2_0 and var_2_0._sort_layer then
			var_2_0._sort_layer._now_select_sort_layer_num = 1

			var_2_0._sort_layer:reset_select_state()
			var_2_0._sort_layer:set_select_panel(1)
			var_2_0._sort_layer:select_sort_down_1()

			var_2_0._control.sort_order_btn.sort_txt.text.text = var_0_4:getNowLang("sorttypes3")
		end

		var_0_2:destroyInstance("restaurant_type_layer")

		local var_2_1 = var_0_2:getInstance("restaurant")

		if var_2_1 then
			var_2_1:show(var_0_3.enter_restaurant_type.cook_setting)
		else
			var_0_2:createInstance("restaurant"):show(var_0_3.enter_restaurant_type.cook_setting)
		end
	end

	function arg_1_0:__onClick_menu_list_type_btn()
		self:show_country_layer(true)
	end

	function arg_1_0:__onClick_country_layer()
		self:show_country_layer(false)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_all()
		self:__toggle_event("all", self._toggle_style_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_J_country()
		self:__toggle_event("J_country", self._toggle_style_group.J_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_G_country()
		self:__toggle_event("G_country", self._toggle_style_group.G_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_E_country()
		self:__toggle_event("E_country", self._toggle_style_group.E_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_U_country()
		self:__toggle_event("U_country", self._toggle_style_group.U_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_I_country()
		self:__toggle_event("I_country", self._toggle_style_group.I_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_F_country()
		self:__toggle_event("F_country", self._toggle_style_group.F_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_S_country()
		self:__toggle_event("S_country", self._toggle_style_group.S_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_C_country()
		self:__toggle_event("C_country", self._toggle_style_group.C_country.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_general()
		self:__toggle_event("general", self._toggle_style_group.general.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_get()
		self:__toggle_event("get", self._toggle_style_group.get.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_not_get()
		self:__toggle_event("not_get", self._toggle_style_group.not_get.toggle.isOn)
	end

	function arg_1_0:__onToggle_country_layer_toggle_group_can_set()
		self:__toggle_event("can_set", self._toggle_style_group.can_set.toggle.isOn)
	end

	function arg_1_0:__toggle_event(arg_18_1, arg_18_2)
		self._style_toggle_data = {}

		if arg_18_2 then
			self._style_toggle_data = {
				arg_18_1
			}
			self._control.menu_list.type_btn.txt.text.text = var_0_4:getNowLang("countrytype") .. var_0_4:getNowLang(arg_18_1 == "all" and "country0" or arg_18_1 == "general" and "country99" or arg_18_1 == "get" and "medaltypegain" or arg_18_1 == "not_get" and "nothave" or arg_18_1 == "can_set" and "canset" or "country" .. tostring(var_0_3.filter_country[arg_18_1]))

			self:update_cookbook_list()
			self:show_country_layer(false)
		end
	end
end

function var_0_0.extend_obj(arg_19_0)
	return
end

return var_0_0
