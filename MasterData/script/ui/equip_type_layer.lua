local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader

gamecore.UILoader:define("equip_type_layer", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:set_listener(arg_3_1, arg_3_2)
		arg_3_1 = arg_3_1 or self._default_type_str
		self._is_init_type_layer = false

		self:__set_type_layer(arg_3_1)

		self._is_init_type_layer = true
	end

	function arg_1_0:__get_type_toggle(arg_4_1)
		local var_4_0

		for iter_4_0, iter_4_1 in pairs(self._toggle_type_group) do
			if arg_4_1 == iter_4_1.transform.name then
				var_4_0 = iter_4_1
			end
		end

		return var_4_0
	end

	function arg_1_0:__get_effect_toggle(arg_5_1)
		local var_5_0

		for iter_5_0, iter_5_1 in pairs(self._toggle_effect_group) do
			if arg_5_1 == iter_5_1.transform.name then
				var_5_0 = iter_5_1
			end
		end

		return var_5_0
	end

	function arg_1_0:__set_type_layer(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(self._toggle_type_group) do
			iter_6_1.toggle.isOn = false
		end

		self:__get_type_toggle(arg_6_1).toggle.isOn = true

		for iter_6_2, iter_6_3 in pairs(self._toggle_effect_group) do
			iter_6_3.toggle.isOn = false
		end

		self:__get_effect_toggle(arg_6_1).toggle.isOn = true
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_filter_type_list()
		end

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.type_layer.filter_type.type_txt.text.text = var_0_1:getNowLang("type")
		self._control.type_layer.btn_series.cancel_btn.cancel.text.text = var_0_1:getNowLang("cancel")

		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.btn_series.confirm_btn.confirm_mask, var_0_1:getNowLang("confirm"))

		self._control.type_layer.type_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shiptype0")

		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.main_gun.title_mask, var_0_1:getNowLang("equip1"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.sub_gun.title_mask, var_0_1:getNowLang("equip2"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.torpedo.title_mask, var_0_1:getNowLang("equip3"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.torpedo_plane.title_mask, var_0_1:getNowLang("equip4"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.fighter.title_mask, var_0_1:getNowLang("equip5"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.bomber.title_mask, var_0_1:getNowLang("equip6"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.spy_plane.title_mask, var_0_1:getNowLang("equip7"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.radar.title_mask, var_0_1:getNowLang("equip8"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.module.title_mask, var_0_1:getNowLang("equip9"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.bullet.title_mask, var_0_1:getNowLang("equip10"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.aagun.title_mask, var_0_1:getNowLang("equip11"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.repairs.title_mask, var_0_1:getNowLang("equip13"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.anti_sub.title_mask, var_0_1:getNowLang("equip14"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.missile_launcher.title_mask, var_0_1:getNowLang("equip32"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.type_group.toggle_group.missile.title_mask, var_0_1:getNowLang("equip34"))

		self._control.type_layer.effect_group.toggle_group.all.Label.text.text = var_0_1:getNowLang("shiptype0")

		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.attack.title_mask, var_0_1:getNowLang("equipment_effect_type_1"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.extra_damage.title_mask, var_0_1:getNowLang("equipment_effect_type_2"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.exp_up.title_mask, var_0_1:getNowLang("equipment_effect_type_3"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.armor_pene.title_mask, var_0_1:getNowLang("equipment_effect_type_4"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.expedition_resource.title_mask, var_0_1:getNowLang("equipment_effect_type_5"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.hit_rate.title_mask, var_0_1:getNowLang("equipment_effect_type_6"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.miss.title_mask, var_0_1:getNowLang("equipment_effect_type_7"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.critical_rate.title_mask, var_0_1:getNowLang("equipment_effect_type_8"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.anti_air.title_mask, var_0_1:getNowLang("equipment_effect_type_9"))
		gamecore.util_func.setTextHorizonInfo(self._control.type_layer.effect_group.toggle_group.atk_top.title_mask, var_0_1:getNowLang("equipment_effect_type_10"))
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_type_group = {
			all = self._control.type_layer.type_group.toggle_group.all,
			main_gun = self._control.type_layer.type_group.toggle_group.main_gun,
			sub_gun = self._control.type_layer.type_group.toggle_group.sub_gun,
			torpedo = self._control.type_layer.type_group.toggle_group.torpedo,
			torpedo_plane = self._control.type_layer.type_group.toggle_group.torpedo_plane,
			fighter = self._control.type_layer.type_group.toggle_group.fighter,
			bomber = self._control.type_layer.type_group.toggle_group.bomber,
			spy_plane = self._control.type_layer.type_group.toggle_group.spy_plane,
			radar = self._control.type_layer.type_group.toggle_group.radar,
			module = self._control.type_layer.type_group.toggle_group.module,
			bullet = self._control.type_layer.type_group.toggle_group.bullet,
			aagun = self._control.type_layer.type_group.toggle_group.aagun,
			repairs = self._control.type_layer.type_group.toggle_group.repairs,
			anti_sub = self._control.type_layer.type_group.toggle_group.anti_sub,
			missile_launcher = self._control.type_layer.type_group.toggle_group.missile_launcher,
			missile = self._control.type_layer.type_group.toggle_group.missile
		}
		self._toggle_type_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"main_gun",
			"sub_gun",
			"torpedo",
			"torpedo_plane",
			"fighter",
			"bomber",
			"spy_plane",
			"radar",
			"module",
			"bullet",
			"aagun",
			"repairs",
			"anti_sub",
			"missile_launcher",
			"missile"
		}, self._toggle_type_group)
		self._toggle_effect_group = {
			all = self._control.type_layer.effect_group.toggle_group.all,
			attack = self._control.type_layer.effect_group.toggle_group.attack,
			extra_damage = self._control.type_layer.effect_group.toggle_group.extra_damage,
			exp_up = self._control.type_layer.effect_group.toggle_group.exp_up,
			armor_pene = self._control.type_layer.effect_group.toggle_group.armor_pene,
			expedition_resource = self._control.type_layer.effect_group.toggle_group.expedition_resource,
			hit_rate = self._control.type_layer.effect_group.toggle_group.hit_rate,
			miss = self._control.type_layer.effect_group.toggle_group.miss,
			critical_rate = self._control.type_layer.effect_group.toggle_group.critical_rate,
			anti_air = self._control.type_layer.effect_group.toggle_group.anti_air,
			atk_top = self._control.type_layer.effect_group.toggle_group.atk_top,
			other = self._control.type_layer.effect_group.toggle_group.other
		}
		self._toggle_effect_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"attack",
			"extra_damage",
			"exp_up",
			"armor_pene",
			"expedition_resource",
			"hit_rate",
			"miss",
			"critical_rate",
			"anti_air",
			"atk_top",
			"other"
		}, self._toggle_effect_group)
	end

	function arg_1_0.__set_search_result(arg_10_0)
		local var_10_0 = var_0_2:getInstance("equip_list")

		if var_10_0 then
			var_10_0:init_equip_data()
			var_10_0:__show_capacity()
			var_10_0:set_equip_input_fidle_type_out()

			if var_10_0._is_use_equip then
				var_10_0:_show_already_use_equip(true)
			else
				var_10_0:__update_cell_list()
			end
		end

		local var_10_1 = var_0_2:getInstance("bootyshop")

		if var_10_1 then
			var_10_1:__update_cell()
		end

		local var_10_2 = var_0_2:getInstance("dock")

		if var_10_2 then
			var_10_2:__update_reusable_cell_3()
		end

		local var_10_3 = var_0_2:getInstance("research_ship_equip")

		if var_10_3 then
			var_10_3:__update_cell_list()
		end
	end

	function arg_1_0.reset_sort_info(arg_11_0)
		arg_11_0._type_toggle_txt = ""
		arg_11_0._type_toggle_data = {
			all = true
		}
		arg_11_0._effect_toggle_data = {
			all = true
		}
	end

	function arg_1_0.__onReset(arg_12_0)
		return
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_13_0)
	local var_13_0 = var_0_2:class("equip_type_layer")

	var_13_0._is_already_init = false
	var_13_0._type_toggle_data = {
		all = true
	}
	var_13_0._type_toggle_txt = ""
	var_13_0._toggle_type_group = nil
	var_13_0._effect_toggle_data = {
		all = true
	}
	var_13_0._effect_toggle_txt = ""
	var_13_0._toggle_effect_group = nil
	var_13_0._confirm_listener = nil
	var_13_0._is_init_type_layer = false
	var_13_0._is_init_effect_layer = false
	var_13_0._default_type_str = "all"
	var_13_0._toggle_effect_group_obj = nil
	var_13_0._toggle_effect_group = nil
	var_13_0._toggle_type_group_obj = nil
	var_13_0._toggle_type_group = nil

	gamecore.extend_obj(var_13_0)

	return var_13_0
end

return var_0_0
