local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = table.insert
local var_0_4 = gamecore.Language
local var_0_5 = gamecore.UILoader
local var_0_6 = string.format
local var_0_7 = UnityEngine.Vector3
local var_0_10 = gameenum.common_type
local var_0_11 = gameconfig.item_config
local var_0_12 = gameconfig.furniture_config
local var_0_13 = gameconfig.cook_book_config

gamecore.UILoader:define("item_details_view", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel()
		self:__init_item_details_data(arg_2_1)
		self:__set_cook_book_panel_data()
		self:__set_furniture_panel_data()
	end

	function arg_1_0.set_listener(arg_3_0, arg_3_1)
		arg_3_0._confirm_listener = arg_3_1
	end

	function arg_1_0:update_now_data(arg_4_1)
		self._slidingarea.gameObject:SetActive(false)

		if arg_4_1 == 0 then
			self:__set_cook_book_panel_data()

			self._now_furniture_data = self._furniture_config_table

			self:__set_furniture_panel_data()
		elseif arg_4_1 == var_0_10.shop_const.screen_type_id then
			self:__set_cook_book_panel_data()
			self._now_content.furniture_panel.gameObject:SetActive(false)
			self._now_content.furniture_content.gameObject:SetActive(false)
		else
			self._now_content.cook_panel.gameObject:SetActive(false)
			self._now_content.cook_content.gameObject:SetActive(false)

			self._now_furniture_data = {}

			for iter_4_0, iter_4_1 in pairs(self._furniture_config_table) do
				if var_0_12.find_object_by_cid(iter_4_1).type == tonumber(arg_4_1) then
					var_0_3(self._now_furniture_data, iter_4_1)
				end
			end

			self:__set_furniture_panel_data()
		end
	end

	function arg_1_0:__onUpdate()
		if self._diff_num > 1 then
			self._diff_num = self._diff_num - 0.2
		end

		if self._diff_num < 1 then
			self._diff_num = 1

			if #self._now_furniture_data ~= 0 then
				self._now_content.furniture_panel.gameObject:SetActive(true)
				self._now_content.furniture_content.gameObject:SetActive(true)
			end
		end
	end

	function arg_1_0:__init_language()
		self._control.top_layer.title.text.text = var_0_4:getNowLang("detailinfo")
		self._control.right_layer.type_layer.des.text.text = var_0_4:getNowLang("type")
		self._control.scrollview.viewport.content.cook_panel.icondes.text.text = var_0_4:getNowLang("furnituretype14")
		self._control.scrollview.viewport.content.furniture_panel.icondes.text.text = var_0_4:getNowLang("country9")
		self._now_content = self._control.scrollview.viewport.content
		self._control.type_layer_detail.toggle_group.all.Label.text.text = var_0_4:getNowLang("furnituretype0")

		for iter_6_0 = 1, self._control.type_layer_detail.toggle_group.item_parent.transform.childCount do
			self._control.type_layer_detail.toggle_group.item_parent.transform:GetChild(iter_6_0 - 1):Find("Label"):GetComponent("Text").text = var_0_4:getNowLang("furnituretype" .. iter_6_0)
		end

		self._slidingarea = self._control.scrollview.scrollbarvertical.slidingarea
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
		end

		self:__refesh_sort_text(0)

		local var_7_0 = self._now_content:GetComponent("RectTransform")

		var_7_0.localPosition = var_0_7(var_7_0.localPosition.x, 0, 0)
		self._is_already_init = true
	end

	function arg_1_0:__refesh_sort_text(arg_8_1)
		self._control.right_layer.type_layer.type_des.text.text = var_0_4:getNowLang("furnituretype" .. arg_8_1)
	end

	function arg_1_0:__init_item_details_data(arg_9_1)
		local var_9_0 = var_0_11.find_object_by_cid(arg_9_1)

		self._cook_book_config_table = {}

		for iter_9_0, iter_9_1 in pairs(var_9_0.cookbook) do
			var_0_3(self._cook_book_config_table, iter_9_1)
		end

		self._furniture_config_table = {}

		for iter_9_2, iter_9_3 in pairs(var_9_0.furniture) do
			var_0_3(self._furniture_config_table, iter_9_3)
		end

		self._now_furniture_data = self._furniture_config_table
	end

	function arg_1_0.__sort_config_list_by_star(arg_10_0, arg_10_1)
		var_0_2(arg_10_1, function(arg_11_0, arg_11_1)
			if arg_11_0.star == arg_11_1.star then
				if arg_11_0.type == arg_11_1.type then
					return arg_11_0.cid > arg_11_1.cid
				else
					return arg_11_0.type > arg_11_1.type
				end
			else
				return arg_11_0.star > arg_11_1.star
			end
		end)
	end

	function arg_1_0:__set_cook_book_panel_data()
		self._now_content.cook_panel.gameObject:SetActive(false)
		self._now_content.cook_content.gameObject:SetActive(false)

		if #self._cook_book_config_table == 0 then
			return
		end

		local var_12_0 = {}

		for iter_12_0, iter_12_1 in pairs(self._cook_book_config_table) do
			var_0_3(var_12_0, (var_0_13.find_object_by_cid(iter_12_1)))
		end

		self:__record_furniture_num(#var_12_0)
		self:__sort_config_list_by_star(var_12_0)

		local var_12_1 = self._now_content.cook_content.transform:GetChild(0)

		if #self._cook_book_config_table > self._now_content.cook_content.transform.childCount then
			for iter_12_2 = 1, #self._cook_book_config_table - self._now_content.cook_content.transform.childCount do
				UnityEngine.Object.Instantiate(var_12_1.gameObject, self._now_content.cook_content.transform, false)
			end
		end

		for iter_12_3, iter_12_4 in pairs(var_12_0) do
			local var_12_2 = self._now_content.cook_content.transform:GetChild(iter_12_3 - 1)

			var_12_2.gameObject:SetActive(true)

			if self:__get_cur_cookbook_data(iter_12_4.cid) then
				var_12_2:Find("mask"):Find("icon"):GetComponent("Image").material = nil
				var_12_2:Find("bg"):GetComponent("Image").sprite = self:loadSprite(var_0_10:get_ship_icon(var_0_10.food_quality_s, iter_12_4.star))
				var_12_2:Find("namebg"):GetComponent("Image").sprite = self:loadSprite(var_0_10.common_icon.room_furniture_frame.blue)
			else
				var_12_2:Find("mask"):Find("icon"):GetComponent("Image").material = self:loadMaterial(var_0_10.common_icon.furniture_gray_material)
				var_12_2:Find("bg"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_10.furniture_bg, 1))
				var_12_2:Find("namebg"):GetComponent("Image").sprite = self:loadSprite(var_0_10.common_icon.room_furniture_frame.gray)
			end

			var_12_2:Find("mask"):Find("icon"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_10.cook_book_icon, iter_12_4.icon))
			var_12_2:Find("icon_mask"):Find("icondes"):GetComponent("Text").text = iter_12_4.title

			var_12_2:Find("icon_mask"):GetComponent("TextHorizonScroller"):SetText(iter_12_4.title)
		end

		for iter_12_5 = #self._cook_book_config_table + 1, self._now_content.cook_content.transform.childCount do
			self._now_content.cook_content.transform:GetChild(iter_12_5 - 1).gameObject:SetActive(false)
		end

		self._now_content.cook_panel.gameObject:SetActive(true)
		self._now_content.cook_content.gameObject:SetActive(true)
	end

	function arg_1_0:__set_furniture_panel_data()
		self._diff_num = 2

		self._now_content.furniture_panel.gameObject:SetActive(false)
		self._now_content.furniture_content.gameObject:SetActive(false)

		if #self._now_furniture_data == 0 then
			return
		end

		local var_13_0 = {}

		for iter_13_0, iter_13_1 in pairs(self._now_furniture_data) do
			var_0_3(var_13_0, (var_0_12.find_object_by_cid(iter_13_1)))
		end

		self:__record_furniture_num(#var_13_0)
		self:__sort_config_list_by_star(var_13_0)

		local var_13_1 = self._now_content.furniture_content.transform:GetChild(0)

		if #self._now_furniture_data > self._now_content.furniture_content.transform.childCount then
			for iter_13_2 = 1, #self._now_furniture_data - self._now_content.furniture_content.transform.childCount do
				UnityEngine.Object.Instantiate(var_13_1.gameObject, self._now_content.furniture_content.transform, false)
			end
		end

		for iter_13_3, iter_13_4 in pairs(var_13_0) do
			local var_13_2 = self._now_content.furniture_content.transform:GetChild(iter_13_3 - 1)

			var_13_2.gameObject:SetActive(true)

			if self:__get_cur_furniture_data(iter_13_4.cid) then
				var_13_2:Find("mask"):Find("icon"):GetComponent("Image").material = nil
				var_13_2:Find("bg"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_10.furniture_bg, iter_13_4.star))
				var_13_2:Find("namebg"):GetComponent("Image").sprite = self:loadSprite(var_0_10.common_icon.room_furniture_frame.blue)
			end

			local var_13_3

			do
				var_13_2:Find("mask"):Find("icon"):GetComponent("Image").material = self:loadMaterial(var_0_10.common_icon.furniture_gray_material)
				var_13_2:Find("bg"):GetComponent("Image").sprite = self:loadSprite(var_0_6(var_0_10.furniture_bg, 1))
				var_13_2:Find("namebg"):GetComponent("Image").sprite = self:loadSprite(var_0_10.common_icon.room_furniture_frame.gray)
				var_13_3 = var_13_2:Find("mask"):Find("icon"):GetComponent("Image")
			end

			var_13_3.sprite = self:loadSprite((var_0_10:get_ship_icon(var_0_10.furniture_s_img, iter_13_4.icon)))
			var_13_2:Find("icon_mask"):Find("icondes"):GetComponent("Text").text = iter_13_4.title

			var_13_2:Find("icon_mask"):GetComponent("TextHorizonScroller"):SetText(iter_13_4.title)
		end

		for iter_13_5 = #self._now_furniture_data + 1, self._now_content.furniture_content.transform.childCount do
			self._now_content.furniture_content.transform:GetChild(iter_13_5 - 1).gameObject:SetActive(false)
		end
	end

	function arg_1_0.__set_icon_des_color(arg_14_0, arg_14_1, arg_14_2)
		arg_14_1.color = arg_14_2 > var_0_10.shop_const.star_limit and Color.New(0.043137254901960784, 0.47058823529411764, 0.8) or Color.New(0.38823529411764707, 0.38823529411764707, 0.38823529411764707)
	end

	function arg_1_0.__get_cur_furniture_data(arg_15_0, arg_15_1)
		local var_15_0 = false

		for iter_15_0, iter_15_1 in pairs((var_0_1:get_dormitory_furniture_archive())) do
			if iter_15_0 == arg_15_1 then
				var_15_0 = true
			end
		end

		return var_15_0
	end

	function arg_1_0.__get_cur_cookbook_data(arg_16_0, arg_16_1)
		local var_16_0 = false

		for iter_16_0, iter_16_1 in pairs((var_0_1:get_restaurant_have_cookbook())) do
			if iter_16_1 == arg_16_1 then
				var_16_0 = true
			end
		end

		return var_16_0
	end

	function arg_1_0:__record_furniture_num(arg_17_1)
		if arg_17_1 > var_0_10.shop_const.furniture_min_num then
			self._slidingarea.gameObject:SetActive(true)
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_18_0)
	local var_18_0 = var_0_5:class("item_details_view")

	var_18_0._is_already_init = false
	var_18_0._now_content = nil
	var_18_0._cook_book_config_table = {}
	var_18_0._furniture_config_table = {}
	var_18_0._now_furniture_data = {}
	var_18_0._confirm_listener = nil
	var_18_0._diff_num = 0
	var_18_0._slidingarea = nil
	var_18_0._record_select_type = 0

	return var_18_0
end

return var_0_0
