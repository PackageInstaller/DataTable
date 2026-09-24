local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gamecore.util_func
local var_0_5 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:__onToggle_top_layer_top_btn_btnone()
		self:__select_one(var_0_5.mall_layer_type.layer_diamond)
		self:update_user_res_data(false)
		self._control.top_layer.type_btn:SetActive(false)
		self:show_skin_voucher_store(false)
	end

	function arg_1_0:__onToggle_top_layer_top_btn_btntwo()
		self:__select_one(var_0_5.mall_layer_type.layer_item)
		self._control.top_layer.type_btn:SetActive(false)
		self:show_skin_voucher_store(false)
	end

	function arg_1_0:__onToggle_top_layer_top_btn_btnthree()
		self:__select_one(var_0_5.mall_layer_type.layer_func)
		self._control.top_layer.type_btn:SetActive(false)
		self:show_skin_voucher_store(false)
	end

	function arg_1_0:__onToggle_top_layer_top_btn_btnfour()
		self:__select_one(var_0_5.mall_layer_type.layer_other)
		self._control.top_layer.type_btn:SetActive(false)
		self:show_skin_voucher_store(false)
	end

	function arg_1_0:__onToggle_top_layer_top_btn_btnfive()
		self:__select_one(var_0_5.mall_layer_type.layer_skin)
		self._control.top_layer.type_btn:SetActive(true)
		self:show_sort_layer(false)
		self:show_skin_voucher_store(true)
	end

	function arg_1_0:__onScaleButtonClick_top_layer_returnbtn()
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.back_two))

		local var_7_0

		if self._enter_type ~= var_0_5.mall_enter_type.enter_marry then
			function var_7_0()
				self:destroy_panel()

				if self._enter_type == var_0_5.mall_enter_type.enter_menu then
					local var_8_0 = var_0_2:createInstance("main_menu")

					var_8_0:reset()
					var_8_0:show(false)
				elseif self._enter_type == var_0_5.mall_enter_type.enter_marry then
					local var_8_1 = var_0_2:getInstance("ship_detail")

					if var_8_1 then
						var_8_1:set_enter_type()
						var_8_1:setVisible(true)
						var_8_1:update_data()
					end

					local var_8_2 = var_0_2:createInstance("marry")

					if var_8_2 then
						var_8_2:setVisible(true)
						var_8_2:update_data()
					end
				elseif self._enter_type == var_0_5.mall_enter_type.enter_topup then
					local var_8_3 = var_0_2:getInstance("firsttopup")

					function var_7_0()
						var_8_3:setVisible(true)
						self:destroy_panel()
					end
				end
			end
		end

		self:play_in_out_animation(false, function()
			self._now_label_index = 0

			if var_7_0 then
				var_7_0()
			end
		end, self._now_content.uITweenSequence)
		self:play_in_out_animation(false)

		if self._is_from_marry then
			self:setVisible(false)
			var_0_2:destroyInstance("marry")

			local var_7_1 = var_0_2:getInstance("ship_detail")

			if var_7_1 then
				var_7_1:setVisible(true)
			end

			var_0_2:createInstance("marry"):show(self._from_marry_data, self._from_marry_data)
		else
			var_0_2:getInstance("home"):show(true)
		end

		self:reset_skin_effect_select()
	end

	function arg_1_0:__onClick_changepage_type_layer_bg()
		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_11_0, iter_11_1 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_11_1 then
				self._effect_toggle_data[iter_11_0] = iter_11_1
			end
		end

		self._using_toggle_data = {}
		self._using_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_11_2, iter_11_3 in pairs(self._toggle_using_group_obj._rule_b.set) do
			if iter_11_3 then
				self._using_toggle_data[iter_11_2] = iter_11_3
			end
		end

		self:__change_type_text()

		if self._search_text_trans.text then
			self:update_search_ship_data(self._search_text_trans.text)
		else
			self:__update_skin_cell()
		end

		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_changepage_type_layer_bg_btn_series_confirm_btn()
		self._effect_toggle_data = {}
		self._effect_toggle_data.all = self._toggle_effect_group_obj._rule_a.set.all

		for iter_12_0, iter_12_1 in pairs(self._toggle_effect_group_obj._rule_b.set) do
			if iter_12_1 then
				self._effect_toggle_data[iter_12_0] = iter_12_1
			end
		end

		self._using_toggle_data = {}
		self._using_toggle_data.all = self._toggle_using_group_obj._rule_a.set.all

		for iter_12_2, iter_12_3 in pairs(self._toggle_using_group_obj._rule_b.set) do
			if iter_12_3 then
				self._using_toggle_data[iter_12_2] = iter_12_3
			end
		end

		self:__change_type_text()

		if self._search_text_trans.text then
			self:update_search_ship_data(self._search_text_trans.text)
		else
			self:__update_skin_cell()
		end

		self:show_sort_layer(false)
	end

	function arg_1_0:__onClick_changepage_type_layer_bg_btn_series_cancel_btn()
		self:show_sort_layer(false)

		self._need_revert = true
	end

	function arg_1_0:__onClick_top_layer_type_btn()
		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		else
			self:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_all()
		end

		self:__save_toggle_group_all_set_data()
		self:show_sort_layer(true)
	end

	function arg_1_0:__revert_toggle_group_all_set()
		if self._last_toggle_effect_group_obj_rule_a.all ~= self._toggle_effect_group_obj._rule_a.set.all then
			self._control.changepage.type_layer.bg.effect_group.toggle_group.all.toggle.isOn = self._last_toggle_effect_group_obj_rule_a.all
		end

		for iter_15_0, iter_15_1 in pairs(self._last_toggle_effect_group_obj_rule_b) do
			if iter_15_1 ~= self._toggle_effect_group_obj._rule_b.set[iter_15_0] then
				self._control.changepage.type_layer.bg.effect_group.toggle_group[iter_15_0].toggle.isOn = iter_15_1
			end
		end

		if self._last_toggle_using_group_obj_rule_a.all ~= self._toggle_using_group_obj._rule_a.set.all then
			self._control.changepage.type_layer.bg.using_group.toggle_group.all.toggle.isOn = self._last_toggle_using_group_obj_rule_a.all
		end

		for iter_15_2, iter_15_3 in pairs(self._last_toggle_using_group_obj_rule_b) do
			if iter_15_3 ~= self._toggle_using_group_obj._rule_b.set[iter_15_2] then
				self._control.changepage.type_layer.bg.using_group.toggle_group[iter_15_2].toggle.isOn = iter_15_3
			end
		end
	end

	function arg_1_0:__save_toggle_group_all_set_data()
		self._last_toggle_effect_group_obj_rule_a = var_0_4.little_clone(self._toggle_effect_group_obj._rule_a.set)
		self._last_toggle_effect_group_obj_rule_b = var_0_4.little_clone(self._toggle_effect_group_obj._rule_b.set)
		self._last_toggle_using_group_obj_rule_a = var_0_4.little_clone(self._toggle_using_group_obj._rule_a.set)
		self._last_toggle_using_group_obj_rule_b = var_0_4.little_clone(self._toggle_using_group_obj._rule_b.set)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_all(arg_17_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_all()
		self._toggle_effect_group_obj:toggleOn("all", self._toggle_effect_group.all.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_shell_effect(arg_19_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_shell_effect()
		self._toggle_effect_group_obj:toggleOn("shell_effect", self._toggle_effect_group.shell_effect.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_live(arg_21_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_live()
		self._toggle_effect_group_obj:toggleOn("live", self._toggle_effect_group.live.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_sp_music(arg_23_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_sp_music()
		self._toggle_effect_group_obj:toggleOn("sp_music", self._toggle_effect_group.sp_music.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_sp_dialogue(arg_25_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_sp_dialogue()
		self._toggle_effect_group_obj:toggleOn("sp_dialogue", self._toggle_effect_group.sp_dialogue.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_sp_menu(arg_27_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_sp_menu()
		self._toggle_effect_group_obj:toggleOn("sp_menu", self._toggle_effect_group.sp_menu.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_airplane(arg_29_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_airplane()
		self._toggle_effect_group_obj:toggleOn("airplane", self._toggle_effect_group.airplane.toggle.isOn)
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_effect_group_toggle_group_voice(arg_31_0)
		return
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_effect_group_toggle_group_voice()
		self._toggle_effect_group_obj:toggleOn("voice", self._toggle_effect_group.voice.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_using_group_toggle_group_all()
		self._toggle_using_group_obj:toggleOnOnly("all", self._toggle_using_group.all.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_using_group_toggle_group_bought()
		self._toggle_using_group_obj:toggleOnOnly("bought", self._toggle_using_group.bought.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_using_group_toggle_group_not_bought()
		self._toggle_using_group_obj:toggleOnOnly("not_bought", self._toggle_using_group.not_bought.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_using_group_toggle_group_using()
		self._toggle_using_group_obj:toggleOnOnly("using", self._toggle_using_group.using.toggle.isOn)
	end

	function arg_1_0:__onToggle_all_do_changepage_type_layer_bg_using_group_toggle_group_not_using()
		self._toggle_using_group_obj:toggleOnOnly("not_using", self._toggle_using_group.not_using.toggle.isOn)
	end

	function arg_1_0.__onClick_top_layer_search_btn(arg_38_0)
		return
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_using_group_toggle_group_all(arg_39_0)
		return
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_using_group_toggle_group_bought(arg_40_0)
		return
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_using_group_toggle_group_not_bought(arg_41_0)
		return
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_using_group_toggle_group_using(arg_42_0)
		return
	end

	function arg_1_0.__onToggle_changepage_type_layer_bg_using_group_toggle_group_not_using(arg_43_0)
		return
	end

	function arg_1_0.__onScaleButtonClick_top_layer_top_btn_btnvoucher(arg_44_0)
		local var_44_0 = var_0_2:getInstance("voucher_shop")

		if var_44_0 then
			var_44_0:show(1)
		else
			var_0_2:createInstance("voucher_shop"):show(1)
		end
	end

	function arg_1_0:__change_type_text()
		local var_45_0 = false
		local var_45_1

		if self._effect_toggle_data.all then
			var_45_1 = false
		elseif var_0_4.dict_lenght(self._effect_toggle_data) <= 2 then
			for iter_45_0, iter_45_1 in pairs(self._effect_toggle_data) do
				if iter_45_0 == "shell_effect" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_1")
				elseif iter_45_0 == "live" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_2")
				elseif iter_45_0 == "sp_music" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_3")
				elseif iter_45_0 == "sp_dialogue" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_4")
				elseif iter_45_0 == "sp_menu" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_5")
				elseif iter_45_0 == "airplane" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_6")
				elseif iter_45_0 == "voice" then
					var_45_1 = var_0_3:getNowLang("skin_effect_type_7")
				end
			end
		else
			var_45_0 = true
		end

		local var_45_2

		if var_0_4.dict_lenght(self._using_toggle_data) <= 2 then
			for iter_45_2, iter_45_3 in pairs(self._using_toggle_data) do
				if iter_45_2 == "bought" then
					var_45_2 = var_0_3:getNowLang("shoptipbuyed")
				elseif iter_45_2 == "not_bought" then
					var_45_2 = var_0_3:getNowLang("state_no_buy")
				elseif iter_45_2 == "using" then
					var_45_2 = var_0_3:getNowLang("state_use")
				elseif iter_45_2 == "not_using" then
					var_45_2 = var_0_3:getNowLang("state_no_use")
				end
			end
		elseif not self._using_toggle_data.all then
			var_45_0 = true
		end

		self._control.top_layer.type_btn.type_txt.text.text = var_45_0 and var_0_3:getNowLang("multiselect") or var_45_1 and var_45_2 and var_0_3:getNowLang("multiselect") or var_45_1 and not var_45_2 and var_45_1 or not var_45_1 and var_45_2 and var_45_2 or var_0_3:getNowLang("questall")
	end
end

function var_0_0.extend_obj(arg_46_0)
	arg_46_0._need_revert = false
	arg_46_0._last_toggle_effect_group_obj_rule_a = {}
	arg_46_0._last_toggle_effect_group_obj_rule_b = {}
	arg_46_0._last_toggle_using_group_obj_rule_a = {}
	arg_46_0._last_toggle_using_group_obj_rule_b = {}
end

return var_0_0
