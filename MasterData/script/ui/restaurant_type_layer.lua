local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = table.sort
local var_0_3 = gamecore.prompt
local var_0_4 = table.insert
local var_0_5 = gamecore.Language
local var_0_6 = gamecore.UILoader
local var_0_9 = gameenum.common_type
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.cook_book_config
local var_0_12 = {
	have_set = "have_set",
	no_use = "no_use",
	no_have = "no_have",
	have = "have"
}
local var_0_13 = {
	other_country = 2,
	general_country = 3,
	my_country = 1
}

gamecore.UILoader:define("restaurant_type_layer", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:show(arg_3_1)
		self:setVisible(true)
		self:__init_panel(arg_3_1)
	end

	function arg_1_0:__init_panel(arg_4_1)
		var_0_1:set_cook_common_state(true)

		if not self._is_already_init then
			self:__init_language()
			self:init_cell()
			self:__init_style_group_list()
		end

		self:set_chef_by_id()
		self:update_cookbook_list()
		self:__onToggle_country_layer_toggle_group_all()
	end

	function arg_1_0:__init_language()
		self._control.top.title_txt.text.text = var_0_5:getNowLang("cookbook_record")
		self._control.menu_list.type_btn.txt.text.text = var_0_5:getNowLang("countrytype") .. var_0_5:getNowLang("country0")
		self._control.country_layer.toggle_group.all.Label.text.text = var_0_5:getNowLang("country0")
		self._control.country_layer.toggle_group.J_country.Label.text.text = var_0_5:getNowLang("country1")
		self._control.country_layer.toggle_group.G_country.Label.text.text = var_0_5:getNowLang("country2")
		self._control.country_layer.toggle_group.E_country.Label.text.text = var_0_5:getNowLang("country3")
		self._control.country_layer.toggle_group.U_country.Label.text.text = var_0_5:getNowLang("country4")
		self._control.country_layer.toggle_group.I_country.Label.text.text = var_0_5:getNowLang("country5")
		self._control.country_layer.toggle_group.F_country.Label.text.text = var_0_5:getNowLang("country6")
		self._control.country_layer.toggle_group.S_country.Label.text.text = var_0_5:getNowLang("country7")
		self._control.country_layer.toggle_group.C_country.Label.text.text = var_0_5:getNowLang("country8")
		self._control.country_layer.toggle_group.general.Label.text.text = var_0_5:getNowLang("country99")
		self._control.country_layer.toggle_group.get.Label.text.text = var_0_5:getNowLang("medaltypegain")
		self._control.country_layer.toggle_group.not_get.Label.text.text = var_0_5:getNowLang("nothave")
		self._control.country_layer.toggle_group.can_set.Label.text.text = var_0_5:getNowLang("canset")
	end

	function arg_1_0:init_cell()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.menu_list.scrollview.viewport.content.endlessScrollView, self._control.menu_list.scrollview.viewport.content, "single_food_cell", "restaurant_type_layer")

			self._reusable_cell:init()
		end
	end

	function arg_1_0:update_cookbook_list()
		self._control.menu_list.scrollview.viewport.content.rectTransform.anchoredPosition = Vector2(self._control.menu_list.scrollview.viewport.content.rectTransform.anchoredPosition.x, 0)

		local var_7_0 = self:filtrate_cookbook_list()
		local var_7_1 = var_0_1:get_restaurant_use_cookbook()

		self._reusable_cell:set_data(var_7_0)

		function self._reusable_cell:_set_func(arg_8_1)
			local var_8_0 = var_7_0[arg_8_1 + 1]

			self.food_quality.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.food_quality_s, var_7_0[arg_8_1 + 1].star))
			self.icon.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.cook_book_icon, var_7_0[arg_8_1 + 1].icon))

			self:set_cookbook_lable(self, var_7_0[arg_8_1 + 1], var_7_1)

			self.country_bg.country.text.text = var_0_5:getNowLang(var_0_9:get_country_language_key(var_7_0[arg_8_1 + 1].country))
			self.name_txt.text.text = var_7_0[arg_8_1 + 1].title
			self.type_txt.text.text = var_7_0[arg_8_1 + 1].effect_desc2
			self.buff_txt.text.text = self:get_txt(var_7_0[arg_8_1 + 1].effect_desc3)

			self.food_quality.button.onClick:RemoveAllListeners()
			self.food_quality.button.onClick:AddListener(function()
				if var_8_0.state == "no_have" then
					var_0_3:show(var_0_5:getNowLang("errorcode_280"))

					return
				end

				local var_9_0 = var_0_6:getInstance("select_member")

				if var_9_0 then
					self:setVisible(false)
					var_9_0:show_by_type(var_0_9.enter_select_member_type.restaurant_show_type, nil, nil, nil, nil, nil, nil, var_8_0)
				else
					self:setVisible(false)
					var_0_6:createInstance("select_member"):show_by_type(var_0_9.enter_select_member_type.restaurant_show_type, nil, nil, nil, nil, nil, nil, var_8_0)
				end
			end)
		end
	end

	function arg_1_0:__init_style_group_list()
		self._toggle_style_group = {
			all = self._control.country_layer.toggle_group.all,
			J_country = self._control.country_layer.toggle_group.J_country,
			G_country = self._control.country_layer.toggle_group.G_country,
			E_country = self._control.country_layer.toggle_group.E_country,
			U_country = self._control.country_layer.toggle_group.U_country,
			I_country = self._control.country_layer.toggle_group.I_country,
			F_country = self._control.country_layer.toggle_group.F_country,
			S_country = self._control.country_layer.toggle_group.S_country,
			C_country = self._control.country_layer.toggle_group.C_country,
			general = self._control.country_layer.toggle_group.general,
			get = self._control.country_layer.toggle_group.get,
			not_get = self._control.country_layer.toggle_group.not_get,
			can_set = self._control.country_layer.toggle_group.can_set
		}
	end

	function arg_1_0.get_txt(arg_11_0, arg_11_1)
		return (string.gsub(arg_11_1, "%^C[^%^]+", function(arg_12_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_12_0, 3, 10), (string.sub(arg_12_0, 19, #arg_12_0)))
		end))
	end

	function arg_1_0:show_country_layer(arg_13_1)
		self._control.country_layer:SetActive(arg_13_1)
	end

	function arg_1_0:set_cookbook_lable(arg_14_1, arg_14_2, arg_14_3)
		if arg_14_2.state == var_0_12.have then
			arg_14_1.cover:SetActive(false)
		elseif arg_14_2.state == var_0_12.have_set then
			arg_14_1.cover.image.sprite = self:loadSprite(var_0_9.restaurant_const.used)
			arg_14_1.cover.tip.text.text = var_0_5:getNowLang("setted")

			arg_14_1.cover:SetActive(true)
		elseif arg_14_2.state == var_0_12.no_use then
			arg_14_1.cover:SetActive(false)
		elseif arg_14_2.state == var_0_12.no_have then
			arg_14_1.cover.image.sprite = self:loadSprite(var_0_9.restaurant_const.unhave)
			arg_14_1.cover.tip.text.text = var_0_5:getNowLang("nothave")

			arg_14_1.cover:SetActive(true)
		end
	end

	function arg_1_0._have_data(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = false

		if arg_15_1 and next(arg_15_1) then
			for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
				if iter_15_1.id == arg_15_2 then
					var_15_0 = true

					return true
				end
			end
		end

		return var_15_0
	end

	function arg_1_0.set_cookbook_layer(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
		var_0_6:createInstance("restaurant_cookinfo"):show(1, arg_16_2, arg_16_1, arg_16_3)
	end

	function arg_1_0:set_cookbook_info(arg_17_1, arg_17_2)
		local var_17_0 = var_0_11.find_object_by_cid(arg_17_1)

		arg_17_2.food_quality.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.food_quality, var_17_0.star))
		arg_17_2.food_quality.food_small.image.sprite = self:loadSprite(var_0_9:get_format_url(var_0_9.cook_book_icon, var_17_0.icon))

		local var_17_1 = var_0_1:get_exp_by_id(arg_17_1)

		if var_17_1 > 100 then
			var_17_1 = 100
		end

		arg_17_2.progress.exp_text.text.text = tostring(var_17_1) .. " / 100"
	end

	function arg_1_0.sort_rule(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_2 == 1 then
			var_0_2(arg_18_1, function(arg_19_0, arg_19_1)
				return arg_19_0.cid < arg_19_1.cid
			end)
		else
			var_0_2(arg_18_1, function(arg_20_0, arg_20_1)
				if arg_20_0.country == arg_20_1.country then
					return arg_20_0.cid < arg_20_1.cid
				else
					return arg_20_0.country < arg_20_1.country
				end
			end)
		end

		return arg_18_1
	end

	function arg_1_0:set_chef_by_id()
		self._now_chef_id = var_0_1:get_use_info_data().chef
		self._now_chef_country = var_0_10.find_object_by_cid(var_0_1:find_character_by_id(self._now_chef_id).cid).country
	end

	function arg_1_0:init_cookbook_list()
		local var_22_0 = var_0_1:get_restaurant_have_cookbook()

		self._cookbook_list = var_22_0

		local var_22_1, var_22_2 = var_0_11.get_sequence()
		local var_22_3 = {}
		local var_22_4 = {}
		local var_22_5 = {}
		local var_22_6 = {}
		local var_22_7 = {}
		local var_22_8 = {}
		local var_22_11 = {}

		for iter_22_0, iter_22_1 in pairs(var_22_1) do
			iter_22_1.state = var_0_12.no_have

			if iter_22_1.country == self._now_chef_country then
				iter_22_1.country_state = var_0_13.my_country

				var_0_4(var_22_4, iter_22_1)
			elseif iter_22_1.country == var_0_9.country_type_rule.general.value then
				iter_22_1.country_state = var_0_13.general_country

				var_0_4(var_22_5, iter_22_1)
			else
				iter_22_1.country_state = var_0_13.other_country

				var_0_4(var_22_6, iter_22_1)
			end
		end

		for iter_22_2, iter_22_3 in ipairs(var_22_0) do
			local var_22_13 = var_0_11.find_object_by_cid(iter_22_3)

			if var_22_13.country == self._now_chef_country then
				var_22_13.state = var_0_12.have

				var_0_4(var_22_7, var_22_13)
			elseif var_22_13.country == var_0_9.country_type_rule.general.value then
				var_22_13.state = var_0_12.have

				var_0_4(var_22_8, var_22_13)
			else
				var_22_13.state = var_0_12.no_use

				var_0_4(var_22_11, var_22_13)
			end
		end

		local var_22_14 = self:cookbook_have_set(var_22_7)
		local var_22_15 = self:cookbook_have_set(var_22_8)

		for iter_22_4, iter_22_5 in ipairs({
			self:sort_rule(var_22_14, 1),
			self:sort_rule(var_22_15, 1),
			self:sort_rule(self:contrast_tab(var_22_4, var_22_14), 1),
			self:sort_rule(self:contrast_tab(var_22_5, var_22_15), 1),
			self:sort_rule(var_22_11, 2),
			(self:sort_rule(self:contrast_tab(var_22_6, var_22_11), 2))
		}) do
			for iter_22_6, iter_22_7 in ipairs(iter_22_5) do
				var_0_4(var_22_3, iter_22_7)
			end
		end

		return var_22_3
	end

	function arg_1_0:filtrate_cookbook_list()
		local var_23_0 = self:init_cookbook_list()
		local var_23_1 = {}

		if self._style_toggle_data[1] == "all" then
			var_23_1 = self:proficiency_sort_rule(var_23_0)
		elseif self._style_toggle_data[1] == "general" then
			for iter_23_0, iter_23_1 in ipairs(var_23_0) do
				if iter_23_1.country_state == var_0_13.general_country then
					var_0_4(var_23_1, iter_23_1)
				end
			end
		elseif self._style_toggle_data[1] == "get" then
			for iter_23_2, iter_23_3 in ipairs(var_23_0) do
				if iter_23_3.state == var_0_12.have or iter_23_3.state == var_0_12.have_set or iter_23_3.state == var_0_12.no_use then
					var_0_4(var_23_1, iter_23_3)
				end
			end
		elseif self._style_toggle_data[1] == "not_get" then
			for iter_23_4, iter_23_5 in ipairs(var_23_0) do
				if iter_23_5.state == var_0_12.no_have then
					var_0_4(var_23_1, iter_23_5)
				end
			end
		elseif self._style_toggle_data[1] == "can_set" then
			for iter_23_6, iter_23_7 in ipairs(var_23_0) do
				if iter_23_7.state == var_0_12.have or iter_23_7.state == var_0_12.have_set or iter_23_7.country_state == var_0_13.my_country or iter_23_7.country_state == var_0_13.general_country then
					var_0_4(var_23_1, iter_23_7)
				end
			end
		else
			for iter_23_8, iter_23_9 in ipairs(var_23_0) do
				if iter_23_9.country == var_0_9.filter_country[self._style_toggle_data[1]] then
					var_0_4(var_23_1, iter_23_9)
				end
			end
		end

		return var_23_1
	end

	function arg_1_0:proficiency_sort_rule(arg_24_1)
		local var_24_0 = {}
		local var_24_1 = {}

		for iter_24_0, iter_24_1 in pairs(arg_24_1) do
			if iter_24_1.state == var_0_12.have then
				var_0_4(var_24_0, iter_24_1)
			else
				var_0_4(var_24_1, iter_24_1)
			end
		end

		var_0_2(var_24_0, function(arg_25_0, arg_25_1)
			local var_25_0 = var_0_1:get_restaurant_the_cook_cookbook(arg_25_0.cid)
			local var_25_1 = var_0_1:get_restaurant_the_cook_cookbook(arg_25_1.cid)

			if var_25_0 == var_25_1 then
				return arg_25_0.country < arg_25_1.country
			end

			return var_25_1 < var_25_0
		end)

		local var_24_2 = var_0_1:get_use_info_data()
		local var_24_3 = var_0_1:get_restaurant_use_cookbook()

		for iter_24_2, iter_24_3 in pairs(var_24_1) do
			var_0_4(var_24_0, iter_24_3)
		end

		local var_24_4 = {}

		for iter_24_4, iter_24_5 in ipairs(var_24_0) do
			if iter_24_5.state == "no_have" then
				var_0_4(var_24_4, iter_24_5)
				table.remove(var_24_0, iter_24_4)
			end
		end

		for iter_24_6, iter_24_7 in ipairs(var_24_0) do
			if iter_24_7.state == "no_have" then
				var_0_4(var_24_4, iter_24_7)
				table.remove(var_24_0, iter_24_6)
			end
		end

		for iter_24_8, iter_24_9 in ipairs(var_24_0) do
			if iter_24_9.state == "no_have" then
				var_0_4(var_24_4, iter_24_9)
				table.remove(var_24_0, iter_24_8)
			end
		end

		if var_24_3 and next(var_24_3) then
			for iter_24_10, iter_24_11 in ipairs(var_24_0) do
				if self:__have_data(var_24_3, iter_24_11.cid) then
					table.remove(var_24_0, iter_24_10)
				end
			end

			for iter_24_12, iter_24_13 in ipairs(var_24_0) do
				if self:__have_data(var_24_3, iter_24_13.cid) then
					table.remove(var_24_0, iter_24_12)
				end
			end

			for iter_24_14, iter_24_15 in ipairs(var_24_3) do
				var_0_4(var_24_0, iter_24_14, (var_0_11.find_object_by_cid(iter_24_15.id)))
			end
		end

		if var_24_4 and next(var_24_4) then
			for iter_24_16, iter_24_17 in ipairs(var_24_4) do
				var_0_4(var_24_0, iter_24_17)
			end
		end

		return var_24_0
	end

	function arg_1_0.__have_data(arg_26_0, arg_26_1, arg_26_2)
		local var_26_0 = false

		for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
			if iter_26_1.id == arg_26_2 then
				var_26_0 = true

				return true
			end
		end

		return var_26_0
	end

	function arg_1_0.cookbook_have_set(arg_27_0, arg_27_1)
		for iter_27_0, iter_27_1 in pairs((var_0_1:get_restaurant_use_cookbook())) do
			for iter_27_2, iter_27_3 in pairs(arg_27_1) do
				if iter_27_1.id == iter_27_3.cid then
					iter_27_3.state = var_0_12.have_set
				end
			end
		end

		return arg_27_1
	end

	function arg_1_0.contrast_tab(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_1) do
			local var_28_1 = false

			for iter_28_2, iter_28_3 in pairs(arg_28_2) do
				if iter_28_1.cid == iter_28_3.cid then
					var_28_1 = true
				end
			end

			if not var_28_1 then
				var_0_4(var_28_0, iter_28_1)
			end
		end

		return var_28_0
	end

	function arg_1_0:__onReset()
		self:__initia_lize()
	end

	function arg_1_0.__initia_lize(arg_30_0)
		arg_1_0._now_chef_id = nil
		arg_1_0._is_already_init = false
		arg_1_0._reusable_cell = nil
		arg_1_0._style_toggle_data = {
			"all"
		}
		arg_1_0._toggle_style_group = nil
		arg_1_0._now_chef_country = nil
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_6:class("restaurant_type_layer")

	var_31_0:__initia_lize()

	var_31_0._now_chef_id = nil
	var_31_0._is_already_init = false
	var_31_0._reusable_cell = nil
	var_31_0._style_toggle_data = {
		"all"
	}
	var_31_0._toggle_style_group = nil
	var_31_0._now_chef_country = nil

	return var_31_0
end

return var_0_0
