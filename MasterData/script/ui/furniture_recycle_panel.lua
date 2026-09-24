local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.getn
local var_0_3 = gamecore.prompt
local var_0_4 = table.remove
local var_0_5 = table.insert
local var_0_6 = gamecore.Language
local var_0_7 = gamecore.UILoader
local var_0_8 = string.format
local var_0_9 = gamecore.util_func
local var_0_10 = gameenum.common_type
local var_0_11 = gameconfig.furniture_config

gamecore.UILoader:define("furniture_recycle_panel", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__set_recycle_furniture_data(arg_2_1)
		self:__init_panel()
	end

	function arg_1_0.play_bg_in_animation(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		if arg_3_2 then
			arg_3_1.uITweenSequence:Play(function()
				if arg_3_3 then
					arg_3_3()
				end
			end)
		else
			arg_3_1.uITweenSequence:PlayReverse(function()
				if arg_3_3 then
					arg_3_3()
				end
			end)
		end
	end

	function arg_1_0:update_furniture_recycle_handle_data()
		local var_6_0 = var_0_7:getInstance("dorm_warehouse")

		if var_6_0 then
			self:__set_recycle_furniture_data((var_6_0:get_curr_furniture_total_data()))
			var_0_7:createInstance("furniture_point_view"):show(self._now_fur_point)
			self:update_furniture_recycle_data()
		end
	end

	function arg_1_0:update_furniture_recycle_data()
		self:__init_furniture_point_data()
		self:update_recycle_screen_data()
	end

	function arg_1_0:__onUpdate()
		self._reusable_cell:update()
	end

	function arg_1_0:update_recycle_screen_data()
		if not self._furniture_recycle_sever_data then
			return
		end

		local var_9_0 = var_0_7:getInstance("dorm_warehouse")

		if self._now_type == var_0_10.furniture_type.All then
			self._furniture_recycle_list_data = self._furniture_recycle_sever_data

			var_9_0:get_origin_data(self._now_order, self._furniture_recycle_list_data)
		else
			self._furniture_recycle_list_data = {}

			for iter_9_0, iter_9_1 in pairs(self._furniture_recycle_sever_data) do
				if var_0_11.find_object_by_cid(iter_9_1.cid).type == self._now_type then
					var_0_5(self._furniture_recycle_list_data, iter_9_1)
				end
			end

			var_9_0:get_origin_data(self._now_order, self._furniture_recycle_list_data)
		end

		self:__update_cell()
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_furniture_recycle_list()
		end

		self:__set_sort_data()
		self:update_furniture_recycle_data()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.top_layer.title.text.text = var_0_6:getNowLang("ui_furniture_dismantle")
		self._control.top_layer.des.text.text = var_0_6:getNowLang("ui_furniture_dismantle_select")
		self._control.furniture_layer.furniture_des.text.text = var_0_6:getNowLang("ui_furniture_dismantle_get1")
		self._control.order_layer.des.text.text = var_0_6:getNowLang("ui_teamtip2")
		self._control.type_layer.des.text.text = var_0_6:getNowLang("ui_collectionviewtip")
		self._control.type_layer.type_des.text.text = var_0_6:getNowLang("trophytype0")
		self._control.confirm_btn.des.text.text = var_0_6:getNowLang("confirm")
		self._control.fast_choose_btn.des.text.text = var_0_6:getNowLang("all_select")
		self._type_toggle_group = self._control.type_layer_detail.parent.toggle_group

		for iter_11_0 = 0, self._type_toggle_group.transform.childCount - 1 do
			self._type_toggle_group.transform:GetChild(iter_11_0):Find("Label"):GetComponent("Text").text = var_0_6:getNowLang("furnituretype" .. iter_11_0)
		end

		self._order_toggle_group = {
			self._control.order_layer_detail.parent.toggle_group.to_1,
			self._control.order_layer_detail.parent.toggle_group.to_2,
			self._control.order_layer_detail.parent.toggle_group.to_3,
			self._control.order_layer_detail.parent.toggle_group.to_4,
			self._control.order_layer_detail.parent.toggle_group.to_5
		}

		for iter_11_1, iter_11_2 in pairs(self._order_toggle_group) do
			iter_11_2.Label.text.text = var_0_6:getNowLang("furnituresorttype" .. iter_11_1)
		end
	end

	function arg_1_0:__init_furniture_point_data()
		self._control.res_node.diamond_num.text.text = var_0_1:get_use_info_data().furniture_point
		self._select_furniture_list = {}
		self._now_fur_point = 0

		self:__show_fur_point_add_data()
	end

	function arg_1_0:__show_fur_point_add_data()
		self._control.top_layer.fur_num.text.text = var_0_8("%s/%s", var_0_2(self._select_furniture_list), var_0_10.max_select_type.forty)
		self._control.furniture_layer.amount_txt.text.text = self._now_fur_point
	end

	function arg_1_0:__init_furniture_recycle_list()
		self._reusable_cell = gamecore.reusable_cell:create(self, self._control.scrollview.viewport.content.endlessScrollView, self._control.scrollview.viewport.content, "single_furniture", "furniture_recycle_panel")

		self._reusable_cell:init()
	end

	function arg_1_0:__update_cell()
		local var_15_0 = self._furniture_recycle_list_data

		if self._is_already_init then
			self._reusable_cell:set_data(self._furniture_recycle_list_data, true)
		else
			self._reusable_cell:set_data(self._furniture_recycle_list_data)
		end

		function self._reusable_cell:_set_func(arg_16_1)
			self.put_dorm:SetActive(false)
			self.lock:SetActive(false)

			self.bg.image.raycastTarget = true

			local var_16_0 = var_0_11.find_object_by_cid(var_15_0[arg_16_1 + 1].cid)

			self.bg.image.sprite = self:loadSprite((var_0_8(var_0_10.furniture_bg, (var_16_0.star > 0 or nil) and (var_16_0.star or 1))))
			self.bg.icon.image.sprite = self:loadSprite((var_0_10:get_ship_icon(var_0_10.furniture_s_img, var_16_0.icon)))
			self.frame.image.sprite = self:loadSprite(var_0_10.common_icon.room_furniture_frame.blue)

			local var_16_1 = self.name_mask:GetComponent(typeof(TextScroller))

			if tostring(self.name_mask.name_txt.text.text) ~= tostring(var_16_0.title) then
				self.name_mask.name_txt_1.text.text = ""

				var_16_1:SetText(var_16_0.title)

				var_16_1.deltaLength = var_0_10.dormitory_const.text_interval
				var_16_1.scrollSpeed = var_0_10.dormitory_const.scroll_speed
			end

			self.bg.button.onClick:RemoveAllListeners()
			self.bg.button.onClick:AddListener(function()
				self:__set_select_furniture_data(var_15_0[arg_16_1 + 1].id, var_16_0)
			end)

			local var_16_2, var_16_3 = self:__get_cur_furniture_state(var_15_0[arg_16_1 + 1].id)

			self.select.num.text.text = var_16_3

			self.select:SetActive(var_16_2)
		end
	end

	function arg_1_0:fast_choose_furniture()
		for iter_18_0, iter_18_1 in pairs(self._furniture_recycle_list_data) do
			if not var_0_9.have_data(self._select_furniture_list, iter_18_1.id) and var_0_2(self._select_furniture_list) < var_0_10.max_select_type.forty then
				var_0_5(self._select_furniture_list, iter_18_1.id)

				self._now_fur_point = self._now_fur_point + var_0_10:get_furniture_point_by_star(var_0_11.find_object_by_cid(iter_18_1.cid).star)
			end
		end
	end

	function arg_1_0:__get_cur_furniture_state(arg_19_1)
		local var_19_0 = false
		local var_19_1 = 0

		for iter_19_0, iter_19_1 in pairs(self._select_furniture_list) do
			if iter_19_1 == arg_19_1 then
				var_19_1 = iter_19_0
				var_19_0 = true
			end
		end

		return var_19_0, var_19_1
	end

	function arg_1_0:__set_select_furniture_data(arg_20_1, arg_20_2)
		local var_20_0 = self:__get_index_by_id(arg_20_1)
		local var_20_1 = var_0_10:get_furniture_point_by_star(arg_20_2.star)

		if var_20_0 then
			var_0_4(self._select_furniture_list, var_20_0)

			self._now_fur_point = self._now_fur_point - var_20_1
		else
			if var_0_2(self._select_furniture_list) >= var_0_10.max_select_type.forty then
				var_0_3:show(var_0_8(var_0_6:getNowLang("selectstrenmaterialmax"), var_0_10.max_select_type.forty))

				return
			end

			var_0_5(self._select_furniture_list, arg_20_1)

			self._now_fur_point = self._now_fur_point + var_20_1
		end

		self:__update_cell()
		self:__show_fur_point_add_data()
	end

	function arg_1_0:__get_index_by_id(arg_21_1)
		local var_21_0

		for iter_21_0, iter_21_1 in pairs(self._select_furniture_list) do
			if iter_21_1 == arg_21_1 then
				var_21_0 = iter_21_0

				break
			end
		end

		return var_21_0
	end

	function arg_1_0:__set_sort_data()
		self._now_type = var_0_10.furniture_type.All
		self._now_order = var_0_10.order_sort.one
		self._control.order_layer.type_des.text.text = var_0_6:getNowLang("furnituresorttype_s1")
		self._control.type_layer.type_des.text.text = var_0_6:getNowLang("trophytype0")

		self:__reset_toggle_state()
	end

	function arg_1_0:__reset_toggle_state()
		for iter_23_0, iter_23_1 in pairs(self._order_toggle_group) do
			iter_23_1.toggle.isOn = iter_23_0 == 1
		end
	end

	function arg_1_0:__set_recycle_furniture_data(arg_24_1)
		self._furniture_recycle_sever_data = {}

		for iter_24_0, iter_24_1 in pairs(arg_24_1) do
			if not iter_24_1.lock then
				var_0_5(self._furniture_recycle_sever_data, iter_24_1)
			end
		end

		self:__check_furniture_data()
	end

	function arg_1_0:__check_furniture_data()
		local var_25_0 = var_0_7:getInstance("dorm_warehouse"):get_recycle_furniture_data()

		if #var_25_0 ~= 0 then
			for iter_25_0, iter_25_1 in pairs(var_25_0) do
				for iter_25_2, iter_25_3 in pairs(self._furniture_recycle_sever_data) do
					if iter_25_1.id == iter_25_3.id then
						var_0_4(self._furniture_recycle_sever_data, iter_25_2)
					end
				end
			end
		end
	end

	function arg_1_0:__reset_recycle_scroll_view_position()
		self._control.scrollview.viewport.content.transform.localPosition = Vector2(self._control.scrollview.viewport.content.transform.localPosition.x, 0)
	end

	function arg_1_0.__onReset(arg_27_0)
		arg_27_0._is_already_init = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_28_0)
	local var_28_0 = var_0_7:class("furniture_recycle_panel")

	var_28_0._is_already_init = nil
	var_28_0._reusable_cell = nil
	var_28_0._furniture_recycle_list_data = {}
	var_28_0._select_furniture_list = {}
	var_28_0._now_fur_point = 0
	var_28_0._type_toggle_group = nil
	var_28_0._order_toggle_group = nil
	var_28_0._now_type = nil
	var_28_0._now_order = nil
	var_28_0._furniture_recycle_sever_data = {}

	return var_28_0
end

return var_0_0
