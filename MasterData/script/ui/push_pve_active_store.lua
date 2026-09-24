local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_8 = gameconfig.pve_active_buff_config
local var_0_9 = string.format
local var_0_10 = gamecore.util_func

gamecore.UILoader:define("push_pve_active_store", function(arg_1_0)
	function arg_1_0:show()
		self:__init_panel()
		self:setVisible(true)
	end

	function arg_1_0:__init_panel()
		self._panel.transform:GetComponent("Canvas").sortingOrder = var_0_3:getInstance("fearlessness_sea")._panel.transform:GetComponent("Canvas").sortingOrder + 1

		local var_3_0 = var_0_5:get_push_info_using_buff()

		self:__init_equip_buff_cell_list()

		if not self._is_init and var_3_0 then
			self:__init_buff_list()
			self:__init_buff_reusable_list()
			self:__init_equip_buff_cell_list()

			self._cur_buff_id = var_3_0[1]
			self._need_exp_list = {
				3,
				6,
				0
			}
			self._is_init = true
		end

		self._control.bg.title_bg.title_txt.text.text = var_0_2:getNowLang("active_buff_warehouse")

		self:__init_control()
		self:update_all_buff_detail_data()
		self:__set_select_buff_left_or_right(var_3_0)

		if type(self._cur_buff_id) ~= "number" and next(self._cur_buff_id) then
			self:__update_buff_detail_panel(self._cur_buff_id.data.id)
		else
			self:__update_buff_detail_panel()
		end

		self:update_show_active_panel()
		self:__update_equip_buff()
	end

	function arg_1_0:__set_select_buff_left_or_right(arg_4_1)
		local var_4_0 = self:__update_unequip_reusable_data()

		if var_4_0 and next(var_4_0) then
			self._cur_buff_id = var_4_0[1]
			self._is_left = false
		end
	end

	function arg_1_0:__init_control()
		self._buff_detail_control = self._control.buff_detail
	end

	function arg_1_0:__init_buff_list()
		for iter_6_0, iter_6_1 in pairs((var_0_8.get_sequence())) do
			if iter_6_1.id ~= 11000 then
				local var_6_0 = {
					title = "",
					buff_icon = "",
					desc_level_3 = "",
					type = 0,
					value = 0,
					effect_desc = "",
					desc_level_1 = "",
					desc_level_2 = "",
					id = 0,
					level = 0,
					id = iter_6_1.id,
					title = iter_6_1.title,
					level = iter_6_1.level,
					type = iter_6_1.type,
					buff_icon = iter_6_1.buff_icon,
					effect_desc = iter_6_1.effect_desc,
					desc_level_1 = var_0_2:convert_rich_text(iter_6_1.desc_level_1),
					desc_level_2 = var_0_2:convert_rich_text(iter_6_1.desc_level_2),
					desc_level_3 = var_0_2:convert_rich_text(iter_6_1.desc_level_3),
					value = iter_6_1.value
				}

				self._buff_list[var_6_0.id] = var_6_0
			end
		end
	end

	function arg_1_0:__init_buff_reusable_list()
		if self._already_init then
			return
		end

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.endlessScrollView, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content, "push_pve_active_buff_cell", "push_pve_active_store", true)

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__init_equip_buff_cell_list()
		self._equip_buff_cell_list = {
			self._control.equip_buff_content.equip_buff_cell_1,
			self._control.equip_buff_content.equip_buff_cell_2,
			self._control.equip_buff_content.equip_buff_cell_3,
			self._control.equip_buff_content.equip_buff_cell_4,
			self._control.equip_buff_content.equip_buff_cell_5,
			self._control.equip_buff_content.equip_buff_cell_6
		}
	end

	function arg_1_0:update_all_buff_detail_data()
		self:update_buff_detail_data((var_0_5:get_save_now_fear()))
	end

	function arg_1_0.update_buff_detail_data(arg_10_0, arg_10_1)
		local function var_10_0(arg_11_0)
			local var_11_0 = {}

			for iter_11_0, iter_11_1 in pairs(arg_11_0) do
				var_11_0[iter_11_1.id] = {
					config = arg_10_0._buff_list[iter_11_1.id],
					data = iter_11_1
				}
			end

			return var_11_0
		end

		if not arg_10_1 then
			arg_10_0._easy_buff_detail_data_list = var_10_0(var_0_5:get_push_buff_list())
		else
			arg_10_0._hard_buff_detail_data_list = var_10_0(var_0_5:get_push_buff_list())
		end
	end

	function arg_1_0:__update_equip_buff_image(arg_12_1, arg_12_2)
		local var_12_0 = var_0_5:get_push_info_using_buff()

		if var_12_0 then
			if arg_12_1 <= #var_12_0 then
				local var_12_1 = self:__get_buff_detail_data(var_12_0[arg_12_1])

				if var_12_1 then
					local var_12_2, var_12_3 = self:__get_image_path(var_12_0[arg_12_1])

					arg_12_2.buff_bg:SetActive(true)

					local var_12_4 = var_0_8.find_object_by_id(var_12_0[arg_12_1])

					arg_12_2.buff_bg.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_buff_bg_image, var_12_1.data.level)))
					arg_12_2.buff_bg.buff_image.image.sprite = self:loadSprite(var_12_3)
					arg_12_2.buff_bg.buff_lv_num.text.text = var_0_9("Lv%d", var_12_1.data.level)
				else
					arg_12_2.buff_bg:SetActive(false)
				end
			else
				arg_12_2.buff_bg:SetActive(false)
			end
		else
			arg_12_2.buff_bg:SetActive(false)
		end
	end

	function arg_1_0.__register_equip_buff_button(arg_13_0, arg_13_1, arg_13_2)
		arg_13_2.buff_bg:GetComponent("Button").onClick:RemoveAllListeners()
		arg_13_2.buff_bg:GetComponent("Button").onClick:AddListener(function()
			arg_13_0._equip_buff_index = arg_13_1
			arg_13_0._is_left = true

			arg_13_0:__update_buff_detail_panel()
			arg_13_0:__register_blue_button()
		end)
	end

	function arg_1_0:__update_buff_detail_panel(arg_15_1, arg_15_2)
		local var_15_0 = var_0_5:get_push_info_using_buff()

		self._cur_buff_id = var_15_0 and (arg_15_1 or var_15_0[self:__get_cur_buff_index()]) or arg_15_1

		if self._cur_buff_id then
			self._buff_detail_data = self:__get_buff_detail_data(self._cur_buff_id)
			self._buff_level = self._buff_detail_data.data.level

			self._buff_detail_control:SetActive(true)
			self:__update_buff_detail_image(self._buff_detail_data.data.id, self._buff_level)

			self._buff_detail_control.buff_title.text.text = var_0_8.find_object_by_id(self._cur_buff_id).title

			self:__update_buff_detail_level_desc()
			self:__update_equip_buff_select_outline(arg_15_1)
			self:__update_unequip_buff_select_outline()
			self:__update_buff_exp_content()
			self:__update_buff_detail_blue_button()
			self:__update_buff_detail_left_and_right_toggle()
		else
			self._control.buff_detail_bg.info_bg_1:SetActive(false)
			self._control.buff_detail_bg.info_bg_2:SetActive(false)
			self._control.buff_detail:SetActive(false)
		end
	end

	function arg_1_0:__update_buff_detail_image(arg_16_1, arg_16_2)
		local var_16_0, var_16_1 = self:__get_image_path(arg_16_1)

		self._buff_detail_control.buff_bg.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_buff_bg_image, arg_16_2)))
		self._buff_detail_control.buff_bg.buff_image.image.sprite = self:loadSprite(var_16_1)
	end

	function arg_1_0:__update_buff_detail_level_desc(arg_17_1)
		local var_17_0

		if not arg_17_1 then
			var_17_0 = self._buff_level or self._buff_level + arg_17_1
		end

		self._buff_detail_control.buff_lv.text.text = var_0_2:getNowLang("active_buff_level")

		local var_17_1 = var_0_8.find_object_by_id(self._buff_detail_data.data.id)
		local var_17_2 = ""

		if var_17_0 == 1 then
			var_17_2 = var_17_1.desc_level_1
		elseif var_17_0 == 2 then
			var_17_2 = var_17_1.desc_level_2
		elseif var_17_0 == 3 then
			var_17_2 = var_17_1.desc_level_3
		end

		if var_17_0 <= self:__get_now_buff_data_num(self._buff_detail_data.data.id) then
			self._buff_detail_control.buff_lv.buff_lv_num.text.text = var_0_9("Lv%d", var_17_0)
			self._buff_detail_control.buff_lv.buff_lv_num.text.color = Color.New(0.1607843137254902, 0.6509803921568628, 1, 1)
			self._buff_detail_control.buff_desc_bg.buff_desc.text.text = var_0_10.convert_rich_text(var_17_2)
		elseif var_17_0 > 1 then
			self._buff_detail_control.buff_lv.buff_lv_num.text.text = var_0_9("Lv%d", var_17_0)
			self._buff_detail_control.buff_lv.buff_lv_num.text.color = Color.New(0.996078431372549, 0.6745098039215687, 0.16470588235294117, 1)
			self._buff_detail_control.buff_desc_bg.buff_desc.text.text = var_0_10.convert_rich_text(var_17_2, "FFAB28FF")
		end
	end

	function arg_1_0.__get_now_buff_data_num(arg_18_0, arg_18_1)
		local var_18_1 = 1
		local var_18_2 = var_0_5:get_push_buff_list()

		if var_18_2 and next(var_18_2) then
			for iter_18_0, iter_18_1 in pairs(var_18_2) do
				if iter_18_1.id == arg_18_1 then
					var_18_1 = iter_18_1.count
				end
			end
		end

		return var_18_1 >= 10 and 3 or var_18_1 >= 4 and var_18_1 <= 9 and 2 or 1
	end

	function arg_1_0:__update_equip_buff_select_outline(arg_19_1)
		for iter_19_0, iter_19_1 in pairs(self._equip_buff_cell_list) do
			iter_19_1.buff_bg.select_outline:SetActive(false)
		end

		if arg_19_1 then
			return
		end

		self._equip_buff_cell_list[self:__get_cur_buff_index()].buff_bg.select_outline:SetActive(true)
	end

	function arg_1_0:__update_unequip_buff_select_outline(arg_20_1)
		if self._reusable_cell then
			for iter_20_0, iter_20_1 in pairs((self._reusable_cell:get_all_item())) do
				iter_20_1.control._control.buff_bg.select_outline:SetActive(false)
			end

			if arg_20_1 then
				arg_20_1._control.buff_bg.select_outline:SetActive(true)
			end
		end
	end

	function arg_1_0:__update_buff_exp_content()
		if self._buff_detail_data.data.level < self._buff_level or self._buff_detail_data.data.level == 3 then
			self._buff_detail_control.buff_exp_bg:SetActive(false)

			return
		else
			self._buff_detail_control.buff_exp_bg:SetActive(true)
		end

		local var_21_0, var_21_1 = self:__get_exp_image_path()
		local var_21_2 = self._buff_detail_control.buff_exp_bg
		local var_21_3 = self._buff_level ~= self._buff_detail_data.data.level
		local var_21_4 = self._buff_level ~= self._buff_detail_data.data.level and 0 or self._buff_detail_data.data.need_exp - self._buff_detail_data.data.exp

		self._buff_detail_control.buff_exp_bg.buff_exp_remain.text.text = var_0_2:getNowLang("active_buff_expreience")
		var_21_2.image.sprite = self:loadSprite(var_21_0)
		var_21_2.buff_exp_image.image.sprite = self:loadSprite(var_21_1)
		var_21_2.buff_exp_image.image.fillAmount = var_21_4 / self._buff_detail_data.data.need_exp

		if var_21_3 then
			var_21_2.buff_exp_num.text.text = self._buff_level or self._buff_detail_data.data.level
		end

		var_21_2.buff_exp_remain.remain_num.text.text = var_0_9("(%d/%d)", var_21_4, (var_21_3 or nil) and (self._need_exp_list[self._buff_level] or self._buff_detail_data.data.need_exp))
	end

	function arg_1_0:__update_buff_detail_blue_button()
		self._buff_detail_control.equip_state_btn.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_blue_button_image, not self._buff_detail_data.data.is_equip and var_0_5:is_equip_buff_content_full() and 1 or 2)))

		self:__register_blue_button()
	end

	function arg_1_0:__register_blue_button(arg_23_1)
		if self._is_left then
			self._buff_detail_control.equip_choose_btn.Text.text.text = var_0_2:getNowLang("active_buff_cancel")
			self._buff_detail_control.equip_state_btn.Text.text.text = var_0_2:getNowLang("ui_support_card_open")
			self._buff_detail_control.equip_state_btn.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_blue_button_image, 2)))
		else
			self._buff_detail_control.equip_choose_btn.Text.text.text = var_0_2:getNowLang("active_buff_use")
			self._buff_detail_control.equip_state_btn.Text.text.text = var_0_2:getNowLang("active_buff_not_use")
			self._buff_detail_control.equip_state_btn.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_blue_button_image, 1)))
		end
	end

	function arg_1_0:__update_buff_detail_left_and_right_toggle()
		local var_24_0 = self:__get_cur_buff_detail_level()

		self._buff_detail_control.left_toggle_btn:SetActive(var_24_0 > self._buff_detail_data.data.level and var_24_0 ~= 1)
		self._buff_detail_control.right_toggle_btn:SetActive(var_24_0 ~= 3)
	end

	function arg_1_0:__get_image_path(arg_25_1)
		if arg_25_1 then
			local var_25_0 = self:__get_buff_detail_data(arg_25_1)

			if var_25_0 then
				return var_0_9(var_0_4.pve_active_buff_bg_image, var_25_0.data.level), (var_0_9(var_0_4.pve_active_buff_image, var_0_8.find_object_by_id(var_25_0.data.id).buff_icon))
			end
		end
	end

	function arg_1_0.__get_exp_image_path(arg_26_0)
		return var_0_9(var_0_4.pve_active_buff_level_bg_image, 2), (var_0_9(var_0_4.pve_active_buff_level_image, 2))
	end

	function arg_1_0:__get_buff_detail_data(arg_27_1)
		if arg_27_1 then
			local var_27_0 = arg_27_1 or self._cur_buff_id

			return (not self._is_hard or nil) and (self._easy_buff_detail_data_list[var_27_0] or self._hard_buff_detail_data_list[var_27_0])
		end
	end

	function arg_1_0:__update_equip_buff()
		for iter_28_0, iter_28_1 in pairs(self._equip_buff_cell_list) do
			if not iter_28_1.buff_bg.transform.gameObject:GetComponent("Button") then
				iter_28_1.buff_bg.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))
			end

			self:__update_equip_buff_image(iter_28_0, iter_28_1)
			self:__register_equip_buff_button(iter_28_0, iter_28_1)
		end
	end

	function arg_1_0:__get_cur_buff_detail_level()
		return self._buff_level
	end

	function arg_1_0:__get_cur_buff_index()
		return self._equip_buff_index ~= 0 and self._equip_buff_index or self._unequip_buff_index
	end

	function arg_1_0.__have_data(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
		local var_31_0 = false

		if next(arg_31_1) then
			for iter_31_0, iter_31_1 in pairs(arg_31_1) do
				if iter_31_1.id == arg_31_2 then
					iter_31_1[1] = arg_31_3
					var_31_0 = true

					return true
				end
			end
		end

		return var_31_0
	end

	function arg_1_0:__update_reusable_cell(arg_32_1)
		local var_32_0 = self:__update_unequip_reusable_data()

		if not var_32_0 then
			self._control.buff_detail:SetActive(false)

			return
		end

		self._all_unequip_buff_list = {}
		self._all_unequip_buff_list_2 = {}
		self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.transform.anchoredPosition = Vector2(20, -18)

		self._reusable_cell:set_data(var_32_0)

		function self._reusable_cell:_set_func(arg_33_1)
			self:show(var_32_0[arg_33_1 + 1])
			var_0_1(self._all_unequip_buff_list, self._control)

			if not self:__have_data(self._all_unequip_buff_list_2, var_32_0[arg_33_1 + 1].data.id, self._control) then
				var_0_1(self._all_unequip_buff_list_2, {
					id = var_32_0[arg_33_1 + 1].data.id,
					self._control
				})
			end

			local var_33_0 = self:__get_image_path(var_32_0[arg_33_1 + 1].data.id)

			self._control.buff_bg.select_outline:SetActive(false)

			self._control.buff_bg.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_buff_bg_image, self:__get_buff_detail_data(var_32_0[arg_33_1 + 1].data.id).data.level)))
			self._control.buff_image.image.sprite = self:loadSprite((var_0_9(var_0_4.pve_active_buff_image, var_0_8.find_object_by_id(var_32_0[arg_33_1 + 1].data.id).buff_icon)))

			if not self._panel.transform.gameObject:GetComponent("Button") then
				self._panel.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))
			end

			self._panel:GetComponent("Button").onClick:RemoveAllListeners()
			self._panel:GetComponent("Button").onClick:AddListener(function()
				self._equip_buff_index = 0
				self._unequip_buff_index = arg_33_1 + 1
				self._is_left = false

				self:__update_buff_detail_panel(var_32_0[arg_33_1 + 1].data.id)
				self:__update_unequip_buff_select_outline(self)
				self:__update_equip_buff_select_outline(self._unequip_buff_index)
				self:__register_blue_button()
				self._control.buff_detail_bg:SetActive(true)
				self._control.buff_detail:SetActive(true)
			end)

			local var_33_1 = self:__update_unequip_reusable_data()

			if var_33_1 and next(var_33_1) and not arg_32_1 and next(self._all_unequip_buff_list_2) and self._all_unequip_buff_list_2[arg_33_1 + 1] and self._all_unequip_buff_list_2[arg_33_1 + 1].id == self._cur_buff_id then
				self._all_unequip_buff_list_2[arg_33_1 + 1][1].buff_bg.select_outline:SetActive(true)
			end
		end
	end

	function arg_1_0:set_remove_buff_after_panel()
		self._control.buff_detail.equip_state_btn.Text.text.text = var_0_2:getNowLang("active_buff_not_use")
		self._control.buff_detail.equip_choose_btn.Text.text.text = var_0_2:getNowLang("te")

		local var_35_0 = var_0_5:get_push_info_using_buff()

		if var_35_0 and next(var_35_0) then
			self._cur_buff_id = var_35_0[1]

			self:__update_buff_detail_panel(self._cur_buff_id)

			for iter_35_0, iter_35_1 in pairs(self._equip_buff_cell_list) do
				iter_35_1.buff_bg.select_outline:SetActive(false)
			end

			for iter_35_2, iter_35_3 in pairs(self._equip_buff_cell_list) do
				self._equip_buff_cell_list[1].buff_bg.select_outline:SetActive(true)
			end

			if next(self._all_unequip_buff_list) then
				self._all_unequip_buff_list[1].buff_bg.select_outline:SetActive(false)
			end

			self._is_left = true
		else
			local var_35_1 = self:__update_unequip_reusable_data()

			if var_35_1 and next(var_35_1) then
				self._cur_buff_id = var_35_1[1].data.id
			end

			self:__update_buff_detail_panel(self._cur_buff_id)

			if next(self._all_unequip_buff_list) then
				self._all_unequip_buff_list[1].buff_bg.select_outline:SetActive(true)
			end

			self._is_left = false
		end

		self:__update_buff_detail_blue_button()
	end

	function arg_1_0:set_add_buff_after_panel()
		self._control.buff_detail.equip_state_btn.Text.text.text = var_0_2:getNowLang("ui_support_card_open")
		self._control.buff_detail.equip_choose_btn.Text.text.text = var_0_2:getNowLang("active_buff_cancel")

		local var_36_0 = self:__update_unequip_reusable_data()

		if var_36_0 and next(var_36_0) then
			self._is_left = false
			self._cur_buff_id = var_36_0[1].data.id

			self:__update_buff_detail_panel(self._cur_buff_id)

			for iter_36_0, iter_36_1 in pairs(self._equip_buff_cell_list) do
				iter_36_1.buff_bg.select_outline:SetActive(false)
			end
		else
			self._is_left = true

			local var_36_1 = var_0_5:get_push_info_using_buff()

			if var_36_1 and next(var_36_1) then
				self._cur_buff_id = var_36_1[1]
			end

			self:__update_buff_detail_panel(self._cur_buff_id)
			self._equip_buff_cell_list[1].buff_bg.select_outline:SetActive(true)
		end

		self:__update_buff_detail_blue_button()
	end

	function arg_1_0:__update_unequip_reusable_data()
		local var_37_0 = var_0_5:get_save_now_fear() and self._hard_buff_detail_data_list or self._easy_buff_detail_data_list
		local var_37_1 = {}
		local var_37_2 = var_0_5:get_push_info_using_buff()

		if var_37_2 then
			for iter_37_0, iter_37_1 in pairs(var_37_0) do
				local var_37_3 = true

				for iter_37_2, iter_37_3 in pairs(var_37_2) do
					if iter_37_1.data.id == iter_37_3 then
						var_37_3 = false
					end
				end

				if var_37_3 then
					var_0_1(var_37_1, iter_37_1)
				end
			end
		else
			for iter_37_4, iter_37_5 in pairs(var_37_0) do
				var_0_1(var_37_1, iter_37_5)
			end
		end

		if var_37_1 and next(var_37_1) then
			for iter_37_6, iter_37_7 in pairs(var_37_1) do
				iter_37_7.data.type = var_0_8.find_object_by_id(iter_37_7.data.id).type
			end

			table.sort(var_37_1, function(arg_38_0, arg_38_1)
				return arg_38_0.data.level > arg_38_1.data.level or arg_38_0.data.level == arg_38_1.data.level and arg_38_0.data.type > arg_38_1.data.type or arg_38_0.data.level == arg_38_1.data.level and arg_38_0.data.type == arg_38_1.data.type and arg_38_0.data.id < arg_38_1.data.id
			end)
		end

		return var_37_1
	end

	function arg_1_0:update_show_active_panel(arg_39_1)
		if self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.transform.childCount > 0 then
			for iter_39_0 = 1, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.transform.childCount do
				for iter_39_1 = 1, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.transform.childCount do
					self:destroyGameObject(self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.transform:GetChild(iter_39_1 - 1).gameObject)
				end
			end
		end

		self._reusable_cell = nil

		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content.endlessScrollView, self._control.store_buff_content.all_store_buff.Viewport.edge_mask.Content, "push_pve_active_buff_cell", "push_pve_active_store", true)

			self._reusable_cell:init()
		end

		self:__update_equip_buff()
		self:__update_reusable_cell(arg_39_1)
	end

	function arg_1_0:_play_into_se(arg_40_1)
		self:playSE(arg_40_1, false)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0.__onReset(arg_42_0)
		arg_42_0._is_init = false
		arg_42_0._buff_list = {}
		arg_42_0._easy_buff_detail_data_list = {}
		arg_42_0._hard_buff_detail_data_list = {}
		arg_42_0._equip_buff_cell_list = {}
		arg_42_0._is_hard = false
		arg_42_0._buff_level = 1
		arg_42_0._equip_buff_index = 1
		arg_42_0._unequip_buff_index = 0
		arg_42_0._buff_detail_data = {}
		arg_42_0._cur_buff_id = 11001
		arg_42_0._reusable_cell = nil
		arg_42_0._is_left = true
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_43_0)
	local var_43_0 = var_0_3:class("push_pve_active_store")

	gamecore.extend_obj(var_43_0)

	var_43_0._is_init = false
	var_43_0._buff_list = {}
	var_43_0._easy_buff_detail_data_list = {}
	var_43_0._hard_buff_detail_data_list = {}
	var_43_0._equip_buff_cell_list = {}
	var_43_0._is_hard = false
	var_43_0._buff_level = 1
	var_43_0._equip_buff_index = 1
	var_43_0._unequip_buff_index = 0
	var_43_0._buff_detail_data = {}
	var_43_0._cur_buff_id = 11001
	var_43_0._reusable_cell = nil
	var_43_0._is_left = true
	var_43_0._all_unequip_buff_list = {}

	return var_43_0
end

return var_0_0
