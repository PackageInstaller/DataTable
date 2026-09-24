local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = string.len
local var_0_4 = string.sub
local var_0_5 = gamecore.prompt
local var_0_6 = string.find
local var_0_7 = table.insert
local var_0_8 = table.remove
local var_0_9 = gamecore.Language
local var_0_10 = gamecore.UILoader
local var_0_11 = UnityEngine.Vector3
local var_0_12 = string.format
local var_0_13 = gamecore.util_func
local var_0_15 = gamecore.PayManager
local var_0_17 = gameenum.common_type
local var_0_18 = gameconfig.shop_config
local var_0_19 = gameconfig.skin_config
local var_0_20 = gameconfig.ship_config
local var_0_21 = gamecore.AuditServerManager
local var_0_22 = gameenum.config_data

gamecore.UILoader:define("mall_shop", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:setVisible(true)

		self._layer_type = arg_2_1
		self._enter_type = arg_2_2

		self:__init_config_data()
		self:update_data()
		self:__init_panel()
		self:update_user_res_data(false)

		self._from_marry_data = arg_2_3 or nil
		self._is_from_marry = arg_2_4 or nil
	end

	function arg_1_0:play_in_out_animation(arg_3_1, arg_3_2, arg_3_3)
		arg_3_3 = arg_3_3 or self._control.bg.uITweenSequence

		if arg_3_1 then
			arg_3_3:Play(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		else
			arg_3_3:PlayReverse(function()
				if arg_3_2 then
					arg_3_2()
				end
			end)
		end
	end

	function arg_1_0:update_data()
		self._data = var_0_1:get_mall_total_info()

		if self._now_label_index ~= 0 and self._now_label_index ~= 5 then
			self:__update_cell(true)
			var_0_5:show(var_0_9:getNowLang("shopbuysuccess"))
		end

		if self._now_label_index == 5 then
			self:__init_updata_change_clothes_data()
			self:__update_skin_cell()
			self:__update_change_clothes_data()
		end
	end

	function arg_1_0:__onUpdate()
		if self._now_label_index == var_0_17.mall_layer_type.layer_item and self._reusable_cell_2 then
			self._reusable_cell_2:update()
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_func and self._reusable_cell_3 then
			self._reusable_cell_3:update()
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_other and self._reusable_cell_4 then
			self._reusable_cell_4:update()
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_skin and self._reusable_cell_5 then
			self._reusable_cell_5:update()
		end
	end

	function arg_1_0:update_user_res_data(arg_8_1)
		local var_8_0 = var_0_1:get_use_info_data()
		local var_8_1 = self._control.top_layer.user_res
		local var_8_2 = var_0_13.get_simplify_num(var_8_0.oil)
		local var_8_3 = var_0_13.get_simplify_num(var_8_0.bullet)
		local var_8_4 = var_0_13.get_simplify_num(var_8_0.fe)
		local var_8_5 = var_0_13.get_simplify_num(var_8_0.al)

		if arg_8_1 then
			if tonumber(var_8_2) then
				if var_8_2 > self._orgin_oil then
					var_8_1.oil_num.fontJump:IncreaseAnim(self._orgin_oil, var_8_2)
				end
			else
				var_8_1.oil_num.text.text = var_8_2
			end

			if tonumber(var_8_3) then
				if var_8_3 > self._orgin_bullet then
					var_8_1.bullet_num.fontJump:IncreaseAnim(self._orgin_bullet, var_8_3)
				end
			else
				var_8_1.bullet_num.text.text = var_8_3
			end

			if tonumber(var_8_4) then
				if var_8_4 > self._orgin_fe then
					var_8_1.iron_num.fontJump:IncreaseAnim(self._orgin_fe, var_8_4)
				end
			else
				var_8_1.iron_num.text.text = var_8_4
			end

			if tonumber(var_8_5) then
				if var_8_5 > self._orgin_al then
					var_8_1.mineral_num.fontJump:IncreaseAnim(self._orgin_al, var_8_5)
				end
			else
				var_8_1.mineral_num.text.text = var_8_5
			end
		else
			var_8_1.oil_num.text.text = var_8_2
			var_8_1.bullet_num.text.text = var_8_3
			var_8_1.iron_num.text.text = var_8_4
			var_8_1.mineral_num.text.text = var_8_5
		end

		self._control.top_layer.diamon_node.diamond_num.text.text = var_0_13.get_simplify_num(var_8_0.diamond)

		self:__record_orgin_user_data()
		self:__close_table(self._data)
	end

	function arg_1_0:__close_table(arg_9_1)
		if self._now_label_index == 1 then
			for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
				if iter_9_1.id > 1 and iter_9_1.id < 7 and iter_9_1.buy_count > 0 then
					self._diamond_item_list[iter_9_1.id - 1]._control.label:SetActive(false)
				end

				if iter_9_1.id == 8 and iter_9_1.buy_count > 0 then
					self._diamond_item_list[6]._control.label:SetActive(false)
				end
			end
		end
	end

	function arg_1_0:update_search_ship_data(arg_10_1)
		self._search_text_trans.text = arg_10_1

		if arg_10_1 == "" or not arg_10_1 then
			self._is_search = false

			self:__update_skin_cell()

			return
		end

		self._search_ship_list = {}

		if arg_10_1 == "(" then
			arg_10_1 = "%("
		end

		for iter_10_0, iter_10_1 in pairs(self._now_ship_total_data) do
			if var_0_13.name_filter_match(iter_10_1.title, arg_10_1) and iter_10_1.have_skin == 1 then
				self:get_compare_ship_name_list(iter_10_1.skins)
			end
		end

		for iter_10_2, iter_10_3 in pairs(self._change_data_list) do
			if var_0_13.name_filter_match(iter_10_3.title, arg_10_1) then
				self:get_ship_data_by_skin(iter_10_3)
			end
		end

		for iter_10_4, iter_10_5 in pairs(self._already_bought_skin) do
			local var_10_1, var_10_2 = self:__get_current_single_cell_data(iter_10_5.cid)

			if var_0_13.name_filter_match(iter_10_5.title, arg_10_1) then
				self:get_ship_data_by_skin(iter_10_5)
			elseif var_0_13.name_filter_match(var_10_1, arg_10_1) then
				self:get_ship_data_by_skin(iter_10_5)
			end
		end

		self:show_search_result()
	end

	function arg_1_0:show_search_result()
		self._is_search = true

		self:__update_skin_cell()

		self._is_search = false
	end

	function arg_1_0:get_compare_ship_name_list(arg_12_1)
		for iter_12_0, iter_12_1 in pairs(arg_12_1) do
			self:get_ship_by_skin(iter_12_1)
		end
	end

	function arg_1_0:get_ship_by_skin(arg_13_1)
		for iter_13_0, iter_13_1 in pairs(self._change_data_list) do
			if iter_13_1.cid == arg_13_1 then
				self:get_ship_data_by_skin(iter_13_1)
			end
		end
	end

	function arg_1_0:get_ship_data_by_skin(arg_14_1)
		if #self._search_ship_list == 0 then
			var_0_7(self._search_ship_list, arg_14_1)
		else
			for iter_14_0 = 1, #self._search_ship_list do
				if not self:get_ship_state(arg_14_1.cid) then
					var_0_7(self._search_ship_list, arg_14_1)
				end
			end
		end
	end

	function arg_1_0:get_ship_state(arg_15_1)
		local var_15_0 = false

		for iter_15_0, iter_15_1 in pairs(self._search_ship_list) do
			if iter_15_1.cid == arg_15_1 then
				var_15_0 = true
			end
		end

		return var_15_0
	end

	function arg_1_0.destroy_panel(arg_16_0)
		var_0_10:destroyInstance("item_info")
		var_0_10:destroyInstance("shop_bounced")
		var_0_10:destroyInstance("item_details_view")
		var_0_10:destroyInstance("change_user_layer")
		var_0_10:destroyInstance("reward_tip")
		var_0_10:destroyInstance("new_ship_or_equip")
		var_0_10:destroyInstance("ship_detail")
		var_0_10:destroyInstance("mall_shop")
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()

			self._is_already_init = true
		end

		if var_0_21:isAuditVersion() then
			self._control.top_layer.top_btn.btnfive:SetActive(false)
		end

		self:__init_select()
		self:play_in_out_animation(true)
		self:__init_filter_type_list()
		self:reset_skin_effect_select()
		self:show_skin_voucher_store(false)
	end

	function arg_1_0.__check_count(arg_18_0, arg_18_1)
		return
	end

	function arg_1_0:__init_language()
		self._top_btn = self._control.top_layer.top_btn
		self._top_btn.btnone.text.text.text = var_0_9:getNowLang("resource1")
		self._top_btn.btntwo.text.text.text = var_0_9:getNowLang("shopitem")
		self._top_btn.btnthree.text.text.text = var_0_9:getNowLang("shopfunction")
		self._top_btn.btnfour.text.text.text = var_0_9:getNowLang("to")
		self._top_btn.btnfive.text.text.text = var_0_9:getNowLang("ts")
		self._search_text_trans = self._control.top_layer.search_btn.search.inputField

		self._search_text_trans.onEndEdit:RemoveAllListeners()
		self._search_text_trans.onEndEdit:AddListener(function()
			self:update_search_ship_data(self._search_text_trans.text)
		end)

		self._diamond_item_list = {}
		self._control.top_layer.type_btn.type.text.text = var_0_9:getNowLang("type")
		self._control.top_layer.type_btn.type_txt.text.text = var_0_9:getNowLang("equip0")
		self._control.changepage.type_layer.bg.btn_series.cancel_btn.cancel.text.text = var_0_9:getNowLang("cancel")

		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.btn_series.confirm_btn.confirm_mask, var_0_9:getNowLang("confirm"))

		self._control.changepage.type_layer.bg.effect_group.toggle_group.all.Label.text.text = var_0_9:getNowLang("equip0")

		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect.title_mask, var_0_9:getNowLang("skin_effect_type_1"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.live.title_mask, var_0_9:getNowLang("skin_effect_type_2"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_music.title_mask, var_0_9:getNowLang("skin_effect_type_3"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue.title_mask, var_0_9:getNowLang("skin_effect_type_4"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu.title_mask, var_0_9:getNowLang("skin_effect_type_5"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.airplane.title_mask, var_0_9:getNowLang("skin_effect_type_6"))
		gamecore.util_func.setTextHorizonInfo(self._control.changepage.type_layer.bg.effect_group.toggle_group.voice.title_mask, var_0_9:getNowLang("skin_effect_type_7"))

		self._control.changepage.type_layer.bg.using_group.toggle_group.all.Label.text.text = var_0_9:getNowLang("equip0")
		self._control.changepage.type_layer.bg.using_group.toggle_group.bought.Label.text.text = var_0_9:getNowLang("shoptipbuyed")
		self._control.changepage.type_layer.bg.using_group.toggle_group.not_bought.Label.text.text = var_0_9:getNowLang("state_no_buy")
		self._control.changepage.type_layer.bg.using_group.toggle_group.using.Label.text.text = var_0_9:getNowLang("state_use")
		self._control.changepage.type_layer.bg.using_group.toggle_group.not_using.Label.text.text = var_0_9:getNowLang("state_no_use")
	end

	function arg_1_0:__init_config_data()
		self._diamond_data_list = {}
		self._item_data_list = {}
		self._expansion_data_list = {}
		self._other_data_list = {}
		self._change_data_list = {}
		self._already_bought_skin = {}
		self._now_ship_total_data = {}

		local var_21_0, var_21_1 = var_0_18:get_sequence()
		local var_21_2, var_21_3 = var_0_19:get_sequence()
		local var_21_4, var_21_5 = var_0_20:get_sequence()

		self._now_ship_total_data = var_21_4
		self._ship_all_skins = {}

		for iter_21_0, iter_21_1 in pairs(self._now_ship_total_data) do
			var_0_7(self._ship_all_skins, {
				skins = iter_21_1.skins,
				cid = iter_21_1.cid,
				title = iter_21_1.title
			})
		end

		for iter_21_2, iter_21_3 in pairs(var_21_0) do
			if iter_21_3.type == 1 then
				var_0_7(self._diamond_data_list, iter_21_3)
			elseif iter_21_3.type == 2 then
				if var_0_13._get_open_time(iter_21_3.start_time, iter_21_3.end_time) then
					var_0_7(self._item_data_list, iter_21_3)
				end
			elseif iter_21_3.type == 3 then
				if var_0_13._get_open_time(iter_21_3.start_time, iter_21_3.end_time) then
					var_0_7(self._expansion_data_list, iter_21_3)
				end
			elseif iter_21_3.type == 4 and var_0_13._get_open_time(iter_21_3.start_time, iter_21_3.end_time) then
				var_0_7(self._other_data_list, iter_21_3)
			end
		end

		for iter_21_4, iter_21_5 in pairs(var_21_2) do
			if iter_21_5.get_type == 1 and var_0_13._get_open_time(iter_21_5.buy_start_time, iter_21_5.buy_end_time) then
				var_0_7(self._change_data_list, iter_21_5)
			end
		end

		local var_21_6 = 0

		for iter_21_6, iter_21_7 in pairs(self._change_data_list) do
			var_21_6 = var_21_6 + 1

			for iter_21_8, iter_21_9 in pairs(self._ship_all_skins) do
				var_21_6 = var_21_6 + 1

				if self:__get_ship_by_skin(iter_21_9.skins, iter_21_7.cid) then
					self._have_ship_list[iter_21_7.cid] = iter_21_9

					break
				end
			end
		end

		self:__init_sort_data(self._diamond_data_list)
		self:__init_sort_data(self._item_data_list)
		self:__init_sort_data(self._expansion_data_list)
		self:__init_sort_data(self._other_data_list)
	end

	function arg_1_0.__init_sort_data(arg_22_0, arg_22_1)
		var_0_2(arg_22_1, function(arg_23_0, arg_23_1)
			return arg_23_0.sort < arg_23_1.sort
		end)
	end

	function arg_1_0:__init_updata_data(arg_24_1, arg_24_2)
		if #self._data == 0 then
			return
		end

		local var_24_0 = 0

		for iter_24_0, iter_24_1 in pairs(self._data) do
			if iter_24_1.id == arg_24_1 then
				var_24_0 = iter_24_1.buy_count
			end
		end

		local var_24_1 = false

		if arg_24_2 == 2 then
			for iter_24_2, iter_24_3 in pairs(self._item_data_list) do
				if iter_24_3.id == arg_24_1 and iter_24_3.limit_num ~= 0 and var_24_0 >= iter_24_3.limit_num then
					var_24_1 = true
				end
			end
		elseif arg_24_2 == 3 then
			for iter_24_4, iter_24_5 in pairs(self._expansion_data_list) do
				if iter_24_5.id == arg_24_1 and iter_24_5.limit_num ~= 0 and var_24_0 >= iter_24_5.limit_num then
					var_24_1 = true
				end
			end
		elseif arg_24_2 == 4 then
			for iter_24_6, iter_24_7 in pairs(self._other_data_list) do
				if iter_24_7.id == arg_24_1 and iter_24_7.limit_num ~= 0 and var_24_0 >= iter_24_7.limit_num then
					var_24_1 = true
				end
			end
		end

		return var_24_1
	end

	function arg_1_0:__init_updata_change_clothes_data()
		if self._now_label_index ~= 5 then
			return
		end

		self._change_skin_data = {}
		self._change_skin_data = var_0_1:get_skin_list()

		for iter_25_0, iter_25_1 in pairs(self._now_ship_total_data) do
			if self._change_skin_data[iter_25_1.cid] ~= nil then
				self:__set_now_change_data(self._change_skin_data[iter_25_1.cid])
			end
		end
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_effect_group = {
			all = self._control.changepage.type_layer.bg.effect_group.toggle_group.all,
			shell_effect = self._control.changepage.type_layer.bg.effect_group.toggle_group.shell_effect,
			live = self._control.changepage.type_layer.bg.effect_group.toggle_group.live,
			sp_music = self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_music,
			sp_dialogue = self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_dialogue,
			sp_menu = self._control.changepage.type_layer.bg.effect_group.toggle_group.sp_menu,
			airplane = self._control.changepage.type_layer.bg.effect_group.toggle_group.airplane,
			voice = self._control.changepage.type_layer.bg.effect_group.toggle_group.voice
		}
		self._toggle_effect_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"shell_effect",
			"live",
			"sp_music",
			"sp_dialogue",
			"sp_menu",
			"airplane",
			"voice"
		}, self._toggle_effect_group)
		self._toggle_using_group = {
			all = self._control.changepage.type_layer.bg.using_group.toggle_group.all,
			bought = self._control.changepage.type_layer.bg.using_group.toggle_group.bought,
			not_bought = self._control.changepage.type_layer.bg.using_group.toggle_group.not_bought,
			using = self._control.changepage.type_layer.bg.using_group.toggle_group.using,
			not_using = self._control.changepage.type_layer.bg.using_group.toggle_group.not_using
		}
		self._toggle_using_group_obj = gamecore.toggle_group:create({
			"all"
		}, {
			"bought",
			"not_bought",
			"using",
			"not_using"
		}, self._toggle_using_group)
	end

	function arg_1_0:__update_change_clothes_data()
		var_0_10:destroyInstance("reward_tip")
		var_0_10:destroyInstance("new_ship_or_equip")

		local var_27_0 = 0
		local var_27_1 = {}

		for iter_27_0, iter_27_1 in pairs(var_0_22.special_add_skin) do
			if self._now_need_show_ship_id == iter_27_0 then
				table.insert(var_27_1, iter_27_1)

				var_27_0 = 2
			end
		end

		if self._now_need_show_ship_id > 0 then
			local var_27_2 = var_0_10:getInstance("reward_tip")

			if var_27_2 then
				var_27_2._back_func = nil
			else
				var_27_2 = var_0_10:createInstance("reward_tip")
			end

			if var_27_0 == 2 then
				var_27_2:show_by_enter_type(self._now_need_show_ship_id, var_0_17.enter_get_ship_type.mall_shop, function()
					var_27_2:show(var_27_1[1], var_0_17.enter_get_ship_type.mall_shop)
					var_27_2:clear__now_skin_data(2)
				end)
			else
				var_27_2:clear__now_skin_data(1, nil)
				var_27_2:show(self._now_need_show_ship_id, var_0_17.enter_get_ship_type.mall_shop)
			end
		end
	end

	function arg_1_0:__set_now_change_data(arg_29_1)
		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			local var_29_0 = 0

			for iter_29_2, iter_29_3 in pairs(self._change_data_list) do
				iter_29_3.bought = false

				if iter_29_3.cid == iter_29_1 then
					var_29_0 = iter_29_2
				end
			end

			if var_29_0 > 0 then
				self._now_need_show_ship_id = iter_29_1

				var_0_7(self._already_bought_skin, self._change_data_list[var_29_0])
				var_0_8(self._change_data_list, var_29_0)
			end
		end
	end

	function arg_1_0:__get_current_single_cell_data(arg_30_1)
		local var_30_0
		local var_30_2

		if self._have_ship_list[arg_30_1] then
			var_30_2 = self._have_ship_list[arg_30_1].cid
			var_30_0 = self._have_ship_list[arg_30_1].title
		end

		return var_30_0, (self:__judge_ship_data(var_30_2))
	end

	function arg_1_0.__get_ship_by_skin(arg_31_0, arg_31_1, arg_31_2)
		if arg_31_1 then
			for iter_31_0, iter_31_1 in pairs(arg_31_1) do
				if iter_31_1 == arg_31_2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0.__judge_ship_data(arg_32_0, arg_32_1)
		for iter_32_0, iter_32_1 in pairs((var_0_1:get_cardbook_ship_list())) do
			if iter_32_1.id == arg_32_1 then
				return false
			end
		end

		return true
	end

	function arg_1_0:__init_select()
		if self._now_content then
			self._now_content.toggle.isOn = false
		end

		self:__select_one(self._layer_type, true)

		self._now_content.toggle.isOn = true
	end

	function arg_1_0:__select_one(arg_34_1, arg_34_2)
		self._select_index_type_num = arg_34_1

		if self._now_label == arg_34_1 and not arg_34_2 then
			return
		end

		self._now_label = arg_34_1

		self._control.top_layer.search_btn:SetActive(self._now_label == var_0_17.mall_layer_type.layer_skin)

		self._search_text_trans.text = ""

		if self._now_content then
			self._last_content = self._now_content

			self:__set_title_style(self._now_content, false)
		end

		self:__set_current_content(arg_34_1)
		self:__set_title_style(self._now_content, true)

		if self._last_content then
			self:play_in_out_animation(false, function()
				self:play_in_out_animation(true, nil, self._now_content.uITweenSequence)
			end, self._last_content.uITweenSequence)
		else
			self:play_in_out_animation(true, nil, self._now_content.uITweenSequence)
		end
	end

	function arg_1_0:__set_current_content(arg_36_1)
		if arg_36_1 == var_0_17.mall_layer_type.layer_diamond then
			self._now_content = self._top_btn.btnone
			self._now_label_index = var_0_17.mall_layer_type.layer_diamond
		elseif arg_36_1 == var_0_17.mall_layer_type.layer_item then
			self._now_content = self._top_btn.btntwo
			self._now_label_index = var_0_17.mall_layer_type.layer_item
		elseif arg_36_1 == var_0_17.mall_layer_type.layer_func then
			self._now_content = self._top_btn.btnthree
			self._now_label_index = var_0_17.mall_layer_type.layer_func
		elseif arg_36_1 == var_0_17.mall_layer_type.layer_other then
			self._now_content = self._top_btn.btnfour
			self._now_label_index = var_0_17.mall_layer_type.layer_other
		elseif arg_36_1 == var_0_17.mall_layer_type.layer_skin then
			self._now_content = self._top_btn.btnfive
			self._now_label_index = var_0_17.mall_layer_type.layer_skin
		end

		self:__init_mall_list()
		self:__update_cell()
		self:__init_updata_change_clothes_data()
		self:__update_skin_cell()
		self:__update_now_content_position(arg_36_1)
	end

	function arg_1_0:__set_title_style(arg_37_1, arg_37_2)
		local var_37_0 = arg_37_1.text.text
		local var_37_1 = arg_37_1 == self._top_btn.btnone

		if arg_37_2 then
			var_37_0.fontSize = var_0_17.shop_const.font_max_size
			var_37_0.color = Color.New(1, 1, 1)

			if var_37_1 then
				gamecore.util_func.setTextFontSize(arg_37_1.title_mask, var_0_17.shop_const.font_max_size, true)
				gamecore.util_func.setTextColor(arg_37_1.title_mask, Color.New(1, 1, 1))
			end
		else
			var_37_0.fontSize = var_0_17.shop_const.font_min_size
			var_37_0.color = Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373)

			if var_37_1 then
				gamecore.util_func.setTextFontSize(arg_37_1.title_mask, var_0_17.shop_const.font_min_size, true)
				gamecore.util_func.setTextColor(arg_37_1.title_mask, Color.New(0.5490196078431373, 0.5490196078431373, 0.5490196078431373))
			end
		end
	end

	function arg_1_0:__get_cell_by_now_lable()
		local var_38_0
		local var_38_1

		if self._now_label_index == var_0_17.mall_layer_type.layer_item then
			var_38_0 = self._reusable_cell_2
			var_38_1 = self._item_data_list
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_func then
			var_38_0 = self._reusable_cell_3
			var_38_1 = self._expansion_data_list
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_other then
			var_38_0 = self._reusable_cell_4
			var_38_1 = self._other_data_list
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_skin then
			var_38_0 = self._reusable_cell_5

			if self._is_search then
				self:__sort_skin_by_skin_id_ascend(self._search_ship_list)

				var_38_1 = self._search_ship_list
			else
				var_38_1 = self:__get_all_skin_data(self._change_data_list, self._already_bought_skin)
			end
		end

		return var_38_0, var_38_1
	end

	function arg_1_0:__get_all_skin_data(arg_39_1, arg_39_2)
		local var_39_0 = {}
		local var_39_1 = {}

		for iter_39_0, iter_39_1 in pairs(arg_39_1) do
			if iter_39_1.is_new then
				var_0_7(var_39_0, iter_39_1)
			elseif iter_39_1.is_sale and var_0_13._get_open_time(iter_39_1.sale_start_time, iter_39_1.sale_end_time) then
				var_0_7(var_39_1, iter_39_1)
			end
		end

		for iter_39_2, iter_39_3 in pairs(arg_39_2) do
			iter_39_3.bought = true
		end

		self:__sort_skin_by_skin_id_descend(var_39_0)

		self._new_skin_list = lx.clone_table(var_39_0)

		self:__sort_skin_by_skin_id_descend(var_39_1)

		self._discount_skin_list = lx.clone_table(var_39_1)

		local var_39_2, var_39_3 = self:__get_cur_have_skin(arg_39_1)

		self._cur_have_skin_list = lx.clone_table(var_39_2)
		self._not_have_skin_list = lx.clone_table(var_39_3)

		self:__sort_skin_by_skin_id_descend(self._already_bought_skin)

		return (self:__get_sort_all_skin_list_info(var_39_0, var_39_1, var_39_2, var_39_3))
	end

	function arg_1_0:__get_sort_all_skin_list_info(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		local var_40_0 = {}

		for iter_40_0, iter_40_1 in pairs(arg_40_1) do
			var_0_7(var_40_0, iter_40_1)
		end

		for iter_40_2, iter_40_3 in pairs(arg_40_2) do
			var_0_7(var_40_0, iter_40_3)
		end

		for iter_40_4, iter_40_5 in pairs(arg_40_3) do
			var_0_7(var_40_0, iter_40_5)
		end

		for iter_40_6, iter_40_7 in pairs(arg_40_4) do
			var_0_7(var_40_0, iter_40_7)
		end

		for iter_40_8, iter_40_9 in pairs(self._already_bought_skin) do
			var_0_7(var_40_0, iter_40_9)
		end

		return var_40_0
	end

	function arg_1_0.__get_sort_all_skin_list_info_not_bought(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4)
		local var_41_0 = {}

		for iter_41_0, iter_41_1 in pairs(arg_41_1) do
			var_0_7(var_41_0, iter_41_1)
		end

		for iter_41_2, iter_41_3 in pairs(arg_41_2) do
			var_0_7(var_41_0, iter_41_3)
		end

		for iter_41_4, iter_41_5 in pairs(arg_41_3) do
			var_0_7(var_41_0, iter_41_5)
		end

		for iter_41_6, iter_41_7 in pairs(arg_41_4) do
			var_0_7(var_41_0, iter_41_7)
		end

		return var_41_0
	end

	function arg_1_0:__get_cur_have_skin(arg_42_1)
		local var_42_0 = {}
		local var_42_1 = {}

		for iter_42_0, iter_42_1 in pairs(arg_42_1) do
			local var_42_2, var_42_3 = self:__get_current_single_cell_data(iter_42_1.cid)

			if not iter_42_1.is_new then
				if iter_42_1.is_sale then
					if not var_0_13._get_open_time(iter_42_1.sale_start_time, iter_42_1.sale_end_time) then
						if not var_42_3 then
							var_0_7(var_42_0, iter_42_1)
						else
							var_0_7(var_42_1, iter_42_1)
						end
					end
				elseif not var_42_3 then
					var_0_7(var_42_0, iter_42_1)
				else
					var_0_7(var_42_1, iter_42_1)
				end
			end
		end

		self:__sort_skin_by_skin_id_descend(var_42_0)
		self:__sort_skin_by_skin_id_descend(var_42_1)

		return var_42_0, var_42_1
	end

	function arg_1_0.__sort_skin_by_skin_id_descend(arg_43_0, arg_43_1)
		var_0_2(arg_43_1, function(arg_44_0, arg_44_1)
			local var_44_0 = arg_43_0:__get_sub_former_info(arg_44_0.skin_id)
			local var_44_1 = arg_43_0:__get_sub_former_info(arg_44_1.skin_id)

			if var_44_0 == var_44_1 then
				return tonumber((arg_43_0:__get_sub_later_info(arg_44_0.skin_id))) > tonumber((arg_43_0:__get_sub_later_info(arg_44_1.skin_id)))
			else
				return tonumber(var_44_0) > tonumber(var_44_1)
			end
		end)
	end

	function arg_1_0.__sort_skin_by_skin_id_ascend(arg_45_0, arg_45_1)
		var_0_2(arg_45_1, function(arg_46_0, arg_46_1)
			local var_46_0 = arg_45_0:__get_sub_former_info(arg_46_0.skin_id)
			local var_46_1 = arg_45_0:__get_sub_former_info(arg_46_1.skin_id)

			if var_46_0 == var_46_1 then
				return tonumber((arg_45_0:__get_sub_later_info(arg_46_0.skin_id))) < tonumber((arg_45_0:__get_sub_later_info(arg_46_1.skin_id)))
			else
				return tonumber(var_46_0) < tonumber(var_46_1)
			end
		end)
	end

	function arg_1_0.__get_sub_former_info(arg_47_0, arg_47_1)
		local var_47_0 = var_0_3(arg_47_1)

		return (var_0_4(arg_47_1, 1, var_47_0 - (var_47_0 - var_0_6(arg_47_1, "_") + 1)))
	end

	function arg_1_0.__get_sub_later_info(arg_48_0, arg_48_1)
		return (var_0_4(arg_48_1, var_0_6(arg_48_1, "_") + 1, (var_0_3(arg_48_1))))
	end

	function arg_1_0:__update_now_content_position(arg_49_1)
		if arg_49_1 == var_0_17.mall_layer_type.layer_item then
			self._control.itempage.scrollview.viewport.content.transform.localPosition = var_0_11(self._control.itempage.scrollview.viewport.content.transform.localPosition.x, 0, 0)
		elseif arg_49_1 == var_0_17.mall_layer_type.layer_func then
			self._control.functionpage.scrollview.viewport.content.transform.localPosition = var_0_11(self._control.functionpage.scrollview.viewport.content.transform.localPosition.x, 0, 0)
		elseif arg_49_1 == var_0_17.mall_layer_type.layer_other then
			self._control.otherpage.scrollview.viewport.content.transform.localPosition = var_0_11(self._control.otherpage.scrollview.viewport.content.transform.localPosition.x, 0, 0)
		elseif arg_49_1 == var_0_17.mall_layer_type.layer_skin then
			self._control.changepage.scrollview.viewport.content.transform.localPosition = var_0_11(self._control.changepage.scrollview.viewport.content.transform.localPosition.x, 0, 0)
		end
	end

	function arg_1_0:__init_mall_list()
		if self._already_init[self._now_label_index] == var_0_17.mall_layer_type.layer_diamond then
			return
		end

		if self._now_label_index == var_0_17.mall_layer_type.layer_diamond then
			self:__init_mall_diamond_list()
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_item then
			if not self._reusable_cell_2 then
				self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.itempage.scrollview.viewport.content.endlessScrollView, self._control.itempage.scrollview.viewport.content, "single_mall_item", "mall_shop")

				self._reusable_cell_2:init()
			end
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_func then
			if not self._reusable_cell_3 then
				self._reusable_cell_3 = gamecore.reusable_cell:create(self, self._control.functionpage.scrollview.viewport.content.endlessScrollView, self._control.functionpage.scrollview.viewport.content, "single_mall_item", "mall_shop")

				self._reusable_cell_3:init()
			end
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_other then
			if not self._reusable_cell_4 then
				self._reusable_cell_4 = gamecore.reusable_cell:create(self, self._control.otherpage.scrollview.viewport.content.endlessScrollView, self._control.otherpage.scrollview.viewport.content, "single_mall_item", "mall_shop")

				self._reusable_cell_4:init()
			end
		elseif self._now_label_index == var_0_17.mall_layer_type.layer_skin then
			if not self._reusable_cell_5 then
				self._reusable_cell_5 = gamecore.reusable_cell:create(self, self._control.changepage.scrollview.viewport.content.endlessScrollView, self._control.changepage.scrollview.viewport.content, "single_skin_item", "mall_shop")

				self._reusable_cell_5:init()
			end
		end

		self._already_init[self._now_label_index] = var_0_17.mall_layer_type.layer_diamond
	end

	function arg_1_0:__update_cell(arg_51_1)
		if self._now_label_index == var_0_17.mall_layer_type.layer_diamond or self._now_label_index == var_0_17.mall_layer_type.layer_skin then
			return
		end

		local var_51_0, var_51_1 = self:__get_cell_by_now_lable()

		self:__set_sliding_area_state(self._now_label_index, var_51_1)
		var_51_0:set_data(var_51_1, arg_51_1)

		function var_51_0._set_func(arg_52_0, arg_52_1)
			self:set_cell(arg_52_0, var_51_1[arg_52_1 + 1])
		end
	end

	function arg_1_0:set_cell(arg_53_1, arg_53_2)
		if arg_53_2.price_type == 2 then
			arg_53_1.pricebtn.priceimg:SetActive(false)
			arg_53_1.pricebtn.tokenimg:SetActive(false)
			arg_53_1.pricebtn.pricenumber:SetActive(false)
			arg_53_1.pricebtn.pricenum:SetActive(true)
		else
			arg_53_1.pricebtn.priceimg:SetActive(true)
			arg_53_1.pricebtn.pricenumber:SetActive(true)
			arg_53_1.pricebtn.tokenimg:SetActive(false)
			arg_53_1.pricebtn.pricenum:SetActive(false)
		end

		arg_53_1._data = arg_53_2 or nil

		arg_53_1.bg_lock:SetActive(false)

		arg_53_1.equipimg.img.image.sprite = self:loadSprite(var_0_12(var_0_17.shop_item_bg, arg_53_2.icon))
		arg_53_1.pricebtn.priceimg.image.sprite = self:loadSprite(var_0_17.shop_buy_diamond_bg)
		arg_53_1.name_mask.equipname.text.text = arg_53_2.title

		arg_53_1.name_mask:GetComponent("TextHorizonScroller"):SetText(arg_53_2.title)

		arg_53_1.pricebtn.pricenumber.text.text = arg_53_2.price
		arg_53_1.pricebtn.pricenum.text.text = "¥" .. arg_53_2.price

		arg_53_1.equipimg.event_tip:SetActive(arg_53_2.is_gift)

		local var_53_0 = self:__init_updata_data(arg_53_2.id, arg_53_2.type)

		arg_53_1.pricebtn:SetActive(not var_53_0)

		arg_53_1.numberof.text.text = var_53_0 and var_0_9:getNowLang("buyitemlimttop") or arg_53_2.brief

		local var_53_2 = var_0_1:get_use_info_data()
		local var_53_3 = var_0_1:get_mall_total_info()

		if arg_53_2.id == var_0_17.shop_item_id.month_card then
			local var_53_4, var_53_5 = var_0_13._get_interval_time_format(var_53_2.month_card_time)

			if var_53_4 then
				arg_53_1.numberof.text.text = arg_53_2.brief or var_53_5
			end
		end

		if not var_53_0 then
			if arg_53_2.id == 26 then
				arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_53_2.max_ship
			elseif arg_53_2.id == 24 then
				local var_53_6 = 0

				for iter_53_0, iter_53_1 in pairs(var_53_3) do
					if arg_53_2.id == iter_53_1.id then
						var_53_6 = iter_53_1.buy_count
					end
				end

				arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_53_6 + 2
			elseif arg_53_2.id == 25 then
				local var_53_7 = 0

				for iter_53_2, iter_53_3 in pairs(var_53_3) do
					if arg_53_2.id == iter_53_3.id then
						var_53_7 = iter_53_3.buy_count
					end
				end

				arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_53_7 + 2
			elseif arg_53_2.id == 23 then
				local var_53_8 = 0

				for iter_53_4, iter_53_5 in pairs(var_53_3) do
					if arg_53_2.id == iter_53_5.id then
						var_53_8 = iter_53_5.buy_count
					end
				end

				local var_53_9 = var_53_8 + 2
				local var_53_10 = self:__init_updata_data(31, 2)
				local var_53_11 = self:__init_updata_data(32, 2)
				local var_53_12 = arg_53_2.limit_num or 0

				if arg_53_2.limit_num ~= 0 then
					for iter_53_6, iter_53_7 in pairs(self._data) do
						if arg_53_2.id == iter_53_7.id then
							var_53_12 = arg_53_2.limit_num - iter_53_7.buy_count
						end
					end
				end

				if var_53_10 and not var_53_11 or var_53_11 and not var_53_10 then
					var_53_12 = var_53_12 - 3
					var_53_9 = var_53_9 + 1
				elseif not var_53_10 and not var_53_11 then
					var_53_12 = var_53_12 - 6
				elseif var_53_10 and var_53_11 then
					var_53_9 = var_53_9 + 2
				end

				if var_53_12 == 0 and var_53_9 == 12 then
					arg_53_1.pricebtn:SetActive(false)

					arg_53_1.numberof.text.text = var_0_9:getNowLang("buyitemlimttop")
				elseif var_53_12 == 0 and var_53_9 < 12 then
					arg_53_1.pricebtn:SetActive(false)

					arg_53_1.numberof.text.text = var_0_9:getNowLang("buyitemlimttop") .. "\n" .. var_0_9:getNowLang("repair_buy_max")
				else
					arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_53_9
				end
			elseif arg_53_2.id == 27 then
				arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_53_2.max_equip
			elseif arg_53_2.id == 29 then
				arg_53_1.numberof.text.text = arg_53_2.brief .. "\n" .. var_0_9:getNowLang("evoitemown") .. var_0_1:get_furniture_warehouse_capacity()
			end
		end

		if arg_53_2.id == 30 then
			local var_53_13 = arg_53_2.limit_num

			for iter_53_8, iter_53_9 in pairs(var_53_3) do
				if arg_53_2.id == iter_53_9.id then
					var_53_13 = var_53_13 - iter_53_9.buy_count
				end
			end

			arg_53_1.numberof.text.text = var_53_13 > 0 and arg_53_2.brief .. "\n" .. var_0_12(var_0_9:getNowLang("remain_num"), var_53_13) or var_0_9:getNowLang("buyitemlimttop")
		end

		if arg_53_2.id == 34 then
			local var_53_14 = arg_53_2.limit_num

			for iter_53_10, iter_53_11 in pairs(var_53_3) do
				if arg_53_2.id == iter_53_11.id then
					var_53_14 = var_53_14 - iter_53_11.buy_count
				end
			end

			arg_53_1.numberof.text.text = var_53_14 > 0 and arg_53_2.brief .. "\n" .. var_0_12(var_0_9:getNowLang("remain_num"), var_53_14) or var_0_9:getNowLang("buyitemlimttop")
		end

		if arg_53_2.id == var_0_17.shop_item_id.change_name_card then
			local var_53_15, var_53_16 = var_0_13._get_interval_time_format(var_53_2.change_name_time)

			arg_53_1.pricebtn:SetActive(var_53_15)

			if var_53_15 then
				arg_53_1.numberof.text.text = arg_53_2.brief or var_0_12("%s%s", var_0_9:getNowLang("renameendtime"), var_53_16)
			end
		end

		if arg_53_2.id == var_0_17.shop_item_id.shop_random_box then
			local var_53_18, var_53_19 = var_0_13._get_interval_time_format(var_53_2.change_name_time)

			arg_53_1.pricebtn:SetActive(var_53_18)

			for iter_53_12, iter_53_13 in pairs(self._data) do
				if iter_53_13.id == var_0_17.shop_item_id.shop_random_box then
					if iter_53_13.buy_count then
						if arg_53_2.remain_num == true and iter_53_13.buy_count < arg_53_2.limit_num then
							local var_53_21 = var_0_12(var_0_9:getNowLang("remain_num"), arg_53_2.limit_num - iter_53_13.buy_count)

							arg_53_1.pricebtn:SetActive(true)

							arg_53_1.numberof.text.text = var_53_21
						elseif arg_53_2.remain_num == true and arg_53_2.limit_num == iter_53_13.buy_count then
							arg_53_1.pricebtn:SetActive(false)

							arg_53_1.numberof.text.text = var_0_9:getNowLang("buyitemlimttop")
						end
					else
						arg_53_1.numberof.text.text = var_0_12(var_0_9:getNowLang("remain_num"), arg_53_2.limit_num)
					end
				end
			end
		end

		if arg_53_2.id == var_0_17.shop_item_id.shop_random_box_2 then
			local var_53_22, var_53_23 = var_0_13._get_interval_time_format(var_53_2.change_name_time)

			arg_53_1.pricebtn:SetActive(var_53_22)

			for iter_53_14, iter_53_15 in pairs(self._data) do
				if iter_53_15.id == var_0_17.shop_item_id.shop_random_box_2 then
					if iter_53_15.buy_count then
						if arg_53_2.remain_num == true and iter_53_15.buy_count < arg_53_2.limit_num then
							local var_53_25 = var_0_12(var_0_9:getNowLang("remain_num"), arg_53_2.limit_num - iter_53_15.buy_count)

							arg_53_1.pricebtn:SetActive(true)

							arg_53_1.numberof.text.text = var_53_25
						elseif arg_53_2.remain_num == true and arg_53_2.limit_num == iter_53_15.buy_count then
							arg_53_1.pricebtn:SetActive(false)

							arg_53_1.numberof.text.text = var_0_9:getNowLang("buyitemlimttop")
						end
					else
						arg_53_1.numberof.text.text = var_0_12(var_0_9:getNowLang("remain_num"), arg_53_2.limit_num)
					end
				end
			end
		end

		arg_53_1.equipimg.imgbtn.button.onClick:RemoveAllListeners()
		arg_53_1.equipimg.imgbtn.button.onClick:AddListener(function()
			local var_54_0 = var_0_10:createInstance("item_info")

			var_54_0:show({
				title = arg_53_2.title,
				describe = arg_53_2.desc,
				icon = arg_53_2.icon,
				type = arg_53_2.type
			})
			var_54_0:set_listener(function()
				self:__set_item_info_panel_state()
			end, function()
				self:__set_mall_shop_panel_state()
			end)
		end)
		arg_53_1.pricebtn.button.onClick:RemoveAllListeners()
		arg_53_1.pricebtn.button.onClick:AddListener(function()
			self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.task_goto))

			local var_57_0 = app:getSystem():getChannel()

			if arg_53_2.price_type == 1 and arg_53_2.id ~= 28 then
				if not var_0_1:get_can_pay() then
					var_0_5:show(var_0_9:getNowLang("pay_not_open"))

					return
				end

				if arg_53_2.price ~= 0 and var_0_1:get_use_info_data().diamond < arg_53_2.price then
					var_0_5:show(var_0_9:getNowLang("goldnotenoughnotice"))

					return
				end

				local var_57_1 = var_0_10:createInstance("shop_bounced_repeat")

				if arg_53_2 then
					var_57_1 = arg_53_2.id >= 30 and arg_53_2.id <= 32 and var_0_10:createInstance("shop_bounced") or var_0_10:createInstance("shop_bounced_repeat")
				end

				local var_57_2 = arg_53_2.limit_num or 0

				if arg_53_2.limit_num ~= 0 then
					for iter_57_0, iter_57_1 in pairs(self._data) do
						if arg_53_2.id == iter_57_1.id then
							var_57_2 = arg_53_2.limit_num - iter_57_1.buy_count
						end
					end
				end

				if arg_53_2.id == 23 then
					local var_57_3 = self:__init_updata_data(31, 2)
					local var_57_4 = self:__init_updata_data(32, 2)

					if arg_53_2.limit_num ~= 0 then
						for iter_57_2, iter_57_3 in pairs(self._data) do
							if arg_53_2.id == iter_57_3.id then
								var_57_2 = arg_53_2.limit_num - iter_57_3.buy_count
							end
						end
					end

					if var_57_3 and not var_57_4 or var_57_4 and not var_57_3 then
						var_57_2 = var_57_2 - 3
					elseif not var_57_3 and not var_57_4 then
						var_57_2 = var_57_2 - 6
					end
				end

				var_57_1:show({
					title = arg_53_2.title,
					brief = string.gsub(arg_53_2.brief, "\n", ""),
					price = arg_53_2.price,
					type = arg_53_2.type,
					id = arg_53_2.id,
					limit_num = var_57_2
				}, "mall")
			elseif arg_53_2.price_type == 2 and arg_53_2.id ~= 28 then
				if not var_0_1:get_can_pay() then
					var_0_5:show(var_0_9:getNowLang("pay_not_open"))

					return
				end

				self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.task_goto))

				local var_57_5 = app:getSystem():getChannel()

				if var_57_5 == "default_self" or var_57_5 == "android_cbt" then
					return
				end

				var_0_1:req_CreatePayOrderReq(arg_53_2.id)

				local var_57_6 = var_0_10:createInstance("loading")

				var_57_6:show(true)
				var_57_6:set_mask_active(true)
			else
				var_0_10:createInstance("change_user_layer"):show(arg_53_2)
			end
		end)
	end

	function arg_1_0:__set_item_info_panel_state()
		self:setVisible(true)
		var_0_10:getInstance("item_info"):setVisible(true)
	end

	function arg_1_0:__set_mall_shop_panel_state()
		self:setVisible(false)
	end

	function arg_1_0:__init_diamond_data_list()
		for iter_60_0 = 1, 6 do
			local var_60_0, var_60_1 = self:loadUIPrefab("diamond_buy_view", self._control.diamonpage.scrollview.viewport.content.transform)

			var_60_0:setVisible(true)

			self._diamond_item_list[#self._diamond_item_list + 1] = var_60_0
		end

		return self._diamond_item_list
	end

	function arg_1_0:__init_mall_diamond_list()
		self:__init_diamond_data_list()

		for iter_61_0, iter_61_1 in pairs(self._diamond_data_list) do
			self._diamond_item_list[iter_61_0]._control.icon_image.image.sprite = self:loadSprite(var_0_12(var_0_17.shop_diamond_bg, iter_61_1.icon))

			self._diamond_item_list[iter_61_0]._control.icon_image.image:SetNativeSize()

			self._diamond_item_list[iter_61_0]._control.iconname.text.text = iter_61_1.title
			self._diamond_item_list[iter_61_0]._control.icondes.text.text = iter_61_1.brief
			self._diamond_item_list[iter_61_0]._control.pricebtn.pricenum.text.text = "¥" .. iter_61_1.price
			self._diamond_item_list[iter_61_0]._control.label.label_des.text.text = var_0_9:getNowLang("double")

			self._diamond_item_list[iter_61_0]._control.pricebtn.button.onClick:RemoveAllListeners()
			self._diamond_item_list[iter_61_0]._control.pricebtn.button.onClick:AddListener(function()
				local var_62_0 = app:getSystem():getChannel()

				if not var_0_1:get_can_pay() then
					var_0_5:show(var_0_9:getNowLang("pay_not_open"))

					return
				end

				self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.task_goto))

				if var_62_0 == "default_self" or var_62_0 == "android_cbt" then
					return
				end

				var_0_1:req_CreatePayOrderReq(iter_61_1.id)

				local var_62_1 = var_0_10:createInstance("loading")

				var_62_1:show(true)
				var_62_1:set_mask_active(true)
			end)
		end
	end

	function arg_1_0:__check_skin_using_codition(arg_63_1)
		local var_63_0 = {}

		if var_0_13.dict_lenght(self._using_toggle_data) > 1 then
			for iter_63_0, iter_63_1 in pairs(self._using_toggle_data) do
				if iter_63_0 == "bought" then
					if self._is_search then
						for iter_63_2, iter_63_3 in pairs(arg_63_1) do
							if iter_63_3.bought then
								var_0_7(var_63_0, iter_63_3)
							end
						end
					else
						var_63_0 = lx.clone_table(self._already_bought_skin)
					end
				elseif iter_63_0 == "not_bought" then
					if self._is_search then
						for iter_63_4, iter_63_5 in pairs(arg_63_1) do
							if not iter_63_5.bought then
								var_0_7(var_63_0, iter_63_5)
							end
						end
					else
						var_63_0 = lx.clone_table(self:__get_sort_all_skin_list_info_not_bought(self._new_skin_list, self._discount_skin_list, self._cur_have_skin_list, self._not_have_skin_list))
					end
				elseif iter_63_0 == "using" then
					if self._is_search then
						for iter_63_6, iter_63_7 in pairs(arg_63_1) do
							if self:check_using_skin(iter_63_7.cid) then
								var_0_7(var_63_0, iter_63_7)
							end
						end
					else
						for iter_63_8, iter_63_9 in pairs(self._already_bought_skin) do
							if self:check_using_skin(iter_63_9.cid) then
								var_0_7(var_63_0, iter_63_9)
							end
						end
					end
				elseif iter_63_0 == "not_using" then
					if self._is_search then
						for iter_63_10, iter_63_11 in pairs(arg_63_1) do
							if not self:check_using_skin(iter_63_11.cid) and iter_63_11.bought then
								var_0_7(var_63_0, iter_63_11)
							end
						end
					else
						for iter_63_12, iter_63_13 in pairs(self._already_bought_skin) do
							if not self:check_using_skin(iter_63_13.cid) then
								var_0_7(var_63_0, iter_63_13)
							end
						end
					end
				end
			end
		else
			return arg_63_1
		end

		return var_63_0
	end

	function arg_1_0:__check_skin_effect_codition(arg_64_1)
		local var_64_0 = {}

		for iter_64_0, iter_64_1 in pairs(arg_64_1) do
			local var_64_1 = false

			if var_0_13.dict_lenght(self._effect_toggle_data) > 1 then
				for iter_64_2, iter_64_3 in pairs(self._effect_toggle_data) do
					if iter_64_1.extra_desc and next(iter_64_1.extra_desc) then
						for iter_64_4, iter_64_5 in pairs(iter_64_1.extra_desc) do
							if iter_64_5.icon == var_0_17.skin_effect[iter_64_2] then
								var_64_1 = true
							end
						end
					end
				end
			else
				var_0_7(var_64_0, iter_64_1)
			end

			if var_64_1 then
				var_0_7(var_64_0, iter_64_1)
			end
		end

		return var_64_0
	end

	function arg_1_0:__update_skin_cell()
		if self._now_label_index == var_0_17.mall_layer_type.layer_skin then
			local var_65_0, var_65_1 = self:__get_cell_by_now_lable()
			local var_65_2 = self:__check_skin_effect_codition((self:__check_skin_using_codition(var_65_1)))

			var_65_0:set_data(var_65_2)

			function var_65_0:_set_func(arg_66_1)
				self.graylayer.grayname.text.text = var_65_2[arg_66_1 + 1].title

				self.graylayer:GetComponent("TextHorizonScroller"):SetText(var_65_2[arg_66_1 + 1].title)

				local var_66_0, var_66_1 = self:__get_current_single_cell_data(var_65_2[arg_66_1 + 1].cid)

				self.img_layer:GetComponent("TextHorizonScroller"):SetText(var_66_0)

				self.pricebtn.pricenumber.text.text = var_65_2[arg_66_1 + 1].gold
				self.iconlayer.icon_mask.icon.image.sprite = self:loadSprite((var_0_17:get_ship_icon(var_0_17.ship_icon.model_normal_xm, var_65_2[arg_66_1 + 1].icon, var_65_2[arg_66_1 + 1].icon)))

				self.label:SetActive(var_65_2[arg_66_1 + 1].is_new and not var_65_2[arg_66_1 + 1].bought)

				if var_65_2[arg_66_1 + 1].is_new and not var_65_2[arg_66_1 + 1].bought then
					self.label.image.sprite = self:loadSprite(var_0_17.shop_new_bg)
					self.label.label_des.text.text = var_0_9:getNowLang("new")
				end

				if var_65_2[arg_66_1 + 1].is_sale and not var_65_2[arg_66_1 + 1].bought and var_0_13._get_open_time(var_65_2[arg_66_1 + 1].sale_start_time, var_65_2[arg_66_1 + 1].sale_end_time) then
					self.label:SetActive(true)

					self.label.image.sprite = self:loadSprite(var_0_17.shop_discount_bg)
					self.label.label_des.text.text = var_0_9:getNowLang("discount")
					self.pricebtn.pricenumber.text.text = var_65_2[arg_66_1 + 1].sale_discount
				end

				if var_65_2[arg_66_1 + 1].bought then
					self.bought:SetActive(true)

					self.bought.desc.text.text = var_0_9:getNowLang("shoptipbuyed")
				else
					self.bought:SetActive(false)
				end

				if self:check_using_skin(var_65_2[arg_66_1 + 1].cid) then
					self.used:SetActive(true)

					self.used.imgname.text.text = var_0_9:getNowLang("state_use")
				else
					self.used:SetActive(false)
				end

				self.nogetlayer.des.text.text = var_0_9:getNowLang("shipnotget")

				self.nogetlayer:SetActive(var_66_1)
				self.iconbtn.button.onClick:RemoveAllListeners()
				self.iconbtn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.open))

					self._now_click_ship_details_data = {
						pic_id = var_65_2[arg_66_1 + 1].skin_id,
						gold = var_65_2[arg_66_1 + 1].gold,
						title = var_65_2[arg_66_1 + 1].title,
						desc1 = var_65_2[arg_66_1 + 1].desc1,
						extra_desc = var_65_2[arg_66_1 + 1].extra_desc,
						cid = var_65_2[arg_66_1 + 1].cid,
						ship_name = var_66_0,
						skins = {
							var_65_2[arg_66_1 + 1].cid
						},
						bought = var_65_2[arg_66_1 + 1].bought,
						card_cids = var_65_2[arg_66_1 + 1].card_cids,
						now_data = var_65_2[arg_66_1 + 1],
						is_have = not var_66_1
					}

					self:setVisible(false)
					var_0_10:createInstance("ship_detail"):show(var_0_17.enter_ship_detail_type.mall_shop, self._now_click_ship_details_data)
				end)
				self.pricebtn.button.onClick:RemoveAllListeners()
				self.pricebtn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.task_goto))
					var_0_10:createInstance("shop_bounced"):show({
						type = 5,
						price = var_65_2[arg_66_1 + 1].gold,
						id = var_65_2[arg_66_1 + 1].cid,
						title = var_65_2[arg_66_1 + 1].title,
						discount = var_65_2[arg_66_1 + 1].sale_discount,
						is_sale = var_65_2[arg_66_1 + 1].is_sale,
						sale_start_time = var_65_2[arg_66_1 + 1].sale_start_time,
						sale_end_time = var_65_2[arg_66_1 + 1].sale_end_time
					})
				end)
				self.bought.button.onClick:RemoveAllListeners()
				self.bought.button.onClick:AddListener(function()
					self:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.open))

					self._now_click_ship_details_data = {
						pic_id = var_65_2[arg_66_1 + 1].skin_id,
						gold = var_65_2[arg_66_1 + 1].gold,
						title = var_65_2[arg_66_1 + 1].title,
						desc1 = var_65_2[arg_66_1 + 1].desc1,
						extra_desc = var_65_2[arg_66_1 + 1].extra_desc,
						cid = var_65_2[arg_66_1 + 1].cid,
						ship_name = var_66_0,
						skins = {
							var_65_2[arg_66_1 + 1].cid
						},
						bought = var_65_2[arg_66_1 + 1].bought,
						card_cids = var_65_2[arg_66_1 + 1].card_cids,
						now_data = var_65_2[arg_66_1 + 1],
						is_have = not var_66_1
					}

					var_0_10:createInstance("ship_detail"):show(var_0_17.enter_ship_detail_type.mall_shop, self._now_click_ship_details_data)
					self:setVisible(false)
				end)
			end
		end
	end

	function arg_1_0:_play_into_se(arg_70_1)
		self:playSE(arg_70_1, false)
	end

	function arg_1_0.create_order_data_resp(arg_71_0, arg_71_1)
		var_0_15:init()
		var_0_15:pay((var_0_1:get_order_data()))
	end

	function arg_1_0:__set_sliding_area_state(arg_72_1, arg_72_2)
		if arg_72_1 == 3 then
			self._control.functionpage.scrollview.scrollbarvertical.slidingarea:SetActive(#arg_72_2 > 9)
		elseif arg_72_1 == 4 then
			self._control.otherpage.scrollview.scrollbarvertical.slidingarea:SetActive(#arg_72_2 > 9)
		end
	end

	function arg_1_0.check_using_skin(arg_73_0, arg_73_1)
		for iter_73_0, iter_73_1 in pairs((var_0_1:get_character_list())) do
			if iter_73_1.skin == arg_73_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:show_sort_layer(arg_74_1)
		self._control.changepage.type_layer:SetActive(arg_74_1)
	end

	function arg_1_0:show_skin_voucher_store(arg_75_1)
		if arg_75_1 then
			self._control.top_layer.top_btn.btnvoucher.Text.text.text = var_0_9:getNowLang("skin_voucher_shop")
		end

		self._control.top_layer.top_btn.btnvoucher:SetActive(arg_75_1)
	end

	function arg_1_0:clear_search_text()
		self._search_text_trans.text = ""
	end

	function arg_1_0:reset_skin_effect_select()
		self._need_revert = false
		self._control.top_layer.type_btn.type_txt.text.text = var_0_9:getNowLang("equip0")
		self._effect_toggle_data = {
			all = true
		}
		self._using_toggle_data = {
			all = true
		}
	end

	function arg_1_0.__record_orgin_user_data(arg_78_0)
		local var_78_0 = var_0_1:get_use_info_data()

		arg_78_0._orgin_oil = var_0_13.get_simplify_num(var_78_0.oil)
		arg_78_0._orgin_bullet = var_0_13.get_simplify_num(var_78_0.bullet)
		arg_78_0._orgin_fe = var_0_13.get_simplify_num(var_78_0.fe)
		arg_78_0._orgin_al = var_0_13.get_simplify_num(var_78_0.al)
	end

	function arg_1_0:__onReset()
		self._already_init = {
			0,
			0,
			0,
			0
		}
		self._last_content = nil
		self._now_label = nil
		self._now_label_index = 0
		self._data = {}
		self._change_skin_data = {}
		self._now_need_show_ship_id = 0
		self._now_click_ship_details_data = nil
		self._orgin_oil = 0
		self._orgin_bullet = 0
		self._orgin_fe = 0
		self._orgin_al = 0
		self._have_ship_list = {}
		self._effect_toggle_data = {
			all = true
		}
		self._using_toggle_data = {
			all = true
		}
		self._is_search = false

		if self._diamond_item_list then
			for iter_79_0, iter_79_1 in pairs(self._diamond_item_list) do
				iter_79_1:destroy()
			end
		end

		self._diamond_item_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_80_0)
	local var_80_0 = var_0_10:class("mall_shop")

	var_80_0._is_already_init = false
	var_80_0._already_init = {
		0,
		0,
		0,
		0
	}
	var_80_0._last_content = nil
	var_80_0._now_label = nil
	var_80_0._now_content = nil
	var_80_0._now_label_index = 0
	var_80_0._data = {}
	var_80_0._change_skin_data = {}
	var_80_0._now_need_show_ship_id = 0
	var_80_0._already_bought_skin = {}
	var_80_0._now_click_ship_details_data = nil
	var_80_0._is_search = false
	var_80_0._enter_type = nil
	var_80_0._layer_type = nil
	var_80_0._diamond_item_list = {}
	var_80_0._orgin_oil = 0
	var_80_0._orgin_bullet = 0
	var_80_0._orgin_fe = 0
	var_80_0._orgin_al = 0
	var_80_0._top_btn = nil
	var_80_0._search_text_trans = nil
	var_80_0._from_marry_data = nil
	var_80_0._is_from_marry = nil
	var_80_0._have_ship_list = {}
	arg_80_0._select_index_type_num = 1
	var_80_0._toggle_effect_group_obj = nil
	var_80_0._toggle_effect_group = nil
	var_80_0._toggle_using_group_obj = nil
	var_80_0._toggle_using_group = nil
	var_80_0._effect_toggle_data = {
		all = true
	}
	var_80_0._using_toggle_data = {
		all = true
	}
	var_80_0._new_skin_list = {}
	var_80_0._discount_skin_list = {}
	var_80_0._cur_have_skin_list = {}
	var_80_0._not_have_skin_list = {}

	return var_80_0
end

return var_0_0
