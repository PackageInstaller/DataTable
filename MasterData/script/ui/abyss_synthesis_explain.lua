local var_0_0 = {}
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gameconfig.ship_config
local var_0_5 = gameenum.common_type
local var_0_7 = gameconfig.ship_pve_active_config

function init_method(arg_1_0)
	function arg_1_0:__onUpdate()
		if self._abyss_ship_item then
			self._abyss_ship_item:update()
		end
	end

	function arg_1_0:updata_data()
		self:__abyss_ship_item_cell()
	end

	function arg_1_0:show()
		self:setVisible(true)
		self:_sort_abyss_ship_table()
		self:__load_abyss_ship_map_item()
		self:updata_data()
		self:__init_panel()
	end

	function arg_1_0:__init_panel()
		self:__initialize_All()
	end

	function arg_1_0:__initialize_All()
		self:__initialize_text()
		self:__initialize_button()
		self:__initialize_image()
		self:__initialize_data()
	end

	function arg_1_0:__initialize_text()
		self._control.bg.top_text.text.text = var_0_3:getNowLang("ui_ny21_synthesis_interface_synthesis_talk")
		self._control.left_button_layer.button_detail.Text.text.text = var_0_3:getNowLang("ui_ny21_synthesis_explain_details")
		self._control.left_button_layer.button_talk.Text.text.text = var_0_3:getNowLang("ui_ny21_synthesis_explain_synthesis_talk")
		self._control.right_ship_layer.top_title.rarity.Text.text.text = var_0_3:getNowLang("rarity")
		self._control.right_ship_layer.top_title.flesh.Text.text.text = var_0_3:getNowLang("flesh")
		self._control.right_ship_layer.top_title.type.Text.text.text = var_0_3:getNowLang("abyss_type")
		self._control.right_ship_layer.top_title.detail.Text.text.text = var_0_3:getNowLang("logdetail")

		self:__talk_load()
	end

	function arg_1_0:__talk_load()
		self._control.right_ship_layer.talk_text:SetActive(true)

		self._abyss_active_config = var_0_7.find_object_by_id(var_0_5.pve_active_list.abyss_event)
		self._control.right_ship_layer.talk_text.text.text = string.gsub(var_0_3:convert_rich_text(self._abyss_active_config.desc), "\\n", "\n")
	end

	function arg_1_0:__initialize_button()
		self._control.left_button_layer.button_detail.button_select:SetActive(false)
		self._control.left_button_layer.button_detail.button_cover:SetActive(true)
		self._control.left_button_layer.button_talk.button_cover:SetActive(false)
		self._control.left_button_layer.button_talk.button_select:SetActive(true)
		self._control.right_ship_layer.top_title:SetActive(false)
		self._control.right_ship_layer.all_ship:SetActive(false)
		self._control.right_ship_layer.top_button_layer:SetActive(false)
	end

	function arg_1_0.__initialize_image(arg_10_0)
		return
	end

	function arg_1_0.__initialize_data(arg_11_0)
		return
	end

	function arg_1_0:__onclick_talk_button()
		self._control.left_button_layer.button_detail.button_select:SetActive(false)
		self._control.left_button_layer.button_detail.button_cover:SetActive(true)
		self._control.left_button_layer.button_talk.button_cover:SetActive(false)
		self._control.left_button_layer.button_talk.button_select:SetActive(true)
		self._control.right_ship_layer.top_title:SetActive(false)
		self._control.right_ship_layer.all_ship:SetActive(false)
		self._control.right_ship_layer.talk_text:SetActive(true)
		self._control.right_ship_layer.top_button_layer:SetActive(false)
	end

	function arg_1_0:__onclick_detail_button()
		self._control.left_button_layer.button_detail.button_select:SetActive(true)
		self._control.left_button_layer.button_detail.button_cover:SetActive(false)
		self._control.left_button_layer.button_talk.button_cover:SetActive(true)
		self._control.left_button_layer.button_talk.button_select:SetActive(false)
		self._control.right_ship_layer.top_title:SetActive(true)
		self._control.right_ship_layer.all_ship:SetActive(true)
		self._control.right_ship_layer.talk_text:SetActive(false)
		self._control.right_ship_layer.top_button_layer:SetActive(true)
	end

	function arg_1_0:__load_abyss_ship_map_item()
		if self._is_first_init then
			return
		end

		self._abyss_ship_item = gamecore.reusable_cell:create(self, self._control.right_ship_layer.all_ship.Viewport.edge_mask.Content.endlessScrollView, self._control.right_ship_layer.all_ship.Viewport.edge_mask.Content, "abyss_explain_select_item", "abyss_synthesis_explain")

		self._abyss_ship_item:init()

		self._is_first_init = true
	end

	function arg_1_0.__get_all_abyss_ship_cid(arg_15_0)
		local var_15_0, var_15_1 = var_0_4.get_sequence()
		local var_15_2 = {}

		for iter_15_0, iter_15_1 in pairs(var_15_0) do
			for iter_15_2, iter_15_3 in pairs(iter_15_1) do
				if iter_15_2 == "cid" and iter_15_3 % 100 == 18 then
					var_15_2[#var_15_2 + 1] = iter_15_1

					for iter_15_4, iter_15_5 in pairs(var_15_2[#var_15_2]) do
						if iter_15_4 == "equipment" or iter_15_4 == "equips" then
							local var_15_3 = {}

							for iter_15_6, iter_15_7 in pairs(iter_15_5) do
								table.insert(var_15_3, {
									id = iter_15_7
								})
							end

							if iter_15_4 == "equipment" then
								var_15_2[#var_15_2].equipment = var_15_3

								break
							end

							if iter_15_4 == "equips" then
								var_15_2[#var_15_2].equips = var_15_3
							end

							break
						end
					end
				end
			end
		end

		return var_15_2
	end

	function arg_1_0:_sort_abyss_ship_table()
		if #self._abyss_ship_table ~= 0 then
			return
		end

		local var_16_0 = self:__get_all_abyss_ship_cid()

		for iter_16_0, iter_16_1 in pairs(var_16_0) do
			iter_16_1.equips = iter_16_1.equipment
		end

		local var_16_1 = {}

		for iter_16_2, iter_16_3 in pairs(var_16_0) do
			for iter_16_4, iter_16_5 in pairs(iter_16_3) do
				if iter_16_4 == "combination_weight" and iter_16_5 ~= 0 then
					var_16_1[#var_16_1 + 1] = iter_16_3
				end
			end
		end

		local var_16_3 = {}
		local var_16_4 = {}

		for iter_16_6, iter_16_7 in pairs(var_16_1) do
			if var_16_1[iter_16_6].boss == 1 then
				var_16_3[#var_16_3 + 1] = iter_16_7
			else
				var_16_4[#var_16_4 + 1] = iter_16_7
			end
		end

		table.sort(var_16_4, function(arg_17_0, arg_17_1)
			return arg_17_0.star > arg_17_1.star
		end)

		local var_16_5 = {}

		for iter_16_8, iter_16_9 in pairs(var_16_3) do
			var_16_5[#var_16_5 + 1] = iter_16_9
		end

		for iter_16_10, iter_16_11 in pairs(var_16_4) do
			var_16_5[#var_16_5 + 1] = iter_16_11
		end

		self._abyss_ship_table = var_16_5
	end

	function arg_1_0:__abyss_ship_item_cell()
		local var_18_0 = self._abyss_ship_table

		self._abyss_ship_item:set_data(self._abyss_ship_table)

		function self._abyss_ship_item:_set_func(arg_19_1)
			local var_19_0 = var_18_0[arg_19_1 + 1]

			self:__star_info(self, var_18_0[arg_19_1 + 1].star)
			self:__boss_and_name_info(self, var_18_0[arg_19_1 + 1].title, var_18_0[arg_19_1 + 1].boss)
			self:__abyss_ship_icon_info(self, var_18_0[arg_19_1 + 1].pic_id)
			self:__abyss_ship_type_info(self, var_18_0[arg_19_1 + 1].type)
			self:__abyss_star_backdrop_image_info(self, var_18_0[arg_19_1 + 1].boss)

			self.detail.Button_ship_detail.Text.text.text = var_0_3:getNowLang("view")

			self.detail.Button_ship_detail.button.onClick:RemoveAllListeners()
			self.detail.Button_ship_detail.button.onClick:AddListener(function()
				var_0_2:createInstance("abyss_ship_detail"):show(var_0_5.enter_ship_detail_type.abyss_synthesis_explain, var_19_0)
			end)
		end
	end

	function arg_1_0.__onclick_rarity_button_to_sort(arg_21_0)
		return
	end

	function arg_1_0.__onclick_flesh_button_to_sort(arg_22_0)
		return
	end

	function arg_1_0.__onclick_type_button_to_sort(arg_23_0)
		return
	end

	function arg_1_0:__star_info(arg_24_1, arg_24_2)
		star_layer = arg_24_1.flesh.Image.star_layer

		for iter_24_0 = 1, 7 do
			if iter_24_0 <= arg_24_2 then
				star_layer["star_" .. iter_24_0].image.sprite = self:loadSprite(var_0_5.abyss_ui_path.card .. "star_icon.png")

				star_layer["star_" .. iter_24_0]:SetActive(true)
			elseif iter_24_0 == 7 then
				star_layer["star_" .. iter_24_0]:SetActive(false)
			else
				star_layer["star_" .. iter_24_0].image.sprite = self:loadSprite(var_0_5.abyss_ui_path.card .. "star_blank_icon.png")

				star_layer["star_" .. iter_24_0]:SetActive(true)
			end
		end
	end

	function arg_1_0.__boss_and_name_info(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
		arg_25_1.flesh.name_type.top_text.text.text = arg_25_2
		arg_25_1.flesh.name_type.bottom_text.text.text = arg_25_3 == 1 and var_0_3:getNowLang("tip_boss") or var_0_3:getNowLang("tip_not_boss")
	end

	function arg_1_0:__abyss_ship_icon_info(arg_26_1, arg_26_2)
		arg_26_1.flesh.icon.image.sprite = self:loadSprite((var_0_5:get_ship_icon(var_0_5.ship_icon.model_normal_s, arg_26_2, arg_26_2)))
	end

	function arg_1_0:__abyss_star_backdrop_image_info(arg_27_1, arg_27_2)
		arg_27_1.flesh.Image.image.sprite = self:loadSprite(arg_27_2 == 1 and var_0_5.abyss_ui_path.info .. "ship_quality_2.png" or var_0_5.abyss_ui_path.info .. "ship_quality_1.png")
	end

	function arg_1_0.__abyss_ship_type_info(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0

		for iter_28_0, iter_28_1 in pairs(var_0_5.ship_type_rule) do
			if iter_28_1.value == arg_28_2 then
				var_28_0 = iter_28_1.simplified_lan
			end
		end

		arg_28_1.type.Text.text.text = var_0_3:getNowLang(var_28_0)
	end

	function arg_1_0.__onReset(arg_29_0)
		arg_29_0._abyss_active_config = {}
	end

	gamecore.extend_method(arg_1_0)
end

gamecore.UILoader:define("abyss_synthesis_explain", init_method)

function var_0_0.create(arg_30_0)
	local var_30_0 = var_0_2:class("abyss_synthesis_explain")

	var_30_0._abyss_ship_item = nil
	var_30_0._is_first_init = false
	var_30_0._abyss_ship_table = {}
	var_30_0._abyss_active_config = {}

	return var_30_0
end

return var_0_0
