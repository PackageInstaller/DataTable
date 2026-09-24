local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.util_func
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onClick_top_return_btn()
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back_two))
		self:setVisible(false)

		local var_2_0 = var_0_2:getInstance("mall_shop")

		if var_2_0 then
			var_2_0:setVisible(true)
			var_2_0:__onToggle_top_layer_top_btn_btnfive()
		else
			local var_2_1 = var_0_2:createInstance("mall_shop")

			var_2_1:setVisible(true)
			var_2_1:show()
			var_2_1:__onToggle_top_layer_top_btn_btnfive()
		end
	end

	function arg_1_0:__onClick_top_ship_type_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		else
			self:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_all()
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0:__onClick_type_layer_bg()
		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_4_0, iter_4_1 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_4_1 then
				self._effect_toggle_data[iter_4_0] = iter_4_1
			end
		end

		self:__change_type_text()
		self:__init_shop_skin_data()

		if self._search_text_trans.text then
			self:update_search_ship_data(self._search_text_trans.text)
		else
			self:__update_skin_cell()
		end

		self:__update_cell()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_bg_btn_series_confirm_btn()
		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_5_0, iter_5_1 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_5_1 then
				self._effect_toggle_data[iter_5_0] = iter_5_1
			end
		end

		self:__change_type_text()
		self:__init_shop_skin_data()

		if self._search_text_trans.text then
			self:update_search_ship_data(self._search_text_trans.text)
		else
			self:__update_skin_cell()
		end

		self:__update_cell()
		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_type_layer_bg_btn_series_cancel_btn()
		self:show_sort_layer(false)

		self._need_revert = true
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_effect_group_obj_rule_a.all ~= self._toggle_effect_group_obj._rule_a.set.all then
			self._control.type_layer.bg.effect_group.toggle_group.all.toggle.isOn = self._last_toggle_effect_group_obj_rule_a.all
		end

		for iter_7_0, iter_7_1 in pairs(self._last_toggle_effect_group_obj_rule_b) do
			if iter_7_1 ~= self._toggle_effect_group_obj._rule_b.set[iter_7_0] then
				self._control.type_layer.bg.effect_group.toggle_group[iter_7_0].toggle.isOn = iter_7_1
			end
		end
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_effect_group_obj_rule_a = var_0_4.little_clone(self._toggle_effect_group_obj._rule_a.set)
		self._last_toggle_effect_group_obj_rule_b = var_0_4.little_clone(self._toggle_effect_group_obj._rule_b.set)
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_all(arg_9_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_shell_effect(arg_10_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_live(arg_11_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_sp_music(arg_12_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_sp_dialogue(arg_13_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_sp_menu(arg_14_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_airplane(arg_15_0)
		return
	end

	function arg_1_0.__onToggle_type_layer_bg_effect_group_toggle_group_voice(arg_16_0)
		return
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_all()
		self._toggle_effect_group_obj:toggleOn("all", self._toggle_effect_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_shell_effect()
		self._toggle_effect_group_obj:toggleOn("shell_effect", self._toggle_effect_group.shell_effect.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_live()
		self._toggle_effect_group_obj:toggleOn("live", self._toggle_effect_group.live.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_sp_music()
		self._toggle_effect_group_obj:toggleOn("sp_music", self._toggle_effect_group.sp_music.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_sp_dialogue()
		self._toggle_effect_group_obj:toggleOn("sp_dialogue", self._toggle_effect_group.sp_dialogue.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_sp_menu()
		self._toggle_effect_group_obj:toggleOn("sp_menu", self._toggle_effect_group.sp_menu.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_airplane()
		self._toggle_effect_group_obj:toggleOn("airplane", self._toggle_effect_group.airplane.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_type_layer_bg_effect_group_toggle_group_voice()
		self._toggle_effect_group_obj:toggleOn("voice", self._toggle_effect_group.voice.toggle.isOn)
	end

	function arg_1_0:__onClick_buy_msgbox_main_quitbtn()
		self._control.buy_msgbox.gameObject:SetActive(false)
	end

	function arg_1_0.__onClick_buy_msgbox_main_confirmbtn(arg_26_0)
		return
	end

	function arg_1_0.__onClick_top_search_btn(arg_27_0)
		return
	end

	function arg_1_0:__change_type_text()
		local var_28_0 = false
		local var_28_1

		if self._effect_toggle_data.all then
			var_28_1 = false
		elseif var_0_4.dict_lenght(self._effect_toggle_data) <= 2 then
			for iter_28_0, iter_28_1 in pairs(self._effect_toggle_data) do
				if iter_28_0 == "shell_effect" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_1")
				elseif iter_28_0 == "live" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_2")
				elseif iter_28_0 == "sp_music" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_3")
				elseif iter_28_0 == "sp_dialogue" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_4")
				elseif iter_28_0 == "sp_menu" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_5")
				elseif iter_28_0 == "airplane" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_6")
				elseif iter_28_0 == "voice" then
					var_28_1 = var_0_3:getNowLang("skin_effect_type_7")
				end
			end
		else
			var_28_0 = true
		end

		self._control.top.ship_type_btn.type_text.text.text = var_28_0 and var_0_3:getNowLang("multiselect") or var_28_1 and var_28_1 or var_0_3:getNowLang("questall")
	end
end

function var_0_0.extend_obj(arg_29_0)
	arg_29_0._need_revert = false
	arg_29_0._last_toggle_effect_group_obj_rule_a = {}
	arg_29_0._last_toggle_effect_group_obj_rule_b = {}
end

return var_0_0
