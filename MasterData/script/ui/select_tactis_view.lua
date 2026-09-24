local var_0_0 = {}
local var_0_1 = table.insert
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = string.format
local var_0_5 = gamecore.util_func
local var_0_6 = gameenum.common_type
local var_0_7 = gameconfig.ship_config
local var_0_8 = gameconfig.skin_config
local var_0_9 = gameconfig.tactics_config

gamecore.UILoader:define("select_tactis_view", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._tactics_item_table = arg_2_1

		self:__init_panel()
	end

	function arg_1_0:save_now_select_ship_data(arg_3_1)
		self._ship_data = arg_3_1

		self:__reset_item_state()
		self:__reset_level_limit_prompt()
		self:__set_already_study_tactis_data(arg_3_1)
		self:__get_study_show_state(self._ship_data.level)
		self:update_school_panel_state()

		self._is_select_ship = true
		self._ship_config = var_0_7.find_object_by_cid(arg_3_1.cid)

		self:__set_ship_icon_url(arg_3_1)
		self:__set_ship_layer_info()
		self._control.all_layer.gameObject:SetActive(true)
		self:__refresh_item_state()
	end

	function arg_1_0:update_school_panel_state()
		local var_4_0 = var_0_2:getInstance("school")

		self:setVisible(true)
	end

	function arg_1_0:get_curr_select_ship_info()
		return self._ship_data
	end

	function arg_1_0:get_select_ship_data()
		return self._ship_data
	end

	function arg_1_0:__init_panel()
		if not self._is_already_init then
			self:__init_language()
			self:__init_tactis_item_list()
			self:__init_images()
		end

		self:__reset_level_limit_prompt()
		self:__init_study_tactics_data()

		self._is_already_init = true
	end

	function arg_1_0:__init_images()
		self._control.select_ship.image.sprite = self:loadSprite(var_0_4(var_0_6.tactics_normal, "add_ship"))
	end

	function arg_1_0:__init_language()
		self._control.baseboard.title.text.text = var_0_3:getNowLang("selecttactics")
		self._control.attack_des.text.text = var_0_3:getNowLang("attacktactics")
		self._control.defense_des.text.text = var_0_3:getNowLang("defendtactics")
		self._control.special_des.text.text = var_0_3:getNowLang("specialtactics")
		self._control.attack_limit.limit_des.text.text = var_0_3:convert_rich_text(var_0_4(var_0_3:getNowLang("tacticslimit"), var_0_6.college_const.attack_level, var_0_3:getNowLang("attacktactics")))
		self._control.defense_limit.limit_des.text.text = var_0_3:convert_rich_text(var_0_4(var_0_3:getNowLang("tacticslimit"), var_0_6.college_const.defense_level, var_0_3:getNowLang("defendtactics")))
		self._control.special_limit.limit_des.text.text = var_0_3:convert_rich_text(var_0_4(var_0_3:getNowLang("tacticslimit"), var_0_6.college_const.special_level, var_0_3:getNowLang("specialtactics")))
		self._level_limit_prompt_list = {
			self._control.attack_limit.gameObject,
			self._control.defense_limit.gameObject,
			self._control.special_limit.gameObject
		}
	end

	function arg_1_0:__init_tactis_item_list()
		self._tactics_item_panel = {}

		for iter_10_0 = 1, 9 do
			local var_10_0, var_10_1 = self:loadUIPrefab("tactics_item_view", self._control.item_parent.transform)

			var_10_0:setVisible(false)

			var_10_1.select.image.sprite = self:loadSprite(var_0_6.college_select_shield_bg)
			self._tactics_item_panel[#self._tactics_item_panel + 1] = {
				obj = var_10_0,
				control = var_10_1
			}
		end
	end

	function arg_1_0:__init_study_tactics_data()
		self._attack_tactics_table = {}
		self._defense_tactics_table = {}
		self._special_tactics_table = {}

		for iter_11_0, iter_11_1 in pairs(self._tactics_item_table.tactics) do
			local var_11_0 = var_0_9.find_object_by_cid(iter_11_1)

			if var_11_0.type == 1 then
				var_0_1(self._attack_tactics_table, var_11_0)
			elseif var_11_0.type == 2 then
				var_0_1(self._defense_tactics_table, var_11_0)
			elseif var_11_0.type == 3 then
				var_0_1(self._special_tactics_table, var_11_0)
			end
		end

		self._control.all_layer.gameObject:SetActive(false)
		self:__reset_item_state()
		self:__set_item_panel()
	end

	function arg_1_0:__set_item_panel()
		for iter_12_0 = 1, #self._attack_tactics_table do
			self._tactics_item_panel[iter_12_0].obj:setVisible(true)

			self._tactics_item_panel[iter_12_0].control.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.college_tactics, self._attack_tactics_table[iter_12_0].tactics_id))
			self._tactics_item_panel[iter_12_0].control.icondes.text.text = self._attack_tactics_table[iter_12_0].title

			self:__set_tactis_click_listener(iter_12_0)
		end

		for iter_12_1 = 4, #self._defense_tactics_table + 3 do
			self._tactics_item_panel[iter_12_1].obj:setVisible(true)

			self._tactics_item_panel[iter_12_1].control.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.college_tactics, self._defense_tactics_table[iter_12_1 - 3].tactics_id))
			self._tactics_item_panel[iter_12_1].control.icondes.text.text = self._defense_tactics_table[iter_12_1 - 3].title

			self:__set_tactis_click_listener(iter_12_1)
		end

		for iter_12_2 = 7, #self._special_tactics_table + 6 do
			self._tactics_item_panel[iter_12_2].obj:setVisible(true)

			self._tactics_item_panel[iter_12_2].control.icon.image.sprite = self:loadSprite(var_0_4(var_0_6.college_tactics, self._special_tactics_table[iter_12_2 - 6].tactics_id))
			self._tactics_item_panel[iter_12_2].control.icondes.text.text = self._special_tactics_table[iter_12_2 - 6].title

			self:__set_tactis_click_listener(iter_12_2)
		end
	end

	function arg_1_0:__refresh_item_state()
		for iter_13_0 = 1, #self._attack_tactics_table do
			self._tactics_item_panel[iter_13_0].obj:setVisible(true)

			if self._is_show_index > 0 then
				if self._attack_tactics_table[iter_13_0].ship_ton ~= 0 and self._attack_tactics_table[iter_13_0].ship_ton ~= self._ship_config.ship_ton then
					self._tactics_item_panel[iter_13_0].control.select.gameObject:SetActive(true)
					self._tactics_item_panel[iter_13_0].control.limit_des.gameObject:SetActive(true)

					self._tactics_item_panel[iter_13_0].control.limit_des.text.text = var_0_6:get_limit_text(self._attack_tactics_table[iter_13_0].ship_ton)
				else
					local var_13_0 = false
					local var_13_1
					local var_13_2 = 0

					if self._ship_data.all_tactics ~= nil and #self._ship_data.all_tactics ~= 0 then
						for iter_13_1, iter_13_2 in ipairs(self._ship_data.all_tactics) do
							local var_13_3 = var_0_9.find_object_by_cid(iter_13_2.id)
							local var_13_4 = var_0_9.find_object_by_cid(self._attack_tactics_table[iter_13_0].cid)

							if var_13_3 and var_13_4 and var_13_3.tactics_id == var_13_4.tactics_id then
								var_13_0 = true
								var_13_1 = iter_13_2.id
								var_13_2 = var_13_3.max_level

								break
							end
						end
					end

					local var_13_5
					local var_13_6
					local var_13_7
					local var_13_8

					if var_13_0 then
						local var_13_10

						var_13_5, var_13_6, var_13_7, var_13_8, var_13_10 = self:__get_tactis_info_by_cid(var_13_1)
					else
						local var_13_11

						var_13_5, var_13_6, var_13_7, var_13_8, var_13_11 = self:__get_tactis_info_by_cid(self._attack_tactics_table[iter_13_0].cid)
					end

					if var_13_5 then
						self._tactics_item_panel[iter_13_0].control.tips.gameObject:SetActive(var_13_7 ~= var_13_2)

						self._tactics_item_panel[iter_13_0].control.complete_icon.complete_des.text.text = var_0_3:getNowLang("trainover")

						self._tactics_item_panel[iter_13_0].control.complete_icon.gameObject:SetActive(var_13_7 == var_13_2)

						self._tactics_item_panel[iter_13_0].control.tips.level.text.text = "Lv." .. var_13_7
						self._tactics_item_panel[iter_13_0].control.tips.progress.text.text = var_13_6.exp .. "/" .. var_13_8
					end
				end
			end
		end

		if self._is_show_index <= 0 then
			self._level_limit_prompt_list[1]:SetActive(true)
		end

		for iter_13_3 = 4, #self._defense_tactics_table + 3 do
			self._tactics_item_panel[iter_13_3].obj:setVisible(true)

			if self._is_show_index > 1 then
				if self._defense_tactics_table[iter_13_3 - 3].ship_ton ~= 0 and self._defense_tactics_table[iter_13_3 - 3].ship_ton ~= self._ship_config.ship_ton then
					self._tactics_item_panel[iter_13_3].control.select.gameObject:SetActive(true)
					self._tactics_item_panel[iter_13_3].control.limit_des.gameObject:SetActive(true)

					self._tactics_item_panel[iter_13_3].control.limit_des.text.text = var_0_6:get_limit_text(self._defense_tactics_table[iter_13_3 - 3].ship_ton)
				else
					local var_13_12 = false
					local var_13_13
					local var_13_14 = 0

					if self._ship_data.all_tactics ~= nil and #self._ship_data.all_tactics ~= 0 then
						for iter_13_4, iter_13_5 in ipairs(self._ship_data.all_tactics) do
							local var_13_15 = var_0_9.find_object_by_cid(iter_13_5.id) or var_0_9.find_object_by_cid(iter_13_5.cid)

							if var_13_15.tactics_id == var_0_9.find_object_by_cid(self._defense_tactics_table[iter_13_3 - 3].cid).tactics_id then
								var_13_12 = true
								var_13_13 = iter_13_5.id
								var_13_14 = var_13_15.max_level

								break
							end
						end
					end

					local var_13_16
					local var_13_17
					local var_13_18
					local var_13_19

					if var_13_12 then
						local var_13_21

						var_13_16, var_13_17, var_13_18, var_13_19, var_13_21 = self:__get_tactis_info_by_cid(var_13_13)
					else
						local var_13_22

						var_13_16, var_13_17, var_13_18, var_13_19, var_13_22 = self:__get_tactis_info_by_cid(self._defense_tactics_table[iter_13_3 - 3].cid)
					end

					if var_13_16 then
						self._tactics_item_panel[iter_13_3].control.tips.gameObject:SetActive(var_13_18 ~= var_13_14)

						self._tactics_item_panel[iter_13_3].control.complete_icon.complete_des.text.text = var_0_3:getNowLang("trainover")

						self._tactics_item_panel[iter_13_3].control.complete_icon.gameObject:SetActive(var_13_18 == var_13_14)

						self._tactics_item_panel[iter_13_3].control.tips.level.text.text = "Lv." .. var_13_18
						self._tactics_item_panel[iter_13_3].control.tips.progress.text.text = var_13_17.exp .. "/" .. var_13_19
					end
				end
			end
		end

		if self._is_show_index <= 1 then
			self._level_limit_prompt_list[2]:SetActive(true)
		end

		for iter_13_6 = 7, #self._special_tactics_table + 6 do
			self._tactics_item_panel[iter_13_6].obj:setVisible(true)

			if self._is_show_index > 2 then
				if self._special_tactics_table[iter_13_6 - 6].ship_ton ~= 0 and self._special_tactics_table[iter_13_6 - 6].ship_ton ~= self._ship_config.ship_ton then
					self._tactics_item_panel[iter_13_6].control.select.gameObject:SetActive(true)
					self._tactics_item_panel[iter_13_6].control.limit_des.gameObject:SetActive(true)

					self._tactics_item_panel[iter_13_6].control.limit_des.text.text = var_0_6:get_limit_text(self._special_tactics_table[iter_13_6 - 6].ship_ton)
				else
					local var_13_23 = false
					local var_13_24
					local var_13_25 = 0

					if self._ship_data.all_tactics ~= nil and #self._ship_data.all_tactics ~= 0 then
						for iter_13_7, iter_13_8 in ipairs(self._ship_data.all_tactics) do
							local var_13_26 = var_0_9.find_object_by_cid(iter_13_8.id) or var_0_9.find_object_by_cid(iter_13_8.cid)

							if var_13_26.tactics_id == var_0_9.find_object_by_cid(self._special_tactics_table[iter_13_6 - 6].cid).tactics_id then
								var_13_23 = true
								var_13_24 = var_0_9.find_object_by_cid(iter_13_8.id) and iter_13_8.id or iter_13_8.cid
								var_13_25 = var_13_26.max_level

								break
							end
						end
					end

					local var_13_27
					local var_13_28
					local var_13_29
					local var_13_30

					if var_13_23 then
						local var_13_32

						var_13_27, var_13_28, var_13_29, var_13_30, var_13_32 = self:__get_tactis_info_by_cid(var_13_24)
					else
						local var_13_33

						var_13_27, var_13_28, var_13_29, var_13_30, var_13_33 = self:__get_tactis_info_by_cid(self._special_tactics_table[iter_13_6 - 6].cid)
					end

					if var_13_27 then
						self._tactics_item_panel[iter_13_6].control.tips.gameObject:SetActive(var_13_29 ~= var_13_25)

						self._tactics_item_panel[iter_13_6].control.complete_icon.complete_des.text.text = var_0_3:getNowLang("trainover")

						self._tactics_item_panel[iter_13_6].control.complete_icon.gameObject:SetActive(var_13_29 == var_13_25)

						self._tactics_item_panel[iter_13_6].control.tips.level.text.text = "Lv." .. var_13_29
						self._tactics_item_panel[iter_13_6].control.tips.progress.text.text = var_13_28.exp .. "/" .. var_13_30
					end
				end
			end
		end

		if self._is_show_index <= 2 then
			self._level_limit_prompt_list[3]:SetActive(true)
		end
	end

	function arg_1_0:__reset_item_state()
		for iter_14_0 = 1, #self._tactics_item_panel do
			self._tactics_item_panel[iter_14_0].obj:setVisible(false)
			self._tactics_item_panel[iter_14_0].control.select:SetActive(false)
			self._tactics_item_panel[iter_14_0].control.limit_des.gameObject:SetActive(false)
			self._tactics_item_panel[iter_14_0].control.complete_icon.gameObject:SetActive(false)
			self._tactics_item_panel[iter_14_0].control.tips.gameObject:SetActive(false)
		end
	end

	function arg_1_0:__set_ship_layer_info()
		local var_15_0 = self._control.all_layer.level_layer

		self._control.all_layer.icon.image.sprite = self:loadSprite(self._icon_url)
		self._control.all_layer.image.sprite = self:loadSprite(var_0_4(var_0_6.chef_bg, self._ship_data.star))
		var_15_0.type_txt.text.text = var_0_3:getNowLang(var_0_6:get_ship_type_language_key(self._ship_config.type, 1))
		var_15_0.country_txt.text.text = var_0_4("(%s)", var_0_3:getNowLang(var_0_6:get_country_language_key(self._ship_config.country)))
		var_15_0.level_txt.text.text = var_0_4("LV.%d", self._ship_data.level)
		var_15_0.level_txt.text.color = self._ship_data.level >= var_0_6.college_const.special_level and Color.New(254, 252, 0) or Color.New(255, 255, 255)

		var_15_0.ship_remake:SetActive(self._ship_config.evo_class)

		self._control.all_layer.name_level.text.text = self._ship_data.name
		var_15_0.lock_tag.image.sprite = self:loadSprite((self._ship_data.lock or nil) and (var_0_6.ship_lock.ship_lock_l or var_0_6.ship_unlock.ship_unlock_l))
		self._control.all_layer.love_layer.love.image.sprite = self:loadSprite(var_0_6:get_love_path_2(self._ship_data, false))

		for iter_15_0 = 1, var_15_0.star_layer.transform.childCount do
			if iter_15_0 <= self._ship_data.star then
				var_15_0.star_layer.transform:GetChild(iter_15_0 - 1).gameObject:SetActive(true)
			else
				var_15_0.star_layer.transform:GetChild(iter_15_0 - 1).gameObject:SetActive(false)
			end
		end
	end

	function arg_1_0:__reset_level_limit_prompt()
		for iter_16_0, iter_16_1 in pairs(self._level_limit_prompt_list) do
			iter_16_1:SetActive(false)
		end

		self._already_study_tactis_list = {}
	end

	function arg_1_0.__get_study_show_state(arg_17_0, arg_17_1)
		arg_17_0._is_show_index = 0

		if arg_17_1 >= var_0_6.college_const.attack_level then
			arg_17_0._is_show_index = 1
		end

		if arg_17_1 >= var_0_6.college_const.defense_level then
			arg_17_0._is_show_index = 2
		end

		if arg_17_1 >= var_0_6.college_const.special_level then
			arg_17_0._is_show_index = 3
		end
	end

	function arg_1_0:__set_tactis_click_listener(arg_18_1)
		self._tactics_item_panel[arg_18_1].control.tactics_btn.button.onClick:RemoveAllListeners()
		self._tactics_item_panel[arg_18_1].control.tactics_btn.button.onClick:AddListener(function()
			self:__show_item_detail_info(arg_18_1)
		end)
	end

	function arg_1_0:__get_tactis_info_by_cid(arg_20_1)
		local var_20_0 = false
		local var_20_1
		local var_20_2 = 0
		local var_20_3 = 0
		local var_20_4 = 0

		for iter_20_0, iter_20_1 in pairs(self._already_study_tactis_list) do
			local var_20_5 = var_0_9.find_object_by_cid(iter_20_1.id) or var_0_9.find_object_by_cid(iter_20_1.cid)

			if var_20_5.tactics_id == var_0_9.find_object_by_cid(arg_20_1).tactics_id then
				var_20_0 = true
				var_20_1 = iter_20_1

				if var_0_9.find_object_by_cid(iter_20_1.id) then
					var_20_2, var_20_3, var_20_4 = var_0_6:__get_tactis_config_level(iter_20_1.exp, iter_20_1.id)
				else
					var_20_2, var_20_3, var_20_4 = var_0_6:__get_tactis_config_level(iter_20_1.exp, iter_20_1.cid)
				end

				var_20_2 = var_20_5.level

				return var_20_0, var_20_1, var_20_5.level, var_20_3, var_20_4
			end
		end

		return var_20_0, var_20_1, var_20_2, var_20_3, var_20_4
	end

	function arg_1_0.__set_already_study_tactis_data(arg_21_0, arg_21_1)
		arg_21_0._already_study_tactis_list = var_0_2:getInstance("school"):get_tactics_by_ship_id(arg_21_1.id)
	end

	function arg_1_0:__set_ship_icon_url(arg_22_1)
		self._icon_url = nil

		local var_22_0 = var_0_5:use_big_break_painting(arg_22_1, var_0_6.ship_icon_type.model_m, true)

		self._icon_url = arg_22_1.skin ~= 0 and var_0_6:get_ship_icon(var_22_0, var_0_8.find_object_by_cid(arg_22_1.skin).icon) or var_0_6:get_ship_icon(var_22_0, tostring(self._ship_config.pic_id))
	end

	function arg_1_0:__onReset()
		self._control.select_ship.image.sprite = self:loadSprite(var_0_4(var_0_6.tactics_normal, "add_ship"))
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_24_0)
	local var_24_0 = var_0_2:class("select_tactis_view")

	var_24_0._is_already_init = false
	var_24_0._tactics_item_panel = {}
	var_24_0._tactics_item_table = {}
	var_24_0._attack_tactics_table = {}
	var_24_0._defense_tactics_table = {}
	var_24_0._special_tactics_table = {}
	var_24_0._is_select_ship = false
	var_24_0._ship_type_limit = nil
	var_24_0._ship_data = nil
	var_24_0._level_limit_prompt_list = {}
	var_24_0._is_show_index = 0
	var_24_0._already_study_tactis_list = {}
	var_24_0._icon_url = nil

	return var_24_0
end

return var_0_0
