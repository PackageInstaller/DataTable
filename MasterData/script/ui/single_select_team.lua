local var_0_0 = {}
local var_0_2 = gamecore.Language
local var_0_3 = gamecore.UILoader
local var_0_4 = gameenum.common_type
local var_0_5 = gameconfig.ship_config
local var_0_6 = gameconfig.skin_config
local var_0_7 = gameconfig.item_config
local var_0_8 = gameconfig.skill_config
local var_0_9 = gameconfig.cook_book_config
local var_0_10 = gameconfig.equip_config
local var_0_11 = string.format
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = gamecore.user
local var_0_14 = math.modf
local var_0_15 = string.lower
local var_0_16 = UnityEngine.Vector2
local var_0_17 = gameconfig.workshop_config
local var_0_18 = gameconfig.strike_buff_config
local var_0_19 = gameconfig.strike_weather_config
local var_0_21 = gameconfig.pve_mist_ship_config
local var_0_22 = {
	bullet = 1,
	oil = 2
}
local var_0_23 = gamecore.util_func
local var_0_25 = math.floor

gamecore.UILoader:define("single_select_team", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7)
		self:setVisible(true)

		self._is_nf = var_0_13:get_select_into_nf()
		self._index = arg_2_3
		self._go_to_map_id = arg_2_6
		self._tab_type = arg_2_2
		self._team_type = arg_2_4
		self._enter_friend_captainroom_fleet_type = arg_2_5
		self._orgin_ship_data = arg_2_7
		self._team_num = 0

		self:__init_panel(arg_2_1, arg_2_2)
	end

	function arg_1_0:update_cell_info()
		self:update_character_data()
		self:__init_panel(self._data, self._tab_type, true)
		self:show_detail_layer()
		self:__set_level_layer(self._control.BG.all_layer.formation_type_layer.level_layer)
		var_0_3:getInstance("select_member"):update_content(self._data.id)
	end

	function arg_1_0:update_character_data(arg_4_1)
		local var_4_0 = self._data.id

		if arg_4_1 then
			var_4_0 = arg_4_1
		end

		local var_4_1 = var_0_13:find_character_by_id(var_4_0)

		if var_4_1 then
			self._data = var_0_23.little_clone(var_4_1)
			self._data.attrs = var_0_13:get_character_attribute(var_4_0) or {}
		end
	end

	function arg_1_0.set_enter_type(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		arg_5_0._enter_type = arg_5_1
		arg_5_0._campaign = arg_5_2
		arg_5_0._team_index = arg_5_3
	end

	function arg_1_0:__init_active()
		self._control.BG.all_layer.ship_level_image.gameObject:SetActive(false)
	end

	function arg_1_0:set_team_id(arg_7_1)
		local var_7_0 = self._control.BG.all_layer

		if arg_7_1 and arg_7_1 ~= 0 and arg_7_1 < 9 then
			self._control.team_id_info:SetActive(true)
			self._control.tower_cost:SetActive(false)

			self._control.team_id_info.team_id.text.text = arg_7_1

			if self._data.state ~= var_0_4.ship_state.repair and self._team_type ~= var_0_4.team_type.campaign then
				if self._enter_type == var_0_4.enter_select_member_type.six_year_primary then
					var_7_0.formation_layer:SetActive(false)
					var_7_0.expedition_layer:SetActive(false)
				elseif (self._enter_type == var_0_4.enter_select_member_type.fight or self._enter_type == var_0_4.enter_select_member_type.tower) and arg_7_1 == self._team_index then
					var_7_0.expedition_layer:SetActive(false)
					var_7_0.formation_layer:SetActive(true)
				else
					var_7_0.formation_layer:SetActive(false)
					var_7_0.expedition_layer:SetActive(self._data.state == var_0_4.ship_state.expedition)
				end
			else
				var_7_0.formation_layer:SetActive(false)
				var_7_0.expedition_layer:SetActive(false)
			end
		else
			var_7_0.expedition_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)
			var_7_0.formation_layer:SetActive(false)
		end
	end

	function arg_1_0:show_mist_detail_layer(arg_8_1)
		if self._data.is_exist then
			return
		end

		if arg_8_1 == var_0_4.dock_detail_layer.second then
			local var_8_0 = var_0_21.find_object_by_id(self._data.id)

			self._control.BG.all_layer.formation_type_layer.detail_layer_mist:SetActive(true)

			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_1.tip.text.text = var_0_2:getNowLang("hp")
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_1.num.text.text = var_8_0.maxhp
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2.tip.text.text = var_0_2:getNowLang("atk")
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2.num.text.text = var_8_0.gunpower
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3.tip.text.text = var_0_2:getNowLang("torpedo")
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3.num.text.text = var_8_0.torpedopower

			if var_8_0.shiptype == 6 then
				self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_2.tip.text.text = var_0_2:get("舰爆")
				self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_3.tip.text.text = var_0_2:get("舰攻")
			end

			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_4.tip.text.text = var_0_2:getNowLang("airdef")
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist.info_bg.txt_4.num.text.text = var_8_0.antiair
		else
			self._control.BG.all_layer.formation_type_layer.detail_layer_mist:SetActive(false)
		end
	end

	function arg_1_0:show_tactics_detail_layer(arg_9_1, arg_9_2, arg_9_3)
		local var_9_0 = self._control.BG.all_layer.tactics_layer

		if arg_9_1 == var_0_4.dock_detail_layer.once then
			var_9_0:SetActive(false)
		else
			local var_9_1 = "lv.0"
			local var_9_2 = "0"

			if arg_9_2 and arg_9_2 >= 900 then
				var_9_1 = "lv.3"
				var_9_2 = 500 .. "/" .. 500
			elseif arg_9_2 and arg_9_2 >= 400 then
				var_9_1 = "lv.2"
				var_9_2 = arg_9_2 - 400 .. "/" .. 500
			elseif arg_9_2 and arg_9_2 >= 100 then
				var_9_1 = "lv.1"
				var_9_2 = arg_9_2 - 100 .. "/" .. 300
			else
				var_9_1 = "lv.0"
				var_9_2 = arg_9_2 .. "/" .. 100
			end

			var_9_0.tactics_level.text.text = var_9_1
			var_9_0.tactics_exp.text.text = var_9_2
			self._control.BG.all_layer.tactics_layer.tactics_bg.image.sprite = self:loadSprite(var_0_11(var_0_4.college_tactics_s, arg_9_3))

			var_9_0:SetActive(true)
		end
	end

	function arg_1_0:show_cook_detail_layer(arg_10_1)
		if arg_10_1 > 0 then
			self._control.BG.all_layer.restaurant_layer:SetActive(true)

			self._control.BG.all_layer.restaurant_layer.restaurant_level.text.text = var_0_2:getNowLang("goodat")
			self._control.BG.all_layer.restaurant_layer.restaurant_exp.text.text = arg_10_1 .. "/" .. 100
		else
			self._control.BG.all_layer.restaurant_layer:SetActive(false)
		end
	end

	function arg_1_0:show_detail_layer(arg_11_1)
		local var_11_0 = self._control.BG.all_layer.formation_type_layer
		local var_11_1 = self._control.BG.all_layer.formation_type_layer.detail_layer

		if not self._data.id then
			return
		end

		if arg_11_1 then
			self._current_detail_layer_index = arg_11_1
		end

		if not arg_11_1 and self._current_detail_layer_index then
			arg_11_1 = self._current_detail_layer_index
		end

		local var_11_2 = (self._enter_type == var_0_4.enter_select_member_type.strengthen or self._enter_type == var_0_4.enter_select_member_type.skill) and var_11_0.strength_level_layer or var_11_0.level_layer

		if self._enter_type == var_0_4.enter_select_member_type.strengthen then
			if arg_11_1 == var_0_4.dock_detail_layer.once then
				self._control.BG.all_layer.formation_type_layer.strength_lock.transform.localPosition = Vector3(50, -10, 0)
				self._control.BG.all_layer.formation_type_layer.custom.transform.localPosition = Vector3(-47, -10, 0)
			else
				self._control.BG.all_layer.formation_type_layer.strength_lock.transform.localPosition = Vector3(50, -40, 0)
				self._control.BG.all_layer.formation_type_layer.custom.transform.localPosition = Vector3(-47, -40, 0)
			end
		end

		if arg_11_1 == var_0_4.dock_detail_layer.once then
			var_11_1:SetActive(false)
			var_11_2:SetActive(true)

			local var_11_3 = var_0_3:getInstance("select_member")

			if var_11_3 then
				if var_11_3._panel_type == var_0_4.enter_select_member_type.custom_ship and (self._enter_type == var_0_4.enter_select_member_type.strengthen or self._enter_type == var_0_4.enter_select_member_type.skill) then
					var_11_2:SetActive(false)
					var_11_0.level_layer:SetActive(true)
				elseif (self._enter_type == var_0_4.enter_select_member_type.strengthen or self._enter_type == var_0_4.enter_select_member_type.skill) and var_11_3._panel_type ~= var_0_4.enter_select_member_type.custom_ship then
					var_11_2:SetActive(true)
					var_11_0.level_layer:SetActive(false)
				end
			end
		elseif arg_11_1 == var_0_4.dock_detail_layer.second then
			var_11_1:SetActive(true)
			var_11_2:SetActive(false)

			local var_11_4 = var_0_23:get_ship_attr(self._data, self._ship_config)

			if self._enter_type == var_0_4.enter_select_member_type.strengthen_res then
				local var_11_6 = var_0_5.find_object_by_cid(self._data.cid).type

				for iter_11_0, iter_11_1 in pairs(self._ship_config.strengthen_supply_exp) do
					local var_11_7 = self:__set_work_add(var_11_6)

					if iter_11_1.name == "atk" then
						var_11_4.atk = iter_11_1.value + math.floor(iter_11_1.value * var_11_7 / 100)
					elseif iter_11_1.name == "torpedo" then
						var_11_4.torpedo = iter_11_1.value + math.floor(iter_11_1.value * var_11_7 / 100)
					elseif iter_11_1.name == "def" then
						var_11_4.def = iter_11_1.value + math.floor(iter_11_1.value * var_11_7 / 100)
					elseif iter_11_1.name == "air_def" then
						var_11_4.air_def = iter_11_1.value + math.floor(iter_11_1.value * var_11_7 / 100)
					end
				end
			end

			var_11_1.txt_1.tip.text.text = var_0_2:getNowLang("atk")
			var_11_1.txt_1.num.text.text = var_0_25(var_11_4.atk)
			var_11_1.txt_2.tip.text.text = var_0_2:getNowLang("equip3")
			var_11_1.txt_2.num.text.text = var_0_25(var_11_4.torpedo)
			var_11_1.txt_3.tip.text.text = var_0_2:getNowLang("def")
			var_11_1.txt_3.num.text.text = var_0_25(var_11_4.def)
			var_11_1.txt_4.tip.text.text = var_0_2:getNowLang("airdef")
			var_11_1.txt_4.num.text.text = var_0_25(var_11_4.air_def)
		elseif arg_11_1 == var_0_4.dock_detail_layer.third then
			var_11_1:SetActive(true)
			var_11_2:SetActive(false)

			var_11_1.txt_1.tip.text.text = var_0_2:getNowLang("radar")
			var_11_1.txt_1.num.text.text = var_0_25(self._data.attrs.radar)
			var_11_1.txt_2.tip.text.text = var_0_2:getNowLang("shiptype")
			var_11_1.txt_2.num.text.text = var_0_2:getNowLang(var_0_4:get_ship_size_language(self._data.type))
			var_11_1.txt_3.tip.text.text = var_0_2:getNowLang("luck")
			var_11_1.txt_3.num.text.text = var_0_25(self._data.attrs.luck)
			var_11_1.txt_4.tip.text.text = var_0_2:getNowLang("speed")
			var_11_1.txt_4.num.text.text = string.format("%.1f", self._data.attrs.speed)
		elseif arg_11_1 == var_0_4.dock_detail_layer.fourth then
			var_11_1:SetActive(true)
			var_11_2:SetActive(false)

			var_11_1.txt_1.tip.text.text = var_0_2:getNowLang("hp")
			var_11_1.txt_1.num.text.text = var_0_25(self._data.attrs.hp)
			var_11_1.txt_2.tip.text.text = var_0_2:getNowLang("miss")
			var_11_1.txt_2.num.text.text = var_0_25(self._data.attrs.miss)
			var_11_1.txt_3.tip.text.text = var_0_2:getNowLang("antisub")
			var_11_1.txt_3.num.text.text = var_0_25(self._data.attrs.antisub)
			var_11_1.txt_4.tip.text.text = var_0_2:getNowLang("range")
			var_11_1.txt_4.num.text.text = var_0_4:get_shoot_type_name(self._data.attrs.range)
		end
	end

	function arg_1_0:set_fast_team_num(arg_12_1, arg_12_2, arg_12_3)
		local var_12_0 = self._control.BG.all_layer

		if arg_12_3 and arg_12_3 == var_0_4.enter_select_member_type.tower or arg_12_3 and arg_12_3 == var_0_4.enter_select_member_type.ocean_attack_map_select then
			if arg_12_1 and arg_12_2 then
				var_12_0.mask_img:SetActive(true)

				var_12_0.mask_img.number_info.num.text.text = arg_12_2
			else
				var_12_0.mask_img:SetActive(false)
			end

			var_12_0.formation_layer:SetActive(self._data and self._data._can_not_act)

			return
		end

		if arg_12_1 and arg_12_2 then
			var_12_0.formation_layer:SetActive(false)
			var_12_0.mask_img:SetActive(true)

			var_12_0.mask_img.number_info.num.text.text = arg_12_2
			self._mask_active = true
		elseif arg_12_1 and not arg_12_2 then
			var_12_0.mask_img:SetActive(false)
			var_12_0.formation_layer:SetActive(false)

			if self._mask_active then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back_click))

				self._mask_active = false
			end
		else
			var_12_0.mask_img:SetActive(false)
		end

		if arg_12_3 and arg_12_3 == var_0_4.enter_select_member_type.six_year_map_select then
			var_12_0.sixth_fight_layer:SetActive(false)
		end
	end

	function arg_1_0:set_custom_team_num(arg_13_1, arg_13_2, arg_13_3)
		if arg_13_1 and arg_13_2 then
			self._control.BG.all_layer.formation_layer:SetActive(false)
			self._control.BG.all_layer.custom_img:SetActive(true)

			if arg_13_2 < 10 then
				self._control.BG.all_layer.custom_img.custom_info.custom_num.text.text = "00" .. arg_13_2
			elseif arg_13_2 >= 10 and arg_13_2 < 100 then
				self._control.BG.all_layer.custom_img.custom_info.custom_num.text.text = "0" .. arg_13_2
			elseif arg_13_2 >= 100 then
				self._control.BG.all_layer.custom_img.custom_info.custom_num.text.text = arg_13_2
			end

			self._mask_active = true
		elseif arg_13_1 and not arg_13_2 then
			self._control.BG.all_layer.custom_img:SetActive(false)
			self._control.BG.all_layer.formation_layer:SetActive(false)

			if self._mask_active then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back_click))

				self._mask_active = false
			end
		else
			self._control.BG.all_layer.custom_img:SetActive(false)
		end
	end

	function arg_1_0:set_fast_dock_disassemble_team_num(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
		if arg_14_1 and arg_14_2 and arg_14_4 == 1 then
			self._control.BG.all_layer.formation_layer:SetActive(false)
			self._control.BG.all_layer.mask_img:SetActive(true)

			self._control.BG.all_layer.mask_img.number_info.num.text.text = arg_14_2
			self._mask_active = true
		elseif arg_14_4 == 2 then
			self._control.BG.all_layer.mask_img:SetActive(false)
			self._control.BG.all_layer.formation_layer:SetActive(false)

			if self._mask_active then
				self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.back_click))

				self._mask_active = false
			end
		end
	end

	function arg_1_0:refresh()
		self._last_data = self._data and var_0_23.little_clone(self._data) or {}

		self:update_character_data()
		self:__set_supply_type_layer(true)
		self:__set_shell_layer_info()
	end

	function arg_1_0:set_main()
		self._control.BG.flag_ship:SetActive(true)
	end

	function arg_1_0:get_data()
		return self._data
	end

	function arg_1_0:get_need_supply()
		return self._need_supply
	end

	function arg_1_0:__init_panel(arg_19_1, arg_19_2, arg_19_3)
		self._data = arg_19_1 and var_0_23.little_clone(arg_19_1) or {}

		local var_19_0 = self._control.BG.all_layer

		self._control.BG.all_layer.formation_layer.formation_txt.text.text = var_0_2:getNowLang("inteam")
		var_19_0.expedition_layer.formation_txt.text.text = var_0_2:getNowLang("errorcode_139")
		var_19_0.stationed_layer.stationed_txt.text.text = var_0_2:getNowLang("inguard")

		self._control.BG.all_layer.formation_type_layer.detail_layer_mist:SetActive(false)
		self._control.BG.all_layer.restaurant_layer:SetActive(false)

		if arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_friend_fleet and not self._is_nf then
			local var_19_1 = var_0_13:find_character_by_id(self._data.id) or {}

			if self._data.cid and tonumber(string.sub(self._data.cid, 7)) == 18 then
				var_19_1 = var_0_13:find_abyss_character_by_id(self._data.id) or {}
			end

			local var_19_2 = var_0_5.find_object_by_cid(self._data.cid)

			if self._data and var_19_2 then
				self._data.hp = var_19_2.hp
			end

			if self._data and self._data.id and var_0_23:is_add_hp(var_19_1, var_19_2) and next(var_19_1) then
				self._data.hp = var_0_23:get_ship_attr(var_19_1, var_19_2).hp
			end
		end

		self:set_custom_info(self._data, var_19_0)

		local var_19_3 = self._control.BG.all_layer.formation_type_layer.strength_lock

		if self._control.BG.all_layer.formation_type_layer.strength_lock then
			if self._enter_type == var_0_4.enter_select_member_type.strengthen then
				var_19_3:SetActive(self._data.lock and true or false)
			else
				var_19_3:SetActive(false)
			end
		end

		local var_19_4 = var_0_3:getInstance("select_member")

		if var_19_4 and var_19_4._enter_type == var_0_4.enter_select_member_type.six_year_map_select then
			arg_19_2 = var_0_4.enter_select_member_type.six_year_map_select
		elseif var_19_4 and var_19_4._enter_type == var_0_4.enter_select_member_type.ocean_attack_map_select then
			arg_19_2 = var_0_4.enter_select_member_type.ocean_attack_map_select
		end

		self._control.BG.image.sprite = self:loadSprite(var_0_4.fight_prepare_ship_item.ship_leave)

		self:__init_active()

		local var_19_5 = false

		if arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_fleet and arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_friend_fleet and arg_19_2 ~= var_0_4.dock_team_toggle_type.active_station_fleet then
			for iter_19_0, iter_19_1 in pairs(self._data) do
				if iter_19_0 == "is_exist" then
					var_19_5 = iter_19_1
				end
			end
		end

		if var_19_5 then
			var_19_0:SetActive(false)
			self._control.team_id_info:SetActive(false)
			self._control.tower_cost:SetActive(false)

			return
		else
			local var_19_6
			local var_19_7 = var_0_23:use_big_break_painting(self._data, var_0_4.ship_icon_type.model_xm, true)

			var_19_0:SetActive(true)

			if self._is_nf then
				local var_19_8 = var_0_21.find_object_by_id(self._data.id)

				var_19_0.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[var_19_8.rarity])
				var_19_6 = var_0_4:get_ship_icon(var_19_7, tostring(var_19_8.pic_id), tostring(var_19_8.pic_id))

				var_19_0.status_layer:SetActive(false)
			else
				self._ship_config = var_0_5.find_object_by_cid(self._data.cid)
				var_19_0.love_layer.love.image.sprite = self:loadSprite(var_0_4:get_love_path_2(self._data, false))

				if arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_fleet then
					var_19_0.status_layer:SetActive(self._data.state == var_0_4.ship_state.repair)
				elseif arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_friend_fleet then
					var_19_0.status_layer:SetActive(false)
				end

				var_19_0.icon_layer.image.sprite = self:loadSprite(var_0_4.ship_quality_s[self._data.star])
			end

			if var_19_4 and var_19_4._enter_type == var_0_4.enter_select_member_type.tower then
				self._temp_config = self:__get_charactor_info_affected_from_tower_by_charactor_config(self._ship_config)
			end

			if arg_19_2 == var_0_4.dock_team_toggle_type.captainroom_friend_fleet then
				self._data.now_hp = self._data.hp
			end

			if not self._is_nf then
				if self._data.skin and self._data.skin ~= 0 then
					local var_19_9 = var_0_6.find_object_by_cid(self._data.skin).icon

					var_19_6 = var_0_4:get_ship_icon(var_19_7, tostring(var_19_9), tostring(var_19_9))
				else
					var_19_6 = var_0_4:get_ship_icon(var_19_7, tostring(self._ship_config.pic_id), tostring(self._ship_config.pic_id))
				end
			end

			var_19_0.icon_layer.icon.image.sprite = self:loadSprite(var_19_6)

			if arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_fleet then
				var_19_0.stationed_layer:SetActive(var_0_13:is_character_station_state(self._data.id))

				if var_0_13:get_to_mix() then
					var_19_0.stationed_layer.rectTransform.sizeDelta = var_0_16(126.8, 269)
				end
			elseif arg_19_2 ~= var_0_4.dock_team_toggle_type.captainroom_friend_fleet then
				var_19_0.stationed_layer:SetActive(false)
			end

			if self._data.state == var_0_4.ship_state.repair then
				var_19_0.status_layer.status_txt.text.text = var_0_2:getNowLang("inrepair")
			end

			if arg_19_2 == var_0_4.dock_team_toggle_type.formation or arg_19_2 == var_0_4.dock_team_toggle_type.captainroom_fleet or arg_19_2 == var_0_4.dock_team_toggle_type.captainroom_friend_fleet or arg_19_2 == var_0_4.dock_team_toggle_type.active_station_fleet then
				if arg_19_3 then
					return
				end

				var_19_0.formation_layer:SetActive(false)
			end

			if arg_19_2 == var_0_4.dock_team_toggle_type.captainroom_fleet or arg_19_2 == var_0_4.dock_team_toggle_type.captainroom_friend_fleet or arg_19_2 == var_0_4.dock_team_toggle_type.active_station_fleet or self._enter_type == var_0_4.enter_select_member_type.restaurant then
				self._control.team_id_info:SetActive(false)
			else
				for iter_19_2, iter_19_3 in pairs(self._data) do
					if iter_19_2 == "team_num" then
						self._team_num = iter_19_3
					end
				end

				if self._team_num == 0 then
					self._team_num = var_0_13:get_team_index_by_id(1, self._data.id)
				end

				local var_19_10 = var_0_3:getInstance("select_member")

				if var_19_10 then
					if var_19_10._enter_type == var_0_4.enter_select_member_type.dock_disassemble then
						self._control.team_id_info:SetActive(false)
					else
						self:set_team_id(self._team_num)
					end
				end
			end

			self:__set_tab_type(arg_19_2)
		end

		self:__set_guide_btn_state()

		if self._team_type then
			self:__set_team_type()
		else
			var_19_0.sixth_fight_layer:SetActive(false)
		end

		if self._enter_type == var_0_4.enter_select_member_type.six_year_primary then
			var_19_0.sixth_icon:SetActive(true)
			self._control.team_id_info:SetActive(false)

			var_19_0.sixth_icon.money.text.text = self._ship_config.strategic_point
		elseif arg_19_2 == var_0_4.enter_select_member_type.six_year_map_select then
			var_19_0.sixth_icon:SetActive(false)
			self._control.team_id_info:SetActive(false)

			if self._is_nf then
				self:__set_mist_ship_level()
			else
				self:__set_sixth_ship_level()
			end
		else
			var_19_0.sixth_icon:SetActive(false)
		end
	end

	function arg_1_0._set_nf_data_info(arg_20_0)
		return
	end

	function arg_1_0:__set_team_type()
		local var_21_0 = self._control.BG.all_layer

		self._control.BG.all_layer.formation_layer.formation_txt.text.text = var_0_2:getNowLang("inteam")
		var_21_0.expedition_layer.formation_txt.text.text = var_0_2:getNowLang("errorcode_139")

		local var_21_1 = var_0_3:getInstance("select_member")

		var_21_0.sixth_fight_layer:SetActive(false)
		var_21_0.expedition_layer:SetActive(false)

		if self._team_type == var_0_4.team_type.sixth_team then
			local var_21_2 = var_0_13:get_sixth_combat_info()

			if var_21_2.members then
				for iter_21_0, iter_21_1 in pairs(var_21_2.members) do
					if self._data.id == iter_21_1 then
						self._is_can_click = false

						var_21_0.sixth_fight_layer:SetActive(true)
					end
				end

				var_21_0.sixth_fight_layer:SetActive(not self._is_can_click)
			end
		elseif self._data.state == var_0_4.ship_state.expedition then
			self._is_can_click = true

			var_21_0.expedition_layer:SetActive(true)
		elseif self._data.state == var_0_4.ship_state.repair then
			self._is_can_click = true

			var_21_0.status_layer:SetActive(true)
		end

		if var_21_0.expedition_layer.gameObject.activeSelf then
			var_21_0.formation_layer:SetActive(false)
		end

		if var_21_0.formation_layer.gameObject.activeSelf then
			var_21_0.status_layer:SetActive(false)

			if var_21_1._is_fast_formation and self._data.state == var_0_4.ship_state.repair then
				var_21_0.status_layer:SetActive(true)
			end
		end
	end

	function arg_1_0:__set_guide_btn_state()
		if var_0_13:get_guide_state() then
			self._control.BG.all_layer.button.enabled = true
			self._control.BG.all_layer.image.raycastTarget = true
			self._control.BG.clickAndLongClickEvent.enabled = false
		else
			self._control.BG.clickAndLongClickEvent.enabled = true
			self._control.BG.all_layer.button.enabled = false
			self._control.BG.all_layer.image.raycastTarget = false
		end
	end

	function arg_1_0.__get_cur_team_index(arg_23_0)
		local var_23_0 = var_0_3:getInstance("dock_team")

		if var_23_0 then
			return var_23_0:get_current_team_index()
		else
			local var_23_1 = var_0_3:getInstance("fight_prepare")

			if var_23_1 then
				return var_23_1:get_current_team_index()
			end
		end
	end

	function arg_1_0:__set_tab_type(arg_24_1)
		local var_24_0 = self._control.BG.all_layer.formation_type_layer
		local var_24_1 = self._control.BG.all_layer

		self._control.BG.all_layer.strike_layer:SetActive(false)

		if self._is_nf then
			var_24_1.love_layer:SetActive(false)
		else
			var_24_1.love_layer:SetActive(true)
		end

		var_24_0.level_layer.lock_tag:SetActive(true)
		self._control.tower_cost:SetActive(self._enter_type == var_0_4.enter_select_member_type.tower)

		if self._enter_type == var_0_4.enter_select_member_type.strengthen or self._enter_type == var_0_4.enter_select_member_type.skill then
			var_24_0:SetActive(true)
			var_24_0.level_layer:SetActive(false)
			var_24_1.formation_layer:SetActive(false)

			if self._data.state == var_0_4.ship_state.expedition then
				var_24_1.expedition_layer:SetActive(true)
			end

			if self._data.state == var_0_4.ship_state.repair then
				var_24_1.status_layer:SetActive(true)
			end

			self._control.team_id_info:SetActive(false)

			if var_0_3:getInstance("select_member")._panel_type == var_0_4.enter_select_member_type.custom_ship then
				var_24_0.strength_level_layer:SetActive(false)
				var_24_0.level_layer:SetActive(true)
				self:__set_level_layer(var_24_0.level_layer)
			else
				var_24_0.strength_level_layer:SetActive(true)
				var_24_0.level_layer:SetActive(false)
			end

			var_24_0.strength_level_layer.info_bg:SetActive(false)
			var_24_1.supply_type_layer:SetActive(false)
			var_24_1.equipment_type_layer:SetActive(false)
			self:__set_formation_type_layer_for_strength()

			return
		elseif self._enter_type == var_0_4.enter_select_member_type.six_year_map_select then
			var_24_1.formation_layer:SetActive(false)
			var_24_1.expedition_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)
		elseif self._enter_type == var_0_4.enter_select_member_type.evo then
			var_24_1.formation_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)

			if self._data.state == var_0_4.ship_state.expedition then
				var_24_1.expedition_layer:SetActive(true)
			end

			if self._data.state == var_0_4.ship_state.repair then
				var_24_1.status_layer:SetActive(true)
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.college then
			var_24_1.formation_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)

			if self._data.state == var_0_4.ship_state.expedition then
				var_24_1.expedition_layer:SetActive(true)
			end

			if self._data.state == var_0_4.ship_state.repair then
				var_24_1.status_layer:SetActive(true)
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.captainroom_fleet then
			self._control.team_id_info:SetActive(false)
		elseif self._enter_type == var_0_4.enter_select_member_type.dormitory then
			self._control.team_id_info:SetActive(false)
		elseif self._enter_type == var_0_4.enter_select_member_type.tower then
			self._control.team_id_info:SetActive(false)
			self:__set_tower_cost_num()
			self:__show_if_can_not_act_mask()
		elseif self._enter_type == var_0_4.enter_select_member_type.war_concerto_play then
			var_24_1.love_layer:SetActive(false)
			var_24_1.formation_layer:SetActive((self:__check_is_in_team()))
			var_24_0.level_layer.lock_tag:SetActive(false)
		elseif self._enter_type == var_0_4.enter_select_member_type.abyss_dock_team_formation then
			var_24_1.love_layer:SetActive(true)

			local var_24_2 = self:__check_is_in_abyss_team()

			var_24_1.formation_layer:SetActive(var_24_2)
			var_24_0.level_layer.lock_tag:SetActive(not var_24_2)
		elseif self._enter_type == var_0_4.enter_select_member_type.strike_map_select then
			var_24_1.formation_layer:SetActive(false)

			local var_24_3 = var_0_3:getInstance("fight_prepare")

			if var_24_3 and var_24_3._current_strike_buffs then
				for iter_24_0, iter_24_1 in pairs(var_24_3._current_strike_buffs) do
					if not iter_24_1.replace then
						local var_24_4 = iter_24_1.id < 1000 and var_0_19.find_object_by_id(iter_24_1.id) or var_0_18.find_object_by_id(iter_24_1.id)

						if iter_24_1.state then
							var_24_4 = var_0_18.find_object_by_id(iter_24_1.change_id)
						end

						var_24_1.strike_layer.strike_txt.text.text = var_0_2:getNowLang("ui_ship_status_forbidden")

						for iter_24_2, iter_24_3 in pairs(var_24_4.effect) do
							if iter_24_3.type == 38 then
								local var_24_5 = var_0_13:get_strike_point_info().use_ship or {}

								if next(var_24_5) then
									for iter_24_4, iter_24_5 in pairs(var_24_5) do
										if self._data.id == iter_24_5 then
											var_24_1.strike_layer:SetActive(true)

											if self._data.state == var_0_4.ship_state.expedition then
												var_24_1.strike_layer:SetActive(false)

												break
											end

											if self._data.state == var_0_4.ship_state.repair then
												var_24_1.strike_layer:SetActive(false)
											end

											break
										end
									end
								end

								break
							end

							if not var_24_3:select_ship_by_pvebuff({
								self._data.id
							}, iter_24_3, var_0_4.fight_type.strike) then
								if iter_24_3.type == 1 or iter_24_3.type == 3 or iter_24_3.type == 5 then
									var_24_1.strike_layer:SetActive(true)

									if self._data.state == var_0_4.ship_state.expedition then
										var_24_1.strike_layer:SetActive(false)
									elseif self._data.state == var_0_4.ship_state.repair then
										var_24_1.strike_layer:SetActive(false)
									end
								elseif iter_24_3.type == 26 then
									var_24_1.strike_layer:SetActive(true)

									if self._data.state == var_0_4.ship_state.expedition then
										var_24_1.strike_layer:SetActive(false)
									elseif self._data.state == var_0_4.ship_state.repair then
										var_24_1.strike_layer:SetActive(false)
									end
								end

								if iter_24_3.type == 3 and iter_24_3.num == 0 and var_0_5.find_object_by_cid(self._data.cid).country == iter_24_3.country then
									var_24_1.strike_layer:SetActive(true)
								end
							end
						end
					end
				end
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.ocean_attack_map_select then
			local var_24_6 = var_0_13:get_ocean_team_data(self._go_to_map_id)

			if var_24_6 and next(var_24_6) then
				var_24_1.formation_layer:SetActive(false)

				for iter_24_6, iter_24_7 in pairs(var_24_6) do
					if self._data.id == iter_24_7 then
						var_24_1.formation_layer:SetActive(true)
					end
				end
			end
		elseif self._team_type == var_0_4.team_type.campaign then
			local var_24_7 = var_0_13:get_campaign_data(self._go_to_map_id)
			local var_24_8 = false

			if var_24_7 and var_24_7.info and var_24_7.info.members then
				var_24_1.formation_layer:SetActive(false)

				for iter_24_8, iter_24_9 in pairs(var_24_7.info.members) do
					if self._data.id == iter_24_9 then
						var_24_8 = true

						break
					end
				end
			end

			if var_24_8 then
				var_24_1.formation_layer:SetActive(true)
			else
				if self._data.state == var_0_4.ship_state.expedition then
					var_24_1.expedition_layer:SetActive(true)
				end

				if self._data.state == var_0_4.ship_state.repair then
					var_24_1.status_layer:SetActive(true)
				end
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.strengthen_res then
			self._control.team_id_info:SetActive(false)
		elseif self._enter_type == var_0_4.enter_select_member_type.pre_formation then
			local var_24_10 = var_0_3:getInstance("pre_formation")

			if ((var_24_10 or nil) and var_24_10:get_sub_type()) == var_0_4.fight_prepare_right_panel_type.tower then
				self._control.team_id_info:SetActive(false)
				self._control.tower_cost:SetActive(true)
				self:__set_tower_cost_num()
				self:__show_if_can_not_act_mask()
			else
				if self._data.state == var_0_4.ship_state.expedition then
					var_24_1.expedition_layer:SetActive(true)
				end

				if self._data.state == var_0_4.ship_state.repair then
					var_24_1.status_layer:SetActive(true)
				end
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.fight then
			var_24_1.formation_layer:SetActive(false)
			var_24_1.strike_layer:SetActive(false)

			local var_24_11 = self:__get_cur_team_index()

			if (var_24_11 and var_24_11 ~= 0 and self._team_num and self._team_num ~= 0 or nil) and self._team_num == var_24_11 then
				var_24_1.formation_layer:SetActive(true)
			else
				if self._data.state == var_0_4.ship_state.expedition then
					var_24_1.expedition_layer:SetActive(true)
				end

				if self._data.state == var_0_4.ship_state.repair then
					var_24_1.status_layer:SetActive(true)
				end
			end
		elseif self._enter_type == var_0_4.enter_select_member_type.dock_team or self._enter_type == var_0_4.enter_select_member_type.dock_team_empty then
			if self._data.state == var_0_4.ship_state.expedition then
				var_24_1.expedition_layer:SetActive(true)
			end

			if self._data.state == var_0_4.ship_state.repair then
				var_24_1.status_layer:SetActive(true)
			end
		end

		if self._tab_type == var_0_4.dock_team_toggle_type.formation or self._tab_type == var_0_4.dock_team_toggle_type.tactics_type then
			var_24_0:SetActive(true)
			var_24_0.level_layer:SetActive(true)
			var_24_0.strength_level_layer:SetActive(false)
			var_24_1.supply_type_layer:SetActive(false)
			var_24_1.equipment_type_layer:SetActive(false)
			self:__set_formation_type_layer()
		elseif self._tab_type == var_0_4.dock_team_toggle_type.supply then
			var_24_0:SetActive(false)
			var_24_1.supply_type_layer:SetActive(true)
			var_24_1.equipment_type_layer:SetActive(false)
			var_24_1.formation_layer:SetActive(false)
			var_24_1.expedition_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)
			self:__set_supply_type_layer()
			self:__set_shell_layer_info()
			self:__show_dock_supply_equip_expedition()
			self:__show_dock_supply_equip_status()
		elseif self._tab_type == var_0_4.dock_team_toggle_type.equipment then
			var_24_0:SetActive(false)
			var_24_1.supply_type_layer:SetActive(false)
			var_24_1.equipment_type_layer:SetActive(true)
			var_24_1.formation_layer:SetActive(false)
			var_24_1.expedition_layer:SetActive(false)
			var_24_1.shell_layer:SetActive(false)
			self._control.team_id_info:SetActive(false)
			self:__set_equipment_type_layer()
			self:__show_dock_supply_equip_expedition()
			self:__show_dock_supply_equip_status()
		elseif self._tab_type == var_0_4.dock_team_toggle_type.captainroom_fleet or self._tab_type == var_0_4.dock_team_toggle_type.dormitory or self._tab_type == var_0_4.dock_team_toggle_type.captainroom_friend_fleet or self._tab_type == var_0_4.dock_team_toggle_type.active_station_fleet then
			var_24_0:SetActive(true)
			var_24_1.supply_type_layer:SetActive(false)
			var_24_1.equipment_type_layer:SetActive(false)
			self:__set_formation_type_layer()
		elseif self._tab_type == var_0_4.dock_team_toggle_type.abyss_team_formation then
			self:__set_formation_type_layer()
		end

		if self._tab_type == var_0_4.dock_team_toggle_type.captainroom_friend_fleet then
			if self._data.marry then
				var_24_1.love_layer:SetActive(true)
			else
				var_24_1.love_layer:SetActive(false)
			end

			var_24_0.level_layer.lock_tag:SetActive(false)
		end

		local var_24_13 = var_0_3:getInstance("select_member")

		if var_24_13 and var_24_13._enter_type == var_0_4.enter_select_member_type.dock_disassemble then
			var_24_1.expedition_layer:SetActive(false)
		end
	end

	function arg_1_0:__show_if_can_not_act_mask()
		self._control.BG.all_layer.formation_layer:GetComponent("Image").enabled = true

		self._control.BG.all_layer.strike_layer:SetActive(false)

		if self._data._can_not_act then
			self._control.BG.all_layer.formation_layer:GetComponent("Image").enabled = false

			self._control.BG.all_layer.strike_layer:SetActive(true)

			self._control.BG.all_layer.strike_layer.strike_bg.image.sprite = self:loadSprite("data/ui/ship/ship_on_forbidden_m.png")
			self._control.BG.all_layer.strike_layer.strike_txt.text.text = var_0_2:getNowLang("ui_ship_status_used")
		elseif self._control.BG.all_layer.activeSelf then
			self._control.BG.all_layer.formation_layer.formation_bg.image.sprite = self:loadSprite("data/ui/ship/ship_on_team_s.png")
			self._control.BG.all_layer.formation_layer.formation_txt.text.text = var_0_2:getNowLang("inteam")
		end
	end

	function arg_1_0:__show_dock_supply_equip_expedition()
		if self._tab_type == var_0_4.dock_team_toggle_type.supply and self._data.state == var_0_4.ship_state.expedition then
			self._control.BG.all_layer.expedition_layer:SetActive(true)

			self._control.BG.all_layer.expedition_layer.formation_bg.rectTransform.anchoredPosition = var_0_16(0, 68)
			self._control.BG.all_layer.expedition_layer.formation_txt.rectTransform.anchoredPosition = var_0_16(0, 68)
		end

		if self._tab_type == var_0_4.dock_team_toggle_type.equipment and self._data.state == var_0_4.ship_state.expedition then
			self._control.BG.all_layer.expedition_layer:SetActive(true)

			self._control.BG.all_layer.expedition_layer.formation_bg.rectTransform.anchoredPosition = var_0_16(0, 45)
			self._control.BG.all_layer.expedition_layer.formation_txt.rectTransform.anchoredPosition = var_0_16(0, 45)
		end
	end

	function arg_1_0:__show_dock_supply_equip_status()
		if self._tab_type == var_0_4.dock_team_toggle_type.supply and self._data.state == var_0_4.ship_state.repair then
			self._control.BG.all_layer.status_layer:SetActive(true)

			self._control.BG.all_layer.status_layer.status.rectTransform.anchoredPosition = var_0_16(0, 68)
			self._control.BG.all_layer.status_layer.status_txt.rectTransform.anchoredPosition = var_0_16(-45.785, 68)
		end

		if self._tab_type == var_0_4.dock_team_toggle_type.equipment and self._data.state == var_0_4.ship_state.repair then
			self._control.BG.all_layer.status_layer:SetActive(true)

			self._control.BG.all_layer.status_layer.status.rectTransform.anchoredPosition = var_0_16(0, 45)
			self._control.BG.all_layer.status_layer.status_txt.rectTransform.anchoredPosition = var_0_16(-45.785, 45)
		end
	end

	function arg_1_0:__set_formation_type_layer()
		local var_28_0 = self._control.BG.all_layer.formation_type_layer
		local var_28_1 = self._control.BG.all_layer.formation_type_layer.info_layer:GetComponent("TextHorizonScroller")

		if self._is_nf then
			var_28_1:SetText(var_0_21.find_object_by_id(self._data.id).shipnamecn)
		else
			var_28_1:SetText(self._data.name)
		end

		self:__set_hp_layer(var_28_0.hp_layer)
		self:__set_level_layer(var_28_0.level_layer)
	end

	function arg_1_0:__set_shell_layer_info()
		self._equips_info = {
			num = 0,
			carry_type = 1
		}

		local var_29_0 = 0

		for iter_29_0, iter_29_1 in ipairs(self._data.equips) do
			if iter_29_1.carry_type and iter_29_1.carry_type > var_0_4.equip_carry_type.normal and self._tab_type == var_0_4.dock_team_toggle_type.supply then
				self._equips_info.carry_type = iter_29_1.carry_type
				self._equips_info.num = self._equips_info.num + iter_29_1.num

				if iter_29_1.carry_type == var_0_4.equip_carry_type.plane then
					local var_29_1 = self._ship_config.capacity_slot or self._ship_config.missile_slot

					if var_29_1 and next(var_29_1) and var_29_1[iter_29_0] then
						var_29_0 = var_29_0 + var_29_1[iter_29_0]
					end
				end
			end
		end

		self._config_count = var_29_0

		if self._equips_info.carry_type ~= var_0_4.equip_carry_type.normal then
			local var_29_2

			if self._equips_info.num / var_29_0 >= 0.5 then
				var_29_2 = var_0_4.dock_carry_icon[self._equips_info.carry_type]
			elseif self._equips_info.num / var_29_0 >= 0.25 and self._equips_info.num / var_29_0 < 0.5 then
				var_29_2 = var_0_4.dock_carry_icon2[self._equips_info.carry_type]
			elseif self._equips_info.num / var_29_0 < 0.25 then
				var_29_2 = var_0_4.dock_carry_icon3[self._equips_info.carry_type]
			end

			self._control.BG.all_layer.shell_layer.icon.image.sprite = self:loadSprite(var_29_2)
			self._control.BG.all_layer.shell_layer.count_txt.text.text = var_0_11("%s/%s", self._equips_info.num, var_29_0)

			self._control.BG.all_layer.shell_layer:SetActive(true)

			if var_29_0 > self._equips_info.num and not self._need_supply then
				self._need_supply = true
			end
		else
			self._control.BG.all_layer.shell_layer:SetActive(false)
		end
	end

	function arg_1_0:__set_supply_type_layer(arg_30_1)
		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer:GetComponent("TextHorizonScroller"):SetText(self._data.name)
		self:__set_hp_layer(self._control.BG.all_layer.supply_type_layer.hp_layer)
		self:__set_level_layer(self._control.BG.all_layer.supply_type_layer.level_layer)

		self._control.BG.all_layer.supply_type_layer.info_layer.name_layer.name_level.text.text = self._data.name
		self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.Tip.text.text = var_0_2:getNowLang("ammo") .. ":"
		self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.Tip.text.text = var_0_2:getNowLang("fuel") .. ":"

		if not arg_30_1 then
			self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.transform, 10 * (self._data.now_bullet / self._data.bullet), var_0_22.bullet)
			self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.transform, 10 * (self._data.now_oil / self._data.oil), var_0_22.oil)
		else
			self:__refresh_animation()
		end

		self._need_supply = self._data.now_oil < self._data.oil or self._data.now_bullet < self._data.bullet
	end

	function arg_1_0:__set_equipment_type_layer()
		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer:GetComponent("TextHorizonScroller"):SetText(self._data.name)

		self._control.BG.all_layer.equipment_type_layer.info_layer.name_layer.name_level.text.text = self._data.name

		self:__set_level_layer(self._control.BG.all_layer.equipment_type_layer.level_layer)

		for iter_31_0 = 1, self._control.BG.all_layer.equipment_type_layer.info_layer.equip_list.transform.childCount do
			local var_31_0 = self._control.BG.all_layer.equipment_type_layer.info_layer.equip_list.transform:GetChild(iter_31_0 - 1).gameObject

			if iter_31_0 > self._data.equipment_num then
				var_31_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.no_s)

				var_31_0.icon:SetActive(false)
			elseif self._data.equips[iter_31_0] and self._data.equips[iter_31_0].id and self._data.equips[iter_31_0].id > 0 then
				local var_31_1 = var_0_10.find_object_by_cid(self._data.equips[iter_31_0].id)

				var_31_0.icon:SetActive(true)

				var_31_0.frame.image.sprite = self:loadSprite(var_0_4.equip_quality_frame[var_31_1.star])
				var_31_0.icon.image.sprite = self:loadSprite(var_0_11(var_0_4.equip_icon.large, var_31_1.pic_id))
			else
				var_31_0.frame.image.sprite = self:loadSprite(var_0_4.equip_icon.empty_s)

				var_31_0.icon:SetActive(false)
			end
		end
	end

	function arg_1_0:__set_formation_type_layer_for_strength()
		self._control.BG.all_layer.formation_type_layer.info_layer:GetComponent("TextHorizonScroller"):SetText(self._data.name)
		self:__set_hp_layer(self._control.BG.all_layer.formation_type_layer.hp_layer)
		self:__set_strength_level_layer(self._control.BG.all_layer.formation_type_layer.strength_level_layer)
	end

	function arg_1_0:__set_hp_layer(arg_33_1)
		if self._data.now_hp then
			local var_33_0 = self._data.now_hp / self._data.hp
			local var_33_1

			if self._data.now_hp / self._data.hp >= 0.25 and var_33_0 < 0.5 then
				var_33_1 = var_0_4.ship_hp_slider.ship_hp_l_yellow
			elseif var_33_0 < 0.25 then
				var_33_1 = var_0_4.ship_hp_slider.ship_hp_l_red
			end

			arg_33_1.full_img.image.sprite = self:loadSprite(var_0_4.ship_hp_slider.ship_hp_l_green)
			arg_33_1.full_img.image.fillAmount = var_33_0
		end
	end

	function arg_1_0:__set_level_layer(arg_34_1)
		if self._is_nf then
			local var_34_1 = var_0_21.find_object_by_id(self._data.id or self._ship_config.id)

			arg_34_1.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_nf_ship_type_language_key(var_34_1.shiptype))
			arg_34_1.country_txt.text.text = ""
			arg_34_1.level_txt.text.text = var_0_11("LV.%d", var_34_1.maxlevel)
			arg_34_1.level_txt.text.color = Color.New(0.996078431372549, 0.9882352941176471, 0)

			arg_34_1.lock_tag:SetActive(false)
			arg_34_1.ship_remake:SetActive(false)

			for iter_34_0 = 1, arg_34_1.star_layer.transform.childCount do
				if iter_34_0 <= var_34_1.rarity then
					arg_34_1.star_layer.transform:GetChild(iter_34_0 - 1).gameObject:SetActive(true)
				else
					arg_34_1.star_layer.transform:GetChild(iter_34_0 - 1).gameObject:SetActive(false)
				end
			end
		else
			arg_34_1.lock_tag:SetActive(true)

			arg_34_1.type_txt.text.text = var_0_2:getNowLang(var_0_4:get_ship_type_language_key(self._ship_config.type, 1))
			arg_34_1.country_txt.text.text = var_0_11("(%s)", var_0_2:getNowLang(var_0_4:get_country_language_key(self._ship_config.country)))
			arg_34_1.level_txt.text.text = var_0_11("LV.%d", self._data.level)
			arg_34_1.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)

			arg_34_1.ship_remake:SetActive(self._ship_config.evo_class)

			for iter_34_1 = 1, arg_34_1.star_layer.transform.childCount do
				if iter_34_1 <= self._data.star then
					arg_34_1.star_layer.transform:GetChild(iter_34_1 - 1).gameObject:SetActive(true)
				else
					arg_34_1.star_layer.transform:GetChild(iter_34_1 - 1).gameObject:SetActive(false)
				end
			end
		end

		arg_34_1.lock_tag.image.sprite = self._data.lock and self:loadSprite(var_0_4.ship_lock.ship_lock_s) or self:loadSprite(var_0_4.ship_unlock.ship_unlock_s)
	end

	function arg_1_0:__set_info_num(arg_35_1, arg_35_2, arg_35_3)
		local var_35_0

		if arg_35_3 == var_0_22.bullet then
			var_35_0 = var_0_4.supply_info_icon.bullet_empty_m
		elseif arg_35_3 == var_0_22.oil then
			var_35_0 = var_0_4.supply_info_icon.oil_empty_m
		end

		local var_35_1, var_35_2 = var_0_14(arg_35_2)
		local var_35_3 = false

		if var_35_1 >= 8 then
			arg_35_2 = math.floor(arg_35_2)
		elseif var_35_1 >= 6 and var_35_2 > 0 and var_35_1 < 8 then
			var_35_3 = true
			arg_35_2 = 8
		elseif var_35_1 > 6 and var_35_2 == 0 and var_35_1 < 8 then
			arg_35_2 = 8
		elseif var_35_1 < 6 and var_35_1 >= 4 and var_35_2 > 0 then
			var_35_3 = true
			arg_35_2 = 6
		elseif var_35_1 <= 6 and var_35_1 > 4 and var_35_2 == 0 then
			arg_35_2 = 6
		elseif var_35_1 >= 2 and var_35_1 < 4 and var_35_2 > 0 then
			var_35_3 = true
			arg_35_2 = 4
		else
			arg_35_2 = var_35_1 > 2 and var_35_1 <= 4 and 4 or var_35_1 > 0 and var_35_1 <= 2 and 2 or var_35_1 == 0 and var_35_2 > 0 and 2 or var_35_1 == 0 and var_35_2 == 0 and 0 or math.floor(arg_35_2)
		end

		if arg_35_2 > 10 then
			arg_35_2 = 10
		end

		arg_35_2 = arg_35_2 / 2

		for iter_35_0 = 1, arg_35_1.childCount do
			arg_35_1:GetChild(iter_35_0 - 1).gameObject.image.sprite = iter_35_0 <= arg_35_2 and self:loadSprite((self:__set_color_supply(arg_35_3, arg_35_2, var_35_3))) or self:loadSprite(var_35_0)

			if self._data.now_bullet > self._data.bullet then
				self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.star_1.image.sprite = self:loadSprite(var_0_4.supply_info_icon.bullet_green)
			end
		end
	end

	function arg_1_0.__set_color_supply(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		local var_36_0

		if arg_36_2 <= 1 and arg_36_2 > 0 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_red
			end
		elseif arg_36_3 and arg_36_2 <= 2 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_red
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_36_2 <= 2 and arg_36_2 > 1 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_36_2 >= 2 and arg_36_2 < 4 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_yellow
			end
		elseif arg_36_3 and arg_36_2 >= 4 and arg_36_2 <= 5 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_yellow
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_blue
			end
		elseif arg_36_2 >= 4 and arg_36_2 <= 5 then
			if arg_36_1 == var_0_22.bullet then
				var_36_0 = var_0_4.supply_info_icon.bullet_blue
			elseif arg_36_1 == var_0_22.oil then
				var_36_0 = var_0_4.supply_info_icon.oil_blue
			end
		end

		return var_36_0
	end

	function arg_1_0:__refresh_animation()
		local var_37_0 = self:autoKillDOTween(var_0_12.Sequence())
		local var_37_1 = self:autoKillDOTween(var_0_12.Sequence())

		for iter_37_0 = 1, 10 * self._data.now_bullet / self._data.bullet - 10 * self._last_data.now_bullet / self._last_data.bullet do
			local function var_37_2()
				self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.ammunition_layer.ammunition_img.transform, 10 * (self._last_data.now_bullet / self._last_data.bullet) + iter_37_0, var_0_22.bullet)
			end

			var_37_0:AppendInterval(0.1)
			var_37_0:AppendCallback(var_37_2)
		end

		for iter_37_1 = 1, 10 * self._data.now_bullet / self._data.bullet - 10 * self._last_data.now_bullet / self._last_data.bullet do
			local function var_37_3()
				self:__set_info_num(self._control.BG.all_layer.supply_type_layer.info_layer.fuel_layer.fuel_img.transform, 10 * (self._last_data.now_oil / self._last_data.oil) + iter_37_1, var_0_22.oil)
			end

			var_37_1:AppendInterval(0.1)
			var_37_1:AppendCallback(var_37_3)
		end

		var_37_0:Play()
		var_37_1:Play()
	end

	function arg_1_0:__set_strength_level_layer(arg_40_1)
		arg_40_1.level_txt.text.color = self._data.level < 110 and Color.New(1, 1, 1) or Color.New(0.996078431372549, 0.9882352941176471, 0)
		arg_40_1.level_txt.text.text = var_0_11("Lv.%d", self._data.level)
		arg_40_1.slv_txt.text.text = var_0_11("Slv.%d", self._data.skill_level)

		local var_40_1 = var_0_5.find_object_by_cid(self._data.cid)

		for iter_40_0, iter_40_1 in ipairs(var_40_1.strengthen_top) do
			local var_40_2

			if iter_40_1.name == "atk" then
				var_40_2 = arg_40_1.item_1
			elseif iter_40_1.name == "torpedo" then
				var_40_2 = arg_40_1.item_2
			elseif iter_40_1.name == "def" then
				var_40_2 = arg_40_1.item_3
			elseif iter_40_1.name == "air_def" then
				var_40_2 = arg_40_1.item_4
			end

			var_40_2.have.add:SetActive(true)
			var_40_2.have.max:SetActive(false)
			var_40_2.no:SetActive(iter_40_1.value == 0)
			var_40_2.have:SetActive(iter_40_1.value ~= 0)

			var_40_2.have.add.num.text.text = 0

			for iter_40_2, iter_40_3 in pairs(self._data.intensify or {}) do
				if iter_40_1.name == iter_40_3.attr and iter_40_1.value ~= 0 then
					local var_40_3 = iter_40_1.value / var_40_1.strengthen_level_up_exp

					var_40_2.have.add.num.text.text = var_0_25(iter_40_3.exp / var_40_1.strengthen_level_up_exp)

					var_40_2.have.max:SetActive(var_40_3 <= iter_40_3.exp / var_40_1.strengthen_level_up_exp)
					var_40_2.have.add:SetActive(var_40_3 > iter_40_3.exp / var_40_1.strengthen_level_up_exp)
				end
			end
		end
	end

	function arg_1_0:__add_collections_attr(arg_41_1)
		local var_41_0 = var_0_5.find_object_by_cid(self._data.cid)

		for iter_41_0, iter_41_1 in pairs((var_0_13:get_player_desk_collection_data())) do
			local var_41_1 = var_0_7.find_object_by_cid(iter_41_1.id)

			if var_41_1 then
				local var_41_2 = var_0_15(var_41_1.buff_effect.attr)

				if (var_41_1.buff_effect.ship_type == 0 or var_41_1.buff_effect.ship_type == var_41_0.type) and (var_41_1.buff_effect.country == 0 or var_41_1.buff_effect.country == var_41_0.country) and arg_41_1[var_41_2] then
					arg_41_1[var_41_2] = arg_41_1[var_41_2] + var_41_1.buff_effect.val
				end
			end
		end
	end

	function arg_1_0:__add_skill_attr(arg_42_1)
		local var_42_0 = var_0_13:get_character_attribute_by_calculate_no_equips(self._data.id)
		local var_42_1 = not self._data.now_skill and var_0_8.find_object_by_skill_id(self._data.skill_id) or var_0_8.find_object_by_skill_type_skill_level(self._data.now_skill, self._data.skill_level)

		if not var_42_1 then
			return
		end

		self._detail_attr_table = {
			"hp",
			"atk",
			"def",
			"torpedo",
			"miss",
			"air_def",
			"capacity",
			nil,
			"antisub",
			"speed",
			"radar",
			"range",
			"luck",
			nil,
			nil,
			"crit",
			"hit",
			nil,
			"ext"
		}

		local var_42_2
		local var_42_3

		if var_42_1.effect[1] then
			for iter_42_0, iter_42_1 in pairs(var_42_1.effect) do
				if var_42_1.effect[iter_42_0].type == 1 and var_42_1.effect[iter_42_0].stage[1] == 1 then
					for iter_42_2, iter_42_3 in pairs(var_42_1.effect[iter_42_0].effect) do
						if iter_42_3.type == 3 then
							for iter_42_4, iter_42_5 in pairs(self._detail_attr_table) do
								if iter_42_3[self._detail_attr_table[iter_42_4]] then
									var_42_2 = self._detail_attr_table[iter_42_4]
									var_42_3 = iter_42_3[self._detail_attr_table[iter_42_4]]
								end
							end

							if var_42_2 and var_42_3 and arg_42_1[var_42_2] then
								var_42_3 = var_42_3 * var_0_23.get_attr_multiple_by_config(var_42_1, data, iter_42_0)
								arg_42_1[var_42_2] = arg_42_1[var_42_2] + var_42_3
							end
						elseif iter_42_3.type == 4 then
							for iter_42_6, iter_42_7 in pairs(iter_42_3) do
								if iter_42_6 ~= "type" then
									arg_42_1[iter_42_6] = arg_42_1[iter_42_6] or 1
									arg_42_1[iter_42_6] = arg_42_1[iter_42_6] + arg_42_1[iter_42_6] * iter_42_7
								end
							end
						elseif iter_42_3.type == 5 then
							if arg_42_1[self._detail_attr_table[iter_42_3.attribute]] and arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] then
								arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] = arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] + arg_42_1[self._detail_attr_table[iter_42_3.attribute]] * iter_42_3.rate
							end
						elseif iter_42_3.type == 94 then
							if arg_42_1.range >= iter_42_3.num then
								arg_42_1.range = arg_42_1.range or iter_42_3.num
							end
						elseif iter_42_3.type == 49 then
							for iter_42_8, iter_42_9 in ipairs(self._data.equips) do
								if iter_42_9.id then
									local var_42_5 = var_0_10.find_object_by_cid(iter_42_9.id)

									if var_42_5 then
										for iter_42_10, iter_42_11 in pairs(var_42_5) do
											if iter_42_10 ~= "range" and iter_42_10 ~= "hp" and arg_42_1[iter_42_10] and iter_42_11 ~= 0 then
												arg_42_1[iter_42_10] = arg_42_1[iter_42_10] + iter_42_11 * iter_42_3.rate
											end
										end
									end
								end
							end
						elseif iter_42_3.type == 50 then
							for iter_42_12, iter_42_13 in ipairs(self._data.equips) do
								if iter_42_13.id and iter_42_13.id > 0 then
									local var_42_6 = var_0_10.find_object_by_cid(iter_42_13.id)

									if arg_42_1[self._detail_attr_table[iter_42_3.attribute]] and var_42_6[self._detail_attr_table[iter_42_3.attribute]] and arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] then
										arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] = arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] + var_42_6[self._detail_attr_table[iter_42_3.attribute]] * iter_42_3.rate
									end
								end
							end
						elseif iter_42_3.type == 51 then
							local var_42_7 = 0

							for iter_42_14, iter_42_15 in ipairs(self._data.equips) do
								if iter_42_15.id then
									for iter_42_16, iter_42_17 in pairs(iter_42_3.equipment_type) do
										if iter_42_15.id > 0 and var_0_10.find_object_by_cid(iter_42_15.id).type == iter_42_17 then
											var_42_7 = var_42_7 + 1
										end
									end
								end
							end

							for iter_42_18, iter_42_19 in pairs(iter_42_3) do
								if arg_42_1[iter_42_18] then
									arg_42_1[iter_42_18] = arg_42_1[iter_42_18] + iter_42_19 * var_42_7

									break
								end
							end
						elseif iter_42_3.type == 52 then
							for iter_42_20, iter_42_21 in ipairs(self._data.equips) do
								if iter_42_21.id then
									for iter_42_22, iter_42_23 in pairs(iter_42_3.equipment_type) do
										local var_42_8 = var_0_10.find_object_by_cid(iter_42_21.id)

										if iter_42_21.id > 0 and var_42_8.type == iter_42_23 then
											for iter_42_24, iter_42_25 in pairs(iter_42_3) do
												if arg_42_1[iter_42_24] and var_42_8[iter_42_24] then
													arg_42_1[iter_42_24] = arg_42_1[iter_42_24] + var_42_8[iter_42_24] * iter_42_3[iter_42_24]
												end
											end
										end
									end
								end
							end
						elseif iter_42_3.type == 54 then
							for iter_42_26, iter_42_27 in ipairs(self._data.equips) do
								if iter_42_27.id and iter_42_27.id > 0 then
									for iter_42_28, iter_42_29 in pairs(iter_42_3.equipment_type) do
										local var_42_9 = var_0_10.find_object_by_cid(iter_42_27.id)

										if iter_42_27.id > 0 and var_42_9.type == iter_42_29 then
											for iter_42_30, iter_42_31 in pairs(iter_42_3) do
												if arg_42_1[self._detail_attr_table[iter_42_3.attribute]] and var_42_9[self._detail_attr_table[iter_42_3.attribute]] and arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] then
													arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] = arg_42_1[self._detail_attr_table[iter_42_3.attribute2]] + var_42_9[self._detail_attr_table[iter_42_3.attribute]] * iter_42_3.rate

													break
												end
											end
										end
									end
								end
							end
						elseif iter_42_3.type == 131 then
							local var_42_10

							if var_42_0[self._detail_attr_table[iter_42_3.attribute]] then
								var_42_10 = var_0_23.attr_impact_by_speed(var_42_0.speed, var_42_0[self._detail_attr_table[iter_42_3.attribute]], iter_42_3.num1, iter_42_3.num2) - var_42_0[self._detail_attr_table[iter_42_3.attribute]]
							end

							if var_42_10 then
								arg_42_1[self._detail_attr_table[iter_42_3.attribute]] = arg_42_1[self._detail_attr_table[iter_42_3.attribute]] + var_42_10
							end
						end
					end
				end
			end
		end
	end

	function arg_1_0:__add_restaurant_attr(arg_43_1)
		local var_43_0 = var_0_13:get_restaurant_cookbook_buff()

		if not var_43_0 then
			return
		end

		local var_43_1

		if lx.ServerTime:getUtcTime() < var_43_0.end_time then
			var_43_1 = var_0_9.find_object_by_cid(var_43_0.id)
		end

		if not var_43_1 then
			return
		end

		local var_43_2 = var_0_5.find_object_by_cid(self._data.cid)

		if not var_43_2 then
			return
		end

		local var_43_3 = var_43_1.effect.attr

		if arg_43_1[var_43_1.effect.attr] and var_43_0.end_time >= lx.ServerTime:getUtcTime() and (var_43_1.effect.type == 5 or var_43_1.effect.type == 6) then
			local var_43_5 = var_43_1.effect.country or 0
			local var_43_6 = var_43_1.effect.ship_type or 0
			local var_43_7 = var_43_1.effect.ship_ton or 0

			if (var_43_6 == 0 or var_43_6 == var_43_2.type) and (var_43_5 == 0 or var_43_5 == var_43_2.country) and (var_43_7 == 0 or var_43_7 == var_43_2.ship_ton) then
				arg_43_1[var_43_3] = arg_43_1[var_43_3] + var_43_1.effect.value
			end
		end
	end

	function arg_1_0.__set_work_add(arg_44_0, arg_44_1)
		local var_44_0 = 0

		for iter_44_0, iter_44_1 in pairs((var_0_13:get_workshop_data())) do
			local var_44_1 = var_0_17.find_object_by_id(iter_44_1.id).effect[1]

			if var_44_1.type == var_0_4.workshop_const.work_type.add_intensify_exp and var_44_1.shipTypes then
				for iter_44_2, iter_44_3 in pairs(var_44_1.shipTypes) do
					if var_44_1.shipTypes and arg_44_1 == var_44_1.shipTypes[iter_44_2] then
						var_44_0 = var_44_1.num

						return var_44_1.num
					end
				end
			end
		end

		return var_44_0
	end

	function arg_1_0:__add_workshop_attr(arg_45_1)
		local var_45_0 = var_0_5.find_object_by_cid(self._data.cid)

		for iter_45_0, iter_45_1 in pairs((var_0_13:get_workshop_data())) do
			local var_45_1 = var_0_17.find_object_by_id(iter_45_1.id).effect[1]

			if var_45_1.shipTypes then
				for iter_45_2, iter_45_3 in pairs(var_45_1.shipTypes) do
					if var_45_1.shipTypes[iter_45_2] == var_45_0.type then
						local var_45_2 = var_0_4:get_attr_name(var_45_1.num4)

						if var_45_1.type == var_0_4.workshop_const.work_type.add_attribute then
							if var_45_1.countrys then
								for iter_45_4, iter_45_5 in pairs(var_45_1.countrys) do
									if iter_45_5 == var_45_0.country and arg_45_1[var_45_2] then
										arg_45_1[var_45_2] = arg_45_1[var_45_2] + var_45_1.num
									end
								end
							else
								arg_45_1[var_45_2] = arg_45_1[var_45_2] + var_45_1.num
							end
						elseif var_45_1.type == var_0_4.workshop_const.work_type.add_torpedo_damage and var_45_0[var_45_2] ~= 0 and arg_45_1[var_45_2] then
							arg_45_1[var_45_2] = arg_45_1[var_45_2] + var_45_1.num
						end
					end
				end
			end
		end
	end

	function arg_1_0:__set_sixth_ship_level()
		local var_46_0 = self._control.BG.all_layer.ship_level_image
		local var_46_1 = self:__get_sixth_ship_level(self._data.id)

		if var_46_1 - 1 > 0 then
			var_46_0:SetActive(true)

			var_46_0.ship_level_txt.text.text = "+" .. var_46_1 - 1
		else
			var_46_0:SetActive(false)
		end

		if not self._data or not next(self._data) then
			var_46_0:SetActive(false)
		end
	end

	function arg_1_0.__get_sixth_ship_level(arg_47_0, arg_47_1)
		for iter_47_0, iter_47_1 in ipairs(var_0_13:get_sixth_combat_info().ship) do
			if iter_47_1.id == arg_47_1 then
				return iter_47_1.level
			end
		end

		return 0
	end

	function arg_1_0:__set_mist_ship_level()
		local var_48_0 = self._control.BG.all_layer.ship_level_image
		local var_48_1 = self:__get_mist_ship_level(self._data.id)

		if var_48_1 - 1 > 0 then
			var_48_0:SetActive(true)

			var_48_0.ship_level_txt.text.text = "+" .. var_48_1 - 1
		else
			var_48_0:SetActive(false)
		end

		if not self._data or not next(self._data) then
			var_48_0:SetActive(false)
		end
	end

	function arg_1_0.__get_mist_ship_level(arg_49_0, arg_49_1)
		for iter_49_0, iter_49_1 in ipairs(var_0_13:get_mist_combat_info().ship) do
			if iter_49_1.id == arg_49_1 then
				return iter_49_1.level
			end
		end

		return 0
	end

	function arg_1_0.__get_charactor_info_affected_from_tower_by_charactor_config(arg_50_0, arg_50_1)
		local var_50_0 = var_0_3:getInstance("fight_prepare")
		local var_50_1 = {}
		local var_50_2 = {}

		table.insert(var_50_1, arg_50_1)

		if var_50_0 then
			var_50_2 = var_50_0:get_all_charactor_info_affected_from_tower_by_charactors_config(var_50_1)
		end

		if var_50_2 and next(var_50_2) then
			return var_50_2[1]
		else
			return {}
		end
	end

	function arg_1_0:__set_tower_cost_num()
		self._control.tower_cost.cost.text.text = var_0_11("<color=#%s>%d</color>", (self._ship_config.cost_add or 0) - (self._ship_config.cost_sub or 0) == 0 and "FFFFFF" or (self._ship_config.cost_add or 0) - (self._ship_config.cost_sub or 0) > 0 and "FF0000" or "00FF00", (self._ship_config.cost + ((self._ship_config.cost_add or 0) - (self._ship_config.cost_sub or 0)) < 0 or nil) and 0)
	end

	function arg_1_0:__check_is_in_team()
		local var_52_0 = false

		for iter_52_0, iter_52_1 in pairs((var_0_13:get_fifth_team_data())) do
			if iter_52_1 == self._data.cid then
				var_52_0 = true

				break
			end
		end

		return var_52_0
	end

	function arg_1_0.set_custom_info(arg_53_0, arg_53_1, arg_53_2)
		if var_0_23.have_data(var_0_13:get_custom_ship_list(), arg_53_1.id) then
			arg_53_2.formation_type_layer.custom:SetActive(true)
		else
			arg_53_2.formation_type_layer.custom:SetActive(false)
		end
	end

	function arg_1_0:__check_is_in_abyss_team()
		local var_54_0 = false

		for iter_54_0, iter_54_1 in pairs((var_0_13:get_fifth_team_data())) do
			if iter_54_1 == self._data.cid then
				var_54_0 = true

				break
			end
		end

		return var_54_0
	end

	function arg_1_0:_play_into_se(arg_55_1)
		self:playSE(arg_55_1, false)
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_56_0)
	local var_56_0 = var_0_3:class("single_select_team")

	var_56_0._data = nil
	var_56_0._last_data = nil
	var_56_0._ship_config = nil
	var_56_0._temp_config = nil
	var_56_0._need_supply = false
	var_56_0._index = nil
	var_56_0._tab_type = nil
	var_56_0._enter_type = nil
	var_56_0._equips_info = {}
	var_56_0._campaign = false
	var_56_0._team_index = nil
	var_56_0._team_type = nil
	var_56_0._is_can_click = true
	var_56_0._go_to_map_id = nil
	var_56_0._mask_active = false
	var_56_0._orgin_ship_data = nil
	var_56_0._team_num = 0

	function var_56_0:update_selection_state(arg_57_1)
		if not self._control or not self._control.bg then
			return
		end

		local var_57_0 = self._control.bg.transform:Find("multi_selected_border")

		if not var_57_0 then
			local var_57_1 = UnityEngine.GameObject("multi_selected_border")

			var_57_1.transform:SetParent(self._control.bg.transform, false)

			var_57_1.layer = self._control.bg.gameObject.layer

			local var_57_2 = var_57_1:AddComponent(typeof(UnityEngine.UI.Image))

			var_57_2.color = UnityEngine.Color.cyan
			var_57_2.type = UnityEngine.UI.Image.Type.Sliced

			local var_57_3 = var_57_1:GetComponent(typeof(UnityEngine.RectTransform))

			var_57_3.anchorMin = UnityEngine.Vector2(0, 0)
			var_57_3.anchorMax = UnityEngine.Vector2(1, 1)
			var_57_3.offsetMin = UnityEngine.Vector2(-3, -3)
			var_57_3.offsetMax = UnityEngine.Vector2(3, 3)
			var_57_0 = var_57_1.transform
		end

		var_57_0.gameObject:SetActive(arg_57_1)

		local var_57_4 = self._control.bg:GetComponent(typeof(UnityEngine.UI.Image))

		if var_57_4 then
			if arg_57_1 then
				var_57_4.color = UnityEngine.Color.cyan
				var_57_4.color.a = 0.8
			else
				var_57_4.color = UnityEngine.Color.white
			end
		end

		if arg_57_1 then
			self._control.bg.transform:DOScale(Vector3.New(1.05, 1.05, 1), 0.2):SetEase(DG.Tweening.Ease.OutElastic):SetLoops(2, DG.Tweening.LoopType.Yoyo)
		else
			self._control.bg.transform.localScale = Vector3.New(1, 1, 1)
		end
	end

	function var_56_0:get_selection_state()
		if self._control and self._control.bg then
			local var_58_0 = self._control.bg.transform:Find("multi_selected_border")

			return var_58_0 and var_58_0.gameObject.activeSelf
		end

		return false
	end

	return var_56_0
end

return var_0_0
