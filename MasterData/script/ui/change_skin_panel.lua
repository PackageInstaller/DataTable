local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.UILoader
local var_0_7 = gamecore.Language
local var_0_11 = string.format

gamecore.UILoader:define("change_skin_panel", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self:setVisible(true)

		self._skin_data = arg_2_1
		self._role_info_list = arg_2_2

		if self._skin_data then
			self._pic_id = self._skin_data.skin_id or 5
		end

		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self._control.title_bg.title_text.text.text = var_0_7:getNowLang("skin_replace_title")
		self._control.right_node.select_all_tog.label.text.text = var_0_7:getNowLang("skin_replace_all_choose")
		self._control.right_node.change_btn.change_text.text.text = var_0_7:getNowLang("replace")
		self._control.right_node.cancel_btn.cancel_text.text.text = var_0_7:getNowLang("cancel")
		self._next_btn = self._control.left_node.next_btn
		self._last_btn = self._control.left_node.last_btn
		self._list_view = self._control.left_node.item_cell_list.item_view_port.item_content

		if self._skin_data then
			self._skin_cid = self._skin_data.cid
			self._card_cids = self._skin_data.card_cids
		end

		self._control.right_node.select_all_tog.toggle.isOn = false

		self._control.right_node.select_all_tog.toggle.onValueChanged:AddListener(function(arg_4_0)
			self:__select_all(arg_4_0)
		end)
		self:__init_content()
	end

	function arg_1_0:__init_content()
		local var_5_0, var_5_1 = self:loadSprite((var_0_11(var_0_5.ship_icon.model_normal_m, self._pic_id, self._pic_id)))

		self._control.right_node.mask_bg.role_img.image.sprite = var_5_0

		self:__set_list_info()
	end

	function arg_1_0:__set_list_info()
		table.sort(self._role_info_list, function(arg_7_0, arg_7_1)
			if arg_7_0.level == arg_7_1.level then
				if arg_7_0.love == arg_7_1.love then
					return arg_7_0.statistics.create_time > arg_7_1.statistics.create_time
				else
					return arg_7_0.love > arg_7_1.love
				end
			else
				return arg_7_0.level > arg_7_1.level
			end
		end)

		self._max_page = math.ceil(#self._role_info_list / 10)
		self._cell_list = {}

		self:__refresh_list()
	end

	function arg_1_0:__refresh_list()
		self._show_cell_list = {}

		if #self._cell_list < 10 then
			for iter_8_0 = self._page_idx * 10 - 9, self._page_idx * 10 do
				local var_8_0 = self:loadUI("single_change_skin_item")

				var_8_0._panel.transform:SetParent(self._control.left_node.item_cell_list.item_view_port.item_content.rectTransform, false)

				if self._role_info_list[iter_8_0] then
					var_8_0:show(self._role_info_list[iter_8_0], self, self._page_idx)

					self._cell_list[#self._cell_list + 1] = var_8_0
					self._show_cell_list[#self._show_cell_list + 1] = var_8_0
				end
			end
		else
			local var_8_1 = 1

			for iter_8_1 = self._page_idx * 10 - 9, self._page_idx * 10 do
				local var_8_2 = self._cell_list[var_8_1]

				if not self._cell_list[var_8_1] then
					var_8_2 = self:loadUI("single_change_skin_item")

					var_8_2._panel.transform:SetParent(self._control.left_node.item_cell_list.item_view_port.item_content.rectTransform, false)

					self._cell_list[#self._cell_list + 1] = var_8_2
				end

				if self._role_info_list[iter_8_1] then
					var_8_2:show(self._role_info_list[iter_8_1], self, self._page_idx)
					var_8_2:set_select_num(self:__get_select_idx(var_8_2:__get_uid()))

					self._show_cell_list[#self._show_cell_list + 1] = var_8_2
				else
					var_8_2:setVisible(false)
				end

				var_8_1 = var_8_1 + 1
			end
		end

		self._next_btn.gameObject:SetActive(self._page_idx < self._max_page)
		self._last_btn.gameObject:SetActive(self._page_idx ~= 1)
	end

	function arg_1_0:__change_skin()
		if #self._select_item_list <= 0 then
			gamecore.prompt:show(var_0_7:getNowLang("selectshipfirst"))

			return
		end

		local var_9_0 = {}

		for iter_9_0, iter_9_1 in ipairs(self._select_item_list) do
			var_9_0[iter_9_0] = iter_9_1
		end

		var_0_1:req_MultiShipChangeSkin({
			ids = var_9_0,
			skin_id = self._skin_cid
		})
	end

	function arg_1_0:__next_panel()
		self._page_idx = self._page_idx + 1

		self:__refresh_list()

		self._is_auto_callback = true
		self._control.right_node.select_all_tog.toggle.isOn = self._select_all_page_idx == self._page_idx
		self._is_auto_callback = false
	end

	function arg_1_0:__last_panel()
		self._page_idx = math.max(1, self._page_idx - 1)

		self:__refresh_list()

		self._is_auto_callback = true
		self._control.right_node.select_all_tog.toggle.isOn = self._select_all_page_idx == self._page_idx
		self._is_auto_callback = false
	end

	function arg_1_0:__select_all(arg_12_1)
		if self._is_auto_callback then
			self._is_auto_callback = false

			return
		end

		if arg_12_1 and not self._is_auto_callback then
			if #self._select_item_list > 0 then
				local var_12_0 = var_0_6:createInstance("msgbox")

				var_12_0:show(var_0_7:getNowLang("skin_replace_choose_desc"), function()
					self._select_item_list = {}

					for iter_13_0, iter_13_1 in ipairs(self._show_cell_list) do
						iter_13_1:__set_select_state(true, arg_12_1)
					end

					self._is_auto_callback = false
					self._select_all_page_idx = self._page_idx

					var_12_0._control.main.close.gameObject:SetActive(true)
				end, function()
					self._is_auto_callback = true
					self._control.right_node.select_all_tog.toggle.isOn = false

					var_12_0._control.main.close.gameObject:SetActive(true)
				end, var_0_7:getNowLang("replace_desc"), var_0_5.msg_type.tip)

				return
			end

			self._select_all_page_idx = self._page_idx
		end

		if not self._is_auto_callback then
			for iter_12_0, iter_12_1 in ipairs(self._show_cell_list) do
				iter_12_1:__set_select_state(true, arg_12_1)
			end

			self._is_auto_callback = false
		end
	end

	function arg_1_0:__get_select_item_count()
		return #self._select_item_list
	end

	function arg_1_0:__add_select_item(arg_16_1)
		self._select_item_count = self._select_item_count + 1
		self._select_item_list[#self._select_item_list + 1] = arg_16_1

		self:__refresh_item_select_state()

		if self:__get_pake_select_count() >= #self._show_cell_list then
			self._is_auto_callback = true
			self._control.right_node.select_all_tog.toggle.isOn = true
			self._is_auto_callback = false
			self._select_all_page_idx = self._page_idx
		end
	end

	function arg_1_0:__remove_select_item(arg_17_1)
		if self:__get_pake_select_count() >= #self._show_cell_list then
			self._is_auto_callback = true
			self._control.right_node.select_all_tog.toggle.isOn = false
			self._is_auto_callback = false
			self._select_all_page_idx = 0
		end

		for iter_17_0 = #self._select_item_list, 1, -1 do
			if self._select_item_list[iter_17_0] == arg_17_1 then
				table.remove(self._select_item_list, iter_17_0)
			end
		end

		self:__refresh_item_select_state()
	end

	function arg_1_0:__get_pake_select_count()
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in ipairs(self._show_cell_list) do
			if iter_18_1:__get_is_select() then
				var_18_0 = var_18_0 + 1
			end
		end

		return var_18_0
	end

	function arg_1_0:__refresh_item_select_state()
		for iter_19_0, iter_19_1 in ipairs(self._show_cell_list) do
			iter_19_1:set_select_num(self:__get_select_idx(iter_19_1:__get_uid()))
		end
	end

	function arg_1_0:__get_select_idx(arg_20_1)
		for iter_20_0, iter_20_1 in ipairs(self._select_item_list) do
			if iter_20_1 == arg_20_1 then
				return iter_20_0
			end
		end

		return 0
	end

	function arg_1_0:__onReset()
		for iter_21_0 = 0, self._control.left_node.item_cell_list.item_view_port.item_content.rectTransform.childCount - 1 do
			self:destroyGameObject(self._control.left_node.item_cell_list.item_view_port.item_content.rectTransform:GetChild(iter_21_0).gameObject)
		end

		self._control.right_node.select_all_tog.toggle.onValueChanged:RemoveAllListeners()

		self._is_already_init = false
		self._skin_data = nil
		self._skin_cid = 0
		self._cell_list = {}
		self._show_cell_list = {}
		self._card_cids = {}
		self._pic_id = 10
		self._select_item_list = {}
		self._select_item_count = 0
		self._page_idx = 1
		self._select_all_page_idx = 0
		self._max_page = 0
		self._is_select_all = false
		self._role_info_list = {}
		self._is_auto_callback = false
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_22_0)
	local var_22_0 = var_0_6:class("change_skin_panel")

	var_22_0._is_already_init = false
	var_22_0._skin_data = nil
	var_22_0._skin_cid = 0
	var_22_0._cell_list = {}
	var_22_0._show_cell_list = {}
	var_22_0._card_cids = {}
	var_22_0._pic_id = 10
	var_22_0._select_item_list = {}
	var_22_0._select_item_count = 0
	var_22_0._page_idx = 1
	var_22_0._select_all_page_idx = 0
	var_22_0._max_page = 0
	var_22_0._is_select_all = false
	var_22_0._role_info_list = {}
	var_22_0._is_auto_callback = false

	gamecore.extend_obj(var_22_0)

	return var_22_0
end

return var_0_0
