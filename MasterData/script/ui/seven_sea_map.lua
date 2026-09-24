local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = gamecore.util_func
local var_0_6 = gameconfig.ship_config
local var_0_7 = gameconfig.skin_config
local var_0_8 = gameconfig.monster_config
local var_0_9 = gameconfig.monster_formation_config
local var_0_10 = gameconfig.pve_mix_map_config
local var_0_11 = gameconfig.pve_mix_level_config
local var_0_12 = gameconfig.pve_mix_level_node_config
local var_0_13 = gameconfig.pve_mix_buff_config
local var_0_14 = gameconfig.equip_config
local var_0_15 = UnityEngine.Input
local var_0_16 = UnityEngine.RectTransformUtility
local var_0_18 = lx.UserData
local var_0_19 = lx.json_decode
local var_0_20 = gamecore.Language
local var_0_21 = DG.Tweening.DOTween
local var_0_22 = gamecore.prompt
local var_0_23 = UnityEngine.Vector2
local var_0_24 = gameconfig.pevent_task_config
local var_0_25 = gamecore.UserDataManager
local var_0_26 = string.format
local var_0_27 = table.insert
local var_0_28 = UnityEngine.Vector3
local var_0_29 = UnityEngine.Quaternion

gamecore.UILoader:define("seven_sea_map", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self.is_input_down then
			self._time = Time.deltaTime + self._time
		end

		if self._is_short_click and self._can_move then
			self:__set_click_move(true)
		end

		if var_0_15.GetMouseButton(0) and self._can_move then
			self:__set_run_anim()
			self:__set_click_move(false)
		end

		if var_0_15.GetMouseButtonUp(0) then
			self.is_input_down = false
			self._time = 0
			self._is_mouse_in_no_enter = false

			if self._time < 0.3 and self._can_move then
				self._is_short_click = true
				self._is_creat_list = false
				self._time = 0
			else
				self.target_pos_list = {}
				self._is_move_list = false
				self._can_move = false
				self._is_short_click = false

				self:__set_normal_anim(self._control.player_role)
			end
		end

		if var_0_15.GetMouseButtonDown(0) then
			self.collision_pos = nil
			self._is_short_click = false
			self.is_input_down = true
			self._time = 0
		end

		if self._have_sign then
			self:__cloud_sign_pos("boss")
			self:__cloud_sign_pos("plane")
		end

		self:__is_mouse_pos_in_no_enter()

		if self._cloud_parent_list then
			for iter_2_0, iter_2_1 in pairs(self._cloud_parent_list) do
				self:__cloud_move(iter_2_1)
			end
		end

		if self._find_btn_start then
			self._find_btn_time = self._find_btn_time + Time.deltaTime

			if self._find_btn_time >= 3 then
				self:_revert_find_btn_setting()
			end
		end

		self:_dis_player_reasure()
	end

	function arg_1_0:_dis_player_reasure()
		if self._sea_treasure_num == 0 then
			return
		end

		if not self._local_no_treasure then
			return
		end

		if (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition - self._treasure_pos).magnitude <= 188 then
			self._control.empty_bg.treasure:SetActive(true)
			self._control.empty_bg.treasure_spiral:SetActive(true)

			if not self._set_spiral_is_doscale then
				self:_set_treasure_spiral_scale()

				self._set_spiral_is_doscale = true
			end

			if not self._into_treasure_area then
				self:_find_salvage_func()

				self._into_treasure_area = true
			end
		else
			self._control.empty_bg.treasure:SetActive(false)
			self:_revert_salvage_func()

			self._into_treasure_area = false
		end
	end

	function arg_1_0:_set_treasure_spiral_scale()
		self._control.empty_bg.treasure_spiral.transform.localScale = var_0_28.New(0.1, 0.1, 1)
		self._treasure_spira_dot = {}

		var_0_27(self._treasure_spira_dot, (self:autoKillDOTween(var_0_21.Sequence())))
		self._control.empty_bg.treasure_spiral.transform:DOScale(var_0_28.New(1, 1, 1), 0.6)
	end

	function arg_1_0:_set_close_treasure_spiral_scale()
		self._control.empty_bg.treasure_spiral.transform.localScale = var_0_28.New(1, 1, 1)

		local var_5_0 = self:autoKillDOTween(var_0_21.Sequence())

		self._treasure_spira_dot_close = {}

		var_0_27(self._treasure_spira_dot_close, var_5_0)
		self._control.empty_bg.treasure_spiral.transform:DOScale(var_0_28.New(0, 0, 1), 0.6)
		var_5_0:AppendInterval(1)
		var_5_0:AppendCallback(function()
			self._control.empty_bg.treasure_spiral:SetActive(false)
			self:_revert_spira_func()
		end)
	end

	function arg_1_0:_revert_spira_func()
		if self._treasure_spira_dot then
			for iter_7_0, iter_7_1 in pairs(self._treasure_spira_dot) do
				iter_7_1:Kill()
			end
		end

		if self._treasure_spira_dot_close then
			for iter_7_2, iter_7_3 in pairs(self._treasure_spira_dot_close) do
				iter_7_3:Kill()
			end
		end

		self._treasure_spira_dot_close = {}
		self._treasure_spira_dot = {}
	end

	function arg_1_0:_find_salvage_func()
		self._control.empty_bg.treasure.transform.localScale = var_0_28.New(1, 0.1, 1)
		self._treasure_dot = {}

		var_0_27(self._treasure_dot, (self:autoKillDOTween(var_0_21.Sequence())))
		self._control.empty_bg.treasure.transform:DOScale(var_0_28.New(1, 1, 1), 0.3)
		self._control.player_role.find_treasure:SetActive(true)

		self._control.player_role.find_treasure.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))

		if self._now_face == 1 then
			self._control.player_role.find_treasure.transform.localRotation = var_0_29.Euler(var_0_28(0, 180, 0))
		end

		self:__play_animation(self._control.player_role.find_treasure, var_0_2.seventh_find_smt.sign.name, var_0_2.seventh_find_smt.sign.loop)
	end

	function arg_1_0:_revert_salvage_func()
		if self._treasure_dot then
			for iter_9_0, iter_9_1 in pairs(self._treasure_dot) do
				iter_9_1:Kill()
			end
		end

		self._treasure_dot = {}
	end

	function arg_1_0:show(arg_10_1)
		arg_10_1 = arg_10_1 or 9204
		self._is_init = true
		self._panel:GetComponent("Transform").localScale = var_0_28(1, 1, 1)
		self._panel:GetComponent("RectTransform").anchoredPosition = var_0_28(0, 0, 0)

		self:setVisible(true)
		self:__init_panel(arg_10_1)
	end

	function arg_1_0.show_cover_func(arg_11_0, arg_11_1)
		local var_11_0 = var_0_1:getInstance("cover")

		if var_11_0 then
			var_11_0:setVisible(arg_11_1)
		end
	end

	function arg_1_0:show_self_cover_func(arg_12_1)
		self._control.cover_2:SetActive(arg_12_1)
	end

	function arg_1_0:__enter_animation()
		self._panel:GetComponent("Transform").localScale = var_0_28(1.21, 1.21, 1.21)

		self._control.cover_2:SetActive(true)

		local var_13_0 = self:autoKillDOTween(var_0_21.Sequence())

		var_13_0:AppendCallback(function()
			self._panel:GetComponent("Transform"):DOScale(1, 0.48)
		end)
		var_13_0:AppendInterval(0.48)
		var_13_0:AppendCallback(function()
			self._panel:GetComponent("Transform").localScale = var_0_28(1, 1, 1)

			self._control.cover_2:SetActive(false)
		end)
	end

	function arg_1_0:__exit_animation()
		self._panel:GetComponent("Transform").localScale = var_0_28(1, 1, 1)

		self._control.cover_2:SetActive(true)

		local var_16_0 = self:autoKillDOTween(var_0_21.Sequence())

		var_16_0:AppendCallback(function()
			self._panel:GetComponent("Transform"):DOScale(1.21, 0.48)
		end)
		var_16_0:AppendInterval(0.48)
		var_16_0:AppendCallback(function()
			self._control.cover_2:SetActive(false)
			self:__onReset()

			self._panel:GetComponent("Transform").localScale = var_0_28(1, 1, 1)

			var_0_1:__remove_from_showing("seven_sea_map_single")
			var_0_1:destroyInstance("seven_sea_map")

			mix_main_map = var_0_1:createInstance("mix_main_map")

			mix_main_map:show((var_0_4:get_seventh_event_activity_id()))
			mix_main_map:click_point_prefab_anim_func(nil, false)
			self:show_cover_func(true)
		end)
	end

	function arg_1_0:__is_mouse_pos_in_no_enter()
		if self._can_move and not self._is_short_click then
			local var_19_2, var_19_3 = var_0_16.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_15.mousePosition, self._ui_camera, nil)

			mouse_pos = var_19_3

			if var_19_2 then
				mouse_pos = mouse_pos + self.sceen_center_pos + var_0_23(0, 60) - self._control.empty_bg.rectTransform.anchoredPosition

				local var_19_4 = self:__is_in_noenter_area(mouse_pos)

				if var_19_4 and not self._now_move_num and not self._now_move_func then
					self._is_mouse_in_no_enter = true
					self._now_move_sizedelta = var_19_4.size
					self._now_move_num = var_19_4.num
				else
					self._is_mouse_in_no_enter = false
					self._now_move_sizedelta = nil
					self._now_move_num = nil
					self._now_move_func = nil
				end
			end
		end
	end

	function arg_1_0:__set_cloud_data(arg_20_1)
		self._control.cloud_list.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 2

		local var_20_0 = {}

		for iter_20_0 = 1, 2 do
			self._control["cloud_list_" .. iter_20_0].rectTransform.anchoredPosition = var_0_23(0, 0)
			self._control["cloud_list_" .. iter_20_0].rectTransform.anchoredPosition = self._control["cloud_list_" .. iter_20_0].rectTransform.anchoredPosition + var_0_23((iter_20_0 - 1) * self._control.empty_bg.rectTransform.sizeDelta.x, 0)
			self._control["cloud_shadow_list_" .. iter_20_0].rectTransform.anchoredPosition = var_0_23(0, 0)
			self._control["cloud_shadow_list_" .. iter_20_0].rectTransform.anchoredPosition = self._control["cloud_shadow_list_" .. iter_20_0].rectTransform.anchoredPosition + var_0_23((iter_20_0 - 1) * self._control.empty_bg.rectTransform.sizeDelta.x, 0)

			self:__rest_child(self._control["cloud_list_" .. iter_20_0].transform)
			self:__rest_child(self._control["cloud_shadow_list_" .. iter_20_0].transform)

			for iter_20_1 = 1, lan_rand(0, 5) do
				local var_20_1 = lan_rand(1, 90)
				local var_20_2 = lan_rand(1, 40)
				local var_20_3 = var_0_23(var_20_1, var_20_2)
				local var_20_4 = var_0_23(self._control.empty_bg.rectTransform.sizeDelta.x / 100 * var_20_1, self._control.empty_bg.rectTransform.sizeDelta.y / 50 * var_20_2)
				local var_20_5 = false

				for iter_20_2, iter_20_3 in pairs(var_20_0) do
					if iter_20_3.x == var_20_4.x and iter_20_3.y == var_20_4.y then
						var_20_5 = true
					end
				end

				if not var_20_5 then
					table.insert(var_20_0, var_20_3)

					local var_20_6 = lan_rand(1, 3)
					local var_20_7, var_20_8 = self:loadUIPrefab("seven_sea_map_single", self._control["cloud_list_" .. iter_20_0].transform)

					var_20_7:setVisible(true)

					var_20_7._panel:GetComponent("RectTransform").anchoredPosition = var_20_4

					var_20_8.cloud_img:SetActive(true)

					var_20_8.cloud_img.rawImage.texture = self:loadTexture(string.format(var_0_2.seven_year_sea_map.cloud, var_20_6))

					var_20_8.cloud_img.rawImage:SetNativeSize()

					local var_20_9, var_20_10 = self:loadUIPrefab("seven_sea_map_single", self._control["cloud_shadow_list_" .. iter_20_0].transform)

					var_20_9:setVisible(true)

					var_20_9._panel:GetComponent("RectTransform").anchoredPosition = var_20_4

					var_20_10.cloud_img:SetActive(true)

					var_20_10.cloud_img.rawImage.texture = self:loadTexture(string.format(var_0_2.seven_year_sea_map.cloud_shadow, var_20_6))

					var_20_10.cloud_img.rawImage:SetNativeSize()
				end
			end

			table.insert(self._cloud_parent_list, self._control["cloud_list_" .. iter_20_0])
			table.insert(self._cloud_parent_list, self._control["cloud_shadow_list_" .. iter_20_0])
		end
	end

	function arg_1_0:__cloud_move(arg_21_1)
		if not self._is_init then
			return
		end

		if not arg_21_1 or arg_21_1.transform:Equals(nil) then
			return
		end

		local var_21_0 = self._control.empty_bg.rectTransform.sizeDelta

		arg_21_1.rectTransform.anchoredPosition = arg_21_1.rectTransform.anchoredPosition + var_0_23(-1, 0, 0) / 0.3

		if arg_21_1.rectTransform.anchoredPosition.x < -var_21_0.x - 100 then
			arg_21_1.rectTransform.localPosition = var_0_28(var_21_0.x + 100, 0, 1)
		end
	end

	function arg_1_0:__cloud_sign_pos(arg_22_1)
		local var_22_0
		local var_22_1
		local var_22_2

		if arg_22_1 == "boss" then
			var_22_0 = self.sea_map_data.boss_position
			var_22_1 = var_0_2.seventh_sceen_pos.boss
			var_22_2 = self._control.boss_sign
			self.temp_type = nil
		elseif arg_22_1 == "plane" then
			var_22_0 = self.sea_map_data.battle_plan_position
			var_22_1 = var_0_2.seventh_sceen_pos.plane
			var_22_2 = self._control.plane_sign
		end

		local var_22_3 = self:__get_pos_by_rule_num(var_22_0)
		local var_22_4 = var_0_23(var_22_3.x, var_22_3.y)
		local var_22_5 = var_0_23(var_22_3.x, var_22_3.y) + self._control.empty_bg.rectTransform.anchoredPosition
		local var_22_6 = -self._control.empty_bg.rectTransform.anchoredPosition + var_0_23(self._uiroot_canvas_rect.rect.width, self._uiroot_canvas_rect.rect.height)

		if (var_22_4 + var_22_1).x < (-self._control.empty_bg.rectTransform.anchoredPosition).x or var_22_4.x > var_22_6.x then
			if not var_22_2.activeSelf then
				var_22_2:SetActive(true)
			end

			local var_22_7
			local var_22_8

			if (var_22_4 + var_22_1).x < (-self._control.empty_bg.rectTransform.anchoredPosition).x then
				var_22_2.rectTransform.localRotation = var_0_29.Euler(0, 0, 270)
				var_22_2.icon.rectTransform.localRotation = var_0_29.Euler(0, 0, 90)
				var_22_7 = 0
				var_22_8 = (var_22_5.y + (var_22_5 + var_22_1).y) / 2 + 50

				if (var_22_5.y + (var_22_5 + var_22_1).y) / 2 + 50 - 100 <= 0 then
					var_22_8 = 100

					if self.temp_type == 1 then
						var_22_8 = 150
					end

					self.temp_type = 1
				elseif self._uiroot_canvas_rect.rect.height <= var_22_8 then
					var_22_8 = self._uiroot_canvas_rect.rect.height

					if self.temp_type == 2 then
						var_22_8 = self._uiroot_canvas_rect.rect.height - 50
					end

					self.temp_type = 2
				end
			end

			if var_22_4.x > var_22_6.x then
				var_22_2.rectTransform.localRotation = var_0_29.Euler(0, 0, 90)
				var_22_2.icon.rectTransform.localRotation = var_0_29.Euler(0, 0, 270)
				var_22_7 = self._uiroot_canvas_rect.rect.width
				var_22_8 = (var_22_5.y + (var_22_5 + var_22_1).y) / 2 - 50

				if (var_22_5.y + (var_22_5 + var_22_1).y) / 2 - 50 <= 0 then
					var_22_8 = 0

					if self.temp_type == 3 then
						var_22_8 = 50
					end

					self.temp_type = 3
				elseif self._uiroot_canvas_rect.rect.height <= var_22_8 + 100 then
					var_22_8 = self._uiroot_canvas_rect.rect.height - 100

					if self.temp_type == 4 then
						var_22_8 = self._uiroot_canvas_rect.rect.height - 150
					end

					self.temp_type = 4
				end
			end

			if var_22_2.rectTransform.anchoredPosition ~= var_0_23(var_22_7, var_22_8) then
				var_22_2.rectTransform.anchoredPosition = var_0_23(var_22_7, var_22_8)
			end
		elseif (var_22_4 + var_22_1).y < (-self._control.empty_bg.rectTransform.anchoredPosition).y or var_22_4.y > var_22_6.y then
			if not var_22_2.activeSelf then
				var_22_2:SetActive(true)
			end

			local var_22_9
			local var_22_10

			if (var_22_4 + var_22_1).y < (-self._control.empty_bg.rectTransform.anchoredPosition).y then
				var_22_2.rectTransform.localRotation = var_0_29.Euler(0, 0, 0)
				var_22_2.icon.rectTransform.localRotation = var_0_29.Euler(0, 0, 0)
				var_22_9 = (var_22_5.x + (var_22_5 + var_22_1).x) / 2 - 50
				var_22_10 = 0

				if (var_22_5.x + (var_22_5 + var_22_1).x) / 2 - 50 <= 0 then
					var_22_9 = 0

					if self.temp_type == 4 then
						var_22_9 = 50
					end

					self.temp_type = 5
				elseif self._uiroot_canvas_rect.rect.width <= var_22_9 + 100 then
					var_22_9 = self._uiroot_canvas_rect.rect.width - 100

					if self.temp_type == 6 then
						var_22_9 = self._uiroot_canvas_rect.rect.width - 150
					end

					self.temp_type = 6
				end
			elseif var_22_4.y > var_22_6.y then
				var_22_2.rectTransform.localRotation = var_0_29.Euler(0, 0, 180)
				var_22_2.icon.rectTransform.localRotation = var_0_29.Euler(0, 0, 180)
				var_22_9 = (var_22_5.x + (var_22_5 + var_22_1).x) / 2 + 50
				var_22_10 = self._uiroot_canvas_rect.rect.height

				if (var_22_5.x + (var_22_5 + var_22_1).x) / 2 + 50 - 100 <= 0 then
					var_22_9 = 100

					if self.temp_type == 7 then
						var_22_9 = 150
					end

					self.temp_type = 7
				elseif self._uiroot_canvas_rect.rect.width <= var_22_9 then
					var_22_9 = self._uiroot_canvas_rect.rect.width

					if self.temp_type == 8 then
						var_22_9 = self._uiroot_canvas_rect.rect.width - 50
					end

					self.temp_type = 8
				end
			end

			if var_22_2.rectTransform.anchoredPosition ~= var_0_23(var_22_9, var_22_10) then
				var_22_2.rectTransform.anchoredPosition = var_0_23(var_22_9, var_22_10)
			end
		elseif var_22_2.activeSelf then
			var_22_2:SetActive(false)
		end
	end

	function arg_1_0:__init_panel(arg_23_1)
		self._save_now_data = arg_23_1
		self.sea_map_data = var_0_10.find_object_by_id(arg_23_1)

		self:_play_audio(var_0_2:get_audio_url(var_0_2.common_icon.music_path, self.sea_map_data.music_battle))

		self.sea_map_user_data = var_0_4:get_seventh_map_info()[arg_23_1]

		self._control.enemy_info_bg:SetActive(false)

		if not self.sea_map_data or not self.sea_map_user_data then
			return
		end

		self.sceen_center_pos = var_0_23(self._uiroot_canvas_rect.rect.width / 2, self._uiroot_canvas_rect.rect.height / 2 - 60)

		self:__set_enemy_and_scence()
		self:__set_player_role()
		self:__set_map_preview_data()
		self:__set_cloud_data()

		self._have_sign = true
		self._sea_treasure_num = self.sea_map_user_data.treasure_num

		self._control.explore:SetActive(true)

		self._control.empty_bg.treasure.get_txt.text.text = var_0_20:getNowLang("7th_treasure_3")

		if self._sea_treasure_num == 0 then
			self._control.explore.btn.image.sprite = self:loadSprite(var_0_2.seven_ban_find_treasure_img)
			self._local_no_treasure = false
		else
			self._local_no_treasure = true
			self._control.explore.btn.image.sprite = self:loadSprite(var_0_2.seven_find_treasure_img)
		end

		self.sea_map_user_data.treasure_position = self.sea_map_user_data.treasure_position or 0
		self._treasure_pos = self:__get_pos_by_rule_num(self.sea_map_user_data.treasure_position) or self:__get_pos_by_rule_num(0)
		self._control.empty_bg.treasure.rectTransform.anchoredPosition = self._treasure_pos
		self._control.empty_bg.treasure_spiral.rectTransform.anchoredPosition = var_0_23(self._treasure_pos.x + 50, self._treasure_pos.y + 30)

		self:_set_treasure_spiral_ani()
		self._control.empty_bg.treasure:SetActive(false)
		self._control.player_role.find_treasure:SetActive(false)
		self._control.empty_bg.treasure_spiral:SetActive(false)

		self._into_treasure_area = false

		self:__update_point_num()
	end

	function arg_1_0:_set_treasure_spiral_ani()
		self:__play_animation(self._control.empty_bg.treasure_spiral, var_0_2.seventh_find_smt.spiral.name, var_0_2.seventh_find_smt.spiral.loop)
	end

	function arg_1_0:__update_point_num()
		self._control.point_coin.num.text.text = var_0_4:get_seventh_buff_point()

		local var_25_0 = lx.table_size(var_0_4:get_seventh_buff_list())
		local var_25_1, var_25_2 = var_0_13:get_sequence()

		self._control.point_coin:SetActive(var_25_0 ~= var_25_2 - 3)
	end

	function arg_1_0:__set_player_role()
		local var_26_0 = self._control.player_role
		local var_26_1 = self:__get_pos_by_rule_num(self.sea_map_user_data.pos)

		self.player_now_num = self.sea_map_user_data.pos
		var_26_0.rectTransform.anchoredPosition = self.sceen_center_pos
		var_26_0.rectTransform.localScale = var_0_28(0.4, 0.4, 0.4)
		self._control.empty_bg.rectTransform.anchoredPosition = self.sceen_center_pos - (var_0_23(var_26_1.x, var_26_1.y) + var_0_23(64, 64))
		var_26_0.rectTransform.anchoredPosition = var_26_0.rectTransform.anchoredPosition - self:set_position_by_rule()

		local var_26_2 = "normal"

		self._user_data = var_0_4:get_use_info_data()

		local var_26_3 = var_0_4:find_character_by_id(self._user_data.secretary)
		local var_26_4 = var_26_3 and var_0_5.little_clone(var_26_3) or {}

		if var_26_4.now_hp / var_26_4.hp < var_0_2.health_sprite_rule.yellow.max_value then
			var_26_2 = "damage"
		end

		local var_26_5 = var_0_6.find_object_by_cid(var_26_4.cid).pic_id

		if var_26_3.skin ~= 0 then
			var_26_5 = var_0_7.find_object_by_cid(var_26_4.skin).icon
		end

		var_26_0.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_2.ship_spine, var_26_5, var_26_5))

		local var_26_6 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		var_26_0.skeletonGraphic.material.shader = var_26_6
		var_26_0.shadow.skeletonGraphic.material.shader = var_26_6
		var_26_0.skeletonGraphic.initialSkinName = var_26_2

		if not var_26_0.skeletonGraphic:Equals(nil) then
			var_26_0.skeletonGraphic:Initialize(true)
		end

		self:__set_normal_anim(var_26_0, true)
		self._control.top_find_ani.find_ani:SetActive(false)
	end

	function arg_1_0:__set_enemy_and_scence()
		self._control.empty_bg.rectTransform.sizeDelta = var_0_23((self.sea_map_data.ocean_size % 20 == 0 and 20 or self.sea_map_data.ocean_size % 20) * 128, math.ceil(self.sea_map_data.ocean_size / 20) * 96)

		self:__set_enemy_data()
		self:__set_island_data()
		self:__set_exploration_data()
		self:__set_operational_plan_data()

		self._control.enemy_info_bg.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3
	end

	function arg_1_0:update_map_preview_data()
		self:__set_map_preview_data()
	end

	function arg_1_0:__set_map_preview_data()
		self._control.map_preview.map_bg.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3

		self._control.map_preview.map_bg.transform:DOScale(1, 0)
		self._control.map_preview:SetActive(false)

		local var_29_0 = self.sea_map_data.boss_id

		self._control.map_preview.map_bg.confirm_btn.title.text.text = var_0_20:getNowLang("ui_4th_prepare")

		local var_29_1 = self._control.map_preview.map_bg.boss_panel.boss_hp_black
		local var_29_2 = self.sea_map_user_data.hp
		local var_29_3 = var_0_11.find_object_by_id(self.sea_map_data.id)
		local var_29_4

		if self.sea_map_user_data.hp then
			var_29_4 = var_29_2 / var_29_3.hp or 1
		end

		var_29_1.boss_hp_bar.image.fillAmount = var_29_4

		if var_29_4 > 0 and var_29_4 < 0.01 and var_29_2 > 0 then
			var_29_4 = 0.01
		end

		var_29_1.hp_percent_num.text.text = string.format("%0.0f%s", var_29_4 * 100, "%")

		local var_29_5 = self._control.map_preview.map_bg

		self._control.map_preview.map_bg.map_panel.map_image.image.sprite = self:loadSprite(string.format(var_0_2.map_path, var_29_3.id, var_29_3.id))
		var_29_5.map_panel.map_image.rectTransform.anchoredPosition = var_0_23(3, 5)
		var_29_5.title_bg.title_txt.text.text = var_29_3.title .. " " .. var_29_3.sub_title
		var_29_5.boss_panel.boss_bg.image.sprite = self:loadSprite(string.format(var_0_2.fearlessness_sea_enemy_bg, var_29_3.boss_bg))

		local var_29_6 = self.sea_map_user_data.state == 2

		var_29_5.boss_panel.boss_image.image.sprite = self.sea_map_user_data.state ~= 2 and self:loadSprite(string.format(var_0_2.seventh_node_boss, var_29_3.boss_id)) or self:loadSprite(string.format(var_0_2.seventh_node_boss_b, var_29_0))

		var_29_5.reward_panel.reward_icon.get_icon:SetActive(var_29_6)

		var_29_5.map_panel.pass_icon.pass_txt.text.text = var_0_20:getNowLang("ui_pvepassed")

		var_29_5.map_panel.pass_icon:SetActive(var_29_6)

		var_29_5.bottom_tips.tips_txt.text.text = var_0_20:convert_rich_text(var_29_3.tips)

		if var_29_3.award[1].id >= 10000000 then
			if var_29_3.award[1].id % 100 == 21 then
				var_29_5.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(string.format(var_0_2.equip_back.equip_back_normal, var_0_14.find_object_by_cid(var_29_3.award[1].id).star))
				var_29_5.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_2.icon.item_icon, var_29_3.award[1].id))
			elseif var_29_3.award[1].id % 100 == 61 then
				var_29_5.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_2.equip_quality_frame_s[5])
				var_29_5.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_2.icon.item_icon, var_29_3.award[1].id))
			elseif var_29_3.award[1].id % 100 ~= 11 and var_29_3.award[1].id % 100 ~= 12 then
				if var_29_3.award[1].id % 100 == 13 then
					var_29_5.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(string.format(var_0_2.equip_back.equip_back_normal, var_0_6.find_object_by_cid(var_29_3.award[1].id).star))
					var_29_5.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_2.icon.item_icon, var_29_3.award[1].id))

					goto label_29_0
				end
			end
		end

		var_29_5.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_2.equip_back_ground)
		var_29_5.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_2.icon.item_icon, var_29_3.award[1].id))

		::label_29_0::

		self._current_reward_id = var_29_3.award[1].id
		self._current_reward_count = var_29_3.award[1].value
		var_29_5.reward_panel.reward_title.text.text = var_0_20:getNowLang("pveeventitemcanget")

		var_29_5.boss_panel.boss_head:SetActive(true)
		var_29_5.boss_panel.boss_hp_black:SetActive(var_29_2 ~= 0)

		local var_29_7, var_29_8 = var_0_12.get_sequence()
		local var_29_9 = {}

		for iter_29_0, iter_29_1 in pairs(var_29_7) do
			if self.sea_map_data.id == iter_29_1.pve_level_id then
				table.insert(var_29_9, iter_29_1)
			end
		end

		self:__set_node_data_by_map(var_29_9, nil, self.sea_map_data.id)
	end

	function arg_1_0:__set_node_data_by_map(arg_30_1, arg_30_2, arg_30_3)
		arg_30_2 = self._control.map_preview.map_bg.map_panel.map_node_root

		self:__rest_child(self._control.map_preview.map_bg.map_panel.map_node_root.transform)

		self._light_seq_list = {}

		local var_30_0 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.width
		local var_30_1 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.height
		local var_30_2 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
			if iter_30_1.node_miss and next(iter_30_1.node_miss) then
				for iter_30_2, iter_30_3 in pairs(iter_30_1.node_miss) do
					table.insert(var_30_2, {
						hide_start_point = iter_30_1.id,
						hide_end_point = iter_30_2,
						hide_result = iter_30_3
					})
				end
			end
		end

		for iter_30_4, iter_30_5 in ipairs(arg_30_1) do
			local var_30_3, var_30_4 = self:loadUIPrefab("map_node_obj", arg_30_2.transform)

			var_30_3:setVisible(true)

			var_30_4.node_image.rectTransform.parent.offsetMin = var_0_23(0, 0)
			var_30_4.node_image.rectTransform.parent.offsetMax = var_0_23(0, 0)
			var_30_4.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_30_0, var_30_1, iter_30_5.position.x, iter_30_5.position.y) + var_0_23(8, 0)

			local var_30_5
			local var_30_6 = 1
			local var_30_7 = false
			local var_30_8
			local var_30_9

			if iter_30_5.support_icon ~= 0 then
				local var_30_10 = gameconfig.support_atk_config.find_object_by_id(iter_30_5.support_icon)

				var_30_8 = var_0_4:is_pass_seventh_map_node(iter_30_5.pve_level_id, iter_30_5.id)
				var_30_5 = string.format((var_30_8 ~= false or nil) and (var_0_2.fight_point.support_icon_path_red or var_0_2.fight_point.support_icon_path_white), var_30_10.type)
				var_30_7 = true
				var_30_6 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) and 2 or 1
			elseif iter_30_5.node_attribute == var_0_2.map_node_finish_type.init then
				var_30_5 = var_0_2.fight_point.pve_start_l
				var_30_6 = 2
			elseif iter_30_5.node_attribute == var_0_2.map_node_finish_type.boss_finish then
				if var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) then
					var_30_5 = var_0_2.fight_point.pve_boss_l
					var_30_6 = 2
				else
					var_30_5 = var_0_2.fight_point.pve_boss
					var_30_6 = 1
				end
			elseif iter_30_5.node_type == var_0_2.map_node_type.reward then
				var_30_5 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) and var_0_2.fight_point.pve_green or var_0_2.fight_point.pve_white
			elseif iter_30_5.node_type == var_0_2.map_node_type.loss then
				var_30_5 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) and var_0_2.fight_point.pve_purple or var_0_2.fight_point.pve_white
			elseif iter_30_5.node_type == var_0_2.map_node_type.null then
				var_30_5 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) and var_0_2.fight_point.pve_blue or var_0_2.fight_point.pve_white
			elseif iter_30_5.node_type == var_0_2.map_node_type.little_boss then
				self._little_boss_point_data = iter_30_5
				var_30_5 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id) and var_0_2.fight_point.pve_small_boss_l or var_0_2.fight_point.pve_small_boss

				local var_30_11 = var_30_4.node_image.guard_icon
				local var_30_12, var_30_13 = var_0_4:is_point_stationed(iter_30_5.id)

				if var_30_12 then
					self._current_station_team_id = var_30_13

					local var_30_14 = var_30_4.node_image.transform.localPosition

					var_30_11:SetActive(true)
					var_30_11.button.onClick:AddListener(function()
						self:show_cover_func(true)

						local var_31_0 = string.sub(tostring(var_30_11.team_id.image.sprite), 16, 16)
						local var_31_1 = var_0_1:createInstance("captainroom_fleet")

						if not var_31_1 then
							return
						end

						self._control.map_preview:SetActive(false)
						var_31_1:show(var_0_20:getNowLang("ui_activitydefendfleet"), var_0_4:get_team_by_id(tonumber(var_31_0)).members, var_0_20:getNowLang("ui_activitydefendcancel"), "", function()
							local var_32_0 = var_0_1:createInstance("msgbox")

							if not var_32_0 then
								return
							end

							var_32_0:show(var_0_20:getNowLang("ui_activitydefendcanceltip"), function()
								var_32_0:setVisible(false)
								var_0_4:req_StationPointExitReq(tonumber(var_31_0))
								var_0_1:destroyInstance("captainroom_fleet")

								local var_33_0 = var_0_1:getInstance("seven_sea_map")

								if var_33_0 then
									var_33_0._control.map_preview:SetActive(true)
								end

								local var_33_1 = var_0_1:getInstance("cover")

								if var_33_1 then
									var_33_1:setVisible(false)
								end
							end, function()
								var_32_0:setVisible(false)
							end, var_0_20:getNowLang("ui_activitydefendcancel"))
						end, true)
						var_31_1:disallowed_clicking()
					end)

					local var_30_15 = iter_30_5.bubble_icon

					if iter_30_5.bubble_icon == 0 then
						var_30_15 = 1
					end

					var_30_11.image.sprite = self:loadSprite(string.format(var_0_2.guard_point.pve_node_guard, var_30_15))
					var_30_11.team_id.image.sprite = self:loadSprite(string.format(var_0_2.guard_point.pve_fleet_team, self._current_station_team_id))
					var_30_11.transform.localScale = var_0_28(1.38, 1.54, 1)

					local var_30_16 = var_0_28.zero
					local var_30_17 = var_0_28.zero

					if var_30_15 == 1 then
						var_30_16 = var_0_23(-20, -142)
						var_30_17 = var_0_23(0, -2.8)
					elseif var_30_15 == 2 then
						var_30_16 = var_0_23(-20, -142)
						var_30_17 = var_0_23(0, -2.8)
					elseif var_30_15 == 3 then
						var_30_16 = var_0_23(-20, -142)
						var_30_17 = var_0_23(0, -2.8)
					elseif var_30_15 == 4 then
						var_30_16 = var_0_23(-20, -142)
						var_30_17 = var_0_23(0, -2.8)
					end

					if var_30_14.y <= -537 then
						var_30_11.transform.anchoredPosition = var_0_23(-20, -104)
					end

					var_30_11.team_id.transform.anchoredPosition = var_30_17

					if iter_30_5.id ~= 922012 then
						-- block empty
					end

					var_30_11.image.sprite = self:loadSprite(string.format(var_0_2.guard_point.pve_node_guard, 4))
					var_30_11.transform.anchoredPosition = var_0_23(120, -142)

					local var_30_18 = var_0_23(0, -2.8)
				end
			else
				local var_30_19 = var_0_4:is_cur_seventh_map_node_pass(iter_30_5.pve_level_id, iter_30_5.id)

				if var_30_19 and iter_30_5.node_type ~= 13 then
					var_30_5 = var_0_2.fight_point.pve_red
					var_30_9 = var_0_2.push_random_red_image
					var_30_6 = 2
				elseif var_30_19 == false and iter_30_5.node_type ~= 13 then
					var_30_5 = var_0_2.fight_point.pve_white
					var_30_9 = var_0_2.push_random_white_image
					var_30_6 = 1
				elseif var_30_19 and iter_30_5.node_type == 13 then
					var_30_5 = var_0_2.pve_buff_red
					var_30_9 = var_0_2.push_random_red_image
					var_30_6 = 1
				elseif var_30_19 == false and iter_30_5.node_type == 13 then
					var_30_5 = var_0_2.pve_buff_white
					var_30_9 = var_0_2.push_random_white_image
					var_30_6 = 1
				else
					var_30_9 = var_0_2.push_random_white_image
					var_30_5 = var_0_2.fight_point.pve_white
					var_30_6 = 1
				end
			end

			var_30_4.node_image.image.sprite = self:loadSprite(var_30_5)
			var_30_4.node_image.random_buff_icon.image.sprite = self:loadSprite(var_30_9)

			if var_30_7 then
				var_30_4.node_image.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Button))

				var_30_4.node_image.image.raycastTarget = true

				var_30_4.node_image:GetComponent("Button").onClick:RemoveAllListeners()
				var_30_4.node_image:GetComponent("Button").onClick:AddListener(function()
					local var_35_0 = var_0_1:getInstance("suppress_msg")

					if not var_35_0 then
						var_35_0 = var_0_1:createInstance("suppress_msg")
					else
						var_0_1:destroyInstance("suppress_msg")

						var_35_0 = var_0_1:createInstance("suppress_msg")
					end

					if var_30_8 then
						var_35_0:show("suppressed", iter_30_5.pve_level_id, 1.5, nil, var_0_2.fight_type.seventh)
					else
						var_35_0:show("suppress", iter_30_5.pve_level_id, 1.5, nil, var_0_2.fight_type.seventh)
					end
				end)
			end

			var_30_4.node_image.image:SetNativeSize()

			local var_30_21

			if iter_30_5.flag and var_30_6 then
				var_30_21 = string.format(var_0_2.fearlessness_sea_node_letter, iter_30_5.flag .. var_30_6)
			end

			local var_30_23

			if iter_30_5.roundabout == 1 then
				var_30_23 = var_0_2.pve_g
				var_30_4.night_atk_point_2.image.sprite = self:loadSprite(var_0_2.pve_g)

				var_30_4.night_atk_point_2.image:SetNativeSize()
				var_30_4.night_atk_point_2:SetActive(true)

				var_30_4.night_atk_point_2.rectTransform.parent.offsetMin = var_0_23(0, 0)
				var_30_4.night_atk_point_2.rectTransform.parent.offsetMax = var_0_23(0, 0)
				var_30_4.night_atk_point_2.rectTransform.anchoredPosition = self:__get_real_node_pos(var_30_0, var_30_1, iter_30_5.position.x, iter_30_5.position.y) + var_0_23(8, 0)
			end

			local var_30_24 = {}

			if iter_30_5.night_atk == 1 then
				var_30_23 = var_0_2.pve_night_atk_l

				table.insert(var_30_24, var_0_2.pve_night_atk_l)
			end

			if iter_30_5.node_type == 10 then
				var_30_23 = var_0_2.pve_air

				table.insert(var_30_24, var_0_2.pve_air)
			elseif (iter_30_5.node_type == 11 or iter_30_5.node_type == 14) and not self.sea_map_user_data.finish_chase then
				var_30_23 = var_0_2.pve_special_boss_l

				table.insert(var_30_24, var_0_2.pve_special_boss_l)
			end

			if var_30_23 and next(var_30_24) then
				var_30_4.night_atk_point.image.sprite = self:loadSprite(var_30_23)

				var_30_4.night_atk_point.image:SetNativeSize()
				var_30_4.night_atk_point:SetActive(true)

				var_30_4.night_atk_point.rectTransform.parent.offsetMin = var_0_23(0, 0)
				var_30_4.night_atk_point.rectTransform.parent.offsetMax = var_0_23(0, 0)
				var_30_4.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_30_0, var_30_1, iter_30_5.position.x, iter_30_5.position.y) + var_0_23(8, 0)

				if iter_30_5.night_atk == 1 or iter_30_5.node_type == 10 or iter_30_5.node_type == 11 or iter_30_5.node_type == 14 then
					local var_30_25 = true

					if iter_30_5.node_type == 11 then
						local var_30_26 = var_0_4:get_map_list()[iter_30_5.pve_level_id]

						if var_30_26 then
							for iter_30_6, iter_30_7 in pairs(var_30_26.pass_point) do
								if iter_30_5.id == iter_30_7.id then
									for iter_30_8, iter_30_9 in ipairs(iter_30_7.info) do
										if iter_30_9.grade > 2 then
											var_30_25 = false

											break
										end
									end
								end
							end
						end
					end

					if var_30_25 then
						local var_30_27 = self:autoKillDOTween(var_0_21.Sequence())

						table.insert(self._light_seq_list, var_30_27)
						var_30_27:Append(var_30_4.night_atk_point.image:DOFade(0, 0))

						for iter_30_10, iter_30_11 in pairs(var_30_24) do
							var_30_27:Append(var_30_4.night_atk_point.image:DOFade(0, 0))
							var_30_27:AppendCallback(function()
								if var_30_4 and var_30_4.night_atk_point and not var_30_4.night_atk_point:Equals(nil) then
									var_30_4.night_atk_point.image.sprite = self:loadSprite(iter_30_11)
								end
							end)
							var_30_27:Append(var_30_4.night_atk_point.image:DOFade(1, 1))
							var_30_27:Append(var_30_4.night_atk_point.image:DOFade(0, 1))
						end

						var_30_27:SetLoops(-1)
						var_30_27:Play()
					end
				end
			else
				var_30_4.night_atk_point:SetActive(false)
			end

			var_30_4.node_image.random_buff_icon:SetActive(false)

			local var_30_28 = {}

			for iter_30_12, iter_30_13 in pairs(var_30_2) do
				if iter_30_13.hide_start_point == iter_30_5.id then
					for iter_30_14, iter_30_15 in pairs(iter_30_13.hide_result) do
						local var_30_30 = var_0_12.find_object_by_id(tonumber(iter_30_14))

						if var_0_4:is_cur_seventh_map_node_pass(var_30_30.pve_level_id, var_30_30.id) and var_0_4:get_seven_map_node_pass_count(var_30_30.pve_level_id, var_30_30.id) >= 1 then
							for iter_30_16, iter_30_17 in pairs(iter_30_5.next_node) do
								if iter_30_17 == tonumber(iter_30_13.hide_end_point) then
									table.insert(var_30_28, iter_30_17)
								end
							end
						end
					end
				end
			end

			local var_30_31 = {}
			local var_30_32 = true

			if iter_30_5.node_hide and next(iter_30_5.node_hide) then
				for iter_30_18, iter_30_19 in pairs(iter_30_5.node_hide) do
					for iter_30_20, iter_30_21 in pairs(iter_30_5.next_node) do
						if tonumber(iter_30_18) == iter_30_21 then
							for iter_30_22, iter_30_23 in pairs(iter_30_19) do
								local var_30_34 = var_0_12.find_object_by_id(tonumber(iter_30_23))
								local var_30_35 = var_0_4:get_map_node_pass_count(var_30_34.pve_level_id, var_30_34.id)

								if not var_0_4:is_pass_seventh_map_node(var_30_34.pve_level_id, var_30_34.id) then
									var_30_32 = false
								end
							end

							var_30_31 = {
								is_show_true = var_30_32,
								node_flag = var_0_12.find_object_by_id(tonumber(iter_30_18)).flag
							}
						end
					end
				end
			end

			if iter_30_5.next_node_path ~= "{}" then
				for iter_30_24, iter_30_25 in pairs((var_0_19(iter_30_5.next_node_path))) do
					local var_30_37, var_30_38 = self:loadUIPrefab("map_line_obj", arg_30_2.transform)

					var_30_37:setVisible(true)

					var_30_38.line_image.rectTransform.parent.offsetMin = var_0_23(0, 0)
					var_30_38.line_image.rectTransform.parent.offsetMax = var_0_23(0, 0)
					var_30_38.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_30_0, var_30_1, iter_30_25.x, iter_30_25.y)
					var_30_38.line_image.image.sprite = self:loadSprite((string.format(var_0_2.mapline_path, string.lower(arg_30_3), iter_30_24)))
					var_30_38.line_image.transform.localScale = var_0_28(0.75, 0.75, 1)

					var_30_38.line_image.image:SetNativeSize()
					var_30_38.line_image:SetActive(true)

					var_30_38.line_image.image.color = UnityEngine.Color(1, 1, 1, 1)

					if next(var_30_31) and var_30_31.node_flag == lx.split(iter_30_24, "-")[3] then
						var_30_38.line_image.image.color = var_30_31.is_show_true and UnityEngine.Color(1, 1, 1, 1) or UnityEngine.Color(1, 1, 1, 0.2)
					end

					if next(var_30_28) then
						for iter_30_26, iter_30_27 in pairs(var_30_28) do
							if string.format("%s-%s-%s", iter_30_5.pve_level_id, iter_30_5.flag, var_0_12.find_object_by_id(iter_30_27).flag) == iter_30_24 then
								var_30_38.line_image:SetActive(false)
							end
						end
					end
				end
			end

			for iter_30_28, iter_30_29 in pairs((var_0_4:get_push_random_buff())) do
				if iter_30_29.point_id == iter_30_5.id then
					var_30_4.node_image.random_buff_icon:SetActive(true)
				end
			end

			if #iter_30_5.flag > 0 then
				local var_30_39, var_30_40 = self:loadUIPrefab("fearlessness_sea_letter_obj", arg_30_2.transform)

				var_30_39:setVisible(true)

				var_30_40.node_letter_image.rectTransform.parent.offsetMin = var_0_23(0, 0)
				var_30_40.node_letter_image.rectTransform.parent.offsetMax = var_0_23(0, 0)
				var_30_40.node_letter_image.rectTransform.anchoredPosition = var_30_4.node_image.rectTransform.anchoredPosition + var_0_23(18, 30)
				var_30_40.node_letter_image.image.sprite = self:loadSprite(var_30_21)
			end
		end
	end

	function arg_1_0:__show_award_detail()
		local var_37_0 = self:__get_award_type()

		self._control.cloud_list.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 2
		self._control.map_preview.map_bg.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3

		if var_37_0 == var_0_2.reward_type.equipment then
			self:__show_equip_mask(true)

			self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

			self._equip_attr._panel.transform:SetParent(self._panel.transform)
			self._equip_attr:show((var_0_14.find_object_by_cid(self._current_reward_id)))

			if self._equip_attr then
				self._equip_attr._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3
			end
		elseif var_37_0 == var_0_2.reward_type.ship then
			var_0_1:createInstance("ship_detail"):show(var_0_2.enter_ship_detail_type.seven_bootyshop, (var_0_6.find_object_by_cid(self._current_reward_id)))
			self:show_cover_func(true)
			self:setVisible(false)
		elseif var_37_0 == var_0_2.reward_type.item then
			var_0_1:createInstance("specificdetails"):show(self._current_reward_id, var_0_2.enter_icon_detail_type.bootyshop_item)
		elseif var_37_0 == var_0_2.reward_type.cg then
			var_0_1:createInstance("specificdetails"):show(self._current_reward_id, var_0_2.enter_icon_detail_type.bootyshop_cg)

			return
		end
	end

	function arg_1_0:__get_award_type(arg_38_1)
		if arg_38_1 then
			local var_38_0 = var_0_11.find_object_by_id(arg_38_1)

			self._current_reward_id = var_38_0.award[1].id
			self._current_reward_count = var_38_0.award[1].value
		end

		if self._current_reward_id >= 10000000 then
			if self._current_reward_id % 100 == 21 then
				return var_0_2.reward_type.equipment
			elseif self._current_reward_id % 100 == 11 or self._current_reward_id % 100 == 12 or self._current_reward_id % 100 == 13 then
				return var_0_2.reward_type.ship
			elseif self._current_reward_id % 100 == 61 then
				return var_0_2.reward_type.head_icon
			elseif self._current_reward_id % 100 == 71 then
				return var_0_2.reward_type.furniture
			end
		elseif self._current_reward_id % 100 == 81 then
			return var_0_2.reward_type.cg
		else
			return var_0_2.reward_type.item
		end
	end

	function arg_1_0:__show_equip_mask(arg_39_1)
		self._control.equip_mask:SetActive(arg_39_1)

		if self._equip_attr then
			self._equip_attr._panel:SetActive(arg_39_1)
		end
	end

	function arg_1_0:__set_operational_func()
		self._now_move_num = nil
		self._now_move_func = nil

		self:setVisible(false)

		local var_40_0 = var_0_1:getInstance("mix_battle_plan")

		if var_40_0 then
			var_40_0:setVisible(true)

			var_40_0._activity_num = 7
		else
			var_0_1:createInstance("mix_battle_plan"):show(7)
		end

		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
	end

	function arg_1_0:set_boss_func(arg_41_1)
		self:__set_boss_func(arg_41_1)
	end

	function arg_1_0:__set_boss_func(arg_42_1)
		self._control.map_preview:SetActive(true)
		self:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.open))

		local var_42_0 = self:autoKillDOTween(var_0_21.Sequence())

		var_42_0:Append(self._control.map_preview.map_bg.transform:DOScale(0, 0))
		var_42_0:Append(self._control.map_preview.map_bg.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack)):OnComplete(function()
			local var_43_0 = var_0_4:get_account_id()
			local var_43_1 = tonumber(var_0_25:getDataByID(var_0_26("is_seven_station_%d", self.sea_map_data.id), var_43_0))

			if var_43_1 and self.sea_map_data.id == var_43_1 then
				var_0_1:destroyInstance("suppress_msg")
				var_0_1:createInstance("suppress_msg"):show("suppressed", nil, 1.5, true)
				var_0_25:setDataByID(var_0_26("is_seven_station_%d", self.sea_map_data.id), var_43_0, "have_show")
			end
		end)
		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
	end

	function arg_1_0:__set_encounter_func(arg_44_1, arg_44_2)
		self._is_encounter = arg_44_2

		self._control.enemy_info_bg:SetActive(true)

		self._control.enemy_info_bg.fight_btn.text.text.text = arg_44_2 and var_0_20:getNowLang("7th_explore_encounter") or var_0_20:getNowLang("7th_explore_prepare")

		local var_44_0 = arg_44_1.monster
		local var_44_1 = var_0_9.find_object_by_id(arg_44_1.monster)

		if not var_44_1 then
			var_44_0 = 20101002
			var_44_1 = var_0_9.find_object_by_id(20101002)
		end

		self._control.enemy_info_bg.enemy_info_txt.text.text = nil
		self._control.enemy_info_bg.enemy_info_txt.text.text = nil
		self._control.enemy_info_bg.s_enemy_info.text.text = var_0_20:getNowLang("warenemy") .. "-" .. var_0_20:getNowLang(string.format("warformation%s", var_44_1.formation_id))

		for iter_44_0 = 1, self._control.enemy_info_bg.enemy_list.transform.childCount do
			self:destroyGameObject(self._control.enemy_info_bg.enemy_list.transform:GetChild(iter_44_0 - 1).gameObject)
		end

		for iter_44_1, iter_44_2 in ipairs(var_44_1.formation) do
			local var_44_2 = var_0_8.find_object_by_id(iter_44_2)
			local var_44_3, var_44_4 = self:loadUIPrefab("fight_info_item", self._control.enemy_info_bg.enemy_list.rectTransform)

			var_44_3:setVisible(true)

			var_44_4.bg.ship_flag.image.enabled = iter_44_1 == 1
			var_44_4.bg.ship_type.text.text = var_0_20:getNowLang(var_0_2:get_ship_type_language_key(var_44_2.type, 1))
			var_44_4.bg.ship_icon.image.sprite = self:loadSprite(string.format(var_0_2.ship_icon.model_normal_s, var_44_2.pic_id, var_44_2.pic_id))
			var_44_4.bg.image.sprite = self:loadSprite(var_0_2.ship_attrib_bg[var_44_2.star == 0 and 6 or var_44_2.star])
		end

		self._control.enemy_info_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
		self._control.enemy_info_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()
		self:__show_monster_formation(var_44_0, self._control.enemy_info_bg.radar_frame.monster_formation)
		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
	end

	function arg_1_0:__set_can_not_enter()
		var_0_22:show(var_0_20:getNowLang("7th_explore_not_open"))

		self._now_move_num = nil
		self._now_move_func = nil

		var_0_4:req_SeventhBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
	end

	function arg_1_0.__show_monster_formation(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
		local var_46_0 = var_0_9.find_object_by_id(arg_46_1)

		if var_46_0 then
			local var_46_1 = #var_46_0.formation

			for iter_46_0 = 1, 5 do
				arg_46_2[string.format("formation%d", iter_46_0)].canvasGroup.alpha = 0

				if iter_46_0 == var_46_0.formation_id then
					for iter_46_1 = 1, 6 do
						arg_46_2[string.format("formation%d", iter_46_0)][string.format("num%d", iter_46_1)].gameObject:SetActive(iter_46_1 == var_46_1)
					end

					arg_46_2[string.format("formation%d", iter_46_0)].canvasGroup.alpha = 1
				end
			end
		end

		return var_46_0
	end

	function arg_1_0:__set_enemy_data()
		for iter_47_0, iter_47_1 in pairs(self.sea_map_user_data.elite) do
			if iter_47_1.state == 1 then
				local var_47_0 = self:__get_pos_by_rule_num(iter_47_1.pos)
				local var_47_1, var_47_2 = self:loadUIPrefab("seven_sea_map_single", self._control.enemy_list.transform)

				var_47_1:setVisible(true)

				var_47_1._panel:GetComponent("RectTransform").anchoredPosition = var_47_0

				var_47_2.enemy_role:SetActive(true)

				local var_47_3 = var_0_8.find_object_by_id((var_0_9.find_object_by_id(iter_47_1.monster) or var_0_9.find_object_by_id(20101002)).formation[1]).pic_id

				var_47_2.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_2.ship_spine, var_47_3, var_47_3))

				local var_47_4 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

				var_47_2.enemy_role.skeletonGraphic.material.shader = var_47_4
				var_47_2.enemy_role.shadow.skeletonGraphic.material.shader = var_47_4
				var_47_2.enemy_role.skeletonGraphic.initialSkinName = "default"

				if not var_47_2.enemy_role.skeletonGraphic:Equals(nil) then
					var_47_2.enemy_role.skeletonGraphic:Initialize(true)
				end

				self:__set_normal_anim(var_47_2.enemy_role, true)
				self:__set_noentry_area(iter_47_1.pos, var_47_0, var_47_2.enemy_role.enemy_role_collider.boxCollider2D.size)

				var_47_2.enemy_role.enemy_role_collider.trigger2DEvent.colliderName = "obstacle"

				var_47_2.enemy_role.enemy_role_btn.button.onClick:RemoveAllListeners()
				var_47_2.enemy_role.enemy_role_btn.button.onClick:AddListener(function()
					self._now_move_sizedelta = var_47_2.enemy_role.enemy_role_collider.boxCollider2D.size
					self._now_move_num = iter_47_1.pos
					self._is_short_click = true
					self._can_move = true
					self._is_creat_list = false
					self._now_move_func = {
						is_encounter = true,
						func_str = "encounter_func",
						monster_data = iter_47_1
					}
				end)
			end
		end

		local var_47_5 = self.sea_map_data.boss_position
		local var_47_6 = self:__get_pos_by_rule_num(self.sea_map_data.boss_position)
		local var_47_7, var_47_8 = self:loadUIPrefab("seven_sea_map_single", self._control.enemy_list.transform)

		var_47_7:setVisible(true)

		var_47_7._panel:GetComponent("RectTransform").anchoredPosition = var_47_6

		var_47_8.enemy_role:SetActive(true)
		var_47_8.enemy_role.boss_sign:SetActive(true)

		local var_47_9 = var_0_8.find_object_by_id(self.sea_map_data.boss_image).pic_id

		var_47_8.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_2.ship_spine, var_47_9, var_47_9))

		local var_47_10 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		var_47_8.enemy_role.skeletonGraphic.material.shader = var_47_10
		var_47_8.enemy_role.shadow.skeletonGraphic.material.shader = var_47_10
		var_47_8.enemy_role.skeletonGraphic.initialSkinName = "default"

		if not var_47_8.enemy_role.skeletonGraphic:Equals(nil) then
			var_47_8.enemy_role.skeletonGraphic:Initialize(true)
		end

		self:__set_normal_anim(var_47_8.enemy_role, true)
		self:__set_noentry_area(self.sea_map_data.boss_position, var_47_6, var_47_8.enemy_role.enemy_role_collider.boxCollider2D.size)

		var_47_8.enemy_role.enemy_role_collider.trigger2DEvent.colliderName = "obstacle"

		var_47_8.enemy_role.enemy_role_btn.button.onClick:RemoveAllListeners()
		var_47_8.enemy_role.enemy_role_btn.button.onClick:AddListener(function()
			self._now_move_sizedelta = var_47_8.enemy_role.enemy_role_collider.boxCollider2D.size
			self._now_move_num = var_47_5
			self._is_short_click = true
			self._can_move = true
			self._is_creat_list = false
			self._now_move_func = {
				func_str = "boss_func",
				monster_data = self.sea_map_data.boss_id
			}
		end)
	end

	function arg_1_0:__set_island_data()
		for iter_50_0, iter_50_1 in pairs(self.sea_map_data.island_position) do
			for iter_50_2, iter_50_3 in pairs(iter_50_1) do
				local var_50_0 = string.format(var_0_2.seven_year_sea_map.island, iter_50_2)

				for iter_50_4, iter_50_5 in pairs(iter_50_3) do
					local var_50_1 = self:__get_pos_by_rule_num(iter_50_5)
					local var_50_2, var_50_3 = self:loadUIPrefab("seven_sea_map_single", self._control.islands_list.transform)

					var_50_2:setVisible(true)

					var_50_2._panel:GetComponent("RectTransform").anchoredPosition = var_50_1

					var_50_3.islands:SetActive(true)

					var_50_3.islands.image.sprite = self:loadSprite(var_50_0)

					var_50_3.islands.image:SetNativeSize()

					var_50_3.islands.islands_collider.trigger2DEvent.colliderName = "obstacle"
					var_50_3.islands.islands_collider.boxCollider2D.size = var_50_3.islands.rectTransform.sizeDelta
					var_50_3.islands.islands_collider.boxCollider2D.offset = var_50_3.islands.rectTransform.sizeDelta / 2

					self:__set_noentry_area(iter_50_5, var_50_1, var_50_3.islands.rectTransform.sizeDelta)
					var_50_3.islands.islands_btn.button.onClick:RemoveAllListeners()
					var_50_3.islands.islands_btn.button.onClick:AddListener(function()
						self._now_move_sizedelta = var_50_3.islands.islands_collider.boxCollider2D.size
						self._now_move_num = iter_50_5
						self._is_short_click = true
						self._can_move = true
						self._is_creat_list = false
						self._now_move_func = nil
					end)

					if self._can_move and not self._is_short_click then
						self._now_move_num = nil
					end
				end
			end
		end
	end

	function arg_1_0:__set_exploration_data()
		local var_52_0 = self.sea_map_user_data.chase[1].pos
		local var_52_1 = true

		for iter_52_0, iter_52_1 in pairs(self.sea_map_user_data.elite) do
			if iter_52_1.state == 1 then
				var_52_1 = false
			end
		end

		local var_52_2 = self:__get_pos_by_rule_num(self.sea_map_user_data.chase[1].pos)
		local var_52_3, var_52_4 = self:loadUIPrefab("seven_sea_map_single", self._control.exploration_list.transform)

		var_52_3:setVisible(true)

		var_52_3._panel:GetComponent("RectTransform").anchoredPosition = var_52_2

		var_52_4.exploration_point:SetActive(true)

		local var_52_5 = var_0_2.seven_year_whirlpool_animation.off

		if var_52_1 then
			var_52_5 = var_0_2.seven_year_whirlpool_animation.on
		end

		var_52_4.exploration_point.exploration_point_collider.trigger2DEvent.colliderName = "obstacle"

		self:__set_noentry_area(self.sea_map_user_data.chase[1].pos, var_52_2, var_52_4.exploration_point.exploration_point_collider.boxCollider2D.size)
		var_52_4.exploration_point.exploration_point_btn.button.onClick:RemoveAllListeners()
		var_52_4.exploration_point.exploration_point_btn.button.onClick:AddListener(function()
			self._now_move_sizedelta = var_52_4.exploration_point.exploration_point_collider.boxCollider2D.size
			self._now_move_num = var_52_0
			self._is_short_click = true
			self._can_move = true
			self._is_creat_list = false
			self._now_move_func = var_52_1 and {
				is_encounter = false,
				func_str = "encounter_func",
				monster_data = self.sea_map_user_data.chase[1]
			} or {
				func_str = "can_not_enter"
			}
		end)
		self:__play_animation(var_52_4.exploration_point, var_52_5.name, true)
	end

	function arg_1_0:__set_operational_plan_data()
		local var_54_0 = self.sea_map_data.battle_plan_position
		local var_54_1 = self:__get_pos_by_rule_num(self.sea_map_data.battle_plan_position)
		local var_54_2, var_54_3 = self:loadUIPrefab("seven_sea_map_single", self._control.operational_list.transform)

		var_54_2:setVisible(true)

		var_54_2._panel:GetComponent("RectTransform").anchoredPosition = var_54_1

		var_54_3.operational_plan_point:SetActive(true)
		self:__play_animation(var_54_3.operational_plan_point.operational_plan_skeleton, var_0_2.seven_year_operational_plan_animation.offshore_work_platform.name, true)

		var_54_3.operational_plan_point.operational_plan_collider.trigger2DEvent.colliderName = "obstacle"

		self:__set_noentry_area(self.sea_map_data.battle_plan_position, var_54_1, var_54_3.operational_plan_point.operational_plan_collider.boxCollider2D.size)
		var_54_3.operational_plan_point.operational_plan_point_btn.button.onClick:RemoveAllListeners()
		var_54_3.operational_plan_point.operational_plan_point_btn.button.onClick:AddListener(function()
			self._now_move_sizedelta = var_54_3.operational_plan_point.operational_plan_collider.boxCollider2D.size
			self._now_move_num = var_54_0
			self._is_short_click = true
			self._can_move = true
			self._is_creat_list = false
			self._now_move_func = {
				func_str = "operational_func",
				operational_data = v
			}
		end)
	end

	function arg_1_0:__get_now_move_pos(arg_56_1, arg_56_2, arg_56_3)
		if arg_56_1 == arg_56_2 then
			self.player_now_num = arg_56_1 - 1

			return arg_56_3
		end

		local var_56_1 = 1
		local var_56_2 = 0

		if arg_56_1 % 20 == self.sea_map_data.ocean_size % 20 then
			var_56_1 = arg_56_1 - 1
			var_56_2 = -1
		elseif arg_56_1 % 20 == 1 then
			var_56_1 = arg_56_1
			var_56_2 = 1
		else
			local var_56_7 = arg_56_1 % 20 == 0 and 20 or arg_56_1 % 20
			local var_56_8 = arg_56_2 % 20 == 0 and 20 or arg_56_2 % 20

			if (arg_56_2 % 20 == 0 and 20 or arg_56_2 % 20) < (arg_56_1 % 20 == 0 and 20 or arg_56_1 % 20) then
				var_56_1 = arg_56_1 - 1
				var_56_2 = -1
			elseif var_56_7 < var_56_8 then
				var_56_1 = arg_56_1 + 1
				var_56_2 = 1
			elseif var_56_7 == var_56_8 then
				if arg_56_1 < arg_56_2 then
					var_56_1 = arg_56_1 + 20
					var_56_2 = 20
				elseif arg_56_2 < arg_56_1 then
					var_56_1 = arg_56_1 - 20
					var_56_2 = -20
				end
			end
		end

		if self._now_move_func then
			if self.obstacle_list[var_56_1] and (self.obstacle_list[var_56_1].x > 64 or self.obstacle_list[var_56_1].y > 64) then
				if math.abs(var_56_2) == 20 then
					var_56_1 = var_56_1 + 1 * var_56_2 / 20 - var_56_2
				end

				if math.abs(var_56_2) == 1 then
					var_56_1 = var_56_1 + 20 * var_56_2 - var_56_2
				end
			end

			if self.obstacle_list[var_56_1] and (self.obstacle_list[var_56_1].x > 64 or self.obstacle_list[var_56_1].y > 64) then
				if math.abs(var_56_2) == 20 then
					var_56_1 = var_56_1 - 1 * var_56_2 / 20 - var_56_2
				end

				if math.abs(var_56_2) == 1 then
					var_56_1 = var_56_1 - 20 * var_56_2 - var_56_2
				end
			end
		else
			while self.obstacle_list[var_56_1] do
				if self.obstacle_list[var_56_1].x <= 64 or self.obstacle_list[var_56_1].y <= 64 then
					break
				end

				var_56_1 = var_56_1 + var_56_2
			end
		end

		self.player_now_num = var_56_1

		return self:__get_pos_by_rule_num(var_56_1) + var_0_28(64, 64, 0)
	end

	function arg_1_0:__set_run_anim()
		if not self._is_move_anim then
			self._control.player_role.spray:SetActive(true)

			self._is_move_anim = true

			self:__play_animation(self._control.player_role, var_0_2.character_anim_type.w.name, var_0_2.character_anim_type.w.loop)
		end
	end

	function arg_1_0:__set_normal_anim(arg_58_1, arg_58_2)
		if self._is_move_anim or arg_58_2 then
			self._control.player_role.spray:SetActive(false)

			self._is_move_anim = false

			self:__play_animation(arg_58_1, var_0_2.character_anim_type.normal.name, var_0_2.character_anim_type.normal.loop)
		end
	end

	function arg_1_0:_revert_find_btn_setting()
		self._find_btn_start = false
		self._find_btn_time = 0

		if self._sea_treasure_num == 0 then
			self._control.explore.btn.image.sprite = self:loadSprite(var_0_2.seven_ban_find_treasure_img)
		else
			self._control.explore.btn.button.enabled = true
			self._control.explore.btn.image.sprite = self:loadSprite(var_0_2.seven_find_treasure_img)
		end
	end

	function arg_1_0:__set_click_move(arg_60_1)
		self:_close_all_find_ani()
		self:_revert_find_btn_setting()

		local var_60_0 = 50
		local var_60_3, var_60_4 = var_0_16.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_15.mousePosition, self._ui_camera, nil)
		local var_60_5 = var_60_3
		local var_60_6 = self._control.player_role.rectTransform.anchoredPosition
		local var_60_7 = self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition
		local var_60_8 = var_60_4 + self.sceen_center_pos + var_0_23(0, 60)

		if not arg_60_1 and (var_60_8.x < 0 or var_60_8.x > self._uiroot_canvas_rect.rect.width or var_60_8.y < 0 or var_60_8.y > self._uiroot_canvas_rect.rect.height) then
			return
		end

		local var_60_9 = var_60_8 - self._control.empty_bg.rectTransform.anchoredPosition
		local var_60_10

		if self._now_move_num then
			var_60_10 = self:__get_now_move_pos(self._now_move_num, self:__get_rule_num_by_pos(self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition), var_60_7)
			var_60_0 = 10

			if self._is_mouse_in_no_enter then
				var_60_0 = 50
			end
		end

		if not arg_60_1 then
			self._map_target_pos = var_60_9
		elseif self._map_target_pos then
			var_60_9 = self._map_target_pos
		else
			self._map_target_pos = var_60_9
		end

		if var_60_10 then
			var_60_9 = var_60_10
		end

		local var_60_11 = self:__get_rule_num_by_pos(var_60_9)

		if not arg_60_1 and var_60_11 ~= self._map_target_num or arg_60_1 and not self._is_creat_list and not next(self.target_pos_list) then
			self._map_target_num = var_60_11
			self.target_pos_list = self:__get_player_move_pos_by_a_start(var_60_7, var_60_9)
			self._is_creat_list = true
		end

		if not self._is_move_list and next(self.target_pos_list) then
			self._control.move_point.rectTransform.anchoredPosition = self.target_pos_list[1]
			self._is_move_list = true
			var_60_0 = 10
		end

		if self._control.move_point.rectTransform.anchoredPosition ~= var_0_23(0, 0) then
			var_60_8 = self._control.move_point.rectTransform.anchoredPosition + self._control.empty_bg.rectTransform.localPosition
		end

		if var_60_5 then
			local var_60_14
			local var_60_13
			local var_60_12

			if var_60_0 > var_0_23.Distance(var_60_8, var_60_6) then
				if not next(self.target_pos_list) then
					self._is_creat_list = false
					self._is_short_click = false

					self:__set_normal_anim(self._control.player_role)

					if arg_60_1 then
						self._can_move = false
					end

					self.is_stop = true

					if self._now_move_func then
						if self["__set_" .. self._now_move_func.func_str] then
							self["__set_" .. self._now_move_func.func_str](self, self._now_move_func.monster_data, self._now_move_func.is_encounter)
						end
					end
				else
					table.remove(self.target_pos_list, 1)

					self._is_move_list = false
				end

				do return end

				var_60_12 = self._control.empty_bg.rectTransform.sizeDelta
				var_60_13 = -var_0_23.Normalize(var_60_8 - var_60_6) / 0.06
				var_60_14 = var_0_23.Normalize(var_60_8 - var_60_6) / 0.06
			end

			local var_60_15 = var_0_23(self._control.empty_bg.rectTransform.localPosition.x, self._control.empty_bg.rectTransform.localPosition.y) + var_60_13
			local var_60_16 = var_0_28(var_60_14.x, var_60_14.y, 0)
			local var_60_19 = (var_60_15.x < 0 and var_60_15.x > -var_60_12.x + self.sceen_center_pos.x * 2 or false) and (var_60_6.x >= self.sceen_center_pos.x or var_60_16.x <= 0) and (var_60_6.x <= self.sceen_center_pos.x or var_60_16.x >= 0)
			local var_60_20 = (var_60_15.y < 0 and var_60_15.y > -var_60_12.y + self.sceen_center_pos.y * 2 + 120 or false) and (var_60_6.y >= self.sceen_center_pos.y or var_60_16.y <= 0) and (var_60_6.y <= self.sceen_center_pos.y or var_60_16.y >= 0)
			local var_60_21 = var_0_23.Normalize((var_0_28(var_60_13.x, var_60_13.y, 0))) / 0.075
			local var_60_22 = var_0_23.Normalize(var_60_16) / 0.075
			local var_60_23

			if (var_60_15.x < 0 and var_60_15.x > -var_60_12.x + self.sceen_center_pos.x * 2 or false) and (var_60_6.x >= self.sceen_center_pos.x or var_60_16.x <= 0) and (var_60_6.x <= self.sceen_center_pos.x or var_60_16.x >= 0) then
				var_60_23 = var_60_21.x or 0

				local var_60_24

				if var_60_20 then
					var_60_24 = var_60_21.y or 0
				end
			end

			local var_60_25 = var_0_28(var_60_23, var_60_24, 0)

			temp_player_move_pos = var_0_28(var_60_19 and 0 or var_60_22.x, var_60_20 and 0 or var_60_22.y, 0)

			if var_60_25 ~= var_0_28.zero then
				self._control.empty_bg.rectTransform.localPosition = self._control.empty_bg.rectTransform.localPosition + var_60_25
			end

			if temp_player_move_pos ~= var_0_28.zero then
				self._control.player_role.rectTransform.localPosition = self._control.player_role.rectTransform.localPosition + temp_player_move_pos
			end

			self:set_position_by_rule()

			if var_60_19 then
				self:__set_player_face(var_60_25)
			else
				self:__set_player_face(-temp_player_move_pos)
			end
		end
	end

	function arg_1_0:__get_player_move_pos_by_a_start(arg_61_1, arg_61_2)
		local var_61_0, var_61_1, var_61_2 = self:__get_rule_num_by_pos(arg_61_1)
		local var_61_3, var_61_4, var_61_5 = self:__get_rule_num_by_pos(arg_61_2)

		var_61_1 = var_61_1 == 0 and 20 or var_61_1
		var_61_4 = var_61_4 == 0 and 20 or var_61_4

		local var_61_8 = math.ceil(self.sea_map_data.ocean_size / 20)

		if var_61_5 >= var_61_8 - 2 then
			var_61_5 = var_61_8 - 2
		end

		local var_61_9 = var_0_23(var_61_1, var_61_2)
		local var_61_10 = var_0_23(var_61_4, var_61_5)
		local var_61_11 = not not (self.obstacle_list[var_61_3] and self.obstacle_list[var_61_3].x > 64 and self.obstacle_list[var_61_3].y > 64)
		local var_61_12 = {
			g = 0,
			point = var_61_9,
			h = self:__ManHattan(var_61_9, var_61_10)
		}

		if not self:__is_in_map(var_61_10) then
			return {
				arg_61_1
			}
		end

		var_61_12.f = var_61_12.g + var_61_12.h

		local var_61_17 = {}

		table.insert(var_61_17, var_61_12)

		local var_61_19 = {}
		local var_61_21
		local var_61_22 = false

		while #var_61_17 > 0 and 0 < 40 do
			var_61_21 = var_61_17[1]

			local var_61_24 = 1
			local var_61_25 = var_61_17[1].f

			for iter_61_0, iter_61_1 in ipairs(var_61_17) do
				if var_61_25 >= iter_61_1.f then
					var_61_25 = iter_61_1.f
					var_61_21 = iter_61_1
					var_61_24 = iter_61_0
				end
			end

			table.remove(var_61_17, var_61_24)
			table.insert(var_61_19, var_61_21)

			local var_61_26 = false

			if var_61_11 then
				for iter_61_2 = -1, 1 do
					for iter_61_3 = -1, 1 do
						if var_61_21.point.x == var_61_10.x + iter_61_2 and var_61_21.point.y == var_61_10.y + iter_61_3 then
							var_61_26 = true
						end
					end
				end
			elseif var_61_21.point.x == var_61_10.x and var_61_21.point.y == var_61_10.y then
				var_61_26 = true
			end

			if var_61_26 then
				var_61_22 = true

				break
			end

			local var_61_27 = var_61_21.point

			self:__add_to_openlist(var_0_23(var_61_21.point.x - 1, var_61_21.point.y), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x + 1, var_61_27.y), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x, var_61_27.y - 1), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x, var_61_27.y + 1), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x - 1, var_61_27.y - 1), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x + 1, var_61_27.y - 1), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x - 1, var_61_27.y + 1), var_61_21, var_61_17, var_61_19, var_61_10)
			self:__add_to_openlist(var_0_23(var_61_27.x + 1, var_61_27.y + 1), var_61_21, var_61_17, var_61_19, var_61_10)
		end

		if not var_61_22 then
			return {
				arg_61_1
			}
		end

		local var_61_28 = {}

		while var_61_21 and var_61_21.point ~= var_61_9 do
			table.insert(var_61_28, var_61_21.point)

			var_61_21 = var_61_21.parent
		end

		if not next(var_61_28) then
			return {
				arg_61_1
			}
		end

		local var_61_29 = {}

		for iter_61_4 = #var_61_28, 1, -1 do
			local var_61_30, var_61_31 = self:__get_next_pos(var_61_28[iter_61_4])

			if var_61_30 then
				table.insert(var_61_29, var_61_31)
			end
		end

		return var_61_29
	end

	function arg_1_0:__get_next_pos(arg_62_1)
		local var_62_0 = self:__is_in_map(arg_62_1)
		local var_62_1
		local var_62_2

		if var_62_0 then
			var_62_1 = arg_62_1.x + 20 * arg_62_1.y
			var_62_2 = self:__get_pos_by_rule_num(arg_62_1.x + 20 * arg_62_1.y)
			var_62_2 = var_0_23(var_62_2.x, var_62_2.y) + var_0_23(64, 64)
		end

		return var_62_0, var_62_2, var_62_1
	end

	function arg_1_0.__ManHattan(arg_63_0, arg_63_1, arg_63_2)
		local var_63_0 = math.min(math.abs(arg_63_1.x - arg_63_2.x), math.abs(arg_63_1.y - arg_63_2.y))

		return 14 * var_63_0 + 10 * (math.abs(arg_63_1.x - arg_63_2.x) + math.abs(arg_63_1.y - arg_63_2.y) - 2 * var_63_0)
	end

	function arg_1_0:__add_to_openlist(arg_64_1, arg_64_2, arg_64_3, arg_64_4, arg_64_5)
		local var_64_0 = var_0_5.little_clone(arg_64_2)
		local var_64_1, var_64_2, var_64_3 = self:__get_next_pos(arg_64_1)

		if var_64_1 and (not self.obstacle_list[var_64_3] or self.obstacle_list[var_64_3].x <= 64 or self.obstacle_list[var_64_3].y <= 64) and not self:__have_point(arg_64_4, arg_64_1) then
			local var_64_4 = {
				parent = var_64_0,
				point = arg_64_1,
				g = var_64_0.g + 1,
				h = self:__ManHattan(arg_64_1, arg_64_5)
			}

			var_64_4.f = var_64_4.g + var_64_4.h

			local var_64_5, var_64_6 = self:__have_point(arg_64_3, arg_64_1)

			if var_64_5 then
				if var_64_4.f < var_64_5.f then
					arg_64_3[var_64_6] = var_64_4
				end
			else
				table.insert(arg_64_3, var_64_4)
			end
		end
	end

	function arg_1_0:__is_in_map(arg_65_1)
		local var_65_0 = self.sea_map_data.ocean_size
		local var_65_1 = math.ceil(self.sea_map_data.ocean_size / 20) - 1

		if (self.sea_map_data.ocean_size % 20 == 0 and 20 or var_65_0 % 20) < arg_65_1.x then
			return false
		end

		if var_65_1 <= arg_65_1.y then
			return false
		end

		if arg_65_1.x <= 0 then
			return false
		end

		if arg_65_1.y < 0 then
			return false
		end

		return true
	end

	function arg_1_0.__have_point(arg_66_0, arg_66_1, arg_66_2)
		for iter_66_0, iter_66_1 in ipairs(arg_66_1) do
			if iter_66_1.point.x == arg_66_2.x and iter_66_1.point.y == arg_66_2.y then
				return iter_66_1, iter_66_0
			end
		end

		return false
	end

	function arg_1_0:__set_player_face(arg_67_1)
		if arg_67_1.x > 0 and self._control.player_role.rectTransform.localScale.x > 0 then
			self._now_face = 1
			self._control.player_role.rectTransform.localScale = var_0_28(-self._control.player_role.rectTransform.localScale.x, self._control.player_role.rectTransform.localScale.y, self._control.player_role.rectTransform.localScale.z)
		end

		if arg_67_1.x < 0 and self._control.player_role.rectTransform.localScale.x < 0 then
			self._now_face = 2
			self._control.player_role.rectTransform.localScale = var_0_28(-self._control.player_role.rectTransform.localScale.x, self._control.player_role.rectTransform.localScale.y, self._control.player_role.rectTransform.localScale.z)
		end
	end

	function arg_1_0:set_position_by_rule()
		local var_68_0 = self._control.empty_bg.rectTransform.anchoredPosition
		local var_68_1 = var_0_23(0, 0)
		local var_68_2 = var_0_23(-self._control.empty_bg.rectTransform.sizeDelta.x + self.sceen_center_pos.x * 2, -self._control.empty_bg.rectTransform.sizeDelta.y + self.sceen_center_pos.y * 2 + 120)
		local var_68_3 = var_0_23(0, 0)

		if self._control.empty_bg.rectTransform.anchoredPosition.x >= var_68_1.x then
			var_68_3 = var_0_23(var_68_0.x - var_68_1.x, var_68_3.y)
			var_68_0 = var_0_23(var_68_1.x, var_68_0.y)
		end

		if var_68_0.y >= var_68_1.y then
			var_68_3 = var_0_23(var_68_3.x, var_68_0.y - var_68_1.y)
			var_68_0 = var_0_23(var_68_0.x, var_68_1.y)
		end

		if var_68_0.x <= var_68_2.x then
			var_68_3 = var_0_23(var_68_0.x - var_68_2.x, var_68_3.y)
			var_68_0 = var_0_23(var_68_2.x, var_68_0.y)
		end

		if var_68_0.y <= var_68_2.y then
			var_68_3 = var_0_23(var_68_3.x, var_68_0.y - var_68_2.y)
			var_68_0 = var_0_23(var_68_0.x, var_68_2.y)
		end

		self._control.empty_bg.rectTransform.anchoredPosition = var_68_0

		return var_68_3
	end

	function arg_1_0:_now_angle_func()
		self._now_need_angle = 0
		self._need_line_top = 0
		self._need_line_bottom = 0
		self._need_line_top_time = 0
		self._need_line_bottom_time = 0
		self._now_need_direction = 0
		self._control.top_find_ani.scattering.transform.localScale = var_0_28.New(0, 0, 1)

		local var_69_0 = self:__get_rule_num_by_pos(self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition)
		local var_69_1 = Mathf.Abs((self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x)
		local var_69_2 = Mathf.Sqrt(Mathf.Pow(var_69_1, 2) + Mathf.Pow(Mathf.Abs((self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y), 2))

		self._now_find_distance = var_69_2
		self._now_need_angle = 90 - math.floor(Mathf.Asin(var_69_1 / var_69_2) / Mathf.PI * 180)
		self._need_line_top_time = 0.3
		self._need_line_bottom_time = 0.3
		self._is_right_angle = false

		if (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x < 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y < 0 then
			self._is_right_angle = false
			self._now_need_direction = 4

			if self._now_face == 1 then
				self._need_line_top = self._now_need_angle + 20
				self._need_line_bottom = self._now_need_angle - 20
				self._now_need_angle = 180 - self._now_need_angle
				self._now_scattering_angle = 90 + self._need_line_top
			else
				self._need_line_top = self._now_need_angle + 20
				self._need_line_bottom = self._now_need_angle - 20
				self._now_need_angle = self._now_need_angle
				self._now_scattering_angle = self._need_line_top + 90
			end
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x > 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y < 0 then
			self._is_right_angle = false
			self._now_need_direction = 3

			if self._now_face == 1 then
				self._need_line_top = 180 - self._now_need_angle + 20
				self._need_line_bottom = 180 - self._now_need_angle - 20
				self._now_need_angle = self._now_need_angle
				self._now_scattering_angle = self._need_line_top - 270
			else
				self._need_line_top = 180 - self._now_need_angle + 20
				self._need_line_bottom = 180 - self._now_need_angle - 20
				self._now_need_angle = 180 - self._now_need_angle
				self._now_scattering_angle = self._need_line_top - 270
			end
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x > 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y > 0 then
			self._is_right_angle = false
			self._now_need_direction = 2

			if self._now_face == 1 then
				self._need_line_top = self._now_need_angle + 20 - 180
				self._need_line_bottom = 180 + self._now_need_angle - 20
				self._now_scattering_angle = self._need_line_top + 90
				self._now_need_angle = -self._now_need_angle
			else
				self._need_line_top = -180 + self._now_need_angle - 20
				self._need_line_bottom = -180 + self._now_need_angle + 20
				self._now_scattering_angle = 90 + self._need_line_bottom
				self._now_need_angle = -180 + self._now_need_angle
			end
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x < 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y > 0 then
			self._is_right_angle = false
			self._now_need_direction = 1

			if self._now_face == 1 then
				self._need_line_top = -self._now_need_angle - 20
				self._need_line_bottom = -self._now_need_angle + 20
				self._now_scattering_angle = self._need_line_bottom + 90
				self._now_need_angle = self._now_need_angle - 180
			else
				self._need_line_top = -self._now_need_angle - 20
				self._need_line_bottom = -self._now_need_angle + 20
				self._now_scattering_angle = 90 + self._need_line_bottom
				self._now_need_angle = -self._now_need_angle
			end
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x > 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y == 0 then
			self._is_right_angle = true
			self._now_need_direction = 5

			if self._now_face == 1 then
				self._need_line_top = 155
				self._need_line_bottom = -155
				self._now_need_angle = 0
			else
				self._need_line_top = 155
				self._need_line_bottom = 205
				self._now_need_angle = 180
			end

			self._now_scattering_angle = -65
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x == 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y > 0 then
			self._is_right_angle = true
			self._now_need_direction = 6

			if self._now_face == 1 then
				self._need_line_top = -115
				self._need_line_bottom = -65
				self._now_need_angle = -90
			else
				self._need_line_top = -115
				self._need_line_bottom = -65
				self._now_need_angle = -90
			end

			self._now_scattering_angle = 25
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x < 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y == 0 then
			self._is_right_angle = true
			self._now_need_direction = 7

			if self._now_face == 1 then
				self._need_line_top = 25
				self._need_line_bottom = -25
				self._now_need_angle = 180
			else
				self._need_line_top = 25
				self._need_line_bottom = -25
				self._now_need_angle = 0
			end

			self._now_scattering_angle = 115
		elseif (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).x - self._treasure_pos.x == 0 and (self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition).y - self._treasure_pos.y < 0 then
			self._is_right_angle = true
			self._now_need_direction = 8

			if self._now_face == 1 then
				self._need_line_top = 115
				self._need_line_bottom = 65
				self._now_need_angle = 90
			else
				self._need_line_top = 115
				self._need_line_bottom = 65
				self._now_need_angle = 90
			end

			self._now_scattering_angle = 205
		end
	end

	function arg_1_0:_set_find_line_angle()
		if self._now_need_direction == 1 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -90))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -90))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
			end
		elseif self._now_need_direction == 2 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -90))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 180))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -180))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -90))
			end
		elseif self._now_need_direction == 3 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 180))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 90))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 180))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 90))
			end
		elseif self._now_need_direction == 4 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 90))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 90))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
			end
		elseif self._now_need_direction == 5 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -135))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 235))
			end
		elseif self._now_need_direction == 6 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -45))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -45))
			end
		elseif self._now_need_direction == 7 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 45))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -45))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 45))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, -45))
			end
		elseif self._now_need_direction == 8 then
			if self._now_face == 1 then
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 45))
			else
				self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 135))
				self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 45))
			end
		end
	end

	function arg_1_0:back_find_info(arg_71_1)
		local var_71_0 = var_0_1:createInstance("msgbox")
		local var_71_1 = {}
		local var_71_2 = {}

		for iter_71_0, iter_71_1 in pairs(arg_71_1) do
			if iter_71_1.type == 4 then
				var_0_27(var_71_1, iter_71_1)
			end

			if iter_71_1.id == 30 and iter_71_1.type == 2 then
				var_0_27(var_71_2, iter_71_1)
			end
		end

		if #var_71_1 ~= 0 then
			var_0_1:createInstance("new_ship_or_equip"):show(true, var_71_1[1], var_0_2.enter_get_ship_type.seven_treasure_find)
		elseif #var_71_2 ~= 0 then
			var_0_22:show(var_71_2[1].count, "seven_find_config_card")

			self._control.point_coin.num.text.text = var_0_4:get_seventh_buff_point()
		else
			var_71_0:showOnes(arg_71_1, function()
				var_71_0:_play_into_se(var_0_2:get_audio_url(var_0_2.common_icon.music_path, var_0_2.back))
			end, nil, var_0_20:getNowLang("logget"), var_0_2.msg_type.rewards)
		end

		self._control.empty_bg.treasure:SetActive(false)
		self:_set_close_treasure_spiral_scale()

		self._set_spiral_is_doscale = false
		self._control.explore.btn.image.sprite = self:loadSprite(var_0_2.seven_ban_find_treasure_img)
		self._sea_treasure_num = var_0_4:get_seventh_map_info()[self._save_now_data].treasure_num
	end

	function arg_1_0:_set_find_ani()
		self:_close_all_find_ani()
		self:_now_angle_func()

		local var_73_0 = self._control.top_find_ani.chassis_top
		local var_73_1 = self._control.top_find_ani.chassis_radar_outside
		local var_73_2 = self._control.top_find_ani.chassis_radar_inside
		local var_73_3 = self._control.top_find_ani.scattering

		self._control.top_find_ani.find_ani:SetActive(false)
		var_73_0:SetActive(false)
		self._control.top_find_ani.chassis_radar:SetActive(false)
		var_73_1:SetActive(false)
		var_73_2:SetActive(false)
		var_73_3:SetActive(false)

		var_73_3.image.color = Color.New(1, 1, 1)
		var_73_1.image.color = Color.New(1, 1, 1)
		var_73_2.image.color = Color.New(1, 1, 1)
		var_73_0.image.color = Color.New(1, 1, 1)
		self._control.top_find_ani.chassis_top.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar_outside.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar_inside.canvasGroup.alpha = 0
		var_73_3.canvasGroup.alpha = 0
		var_73_1.transform.localScale = var_0_28.New(1, 0.5, 1)
		var_73_2.transform.localScale = var_0_28.New(0.32, 0.16, 1)
		var_73_0.transform.localScale = var_0_28.New(0.1, 0.05, 1)
		self._control.top_find_ani.transform.localPosition = var_0_28.New(self._control.player_role.transform.localPosition.x, self._control.player_role.transform.localPosition.y, 0)
		var_73_3.transform.localScale = var_0_28.New(0, 0, 1)

		self._control.top_find_ani.find_ani.line_top:SetActive(true)
		self._control.top_find_ani.find_ani.line_botton:SetActive(true)

		self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
		self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
		var_73_3.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))

		self:_set_find_line_angle()

		local var_73_7 = 0.1388888888888889
		local var_73_8 = 0.1111111111111111

		if 640 < self._now_find_distance then
			var_73_3.image.color = Color.New(1, 0.07450980392156863, 0.3803921568627451)
			var_73_1.image.color = Color.New(1, 0.07450980392156863, 0.3803921568627451)
			var_73_2.image.color = Color.New(1, 0.07450980392156863, 0.3803921568627451)
			var_73_0.image.color = Color.New(1, 0.07450980392156863, 0.3803921568627451)
		else
			var_73_3.image.color = Color.New(0.4392156862745098, 1, 0.7019607843137254)
			var_73_1.image.color = Color.New(0.4392156862745098, 1, 0.7019607843137254)
			var_73_2.image.color = Color.New(0.4392156862745098, 1, 0.7019607843137254)
			var_73_0.image.color = Color.New(0.4392156862745098, 1, 0.7019607843137254)
		end

		self._control.top_find_ani.find_ani:SetActive(true)
		self._control.top_find_ani.chassis_top:SetActive(true)
		self._control.top_find_ani.chassis_radar_outside:SetActive(true)
		self._control.top_find_ani.chassis_radar_inside:SetActive(true)
		var_73_3:SetActive(true)

		var_73_3.image.fillAmount = self._is_right_angle and math.abs(var_73_7) or math.abs(var_73_8)

		self._control.top_find_ani.find_ani.line_top.transform:DORotate(var_0_28(0, 0, self._need_line_top), self._need_line_top_time)
		self._control.top_find_ani.find_ani.line_botton.transform:DORotate(var_0_28(0, 0, self._need_line_bottom), self._need_line_bottom_time)

		self._control.player_role.radar.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, self._now_need_angle))
		var_73_3.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, self._now_scattering_angle))
		self._info_move_seq = {}

		local var_73_9 = self:autoKillDOTween(var_0_21.Sequence())

		var_0_27(self._info_move_seq, var_73_9)
		var_73_9:AppendInterval(0.1)
		var_73_2.canvasGroup:DOFade(0.6, 0.1)
		var_73_1.canvasGroup:DOFade(0.6, 0.1)
		var_73_0.canvasGroup:DOFade(0.3, 0.1)
		var_73_0.transform:DOScale(var_0_28.New(1, 0.6, 1), 1)
		var_73_3.canvasGroup:DOFade(0.6, 3)
		var_73_3.transform:DOScale(var_0_28.New(0.7, 0.7, 1), 1)
		var_73_9:AppendInterval(0.5)
		var_73_9:AppendCallback(function()
			var_73_9:Append(var_73_1.transform:DOScale(var_0_28.New(0.6, 0.3, 1), 0.3))
			var_73_9:Append(var_73_2.transform:DOScale(var_0_28.New(0.15, 0.075, 1), 0.3))
			var_73_9:Append(var_73_0.transform:DOScale(var_0_28.New(1, 0.4, 1), 0.6))
			var_73_9:Append(var_73_1.canvasGroup:DOFade(0, 0.6))
			var_73_9:Append(var_73_2.canvasGroup:DOFade(0, 0.6))
			var_73_9:Append(var_73_0.canvasGroup:DOFade(0, 0.6))
		end)
		var_73_9:AppendInterval(3)
		var_73_9:AppendCallback(function()
			self:_close_all_find_ani()
		end)
		var_73_9:SetLoops(1)
		var_73_9:Play()
		self._control.player_role.radar:SetActive(true)
		self._control.player_role.radar.find:SetActive(true)
		self:__play_animation(self._control.player_role.radar.find, var_0_2.seventh_find_smt.find.name, var_0_2.seventh_find_smt.find.loop)
	end

	function arg_1_0:_close_all_find_ani()
		if self._info_move_seq then
			for iter_76_0, iter_76_1 in pairs(self._info_move_seq) do
				iter_76_1:Kill()
			end
		end

		self._info_move_seq = {}

		self._control.player_role.radar.find:SetActive(false)

		self._now_need_angle = 0
		self._need_line_top = 0
		self._need_line_bottom = 0
		self._need_line_top_time = 0
		self._need_line_bottom_time = 0

		self._control.top_find_ani.find_ani:SetActive(false)
		self._control.top_find_ani.find_ani.line_top:SetActive(false)
		self._control.top_find_ani.find_ani.line_botton:SetActive(false)
		self._control.top_find_ani.find_ani:SetActive(false)
		self._control.top_find_ani.chassis_top:SetActive(false)
		self._control.top_find_ani.chassis_radar:SetActive(false)
		self._control.top_find_ani.chassis_radar_outside:SetActive(false)
		self._control.top_find_ani.chassis_radar_inside:SetActive(false)
		self._control.top_find_ani.scattering:SetActive(false)

		self._control.top_find_ani.chassis_top.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar_outside.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar_inside.canvasGroup.alpha = 0
		self._control.top_find_ani.scattering.canvasGroup.alpha = 0
		self._control.top_find_ani.chassis_radar_outside.transform.localScale = var_0_28.New(1, 0.5, 1)
		self._control.top_find_ani.chassis_radar_inside.transform.localScale = var_0_28.New(0.32, 0.16, 1)
		self._control.top_find_ani.chassis_top.transform.localScale = var_0_28.New(1, 0.5, 1)
		self._control.top_find_ani.scattering.transform.localScale = var_0_28.New(0, 0, 1)
		self._control.top_find_ani.find_ani.line_top.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
		self._control.top_find_ani.find_ani.line_botton.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
		self._control.player_role.radar.transform.localRotation = var_0_29.Euler(var_0_28(0, 0, 0))
	end

	function arg_1_0.__play_animation(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
		if not arg_77_1.skeletonGraphic.AnimationState:Equals(nil) and arg_77_1.skeletonGraphic.SkeletonData:FindAnimation(arg_77_2) then
			arg_77_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_77_2, arg_77_3)
		end
	end

	function arg_1_0:__rest_child(arg_78_1)
		for iter_78_0 = 1, arg_78_1.childCount do
			self:destroyGameObject(arg_78_1:GetChild(iter_78_0 - 1).gameObject)
		end
	end

	function arg_1_0.__get_data(arg_79_0, arg_79_1)
		local var_79_0 = var_0_18:getKeyData(arg_79_1)

		if var_79_0 ~= "" then
			var_79_0 = var_0_19(var_79_0).value
		end

		return var_79_0
	end

	function arg_1_0.__get_real_node_pos(arg_80_0, arg_80_1, arg_80_2, arg_80_3, arg_80_4, arg_80_5)
		return var_0_23(arg_80_3 / 1280 * arg_80_1, not arg_80_5 and -1 * arg_80_4 / 720 * arg_80_2 or arg_80_4 / 960 * arg_80_2)
	end

	function arg_1_0.__get_pos_by_rule_num(arg_81_0, arg_81_1)
		local var_81_0 = math.floor(arg_81_1 / 20)
		local var_81_1 = var_0_28(((arg_81_1 % 20 == 0 and 20 or arg_81_1 % 20) - 1) * 128, var_81_0 * 96, 0)

		if arg_81_1 == 327 then
			log.print_r(var_81_1, "needpos")
		end

		return var_81_1, (arg_81_1 % 20 == 0 and 20 or arg_81_1 % 20) - 1 + 1, var_81_0
	end

	function arg_1_0.__get_rule_num_by_pos(arg_82_0, arg_82_1)
		local var_82_0 = math.floor(arg_82_1.x / 128) + 1

		var_82_0 = var_82_0 == 20 and 0 or var_82_0

		return math.floor(arg_82_1.y / 96) * 20 + var_82_0, var_82_0, math.floor(arg_82_1.y / 96)
	end

	function arg_1_0:__set_noentry_area(arg_83_1, arg_83_2, arg_83_3)
		local var_83_0 = var_0_23(arg_83_2.x, arg_83_2.y)
		local var_83_2, var_83_3, var_83_4 = self:__get_rule_num_by_pos(var_83_0)
		local var_83_5, var_83_6, var_83_7 = self:__get_rule_num_by_pos(var_83_0 + var_0_23(arg_83_3.x, 0))
		local var_83_8, var_83_9, var_83_10 = self:__get_rule_num_by_pos(var_83_0 + var_0_23(0, arg_83_3.y))
		local var_83_11, var_83_12, var_83_13 = self:__get_rule_num_by_pos(var_83_0 + var_0_23(arg_83_3.x, arg_83_3.y))
		local var_83_14 = math.floor(arg_83_3.x / 128)

		if arg_83_3.x % 128 == 0 then
			var_83_14 = var_83_14 - 1
		end

		local var_83_15 = arg_83_3.x - var_83_14 * 128
		local var_83_16 = math.floor(arg_83_3.y / 96)

		if arg_83_3.y % 96 == 0 then
			var_83_16 = var_83_16 - 1
		end

		local var_83_17 = arg_83_3.y - var_83_16 * 96

		for iter_83_0 = 0, var_83_14 do
			for iter_83_1 = 0, var_83_16 do
				if not self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20] then
					self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20] = {
						x = arg_83_3.x - iter_83_0 * 128 > 128 and 128 or var_83_15,
						y = arg_83_3.y - iter_83_1 * 96 > 96 and 96 or var_83_17,
						num = arg_83_1,
						size = arg_83_3
					}
				else
					local var_83_18 = {
						x = arg_83_3.x - iter_83_0 * 128 > 128 and 128 or var_83_15,
						y = arg_83_3.y - iter_83_1 * 96 > 96 and 96 or var_83_17,
						num = arg_83_1,
						size = arg_83_3
					}
					local var_83_19 = {}

					if self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20].x > var_83_18.x then
						var_83_19.x = self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20].x or var_83_18.x
					end

					if self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20].y > var_83_18.y then
						var_83_19.y = self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20].y or var_83_18.y
					end

					var_83_19.num = arg_83_1
					var_83_19.size = arg_83_3
					self.obstacle_list[arg_83_1 + iter_83_0 + iter_83_1 * 20] = var_83_19
				end
			end
		end
	end

	function arg_1_0:__is_in_noenter_area(arg_84_1, arg_84_2)
		local var_84_0 = self:__get_rule_num_by_pos(arg_84_1)

		if self.obstacle_list[var_84_0] then
			if arg_84_2 then
				return self.obstacle_list[var_84_0], var_84_0
			end

			local var_84_1 = self:__get_pos_by_rule_num(var_84_0)
			local var_84_2 = arg_84_1 - var_0_23(var_84_1.x, var_84_1.y)

			if self.obstacle_list[var_84_0].x >= var_84_2.x and self.obstacle_list[var_84_0].y >= var_84_2.y then
				return self.obstacle_list[var_84_0], var_84_0
			end
		end

		return false
	end

	function arg_1_0:close_map_preview()
		self:__onClick_map_preview_map_bg_close_btn()
	end

	function arg_1_0:__onReset()
		self:show_cover_func(true)

		for iter_86_0, iter_86_1 in ipairs(self._light_seq_list) do
			iter_86_1:Kill()
		end

		for iter_86_2, iter_86_3 in ipairs(self._cloud_seq_list) do
			iter_86_3:Kill()
		end

		self._cloud_seq_list = {}
		self._light_seq_list = {}

		if self._light_seq then
			self._light_seq:Kill()
		end

		self:__rest_child(self._control.enemy_list.transform)
		self:__rest_child(self._control.islands_list.transform)
		self:__rest_child(self._control.exploration_list.transform)
		self:__rest_child(self._control.operational_list.transform)
		self:__initia_lize()
	end

	function arg_1_0.__onDestroy(arg_87_0)
		arg_87_0._is_init = false
	end

	function arg_1_0:__initia_lize()
		self.target_pos_list = {}
		self._sign_pos_list = {}
		self.obstacle_list = {}
		self._light_seq_list = {}
		self._cloud_seq_list = {}
		self._cloud_parent_list = {}
		self._exit_time = 0
		self._time = 0
		self._can_move = false
		self._is_run_anim = false
		self._is_init = true
		self._player_in_no_enter_area = false
		self._uiroot_canvas_rect = var_0_5.get_ui_root_canvas_rect()
		self._ui_camera = var_0_5.get_ui_camera()
		self.framerate_data = self:__get_data(var_0_2.setting_key_list.setting_framerate) ~= "" and self:__get_data(var_0_2.setting_key_list.setting_framerate) or 60
		self._current_station_team_id = 0
	end

	function arg_1_0:_play_audio(arg_89_1, arg_89_2)
		self:playBackgroundMusic(arg_89_1, arg_89_2)
	end

	function arg_1_0:_play_into_se(arg_90_1)
		self:playSE(arg_90_1, false)
	end

	function arg_1_0:__finish_special_task(arg_91_1)
		if not next(arg_91_1) then
			return
		end

		self._control.msg_panel.finish_special_mission.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 4
		self._task_num = 0
		self._task_info = {}

		for iter_91_0, iter_91_1 in pairs(arg_91_1) do
			var_0_27(self._task_info, iter_91_0)

			self._task_num = self._task_num + 1
		end

		local var_91_0 = self:autoKillDOTween(var_0_21.Sequence())

		if self._task_num > 1 then
			local var_91_1 = self._control.msg_panel.finish_special_mission

			var_91_0:AppendCallback(function()
				self:set_finish_task(self._task_info, 1, var_91_1)
			end)
			var_91_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_91_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.finish_special_mission_btn:SetActive(true)
		else
			for iter_91_2, iter_91_3 in pairs(self._task_info) do
				local var_91_2 = self._control.msg_panel.finish_special_mission

				var_91_0:AppendCallback(function()
					self:set_finish_task(self._task_info, iter_91_2, var_91_2)
				end)
				var_91_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_91_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				self._control.finish_special_mission_btn:SetActive(true)
			end
		end

		var_0_4:clear_open_seven_panel()
	end

	function arg_1_0.set_finish_task(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
		local var_94_0 = var_0_24.find_object_by_cid(arg_94_1[arg_94_2])

		arg_94_3:SetActive(true)

		arg_94_3.map_title.text.text = var_94_0.sub_title
		arg_94_3.task_title.text.text = var_94_0.title
		arg_94_3.coin_num.text.text = var_94_0.award
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_95_0)
	local var_95_0 = var_0_1:class("seven_sea_map")

	var_95_0:__initia_lize()

	return var_95_0
end

return var_0_0
