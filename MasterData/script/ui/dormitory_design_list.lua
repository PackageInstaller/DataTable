local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = table.sort
local var_0_6 = string.format
local var_0_7 = table.insert
local var_0_8 = gameconfig.furniture_config
local var_0_9 = gameconfig.room_prefab_config

gamecore.UILoader:define("dormitory_design_list", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		if arg_2_2 then
			self:__init_panel(arg_2_1)

			return
		end

		self:setVisible(true)
		self:__init_panel(arg_2_1)
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0.set_listener(arg_4_0, arg_4_1)
		arg_4_0._confirm_listener = arg_4_1
	end

	function arg_1_0:__preload_furniture_fragment()
		self._obj_pool = {}

		for iter_5_0 = 1, 120 do
			local var_5_0 = self:loadUI("furniture_narrow")

			var_5_0._panel.transform:SetParent(self._control.obj_pool_root.transform, false)
			var_5_0._panel.transform.gameObject:SetActive(true)
			var_0_7(self._obj_pool, {
				belong_to_index = -1,
				prefabContorl = var_5_0
			})
		end
	end

	function arg_1_0:__load_furniture_with_pool(arg_6_1, arg_6_2)
		local var_6_0 = false
		local var_6_1

		for iter_6_0, iter_6_1 in ipairs(self._obj_pool) do
			if iter_6_1.belong_to_index == -1 then
				var_6_0 = true
				var_6_1 = iter_6_1

				break
			end
		end

		if var_6_0 then
			var_6_1.belong_to_index = arg_6_1

			var_6_1.prefabContorl._panel.transform:SetParent(arg_6_2, false)

			return var_6_1.prefabContorl
		else
			local var_6_2 = self:loadUI("furniture_narrow")

			var_6_2._panel.transform:SetParent(arg_6_2, false)
			var_0_7(self._obj_pool, {
				prefabContorl = var_6_2,
				belong_to_index = arg_6_1
			})

			return var_6_2
		end
	end

	function arg_1_0:__hide_all_furniture_to_pool(arg_7_1)
		if arg_7_1 ~= nil then
			for iter_7_0, iter_7_1 in ipairs(self._obj_pool) do
				if iter_7_1.belong_to_index == arg_7_1 then
					iter_7_1.prefabContorl._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

					iter_7_1.belong_to_index = -1
				end
			end
		else
			for iter_7_2, iter_7_3 in ipairs(self._obj_pool) do
				if iter_7_3.belong_to_index ~= -1 then
					iter_7_3.prefabContorl._panel.transform:SetParent(self._control.obj_pool_root.transform, false)

					iter_7_3.belong_to_index = -1
				end
			end
		end
	end

	function arg_1_0:__get_exhibition_data_by_id_in_server_data(arg_8_1)
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in pairs(self._exhibition_data) do
			if iter_8_1.id == arg_8_1 then
				var_8_0 = iter_8_1

				break
			end
		end

		return var_8_0
	end

	function arg_1_0.__get_exhibition_data_by_id_in_cfg(arg_9_0, arg_9_1)
		local var_9_0 = {}

		for iter_9_0, iter_9_1 in pairs(var_0_9.get_sequence()) do
			if iter_9_1.id == arg_9_1 then
				var_9_0 = iter_9_1

				break
			end
		end

		return var_9_0
	end

	function arg_1_0:__get_my_favorite_data()
		local var_10_0 = {}
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs((var_0_4:get_exhibition_data())) do
			if iter_10_1.type == var_0_3.dorm_exhibition_type.prefab then
				var_0_7(var_10_0, iter_10_1)

				var_10_0[#var_10_0] = self:__get_exhibition_data_by_id_in_cfg(iter_10_1.id)
				var_10_0[#var_10_0].is_prefab = true
			else
				var_0_7(var_10_1, iter_10_1)

				var_10_1[#var_10_1] = self:__get_exhibition_data_by_id_in_server_data(iter_10_1.id)
				var_10_1[#var_10_1].is_prefab = false
			end
		end

		return var_10_0, var_10_1
	end

	function arg_1_0.__insert_to_tab_2(arg_11_0, arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in ipairs(arg_11_2) do
			var_0_7(arg_11_1, iter_11_1)
		end

		return arg_11_1
	end

	function arg_1_0.__insert_to_tab(arg_12_0, arg_12_1, arg_12_2)
		var_0_5(arg_12_2, function(arg_13_0, arg_13_1)
			return arg_13_0.point.y > arg_13_1.point.y
		end)

		for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
			var_0_7(arg_12_1, iter_12_1)
		end

		return arg_12_1
	end

	function arg_1_0:__sort_furniture(arg_14_1)
		local var_14_0 = {
			move_forbid_tb = {},
			wall_tb = {},
			ground_tb = {},
			floor_tb = {},
			lean_wall_tb = {},
			ceiling_tb = {}
		}

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			local var_14_1 = var_0_8.find_object_by_cid(iter_14_1.cid)

			if var_14_1.furniture_type == var_0_3.furniture_pos_type.move_forbid then
				var_0_7(var_14_0.move_forbid_tb, iter_14_1)
			elseif var_14_1.furniture_type == var_0_3.furniture_pos_type.wall then
				var_0_7(var_14_0.wall_tb, iter_14_1)
			elseif var_14_1.furniture_type == var_0_3.furniture_pos_type.ground then
				var_0_7(var_14_0.ground_tb, iter_14_1)
			elseif var_14_1.furniture_type == var_0_3.furniture_pos_type.floor then
				var_0_7(var_14_0.floor_tb, iter_14_1)
			elseif var_14_1.furniture_type == var_0_3.furniture_pos_type.lean_wall then
				var_0_7(var_14_0.lean_wall_tb, iter_14_1)
			elseif var_14_1.furniture_type == var_0_3.furniture_pos_type.ceiling then
				var_0_7(var_14_0.ceiling_tb, iter_14_1)
			else
				log.print_r("不存在其他类型")
			end
		end

		return (self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab(self:__insert_to_tab({}, var_14_0.move_forbid_tb), var_14_0.floor_tb), var_14_0.wall_tb), var_14_0.lean_wall_tb), var_14_0.ground_tb), var_14_0.ceiling_tb))
	end

	function arg_1_0:__filtrate_by_rule_search(arg_15_1)
		local var_15_0 = false
		local var_15_1 = {}

		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			if not iter_15_1.is_prefab then
				local var_15_6, var_15_7 = string.find(iter_15_1.title, self._now_search_str)
				local var_15_8, var_15_9 = string.find(iter_15_1.username, self._now_search_str)

				if var_15_6 or var_15_7 or var_15_8 or var_15_9 then
					table.insert(var_15_1, iter_15_1)

					var_15_0 = true
				end
			end
		end

		if not var_15_0 then
			arg_15_1 = {}
		end

		arg_15_1 = var_15_1
		self._now_search_str = nil

		return arg_15_1
	end

	function arg_1_0:__filtrate_by_rule_sort(arg_16_1)
		if self._now_sort_type == self._sort_type_list.designsorttype1 then
			var_0_5(arg_16_1, function(arg_17_0, arg_17_1)
				return arg_17_0.time > arg_17_1.time
			end)
		elseif self._now_sort_type == self._sort_type_list.designsorttype2 then
			var_0_5(arg_16_1, function(arg_18_0, arg_18_1)
				return arg_18_0.score > arg_18_1.score
			end)
		elseif self._now_sort_type == self._sort_type_list.designsorttype3 then
			var_0_5(arg_16_1, function(arg_19_0, arg_19_1)
				return arg_19_0.score < arg_19_1.score
			end)
		elseif self._now_sort_type == self._sort_type_list.designsorttype4 then
			var_0_5(arg_16_1, function(arg_20_0, arg_20_1)
				return arg_20_0.popular > arg_20_1.popular
			end)
		end

		return arg_16_1
	end

	function arg_1_0:__filtrate_by_rule_heat(arg_21_1)
		local var_21_0 = {}

		if self._now_heat_type == self._heat_type_list.roomdesigntype1 then
			var_0_5(arg_21_1, function(arg_22_0, arg_22_1)
				return arg_22_0.id < arg_22_1.id
			end)

			for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
				var_0_7(var_21_0, iter_21_1)

				var_21_0[iter_21_0].is_prefab = true
			end
		elseif self._now_heat_type == self._heat_type_list.roomdesigntype2 then
			var_0_5(arg_21_1, function(arg_23_0, arg_23_1)
				return arg_23_0.time > arg_23_1.time
			end)

			for iter_21_2, iter_21_3 in ipairs(arg_21_1) do
				var_0_7(var_21_0, iter_21_3)

				var_21_0[iter_21_2].is_prefab = false

				if 100 <= iter_21_2 then
					break
				end
			end
		elseif self._now_heat_type == self._heat_type_list.roomdesigntype3 or self._now_heat_type == self._heat_type_list.roomdesigntype4 then
			var_0_5(arg_21_1, function(arg_24_0, arg_24_1)
				return arg_24_0.popular > arg_24_1.popular
			end)

			for iter_21_4, iter_21_5 in ipairs(arg_21_1) do
				var_0_7(var_21_0, iter_21_5)

				var_21_0[iter_21_4].is_prefab = false

				if 100 <= iter_21_4 then
					break
				end
			end
		end

		return arg_21_1
	end

	function arg_1_0:__filtrate_by_rule()
		local var_25_0 = {}

		if self._now_lable == 1 then
			if self._now_heat_type == self._heat_type_list.roomdesigntype1 then
				var_25_0 = self:__filtrate_by_rule_heat((var_0_9.get_sequence()))
			else
				var_25_0 = self:__filtrate_by_rule_heat(self._exhibition_data)
				var_25_0 = self:__filtrate_by_rule_sort(var_25_0)
			end

			if self._now_search_str ~= nil and self._now_search_str ~= "" then
				var_25_0 = self:__filtrate_by_rule_search(self._exhibition_data)
			end
		else
			local var_25_2, var_25_3 = self:__get_my_favorite_data()

			var_0_5(var_25_2, function(arg_26_0, arg_26_1)
				return arg_26_0.id < arg_26_1.id
			end)

			var_25_0 = self:__insert_to_tab_2(var_25_0, (self:__filtrate_by_rule_sort(var_25_3)))
			var_25_0 = self:__insert_to_tab_2(var_25_0, var_25_2)
		end

		local var_25_4 = {}

		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			var_0_7(var_25_4, iter_25_1)

			var_25_0[iter_25_0].furniture = self:__sort_furniture(var_25_0[iter_25_0].furniture)
		end

		return var_25_4
	end

	function arg_1_0:__show_search_layer(arg_27_1)
		self._control.search_layer:SetActive(arg_27_1)
	end

	function arg_1_0:__show_order_type_layer(arg_28_1)
		self._control.order_layer_detail:SetActive(arg_28_1)
	end

	function arg_1_0:__show_heat_type_layer(arg_29_1)
		self._control.type_layer_detail:SetActive(arg_29_1)
	end

	function arg_1_0:__click_search_btn_event()
		self:__show_search_layer(true)

		self._control.search_layer.bg.input.inputField.text = ""
	end

	function arg_1_0:__click_search_confirm_btn_event()
		self:__show_search_layer(false)

		self._now_search_str = self._control.search_layer.bg.input.inputField.text

		if self._now_search_str == "" or self._now_search_str == nil then
			return
		end

		self:update_cell()
	end

	function arg_1_0:__click_order_type_btns_event(arg_32_1)
		self._now_sort_type = arg_32_1

		self:__show_order_type_layer(false)
		self:update_cell()
	end

	function arg_1_0:__click_heat_type_btns_event(arg_33_1)
		self._now_heat_type = arg_33_1

		self:__show_heat_type_layer(false)
		self:update_cell()
	end

	function arg_1_0:__click_my_favorite_btn_event()
		self._now_lable = self._now_lable == 1 and 2 or 1

		self:__show_btns_by_lable()
		self:update_cell()
	end

	function arg_1_0:update_cell()
		self._control.order_layer.type_des.text.text = var_0_2:getNowLang(self._now_sort_type)
		self._control.type_layer.type_des.text.text = var_0_2:getNowLang(self._now_heat_type)

		self:__hide_all_furniture_to_pool(nil)

		local var_35_0 = self:__filtrate_by_rule()

		self._now_design_data_list = var_35_0

		self._reusable_cell:set_data(var_35_0)

		function self._reusable_cell:_set_func(arg_36_1)
			local var_36_0 = var_35_0[arg_36_1 + 1]
			local var_36_1 = var_35_0[arg_36_1 + 1].is_prefab
			local var_36_2 = var_0_4:have_exhibition_for_id(var_36_0.id, (var_35_0[arg_36_1 + 1].is_prefab or nil) and (var_0_3.dorm_exhibition_type.prefab or var_0_3.dorm_exhibition_type.player), var_36_1)

			self.collect_tag:SetActive(var_36_2)
			self.popularity:SetActive(not var_36_1)
			self.popularity_num:SetActive(not var_36_1)
			self.grade:SetActive(not var_36_1)
			self.grade_num:SetActive(not var_36_1)

			self.design_name_txt.text.text = var_36_0.title
			self.designer_name_txt.text.text = var_36_0.username
			self.popularity.text.text = var_0_2:getNowLang("evaluationnum")
			self.grade.text.text = var_0_2:getNowLang("evaluationscore")

			if not var_36_1 then
				self.popularity_num.text.text = var_36_0.popular
				self.grade_num.text.text = var_0_6("%.2f", var_36_0.score)
				self.grade_num.text.color = var_36_0.score > 0 and Color.New(0.17647058823529413, 0.6941176470588235, 0.9686274509803922) or Color.New(0.39215686274509803, 0.39215686274509803, 0.39215686274509803)
			end

			for iter_36_0, iter_36_1 in ipairs(var_36_0.furniture) do
				local var_36_3 = var_0_8.find_object_by_cid(iter_36_1.cid)
				local var_36_4 = self:__load_furniture_with_pool(arg_36_1, self.furniture_root.transform)

				var_36_4._panel.transform:SetParent(self.furniture_root.transform, false)

				var_36_4._panel.transform:GetComponent("RectTransform").anchoredPosition = self.furniture_root.rectTransform.anchoredPosition

				var_36_4:show({
					type = 1,
					data = iter_36_1,
					config = var_36_3
				})
			end

			self.btn.button.onClick:RemoveAllListeners()
			self.btn.button.onClick:AddListener(function()
				var_0_1:createInstance("dormitory_design_detail"):show({
					design_data = var_36_0,
					is_prefab = var_36_1,
					is_collect = var_36_2
				})
			end)
		end

		function self._reusable_cell._recycle_func(arg_38_0)
			self:__hide_all_furniture_to_pool(arg_38_0)
		end
	end

	function arg_1_0.__set_prefab_info(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4)
		return
	end

	function arg_1_0:__show_btns_by_lable()
		self._control.search_btn:SetActive(self._now_lable == 1)
		self._control.type_layer:SetActive(self._now_lable == 1)
	end

	function arg_1_0:__init_panel(arg_41_1)
		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
			self:__init_reusable_cell()
			self:__preload_furniture_fragment()
		end

		self._exhibition_data = arg_41_1
		self._now_lable = 1

		self:__show_btns_by_lable()

		self._now_sort_type = self._sort_type_list.designsorttype1
		self._now_heat_type = self._heat_type_list.roomdesigntype2

		self:update_cell()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.top_layer.title.text.text = var_0_2:getNowLang("showroom")
		self._control.search_btn.input_text.text.text = var_0_2:getNowLang("search")
		self._control.order_layer.txt.text.text = var_0_2:getNowLang("sorttype")
		self._control.type_layer.txt.text.text = var_0_2:getNowLang("type")
		self._control.my_favorite_btn.txt.text.text = var_0_2:getNowLang("mycollection")
		self._control.order_layer_detail.order1.txt.text.text = var_0_2:getNowLang("designsorttype1")
		self._control.order_layer_detail.order2.txt.text.text = var_0_2:getNowLang("designsorttype2")
		self._control.order_layer_detail.order3.txt.text.text = var_0_2:getNowLang("designsorttype3")
		self._control.order_layer_detail.order4.txt.text.text = var_0_2:getNowLang("designsorttype4")
		self._control.type_layer_detail.type1.txt.text.text = var_0_2:getNowLang("roomdesigntype1")
		self._control.type_layer_detail.type2.txt.text.text = var_0_2:getNowLang("roomdesigntype2")
		self._control.type_layer_detail.type3.txt.text.text = var_0_2:getNowLang("roomdesigntype3")
		self._control.type_layer_detail.type4.txt.text.text = var_0_2:getNowLang("roomdesigntype4")
		self._control.search_layer.bg.title.text.text = var_0_2:getNowLang("searchcontent")
		self._control.search_layer.bg.input.placeholder.text.text = var_0_2:getNowLang("searchcontent")
		self._control.search_layer.bg.confirm_btn.txt.text.text = var_0_2:getNowLang("confirm")
	end

	function arg_1_0.__init_constant(arg_43_0)
		return
	end

	function arg_1_0:__init_reusable_cell()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_design_node", "dormitory_design_list")

			self._reusable_cell:init()
		end

		self._sort_type_list = {
			designsorttype2 = "designsorttype2",
			designsorttype4 = "designsorttype4",
			designsorttype3 = "designsorttype3",
			designsorttype1 = "designsorttype1"
		}
		self._heat_type_list = {
			roomdesigntype2 = "roomdesigntype2",
			roomdesigntype3 = "roomdesigntype3",
			roomdesigntype1 = "roomdesigntype1",
			roomdesigntype4 = "roomdesigntype4"
		}
	end

	function arg_1_0.__onReset(arg_45_0)
		arg_45_0._out = "dormitory_design_list"
		arg_45_0._is_already_init = false
		arg_45_0._confirm_listener = nil
		arg_45_0._sort_type_list = {}
		arg_45_0._heat_type_list = {}
		arg_45_0._now_sort_type = nil
		arg_45_0._now_heat_type = nil
		arg_45_0._now_search_str = nil
		arg_45_0._obj_pool = {}
		arg_45_0._now_design_data_list = {}
		arg_45_0._now_lable = nil
		arg_45_0._exhibition_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_46_0)
	local var_46_0 = var_0_1:class("dormitory_design_list")

	var_46_0._out = "dormitory_design_list"
	var_46_0._is_already_init = false
	var_46_0._reusable_cell = nil
	var_46_0._confirm_listener = nil
	var_46_0._sort_type_list = {}
	var_46_0._heat_type_list = {}
	var_46_0._now_sort_type = nil
	var_46_0._now_heat_type = nil
	var_46_0._now_search_str = nil
	var_46_0._obj_pool = {}
	var_46_0._now_design_data_list = {}
	var_46_0._now_lable = nil
	var_46_0._exhibition_data = {}

	return var_46_0
end

return var_0_0
