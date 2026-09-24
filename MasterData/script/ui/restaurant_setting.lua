local var_0_0 = {}
local var_0_1 = gamecore.user
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameconfig.cook_book_config
local var_0_9 = table.sort
local var_0_10 = table.insert
local var_0_11 = gamecore.util_func
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

gamecore.UILoader:define("restaurant_setting", function(arg_1_0)
	function arg_1_0:show()
		self:setVisible(true)
		self:__init_panel()
	end

	function arg_1_0:__onUpdate()
		if self._reusable_cell then
			self._reusable_cell:update()
		end
	end

	function arg_1_0:set_love(arg_4_1, arg_4_2)
		self._control.cooker.marry_icon.image.sprite = self:loadSprite((var_0_4:get_love_path({
			marry = arg_4_2,
			love = arg_4_1
		})))
	end

	function arg_1_0:init_cell()
		if not self._reusable_cell then
			self._reusable_cell = gamecore.reusable_cell:create(self, self._control.menu_list.scrollview.viewport.content.endlessScrollView, self._control.menu_list.scrollview.viewport.content, "single_food_cell", "restaurant_setting")

			self._reusable_cell:init()
		end
	end

	function arg_1_0.contrast_tab(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs(arg_6_1) do
			local var_6_1 = false

			for iter_6_2, iter_6_3 in pairs(arg_6_2) do
				if iter_6_1.cid == iter_6_3.cid then
					var_6_1 = true
				end
			end

			if not var_6_1 then
				var_0_10(var_6_0, iter_6_1)
			end
		end

		return var_6_0
	end

	function arg_1_0.sort_rule(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_2 == 1 then
			var_0_9(arg_7_1, function(arg_8_0, arg_8_1)
				return arg_8_0.cid < arg_8_1.cid
			end)
		else
			var_0_9(arg_7_1, function(arg_9_0, arg_9_1)
				if arg_9_0.country == arg_9_1.country then
					return arg_9_0.cid < arg_9_1.cid
				else
					return arg_9_0.country < arg_9_1.country
				end
			end)
		end

		return arg_7_1
	end

	function arg_1_0.proficiency_sort_rule(arg_10_0, arg_10_1)
		local var_10_0 = {}
		local var_10_1 = {}

		for iter_10_0, iter_10_1 in pairs(arg_10_1) do
			if iter_10_1.state == var_0_12.have then
				var_0_10(var_10_0, iter_10_1)
			else
				var_0_10(var_10_1, iter_10_1)
			end
		end

		var_0_9(var_10_0, function(arg_11_0, arg_11_1)
			local var_11_0 = var_0_1:get_restaurant_the_cook_cookbook(arg_11_0.cid)
			local var_11_1 = var_0_1:get_restaurant_the_cook_cookbook(arg_11_1.cid)

			if var_11_0 == var_11_1 then
				return arg_11_0.country < arg_11_1.country
			end

			return var_11_1 < var_11_0
		end)

		for iter_10_2, iter_10_3 in pairs(var_10_1) do
			var_0_10(var_10_0, iter_10_3)
		end

		return var_10_0
	end

	function arg_1_0.cookbook_have_set(arg_12_0, arg_12_1)
		for iter_12_0, iter_12_1 in pairs((var_0_1:get_restaurant_use_cookbook())) do
			for iter_12_2, iter_12_3 in pairs(arg_12_1) do
				if iter_12_1.id == iter_12_3.cid then
					iter_12_3.state = var_0_12.have_set
				end
			end
		end

		return arg_12_1
	end

	function arg_1_0:init_cookbook_list()
		local var_13_0 = var_0_1:get_restaurant_have_cookbook()

		self._cookbook_list = var_13_0

		local var_13_1, var_13_2 = var_0_7.get_sequence()
		local var_13_3 = {}
		local var_13_4 = {}
		local var_13_5 = {}
		local var_13_6 = {}
		local var_13_7 = {}
		local var_13_8 = {}
		local var_13_11 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_1) do
			iter_13_1.state = var_0_12.no_have

			if iter_13_1.country == self._now_chef_country then
				iter_13_1.country_state = var_0_13.my_country

				var_0_10(var_13_4, iter_13_1)
			elseif iter_13_1.country == var_0_4.country_type_rule.general.value then
				iter_13_1.country_state = var_0_13.general_country

				var_0_10(var_13_5, iter_13_1)
			else
				iter_13_1.country_state = var_0_13.other_country

				var_0_10(var_13_6, iter_13_1)
			end
		end

		for iter_13_2, iter_13_3 in ipairs(var_13_0) do
			local var_13_13 = var_0_7.find_object_by_cid(iter_13_3)

			if var_13_13.country == self._now_chef_country then
				var_13_13.state = var_0_12.have

				var_0_10(var_13_7, var_13_13)
			elseif var_13_13.country == var_0_4.country_type_rule.general.value then
				var_13_13.state = var_0_12.have

				var_0_10(var_13_8, var_13_13)
			else
				var_13_13.state = var_0_12.no_use

				var_0_10(var_13_11, var_13_13)
			end
		end

		local var_13_14 = self:cookbook_have_set(var_13_7)
		local var_13_15 = self:cookbook_have_set(var_13_8)

		for iter_13_4, iter_13_5 in ipairs({
			self:sort_rule(var_13_14, 1),
			self:sort_rule(var_13_15, 1),
			self:sort_rule(self:contrast_tab(var_13_4, var_13_14), 1),
			self:sort_rule(self:contrast_tab(var_13_5, var_13_15), 1),
			self:sort_rule(var_13_11, 2),
			(self:sort_rule(self:contrast_tab(var_13_6, var_13_11), 2))
		}) do
			for iter_13_6, iter_13_7 in ipairs(iter_13_5) do
				var_0_10(var_13_3, iter_13_7)
			end
		end

		return var_13_3
	end

	function arg_1_0:filtrate_cookbook_list()
		local var_14_0 = self:init_cookbook_list()
		local var_14_1 = {}

		if self._style_toggle_data[1] == "all" then
			var_14_1 = self:proficiency_sort_rule(var_14_0)
		elseif self._style_toggle_data[1] == "general" then
			for iter_14_0, iter_14_1 in ipairs(var_14_0) do
				if iter_14_1.country_state == var_0_13.general_country then
					var_0_10(var_14_1, iter_14_1)
				end
			end
		elseif self._style_toggle_data[1] == "get" then
			for iter_14_2, iter_14_3 in ipairs(var_14_0) do
				if iter_14_3.state == var_0_12.have or iter_14_3.state == var_0_12.have_set or iter_14_3.state == var_0_12.no_use then
					var_0_10(var_14_1, iter_14_3)
				end
			end
		elseif self._style_toggle_data[1] == "not_get" then
			for iter_14_4, iter_14_5 in ipairs(var_14_0) do
				if iter_14_5.state == var_0_12.no_have then
					var_0_10(var_14_1, iter_14_5)
				end
			end
		elseif self._style_toggle_data[1] == "can_set" then
			for iter_14_6, iter_14_7 in ipairs(var_14_0) do
				if iter_14_7.state == var_0_12.have or iter_14_7.state == var_0_12.have_set or iter_14_7.country_state == var_0_13.my_country or iter_14_7.country_state == var_0_13.general_country then
					var_0_10(var_14_1, iter_14_7)
				end
			end
		else
			for iter_14_8, iter_14_9 in ipairs(var_14_0) do
				if iter_14_9.country == var_0_4.filter_country[self._style_toggle_data[1]] then
					var_0_10(var_14_1, iter_14_9)
				end
			end
		end

		return var_14_1
	end

	function arg_1_0.get_txt(arg_15_0, arg_15_1)
		return (string.gsub(arg_15_1, "%^C[^%^]+", function(arg_16_0)
			return string.format("<color=#%s>%s</color>", string.sub(arg_16_0, 3, 10), (string.sub(arg_16_0, 19, #arg_16_0)))
		end))
	end

	function arg_1_0:set_cookbook_lable(arg_17_1, arg_17_2)
		if arg_17_2.state == var_0_12.have then
			arg_17_1.cover:SetActive(false)
		elseif arg_17_2.state == var_0_12.have_set then
			arg_17_1.cover.image.sprite = self:loadSprite(var_0_4.restaurant_const.used)
			arg_17_1.cover.tip.text.text = var_0_2:getNowLang("setted")

			arg_17_1.cover:SetActive(true)
		elseif arg_17_2.state == var_0_12.no_use then
			arg_17_1.cover.image.sprite = self:loadSprite(var_0_4.restaurant_const.unuse)
			arg_17_1.cover.tip.text.text = var_0_2:getNowLang("disable")

			arg_17_1.cover:SetActive(true)
		elseif arg_17_2.state == var_0_12.no_have then
			arg_17_1.cover.image.sprite = self:loadSprite(var_0_4.restaurant_const.unhave)
			arg_17_1.cover.tip.text.text = var_0_2:getNowLang("nothave")

			arg_17_1.cover:SetActive(true)
		end
	end

	function arg_1_0:update_cookbook_list()
		self._control.menu_list.scrollview.viewport.content.rectTransform.anchoredPosition = Vector2(self._control.menu_list.scrollview.viewport.content.rectTransform.anchoredPosition.x, 0)

		local var_18_0 = self:filtrate_cookbook_list()

		self._reusable_cell:set_data(var_18_0)

		function self._reusable_cell:_set_func(arg_19_1)
			local var_19_0 = var_18_0[arg_19_1 + 1]

			self.food_quality.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_quality_s, var_18_0[arg_19_1 + 1].star))
			self.icon.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.cook_book_icon, var_18_0[arg_19_1 + 1].icon))

			self:set_cookbook_lable(self, var_18_0[arg_19_1 + 1])

			self.country_bg.country.text.text = var_0_2:getNowLang(var_0_4:get_country_language_key(var_18_0[arg_19_1 + 1].country))
			self.name_txt.text.text = var_18_0[arg_19_1 + 1].title
			self.type_txt.text.text = var_18_0[arg_19_1 + 1].effect_desc2
			self.buff_txt.text.text = self:get_txt(var_18_0[arg_19_1 + 1].effect_desc3)

			self.food_quality.button.onClick:RemoveAllListeners()
			self.food_quality.button.onClick:AddListener(function()
				self._now_click_cookbook_cid = var_19_0.cid

				self:set_cookbook_layer(true, self._now_click_cookbook_cid, var_19_0.state)
			end)
		end
	end

	function arg_1_0.set_cookbook_layer(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
		var_0_3:createInstance("restaurant_cookinfo"):show(1, arg_21_2, arg_21_1, arg_21_3)
	end

	function arg_1_0:set_cookbook_info(arg_22_1, arg_22_2)
		local var_22_0 = var_0_7.find_object_by_cid(arg_22_1)

		arg_22_2.food_quality.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.food_quality, var_22_0.star))
		arg_22_2.food_quality.food_small.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.cook_book_icon, var_22_0.icon))

		local var_22_1 = var_0_1:get_exp_by_id(arg_22_1)

		if var_22_1 > 100 then
			var_22_1 = 100
		end

		arg_22_2.progress.exp_text.text.text = tostring(var_22_1) .. " / 100"
	end

	function arg_1_0:update_cookbook_used_list()
		local var_23_0 = {
			self._control.my_menu.single_food_able_1,
			self._control.my_menu.single_food_able_2,
			self._control.my_menu.single_food_able_3
		}
		local var_23_1 = var_0_1:get_restaurant_use_cookbook()

		for iter_23_0, iter_23_1 in ipairs(var_23_1) do
			self:set_cookbook_info(iter_23_1.id, var_23_0[iter_23_0])
			var_23_0[iter_23_0].food_quality:SetActive(true)

			self._now_used_cookbook_data[iter_23_0] = iter_23_1.id
		end

		for iter_23_2 = #var_23_1 + 1, 3 do
			self._now_used_cookbook_data[iter_23_2] = nil

			var_23_0[iter_23_2].food_quality:SetActive(false)

			var_23_0[iter_23_2].progress.exp_text.text.text = ""
		end
	end

	function arg_1_0:set_chef_by_id()
		local var_24_0 = var_0_1:find_character_by_id(self._now_chef_id)
		local var_24_1 = var_0_5.find_object_by_cid(var_24_0.cid)

		self._control.cooker.image.sprite = self:loadSprite(var_0_4:get_format_url(var_0_4.chef_bg, var_24_1.star))
		self._control.cooker.role.image.sprite = self:loadSprite(var_0_4:get_ship_icon(var_0_11:use_big_break_painting(var_24_0, var_0_4.ship_icon_type.model_m, true), (var_24_0.skin ~= 0 or nil) and var_0_6.find_object_by_cid(var_24_0.skin).icon))

		self:set_love(var_24_0.love, var_24_0.marry)

		self._control.cooker.country_txt.text.text = var_0_2:getNowLang(var_0_4:get_country_language_key(var_24_1.country))
		self._now_chef_country = var_24_1.country
		self._control.cooker.name_txt.text.text = var_24_0.name
	end

	function arg_1_0:show_country_layer(arg_25_1)
		self._control.country_layer:SetActive(arg_25_1)
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:init_cell()
			self:__init_style_group_list()
		end

		var_0_1:set_cook_common_state(false)

		self._now_chef_id = var_0_1:get_use_info_data().chef

		self:set_chef_by_id()
		self:update_cookbook_used_list()
		self:update_cookbook_list()

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.top.title_txt.text.text = var_0_2:getNowLang("restaurantsetting")
		self._control.my_menu.single_food_able_1.progress.level.text.text = var_0_2:getNowLang("goodat")
		self._control.my_menu.single_food_able_2.progress.level.text.text = var_0_2:getNowLang("goodat")
		self._control.my_menu.single_food_able_3.progress.level.text.text = var_0_2:getNowLang("goodat")
		self._control.country_layer.toggle_group.all.Label.text.text = var_0_2:getNowLang("country0")
		self._control.country_layer.toggle_group.J_country.Label.text.text = var_0_2:getNowLang("country1")
		self._control.country_layer.toggle_group.G_country.Label.text.text = var_0_2:getNowLang("country2")
		self._control.country_layer.toggle_group.E_country.Label.text.text = var_0_2:getNowLang("country3")
		self._control.country_layer.toggle_group.U_country.Label.text.text = var_0_2:getNowLang("country4")
		self._control.country_layer.toggle_group.I_country.Label.text.text = var_0_2:getNowLang("country5")
		self._control.country_layer.toggle_group.F_country.Label.text.text = var_0_2:getNowLang("country6")
		self._control.country_layer.toggle_group.S_country.Label.text.text = var_0_2:getNowLang("country7")
		self._control.country_layer.toggle_group.C_country.Label.text.text = var_0_2:getNowLang("country8")
		self._control.country_layer.toggle_group.general.Label.text.text = var_0_2:getNowLang("country99")
		self._control.country_layer.toggle_group.get.Label.text.text = var_0_2:getNowLang("medaltypegain")
		self._control.country_layer.toggle_group.not_get.Label.text.text = var_0_2:getNowLang("nothave")
		self._control.country_layer.toggle_group.can_set.Label.text.text = var_0_2:getNowLang("canset")
		self._control.menu_list.type_btn.txt.text.text = var_0_2:getNowLang("countrytype") .. var_0_2:getNowLang("country0")
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

	function arg_1_0:_play_into_se(arg_29_1)
		self:playSE(arg_29_1, false)
	end

	function arg_1_0.__onReset(arg_30_0)
		arg_30_0._style_toggle_data = {
			"all"
		}
		arg_30_0._now_chef_id = 0
		arg_30_0._now_chef_country = nil
		arg_30_0._now_click_cookbook_cid = nil
		arg_30_0._now_cookbook_info_tyle = nil
		arg_30_0._now_used_cookbook_data = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_31_0)
	local var_31_0 = var_0_3:class("restaurant_setting")

	var_31_0._is_already_init = false
	var_31_0._reusable_cell = nil
	var_31_0._style_toggle_data = {
		"all"
	}
	var_31_0._toggle_style_group = nil
	var_31_0._now_chef_id = 0
	var_31_0._now_chef_country = nil
	var_31_0._now_click_cookbook_cid = nil
	var_31_0._now_cookbook_info_tyle = nil
	var_31_0._now_used_cookbook_data = {}

	return var_31_0
end

return var_0_0
