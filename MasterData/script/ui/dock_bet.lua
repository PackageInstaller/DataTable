local var_0_0 = {}
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.user
local var_0_4 = string.format
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.util_func

gamecore.UILoader:define("dock_bet", function(arg_1_0)
	function arg_1_0:hide(arg_2_1)
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, false, function()
			var_0_2:destroyInstance("dock_bet")

			if arg_2_1 then
				arg_2_1()

				arg_2_1 = nil
			end
		end)
	end

	function arg_1_0:updata_res_data()
		self:__init_data()
	end

	function arg_1_0.set_select_num(arg_5_0, arg_5_1)
		arg_5_0._need_res = arg_5_1
	end

	function arg_1_0:get_guide_btn_pos_info(arg_6_1)
		if arg_6_1 == var_0_5.guide_const_id.six_group.six then
			return self._control.content.right_layer.build_btn.transform
		end
	end

	function arg_1_0:__onVisible(arg_7_1, arg_7_2)
		if not arg_7_1 then
			return
		end

		self:__init_panel(arg_7_2)

		self._user_data = var_0_3:get_use_info_data()
	end

	function arg_1_0:__init_panel(arg_8_1)
		self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.open))

		self._data = arg_8_1
		self._control.content.right_layer.log_btn:GetComponent("Button").enabled = true
		self._control.content.right_layer.fast_btn:GetComponent("Button").enabled = true

		self:__init_fixed_value()
		self:__init_title_name()
		self:__init_data()
		self:__init_roll_scroll()
		var_0_5:play_in_out_animation(self._control.bg.uITweenSequence, true)
	end

	function arg_1_0:__init_fixed_value()
		self._control.content.build_panels.single_build_panel_1.title.text.text = var_0_1:getNowLang("fuel")
		self._control.content.build_panels.single_build_panel_2.title.text.text = var_0_1:getNowLang("ammo")
		self._control.content.build_panels.single_build_panel_3.title.text.text = var_0_1:getNowLang("steel")
		self._control.content.build_panels.single_build_panel_4.title.text.text = var_0_1:getNowLang("aluminium")
		self._single_build_panel_contents = {
			self._control.content.build_panels.single_build_panel_1,
			self._control.content.build_panels.single_build_panel_2,
			self._control.content.build_panels.single_build_panel_3,
			self._control.content.build_panels.single_build_panel_4
		}

		for iter_9_0, iter_9_1 in ipairs(self._single_build_panel_contents) do
			local var_9_0, var_9_1 = self:loadUIPrefab("rollscroll", iter_9_1.scroll_root.rectTransform)

			var_9_0._panel.transform.localScale = Vector3.New(1, 1, 1)

			var_9_0:setVisible(true)

			var_9_1.select_ones_place.rectTransform.parent.anchoredPosition = Vector2.zero
			self._single_build_panel_controls[iter_9_0] = var_9_1
		end

		for iter_9_2, iter_9_3 in ipairs(self._single_build_panel_controls) do
			self:__init_scroll_end_listener(iter_9_3)
		end
	end

	function arg_1_0:__init_title_name()
		if self._data.type == var_0_5.pool_type.ship_build then
			self._control.content.right_layer.log_btn.title.text.text = var_0_1:getNowLang("logshipfactorytitle")
			self._control.content.right_layer.fast_btn.title.text.text = var_0_1:getNowLang("batchbuild")
			self._control.content.right_layer.build_btn.title.text.text = var_0_1:getNowLang("btnbuild")
			self._control.content.top_layer.tip_title.text.text = var_0_1:getNowLang("titlebuild")
			self._control.content.top_layer.tip_title.desc.desc_text.text.text = var_0_1:getNowLang("build_desc")
			self._control.content.right_layer.build_info_btn.title.text.text = var_0_1:getNowLang("build_access")
		else
			self._control.content.top_layer.tip_title.text.text = var_0_1:getNowLang("buildequiptitle")
			self._control.content.top_layer.tip_title.desc.desc_text.text.text = var_0_1:getNowLang("build_desc")
			self._control.content.right_layer.log_btn.title.text.text = var_0_1:getNowLang("logequipfactorytitle")
			self._control.content.right_layer.fast_btn.title.text.text = var_0_1:getNowLang("batchdevelopment")
			self._control.content.right_layer.build_btn.title.text.text = var_0_1:getNowLang("btndevelop")
			self._control.content.right_layer.build_info_btn.title.text.text = var_0_1:getNowLang("develop_access")
		end
	end

	function arg_1_0:__init_data()
		local var_11_0 = var_0_3:get_use_info_data()

		self._control.content.user_res_1.oil_num.text.text = var_0_6.get_simplify_num(var_11_0.oil)
		self._control.content.user_res_1.iron_num.text.text = var_0_6.get_simplify_num(var_11_0.fe)
		self._control.content.user_res_1.mineral_num.text.text = var_0_6.get_simplify_num(var_11_0.al)
		self._control.content.user_res_1.bullet_num.text.text = var_0_6.get_simplify_num(var_11_0.bullet)
		self.num_oil = var_0_6.get_simplify_num(var_11_0.oil)
		self.num_bullet = var_0_6.get_simplify_num(var_11_0.bullet)
		self.num_steel = var_0_6.get_simplify_num(var_11_0.fe)
		self.num_aluminium = var_0_6.get_simplify_num(var_11_0.al)
		self.num_blue_map = self._data.type == var_0_5.pool_type.ship_build and var_0_3:get_item_count(var_0_5.ship_item_cid.ship_blueprint) or var_0_3:get_item_count(var_0_5.ship_item_cid.equip_blueprint)

		local var_11_1 = var_0_3:get_item_count(var_0_5.ship_item_cid.ship_blueprint)
		local var_11_2 = var_0_3:get_item_count(var_0_5.ship_item_cid.fast_build)

		if self._data.type == var_0_5.pool_type.ship_build then
			self._control.content.user_res_2.item_1.icon.image.sprite = self:loadSprite(var_0_4(var_0_5.common_icon.common_source, 7))
			self._control.content.user_res_2.item_1.num.text.text = var_0_6.get_simplify_num(var_11_1)
			self._control.content.user_res_2.item_2.num.text.text = var_0_6.get_simplify_num(var_11_2)
			self._control.content.user_res_2.item_3.num.text.text = var_0_6.get_simplify_num(var_11_0.diamond)
			self._control.content.right_layer.dock_capacity.title.text.text = var_0_1:getNowLang("dockcapacity")
			self._control.content.right_layer.dock_capacity.count.text.text = var_0_6.dict_lenght(var_0_3:get_character_list()) .. "/" .. var_11_0.max_ship
		elseif self._data.type == var_0_5.pool_type.equipment_build then
			self._control.content.user_res_2.item_1.icon.image.sprite = self:loadSprite(var_0_4(var_0_5.common_icon.common_source, 8))
			self._control.content.user_res_2.item_1.num.text.text = var_0_6.get_simplify_num((var_0_3:get_item_count(var_0_5.ship_item_cid.equip_blueprint)))
			self._control.content.user_res_2.item_2.num.text.text = var_0_6.get_simplify_num(var_11_2)
			self._control.content.user_res_2.item_3.num.text.text = var_0_6.get_simplify_num(var_11_0.diamond)
			self._control.content.right_layer.dock_capacity.title.text.text = var_0_1:getNowLang("equipdockcapacity")
			self._control.content.right_layer.dock_capacity.count.text.text = var_0_3:get_equipment_count() .. "/" .. var_11_0.max_equip
		end
	end

	function arg_1_0.__init_scroll_end_listener(arg_12_0, arg_12_1)
		arg_12_1.select_ones_place.uIControlScrollFlow.onScrollEndEvent:AddListener(function()
			arg_12_0:__check_num(arg_12_1)
		end)
		arg_12_1.select_tens_place.uIControlScrollFlow.onScrollEndEvent:AddListener(function()
			arg_12_0:__check_num(arg_12_1)
		end)
		arg_12_1.select_hundreds_place.uIControlScrollFlow.onScrollEndEvent:AddListener(function()
			arg_12_0:__check_num(arg_12_1)
		end)
	end

	function arg_1_0.__get_num(arg_16_0, arg_16_1)
		return arg_16_1.select_hundreds_place.uIControlScrollFlow:GetCurrentSellectNum() * 100 + arg_16_1.select_tens_place.uIControlScrollFlow:GetCurrentSellectNum() * 10 + arg_16_1.select_ones_place.uIControlScrollFlow:GetCurrentSellectNum()
	end

	function arg_1_0:__check_num(arg_17_1)
		local var_17_0 = self:__get_num(arg_17_1)

		if self._data.type == var_0_5.pool_type.ship_build then
			if var_17_0 < 30 then
				self:__reset_roll_scroll(arg_17_1)
			end
		elseif self._data.type == var_0_5.pool_type.equipment_build then
			if var_17_0 < 10 then
				self:__reset_roll_scroll(arg_17_1)
			end

			if var_17_0 > 300 then
				arg_17_1.select_ones_place.uIControlScrollFlow:Init(0)
				arg_17_1.select_tens_place.uIControlScrollFlow:Init(0)
				arg_17_1.select_hundreds_place.uIControlScrollFlow:Init(300)
			end
		end
	end

	function arg_1_0:__reset_roll_scroll(arg_18_1)
		if self._data.type == var_0_5.pool_type.ship_build then
			arg_18_1.select_ones_place.uIControlScrollFlow:Init(30)
			arg_18_1.select_tens_place.uIControlScrollFlow:Init(30)
			arg_18_1.select_hundreds_place.uIControlScrollFlow:Init(30)
		elseif self._data.type == var_0_5.pool_type.equipment_build then
			arg_18_1.select_ones_place.uIControlScrollFlow:Init(10)
			arg_18_1.select_tens_place.uIControlScrollFlow:Init(10)
			arg_18_1.select_hundreds_place.uIControlScrollFlow:Init(10)
		end
	end

	function arg_1_0:__set_build_config()
		for iter_19_0, iter_19_1 in ipairs(self._single_build_panel_controls) do
			self._build_config_data[iter_19_0] = self:__get_num(iter_19_1)
		end
	end

	function arg_1_0:__init_roll_scroll()
		self._previous_dock_data = var_0_3:get_previous_dock_data()

		local var_20_0

		self._item_pre = self._item_pre or self:createGameObject(var_0_5.dock_item_pre)

		if self._data.type == var_0_5.pool_type.ship_build then
			for iter_20_0, iter_20_1 in ipairs(self._single_build_panel_controls) do
				if iter_20_0 == 1 then
					var_20_0 = "oil"
				elseif iter_20_0 == 2 then
					var_20_0 = "bullet"
				elseif iter_20_0 == 3 then
					var_20_0 = "fe"
				elseif iter_20_0 == 4 then
					var_20_0 = "al"
				end

				local var_20_2 = self._previous_dock_data.ship_build_pool[var_20_0]

				iter_20_1.select_ones_place.uIControlScrollFlow.ItemPre = self._item_pre
				iter_20_1.select_tens_place.uIControlScrollFlow.ItemPre = self._item_pre
				iter_20_1.select_hundreds_place.uIControlScrollFlow.ItemPre = self._item_pre

				if var_20_2 then
					iter_20_1.select_ones_place.uIControlScrollFlow:Init(var_20_2)
					iter_20_1.select_tens_place.uIControlScrollFlow:Init(var_20_2)
					iter_20_1.select_hundreds_place.uIControlScrollFlow:Init(var_20_2)
				end
			end
		elseif self._data.type == var_0_5.pool_type.equipment_build then
			for iter_20_2, iter_20_3 in ipairs(self._single_build_panel_controls) do
				if iter_20_2 == 1 then
					var_20_0 = "oil"
				elseif iter_20_2 == 2 then
					var_20_0 = "bullet"
				elseif iter_20_2 == 3 then
					var_20_0 = "fe"
				elseif iter_20_2 == 4 then
					var_20_0 = "al"
				end

				local var_20_3 = self._previous_dock_data.equipment_build_pool[var_20_0]

				iter_20_3.select_ones_place.uIControlScrollFlow.ItemPre = self._item_pre
				iter_20_3.select_tens_place.uIControlScrollFlow.ItemPre = self._item_pre
				iter_20_3.select_hundreds_place.uIControlScrollFlow.ItemPre = self._item_pre

				if var_20_3 then
					iter_20_3.select_ones_place.uIControlScrollFlow:Init(var_20_3)
					iter_20_3.select_tens_place.uIControlScrollFlow:Init(var_20_3)
					iter_20_3.select_hundreds_place.uIControlScrollFlow:Init(var_20_3)
				end
			end
		end

		self._item_pre.transform:SetParent(self._control.content.transform, false)
		self._item_pre:SetActive(false)
	end

	function arg_1_0:set_roll_scroll(arg_21_1)
		if self._data.type == var_0_5.pool_type.ship_build then
			for iter_21_0, iter_21_1 in ipairs(self._single_build_panel_controls) do
				iter_21_1.select_ones_place.uIControlScrollFlow:Init(arg_21_1[iter_21_0])
				iter_21_1.select_tens_place.uIControlScrollFlow:Init(arg_21_1[iter_21_0])
				iter_21_1.select_hundreds_place.uIControlScrollFlow:Init(arg_21_1[iter_21_0])
			end
		elseif self._data.type == var_0_5.pool_type.equipment_build then
			for iter_21_2, iter_21_3 in ipairs(self._single_build_panel_controls) do
				iter_21_3.select_ones_place.uIControlScrollFlow:Init(arg_21_1[iter_21_2])
				iter_21_3.select_tens_place.uIControlScrollFlow:Init(arg_21_1[iter_21_2])
				iter_21_3.select_hundreds_place.uIControlScrollFlow:Init(arg_21_1[iter_21_2])
			end
		end
	end

	function arg_1_0:_play_into_se(arg_22_1)
		self:playSE(arg_22_1, false)
	end

	function arg_1_0:__onReset()
		for iter_23_0, iter_23_1 in ipairs(self._single_build_panel_controls) do
			iter_23_1.select_ones_place.uIControlScrollFlow:Destroy()
			iter_23_1.select_tens_place.uIControlScrollFlow:Destroy()
			iter_23_1.select_hundreds_place.uIControlScrollFlow:Destroy()
		end

		self:destroyChildren("rollscroll")

		self._single_build_panel_controls = {}

		if self._item_pre then
			self:destroyGameObject(self._item_pre)

			self._item_pre = nil
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_2:class("dock_bet")

	var_24_0._already_init = false
	var_24_0._data = {}
	var_24_0._need_res = {}
	var_24_0._single_build_panel_contents = {}
	var_24_0._single_build_panel_controls = {}
	var_24_0._build_config_data = {}
	var_24_0.num_oil = nil
	var_24_0.num_bullet = nil
	var_24_0.num_steel = nil
	var_24_0.num_aluminium = nil
	var_24_0.num_fast_build = nil
	var_24_0.num_blue_map = nil
	var_24_0._user_data = nil
	var_24_0._previous_dock_data = nil
	var_24_0._item_pre = nil

	return var_24_0
end

return var_0_0
