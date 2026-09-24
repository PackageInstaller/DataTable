local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.bathhouse_config
local var_0_6 = table.sort
local var_0_7 = table.insert
local var_0_8 = gameconfig.shop_config
local var_0_9

gamecore.UILoader:define("bathroom_change_style", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.open))
		self:setVisible(true)

		local var_2_0 = var_0_2:getInstance("bathroom")

		if var_2_0 then
			var_2_0._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder - 1
			self._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 1
		end

		self:__init_panel()
		self:_set_stop_bathroom_mouse()
	end

	function arg_1_0:_set_stop_bathroom_mouse()
		self._open_bathroom_rubdown = var_0_2:getInstance("bathroom")

		if self._open_bathroom_rubdown then
			self._open_bathroom_rubdown._allow_mouse_move = false
			self._open_bathroom_rubdown._room_end_pos = nil
			self._open_bathroom_rubdown._room_start_pos = nil
		end
	end

	function arg_1_0.__can_change(arg_4_0)
		local var_4_0 = true
		local var_4_1 = var_0_2:getInstance("bathroom")

		for iter_4_0, iter_4_1 in pairs((var_0_3:get_dock_group(var_0_4.pool_type.repair))) do
			if iter_4_1.available and iter_4_1.state ~= var_0_4.pool_state.free then
				var_4_0 = false

				break
			end
		end

		return var_4_0
	end

	function arg_1_0:__show_style_by_index(arg_5_1)
		self._control.bg.style_switch.style_0_btn.toggle.isOn = arg_5_1 == 1
		self._control.bg.style_switch.style_1_btn.toggle.isOn = arg_5_1 == 2
		self._control.bg.style_switch.style_2_btn.toggle.isOn = arg_5_1 == 3

		if self._style_data[arg_5_1] then
			self._now_click_style_id = self._style_data[arg_5_1].id or 174
		end

		self._control.bg.buy_btn:SetActive(not self._style_data[arg_5_1].is_have)
		self._control.bg.use_btn:SetActive(self._style_data[arg_5_1].is_have)

		self._control.bg.mp_tips.text.text = self._style_config[arg_5_1].desc
	end

	function arg_1_0:change_style_resp()
		self._open_bathroom_rubdown._allow_mouse_move = true

		self:__show_style_layer(false)
	end

	function arg_1_0:__click_buy_btn_event()
		var_0_3:set_bathroom_buy_type(var_0_4.bathroom_buy_type.style)

		local var_7_0 = var_0_2:createInstance("shop_bounced")

		if self._now_click_toggle_index == 2 then
			var_7_0:show(var_0_8.find_object_by_id(31))
		elseif self._now_click_toggle_index == 3 then
			var_7_0:show(var_0_8.find_object_by_id(32))
		end
	end

	function arg_1_0:__buy_resp()
		self:__init_style_data()
	end

	function arg_1_0.__show_style_layer(arg_9_0, arg_9_1)
		var_0_4:play_in_out_animation(var_0_9, arg_9_1, function()
			if not arg_9_1 then
				arg_9_0._control.bg:SetActive(false)
				arg_9_0:setVisible(false)
			end
		end)
	end

	function arg_1_0:__init_style_data()
		local var_11_0 = var_0_3:get_bathroom_style()

		self._style_data = {}

		for iter_11_0, iter_11_1 in ipairs(self._style_config) do
			local var_11_1 = false

			for iter_11_2, iter_11_3 in ipairs(var_11_0) do
				if iter_11_3 == iter_11_1.id then
					var_11_1 = true

					break
				end
			end

			var_0_7(self._style_data, {
				id = iter_11_1.id,
				is_have = var_11_1
			})
		end

		local var_11_2 = var_0_2:getInstance("bathroom")

		var_11_2._control.expantion_layer.expantion_count_txt.text.text = var_11_2:__get_basket_count() .. "/" .. #var_0_3:get_bathroom_style() * 4

		var_11_2:_updata_now_info()
		var_11_2:_initialize_change_room()
		var_11_2:_now_style_num_show()

		self._now_click_toggle_index = self._now_click_toggle_index or 1

		for iter_11_4, iter_11_5 in pairs(var_0_4.bathroom_style_k) do
			if var_11_2._now_all_style_list[var_11_2._now_room_num] == iter_11_5 then
				self._now_click_toggle_index = iter_11_4
			end
		end

		self:__show_style_by_index(self._now_click_toggle_index)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_config()
		end

		self._user_data = var_0_3:get_use_info_data()

		self:__show_style_layer(true)
		self:__init_style_data()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.bg.bg_container.title_node.title.text.text = var_0_1:getNowLang("changestyle")
		self._control.bg.use_btn.use.text.text = var_0_1:getNowLang("use")
		self._control.bg.styleselect.text.text = var_0_1:getNowLang("styleselect")
		self._control.bg.buy_btn.shopitemtitle.text.text = var_0_1:getNowLang("shopitemtitle")
		self._control.bg.style_switch.style_0_btn.bg_unselected.styledesc0.text.text = var_0_1:getNowLang("ui_bathroom_title1")
		self._control.bg.style_switch.style_0_btn.bg.styledesc0_selected.text.text = var_0_1:getNowLang("ui_bathroom_title1")
		self._control.bg.style_switch.style_1_btn.bg_unselected.captainstyle2.text.text = var_0_1:getNowLang("ui_bathroom_title2")
		self._control.bg.style_switch.style_1_btn.bg.captainstyle2_selected.text.text = var_0_1:getNowLang("ui_bathroom_title2")
		self._control.bg.style_switch.style_2_btn.bg_unselected.captainstyle3.text.text = var_0_1:getNowLang("ui_bathroom_title3")
		self._control.bg.style_switch.style_2_btn.bg.captainstyle3_selected.text.text = var_0_1:getNowLang("ui_bathroom_title3")
	end

	function arg_1_0:__init_constant()
		var_0_9 = self._control.bg.uITweenSequence
	end

	function arg_1_0:__init_config()
		self._style_config = var_0_5.get_sequence()

		var_0_6(self._style_config, function(arg_16_0, arg_16_1)
			return arg_16_0.id < arg_16_1.id
		end)
	end

	function arg_1_0:_play_into_se(arg_17_1)
		self:playSE(arg_17_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_2:class("bathroom_change_style")

	var_18_0._is_already_init = false
	var_18_0._user_data = {}
	var_18_0._style_config = {}
	var_18_0._style_data = {}
	var_18_0._now_click_style_id = nil
	var_18_0._now_click_toggle_index = 1

	gamecore.extend_obj(var_18_0)

	return var_18_0
end

return var_0_0
