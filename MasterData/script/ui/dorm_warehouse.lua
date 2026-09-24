local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = table.insert
local var_0_4 = table.remove
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.UILoader
local var_0_7 = string.format
local var_0_8 = UnityEngine.Vector2
local var_0_9 = gameenum.common_type
local var_0_10 = gameconfig.furniture_config

gamecore.UILoader:define("dorm_warehouse", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:update_furniture_data()
		self._furniture_sever_data = {}

		for iter_3_0, iter_3_1 in pairs(var_0_1:get_dormitory_furniture()) do
			if iter_3_1.room == 0 then
				var_0_3(self._furniture_sever_data, iter_3_1)
			end
		end

		self._orgin_furniture_data = var_0_1:get_dormitory_furniture()

		local var_3_1 = var_0_6:getInstance("dormitory") or var_0_6:createInstance("dormitory")

		for iter_3_2, iter_3_3 in pairs(var_3_1._furniture_list_form_warehouse) do
			local var_3_2

			for iter_3_4, iter_3_5 in pairs(self._furniture_sever_data) do
				if iter_3_5.id == iter_3_3.id then
					var_3_2 = iter_3_4

					break
				end
			end

			if var_3_2 ~= nil then
				var_0_4(self._furniture_sever_data, var_3_2)
			end
		end

		if #var_3_1._furniture_list_to_warehouse == 0 then
			self._furniture_recycle_data = {}
		end

		for iter_3_6, iter_3_7 in pairs(var_3_1._furniture_list_to_warehouse) do
			local var_3_3

			for iter_3_8, iter_3_9 in ipairs(self._furniture_sever_data) do
				if iter_3_9.id == iter_3_7.data.id then
					var_3_3 = iter_3_8

					break
				end
			end

			if var_3_3 == nil then
				var_0_3(self._furniture_sever_data, iter_3_7.data)
				var_0_3(self._furniture_recycle_data, iter_3_7.data)
			end
		end

		self:update_screen_data()
		self:__init_furniture_total_data()
	end

	function arg_1_0:update_furniture_lock_data()
		local function var_4_0(arg_5_0)
			if not arg_5_0 then
				return
			end

			for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
				local var_5_0 = var_0_1:get_furniture_data_by_id(iter_5_1.id)

				if var_5_0 then
					arg_5_0[iter_5_0] = var_5_0
				end
			end
		end

		var_4_0(self._furniture_sever_data)

		if self._furniture_list_data ~= self._furniture_sever_data then
			var_4_0(self._furniture_list_data)
		end

		if self._furniture_recycle_data then
			var_4_0(self._furniture_recycle_data)
		end

		if self._reusable_cell then
			self:__update_cell()
		end
	end

	function arg_1_0:get_curr_furniture_total_data()
		return self._furniture_sever_data
	end

	function arg_1_0:get_recycle_furniture_data()
		return self._furniture_recycle_data
	end

	function arg_1_0:__onUpdate()
		self._reusable_cell:update()
	end

	function arg_1_0:set_sort_data()
		self._now_type = var_0_9.furniture_type.All
		self._control.type_layer_detail.toggle_group.ALL.toggle.isOn = true
		self._now_order = var_0_9.order_sort.two

		self:__reset_toggle_state()
	end

	function arg_1_0:update_screen_data()
		if not self._furniture_sever_data then
			return
		end

		if self._now_type == var_0_9.furniture_type.All then
			self._furniture_list_data = self._furniture_sever_data

			self:get_origin_data(self._now_order, self._furniture_list_data)
		else
			self._furniture_list_data = {}

			for iter_10_0, iter_10_1 in pairs(self._furniture_sever_data) do
				if var_0_10.find_object_by_cid(iter_10_1.cid).type == self._now_type then
					var_0_3(self._furniture_list_data, iter_10_1)
				end
			end

			self:get_origin_data(self._now_order, self._furniture_list_data)
		end

		self._furniture_list_data = self:__filter_table_by_name()

		self:__update_cell()
	end

	function arg_1_0:get_origin_data(arg_11_1, arg_11_2)
		if arg_11_1 == var_0_9.order_sort.one then
			self:__get_data_by_rarity_ascend(arg_11_2)
		elseif arg_11_1 == var_0_9.order_sort.two then
			self:__get_data_by_rarity_dscend(arg_11_2)
		elseif arg_11_1 == var_0_9.order_sort.three then
			self:__get_data_by_time_ascend(arg_11_2)
		elseif arg_11_1 == var_0_9.order_sort.four then
			self:__get_data_by_time_dscend(arg_11_2)
		elseif arg_11_1 == var_0_9.order_sort.five then
			self:_get_data_by_case_ascend(arg_11_2)
		end
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_furniture_list()
			self:find_furniture()
		end

		self:update_furniture_data()

		self._is_already_init = true
	end

	function arg_1_0:find_furniture()
		self._control.search.inputField.onEndEdit:RemoveAllListeners()
		self._control.search.inputField.onEndEdit:AddListener(function()
			self._filter_name = self._control.search.inputField.text ~= "" and self._control.search.inputField.text or nil

			self:update_content()
		end)
	end

	function arg_1_0:update_content()
		self:__reset_furniture_list_data()

		self._furniture_list_data = self:__filter_table_by_name()

		self:__update_cell()
	end

	function arg_1_0:__reset_furniture_list_data()
		if not self._furniture_sever_data then
			return
		end

		if self._now_type == var_0_9.furniture_type.All then
			self._furniture_list_data = self._furniture_sever_data

			self:get_origin_data(self._now_order, self._furniture_list_data)
		else
			self._furniture_list_data = {}

			for iter_16_0, iter_16_1 in pairs(self._furniture_sever_data) do
				if var_0_10.find_object_by_cid(iter_16_1.cid).type == self._now_type then
					var_0_3(self._furniture_list_data, iter_16_1)
				end
			end

			self:get_origin_data(self._now_order, self._furniture_list_data)
		end
	end

	function arg_1_0:__filter_table_by_name()
		local var_17_0 = {}

		if not self._filter_name then
			return self._furniture_list_data
		end

		if self._filter_name == "(" then
			self._filter_name = "%("
		end

		for iter_17_0, iter_17_1 in pairs(self._furniture_list_data) do
			if gamecore.util_func.name_filter_match(var_0_10.find_object_by_cid(iter_17_1.cid).title, self._filter_name) then
				var_0_3(var_17_0, iter_17_1)
			end
		end

		return var_17_0
	end

	function arg_1_0:__update_search_name()
		self._filter_name = nil
		self._control.search.inputField.text = ""
	end

	function arg_1_0:__init_language()
		self._control.top_layer.title.text.text = var_0_5:getNowLang("furniturestorage")
		self._control.order_layer_detail.filter_type.title.text.text = var_0_5:getNowLang("furniturestorage")
		self._control.type_layer_detail.filter_type.title.text.text = var_0_5:getNowLang("furniturestorage")
		self._control.furniture_layer.furniture_des.text.text = var_0_5:getNowLang("furnitureamounttip")
		self._control.exchange_btn.des.text.text = var_0_5:getNowLang("exchangestore")
		self._control.recycle_btn.des.text.text = var_0_5:getNowLang("furniture_dismantle")
		self._control.order_layer.des.text.text = var_0_5:getNowLang("ui_teamtip2")
		self._control.order_layer.type_des.text.text = var_0_5:getNowLang("furnituresorttype_s2")
		self._control.type_layer.des.text.text = var_0_5:getNowLang("ui_collectionviewtip")
		self._control.type_layer.type_des.text.text = var_0_5:getNowLang("trophytype0")
		self._control.type_layer_detail.filter_type.type_txt.text.text = var_0_5:getNowLang("type")
		self._control.order_layer_detail.filter_type.type_txt.text.text = var_0_5:getNowLang("sorttype")
		self._control.top_layer.title.desc.desc_text.text.text = var_0_5:getNowLang("furniture_desc")
		self._control.type_layer_detail.toggle_group.ALL.Label.text.text = var_0_5:getNowLang("furnituretype0")

		for iter_19_0 = 0, self._control.type_layer_detail.toggle_group.item_parent.transform.childCount - 1 do
			self._control.type_layer_detail.toggle_group.item_parent.transform:GetChild(iter_19_0):Find("Label"):GetComponent("Text").text = var_0_5:getNowLang("furnituretype" .. iter_19_0 + 1)
		end

		self._order_toggle_group = {
			self._control.order_layer_detail.toggle_group.to_1,
			self._control.order_layer_detail.toggle_group.to_2,
			self._control.order_layer_detail.toggle_group.to_3,
			self._control.order_layer_detail.toggle_group.to_4,
			self._control.order_layer_detail.toggle_group.to_5
		}

		for iter_19_1, iter_19_2 in pairs(self._order_toggle_group) do
			iter_19_2.Label.text.text = var_0_5:getNowLang("furnituresorttype" .. iter_19_1)
		end
	end

	function arg_1_0:__init_furniture_list()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_furniture", "dorm_warehouse")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:__init_furniture_total_data()
		self._control.furniture_layer.amount_txt.text.text = var_0_7("%s/%s", #self._orgin_furniture_data, (var_0_1:get_furniture_warehouse_capacity()))
	end

	function arg_1_0:__update_cell()
		local var_22_0 = self._furniture_list_data

		self._reusable_cell:set_data(self._furniture_list_data)

		function self._reusable_cell:_set_func(arg_23_1)
			self.put_dorm.gameObject:SetActive(not self.fur_lock_state)

			self.put_dorm.icondes.text.text = var_0_5:getNowLang("putinroom")

			self.lock.gameObject:SetActive(var_22_0[arg_23_1 + 1].lock)

			if self.fur_lock_state then
				self.lock_btn.lock_effect.title.text.text = var_0_5:getNowLang("ui_equip_lock")

				self.lock_btn.gameObject:SetActive(true)
				self.lock_btn.lock_effect.gameObject:SetActive(var_22_0[arg_23_1 + 1].lock)

				self.bg.button.interactable = false
			else
				self.lock_btn.gameObject:SetActive(false)

				self.bg.button.interactable = true
			end

			self.bg.image.raycastTarget = true

			local var_23_0 = var_0_10.find_object_by_cid(var_22_0[arg_23_1 + 1].cid)

			self.bg.image.sprite = self:loadSprite((var_0_7(var_0_9.furniture_bg, (var_23_0.star > 0 or nil) and (var_23_0.star or 1))))
			self.bg.icon.image.sprite = self:loadSprite((var_0_9:get_ship_icon(var_0_9.furniture_s_img, var_23_0.icon)))
			self.frame.image.sprite = self:loadSprite(var_0_9.common_icon.room_furniture_frame.blue)
			self.name_mask.name_txt.text.text = var_23_0.title

			local var_23_1 = self.name_mask:GetComponent(typeof(TextScroller))

			var_23_1:SetText(var_23_0.title)

			var_23_1.deltaLength = var_0_9.dormitory_const.text_interval
			var_23_1.scrollSpeed = var_0_9.dormitory_const.scroll_speed

			self.bg.button.onClick:RemoveAllListeners()
			self.bg.button.onClick:AddListener(function()
				var_0_6:createInstance("furniture_detail_panel"):show({
					cid = var_22_0[arg_23_1 + 1].cid,
					lock = var_22_0[arg_23_1 + 1].lock,
					id = var_22_0[arg_23_1 + 1].id
				})
			end)
			self.put_dorm.button.onClick:RemoveAllListeners()
			self.put_dorm.button.onClick:AddListener(function()
				self:setVisible(false)

				local var_25_0 = var_0_6:getInstance("dormitory")

				var_25_0:setVisible(true)
				var_25_0:set_special_sortingOrder()
				var_25_0:put_furniture_to_dorm(var_22_0[arg_23_1 + 1])
			end)
			self.lock_btn.button.onClick:RemoveAllListeners()
			self.lock_btn.button.onClick:AddListener(function()
				var_0_1:req_LockFurnitureReq({
					id = var_22_0[arg_23_1 + 1].id
				})
			end)
		end
	end

	function arg_1_0:__reset_toggle_state()
		for iter_27_0 = 0, self._control.order_layer_detail.toggle_group.transform.childCount - 1 do
			self._control.order_layer_detail.toggle_group.transform:GetChild(iter_27_0):GetComponent("Toggle").isOn = iter_27_0 == 1
		end
	end

	function arg_1_0.__get_data_by_rarity_ascend(arg_28_0, arg_28_1)
		var_0_2(arg_28_1, function(arg_29_0, arg_29_1)
			local var_29_0 = var_0_10.find_object_by_cid(arg_29_0.cid)
			local var_29_1 = var_0_10.find_object_by_cid(arg_29_1.cid)

			if var_29_0.star == var_29_1.star then
				return var_29_0.cid > var_29_1.cid
			else
				return var_29_0.star < var_29_1.star
			end
		end)
	end

	function arg_1_0.__get_data_by_rarity_dscend(arg_30_0, arg_30_1)
		var_0_2(arg_30_1, function(arg_31_0, arg_31_1)
			local var_31_0 = var_0_10.find_object_by_cid(arg_31_0.cid)
			local var_31_1 = var_0_10.find_object_by_cid(arg_31_1.cid)

			if var_31_0.star == var_31_1.star then
				return var_31_0.cid > var_31_1.cid
			else
				return var_31_0.star > var_31_1.star
			end
		end)
	end

	function arg_1_0.__get_data_by_time_ascend(arg_32_0, arg_32_1)
		var_0_2(arg_32_1, function(arg_33_0, arg_33_1)
			return var_0_1:get_furniture_data_by_id(arg_33_0.id).time < var_0_1:get_furniture_data_by_id(arg_33_1.id).time
		end)
	end

	function arg_1_0.__get_data_by_time_dscend(arg_34_0, arg_34_1)
		var_0_2(arg_34_1, function(arg_35_0, arg_35_1)
			return var_0_1:get_furniture_data_by_id(arg_35_0.id).time > var_0_1:get_furniture_data_by_id(arg_35_1.id).time
		end)
	end

	function arg_1_0._get_data_by_case_ascend(arg_36_0, arg_36_1)
		var_0_2(arg_36_1, function(arg_37_0, arg_37_1)
			local var_37_0 = var_0_10.find_object_by_cid(arg_37_0.cid)
			local var_37_1 = var_0_10.find_object_by_cid(arg_37_1.cid)

			if var_37_0.case_id == var_37_1.case_id then
				return var_37_0.cid > var_37_1.cid
			else
				return var_37_0.case_id > var_37_1.case_id
			end
		end)
	end

	function arg_1_0:__reset_scroll_view_position()
		self._control.scrollview.viewport.content.transform.localPosition = var_0_8(self._control.scrollview.viewport.content.transform.localPosition.x, 0)

		self._control.scrollview.scrollbarvertical.slidingarea.handle:SetActive(#self._furniture_list_data > var_0_9.dormitory_const.warehouse_scroll_area)
	end

	function arg_1_0:switch_lock_state()
		if not self.fur_lock_state then
			self.fur_lock_state = true
			self._control.top_layer.title.text.text = var_0_5:getNowLang("furniture_lock")
			self._control.top_layer.title.desc.desc_text.text.text = var_0_5:getNowLang("furniture_lock_desc")
		else
			self.fur_lock_state = false
			self._control.top_layer.title.text.text = var_0_5:getNowLang("furniturestorage")
			self._control.top_layer.title.desc.desc_text.text.text = var_0_5:getNowLang("furniture_desc")
		end

		self:__update_cell()
	end

	function arg_1_0:return_lock_state()
		if self.fur_lock_state then
			self.fur_lock_state = false
			self._control.top_layer.title.text.text = var_0_5:getNowLang("furniturestorage")
			self._control.top_layer.title.desc.desc_text.text.text = var_0_5:getNowLang("furniture_desc")
		end
	end

	function arg_1_0:_play_into_se(arg_41_1)
		self:playSE(arg_41_1, false)
	end

	function arg_1_0.__onReset(arg_42_0)
		arg_42_0._is_already_init = nil
		arg_42_0._furniture_list_data = {}
		arg_42_0._order_toggle_group = nil
		arg_42_0._now_type = nil
		arg_42_0._now_order = nil
		arg_42_0._furniture_sever_data = nil
		arg_42_0._orgin_furniture_data = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_43_0)
	local var_43_0 = var_0_6:class("dorm_warehouse")

	var_43_0._is_already_init = nil
	var_43_0._furniture_list_data = {}
	var_43_0._reusable_cell = nil
	var_43_0._order_toggle_group = nil
	var_43_0._now_type = nil
	var_43_0._now_order = nil
	var_43_0._furniture_sever_data = nil
	var_43_0._orgin_furniture_data = nil
	var_43_0._filter_name = nil
	var_43_0.fur_lock_state = false

	return var_43_0
end

return var_0_0
