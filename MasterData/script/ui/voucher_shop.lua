local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_4 = UnityEngine
local var_0_6 = table.insert
local var_0_7 = gamecore.Language
local var_0_8 = gamecore.UILoader
local var_0_9 = string.format
local var_0_12 = gamecore.util_func
local var_0_13 = gameenum.common_type
local var_0_14 = gameconfig.item_config
local var_0_15 = gameconfig.ship_config
local var_0_16 = gameconfig.skin_config
local var_0_17 = gameconfig.skin_voucher_shop_config

gamecore.UILoader:define("voucher_shop", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end

		if self._reusable_cell_2 then
			self._reusable_cell_2:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)

		self._shop_number = arg_3_1

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:destroyChildren("single_voucher_shop")
		self:destroyChildren("single_voucher_shop_select")

		self._now_shop_data = var_0_17.find_object_by_id(self._shop_number)

		local var_4_0 = var_0_8:getInstance("mall_shop")

		if var_4_0 then
			self._panel.transform:GetComponent("Canvas").sortingOrder = var_4_0._panel.transform:GetComponent("Canvas").sortingOrder + 2

			var_4_0:setVisible(false)
		end

		local var_4_1 = var_0_8:getInstance("home")

		if var_4_1 then
			var_4_1:setVisible(false)
		end

		if not self._is_init then
			self:__init_filter_type_list()

			self._is_init = true
		end

		self:__initial_func()
		self:__init_shop_skin_data()
		self:reset_skin_effect_select()
		self:__init_reusable_cell()
		self:__check_new_voucher()
		self:__update_cell()
		self:__update_cell_side()
		self:__set_scroll_to_top()
		self:update_search_ship_data()
	end

	function arg_1_0:__initial_func(arg_5_1)
		self._control.top.title_text.text.text = var_0_7:getNowLang("skin_voucher_shop")
		self._control.top.title_text.desc_text.text.text = var_0_7:getNowLang("skin_voucher_shop")
		self._control.top.change_limit.change_name.text.text = "兑换期限"
		self._control.top.ship_type_btn.type_text.text.text = var_0_7:getNowLang("equip0")
		self._control.type_layer.bg.btn_series.confirm_btn.confirm.text.text = var_0_7:getNowLang("confirm")
		self._control.type_layer.bg.btn_series.cancel_btn.cancel.text.text = var_0_7:getNowLang("cancel")
		self._control.type_layer.bg.effect_group.toggle_group.all.Label.text.text = var_0_7:getNowLang("equip0")
		self._control.type_layer.bg.effect_group.toggle_group.shell_effect.Label.text.text = var_0_7:getNowLang("skin_effect_type_1")
		self._control.type_layer.bg.effect_group.toggle_group.live.Label.text.text = var_0_7:getNowLang("skin_effect_type_2")
		self._control.type_layer.bg.effect_group.toggle_group.sp_music.Label.text.text = var_0_7:getNowLang("skin_effect_type_3")
		self._control.type_layer.bg.effect_group.toggle_group.sp_dialogue.Label.text.text = var_0_7:getNowLang("skin_effect_type_4")
		self._control.type_layer.bg.effect_group.toggle_group.sp_menu.Label.text.text = var_0_7:getNowLang("skin_effect_type_5")
		self._control.type_layer.bg.effect_group.toggle_group.airplane.Label.text.text = var_0_7:getNowLang("skin_effect_type_6")
		self._control.type_layer.bg.effect_group.toggle_group.voice.Label.text.text = var_0_7:getNowLang("skin_effect_type_7")

		local var_5_0 = var_0_1:get_item_count(self._now_shop_data.item_id)

		if self._now_shop_data.end_time == 0 then
			self._control.top.change_limit:SetActive(false)
		else
			self._control.top.change_limit:SetActive(true)

			self._control.top.change_limit.change_time.text.text = self:__time_format_line(self._now_shop_data.end_time)

			self._control.top.change_limit.change_time:SetActive(true)
		end

		self._search_text_trans = self._control.top.search_btn.search.inputField

		if not arg_5_1 then
			self._search_text_trans.text = ""
		end

		self._search_text_trans.onEndEdit:RemoveAllListeners()
		self._search_text_trans.onEndEdit:AddListener(function()
			self:update_search_ship_data(self._search_text_trans.text)
		end)
	end

	function arg_1_0:__init_shop_skin_data()
		self._now_skin_data = {}

		for iter_7_0, iter_7_1 in pairs(self._now_shop_data.skin_id) do
			self._now_skin_data[iter_7_1.number] = iter_7_1.exchange_skin_id
		end
	end

	function arg_1_0:__init_filter_type_list()
		self._toggle_effect_group = {
			all = self._control.type_layer.bg.effect_group.toggle_group.all,
			shell_effect = self._control.type_layer.bg.effect_group.toggle_group.shell_effect,
			live = self._control.type_layer.bg.effect_group.toggle_group.live,
			sp_music = self._control.type_layer.bg.effect_group.toggle_group.sp_music,
			sp_dialogue = self._control.type_layer.bg.effect_group.toggle_group.sp_dialogue,
			sp_menu = self._control.type_layer.bg.effect_group.toggle_group.sp_menu,
			airplane = self._control.type_layer.bg.effect_group.toggle_group.airplane,
			voice = self._control.type_layer.bg.effect_group.toggle_group.voice
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
	end

	function arg_1_0:__check_skin_effect_codition()
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs((lx.clone_table(self._now_shop_data.skin_id))) do
			local var_9_1 = var_0_16.find_object_by_cid(iter_9_1.exchange_skin_id)
			local var_9_2 = false

			if var_0_12.dict_lenght(self._effect_toggle_data) > 1 then
				for iter_9_2, iter_9_3 in pairs(self._effect_toggle_data) do
					if var_9_1.extra_desc and next(var_9_1.extra_desc) then
						for iter_9_4, iter_9_5 in pairs(var_9_1.extra_desc) do
							if iter_9_5.icon == var_0_13.skin_effect[iter_9_2] then
								var_9_2 = true
							end
						end
					end
				end
			else
				var_0_6(var_9_0, iter_9_1)
			end

			if var_9_2 then
				var_0_6(var_9_0, iter_9_1)
			end
		end

		self._now_skin_data = {}

		for iter_9_6, iter_9_7 in pairs(var_9_0) do
			self._now_skin_data[iter_9_7.number] = iter_9_7.exchange_skin_id
		end

		return self._now_skin_data
	end

	function arg_1_0:__check_skin_bought_codition(arg_10_1)
		self._bought_skin = {}

		for iter_10_0, iter_10_1 in pairs((lx.clone_table(var_0_1:get_skin_data_info()))) do
			self._bought_skin[iter_10_0] = iter_10_1
		end

		local var_10_0 = {}

		for iter_10_2, iter_10_3 in pairs(arg_10_1) do
			if not self._bought_skin[iter_10_3] then
				var_10_0[1] = iter_10_3
			end
		end

		self._now_skin_data = lx.clone_table(var_10_0)

		return self._now_skin_data
	end

	function arg_1_0:__check_new_voucher()
		self._bought_skin = {}

		for iter_11_0, iter_11_1 in pairs((lx.clone_table(var_0_1:get_skin_data_info()))) do
			self._bought_skin[iter_11_0] = iter_11_1
		end

		self._skin_all_bought = true

		for iter_11_2, iter_11_3 in pairs((lx.clone_table(self._now_shop_data.skin_id))) do
			if not self._bought_skin[iter_11_3.exchange_skin_id] then
				self._skin_all_bought = false
			end
		end
	end

	function arg_1_0:update_search_ship_data(arg_12_1)
		self._search_text_trans.text = arg_12_1
		self._search_name = arg_12_1

		if arg_12_1 == "" or not arg_12_1 then
			self:__update_cell()

			return
		end

		if arg_12_1 == "(" then
			arg_12_1 = "%("
		end

		self:__update_cell()
	end

	function arg_1_0:__check_skin_search_codition(arg_13_1)
		if self._search_name == "" or not self._search_name then
			return arg_13_1
		end

		local var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(arg_13_1) do
			local var_13_1 = var_0_16.find_object_by_cid(iter_13_1)
			local var_13_2 = var_0_15.find_object_by_cid(var_13_1.card_cids[1])

			if var_0_12.name_filter_match(var_13_1.title, self._search_name) then
				var_13_0[iter_13_0] = iter_13_1
			elseif var_0_12.name_filter_match(var_13_2.title, self._search_name) then
				var_13_0[iter_13_0] = iter_13_1
			end
		end

		local var_13_3 = {}

		for iter_13_2, iter_13_3 in pairs(var_13_0) do
			var_13_3[1] = iter_13_3
		end

		return var_13_3
	end

	function arg_1_0:__init_reusable_cell()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.mainpage.scrollview.viewport.content.endlessScrollView, self._control.mainpage.scrollview.viewport.content, "single_voucher_shop", "voucher_shop")

		self._reusable_cell:init()

		self._reusable_cell_2 = gamecore.reusable_cell:create(self, self._control.sidepage.scrollview.viewport.content.endlessScrollView, self._control.sidepage.scrollview.viewport.content, "single_voucher_shop_select", "voucher_shop")

		self._reusable_cell_2:init()
	end

	function arg_1_0:__update_cell()
		local var_15_0 = self:__check_skin_search_codition((self:__check_skin_bought_codition((self:__check_skin_effect_codition()))))

		if self._now_shop_data.voucher_item_id and next(self._now_shop_data.voucher_item_id) then
			for iter_15_0, iter_15_1 in pairs(self._now_shop_data.voucher_item_id) do
				var_15_0[#var_15_0 + 1] = iter_15_1.exchange_item_id
			end
		end

		self._reusable_cell:set_data(var_15_0)

		function self._reusable_cell:_set_func(arg_16_1)
			local var_16_0 = var_0_1:get_item_count(self._now_shop_data.item_id)

			self.icon_bg.icon.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_icon, var_15_0[arg_16_1 + 1]))
			self.buy_btn.icon.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_icon, self._now_shop_data.item_id))
			self.disable_btn.icon.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_icon, self._now_shop_data.item_id))
			self.buy_btn.icon.Text.text.text = 1
			self.disable_btn.icon.Text.text.text = 1

			if var_15_0[arg_16_1 + 1] > 100000 then
				local var_16_1 = var_0_16.find_object_by_cid(var_15_0[arg_16_1 + 1])

				self.title:GetComponent("TextHorizonScroller"):SetText(var_16_1.title)
				self.name_text:SetActive(true)

				self.name_text.text.text = var_0_15.find_object_by_cid(var_16_1.card_cids[1]).title

				if var_16_0 < 1 then
					self.buy_btn:SetActive(false)
					self.disable_btn:SetActive(true)
				else
					self.buy_btn:SetActive(true)
					self.disable_btn:SetActive(false)
				end
			else
				self.title:GetComponent("TextHorizonScroller"):SetText(gameconfig.item_config.find_object_by_cid(var_15_0[arg_16_1 + 1]).title)
				self.name_text:SetActive(false)

				if self._skin_all_bought and var_16_0 > 0 then
					self.buy_btn:SetActive(true)
					self.disable_btn:SetActive(false)
				else
					self.buy_btn:SetActive(false)
					self.disable_btn:SetActive(true)
				end
			end

			self.buy_btn.button.onClick:RemoveAllListeners()
			self.buy_btn.button.onClick:AddListener(function()
				self._control.buy_msgbox.main.title_text.text.text = var_0_7:getNowLang("ui_4th_buff_change_title")
				self._control.buy_msgbox.main.confirmbtn.text.text.text = var_0_7:getNowLang("ui_cbtn1")
				self._control.buy_msgbox.main.quitbtn.text.text.text = var_0_7:getNowLang("ui_cbtn2")
				self._control.buy_msgbox.main.main_text.text.text.text = var_15_0[arg_16_1 + 1] > 100000 and var_0_9(var_0_7:getNowLang("skin_voucher_shop_explain"), var_0_16.find_object_by_cid(var_15_0[arg_16_1 + 1]).title) or var_0_9(var_0_7:getNowLang("skin_voucher_shop_explain"), gameconfig.item_config.find_object_by_cid(var_15_0[arg_16_1 + 1]).title)

				self._control.buy_msgbox.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.quitbtn.gameObject:SetActive(true)
				self._control.buy_msgbox.main.confirmbtn.button.onClick:RemoveAllListeners()
				self._control.buy_msgbox.main.confirmbtn.button.onClick:AddListener(function()
					local var_18_0 = {
						shop_id = self._shop_number
					}

					if var_15_0[arg_16_1 + 1] > 100000 then
						var_18_0.voucher_id = 0
						var_18_0.skin_id = var_15_0[arg_16_1 + 1]
					else
						var_18_0.voucher_id = var_15_0[arg_16_1 + 1]
						var_18_0.skin_id = 0
					end

					var_0_1:req_VoucherShopBuyReq(var_18_0)
				end)
			end)
		end
	end

	function arg_1_0:__update_cell_side()
		local var_19_0 = var_0_17.get_sequence()

		if #var_19_0 < 4 then
			for iter_19_0 = #var_19_0 + 1, 4 do
				var_19_0[iter_19_0] = {}
			end
		end

		self._control.sidepage.scrollview.scrollbarvertical:SetActive(false)
		self._reusable_cell_2:set_data(var_19_0)

		function self._reusable_cell_2:_set_func(arg_20_1)
			if var_19_0[arg_20_1 + 1] and next(var_19_0[arg_20_1 + 1]) then
				self.bg_empty:SetActive(false)
				self.bg_select:SetActive(true)
				self.voucher_count:SetActive(true)

				self.voucher_count.count.text.text = var_0_1:get_item_count(var_19_0[arg_20_1 + 1].item_id)
				self.bg_select.voucher_icon.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_icon, var_19_0[arg_20_1 + 1].item_id))
				self.bg_select.Text.text.text = var_19_0[arg_20_1 + 1].name

				if self._shop_number == var_19_0[arg_20_1 + 1].id then
					self.bg_select.bg_light:SetActive(true)

					self.bg_select.bg_light.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_sprite, "shop_bg_2_1_1"))
					self.bg_select.bg.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_sprite, "shop_bg_2_1"))
					self.bg_select.bg.image.color = var_0_4.Color(1, 1, 1, 1)
					self.bg_select.voucher_icon.image.color = var_0_4.Color(1, 1, 1, 1)
					self.bg_select.bg_top.image.color = var_0_4.Color(1, 1, 1, 1)
					self.bg_select.Text.text.color = var_0_4.Color(1, 1, 1, 1)
				else
					self.bg_select.bg_light:SetActive(false)

					self.bg_select.bg.image.sprite = self:loadSprite(var_0_9(var_0_13.voucher_skin_sprite, "shop_bg_2_2"))
					self.bg_select.bg.image.color = var_0_4.Color(0.6313725490196078, 0.5803921568627451, 0.5803921568627451, 1)
					self.bg_select.voucher_icon.image.color = var_0_4.Color(0.6313725490196078, 0.5803921568627451, 0.5803921568627451, 1)
					self.bg_select.bg_top.image.color = var_0_4.Color(0.6313725490196078, 0.5803921568627451, 0.5803921568627451, 1)
					self.bg_select.Text.text.color = var_0_4.Color(0.6313725490196078, 0.5803921568627451, 0.5803921568627451, 1)
				end

				self.voucher_count.title:GetComponent("TextHorizonScroller"):SetText(var_0_14.find_object_by_cid(var_19_0[arg_20_1 + 1].item_id).title)

				if var_19_0[arg_20_1 + 1].end_time == 0 then
					self.limit_time:SetActive(false)
				else
					self.limit_time:SetActive(true)

					self.limit_time.Text.text.text = "截止时间：" .. self:__time_format_line(var_19_0[arg_20_1 + 1].end_time)
				end

				self.select_btn.button.onClick:RemoveAllListeners()
				self.select_btn.button.onClick:AddListener(function()
					if self._shop_number ~= var_19_0[arg_20_1 + 1].id then
						self._shop_number = var_19_0[arg_20_1 + 1].id
						self._now_shop_data = var_0_17.find_object_by_id(self._shop_number)

						self:__update_cell()
						self:__update_cell_side()
					end
				end)
			else
				self.bg_empty:SetActive(true)
				self.bg_select:SetActive(false)
				self.voucher_count:SetActive(false)
				self.limit_time:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_scroll_to_top()
		self._control.mainpage.scrollview.scrollbarvertical:GetComponent("Scrollbar").value = self.scrollbar_value ~= 1 and self.scrollbar_value or 1
	end

	function arg_1_0:show_sort_layer(arg_23_1)
		self._control.type_layer:SetActive(arg_23_1)

		if self._need_revert then
			self:__revert_toggle_group_all_set()

			self._need_revert = false
		end

		self:__save_toggle_group_all_set_data()
	end

	function arg_1_0:_play_into_se(arg_24_1)
		self:playSE(arg_24_1, false)
	end

	function arg_1_0.__time_format(arg_25_0, arg_25_1)
		return (os.date("%Y-%m-%d\n%H:%M:%S", arg_25_1))
	end

	function arg_1_0.__time_format_line(arg_26_0, arg_26_1)
		return (os.date("%Y-%m-%d   %H:%M:%S", arg_26_1))
	end

	function arg_1_0:reset_skin_effect_select()
		self._need_revert = false
		self._control.top.ship_type_btn.type_text.text.text = var_0_7:getNowLang("equip0")
		self._effect_toggle_data = {
			all = true
		}

		for iter_27_0, iter_27_1 in pairs(self._toggle_effect_group) do
			iter_27_1.toggle.isOn = iter_27_0 == "all"
		end
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_29_0)
		return
	end

	function arg_1_0.reset_init(arg_30_0)
		arg_30_0._is_init = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_8:class("voucher_shop")

	var_31_0._is_init = false
	var_31_0._now_skin_data = {}
	var_31_0._now_shop_data = {}
	var_31_0.scrollbar_value = 1
	var_31_0._shop_number = 1
	var_31_0._bought_skin = {}
	var_31_0._skin_all_bought = false
	var_31_0._search_name = ""
	var_31_0._toggle_effect_group_obj = nil
	var_31_0._toggle_effect_group = nil
	var_31_0._effect_toggle_data = {
		all = true
	}

	return var_31_0
end

return var_0_0
