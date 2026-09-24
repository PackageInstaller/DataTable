local var_0_0 = {}
local var_0_1 = Spine
local var_0_2 = typeof
local var_0_3 = lan_rand
local var_0_4 = gamecore.user
local var_0_5 = UnityEngine
local var_0_6 = UnityEngine.Input
local var_0_7 = gamecore.UILoader
local var_0_8 = gamecore.Language
local var_0_9 = string.format
local var_0_10 = gamecore.util_func
local var_0_11 = gameenum.common_type
local var_0_12 = DG.Tweening.DOTween
local var_0_13 = gameconfig.ship_config
local var_0_14 = lx.json_decode
local var_0_16 = gameconfig.skin_config
local var_0_17 = gameconfig.equip_config
local var_0_18 = gameconfig.monster_config
local var_0_19 = gamecore.UserDataManager
local var_0_20 = gameconfig.pve_eighth_task_config
local var_0_21 = UnityEngine.RectTransformUtility
local var_0_22 = gameconfig.pve_eighth_map_config
local var_0_23 = gameconfig.pve_eighth_level_config
local var_0_24 = gameconfig.monster_formation_config
local var_0_25 = gameconfig.pve_eighth_enemy_buff_config
local var_0_26 = gameconfig.pve_eighth_level_node_config
local var_0_27 = gameconfig.pve_eighth_supportfleet_config

gamecore.UILoader:define("eighth_sea_map", function(arg_1_0)
	function arg_1_0:__onUpdate()
		if self.is_input_down then
			self._time = Time.deltaTime + self._time
		end

		if self._is_short_click and self._can_move then
			self:__set_click_move(true)
		end

		if var_0_6.GetMouseButton(0) and self._can_move then
			self:__set_run_anim()
			self:__set_click_move(false)
		end

		if var_0_6.GetMouseButtonUp(0) then
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

		if var_0_6.GetMouseButtonDown(0) then
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

		if self._cloud_parent_list and next(self._cloud_parent_list) then
			for iter_2_0, iter_2_1 in pairs(self._cloud_parent_list) do
				self:__cloud_move(iter_2_1)
			end
		end

		if self._not_set_support_bg then
			self:_player_to_support_pos()
		end
	end

	function arg_1_0:_player_to_support_pos()
		if self._player_pos and self._support_info and next(self._support_info) then
			for iter_3_0, iter_3_1 in pairs(self._support_info) do
				local var_3_1 = math.abs(self._player_pos - iter_3_1.pos)

				if var_3_1 == 20 or var_3_1 == 21 or var_3_1 == 1 then
					if iter_3_1.support_num == 1 then
						iter_3_1.single_ctrl.set_support_bg_1:SetActive(true)
					elseif iter_3_1.support_num == 2 then
						iter_3_1.single_ctrl.set_support_bg_2:SetActive(true)
					elseif iter_3_1.support_num == 3 then
						iter_3_1.single_ctrl.set_support_bg_3:SetActive(true)
					end

					if iter_3_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
						iter_3_1.single_ctrl.support_point.clear_support_btn:SetActive(true)
					end
				else
					if not iter_3_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
						iter_3_1.single_ctrl.support_point.support_bg:SetActive(true)
						iter_3_1.single_ctrl.support_point.support_btn:SetActive(true)
						iter_3_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
					end

					iter_3_1.single_ctrl.set_support_bg_1:SetActive(false)
					iter_3_1.single_ctrl.set_support_bg_2:SetActive(false)
					iter_3_1.single_ctrl.set_support_bg_3:SetActive(false)
					iter_3_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
					iter_3_1.single_ctrl.support_point.set_support_btn:SetActive(false)
					iter_3_1.single_ctrl.support_point.support_bg_2:SetActive(false)

					if iter_3_0 == #self._support_info then
						self._set_support_pos = false
					end
				end
			end
		end
	end

	function arg_1_0:show(arg_4_1)
		arg_4_1 = arg_4_1 or 9301

		self:setVisible(true)

		self.map_id = arg_4_1
		self._panel:GetComponent("Transform").localScale = Vector3(1, 1, 1)
		self._panel:GetComponent("RectTransform").anchoredPosition = Vector3(0, 0, 0)

		self:__init_panel(arg_4_1)
	end

	function arg_1_0:__init_panel(arg_5_1)
		self._is_init = true
		self.sea_map_data = var_0_22.find_object_by_id(arg_5_1)
		self.sceen_center_pos = Vector2(self._uiroot_canvas_rect.rect.width / 2, self._uiroot_canvas_rect.rect.height / 2 - 60)

		self._control.enemy_info_bg:SetActive(false)
		self:__set_player_operational_pos()
		self:__set_enemy_and_scence()
		self:__set_map_preview_data()
		self:__set_cloud_data()
		self:__set_player_role()
		self:__update_point_num()

		self._have_sign = true

		self:__set_support_pos()
		self:__create_monster_move()
		self:_play_audio(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_23.find_object_by_id(arg_5_1).music))
		self._control.cover_2:SetActive(false)
	end

	function arg_1_0:__set_enemy_and_scence()
		self._control.empty_bg.rectTransform.sizeDelta = Vector2((self.sea_map_data.ocean_size % 20 == 0 and 20 or self.sea_map_data.ocean_size % 20) * 128, math.ceil(self.sea_map_data.ocean_size / 20) * 96)

		self:__set_enemy_data()
		self:__set_island_data()

		self._control.enemy_info_bg.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3
	end

	function arg_1_0:__set_island_data()
		if self._control.islands_list.transform.childCount > 0 then
			for iter_7_0 = 1, self._control.islands_list.transform.childCount do
				for iter_7_1 = 1, self._control.islands_list.transform.childCount do
					self:destroyGameObject(self._control.islands_list.transform:GetChild(iter_7_1 - 1).gameObject)
				end
			end
		end

		for iter_7_2, iter_7_3 in pairs(self.sea_map_data.island_position) do
			for iter_7_4, iter_7_5 in pairs(iter_7_3) do
				local var_7_0 = string.format(var_0_11.seven_year_sea_map.island, iter_7_4)

				for iter_7_6, iter_7_7 in pairs(iter_7_5) do
					local var_7_1 = self:__get_pos_by_rule_num(iter_7_7)
					local var_7_2, var_7_3 = self:loadUIPrefab("eighth_sea_map_single", self._control.islands_list.transform)

					var_7_2:setVisible(true)

					var_7_2._panel:GetComponent("RectTransform").anchoredPosition = var_7_1

					var_7_3.islands:SetActive(true)

					var_7_3.islands.image.sprite = self:loadSprite(var_7_0)

					var_7_3.islands.image:SetNativeSize()

					var_7_3.islands.islands_collider.trigger2DEvent.colliderName = "obstacle"
					var_7_3.islands.islands_collider.boxCollider2D.size = var_7_3.islands.rectTransform.sizeDelta
					var_7_3.islands.islands_collider.boxCollider2D.offset = var_7_3.islands.rectTransform.sizeDelta / 2

					self:__set_noentry_area(iter_7_7, var_7_1, var_7_3.islands.rectTransform.sizeDelta)
					var_7_3.islands.islands_btn.button.onClick:RemoveAllListeners()
					var_7_3.islands.islands_btn.button.onClick:AddListener(function()
						self._now_move_sizedelta = var_7_3.islands.islands_collider.boxCollider2D.size
						self._now_move_num = iter_7_7
						self._now_move_elite_id = iter_7_7
						self._is_short_click = true
						self._can_move = true
						self._is_creat_list = false
						self._now_move_func = nil
					end)

					if self._can_move and not self._is_short_click then
						self._now_move_num = nil
						self._now_move_elite_id = nil
					end
				end
			end
		end
	end

	function arg_1_0:__set_cloud_data(arg_9_1)
		local var_9_0 = {}

		for iter_9_0 = 1, 2 do
			self._control["cloud_list_" .. iter_9_0].rectTransform.anchoredPosition = Vector2(0, 0)
			self._control["cloud_list_" .. iter_9_0].rectTransform.anchoredPosition = self._control["cloud_list_" .. iter_9_0].rectTransform.anchoredPosition + Vector2((iter_9_0 - 1) * self._control.empty_bg.rectTransform.sizeDelta.x, 0)
			self._control["cloud_shadow_list_" .. iter_9_0].rectTransform.anchoredPosition = Vector2(0, 0)
			self._control["cloud_shadow_list_" .. iter_9_0].rectTransform.anchoredPosition = self._control["cloud_list_" .. iter_9_0].rectTransform.anchoredPosition + Vector2((iter_9_0 - 1) * self._control.empty_bg.rectTransform.sizeDelta.x, 0)

			self:__rest_child(self._control["cloud_list_" .. iter_9_0].transform)
			self:__rest_child(self._control["cloud_shadow_list_" .. iter_9_0].transform)

			for iter_9_1 = 1, var_0_3(0, 5) do
				local var_9_2 = var_0_3(1, 90)
				local var_9_3 = var_0_3(1, 40)
				local var_9_4 = Vector2(var_9_2, var_9_3)
				local var_9_5 = Vector2(self._control.empty_bg.rectTransform.sizeDelta.x / 100 * var_9_2, self._control.empty_bg.rectTransform.sizeDelta.y / 50 * var_9_3)
				local var_9_6 = false

				for iter_9_2, iter_9_3 in pairs(var_9_0) do
					if iter_9_3.x == var_9_5.x and iter_9_3.y == var_9_5.y then
						var_9_6 = true
					end
				end

				if not var_9_6 then
					local var_9_7 = var_0_3(1, 3)

					table.insert(var_9_0, var_9_4)

					local var_9_8, var_9_9 = self:loadUIPrefab("eighth_sea_map_single", self._control["cloud_list_" .. iter_9_0].transform)

					var_9_8:setVisible(true)

					var_9_8._panel:GetComponent("RectTransform").anchoredPosition = var_9_5

					var_9_9.cloud_img:SetActive(true)

					var_9_9.cloud_img.rawImage.texture = self:loadTexture(string.format(var_0_11.eighth_year_sea_map.cloud, var_9_7))

					var_9_9.cloud_img.rawImage:SetNativeSize()

					local var_9_10, var_9_11 = self:loadUIPrefab("eighth_sea_map_single", self._control["cloud_shadow_list_" .. iter_9_0].transform)

					var_9_10:setVisible(true)

					var_9_10._panel:GetComponent("RectTransform").anchoredPosition = var_9_5

					var_9_11.cloud_img:SetActive(true)

					var_9_11.cloud_img.rawImage.texture = self:loadTexture(string.format(var_0_11.eighth_year_sea_map.cloud_shadow, var_9_7))

					var_9_11.cloud_img.rawImage:SetNativeSize()
				end
			end

			table.insert(self._cloud_parent_list, self._control["cloud_list_" .. iter_9_0])
			table.insert(self._cloud_parent_list, self._control["cloud_shadow_list_" .. iter_9_0])
		end
	end

	function arg_1_0:__cloud_move(arg_10_1)
		if not self._is_init then
			return
		end

		if not arg_10_1 or arg_10_1.transform:Equals(nil) then
			return
		end

		local var_10_0 = self._control.empty_bg.rectTransform.sizeDelta

		arg_10_1.rectTransform.anchoredPosition = arg_10_1.rectTransform.anchoredPosition + Vector2(-1, 0, 0) / 0.3

		if arg_10_1.rectTransform.anchoredPosition.x < -var_10_0.x - 100 then
			arg_10_1.rectTransform.localPosition = Vector3(var_10_0.x + 100, 0, 1)
		end
	end

	function arg_1_0:__set_player_operational_pos()
		if self._control.operational_list.transform.childCount > 0 then
			for iter_11_0 = 1, self._control.operational_list.transform.childCount do
				for iter_11_1 = 1, self._control.operational_list.transform.childCount do
					self:destroyGameObject(self._control.operational_list.transform:GetChild(iter_11_1 - 1).gameObject)
				end
			end
		end

		if self.sea_map_data.battle_plan_position then
			local var_11_0 = self:__get_pos_by_rule_num(self.sea_map_data.battle_plan_position)

			self._operational_pos = var_11_0

			local var_11_1, var_11_2 = self:loadUIPrefab("eighth_sea_map_single", self._control.operational_list.transform)

			var_11_1:setVisible(true)

			var_11_1._panel:GetComponent("RectTransform").anchoredPosition = var_11_0

			var_11_2.operational_plan_point:SetActive(true)

			local var_11_3 = var_0_11.eighth_operational_plan_animation.offshore_work_platform
			local var_11_4 = self.sea_map_data.image
			local var_11_5 = 0
			local var_11_6 = var_0_4:get_eighth_map_info()

			self:__set_noentry_area(self.sea_map_data.battle_plan_position, var_11_0, var_11_2.operational_plan_point.operational_plan_collider.boxCollider2D.size)

			if var_0_10.have_index(var_11_6[self.map_id], "enemy_buff_id") then
				if var_11_6[self.map_id].enemy_buff_id > 0 then
					var_11_5 = var_0_25.find_object_by_id(var_11_6[self.map_id].enemy_buff_id).buff_level
				end
			else
				var_11_5 = 0
			end

			if var_11_5 >= var_11_4[2] then
				self:__play_animation(var_11_2.operational_plan_point.operational_plan_skeleton, var_0_11.eighth_operational_plan_animation.offshore_work_platform_3.name, true)
			elseif var_11_5 >= var_11_4[1] then
				self:__play_animation(var_11_2.operational_plan_point.operational_plan_skeleton, var_0_11.eighth_operational_plan_animation.offshore_work_platform_2.name, true)
			else
				self:__play_animation(var_11_2.operational_plan_point.operational_plan_skeleton, var_11_3.name, true)
			end

			var_11_2.operational_plan_point.operational_plan_point_btn.button.onClick:RemoveAllListeners()
			var_11_2.operational_plan_point.operational_plan_point_btn.button.onClick:AddListener(function()
				self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

				self._now_move_sizedelta = var_11_2.operational_plan_point.operational_plan_collider.boxCollider2D.size
				self._now_move_num = self.sea_map_data.battle_plan_position
				self._now_move_elite_id = self.sea_map_data.battle_plan_position
				self._now_move_id = var_11_4
				self._is_short_click = true
				self._can_move = true
				self._is_creat_list = false
				self._now_move_func = {
					func_str = "operational_func"
				}
			end)
		end
	end

	function arg_1_0:__cloud_sign_pos(arg_13_1)
		local var_13_0
		local var_13_1
		local var_13_2

		if arg_13_1 == "boss" then
			var_13_0 = self.sea_map_data.boss_position
			var_13_1 = var_0_11.seventh_sceen_pos.boss
			var_13_2 = self._control.boss_sign
			self.temp_type = nil
		elseif arg_13_1 == "plane" then
			var_13_0 = self.sea_map_data.battle_plan_position
			var_13_1 = var_0_11.seventh_sceen_pos.plane
			var_13_2 = self._control.plane_sign
		end

		local var_13_3 = self:__get_pos_by_rule_num(var_13_0)
		local var_13_4 = Vector2(var_13_3.x, var_13_3.y)
		local var_13_5 = Vector2(var_13_3.x, var_13_3.y) + self._control.empty_bg.rectTransform.anchoredPosition
		local var_13_6 = -self._control.empty_bg.rectTransform.anchoredPosition + Vector2(self._uiroot_canvas_rect.rect.width, self._uiroot_canvas_rect.rect.height)

		if (var_13_4 + var_13_1).x < (-self._control.empty_bg.rectTransform.anchoredPosition).x or var_13_4.x > var_13_6.x then
			if not var_13_2.activeSelf then
				var_13_2:SetActive(true)
			end

			local var_13_7
			local var_13_8

			if (var_13_4 + var_13_1).x < (-self._control.empty_bg.rectTransform.anchoredPosition).x then
				var_13_2.rectTransform.localRotation = Quaternion.Euler(0, 0, 270)
				var_13_2.icon.rectTransform.localRotation = Quaternion.Euler(0, 0, 90)
				var_13_7 = 0
				var_13_8 = (var_13_5.y + (var_13_5 + var_13_1).y) / 2 + 50

				if (var_13_5.y + (var_13_5 + var_13_1).y) / 2 + 50 - 100 <= 0 then
					var_13_8 = 100

					if self.temp_type == 1 then
						var_13_8 = 150
					end

					self.temp_type = 1
				elseif self._uiroot_canvas_rect.rect.height <= var_13_8 then
					var_13_8 = self._uiroot_canvas_rect.rect.height

					if self.temp_type == 2 then
						var_13_8 = self._uiroot_canvas_rect.rect.height - 50
					end

					self.temp_type = 2
				end
			end

			if var_13_4.x > var_13_6.x then
				var_13_2.rectTransform.localRotation = Quaternion.Euler(0, 0, 90)
				var_13_2.icon.rectTransform.localRotation = Quaternion.Euler(0, 0, 270)
				var_13_7 = self._uiroot_canvas_rect.rect.width
				var_13_8 = (var_13_5.y + (var_13_5 + var_13_1).y) / 2 - 50

				if (var_13_5.y + (var_13_5 + var_13_1).y) / 2 - 50 <= 0 then
					var_13_8 = 0

					if self.temp_type == 3 then
						var_13_8 = 50
					end

					self.temp_type = 3
				elseif self._uiroot_canvas_rect.rect.height <= var_13_8 + 100 then
					var_13_8 = self._uiroot_canvas_rect.rect.height - 100

					if self.temp_type == 4 then
						var_13_8 = self._uiroot_canvas_rect.rect.height - 150
					end

					self.temp_type = 4
				end
			end

			if var_13_2.rectTransform.anchoredPosition ~= Vector2(var_13_7, var_13_8) then
				var_13_2.rectTransform.anchoredPosition = Vector2(var_13_7, var_13_8)
			end
		elseif (var_13_4 + var_13_1).y < (-self._control.empty_bg.rectTransform.anchoredPosition).y or var_13_4.y > var_13_6.y then
			if not var_13_2.activeSelf then
				var_13_2:SetActive(true)
			end

			local var_13_9
			local var_13_10

			if (var_13_4 + var_13_1).y < (-self._control.empty_bg.rectTransform.anchoredPosition).y then
				var_13_2.rectTransform.localRotation = Quaternion.Euler(0, 0, 0)
				var_13_2.icon.rectTransform.localRotation = Quaternion.Euler(0, 0, 0)
				var_13_9 = (var_13_5.x + (var_13_5 + var_13_1).x) / 2 - 50
				var_13_10 = 0

				if (var_13_5.x + (var_13_5 + var_13_1).x) / 2 - 50 <= 0 then
					var_13_9 = 0

					if self.temp_type == 4 then
						var_13_9 = 50
					end

					self.temp_type = 5
				elseif self._uiroot_canvas_rect.rect.width <= var_13_9 + 100 then
					var_13_9 = self._uiroot_canvas_rect.rect.width - 100

					if self.temp_type == 6 then
						var_13_9 = self._uiroot_canvas_rect.rect.width - 150
					end

					self.temp_type = 6
				end
			elseif var_13_4.y > var_13_6.y then
				var_13_2.rectTransform.localRotation = Quaternion.Euler(0, 0, 180)
				var_13_2.icon.rectTransform.localRotation = Quaternion.Euler(0, 0, 180)
				var_13_9 = (var_13_5.x + (var_13_5 + var_13_1).x) / 2 + 50
				var_13_10 = self._uiroot_canvas_rect.rect.height

				if (var_13_5.x + (var_13_5 + var_13_1).x) / 2 + 50 - 100 <= 0 then
					var_13_9 = 100

					if self.temp_type == 7 then
						var_13_9 = 150
					end

					self.temp_type = 7
				elseif self._uiroot_canvas_rect.rect.width <= var_13_9 then
					var_13_9 = self._uiroot_canvas_rect.rect.width

					if self.temp_type == 8 then
						var_13_9 = self._uiroot_canvas_rect.rect.width - 50
					end

					self.temp_type = 8
				end
			end

			if var_13_2.rectTransform.anchoredPosition ~= Vector2(var_13_9, var_13_10) then
				var_13_2.rectTransform.anchoredPosition = Vector2(var_13_9, var_13_10)
			end
		elseif var_13_2.activeSelf then
			var_13_2:SetActive(false)
		end
	end

	function arg_1_0:__set_player_role()
		local var_14_0 = var_0_4:get_eighth_map_info()[self.map_id].pos
		local var_14_1 = self:__get_pos_by_rule_num(var_14_0)

		self.player_now_num = var_14_0
		self._control.player_role.rectTransform.anchoredPosition = self.sceen_center_pos
		self._control.player_role.rectTransform.localScale = Vector3(0.4, 0.4, 0.4)
		self._control.empty_bg.rectTransform.anchoredPosition = self.sceen_center_pos - (Vector2(var_14_1.x, var_14_1.y) + Vector2(64, 64))
		self._control.player_role.rectTransform.anchoredPosition = self._control.player_role.rectTransform.anchoredPosition - self:set_position_by_rule()

		local var_14_2 = var_0_4:find_character_by_id(var_0_4:get_use_info_data().secretary)
		local var_14_3 = "normal"

		if var_14_2.now_hp / var_14_2.hp < var_0_11.health_sprite_rule.yellow.max_value then
			var_14_3 = "damage"
		end

		local var_14_4 = var_0_13.find_object_by_cid(var_14_2.cid).pic_id

		if var_14_2.skin ~= 0 then
			var_14_4 = var_0_16.find_object_by_cid(var_14_2.skin).icon
		end

		self._control.player_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_11.ship_spine, var_14_4, var_14_4))

		local var_14_5 = var_0_5.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		self._control.player_role.skeletonGraphic.material.shader = var_14_5
		self._control.player_role.shadow.skeletonGraphic.material.shader = var_14_5
		self._control.player_role.skeletonGraphic.initialSkinName = var_14_3

		if not self._control.player_role.skeletonGraphic:Equals(nil) then
			self._control.player_role.skeletonGraphic:Initialize(true)
		end

		self:__set_normal_anim(self._control.player_role, var_14_3)
		self._control.top_find_ani.find_ani:SetActive(false)
	end

	function arg_1_0:__set_click_move(arg_15_1)
		local var_15_0 = 50
		local var_15_3, var_15_4 = var_0_21.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_6.mousePosition, self._ui_camera, nil)
		local var_15_5 = var_15_3
		local var_15_6 = self._control.player_role.rectTransform.anchoredPosition
		local var_15_7 = self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition
		local var_15_8 = self:__get_rule_num_by_pos(self._control.player_role.rectTransform.anchoredPosition - self._control.empty_bg.rectTransform.anchoredPosition)
		local var_15_9 = var_15_4 + self.sceen_center_pos + Vector2(0, 60)

		if not arg_15_1 and (var_15_9.x < 0 or var_15_9.x > self._uiroot_canvas_rect.rect.width or var_15_9.y < 0 or var_15_9.y > self._uiroot_canvas_rect.rect.height) then
			return
		end

		local var_15_10 = var_15_9 - self._control.empty_bg.rectTransform.anchoredPosition
		local var_15_11

		self._player_pos = var_15_8

		if self._now_move_num then
			var_15_11 = self:__get_now_move_pos(self._now_move_num, var_15_8, var_15_7)
			var_15_0 = 10

			if self._is_mouse_in_no_enter then
				var_15_0 = 50
			end
		end

		if not arg_15_1 then
			self._map_target_pos = var_15_10
		elseif self._map_target_pos then
			var_15_10 = self._map_target_pos
		else
			self._map_target_pos = var_15_10
		end

		if var_15_11 then
			var_15_10 = var_15_11
		end

		local var_15_12 = self:__get_rule_num_by_pos(var_15_10)

		if not arg_15_1 and var_15_12 ~= self._map_target_num or arg_15_1 and not self._is_creat_list and not next(self.target_pos_list) then
			self._map_target_num = var_15_12
			self.target_pos_list = self:__get_player_move_pos_by_a_start(var_15_7, var_15_10, true)
			self._is_creat_list = true
		end

		if not self._is_move_list and next(self.target_pos_list) then
			self._control.move_point.rectTransform.anchoredPosition = self.target_pos_list[1]
			self._is_move_list = true
			var_15_0 = 10
		end

		if self._control.move_point.rectTransform.anchoredPosition ~= Vector2(0, 0) then
			var_15_9 = self._control.move_point.rectTransform.anchoredPosition + self._control.empty_bg.rectTransform.localPosition
		end

		if var_15_5 then
			local var_15_13
			local var_15_14
			local var_15_15

			if var_15_0 > Vector2.Distance(var_15_9, var_15_6) then
				if not next(self.target_pos_list) then
					self._is_creat_list = false
					self._is_short_click = false

					self:__set_normal_anim(self._control.player_role)

					if arg_15_1 then
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

				var_15_13 = self._control.empty_bg.rectTransform.sizeDelta
				var_15_14 = -Vector2.Normalize(var_15_9 - var_15_6) / 0.06
				var_15_15 = Vector2.Normalize(var_15_9 - var_15_6) / 0.06
			end

			local var_15_16 = Vector2(self._control.empty_bg.rectTransform.localPosition.x, self._control.empty_bg.rectTransform.localPosition.y) + var_15_14
			local var_15_17 = Vector3(var_15_15.x, var_15_15.y, 0)
			local var_15_20 = (var_15_16.x < 0 and var_15_16.x > -var_15_13.x + self.sceen_center_pos.x * 2 or false) and (var_15_6.x >= self.sceen_center_pos.x or var_15_17.x <= 0) and (var_15_6.x <= self.sceen_center_pos.x or var_15_17.x >= 0)
			local var_15_21 = (var_15_16.y < 0 and var_15_16.y > -var_15_13.y + self.sceen_center_pos.y * 2 + 120 or false) and (var_15_6.y >= self.sceen_center_pos.y or var_15_17.y <= 0) and (var_15_6.y <= self.sceen_center_pos.y or var_15_17.y >= 0)
			local var_15_22 = Vector2.Normalize((Vector3(var_15_14.x, var_15_14.y, 0))) / 0.075
			local var_15_23 = Vector2.Normalize(var_15_17) / 0.075
			local var_15_24

			if (var_15_16.x < 0 and var_15_16.x > -var_15_13.x + self.sceen_center_pos.x * 2 or false) and (var_15_6.x >= self.sceen_center_pos.x or var_15_17.x <= 0) and (var_15_6.x <= self.sceen_center_pos.x or var_15_17.x >= 0) then
				var_15_24 = var_15_22.x or 0

				local var_15_25

				if var_15_21 then
					var_15_25 = var_15_22.y or 0
				end
			end

			local var_15_26 = Vector3(var_15_24, var_15_25, 0)
			local var_15_27 = Vector3(var_15_20 and 0 or var_15_23.x, var_15_21 and 0 or var_15_23.y, 0)

			if var_15_26 ~= Vector3.zero then
				self._control.empty_bg.rectTransform.localPosition = self._control.empty_bg.rectTransform.localPosition + var_15_26
			end

			if var_15_27 ~= Vector3.zero then
				self._control.player_role.rectTransform.localPosition = self._control.player_role.rectTransform.localPosition + var_15_27
			end

			self:set_position_by_rule()

			if var_15_20 then
				self:__set_player_face(var_15_26)
			else
				self:__set_player_face(-var_15_27)
			end
		end
	end

	function arg_1_0:__set_enemy_data()
		local var_16_0 = var_0_4:get_eighth_map_info()
		local var_16_2 = {}
		local var_16_3 = self.sea_map_data.battle_plan_position

		table.insert(var_16_2, {
			self.sea_map_data.battle_plan_position - 20,
			self.sea_map_data.battle_plan_position - 19,
			self.sea_map_data.battle_plan_position + 19,
			self.sea_map_data.battle_plan_position + 40,
			self.sea_map_data.battle_plan_position - 1,
			self.sea_map_data.battle_plan_position + 41,
			self.sea_map_data.battle_plan_position + 22,
			self.sea_map_data.battle_plan_position + 2
		})

		local var_16_4 = var_0_4:get_eight_monster_hurt_id()

		if var_16_0[self.map_id].elite and next(var_16_0[self.map_id].elite) then
			table.sort(var_16_0[self.map_id].elite, function(arg_17_0, arg_17_1)
				return arg_17_0.pos > arg_17_1.pos
			end)

			for iter_16_0, iter_16_1 in ipairs(var_16_0[self.map_id].elite) do
				local var_16_5 = false

				if var_16_4 and next(var_16_4) and iter_16_1.hp == 0 then
					var_16_5 = self:__have_data(var_16_4, iter_16_1.id)
				end

				self._monster_move = var_0_4:get_monster_is_move()

				if iter_16_1.state == 1 and iter_16_1.hp > 0 or var_16_5 then
					local var_16_6 = self._monster_move and self:__get_pos_by_rule_num(iter_16_1.pre_pos) or self:__get_pos_by_rule_num(iter_16_1.pos)
					local var_16_7, var_16_8 = self:loadUIPrefab("eighth_sea_map_single", self._control.enemy_list.transform)

					var_16_7:setVisible(true)
					var_16_8.enemy_role:SetActive(true)

					var_16_7._panel:GetComponent("RectTransform").anchoredPosition = var_16_6

					local var_16_9 = var_0_18.find_object_by_id((var_0_24.find_object_by_id(iter_16_1.monster) or var_0_24.find_object_by_id(20101002)).formation[1]).pic_id

					var_16_8.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_11.ship_spine, var_16_9, var_16_9))

					local var_16_10 = var_0_5.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

					var_16_8.enemy_role.skeletonGraphic.material.shader = var_16_10
					var_16_8.enemy_role.shadow.skeletonGraphic.material.shader = var_16_10
					var_16_8.enemy_role.skeletonGraphic.initialSkinName = "default"

					if not var_16_8.enemy_role.skeletonGraphic:Equals(nil) then
						var_16_8.enemy_role.skeletonGraphic:Initialize(true)
					end

					if iter_16_1.hp < 100 and iter_16_1.hp >= 0 then
						var_16_8.enemy_role.monster_hp_bg:SetActive(true)

						var_16_8.enemy_role.monster_hp_bg.monster_hp.text.text = iter_16_1.hp .. "/ 100"
						var_16_8.enemy_role.monster_hp_bg.progress.foreground.image.fillAmount = iter_16_1.hp / 100
					end

					if iter_16_1.buff and next(iter_16_1.buff) then
						var_16_8.enemy_role.monster_buff_list:SetActive(true)

						if #iter_16_1.buff == 2 then
							var_16_8.enemy_role.monster_buff_list.defense:SetActive(true)
							var_16_8.enemy_role.monster_buff_list.fast_move:SetActive(true)
						elseif iter_16_1.buff[1].type == 1 then
							var_16_8.enemy_role.monster_buff_list.defense:SetActive(true)
							var_16_8.enemy_role.monster_buff_list.fast_move:SetActive(false)
						elseif iter_16_1.buff[1].type == 2 then
							var_16_8.enemy_role.monster_buff_list.defense:SetActive(false)
							var_16_8.enemy_role.monster_buff_list.fast_move:SetActive(true)
						end
					end

					if self._monster_move and not var_16_5 then
						self._fire_ok = true

						self:__set_monster_move(var_16_8, iter_16_1, var_16_7)
						self:__set_monster_run_anim(var_16_8, iter_16_1, var_16_3, var_16_2)
					elseif self._monster_move and var_16_5 then
						self:__set_monster_die_anim(var_16_8, iter_16_1, var_16_5)
					else
						self:__set_normal_anim(var_16_8.enemy_role, true)
					end

					self:__set_noentry_area(iter_16_1.pos, var_16_6, var_16_8.enemy_role.rectTransform.sizeDelta)

					var_16_8.enemy_role.enemy_role_collider.trigger2DEvent.colliderName = "obstacle"

					self:__set_monster_face(var_16_8, var_16_6)
					var_16_8.enemy_role.enemy_role_btn.button.onClick:RemoveAllListeners()
					var_16_8.enemy_role.enemy_role_btn.button.onClick:AddListener(function()
						self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

						self._now_move_sizedelta = var_16_8.enemy_role.enemy_role_collider.boxCollider2D.size
						self._now_move_num = iter_16_1.pos
						self._now_move_elite_id = iter_16_1.id
						self._is_short_click = true
						self._can_move = true
						self._is_creat_list = false
						self._now_move_func = {
							is_encounter = true,
							func_str = "encounter_func",
							monster_data = iter_16_1
						}
					end)
				end
			end
		end

		local var_16_12 = self.sea_map_data.boss_position
		local var_16_13 = self:__get_pos_by_rule_num(self.sea_map_data.boss_position)
		local var_16_14, var_16_15 = self:loadUIPrefab("eighth_sea_map_single", self._control.enemy_list.transform)

		var_16_14:setVisible(true)

		var_16_14._panel:GetComponent("RectTransform").anchoredPosition = var_16_13

		var_16_15.enemy_role:SetActive(true)
		var_16_15.enemy_role.boss_sign:SetActive(true)

		local var_16_16 = var_0_18.find_object_by_id(self.sea_map_data.boss_image).pic_id

		var_16_15.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_9(var_0_11.ship_spine, var_16_16, var_16_16))

		local var_16_17 = var_0_5.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		var_16_15.enemy_role.skeletonGraphic.material.shader = var_16_17
		var_16_15.enemy_role.shadow.skeletonGraphic.material.shader = var_16_17
		var_16_15.enemy_role.skeletonGraphic.initialSkinName = "default"

		if not var_16_15.enemy_role.skeletonGraphic:Equals(nil) then
			var_16_15.enemy_role.skeletonGraphic:Initialize(true)
		end

		self:__set_normal_anim(var_16_15.enemy_role, true)
		self:__set_noentry_area(var_16_12, var_16_13, var_16_15.enemy_role.enemy_role_collider.boxCollider2D.size)

		var_16_15.enemy_role.enemy_role_collider.trigger2DEvent.colliderName = "obstacle"

		var_16_15.enemy_role.enemy_role_btn.button.onClick:RemoveAllListeners()
		var_16_15.enemy_role.enemy_role_btn.button.onClick:AddListener(function()
			self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

			self._now_move_sizedelta = var_16_15.enemy_role.enemy_role_collider.boxCollider2D.size
			self._now_move_num = var_16_12
			self._now_move_elite_id = var_16_12
			self._is_short_click = true
			self._can_move = true
			self._is_creat_list = false
			self._now_move_func = {
				func_str = "boss_func",
				monster_data = self.sea_map_data.boss_id
			}
		end)

		local var_16_18 = self:autoKillDOTween(var_0_12.Sequence())

		var_16_18:AppendInterval(2.5)
		var_16_18:AppendCallback(function()
			if self._hurt_monster_init and next(self._hurt_monster_init) then
				for iter_20_0, iter_20_1 in pairs(self._hurt_monster_init) do
					self:__set_normal_anim(iter_20_1.enemy_role, true)
				end
			end
		end)
	end

	function arg_1_0:__set_encounter_func(arg_21_1, arg_21_2)
		var_0_4:set_monster_is_move(false)
		self._control.enemy_info_bg:SetActive(true)

		self._control.enemy_info_bg.fight_btn.text.text.text = arg_21_2 and var_0_8:getNowLang("7th_explore_encounter") or var_0_8:getNowLang("7th_explore_prepare")
		self._is_encounter = arg_21_2

		local var_21_0 = var_0_24.find_object_by_id(arg_21_1.monster)

		self._control.enemy_info_bg.enemy_info_txt.text.text = nil
		self._control.enemy_info_bg.s_enemy_info.text.text = var_0_8:getNowLang("warenemy") .. "-" .. var_0_8:getNowLang(var_0_9("warformation%s", var_21_0.formation_id))
		self._control.enemy_info_bg.back_btn.text.text = var_0_8:getNowLang("ui_combat_return")

		self._control.enemy_info_bg.radar_frame.radar_effect1.dOTweenAnimation:DORestart()
		self._control.enemy_info_bg.radar_frame.radar_effect2.dOTweenAnimation:DORestart()
		self:__show_monster_formation(self._control.enemy_info_bg.radar_frame.monster_formation, var_21_0)

		if self._control.enemy_info_bg.enemy_list.transform.childCount > 0 then
			for iter_21_0 = 1, self._control.enemy_info_bg.enemy_list.transform.childCount do
				self:destroyGameObject(self._control.enemy_info_bg.enemy_list.transform:GetChild(iter_21_0 - 1).gameObject)
			end
		end

		for iter_21_1, iter_21_2 in ipairs(var_21_0.formation) do
			local var_21_1 = var_0_18.find_object_by_id(iter_21_2)
			local var_21_2, var_21_3 = self:loadUIPrefab("fight_info_item", self._control.enemy_info_bg.enemy_list.transform)

			var_21_2:setVisible(true)

			var_21_3.bg.ship_flag.image.enabled = iter_21_1 == 1
			var_21_3.bg.ship_icon.image.sprite = self:loadSprite(string.format(var_0_11.ship_icon.model_normal_s, var_21_1.pic_id, var_21_1.pic_id))
			var_21_3.bg.ship_type.text.text = var_0_8:getNowLang(var_0_11:get_ship_type_language_key(var_21_1.type, 1))
			var_21_3.bg.image.sprite = self:loadSprite(var_0_11.ship_attrib_bg[var_21_1.star == 0 and 6 or var_21_1.star])
		end
	end

	function arg_1_0.__show_monster_formation(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
		if arg_22_2 then
			local var_22_0 = #arg_22_2.formation

			for iter_22_0 = 1, 5 do
				arg_22_1[string.format("formation%d", iter_22_0)].canvasGroup.alpha = 0

				if iter_22_0 == arg_22_2.formation_id then
					for iter_22_1 = 1, 6 do
						arg_22_1[string.format("formation%d", iter_22_0)][string.format("num%d", iter_22_1)].gameObject:SetActive(iter_22_1 == var_22_0)
					end

					arg_22_1[string.format("formation%d", iter_22_0)].canvasGroup.alpha = 1
				end
			end
		end

		return arg_22_2
	end

	function arg_1_0:set_boss_func(arg_23_1)
		self:__set_boss_func(arg_23_1)
	end

	function arg_1_0:__set_boss_func(arg_24_1)
		self:show_self_cover_func(true)
		self._control.map_preview:SetActive(true)
		self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.open))

		local var_24_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_24_0:Append(self._control.map_preview.map_bg.transform:DOScale(0, 0))
		var_24_0:Append(self._control.map_preview.map_bg.transform:DOScale(1, 0.3):SetEase(DG.Tweening.Ease.OutBack)):OnComplete(function()
			local var_25_0 = var_0_4:get_account_id()
			local var_25_1 = tonumber(var_0_19:getDataByID(var_0_9("is_eighth_station_%d", self.sea_map_data.id), var_25_0))

			if var_25_1 and var_25_1 and self.sea_map_data.id == var_25_1 then
				var_0_7:destroyInstance("suppress_msg")
				var_0_7:createInstance("suppress_msg"):show("suppressed", nil, 1.5, true)
				var_0_19:setDataByID(var_0_9("is_eighth_station_%d", self.sea_map_data.id), var_25_0, "have_show")
			end
		end)
	end

	function arg_1_0:__set_map_preview_data()
		self._control.map_preview:SetActive(false)

		local var_26_0 = var_0_23.find_object_by_id(self.map_id)
		local var_26_1 = self._control.map_preview.map_bg

		self._control.map_preview.map_bg.map_panel.map_image.image.sprite = self:loadSprite(string.format(var_0_11.map_path, self.map_id, self.map_id))
		var_26_1.map_panel.map_image.rectTransform.anchoredPosition = Vector2(3, 5)
		var_26_1.title_bg.title_txt.text.text = var_26_0.title .. " " .. var_26_0.sub_title
		var_26_1.boss_panel.boss_bg.image.sprite = self:loadSprite(string.format(var_0_11.fearlessness_sea_enemy_bg, var_26_0.boss_bg))
		var_26_1.reward_panel.reward_title.text.text = var_0_8:getNowLang("pveeventitemcanget")
		var_26_1.map_panel.pass_icon.pass_txt.text.text = var_0_8:getNowLang("ui_pvepassed")
		var_26_1.confirm_btn.title.text.text = var_0_8:getNowLang("ui_4th_prepare")
		var_26_1.bottom_tips.tips_txt.text.text = var_0_10.convert_rich_text(var_26_0.tips)

		local var_26_2 = var_0_4:get_eighth_map_info()
		local var_26_3 = {}

		if var_26_2 and next(var_26_2) then
			for iter_26_0, iter_26_1 in pairs(var_26_2) do
				if iter_26_0 == self.map_id then
					var_26_3 = iter_26_1
				end
			end
		end

		local var_26_4 = self._control.map_preview.map_bg.boss_panel.boss_hp_black
		local var_26_5 = var_26_3.hp
		local var_26_6

		if var_26_3.hp then
			var_26_6 = var_26_5 / var_26_0.hp or 1
		end

		var_26_4.boss_hp_bar.image.fillAmount = var_26_6

		if var_26_6 > 0 and var_26_6 < 0.01 and var_26_5 > 0 then
			var_26_6 = 0.01
		end

		var_26_4.hp_percent_num.text.text = string.format("%0.0f%s", var_26_6 * 100, "%")

		local var_26_7 = var_26_3.state == 2
		local var_26_8 = var_26_0.boss_id

		var_26_1.boss_panel.boss_image.image.sprite = var_26_3.state ~= 2 and self:loadSprite(string.format(var_0_11.eighth_node_boss, var_26_8)) or self:loadSprite(string.format(var_0_11.eighth_node_boss_b, var_26_8))

		var_26_1.map_panel.pass_icon:SetActive(var_26_7)
		var_26_1.reward_panel.reward_icon.get_icon:SetActive(var_26_7)

		if var_26_0.award[1].id >= 10000000 then
			if var_26_0.award[1].id % 100 == 21 then
				var_26_1.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(string.format(var_0_11.equip_back.equip_back_normal, var_0_17.find_object_by_cid(var_26_0.award[1].id).star))
				var_26_1.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_11.icon.item_icon, var_26_0.award[1].id))
			elseif var_26_0.award[1].id % 100 == 61 then
				var_26_1.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_11.equip_quality_frame_s[5])
				var_26_1.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_11.icon.item_icon, var_26_0.award[1].id))
			elseif var_26_0.award[1].id % 100 ~= 11 and var_26_0.award[1].id % 100 ~= 12 then
				if var_26_0.award[1].id % 100 == 13 then
					var_26_1.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(string.format(var_0_11.equip_back.equip_back_normal, var_0_13.find_object_by_cid(var_26_0.award[1].id).star))
					var_26_1.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_11.icon.item_icon, var_26_0.award[1].id))

					goto label_26_0
				end
			end
		end

		var_26_1.reward_panel.reward_icon_bg.image.sprite = self:loadSprite(var_0_11.equip_back_ground)
		var_26_1.reward_panel.reward_icon.image.sprite = self:loadSprite(string.format(var_0_11.icon.item_icon, var_26_0.award[1].id))

		::label_26_0::

		local var_26_9 = {}
		local var_26_10, var_26_11 = var_0_26.get_sequence()

		if var_26_10 and next(var_26_10) then
			for iter_26_2, iter_26_3 in pairs(var_26_10) do
				if iter_26_3.pve_level_id == self.map_id then
					table.insert(var_26_9, iter_26_3)
				end
			end
		end

		self:__set_node_data_by_map(var_26_9)
	end

	function arg_1_0:__is_mouse_pos_in_no_enter()
		if self._can_move and not self._is_short_click then
			local var_27_1, var_27_2 = var_0_21.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_6.mousePosition, self._ui_camera, nil)

			if var_27_1 then
				local var_27_3 = self:__is_in_noenter_area(nil + self.sceen_center_pos + Vector2(0, 60) - self._control.empty_bg.rectTransform.anchoredPosition)

				if var_27_3 and not self._now_move_num and not self._now_move_func then
					self._is_mouse_in_no_enter = true
					self._now_move_sizedelta = var_27_3.size
					self._now_move_num = var_27_3.num
					self._now_move_elite_id = var_27_3.num
				else
					self._is_mouse_in_no_enter = false
					self._now_move_sizedelta = nil
					self._now_move_func = nil
				end
			end
		end
	end

	function arg_1_0:__is_in_noenter_area(arg_28_1, arg_28_2)
		local var_28_0 = self:__get_rule_num_by_pos(arg_28_1)

		if self.obstacle_list[var_28_0] then
			if arg_28_2 then
				return self.obstacle_list[var_28_0], var_28_0
			end

			local var_28_1 = self:__get_pos_by_rule_num(var_28_0)
			local var_28_2 = arg_28_1 - Vector2(var_28_1.x, var_28_1.y)

			if self.obstacle_list[var_28_0].x >= var_28_2.x and self.obstacle_list[var_28_0].y >= var_28_2.y then
				return self.obstacle_list[var_28_0], var_28_0
			end
		end

		return false
	end

	function arg_1_0:__set_node_data_by_map(arg_29_1)
		local var_29_0 = self._control.map_preview.map_bg.map_panel.map_node_root

		self:__rest_child(self._control.map_preview.map_bg.map_panel.map_node_root.transform)

		local var_29_1 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.width
		local var_29_2 = self._control.map_preview.map_bg.map_panel.rectTransform.rect.height
		local var_29_3 = {}

		for iter_29_0, iter_29_1 in pairs(arg_29_1) do
			if iter_29_1.node_miss and next(iter_29_1.node_miss) then
				for iter_29_2, iter_29_3 in pairs(iter_29_1.node_miss) do
					table.insert(var_29_3, {
						hide_start_point = iter_29_1.id,
						hide_end_point = iter_29_2,
						hide_result = iter_29_3
					})
				end
			end
		end

		for iter_29_4, iter_29_5 in pairs(arg_29_1) do
			local var_29_4, var_29_5 = self:loadUIPrefab("map_node_obj", var_29_0.transform)

			var_29_4:setVisible(true)

			var_29_5.node_image.rectTransform.parent.offsetMin = Vector2(0, 0)
			var_29_5.node_image.rectTransform.parent.offsetMax = Vector2(0, 0)
			var_29_5.node_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_29_1, var_29_2, iter_29_5.position.x, iter_29_5.position.y) + Vector2(8, 0)

			local var_29_6
			local var_29_7 = 1
			local var_29_8 = false
			local var_29_9
			local var_29_10

			if iter_29_5.support_icon ~= 0 then
				local var_29_11 = gameconfig.support_atk_config.find_object_by_id(iter_29_5.support_icon)

				var_29_9 = var_0_4:is_pass_eighth_map_node(iter_29_5.pve_level_id, iter_29_5.id)
				var_29_6 = string.format((var_29_9 ~= false or nil) and (var_0_11.fight_point.support_icon_path_red or var_0_11.fight_point.support_icon_path_white), var_29_11.type)
				var_29_8 = true
				var_29_7 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) and 2 or 1
			elseif iter_29_5.node_attribute == var_0_11.map_node_finish_type.init then
				var_29_6 = var_0_11.fight_point.pve_start_l
				var_29_7 = 2
			elseif iter_29_5.node_attribute == var_0_11.map_node_finish_type.boss_finish then
				if var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) then
					var_29_6 = var_0_11.fight_point.pve_boss_l
					var_29_7 = 2
				else
					var_29_6 = var_0_11.fight_point.pve_boss
					var_29_7 = 1
				end
			elseif iter_29_5.node_type == var_0_11.map_node_type.reward then
				var_29_6 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) and var_0_11.fight_point.pve_green or var_0_11.fight_point.pve_white
			elseif iter_29_5.node_type == var_0_11.map_node_type.loss then
				var_29_6 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) and var_0_11.fight_point.pve_purple or var_0_11.fight_point.pve_white
			elseif iter_29_5.node_type == var_0_11.map_node_type.null then
				var_29_6 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) and var_0_11.fight_point.pve_blue or var_0_11.fight_point.pve_white
			elseif iter_29_5.node_type == var_0_11.map_node_type.little_boss then
				self._little_boss_point_data = iter_29_5
				var_29_6 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) and var_0_11.fight_point.pve_small_boss_l or var_0_11.fight_point.pve_small_boss

				local var_29_12 = var_29_5.node_image.guard_icon
				local var_29_13, var_29_14 = var_0_4:is_point_stationed(iter_29_5.id)

				if var_29_13 then
					self._current_station_team_id = var_29_14

					local var_29_15 = var_29_5.node_image.transform.localPosition

					var_29_12:SetActive(true)
					var_29_12.button.onClick:RemoveAllListeners()
					var_29_12.button.onClick:AddListener(function()
						self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))
						self:show_cover_func(true)

						local var_30_0 = string.sub(tostring(var_29_12.team_id.image.sprite), 16, 16)

						self._control.map_preview:SetActive(false)
						self._control.cover_2:SetActive(false)

						local var_30_1 = var_0_7:createInstance("captainroom_fleet")

						if not var_30_1 then
							return
						end

						var_30_1:show(var_0_8:getNowLang("ui_activitydefendfleet"), var_0_4:get_team_by_id(tonumber(var_30_0)).members, var_0_8:getNowLang("ui_activitydefendcancel"), "", function()
							local var_31_0 = var_0_7:createInstance("msgbox")

							if not var_31_0 then
								return
							end

							var_31_0:show(var_0_8:getNowLang("ui_activitydefendcanceltip"), function()
								var_31_0:setVisible(false)
								var_0_4:req_StationPointExitReq(tonumber(var_30_0))
								var_0_7:destroyInstance("captainroom_fleet")

								local var_32_0 = var_0_7:getInstance("eighth_sea_map")

								if var_32_0 then
									var_32_0._control.map_preview:SetActive(true)
								end

								local var_32_1 = var_0_7:getInstance("cover")

								if var_32_1 then
									var_32_1:setVisible(false)
								end
							end, function()
								var_31_0:setVisible(false)
							end, var_0_8:getNowLang("ui_activitydefendcancel"))
						end, true)
						var_30_1:disallowed_clicking()
					end)

					local var_29_16 = iter_29_5.bubble_icon

					if iter_29_5.bubble_icon == 0 then
						var_29_16 = 1
					end

					var_29_12.image.sprite = self:loadSprite(string.format(var_0_11.guard_point.pve_node_guard, var_29_16))
					var_29_12.team_id.image.sprite = self:loadSprite(string.format(var_0_11.guard_point.pve_fleet_team, self._current_station_team_id))
					var_29_12.transform.localScale = Vector3(1.38, 1.54, 1)

					local var_29_17 = Vector3.zero
					local var_29_18 = Vector3.zero

					if var_29_16 == 1 then
						var_29_17 = Vector2(-10, -142)
						var_29_18 = Vector2(0, -2.8)
					elseif var_29_16 == 2 then
						var_29_17 = Vector2(-10, 0)
						var_29_18 = Vector2(0, 6)
					elseif var_29_16 == 3 then
						var_29_17 = Vector2(120, 0)
						var_29_18 = Vector2(0, 6)
					elseif var_29_16 == 4 then
						var_29_17 = Vector2(120, -142)
						var_29_18 = Vector2(0, -2.8)
					end

					if (var_29_16 == 1 or var_29_16 == 2) and var_29_15.x < 60 then
						var_29_17.x = 10
					elseif (var_29_16 == 1 or var_29_16 == 4) and var_29_15.y <= -537 then
						var_29_17.y = -104
					end

					var_29_12.transform.anchoredPosition = var_29_17
					var_29_12.team_id.transform.anchoredPosition = var_29_18
				end
			else
				local var_29_19 = var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id)

				if var_29_19 and iter_29_5.node_type ~= 13 then
					var_29_6 = var_0_11.fight_point.pve_red
					var_29_10 = var_0_11.push_random_red_image
					var_29_7 = 2
				elseif var_29_19 == false and iter_29_5.node_type ~= 13 then
					var_29_6 = var_0_11.fight_point.pve_white
					var_29_10 = var_0_11.push_random_white_image
					var_29_7 = 1
				elseif var_29_19 and iter_29_5.node_type == 13 then
					var_29_6 = var_0_11.pve_buff_red
					var_29_10 = var_0_11.push_random_red_image
					var_29_7 = 1
				elseif var_29_19 == false and iter_29_5.node_type == 13 then
					var_29_6 = var_0_11.pve_buff_white
					var_29_10 = var_0_11.push_random_white_image
					var_29_7 = 1
				else
					var_29_10 = var_0_11.push_random_white_image
					var_29_6 = var_0_11.fight_point.pve_white
					var_29_7 = 1
				end
			end

			var_29_5.node_image.image.sprite = self:loadSprite(var_29_6)
			var_29_5.node_image.random_buff_icon.image.sprite = self:loadSprite(var_29_10)

			if var_29_8 then
				var_29_5.node_image.transform.gameObject:AddComponent(typeof(var_0_5.UI.Button))

				var_29_5.node_image.image.raycastTarget = true

				var_29_5.node_image:GetComponent("Button").onClick:RemoveAllListeners()
				var_29_5.node_image:GetComponent("Button").onClick:AddListener(function()
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

					local var_34_0 = var_0_7:getInstance("suppress_msg")

					if not var_34_0 then
						var_34_0 = var_0_7:createInstance("suppress_msg")
					else
						var_0_7:destroyInstance("suppress_msg")

						var_34_0 = var_0_7:createInstance("suppress_msg")
					end

					if var_29_9 then
						var_34_0:show("suppressed", iter_29_5.pve_level_id, 1.5, nil, var_0_11.fight_type.eighth_attack)
					else
						var_34_0:show("suppress", iter_29_5.pve_level_id, 1.5, nil, var_0_11.fight_type.eighth_attack)
					end
				end)
			end

			var_29_5.node_image.image:SetNativeSize()

			if iter_29_5.node_attribute == var_0_11.map_node_finish_type.normal_finish then
				if var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) then
					var_29_7 = 2
				end
			elseif iter_29_5.node_attribute == var_0_11.map_node_finish_type.normal and var_0_4:is_cur_eighth_map_node_pass(iter_29_5.pve_level_id, iter_29_5.id) then
				var_29_7 = 2
			end

			local var_29_21

			if iter_29_5.flag and var_29_7 then
				var_29_21 = string.format(var_0_11.fearlessness_sea_node_letter, iter_29_5.flag .. var_29_7)
			end

			local var_29_23

			if iter_29_5.roundabout == 1 then
				var_29_23 = var_0_11.pve_g
				var_29_5.night_atk_point_2.image.sprite = self:loadSprite(var_0_11.pve_g)

				var_29_5.night_atk_point_2.image:SetNativeSize()
				var_29_5.night_atk_point_2:SetActive(true)

				var_29_5.night_atk_point_2.rectTransform.parent.offsetMin = Vector2(0, 0)
				var_29_5.night_atk_point_2.rectTransform.parent.offsetMax = Vector2(0, 0)
				var_29_5.night_atk_point_2.rectTransform.anchoredPosition = self:__get_real_node_pos(var_29_1, var_29_2, iter_29_5.position.x, iter_29_5.position.y) + Vector2(8, 0)
			end

			local var_29_24 = {}

			if iter_29_5.night_atk == 1 then
				var_29_23 = var_0_11.pve_night_atk_l

				table.insert(var_29_24, var_0_11.pve_night_atk_l)
			end

			if iter_29_5.node_type == 10 then
				var_29_23 = var_0_11.pve_air

				table.insert(var_29_24, var_0_11.pve_air)
			elseif iter_29_5.node_type == 11 or iter_29_5.node_type == 14 then
				local var_29_25 = var_0_4:get_eighth_map_info()
				local var_29_26 = {}

				if var_29_25 and next(var_29_25) then
					for iter_29_6, iter_29_7 in pairs(var_29_25) do
						if iter_29_6 == self.map_id then
							var_29_26 = iter_29_7
						end
					end
				end

				if not var_29_26.finish_chase then
					var_29_23 = var_0_11.pve_special_boss_l

					table.insert(var_29_24, var_0_11.pve_special_boss_l)
				end
			end

			if var_29_23 and next(var_29_24) then
				var_29_5.night_atk_point.image.sprite = self:loadSprite(var_29_23)

				var_29_5.night_atk_point.image:SetNativeSize()
				var_29_5.night_atk_point:SetActive(true)

				var_29_5.night_atk_point.rectTransform.parent.offsetMin = Vector2(0, 0)
				var_29_5.night_atk_point.rectTransform.parent.offsetMax = Vector2(0, 0)
				var_29_5.night_atk_point.rectTransform.anchoredPosition = self:__get_real_node_pos(var_29_1, var_29_2, iter_29_5.position.x, iter_29_5.position.y) + Vector2(8, 0)

				if iter_29_5.night_atk == 1 or iter_29_5.node_type == 10 or iter_29_5.node_type == 11 or iter_29_5.node_type == 14 then
					local var_29_27 = true

					if iter_29_5.node_type == 11 then
						local var_29_28 = var_0_4:get_map_list()[iter_29_5.pve_level_id]

						if var_29_28 then
							for iter_29_8, iter_29_9 in pairs(var_29_28.pass_point) do
								if iter_29_5.id == iter_29_9.id then
									for iter_29_10, iter_29_11 in ipairs(iter_29_9.info) do
										if iter_29_11.grade > 2 then
											var_29_27 = false

											break
										end
									end
								end
							end
						end
					end

					if var_29_27 then
						local var_29_29 = self:autoKillDOTween(var_0_12.Sequence())

						table.insert(self._light_seq_list, var_29_29)
						var_29_29:Append(var_29_5.night_atk_point.image:DOFade(0, 0))

						for iter_29_12, iter_29_13 in pairs(var_29_24) do
							var_29_29:Append(var_29_5.night_atk_point.image:DOFade(0, 0))
							var_29_29:AppendCallback(function()
								if var_29_5 and var_29_5.night_atk_point and not var_29_5.night_atk_point:Equals(nil) then
									var_29_5.night_atk_point.image.sprite = self:loadSprite(iter_29_13)
								end
							end)
							var_29_29:Append(var_29_5.night_atk_point.image:DOFade(1, 1))
							var_29_29:Append(var_29_5.night_atk_point.image:DOFade(0, 1))
						end

						var_29_29:SetLoops(-1)
						var_29_29:Play()
					end
				end
			else
				var_29_5.night_atk_point:SetActive(false)
			end

			var_29_5.node_image.random_buff_icon:SetActive(false)

			local var_29_30 = {}

			for iter_29_14, iter_29_15 in pairs(var_29_3) do
				if iter_29_15.hide_start_point == iter_29_5.id then
					for iter_29_16, iter_29_17 in pairs(iter_29_15.hide_result) do
						local var_29_32 = var_0_26.find_object_by_id(tonumber(iter_29_16))

						if var_0_4:is_cur_eighth_map_node_pass(var_29_32.pve_level_id, var_29_32.id) and var_0_4:get_eighth_map_node_pass_count(var_29_32.pve_level_id, var_29_32.id) >= 1 then
							for iter_29_18, iter_29_19 in pairs(iter_29_5.next_node) do
								if iter_29_19 == tonumber(iter_29_15.hide_end_point) then
									table.insert(var_29_30, iter_29_19)
								end
							end
						end
					end
				end
			end

			local var_29_33 = {}
			local var_29_34 = true

			if iter_29_5.node_hide and next(iter_29_5.node_hide) then
				for iter_29_20, iter_29_21 in pairs(iter_29_5.node_hide) do
					for iter_29_22, iter_29_23 in pairs(iter_29_5.next_node) do
						if tonumber(iter_29_20) == iter_29_23 then
							for iter_29_24, iter_29_25 in pairs(iter_29_21) do
								local var_29_36 = var_0_26.find_object_by_id(tonumber(iter_29_25))
								local var_29_37 = var_0_4:get_map_node_pass_count(var_29_36.pve_level_id, var_29_36.id)

								if not var_0_4:is_pass_eighth_map_node(var_29_36.pve_level_id, var_29_36.id) then
									var_29_34 = false
								end
							end

							var_29_33 = {
								is_show_true = var_29_34,
								node_flag = var_0_26.find_object_by_id(tonumber(iter_29_20)).flag
							}
						end
					end
				end
			end

			if iter_29_5.next_node_path ~= "{}" then
				for iter_29_26, iter_29_27 in pairs((var_0_14(iter_29_5.next_node_path))) do
					local var_29_39, var_29_40 = self:loadUIPrefab("map_line_obj", var_29_0.transform)

					var_29_39:setVisible(true)

					var_29_40.line_image.rectTransform.parent.offsetMin = Vector2(0, 0)
					var_29_40.line_image.rectTransform.parent.offsetMax = Vector2(0, 0)
					var_29_40.line_image.rectTransform.anchoredPosition = self:__get_real_node_pos(var_29_1, var_29_2, iter_29_27.x, iter_29_27.y)
					var_29_40.line_image.image.sprite = self:loadSprite(var_0_9(var_0_11.mapline_path, string.lower(self.map_id), iter_29_26))
					var_29_40.line_image.transform.localScale = Vector3(0.75, 0.75, 1)

					var_29_40.line_image.image:SetNativeSize()
					var_29_40.line_image:SetActive(true)

					var_29_40.line_image.image.color = var_0_5.Color(1, 1, 1, 1)

					if next(var_29_33) and var_29_33.node_flag == lx.split(iter_29_26, "-")[3] then
						var_29_40.line_image.image.color = var_29_33.is_show_true and var_0_5.Color(1, 1, 1, 1) or var_0_5.Color(1, 1, 1, 0.2)
					end

					if next(var_29_30) then
						for iter_29_28, iter_29_29 in pairs(var_29_30) do
							if string.format("%s-%s-%s", iter_29_5.pve_level_id, iter_29_5.flag, var_0_26.find_object_by_id(iter_29_29).flag) == iter_29_26 then
								var_29_40.line_image:SetActive(false)
							end
						end
					end
				end
			end

			if #iter_29_5.flag > 0 then
				local var_29_41, var_29_42 = self:loadUIPrefab("fearlessness_sea_letter_obj", var_29_0.transform)

				var_29_41:setVisible(true)

				var_29_42.node_letter_image.rectTransform.parent.offsetMin = Vector2(0, 0)
				var_29_42.node_letter_image.rectTransform.parent.offsetMax = Vector2(0, 0)
				var_29_42.node_letter_image.rectTransform.anchoredPosition = var_29_5.node_image.rectTransform.anchoredPosition + Vector2(18, 30)
				var_29_42.node_letter_image.image.sprite = self:loadSprite(var_29_21)
			end
		end
	end

	function arg_1_0:__set_operational_func()
		self._not_set_support_bg = false
		self._now_move_num = nil
		self._now_move_elite_id = nil
		self._now_move_func = nil

		if self._support_info and next(self._support_info) then
			for iter_36_0, iter_36_1 in pairs(self._support_info) do
				if iter_36_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
					iter_36_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
				else
					iter_36_1.single_ctrl.support_point.support_bg_2:SetActive(false)
					iter_36_1.single_ctrl.support_point.set_support_btn:SetActive(false)
					iter_36_1.single_ctrl.support_point.support_btn:SetActive(true)
					iter_36_1.single_ctrl.support_point.support_bg:SetActive(true)
				end
			end
		end

		var_0_4:req_EighthBigMapMoveReq(self.sea_map_data.id, self.player_now_num)
		var_0_4:set_common_eighth_map_id(self.map_id)
		var_0_4:set_eight_monster_hurt_id()
		var_0_4:set_monster_is_move(false)

		self._monster_move = false
		self._have_sign = false

		self:__exit_animation()

		local var_36_0 = var_0_7:getInstance("mix_battle_plan")

		if var_36_0 then
			var_36_0:show(8)
		else
			var_0_7:createInstance("mix_battle_plan"):show(8)
		end
	end

	function arg_1_0:update_map_preview_data()
		self:__set_map_preview_data()
	end

	function arg_1_0:close_map_preview()
		self:__onClick_map_preview_map_bg_close_btn()
	end

	function arg_1_0:_play_audio(arg_39_1, arg_39_2)
		self:playBackgroundMusic(arg_39_1, arg_39_2)
	end

	function arg_1_0:_play_into_se(arg_40_1)
		self:playSE(arg_40_1, false)
	end

	function arg_1_0:__set_support_pos()
		if self._control.support_list.transform.childCount > 0 then
			for iter_41_0 = 1, self._control.support_list.transform.childCount do
				self:destroyGameObject(self._control.support_list.transform:GetChild(iter_41_0 - 1).gameObject)
			end
		end

		self._support_info = {}

		for iter_41_1, iter_41_2 in pairs(self.sea_map_data.support_position) do
			local var_41_1 = self:__get_pos_by_rule_num(iter_41_2)
			local var_41_2, var_41_3 = self:loadUIPrefab("eighth_sea_map_support", self._control.support_list.transform)

			self:__set_noentry_area(iter_41_2, var_41_1, var_41_3.support_point.rectTransform.sizeDelta)

			var_41_2._panel.name = "support_" .. iter_41_1

			var_41_2:setVisible(true)

			var_41_2._panel:GetComponent("RectTransform").anchoredPosition = var_41_1

			local var_41_4 = var_0_27.find_object_by_level((self:__all_activity_score()))

			table.insert(self._support_info, {
				state = false,
				name = var_41_2._panel.name,
				single_ctrl = var_41_3,
				pos = iter_41_2,
				support_num = var_41_4.range
			})
			var_41_3.enemy_role:SetActive(false)
			var_41_3.support_point:SetActive(true)
			var_41_3.support_point.set_support_btn:SetActive(false)
			var_41_3.support_point.set_support_btn.set_support_txt:SetActive(false)
			var_41_3.support_point.clear_support_btn:SetActive(false)
			var_41_3.support_point.clear_support_btn_2:SetActive(false)
			var_41_3.enemy_role.boss_sign:SetActive(false)
			var_41_3.enemy_role.enemy_role_btn:SetActive(false)

			var_41_3.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_11.eighth_support_ship_spine, var_41_4.image, var_41_4.image))

			local var_41_5 = var_0_5.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

			var_41_3.enemy_role.skeletonGraphic.material.shader = var_41_5
			var_41_3.enemy_role.shadow.skeletonGraphic.material.shader = var_41_5
			var_41_3.enemy_role.skeletonGraphic.initialSkinName = "normal"

			if not var_41_3.enemy_role.skeletonGraphic:Equals(nil) then
				var_41_3.enemy_role.skeletonGraphic:Initialize(true)
			end

			self:__set_support_normal_anim(var_41_3.enemy_role, true, var_41_4.image)

			local var_41_7 = var_0_4:get_eighth_map_info()[self.map_id]

			var_41_3.support_point.support_bg:SetActive(true)
			var_41_3.support_point.support_bg_2:SetActive(false)

			var_41_3.support_point.support_bg.image.sprite = self:loadSprite(var_0_11.eighth_support_bg.place)

			if ((var_41_7.support_fleet and next(var_41_7.support_fleet) or nil) and #var_41_7.support_fleet) >= var_41_4.num then
				var_41_3.support_point.support_bg.image.sprite = self:loadSprite(var_0_11.eighth_support_bg.not_place)
			end

			local var_41_10 = {}
			local var_41_11 = 0

			if #var_41_7.support_fleet > 0 and var_41_7.support_fleet[1] ~= 0 then
				for iter_41_3, iter_41_4 in ipairs(var_41_7.support_fleet) do
					if iter_41_4 == iter_41_2 then
						var_41_3.support_point.support_bg.image:SetNativeSize()
						var_41_3.support_point.support_bg:SetActive(false)
						var_41_3.enemy_role:SetActive(true)
						var_41_3.support_point.clear_support_btn:SetActive(false)
						table.insert(var_41_10, iter_41_2)
					end
				end

				var_41_11 = #var_41_7.support_fleet
			end

			local var_41_12 = 1
			local var_41_13 = self:__all_activity_score()
			local var_41_14

			if var_41_13 > 0 then
				var_41_14 = var_0_27.find_object_by_level(var_41_13)
				var_41_12 = var_41_14.num
			end

			if var_41_10 and next(var_41_10) then
				for iter_41_5, iter_41_6 in pairs(var_41_10) do
					if var_41_3.enemy_role.gameObject.activeSelf then
						self._monster_move = var_0_4:get_monster_is_move()

						if self._monster_move and self._fire_ok and self:__is_support_can_fire(iter_41_2, var_41_14.range) then
							self:__create_openfire_effect(var_41_3, iter_41_6, var_41_14.num)
						end

						var_41_3.support_point.support_btn:SetActive(false)
						var_41_3.support_point.clear_support_btn:SetActive(true)
						var_41_3.support_point.clear_support_txt:SetActive(false)
						var_41_3.support_point.clear_support_btn.button.onClick:RemoveAllListeners()
						var_41_3.support_point.clear_support_btn.button.onClick:AddListener(function()
							self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

							for iter_42_0, iter_42_1 in pairs(self._support_info) do
								iter_42_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)

								if not iter_42_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
									iter_42_1.single_ctrl.support_point.support_bg_2:SetActive(false)
									iter_42_1.single_ctrl.support_point.set_support_btn:SetActive(false)
									iter_42_1.single_ctrl.support_point.support_btn:SetActive(true)
									iter_42_1.single_ctrl.support_point.support_bg:SetActive(true)
								end
							end

							self._now_move_num = iter_41_2
							self._now_move_elite_id = iter_41_2
							self._is_short_click = true
							self._can_move = true
							self._is_creat_list = false

							var_41_3.support_point.set_support_btn:SetActive(false)
							var_41_3.support_point.clear_support_btn:SetActive(false)
							var_41_3.support_point.clear_support_btn_2:SetActive(true)
							var_41_3.support_point.clear_support_txt:SetActive(true)

							self._support_ctrl = var_41_3
							var_41_3.support_point.clear_support_txt_2.text.text = var_0_8:getNowLang("cancel")

							var_41_3.support_point.support_btn:SetActive(false)
						end)
					else
						var_41_3.support_point.set_support_btn:SetActive(true)
						var_41_3.support_point.set_support_btn.set_support_txt:SetActive(true)
						var_41_3.support_point.support_btn:SetActive(false)
					end
				end
			elseif var_41_12 < var_41_11 or var_41_11 == 0 then
				var_41_3.support_point.support_btn:SetActive(true)
				var_41_3.support_point.support_btn.button.onClick:RemoveAllListeners()
				var_41_3.support_point.support_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

					if self._support_info and next(self._support_info) then
						for iter_43_0, iter_43_1 in pairs(self._support_info) do
							iter_43_1.single_ctrl.set_support_bg_1:SetActive(false)
							iter_43_1.single_ctrl.set_support_bg_2:SetActive(false)
							iter_43_1.single_ctrl.set_support_bg_3:SetActive(false)
							iter_43_1.single_ctrl.support_point.set_support_btn:SetActive(false)
							iter_43_1.single_ctrl.support_point.support_bg_2:SetActive(false)
							iter_43_1.single_ctrl.support_point.support_bg:SetActive(true)
							iter_43_1.single_ctrl.support_point.support_btn:SetActive(true)
							iter_43_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
						end
					end

					if var_41_14.range == 1 then
						var_41_3.set_support_bg_1:SetActive(true)
					elseif var_41_14.range == 2 then
						var_41_3.set_support_bg_2:SetActive(true)
					elseif var_41_14.range == 3 then
						var_41_3.set_support_bg_3:SetActive(true)
					elseif var_41_14.range == 4 then
						var_41_3.set_support_bg_4:SetActive(true)
					end

					self._now_move_num = iter_41_2
					self._now_move_elite_id = iter_41_2
					self._is_short_click = true
					self._can_move = true
					self._is_creat_list = false

					var_41_3.support_point.set_support_btn:SetActive(true)
					var_41_3.support_point.set_support_btn.set_support_txt:SetActive(true)

					self._support_ctrl = var_41_3

					var_41_3.support_point.support_bg:SetActive(false)
					var_41_3.support_point.support_bg_2:SetActive(true)

					var_41_3.support_point.support_bg_2.image.sprite = self:loadSprite(string.format(var_0_11.eighth_support_bg.place_state, var_41_14.image))

					var_41_3.support_point.support_bg_2.image:SetNativeSize()

					var_41_3.support_point.set_support_btn.set_support_txt.text.text = var_0_8:getNowLang("place")

					var_41_3.support_point.support_btn:SetActive(false)
				end)
			elseif var_41_11 < var_41_12 then
				var_41_3.support_point.support_btn:SetActive(true)
				var_41_3.support_point.support_btn.button.onClick:RemoveAllListeners()
				var_41_3.support_point.support_btn.button.onClick:AddListener(function()
					self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))

					if self._support_info and next(self._support_info) then
						for iter_44_0, iter_44_1 in pairs(self._support_info) do
							if not iter_44_1.single_ctrl.enemy_role.gameObject.activeInHierarchy then
								iter_44_1.single_ctrl.support_point.set_support_btn:SetActive(false)
								iter_44_1.single_ctrl.support_point.support_bg_2:SetActive(false)
								iter_44_1.single_ctrl.support_point.support_bg:SetActive(true)
								iter_44_1.single_ctrl.support_point.support_btn:SetActive(true)
							else
								iter_44_1.single_ctrl.support_point.clear_support_btn_2:SetActive(false)
							end
						end
					end

					if var_41_14.range == 1 then
						var_41_3.set_support_bg_1:SetActive(true)
					elseif var_41_14.range == 2 then
						var_41_3.set_support_bg_2:SetActive(true)
					elseif var_41_14.range == 3 then
						var_41_3.set_support_bg_3:SetActive(true)
					elseif var_41_14.range == 4 then
						var_41_3.set_support_bg_4:SetActive(true)
					end

					self._now_move_num = iter_41_2
					self._now_move_elite_id = iter_41_2
					self._is_short_click = true
					self._can_move = true
					self._is_creat_list = false

					var_41_3.support_point.set_support_btn:SetActive(true)
					var_41_3.support_point.set_support_btn.set_support_txt:SetActive(true)

					self._support_ctrl = var_41_3

					var_41_3.support_point.support_bg:SetActive(false)
					var_41_3.support_point.support_bg_2:SetActive(true)

					var_41_3.support_point.support_bg_2.image.sprite = self:loadSprite(string.format(var_0_11.eighth_support_bg.place_state, var_41_14.image))

					var_41_3.support_point.support_bg_2.image:SetNativeSize()

					var_41_3.support_point.set_support_btn.set_support_txt.text.text = var_0_8:getNowLang("place")

					var_41_3.support_point.support_btn:SetActive(false)
				end)
			end

			var_41_3.support_point.set_support_btn.button.onClick:RemoveAllListeners()
			var_41_3.support_point.set_support_btn.button.onClick:AddListener(function()
				self._fire_ok = false
				self._support_state = 1

				self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))
				var_0_4:req_EighthSetSupPosReq(self.map_id, self._now_move_num, 1)
			end)
			var_41_3.support_point.clear_support_btn_2.button.onClick:RemoveAllListeners()
			var_41_3.support_point.clear_support_btn_2.button.onClick:AddListener(function()
				self._fire_ok = false
				self._support_state = 2

				self:_play_into_se(var_0_11:get_audio_url(var_0_11.common_icon.music_path, var_0_11.back_two))
				var_0_4:req_EighthSetSupPosReq(self.map_id, self._now_move_num, 2)
			end)
		end
	end

	function arg_1_0.__all_activity_score(arg_47_0)
		local var_47_0 = var_0_4:get_eighth_task_finished_table()
		local var_47_1 = 0

		if var_47_0 and next(var_47_0) then
			for iter_47_0, iter_47_1 in pairs(var_47_0) do
				var_47_1 = var_47_1 + var_0_20.find_object_by_id(iter_47_1).supportfleet_exp
			end
		end

		local var_47_3 = {}

		if var_47_1 > 0 then
			local var_47_4, var_47_5 = var_0_27.get_sequence()

			for iter_47_2, iter_47_3 in pairs(var_47_4) do
				if var_47_1 >= iter_47_3.exp then
					table.insert(var_47_3, iter_47_3.level)
				end
			end
		end

		return (var_47_3 and next(var_47_3) or nil) and var_47_3[#var_47_3]
	end

	function arg_1_0:set_support_state()
		if self._support_state == 1 then
			self._support_ctrl.enemy_role:SetActive(true)
			self._support_ctrl.support_point.set_support_btn:SetActive(false)
			self._support_ctrl.support_point.support_txt:SetActive(false)
			self._support_ctrl.support_point.support_btn:SetActive(true)
		else
			self._support_ctrl.support_point.support_btn:SetActive(true)
			self._support_ctrl.enemy_role:SetActive(false)
			self._support_ctrl.support_point.set_support_btn:SetActive(false)
			self._support_ctrl.support_point.support_txt:SetActive(false)
		end
	end

	function arg_1_0:__is_support_can_fire(arg_49_1, arg_49_2)
		local var_49_0 = false
		local var_49_1 = var_0_4:get_eight_monster_hurt_id()
		local var_49_2

		if not var_49_1 or not next(var_49_1) then
			do return end

			var_49_2 = {}
		end

		for iter_49_0, iter_49_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			for iter_49_2, iter_49_3 in pairs(var_49_1) do
				if iter_49_1.id == iter_49_3 then
					table.insert(var_49_2, {
						id = iter_49_1.id,
						pos = iter_49_1.pre_pos
					})
				end
			end
		end

		if var_49_2 and next(var_49_2) then
			for iter_49_4, iter_49_5 in pairs(var_49_2) do
				if arg_49_2 == 1 then
					if iter_49_5.pos == arg_49_1 + 1 or iter_49_5.pos == arg_49_1 - 1 or iter_49_5.pos == arg_49_1 + 20 or iter_49_5.pos == arg_49_1 - 20 then
						var_49_0 = true
					end
				elseif arg_49_2 == 2 then
					if iter_49_5.pos == arg_49_1 + 1 or iter_49_5.pos == arg_49_1 - 1 or iter_49_5.pos == arg_49_1 + 20 or iter_49_5.pos == arg_49_1 - 20 or iter_49_5.pos == arg_49_1 + 2 or iter_49_5.pos == arg_49_1 - 2 or iter_49_5.pos == arg_49_1 + 19 or iter_49_5.pos == arg_49_1 - 19 or iter_49_5.pos == arg_49_1 + 21 or iter_49_5.pos == arg_49_1 - 21 or iter_49_5.pos == arg_49_1 + 40 or iter_49_5.pos == arg_49_1 - 40 then
						var_49_0 = true
					end
				elseif arg_49_2 == 3 then
					if iter_49_5.pos == arg_49_1 + 1 or iter_49_5.pos == arg_49_1 - 1 or iter_49_5.pos == arg_49_1 + 20 or iter_49_5.pos == arg_49_1 - 20 or iter_49_5.pos == arg_49_1 + 2 or iter_49_5.pos == arg_49_1 - 2 or iter_49_5.pos == arg_49_1 + 19 or iter_49_5.pos == arg_49_1 - 19 or iter_49_5.pos == arg_49_1 + 21 or iter_49_5.pos == arg_49_1 - 21 or iter_49_5.pos == arg_49_1 + 40 or iter_49_5.pos == arg_49_1 - 40 or iter_49_5.pos == arg_49_1 + 3 or iter_49_5.pos == arg_49_1 - 3 or iter_49_5.pos == arg_49_1 + 31 or iter_49_5.pos == arg_49_1 - 31 or iter_49_5.pos == arg_49_1 + 41 or iter_49_5.pos == arg_49_1 - 41 or iter_49_5.pos == arg_49_1 + 18 or iter_49_5.pos == arg_49_1 - 18 or iter_49_5.pos == arg_49_1 + 22 or iter_49_5.pos == arg_49_1 - 22 or iter_49_5.pos == arg_49_1 + 60 or iter_49_5.pos == arg_49_1 - 60 then
						var_49_0 = true
					end
				elseif arg_49_2 == 4 and (iter_49_5.pos == arg_49_1 + 1 or iter_49_5.pos == arg_49_1 - 1 or iter_49_5.pos == arg_49_1 + 20 or iter_49_5.pos == arg_49_1 - 20 or iter_49_5.pos == arg_49_1 + 2 or iter_49_5.pos == arg_49_1 - 2 or iter_49_5.pos == arg_49_1 + 19 or iter_49_5.pos == arg_49_1 - 19 or iter_49_5.pos == arg_49_1 + 21 or iter_49_5.pos == arg_49_1 - 21 or iter_49_5.pos == arg_49_1 + 40 or iter_49_5.pos == arg_49_1 - 40 or iter_49_5.pos == arg_49_1 + 3 or iter_49_5.pos == arg_49_1 - 3 or iter_49_5.pos == arg_49_1 + 31 or iter_49_5.pos == arg_49_1 - 31 or iter_49_5.pos == arg_49_1 + 41 or iter_49_5.pos == arg_49_1 - 41 or iter_49_5.pos == arg_49_1 + 18 or iter_49_5.pos == arg_49_1 - 18 or iter_49_5.pos == arg_49_1 + 22 or iter_49_5.pos == arg_49_1 - 22 or iter_49_5.pos == arg_49_1 + 60 or iter_49_5.pos == arg_49_1 - 60 or iter_49_5.pos == arg_49_1 + 80 or iter_49_5.pos == arg_49_1 - 80 or iter_49_5.pos == arg_49_1 + 61 or iter_49_5.pos == arg_49_1 - 61 or iter_49_5.pos == arg_49_1 + 42 or iter_49_5.pos == arg_49_1 - 42 or iter_49_5.pos == arg_49_1 + 23 or iter_49_5.pos == arg_49_1 - 23 or iter_49_5.pos == arg_49_1 + 4 or iter_49_5.pos == arg_49_1 - 4 or iter_49_5.pos == arg_49_1 + 59 or iter_49_5.pos == arg_49_1 - 59 or iter_49_5.pos == arg_49_1 + 38 or iter_49_5.pos == arg_49_1 - 38 or iter_49_5.pos == arg_49_1 + 17 or iter_49_5.pos == arg_49_1 - 17) then
					var_49_0 = true
				end
			end
		end

		return var_49_0
	end

	function arg_1_0.__get_real_node_pos(arg_50_0, arg_50_1, arg_50_2, arg_50_3, arg_50_4, arg_50_5)
		return Vector2(arg_50_3 / 1280 * arg_50_1, not arg_50_5 and -1 * arg_50_4 / 720 * arg_50_2 or arg_50_4 / 960 * arg_50_2)
	end

	function arg_1_0:__get_player_move_pos_by_a_start(arg_51_1, arg_51_2, arg_51_3)
		local var_51_0, var_51_1, var_51_2 = self:__get_rule_num_by_pos(arg_51_1)
		local var_51_3, var_51_4, var_51_5 = self:__get_rule_num_by_pos(arg_51_2)

		var_51_1 = var_51_1 == 0 and 20 or var_51_1
		var_51_4 = var_51_4 == 0 and 20 or var_51_4

		local var_51_8 = math.ceil(self.sea_map_data.ocean_size / 20)

		if var_51_5 >= var_51_8 - 2 then
			var_51_5 = var_51_8 - 2
		end

		local var_51_9 = Vector2(var_51_1, var_51_2)
		local var_51_10 = Vector2(var_51_4, var_51_5)
		local var_51_11 = not not (self.obstacle_list[var_51_3] and self.obstacle_list[var_51_3].x > 64 and self.obstacle_list[var_51_3].y > 64)
		local var_51_12 = {
			g = 0,
			point = var_51_9,
			h = self:__ManHattan(var_51_9, var_51_10)
		}

		if not self:__is_in_map(var_51_10) then
			return {
				arg_51_1
			}
		end

		var_51_12.f = var_51_12.g + var_51_12.h

		local var_51_17 = {}

		table.insert(var_51_17, var_51_12)

		local var_51_18 = {}
		local var_51_20
		local var_51_21 = false

		while #var_51_17 > 0 and 0 < 40 do
			var_51_20 = var_51_17[1]

			local var_51_23 = 1
			local var_51_24 = var_51_17[1].f

			for iter_51_0, iter_51_1 in ipairs(var_51_17) do
				if var_51_24 >= iter_51_1.f then
					var_51_24 = iter_51_1.f
					var_51_20 = iter_51_1
					var_51_23 = iter_51_0
				end
			end

			table.remove(var_51_17, var_51_23)
			table.insert(var_51_18, var_51_20)

			local var_51_25 = false

			if var_51_11 then
				for iter_51_2 = -1, 1 do
					for iter_51_3 = -1, 1 do
						if var_51_20.point.x == var_51_10.x + iter_51_2 and var_51_20.point.y == var_51_10.y + iter_51_3 then
							var_51_25 = true
						end
					end
				end
			elseif var_51_20.point.x == var_51_10.x and var_51_20.point.y == var_51_10.y then
				var_51_25 = true
			end

			if var_51_25 then
				var_51_21 = true

				break
			end

			local var_51_26 = var_51_20.point

			self:__add_to_openlist(Vector2(var_51_20.point.x - 1, var_51_20.point.y), var_51_20, var_51_17, var_51_18, var_51_10)
			self:__add_to_openlist(Vector2(var_51_26.x + 1, var_51_26.y), var_51_20, var_51_17, var_51_18, var_51_10)
			self:__add_to_openlist(Vector2(var_51_26.x, var_51_26.y - 1), var_51_20, var_51_17, var_51_18, var_51_10)
			self:__add_to_openlist(Vector2(var_51_26.x, var_51_26.y + 1), var_51_20, var_51_17, var_51_18, var_51_10)

			if arg_51_3 then
				self:__add_to_openlist(Vector2(var_51_26.x - 1, var_51_26.y - 1), var_51_20, var_51_17, var_51_18, var_51_10)
				self:__add_to_openlist(Vector2(var_51_26.x + 1, var_51_26.y - 1), var_51_20, var_51_17, var_51_18, var_51_10)
				self:__add_to_openlist(Vector2(var_51_26.x - 1, var_51_26.y + 1), var_51_20, var_51_17, var_51_18, var_51_10)
				self:__add_to_openlist(Vector2(var_51_26.x + 1, var_51_26.y + 1), var_51_20, var_51_17, var_51_18, var_51_10)
			end
		end

		if not var_51_21 then
			return {
				arg_51_1
			}
		end

		local var_51_27 = {}

		while var_51_20 and var_51_20.point ~= var_51_9 do
			table.insert(var_51_27, var_51_20.point)

			var_51_20 = var_51_20.parent
		end

		if not next(var_51_27) then
			return {
				arg_51_1
			}
		end

		local var_51_28 = {}

		for iter_51_4 = #var_51_27, 1, -1 do
			local var_51_29, var_51_30 = self:__get_next_pos(var_51_27[iter_51_4])

			if var_51_29 then
				table.insert(var_51_28, var_51_30)
			end
		end

		return var_51_28
	end

	function arg_1_0:__set_run_anim()
		if not self._is_move_anim then
			self._control.player_role.spray:SetActive(true)

			self._is_move_anim = true

			self:__play_animation(self._control.player_role, var_0_11.character_anim_type.w.name, var_0_11.character_anim_type.w.loop)
		end
	end

	function arg_1_0:__set_monster_die_anim(arg_53_1, arg_53_2, arg_53_3)
		if not arg_53_3 then
			arg_53_1.enemy_role:SetActive(false)

			return
		end

		local var_53_0 = self:autoKillDOTween(var_0_12.Sequence())

		var_53_0:AppendInterval(1.2)

		local var_53_1 = var_0_11.character_anim_type.damage

		var_53_0:AppendCallback(function()
			self:__play_animation(arg_53_1.enemy_role, var_53_1.name, var_53_1.loop)
		end)
		var_53_0:AppendInterval(1)
		var_53_0:AppendCallback(function()
			arg_53_1.gunfire_universal:SetActive(true)

			local var_55_0 = arg_53_1.gunfire_universal.transform:GetComponent(var_0_2(var_0_1.Unity.SkeletonAnimation))

			self:play_animation(arg_53_1.gunfire_universal, var_0_11.effect_spine.bomb_at_sea.name, var_0_11.effect_spine.bomb_at_sea.loop)
			arg_53_1.enemy_role:SetActive(false)
		end)
	end

	function arg_1_0:__set_monster_run_anim(arg_56_1, arg_56_2, arg_56_3, arg_56_4)
		if not self:__have_data(arg_56_4[1], arg_56_2.pos) then
			arg_56_1.enemy_role.spray:SetActive(true)

			local var_56_0 = self:autoKillDOTween(var_0_12.Sequence())

			var_56_0:AppendInterval(0.8)
			var_56_0:AppendCallback(function()
				arg_56_1.enemy_role.spray:SetActive(false)
			end)
			self:__play_animation(arg_56_1.enemy_role, var_0_11.character_anim_type.w.name, false)
		end

		local var_56_1 = self:autoKillDOTween(var_0_12.Sequence())

		var_56_1:AppendInterval(1.2)
		var_56_1:AppendCallback(function()
			local var_58_0 = var_0_27.find_object_by_level((self:__all_activity_score())).range
			local var_58_1 = var_0_4:get_eighth_map_info()[self.map_id]

			if not var_58_1 then
				return
			end

			local var_58_2 = var_58_1.support_fleet
			local var_58_4 = var_0_4:get_eight_monster_hurt_id()

			if var_58_1.support_fleet and next(var_58_2) then
				for iter_58_0, iter_58_1 in ipairs(var_58_2) do
					if var_58_0 == 1 then
						if arg_56_2.hp < 100 and arg_56_2.hp > 0 then
							if self:__have_data(var_58_4, arg_56_2.id) then
								local function var_58_5()
									table.insert(self._hurt_monster_init, arg_56_1)
								end

								self:__play_animation(arg_56_1.enemy_role, var_0_11.character_anim_type.damage.name, var_0_11.character_anim_type.damage.loop)
								table.insert(self._hurt_monster_init, arg_56_1)
								var_56_1:AppendInterval(1.6)
								var_56_1:AppendCallback(var_58_5)
							else
								self:__set_normal_anim(arg_56_1.enemy_role, true)
							end
						else
							self:__set_normal_anim(arg_56_1.enemy_role, true)
						end
					elseif var_58_0 == 2 then
						if arg_56_2.hp < 100 and arg_56_2.hp > 0 then
							if self:__have_data(var_58_4, arg_56_2.id) then
								local function var_58_6()
									self:__set_monster_normal_anim(arg_56_1.enemy_role, true)
								end

								self:__play_animation(arg_56_1.enemy_role, var_0_11.character_anim_type.damage.name, var_0_11.character_anim_type.damage.loop)
								var_56_1:AppendCallback(var_58_6)
							else
								self:__set_normal_anim(arg_56_1.enemy_role, true)
							end
						else
							self:__set_normal_anim(arg_56_1.enemy_role, true)
						end
					elseif var_58_0 == 3 then
						if arg_56_2.hp < 100 and arg_56_2.hp > 0 then
							if self:__have_data(var_58_4, arg_56_2.id) then
								local function var_58_7()
									self:__set_monster_normal_anim(arg_56_1.enemy_role, true)
								end

								self:__play_animation(arg_56_1.enemy_role, var_0_11.character_anim_type.damage.name, var_0_11.character_anim_type.damage.loop)
								var_56_1:AppendCallback(var_58_7)
							else
								self:__set_normal_anim(arg_56_1.enemy_role, true)
							end
						else
							self:__set_normal_anim(arg_56_1.enemy_role, true)
						end
					end
				end
			else
				self:__set_normal_anim(arg_56_1.enemy_role, true)
			end
		end)
	end

	function arg_1_0:__create_openfire_effect(arg_62_1, arg_62_2, arg_62_3)
		local var_62_0 = var_0_4:get_eight_monster_hurt_id()

		if not var_62_0 or not next(var_62_0) then
			return
		end

		local var_62_1 = self:autoKillDOTween(var_0_12.Sequence())

		var_62_1:AppendInterval(0.5)
		var_62_1:AppendCallback(function()
			local var_63_0 = var_0_4:get_eighth_map_info()[self.map_id].elite
			local var_63_1 = var_0_27.find_object_by_level((self:__all_activity_score())).range
			local var_63_2 = {}

			for iter_63_0, iter_63_1 in pairs(var_63_0) do
				for iter_63_2, iter_63_3 in pairs(var_62_0) do
					if iter_63_1.id == iter_63_3 then
						table.insert(var_63_2, {
							id = iter_63_1.id,
							pos = iter_63_1.pos,
							hp = iter_63_1.hp
						})
					end
				end
			end

			local var_63_3 = {}

			for iter_63_4, iter_63_5 in pairs(var_63_2) do
				table.insert(var_63_3, {
					id = iter_63_5.id,
					dist = math.abs(iter_63_5.pos - arg_62_2),
					hp = iter_63_5.hp
				})
			end

			for iter_63_6, iter_63_7 in pairs(var_63_0) do
				for iter_63_8, iter_63_9 in pairs(var_63_3) do
					if iter_63_7.id == iter_63_9.id then
						var_63_3[iter_63_8].hp = iter_63_7.hp
					end
				end
			end

			table.sort(var_63_3, function(arg_64_0, arg_64_1)
				return arg_64_0.dist < arg_64_1.dist
			end)

			local var_63_5

			for iter_63_10, iter_63_11 in pairs(var_63_0) do
				if iter_63_11.id == var_63_3[1].id then
					var_63_5 = iter_63_11.pos
				end
			end

			self:start_battle_monster(arg_62_1, self:__get_pos_by_rule_num(var_63_5), self:__get_pos_by_rule_num(arg_62_2), arg_62_3, var_63_5, arg_62_2)
		end)
	end

	function arg_1_0:__set_monster_move(arg_65_1, arg_65_2, arg_65_3)
		local var_65_0 = self:__get_pos_by_rule_num(arg_65_2.pos)
		local var_65_1 = self:__get_pos_by_rule_num(arg_65_2.pre_pos)

		if arg_65_2.pos ~= arg_65_2.pre_pos then
			arg_65_3._panel.transform:DOLocalMove(Vector3.New(var_65_0.x, var_65_0.y, 0), 0.8)
		end
	end

	function arg_1_0:start_battle_monster(arg_66_1, arg_66_2, arg_66_3, arg_66_4, arg_66_5, arg_66_6)
		arg_66_1.gunfire_universal:SetActive(true)

		local var_66_1 = arg_66_1.gunfire_universal.transform:GetComponent(var_0_2(var_0_1.Unity.SkeletonAnimation))
		local var_66_3 = self:autoKillDOTween(var_0_12.Sequence())

		var_66_3:AppendInterval(1)
		self:play_animation(arg_66_1.gunfire_universal, var_0_11.effect_spine.ship_fire.name, var_0_11.effect_spine.ship_fire.loop)
		self:__set_support_face(arg_66_1, arg_66_5, arg_66_6)
		self:build_one_shot(arg_66_1, arg_66_2.x - arg_66_3.x, arg_66_2.y - arg_66_3.y, arg_66_5, arg_66_6)
		var_66_3:AppendInterval(2.267)
		var_66_3:AppendCallback(function()
			self:__set_support_normal_anim(arg_66_1.enemy_role, true, arg_66_4)
		end)
		self:__set_support_attack_anim(arg_66_1.enemy_role, true, arg_66_4)
	end

	function arg_1_0:build_one_shot(arg_68_1, arg_68_2, arg_68_3, arg_68_4, arg_68_5)
		self:__play_animation(arg_68_1.enemy_role, var_0_11.effect_spine.ship_fire.name, var_0_11.effect_spine.ship_fire.loop)
	end

	function arg_1_0:__create_monster_move()
		local var_69_0 = {}
		local var_69_2 = {}
		local var_69_3 = {}

		table.insert(var_69_2, {
			self.sea_map_data.battle_plan_position - 20,
			self.sea_map_data.battle_plan_position - 19,
			self.sea_map_data.battle_plan_position + 19,
			self.sea_map_data.battle_plan_position + 40,
			self.sea_map_data.battle_plan_position - 1,
			self.sea_map_data.battle_plan_position + 41,
			self.sea_map_data.battle_plan_position + 22,
			self.sea_map_data.battle_plan_position + 2
		})

		for iter_69_0, iter_69_1 in pairs(var_69_2[1]) do
			table.insert(var_69_3, iter_69_1)
		end

		local var_69_4 = {}
		local var_69_5 = {}
		local var_69_6

		for iter_69_2, iter_69_3 in ipairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			if iter_69_3.hp > 0 then
				if self:__have_data(var_69_2[1], iter_69_3.pos) then
					table.insert(var_69_0, {
						id = iter_69_3.id,
						pos = iter_69_3.pos
					})
				elseif not self:__have_data(var_69_2[1], iter_69_3.pos) then
					local var_69_8 = self:__get_pos_by_rule_num(iter_69_3.pos)
					local var_69_9 = self:__get_rule_num_by_pos(var_69_8)
					local var_69_10 = self.sea_map_data.battle_plan_position
					local var_69_11 = self:__get_pos_by_rule_num(self.sea_map_data.battle_plan_position)
					local var_69_12 = self:__get_player_move_pos_by_a_start(var_69_8, var_69_11, false)

					var_69_6 = self:__get_rule_num_by_pos(var_69_12[1])

					if iter_69_3.buff and next(iter_69_3.buff) then
						if iter_69_3.buff[1].type == 1 and #var_69_12 >= 2 then
							local var_69_13 = self:__get_rule_num_by_pos(var_69_12[1])
							local var_69_14 = {}

							for iter_69_4, iter_69_5 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
								if iter_69_5.hp > 0 then
									table.insert(var_69_14, iter_69_5.pos)
								end
							end

							var_69_6 = self:__have_data(var_69_3, var_69_13) and not self:__have_data(var_69_14, var_69_13) and var_69_13 or self:__get_rule_num_by_pos(var_69_12[2])
						elseif iter_69_3.buff[1].type == 1 and #var_69_12 == 1 then
							var_69_6 = self:__get_rule_num_by_pos(var_69_12[1])
						end
					end

					table.insert(var_69_4, {
						id = iter_69_3.id,
						pos = var_69_6
					})

					var_69_6 = iter_69_3.buff and next(iter_69_3.buff) and iter_69_3.buff[1].type == 1 and self:__is_not_go_to_next_pos_2(iter_69_3.pos, var_69_6, var_69_10, var_69_8, var_69_11, var_69_3) or self:__is_not_go_to_next_pos(iter_69_3.pos, var_69_6, var_69_10, var_69_8, var_69_11, var_69_3, false)

					if self:__have_data(var_69_3, var_69_6) and iter_69_3.buff and next(iter_69_3.buff) and iter_69_3.buff[1].type == 1 then
						var_69_6 = self:__set_next_pos(iter_69_3.pos, var_69_6, var_69_2, var_69_3, var_69_5, true)
					elseif self:__have_data(var_69_3, var_69_6) then
						var_69_6 = self:__set_next_pos(iter_69_3.pos, var_69_6, var_69_2, var_69_3, var_69_5, false)
					end

					if var_69_5 and next(var_69_5) and self:__have_data(var_69_5, var_69_6) then
						var_69_6 = iter_69_3.pos
					end

					local var_69_15 = #self.sea_map_data.support_position

					if #self.sea_map_data.support_position == 2 then
						if var_69_6 == self.sea_map_data.support_position[1] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[2] then
							local var_69_16 = self:__set_now_support_pos_num(var_69_6, var_69_10)
						else
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = var_69_6
							})
						end
					elseif var_69_15 == 3 then
						if var_69_6 == self.sea_map_data.support_position[1] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[2] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[3] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						else
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = var_69_6
							})
						end
					elseif var_69_15 == 4 then
						if var_69_6 == self.sea_map_data.support_position[1] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[2] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[3] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						elseif var_69_6 == self.sea_map_data.support_position[4] then
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = self:__set_now_support_pos_num(var_69_6, var_69_10)
							})
						else
							table.insert(var_69_0, {
								id = iter_69_3.id,
								pos = var_69_6
							})
						end
					end
				end
			end

			if iter_69_3.hp > 0 then
				table.insert(var_69_5, var_69_6)
			end

			var_0_4:set_eighth_elite_move({
				map_id = self.map_id,
				monster_info = var_69_0
			})
		end
	end

	function arg_1_0:__is_not_go_to_next_pos(arg_70_1, arg_70_2, arg_70_3, arg_70_4, arg_70_5, arg_70_6, arg_70_7)
		local var_70_0 = {}

		for iter_70_0, iter_70_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			if iter_70_1.hp > 0 then
				table.insert(var_70_0, iter_70_1.pos)
			end
		end

		local var_70_1 = self.sea_map_data.support_position

		if arg_70_2 == arg_70_1 - 1 then
			local var_70_2 = 0
			local var_70_3 = 0
			local var_70_4 = self:__get_pos_by_rule_num(arg_70_3 + 40)
			local var_70_5 = self:__get_pos_by_rule_num(arg_70_3 + 41)

			if arg_70_4.x > var_70_4.x and arg_70_4.y > var_70_4.y then
				if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) then
					arg_70_2 = arg_70_1 - 20

					return arg_70_1 - 20
				end

				if var_70_0 and next(var_70_0) then
					for iter_70_2, iter_70_3 in pairs(var_70_0) do
						if iter_70_3 == arg_70_3 - 1 or iter_70_3 == arg_70_3 + 41 or iter_70_3 == arg_70_3 + 40 or iter_70_3 == arg_70_3 + 19 then
							var_70_2 = var_70_2 + 1
						end
					end
				end

				if var_70_0 and next(var_70_0) then
					for iter_70_4, iter_70_5 in pairs(var_70_0) do
						if iter_70_5 == arg_70_3 - 20 or iter_70_5 == arg_70_3 - 19 or iter_70_5 == arg_70_3 + 2 or iter_70_5 == arg_70_3 + 22 then
							var_70_3 = var_70_3 + 1
						end
					end
				end

				if var_70_3 < var_70_2 then
					if not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_1 - 20) then
						arg_70_2 = arg_70_1 - 20

						return arg_70_1 - 20
					elseif self:__have_data(var_70_0, arg_70_3 + 41) and self:__have_data(var_70_0, arg_70_3 + 40) and self:__have_data(var_70_0, arg_70_3 + 19) and self:__have_data(var_70_0, arg_70_3 - 1) then
						arg_70_2 = arg_70_1 + 1

						if not self:__have_data(var_70_0, arg_70_1 + 1) then
							return arg_70_2
						end
					end
				end
			elseif arg_70_4.x > arg_70_5.x and arg_70_4.y < arg_70_5.y then
				local var_70_6, var_70_7 = self:_left_have_is_lands(arg_70_3)

				if var_70_6 then
					if var_70_0 and next(var_70_0) then
						for iter_70_6, iter_70_7 in pairs(var_70_0) do
							if iter_70_7 == arg_70_3 - 20 or iter_70_7 == arg_70_3 - 19 then
								var_70_3 = var_70_3 + 1
							end
						end

						if var_70_7 == arg_70_3 - 20 or var_70_7 == arg_70_3 - 19 then
							var_70_3 = var_70_3 + 1
						end
					end

					if var_70_3 >= 2 then
						arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

						if not self:__have_data(var_70_0, arg_70_2) then
							return arg_70_2
						end
					end
				else
					if var_70_0 and next(var_70_0) then
						for iter_70_8, iter_70_9 in pairs(var_70_0) do
							if iter_70_9 == arg_70_3 + 2 or iter_70_9 == arg_70_3 + 2 or iter_70_9 == arg_70_3 + 2 or iter_70_9 == arg_70_3 + 2 then
								var_70_2 = var_70_2 + 1
							end
						end
					end

					if var_70_0 and next(var_70_0) then
						for iter_70_10, iter_70_11 in pairs(var_70_0) do
							if iter_70_11 == arg_70_3 - 20 or iter_70_11 == arg_70_3 - 19 or iter_70_11 == arg_70_3 + 2 or iter_70_11 == arg_70_3 + 2 then
								var_70_3 = var_70_3 + 1
							end
						end
					end

					if var_70_3 < var_70_2 then
						arg_70_2 = arg_70_1 + 20

						return arg_70_1 + 20
					end
				end
			elseif arg_70_4.x < var_70_4.x and arg_70_4.y > var_70_4.y then
				local var_70_8, var_70_9 = self:_left_have_is_lands(arg_70_3)

				if var_70_8 then
					if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) and var_70_9 ~= arg_70_1 - 20 then
						arg_70_2 = arg_70_1 - 20

						return arg_70_1 - 20
					end

					if var_70_0 and next(var_70_0) then
						for iter_70_12, iter_70_13 in pairs(var_70_0) do
							if iter_70_13 == arg_70_3 - 1 or iter_70_13 == arg_70_3 + 19 then
								var_70_3 = var_70_3 + 1
							end
						end

						if var_70_3 >= 2 then
							arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

							if not self:__have_data(var_70_0, arg_70_2) then
								return arg_70_2
							else
								local var_70_10 = false

								if not self:__have_data(var_70_0, arg_70_3 - 20) and arg_70_3 - 20 ~= var_70_9 then
									var_70_10 = true
								elseif not self:__have_data(var_70_0, arg_70_3 - 19) and arg_70_3 - 19 ~= var_70_9 then
									var_70_10 = true
								elseif not self:__have_data(var_70_0, arg_70_3 + 2) and arg_70_3 + 2 ~= var_70_9 then
									var_70_10 = true
								elseif not self:__have_data(var_70_0, arg_70_3 - 22) and arg_70_3 - 22 ~= var_70_9 then
									var_70_10 = true
								end

								if var_70_10 then
									arg_70_2 = arg_70_1 + 1

									if not self:__have_data(var_70_0, arg_70_1 + 1) then
										return arg_70_2
									end
								end
							end
						end
					end
				else
					if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) then
						arg_70_2 = arg_70_1 - 20

						return arg_70_1 - 20
					end

					if var_70_0 and next(var_70_0) then
						for iter_70_14, iter_70_15 in pairs(var_70_0) do
							if iter_70_15 == arg_70_3 - 20 or iter_70_15 == arg_70_3 - 19 or iter_70_15 == arg_70_3 - 1 or iter_70_15 == arg_70_3 + 19 then
								var_70_3 = var_70_3 + 1
							end
						end

						if var_70_3 >= 2 then
							arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

							if not self:__have_data(var_70_0, arg_70_2) then
								return arg_70_2
							end
						end
					end
				end
			elseif arg_70_4.x == var_70_4.x then
				if arg_70_4.y > var_70_4.y or arg_70_4.y < var_70_4.y then
					if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) then
						arg_70_2 = arg_70_1 - 20

						return arg_70_1 - 20
					end

					if self:__have_data(arg_70_6, arg_70_1 + 20) and not self:__have_data(var_70_0, arg_70_1 + 20) then
						arg_70_2 = arg_70_1 + 20

						return arg_70_1 + 20
					end

					if var_70_0 and next(var_70_0) then
						for iter_70_16, iter_70_17 in pairs(var_70_0) do
							if iter_70_17 == arg_70_3 - 20 or iter_70_17 == arg_70_3 - 19 or iter_70_17 == arg_70_3 - 1 or iter_70_17 == arg_70_3 + 19 then
								var_70_3 = var_70_3 + 1
							end
						end

						if var_70_3 >= 2 then
							arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

							if not self:__have_data(var_70_0, arg_70_2) then
								return arg_70_2
							else
								local var_70_11 = false

								if not self:__have_data(var_70_0, arg_70_3 - 20) and arg_70_3 - 20 ~= is_land_num then
									var_70_11 = true
								elseif not self:__have_data(var_70_0, arg_70_3 - 19) and arg_70_3 - 19 ~= is_land_num then
									var_70_11 = true
								elseif not self:__have_data(var_70_0, arg_70_3 + 2) and arg_70_3 + 2 ~= is_land_num then
									var_70_11 = true
								elseif not self:__have_data(var_70_0, arg_70_3 - 22) and arg_70_3 - 22 ~= is_land_num then
									var_70_11 = true
								end

								if var_70_11 then
									arg_70_2 = arg_70_1 + 1

									if not self:__have_data(var_70_0, arg_70_1 + 1) then
										return arg_70_2
									end
								end
							end
						end
					end
				end
			elseif arg_70_4.y == var_70_4.y and arg_70_4.x > var_70_4.x then
				local var_70_12 = 0

				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_1 - 20) then
					arg_70_2 = arg_70_1 - 20

					return arg_70_1 - 20
				end

				for iter_70_18, iter_70_19 in pairs(var_70_0) do
					if iter_70_19 == arg_70_3 + 40 or iter_70_19 == arg_70_3 + 41 or iter_70_19 == arg_70_3 + 19 or iter_70_19 == arg_70_3 - 1 then
						var_70_12 = var_70_12 + 1
					end
				end

				if var_70_12 >= 3 then
					arg_70_2 = arg_70_1 - 20

					if not self:__have_data(var_70_0, arg_70_1 - 20) then
						return arg_70_2
					else
						arg_70_2 = arg_70_1 + 1

						if not self:__have_data(var_70_0, arg_70_1 - 20) then
							return arg_70_2
						end
					end
				end
			elseif arg_70_4.x == var_70_5.x and arg_70_4.y > var_70_5.y then
				local var_70_13 = 0

				if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) then
					arg_70_2 = arg_70_1 - 20

					return arg_70_1 - 20
				end

				for iter_70_20, iter_70_21 in pairs(var_70_0) do
					if iter_70_21 == arg_70_3 + 40 or iter_70_21 == arg_70_3 + 41 or iter_70_21 == arg_70_3 + 19 or iter_70_21 == arg_70_3 - 1 then
						var_70_13 = var_70_13 + 1
					end
				end

				if var_70_13 >= 3 then
					arg_70_2 = arg_70_1 + 1

					if not self:__have_data(var_70_0, arg_70_1 + 1) then
						return arg_70_2
					end
				end
			elseif arg_70_4.x > var_70_5.x and arg_70_4.y >= self:__get_pos_by_rule_num(arg_70_3 + 2).y then
				if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_1 - 20) then
					arg_70_2 = arg_70_1 - 20

					return arg_70_1 - 20
				end

				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				for iter_70_22, iter_70_23 in pairs(var_70_0) do
					if iter_70_23 == arg_70_3 + 40 or iter_70_23 == arg_70_3 + 41 or iter_70_23 == arg_70_3 + 19 or iter_70_23 == arg_70_3 - 1 then
						var_70_3 = var_70_3 + 1
					end
				end

				for iter_70_24, iter_70_25 in pairs(var_70_0) do
					if iter_70_25 == arg_70_3 + 2 or iter_70_25 == arg_70_3 + 22 then
						var_70_2 = var_70_2 + 1
					end
				end

				if var_70_3 <= 3 and var_70_2 == 2 then
					arg_70_2 = arg_70_1 + 20

					if not self:__have_data(var_70_0, arg_70_1 + 20) and not self:__have_data(var_70_1, arg_70_1 + 20) then
						return arg_70_2
					end
				elseif var_70_2 < 2 then
					arg_70_2 = arg_70_1 - 1

					if not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 + 20) then
						return arg_70_2
					end
				else
					arg_70_2 = arg_70_1 - 20

					if not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_1 - 20) then
						return arg_70_2
					end
				end
			end

			if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_1 - 20) then
				arg_70_2 = arg_70_1 - 20

				return arg_70_1 - 20
			end

			if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 - 1) then
				arg_70_2 = arg_70_1 - 1

				return arg_70_1 - 1
			end
		elseif arg_70_2 == arg_70_1 + 1 then
			local var_70_14 = 0

			if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) then
				arg_70_2 = arg_70_1 - 1

				return arg_70_1 - 1
			end

			if self:__have_data(arg_70_6, arg_70_1 + 1) and not self:__have_data(var_70_0, arg_70_1 + 1) then
				arg_70_2 = arg_70_1 + 1

				return arg_70_1 + 1
			end

			if self:__have_data(arg_70_6, arg_70_1 - 20) and not self:__have_data(var_70_0, arg_70_1 - 20) then
				arg_70_2 = arg_70_1 - 20

				return arg_70_1 - 20
			end

			if self:__have_data(arg_70_6, arg_70_1 + 20) and not self:__have_data(var_70_0, arg_70_1 + 20) then
				arg_70_2 = arg_70_1 + 20

				return arg_70_1 + 20
			end

			if self:__have_data(arg_70_6, arg_70_1 - 21) and not self:__have_data(var_70_0, arg_70_1 - 21) then
				if not self:__have_data(var_70_0, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1
				end

				return arg_70_2
			end

			if arg_70_4.x < arg_70_5.x and self:__have_data(arg_70_6, arg_70_1 + 21) and not self:__have_data(var_70_0, arg_70_1 + 21) then
				arg_70_2 = arg_70_1 + 20

				return arg_70_1 + 20
			end

			if var_70_0 and next(var_70_0) then
				for iter_70_26, iter_70_27 in pairs(var_70_0) do
					if arg_70_4.y <= arg_70_5.y then
						if iter_70_27 == arg_70_3 - 1 or iter_70_27 == arg_70_3 + 19 or iter_70_27 == arg_70_3 - 20 or iter_70_27 == arg_70_3 - 19 then
							var_70_14 = var_70_14 + 1
						end
					elseif iter_70_27 == arg_70_3 - 1 or iter_70_27 == arg_70_3 + 19 then
						var_70_14 = var_70_14 + 1
					end
				end

				if arg_70_4.x <= arg_70_5.x then
					if var_70_14 >= 2 then
						arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

						if arg_70_2 == arg_70_3 - 40 and self:__have_data(var_70_0, arg_70_3 - 20) and self:__have_data(var_70_0, arg_70_3 - 19) then
							arg_70_2 = arg_70_1 - 1

							return arg_70_1 - 1
						end
					end
				elseif var_70_14 >= 2 then
					arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 3), false)[1])

					if arg_70_2 == arg_70_3 - 40 and self:__have_data(var_70_0, arg_70_3 - 20) and self:__have_data(var_70_0, arg_70_3 - 19) then
						arg_70_2 = arg_70_1 - 1

						return arg_70_1 - 1
					end
				end
			end
		elseif arg_70_2 - 20 == arg_70_1 then
			local var_70_15 = 0

			if arg_70_4.y > arg_70_5.y and arg_70_4.x > arg_70_5.x then
				if self:__have_data(arg_70_6, arg_70_1 + 20) and not self:__have_data(var_70_0, arg_70_1 + 20) and not self:__have_data(var_70_1, arg_70_1 + 20) then
					arg_70_2 = arg_70_1 + 20

					return arg_70_1 + 20
				end

				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				if self:__have_data(arg_70_6, arg_70_1 + 19) and not self:__have_data(var_70_0, arg_70_1 + 19) and not self:__have_data(var_70_1, arg_70_1 + 19) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				for iter_70_28, iter_70_29 in pairs(var_70_0) do
					if iter_70_29 == arg_70_3 + 40 or iter_70_29 == arg_70_3 + 41 or iter_70_29 == arg_70_3 + 19 or iter_70_29 == arg_70_3 - 1 then
						var_70_15 = var_70_15 + 1
					end
				end

				if var_70_15 >= 3 then
					arg_70_2 = arg_70_1 + 1

					if not self:__have_data(var_70_0, arg_70_1 + 1) and not self:__have_data(var_70_1, arg_70_2) then
						return arg_70_2
					end
				end
			end

			if arg_70_4.y < arg_70_5.y then
				if self:__have_data(arg_70_6, arg_70_1 + 20) and not self:__have_data(var_70_0, arg_70_1 + 20) and not self:__have_data(var_70_1, arg_70_1 + 20) then
					arg_70_2 = arg_70_1 + 20

					return arg_70_1 + 20
				end

				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				if self:__have_data(arg_70_6, arg_70_1 + 20) and not self:__have_data(var_70_0, arg_70_1 + 20) and not self:__have_data(var_70_1, arg_70_1 + 20) then
					arg_70_2 = arg_70_1 + 20

					return arg_70_1 + 20
				end

				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_1 - 1) then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end
			end
		elseif arg_70_2 + 20 == arg_70_1 then
			local var_70_16 = 0
			local var_70_17 = 0
			local var_70_18 = self:__get_pos_by_rule_num(arg_70_3 + 40)
			local var_70_19, var_70_20 = self:_left_have_is_lands(arg_70_3)

			if arg_70_4.x > arg_70_5.x then
				if self:__have_data(arg_70_6, arg_70_1 - 1) and not self:__have_data(var_70_0, arg_70_1 - 1) and var_70_20 ~= arg_70_1 - 1 then
					arg_70_2 = arg_70_1 - 1

					return arg_70_1 - 1
				end

				if var_70_0 and next(var_70_0) then
					for iter_70_30, iter_70_31 in pairs(var_70_0) do
						if iter_70_31 == arg_70_3 - 20 or iter_70_31 == arg_70_3 - 19 then
							var_70_17 = var_70_17 + 1
						end
					end
				end

				if var_70_0 and next(var_70_0) then
					for iter_70_32, iter_70_33 in pairs(var_70_0) do
						if iter_70_33 == arg_70_3 - 1 or iter_70_33 == arg_70_3 + 19 or iter_70_33 == arg_70_3 + 40 or iter_70_33 == arg_70_3 + 41 then
							var_70_16 = var_70_16 + 1
						end
					end
				end

				if false and (var_70_20 == arg_70_3 - 19 or var_70_20 == arg_70_3 - 20) then
					var_70_17 = var_70_17 + 1
				end

				local var_70_21 = 0

				for iter_70_34, iter_70_35 in pairs(var_70_0) do
					if iter_70_35 == arg_70_3 + 2 or iter_70_35 == arg_70_3 + 22 then
						var_70_21 = var_70_21 + 1
					end
				end

				if false and (var_70_20 == arg_70_3 - 19 or var_70_20 == arg_70_3 - 20) then
					var_70_16 = var_70_16 + 1
				end

				if arg_70_4.y > arg_70_5.y and arg_70_4.y <= var_70_18.y and var_70_21 == 2 then
					arg_70_2 = arg_70_1 + 20

					if not self:__have_data(var_70_0, arg_70_1 + 20) and not self:__have_data(var_70_1, arg_70_2) then
						return arg_70_2
					end
				elseif arg_70_4.x > self:__get_pos_by_rule_num(arg_70_3 + 2).x and arg_70_4.y > var_70_18.y and var_70_16 <= 3 then
					arg_70_2 = arg_70_1 - 1

					if not self:__have_data(var_70_0, arg_70_1 - 1) and not self:__have_data(var_70_1, arg_70_2) then
						return arg_70_2
					end
				elseif arg_70_4.y > arg_70_5.y and arg_70_4.y <= var_70_18.y and var_70_21 < 2 then
					arg_70_2 = arg_70_1 - 20

					if not self:__have_data(var_70_0, arg_70_1 - 20) and not self:__have_data(var_70_1, arg_70_2) then
						return arg_70_2
					end
				end

				if var_70_17 >= 2 then
					arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

					if self:__have_data(var_70_0, arg_70_2) then
						return arg_70_2
					end
				end
			elseif arg_70_4.x < arg_70_5.x then
				if self:__have_data(arg_70_6, arg_70_1 + 1) and not self:__have_data(var_70_0, arg_70_1 + 1) and var_70_20 ~= arg_70_1 + 1 then
					arg_70_2 = arg_70_1 + 1

					return arg_70_1 + 1
				end

				if var_70_0 and next(var_70_0) then
					for iter_70_36, iter_70_37 in pairs(var_70_0) do
						if iter_70_37 == arg_70_3 - 1 or iter_70_37 == arg_70_3 + 19 then
							var_70_17 = var_70_17 + 1
						end
					end

					if var_70_17 >= 2 then
						arg_70_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_70_1), self:__get_pos_by_rule_num(arg_70_3 + 41), false)[1])

						if not self:__have_data(var_70_0, arg_70_2) then
							return arg_70_2
						end
					end
				end
			end
		end

		return arg_70_2
	end

	function arg_1_0:__is_not_go_to_next_pos_2(arg_71_1, arg_71_2, arg_71_3, arg_71_4, arg_71_5, arg_71_6)
		local var_71_0 = {}

		for iter_71_0, iter_71_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			if iter_71_1.hp > 0 then
				table.insert(var_71_0, iter_71_1.pos)
			end
		end

		local var_71_1 = self.sea_map_data.support_position

		if arg_71_2 == arg_71_1 - 2 or arg_71_2 == arg_71_1 - 1 then
			local var_71_2 = 0
			local var_71_3 = 0
			local var_71_4 = self:__get_pos_by_rule_num(arg_71_3 + 40)
			local var_71_5 = self:__get_pos_by_rule_num(arg_71_3 + 41)

			if arg_71_4.x > var_71_4.x and arg_71_4.y > var_71_4.y then
				if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) then
					arg_71_2 = arg_71_1 - 20

					return arg_71_1 - 20
				end

				if var_71_0 and next(var_71_0) then
					for iter_71_2, iter_71_3 in pairs(var_71_0) do
						if iter_71_3 == arg_71_3 - 1 or iter_71_3 == arg_71_3 + 41 or iter_71_3 == arg_71_3 + 40 or iter_71_3 == arg_71_3 + 19 then
							var_71_2 = var_71_2 + 1
						end
					end
				end

				if var_71_0 and next(var_71_0) then
					for iter_71_4, iter_71_5 in pairs(var_71_0) do
						if iter_71_5 == arg_71_3 - 20 or iter_71_5 == arg_71_3 - 19 or iter_71_5 == arg_71_3 + 2 or iter_71_5 == arg_71_3 + 22 then
							var_71_3 = var_71_3 + 1
						end
					end
				end

				if var_71_3 < var_71_2 then
					if not self:__have_data(var_71_0, arg_71_1 - 20) and not self:__have_data(var_71_1, arg_71_1 - 20) then
						arg_71_2 = arg_71_1 - 20

						return arg_71_1 - 20
					elseif not self:__have_data(var_71_0, arg_71_1 - 21) and not self:__have_data(var_71_1, arg_71_1 - 21) then
						arg_71_2 = arg_71_1 - 21

						return arg_71_1 - 21
					elseif self:__have_data(var_71_0, arg_71_3 + 41) and self:__have_data(var_71_0, arg_71_3 + 40) and self:__have_data(var_71_0, arg_71_3 + 19) and self:__have_data(var_71_0, arg_71_3 - 1) then
						arg_71_2 = arg_71_1 + 1

						if not self:__have_data(var_71_0, arg_71_1 + 1) then
							return arg_71_2
						end
					end
				end
			elseif arg_71_4.x > arg_71_5.x and arg_71_4.y < arg_71_5.y then
				local var_71_6, var_71_7 = self:_left_have_is_lands(arg_71_3)

				if var_71_6 then
					if var_71_0 and next(var_71_0) then
						for iter_71_6, iter_71_7 in pairs(var_71_0) do
							if iter_71_7 == arg_71_3 - 20 or iter_71_7 == arg_71_3 - 19 then
								var_71_3 = var_71_3 + 1
							end
						end

						if var_71_7 == arg_71_3 - 20 or var_71_7 == arg_71_3 - 19 then
							var_71_3 = var_71_3 + 1
						end
					end

					if var_71_3 >= 2 then
						local var_71_8 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)

						arg_71_2 = var_71_8 and #var_71_8 >= 2 and self:__get_rule_num_by_pos(var_71_8[2]) or self:__get_rule_num_by_pos(var_71_8[1])

						if not self:__have_data(var_71_0, arg_71_2) then
							return arg_71_2
						end
					end
				else
					if var_71_0 and next(var_71_0) then
						for iter_71_8, iter_71_9 in pairs(var_71_0) do
							if iter_71_9 == arg_71_3 + 2 or iter_71_9 == arg_71_3 + 2 or iter_71_9 == arg_71_3 + 2 or iter_71_9 == arg_71_3 + 2 then
								var_71_2 = var_71_2 + 1
							end
						end
					end

					if var_71_0 and next(var_71_0) then
						for iter_71_10, iter_71_11 in pairs(var_71_0) do
							if iter_71_11 == arg_71_3 - 20 or iter_71_11 == arg_71_3 - 19 or iter_71_11 == arg_71_3 + 2 or iter_71_11 == arg_71_3 + 2 then
								var_71_3 = var_71_3 + 1
							end
						end
					end

					if var_71_3 < var_71_2 then
						arg_71_2 = arg_71_1 + 20

						return arg_71_1 + 20
					end
				end
			elseif arg_71_4.x < var_71_4.x and arg_71_4.y > var_71_4.y then
				local var_71_9, var_71_10 = self:_left_have_is_lands(arg_71_3)

				if var_71_9 then
					if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) and var_71_10 ~= arg_71_1 - 20 then
						arg_71_2 = arg_71_1 - 20

						return arg_71_1 - 20
					end

					if var_71_0 and next(var_71_0) then
						for iter_71_12, iter_71_13 in pairs(var_71_0) do
							if iter_71_13 == arg_71_3 - 1 or iter_71_13 == arg_71_3 + 19 then
								var_71_3 = var_71_3 + 1
							end
						end

						if var_71_3 >= 2 then
							arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

							if not self:__have_data(var_71_0, arg_71_2) then
								return arg_71_2
							else
								local var_71_11 = false

								if not self:__have_data(var_71_0, arg_71_3 - 20) and arg_71_3 - 20 ~= var_71_10 then
									var_71_11 = true
								elseif not self:__have_data(var_71_0, arg_71_3 - 19) and arg_71_3 - 19 ~= var_71_10 then
									var_71_11 = true
								elseif not self:__have_data(var_71_0, arg_71_3 + 2) and arg_71_3 + 2 ~= var_71_10 then
									var_71_11 = true
								elseif not self:__have_data(var_71_0, arg_71_3 - 22) and arg_71_3 - 22 ~= var_71_10 then
									var_71_11 = true
								end

								if var_71_11 then
									arg_71_2 = arg_71_1 + 1

									if not self:__have_data(var_71_0, arg_71_1 + 1) then
										return arg_71_2
									end
								end
							end
						end
					end
				else
					if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) then
						arg_71_2 = arg_71_1 - 20

						return arg_71_1 - 20
					end

					if var_71_0 and next(var_71_0) then
						for iter_71_14, iter_71_15 in pairs(var_71_0) do
							if iter_71_15 == arg_71_3 - 20 or iter_71_15 == arg_71_3 - 19 or iter_71_15 == arg_71_3 - 1 or iter_71_15 == arg_71_3 + 19 then
								var_71_3 = var_71_3 + 1
							end
						end

						if var_71_3 >= 2 then
							arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

							if not self:__have_data(var_71_0, arg_71_2) then
								return arg_71_2
							end
						end
					end
				end
			elseif arg_71_4.x == var_71_4.x then
				if arg_71_4.y > var_71_4.y or arg_71_4.y < var_71_4.y then
					if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) then
						arg_71_2 = arg_71_1 - 20

						return arg_71_1 - 20
					end

					if self:__have_data(arg_71_6, arg_71_1 + 20) and not self:__have_data(var_71_0, arg_71_1 + 20) then
						arg_71_2 = arg_71_1 + 20

						return arg_71_1 + 20
					end

					if var_71_0 and next(var_71_0) then
						for iter_71_16, iter_71_17 in pairs(var_71_0) do
							if iter_71_17 == arg_71_3 - 20 or iter_71_17 == arg_71_3 - 19 or iter_71_17 == arg_71_3 - 1 or iter_71_17 == arg_71_3 + 19 then
								var_71_3 = var_71_3 + 1
							end
						end

						if var_71_3 >= 2 then
							arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

							if not self:__have_data(var_71_0, arg_71_2) then
								return arg_71_2
							else
								local var_71_12 = false

								if not self:__have_data(var_71_0, arg_71_3 - 20) and arg_71_3 - 20 ~= is_land_num then
									var_71_12 = true
								elseif not self:__have_data(var_71_0, arg_71_3 - 19) and arg_71_3 - 19 ~= is_land_num then
									var_71_12 = true
								elseif not self:__have_data(var_71_0, arg_71_3 + 2) and arg_71_3 + 2 ~= is_land_num then
									var_71_12 = true
								elseif not self:__have_data(var_71_0, arg_71_3 - 22) and arg_71_3 - 22 ~= is_land_num then
									var_71_12 = true
								end

								if var_71_12 then
									arg_71_2 = arg_71_1 + 1

									if not self:__have_data(var_71_0, arg_71_1 + 1) then
										return arg_71_2
									end
								end
							end
						end
					end
				end
			elseif arg_71_4.y == var_71_4.y and arg_71_4.x > var_71_4.x then
				local var_71_13 = 0

				if self:__have_data(arg_71_6, arg_71_1 - 1) and not self:__have_data(var_71_0, arg_71_1 - 1) then
					arg_71_2 = arg_71_1 - 1

					return arg_71_1 - 1
				end

				if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) and not self:__have_data(var_71_1, arg_71_1 - 20) then
					arg_71_2 = arg_71_1 - 20

					return arg_71_1 - 20
				end

				for iter_71_18, iter_71_19 in pairs(var_71_0) do
					if iter_71_19 == arg_71_3 + 40 or iter_71_19 == arg_71_3 + 41 or iter_71_19 == arg_71_3 + 19 or iter_71_19 == arg_71_3 - 1 then
						var_71_13 = var_71_13 + 1
					end
				end

				if var_71_13 >= 3 then
					arg_71_2 = arg_71_1 - 20

					if not self:__have_data(var_71_0, arg_71_1 - 20) then
						return arg_71_2
					else
						arg_71_2 = arg_71_1 + 1

						if not self:__have_data(var_71_0, arg_71_1 - 20) then
							return arg_71_2
						end
					end
				end
			elseif arg_71_4.x == var_71_5.x and arg_71_4.y > var_71_5.y then
				local var_71_14 = 0

				if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) then
					arg_71_2 = arg_71_1 - 20

					return arg_71_1 - 20
				end

				for iter_71_20, iter_71_21 in pairs(var_71_0) do
					if iter_71_21 == arg_71_3 + 40 or iter_71_21 == arg_71_3 + 41 or iter_71_21 == arg_71_3 + 19 or iter_71_21 == arg_71_3 - 1 then
						var_71_14 = var_71_14 + 1
					end
				end

				if var_71_14 >= 3 then
					arg_71_2 = arg_71_1 + 1

					if not self:__have_data(var_71_0, arg_71_1 + 1) then
						return arg_71_2
					end
				end
			elseif arg_71_4.x > var_71_5.x and arg_71_4.y >= self:__get_pos_by_rule_num(arg_71_3 + 2).y then
				if self:__have_data(arg_71_6, arg_71_1 - 20) and not self:__have_data(var_71_0, arg_71_1 - 20) and not self:__have_data(var_71_1, arg_71_1 - 20) then
					arg_71_2 = arg_71_1 - 20

					return arg_71_1 - 20
				end

				if self:__have_data(arg_71_6, arg_71_1 - 1) and not self:__have_data(var_71_0, arg_71_1 - 1) and not self:__have_data(var_71_1, arg_71_1 - 1) then
					arg_71_2 = arg_71_1 - 1

					return arg_71_1 - 1
				end

				for iter_71_22, iter_71_23 in pairs(var_71_0) do
					if iter_71_23 == arg_71_3 + 40 or iter_71_23 == arg_71_3 + 41 or iter_71_23 == arg_71_3 + 19 or iter_71_23 == arg_71_3 - 1 then
						var_71_3 = var_71_3 + 1
					end
				end

				for iter_71_24, iter_71_25 in pairs(var_71_0) do
					if iter_71_25 == arg_71_3 + 2 or iter_71_25 == arg_71_3 + 22 then
						var_71_2 = var_71_2 + 1
					end
				end

				if var_71_3 <= 3 and var_71_2 == 2 then
					arg_71_2 = arg_71_1 + 20

					if not self:__have_data(var_71_0, arg_71_1 + 20) and not self:__have_data(var_71_1, arg_71_1 + 20) then
						return arg_71_2
					end
				elseif var_71_2 < 2 then
					arg_71_2 = arg_71_1 - 1

					if not self:__have_data(var_71_0, arg_71_1 - 1) and not self:__have_data(var_71_1, arg_71_1 + 20) then
						return arg_71_2
					end
				else
					arg_71_2 = arg_71_1 - 20

					if not self:__have_data(var_71_0, arg_71_1 - 20) and not self:__have_data(var_71_1, arg_71_1 - 20) then
						return arg_71_2
					end
				end
			end
		elseif arg_71_2 == arg_71_1 + 2 or arg_71_2 == arg_71_1 + 1 then
			local var_71_15 = 0
			local var_71_16 = self:__get_pos_by_rule_num(arg_71_3 + 40)
			local var_71_17 = self:__get_pos_by_rule_num(arg_71_3 + 2)

			if self:__have_data(arg_71_6, arg_71_1 - 1) and not self:__have_data(var_71_0, arg_71_1 - 1) then
				arg_71_2 = arg_71_1 - 1

				return arg_71_1 - 1
			end

			if self:__have_data(arg_71_6, arg_71_1 + 1) and not self:__have_data(var_71_0, arg_71_1 + 1) then
				arg_71_2 = arg_71_1 + 1

				return arg_71_1 + 1
			end

			if arg_71_4.x < arg_71_5.x and self:__have_data(arg_71_6, arg_71_1 + 21) and not self:__have_data(var_71_0, arg_71_1 + 21) then
				arg_71_2 = arg_71_1 + 20

				return arg_71_1 + 20
			end

			if var_71_0 and next(var_71_0) then
				for iter_71_26, iter_71_27 in pairs(var_71_0) do
					if arg_71_4.y <= arg_71_5.y then
						if iter_71_27 == arg_71_3 - 1 or iter_71_27 == arg_71_3 + 19 or iter_71_27 == arg_71_3 - 20 or iter_71_27 == arg_71_3 - 19 then
							var_71_15 = var_71_15 + 1
						end
					elseif iter_71_27 == arg_71_3 - 1 or iter_71_27 == arg_71_3 + 19 then
						var_71_15 = var_71_15 + 1
					end
				end

				if var_71_15 >= 2 then
					if arg_71_4.x <= arg_71_5.x then
						local var_71_18 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)

						if #var_71_18 >= 2 then
							arg_71_2 = self:__get_rule_num_by_pos(var_71_18[2])

							if arg_71_2 == arg_71_3 - 40 and self:__have_data(var_71_0, arg_71_3 - 20) and self:__have_data(var_71_0, arg_71_3 - 19) then
								arg_71_2 = arg_71_1 - 1

								return arg_71_1 - 1
							end
						else
							arg_71_2 = self:__get_rule_num_by_pos(var_71_18[1])

							if arg_71_2 == arg_71_3 - 40 and self:__have_data(var_71_0, arg_71_3 - 20) and self:__have_data(var_71_0, arg_71_3 - 19) then
								arg_71_2 = arg_71_1 - 1

								return arg_71_1 - 1
							end
						end
					else
						local var_71_19 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 3), false)

						if #var_71_19 >= 2 then
							arg_71_2 = self:__get_rule_num_by_pos(var_71_19[2])

							if arg_71_2 == arg_71_3 - 40 and self:__have_data(var_71_0, arg_71_3 - 20) and self:__have_data(var_71_0, arg_71_3 - 19) then
								arg_71_2 = arg_71_1 - 1

								return arg_71_1 - 1
							end
						else
							arg_71_2 = self:__get_rule_num_by_pos(var_71_19[1])

							if arg_71_2 == arg_71_3 - 40 and self:__have_data(var_71_0, arg_71_3 - 20) and self:__have_data(var_71_0, arg_71_3 - 19) then
								arg_71_2 = arg_71_1 - 1

								return arg_71_1 - 1
							end
						end
					end
				end
			end
		elseif arg_71_2 - 40 == arg_71_1 or arg_71_2 - 20 == arg_71_1 then
			local var_71_20 = 0

			if arg_71_4.y > arg_71_5.y and arg_71_4.x > arg_71_5.x then
				if self:__have_data(arg_71_6, arg_71_1 + 20) and not self:__have_data(var_71_0, arg_71_1 + 20) and not self:__have_data(var_71_1, arg_71_1 + 20) then
					arg_71_2 = arg_71_1 + 20

					return arg_71_1 + 20
				end

				if self:__have_data(arg_71_6, arg_71_1 - 1) and not self:__have_data(var_71_0, arg_71_1 - 1) and not self:__have_data(var_71_1, arg_71_1 - 1) then
					arg_71_2 = arg_71_1 - 1

					return arg_71_1 - 1
				end

				for iter_71_28, iter_71_29 in pairs(var_71_0) do
					if iter_71_29 == arg_71_3 + 40 or iter_71_29 == arg_71_3 + 41 or iter_71_29 == arg_71_3 + 19 or iter_71_29 == arg_71_3 - 1 then
						var_71_20 = var_71_20 + 1
					end
				end

				if var_71_20 >= 3 then
					arg_71_2 = arg_71_1 + 1

					if not self:__have_data(var_71_0, arg_71_1 + 1) and not self:__have_data(var_71_1, arg_71_2) then
						return arg_71_2
					end
				end
			end

			if arg_71_4.y < arg_71_5.y then
				if self:__have_data(arg_71_6, arg_71_1 + 20) and not self:__have_data(var_71_0, arg_71_1 + 20) and not self:__have_data(var_71_1, arg_71_1 + 20) then
					arg_71_2 = arg_71_1 + 20

					return arg_71_1 + 20
				end

				local var_71_21 = self:__is_have_want_to_pos(arg_71_6, var_71_0, var_71_1, arg_71_1, arg_71_2, arg_71_3)

				if self:__have_data(arg_71_6, var_71_21) and not self:__have_data(var_71_0, var_71_21) then
					return var_71_21
				elseif not self:__have_data(var_71_0, var_71_21) then
					return var_71_21
				end
			end
		elseif arg_71_2 + 40 == arg_71_1 or arg_71_2 + 20 == arg_71_1 then
			local var_71_22 = 0
			local var_71_23 = 0
			local var_71_24 = self:__get_pos_by_rule_num(arg_71_3 + 40)
			local var_71_25, var_71_26 = self:_left_have_is_lands(arg_71_3)

			if arg_71_4.x > arg_71_5.x then
				if self:__have_data(arg_71_6, arg_71_1 - 1) and not self:__have_data(var_71_0, arg_71_1 - 1) and var_71_26 ~= arg_71_1 - 1 then
					arg_71_2 = arg_71_1 - 1

					return arg_71_1 - 1
				end

				if var_71_0 and next(var_71_0) then
					for iter_71_30, iter_71_31 in pairs(var_71_0) do
						if iter_71_31 == arg_71_3 - 20 or iter_71_31 == arg_71_3 - 19 then
							var_71_23 = var_71_23 + 1
						end
					end
				end

				if var_71_0 and next(var_71_0) then
					for iter_71_32, iter_71_33 in pairs(var_71_0) do
						if iter_71_33 == arg_71_3 - 1 or iter_71_33 == arg_71_3 + 19 or iter_71_33 == arg_71_3 + 40 or iter_71_33 == arg_71_3 + 41 then
							var_71_22 = var_71_22 + 1
						end
					end
				end

				if var_71_25 and (var_71_26 == arg_71_3 - 19 or var_71_26 == arg_71_3 - 20) then
					var_71_23 = var_71_23 + 1
				end

				local var_71_27 = 0

				for iter_71_34, iter_71_35 in pairs(var_71_0) do
					if iter_71_35 == arg_71_3 + 2 or iter_71_35 == arg_71_3 + 22 then
						var_71_27 = var_71_27 + 1
					end
				end

				if var_71_25 and (var_71_26 == arg_71_3 - 19 or var_71_26 == arg_71_3 - 20) then
					var_71_22 = var_71_22 + 1
				end

				if arg_71_4.y > arg_71_5.y and arg_71_4.y <= var_71_24.y and var_71_27 == 2 then
					arg_71_2 = arg_71_1 + 20

					if not self:__have_data(var_71_0, arg_71_1 + 20) and not self:__have_data(var_71_1, arg_71_2) then
						return arg_71_2
					end
				elseif arg_71_4.x > self:__get_pos_by_rule_num(arg_71_3 + 2).x and arg_71_4.y > var_71_24.y and var_71_22 <= 3 then
					arg_71_2 = arg_71_1 - 1

					if not self:__have_data(var_71_0, arg_71_1 - 1) and not self:__have_data(var_71_1, arg_71_2) then
						return arg_71_2
					end
				elseif arg_71_4.y > arg_71_5.y and arg_71_4.y <= var_71_24.y and var_71_27 < 2 then
					arg_71_2 = arg_71_1 - 20

					if not self:__have_data(var_71_0, arg_71_1 - 20) and not self:__have_data(var_71_1, arg_71_2) then
						return arg_71_2
					end
				end

				if var_71_23 >= 2 then
					arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

					if self:__have_data(var_71_0, arg_71_2) then
						return arg_71_2
					end
				end
			elseif arg_71_4.x < arg_71_5.x then
				if self:__have_data(arg_71_6, arg_71_1 + 1) and not self:__have_data(var_71_0, arg_71_1 + 1) and var_71_26 ~= arg_71_1 + 1 then
					arg_71_2 = arg_71_1 + 1

					return arg_71_1 + 1
				end

				if var_71_0 and next(var_71_0) then
					for iter_71_36, iter_71_37 in pairs(var_71_0) do
						if iter_71_37 == arg_71_3 - 1 or iter_71_37 == arg_71_3 + 19 then
							var_71_23 = var_71_23 + 1
						end
					end

					if var_71_23 >= 2 then
						arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

						if not self:__have_data(var_71_0, arg_71_2) then
							return arg_71_2
						end
					end
				end
			end
		elseif arg_71_2 + 19 == arg_71_1 then
			local var_71_28 = 0

			if arg_71_4.x < arg_71_5.x then
				if self:__have_data(arg_71_6, arg_71_1 - 19) and not self:__have_data(var_71_0, arg_71_1 - 19) then
					arg_71_2 = arg_71_1 - 19

					return arg_71_1 - 19
				elseif self:__have_data(arg_71_6, arg_71_1 - 40) and not self:__have_data(var_71_0, arg_71_1 - 40) then
					arg_71_2 = arg_71_1 - 40

					return arg_71_1 - 40
				elseif self:__have_data(arg_71_6, arg_71_1 + 21) and not self:__have_data(var_71_0, arg_71_1 + 21) then
					arg_71_2 = arg_71_1 + 21

					return arg_71_1 + 21
				elseif self:__have_data(arg_71_6, arg_71_1 - 21) and not self:__have_data(var_71_0, arg_71_1 - 21) then
					arg_71_2 = arg_71_1 - 21

					return arg_71_1 - 21
				elseif self:__have_data(arg_71_6, arg_71_1 - 19) and self:__have_data(var_71_0, arg_71_1 - 19) and var_71_0 and next(var_71_0) then
					for iter_71_38, iter_71_39 in pairs(var_71_0) do
						if iter_71_39 == arg_71_3 - 1 or iter_71_39 == arg_71_3 + 19 then
							var_71_28 = var_71_28 + 1
						end
					end

					if var_71_28 >= 2 then
						arg_71_2 = self:__get_rule_num_by_pos(self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 41), false)[1])

						if not self:__have_data(var_71_0, arg_71_2) then
							return arg_71_2
						end
					elseif not self:__have_data(var_71_0, arg_71_1 - 40) then
						arg_71_2 = arg_71_1 - 40

						return arg_71_1 - 40
					end
				end
			elseif arg_71_4.x > arg_71_5.x and arg_71_4.y > arg_71_5.y then
				if self:__have_data(arg_71_6, arg_71_1 - 40) and not self:__have_data(var_71_0, arg_71_1 - 40) then
					arg_71_2 = arg_71_1 - 40

					return arg_71_1 - 40
				elseif self:__have_data(arg_71_6, arg_71_1 - 19) and not self:__have_data(var_71_0, arg_71_1 - 19) then
					arg_71_2 = arg_71_1 - 19

					return arg_71_1 - 19
				elseif self:__have_data(arg_71_6, arg_71_1 + 21) and not self:__have_data(var_71_0, arg_71_1 + 21) then
					arg_71_2 = arg_71_1 + 21

					return arg_71_1 + 21
				elseif self:__have_data(arg_71_6, arg_71_1 - 21) and not self:__have_data(var_71_0, arg_71_1 - 21) then
					arg_71_2 = arg_71_1 - 21

					return arg_71_1 - 21
				end
			end
		elseif arg_71_2 + 21 == arg_71_1 then
			if arg_71_4.x > arg_71_5.x then
				if self:__have_data(arg_71_6, arg_71_1 - 2) and not self:__have_data(var_71_0, arg_71_1 - 2) then
					arg_71_2 = arg_71_1 - 2

					return arg_71_1 - 2
				end
			elseif self:__have_data(arg_71_6, arg_71_1 - 40) and not self:__have_data(var_71_0, arg_71_1 - 40) and self:__have_data(var_71_1, arg_71_1 - 40) then
				arg_71_2 = arg_71_1 - 40

				return arg_71_1 - 40
			elseif self:__have_data(arg_71_6, arg_71_1 - 21) and not self:__have_data(var_71_0, arg_71_1 - 21) then
				arg_71_2 = arg_71_1 - 21

				return arg_71_1 - 21
			elseif self:__have_data(arg_71_6, arg_71_1 - 19) and not self:__have_data(var_71_0, arg_71_1 - 19) then
				arg_71_2 = arg_71_1 - 19

				return arg_71_1 - 19
			end

			if arg_71_4.y > arg_71_5.y and self:__have_data(arg_71_6, arg_71_3 + 19) and self:__have_data(arg_71_6, arg_71_3 - 1) then
				if not self:__have_data(arg_71_6, arg_71_3 + 3) then
					if self:__have_data(arg_71_6, arg_71_3 + 21) then
						local var_71_32 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 3), false)

						arg_71_2 = #var_71_32 >= 2 and self:__get_rule_num_by_pos(var_71_32[2]) or self:__get_rule_num_by_pos(var_71_32[1])

						if not self:__have_data(var_71_0, arg_71_2) and not self:__have_data(var_71_1, arg_71_2) then
							return arg_71_2
						else
							arg_71_2 = self:__get_rule_num_by_pos(var_71_32[1])

							if not self:__have_data(var_71_1, arg_71_2) then
								return arg_71_2
							end
						end

						goto label_71_0
					end

					if arg_71_2 - 19 == arg_71_1 then
						if self:__have_data(arg_71_6, arg_71_1 - 40) and not self:__have_data(var_71_0, arg_71_1 - 40) and self:__have_data(var_71_1, arg_71_1 - 40) then
							arg_71_2 = arg_71_1 - 40

							return arg_71_1 - 40
						elseif self:__have_data(arg_71_6, arg_71_1 - 21) and not self:__have_data(var_71_0, arg_71_1 - 21) then
							arg_71_2 = arg_71_1 - 21

							return arg_71_1 - 21
						elseif self:__have_data(arg_71_6, arg_71_1 - 19) and not self:__have_data(var_71_0, arg_71_1 - 19) then
							arg_71_2 = arg_71_1 - 19

							return arg_71_1 - 19
						end
					elseif arg_71_2 - 21 == arg_71_1 and arg_71_4.x < arg_71_5.x then
						if self:__have_data(arg_71_6, arg_71_1 + 19) and not self:__have_data(var_71_0, arg_71_1 + 19) then
							arg_71_2 = arg_71_1 + 19

							return arg_71_1 + 19
						elseif self:__have_data(arg_71_6, arg_71_1 + 21) and not self:__have_data(var_71_0, arg_71_1 + 21) then
							arg_71_2 = arg_71_1 + 19

							return arg_71_1 + 19
						elseif self:__have_data(var_71_0, arg_71_3 - 1) and self:__have_data(var_71_0, arg_71_3 + 19) then
							if self:__have_data(var_71_0, arg_71_3 - 20) then
								if not self:__have_data(var_71_0, arg_71_3 - 19) then
									local var_71_33 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 3), false)

									arg_71_2 = #var_71_33 >= 2 and self:__get_rule_num_by_pos(var_71_33[2]) or self:__get_rule_num_by_pos(var_71_33[1])

									if not self:__have_data(var_71_0, arg_71_2) and not self:__have_data(var_71_1, arg_71_2) then
										return arg_71_2
									else
										arg_71_2 = self:__get_rule_num_by_pos(var_71_33[1])

										if not self:__have_data(var_71_1, arg_71_2) then
											return arg_71_2
										end
									end
								elseif self:__have_data(var_71_0, arg_71_3 + 20) then
									if not self:__have_data(var_71_0, arg_71_3 + 21) then
										local var_71_34 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_71_1), self:__get_pos_by_rule_num(arg_71_3 + 21), false)

										arg_71_2 = #var_71_34 >= 2 and self:__get_rule_num_by_pos(var_71_34[2]) or self:__get_rule_num_by_pos(var_71_34[1])

										if not self:__have_data(var_71_0, arg_71_2) and not self:__have_data(var_71_1, arg_71_2) then
											return arg_71_2
										else
											arg_71_2 = self:__get_rule_num_by_pos(var_71_34[1])

											if not self:__have_data(var_71_1, arg_71_2) then
												return arg_71_2
											end
										end

										goto label_71_0
									end

									if self:__have_data(arg_71_6, arg_71_1 + 19) and not self:__have_data(var_71_0, arg_71_1 + 19) then
										arg_71_2 = arg_71_1 + 19

										return arg_71_1 + 19
									elseif not self:__have_data(arg_71_6, arg_71_1 + 40) and not self:__have_data(var_71_0, arg_71_1 + 40) then
										arg_71_2 = arg_71_1 + 40

										return arg_71_1 + 40
									end
								end
							end
						end
					end
				end
			end
		end

		::label_71_0::

		return arg_71_2
	end

	function arg_1_0:__is_have_want_to_pos(arg_72_1, arg_72_2, arg_72_3, arg_72_4, arg_72_5, arg_72_6)
		if self:__have_data(arg_72_2, arg_72_6 - 20) and self:__have_data(arg_72_2, arg_72_6 - 19) then
			if not self:__have_data(arg_72_2, arg_72_4 + 21) and not self:__have_data(arg_72_3, arg_72_4 + 21) then
				arg_72_5 = arg_72_4 + 21

				return arg_72_4 + 21
			elseif not self:__have_data(arg_72_2, arg_72_4 + 19) and not self:__have_data(arg_72_3, arg_72_4 + 19) then
				arg_72_5 = arg_72_4 + 19

				return arg_72_4 + 19
			end

			if self:__have_data(arg_72_2, arg_72_6 + 22) and self:__have_data(arg_72_2, arg_72_6 + 2) then
				if not self:__have_data(arg_72_2, arg_72_4 - 2) and not self:__have_data(arg_72_3, arg_72_4 - 2) then
					arg_72_5 = arg_72_4 - 2

					return arg_72_4 - 2
				end
			elseif not self:__have_data(arg_72_2, arg_72_4 + 2) and not self:__have_data(arg_72_3, arg_72_4 + 2) then
				arg_72_5 = arg_72_4 + 2

				return arg_72_4 + 2
			end

			if self:__have_data(arg_72_2, arg_72_6 - 1) and self:__have_data(arg_72_2, arg_72_6 + 19) then
				if not self:__have_data(arg_72_2, arg_72_4 + 2) and not self:__have_data(arg_72_3, arg_72_4 + 2) then
					arg_72_5 = arg_72_4 + 2

					return arg_72_4 + 2
				end
			elseif not self:__have_data(arg_72_2, arg_72_4 - 2) and not self:__have_data(arg_72_3, arg_72_4 - 2) then
				arg_72_5 = arg_72_4 - 2

				return arg_72_4 - 2
			end
		elseif self:__have_data(arg_72_2, arg_72_6 - 1) and self:__have_data(arg_72_2, arg_72_6 + 19) then
			if self:__have_data(arg_72_2, arg_72_6 - 20) then
				if self:__have_data(arg_72_2, arg_72_6 - 19) then
					local var_72_0 = self:__get_player_move_pos_by_a_start(self:__get_pos_by_rule_num(arg_72_4), self:__get_pos_by_rule_num(arg_72_6 + 3), false)

					arg_72_5 = #var_72_0 >= 2 and self:__get_rule_num_by_pos(var_72_0[2]) or self:__get_rule_num_by_pos(var_72_0[1])

					if self:__have_data(arg_72_1, arg_72_4 + 19) and not self:__have_data(arg_72_3, arg_72_4 + 19) and not self:__have_data(arg_72_2, arg_72_5) then
						arg_72_5 = arg_72_4 + 19

						return arg_72_4 + 19
					elseif self:__have_data(arg_72_1, arg_72_4 - 19) and not self:__have_data(arg_72_3, arg_72_4 - 19) and not self:__have_data(arg_72_2, arg_72_5) then
						arg_72_5 = arg_72_4 - 19

						return arg_72_4 - 19
					end

					if not self:__have_data(arg_72_2, arg_72_5) and not self:__have_data(arg_72_3, arg_72_5) then
						return arg_72_5
					else
						arg_72_5 = self:__get_rule_num_by_pos(var_72_0[1])

						if not self:__have_data(arg_72_3, arg_72_5) then
							return arg_72_5
						end
					end
				end

				if self:__have_data(arg_72_1, arg_72_4 + 20) and not self:__have_data(arg_72_2, arg_72_4 + 20) and not self:__have_data(arg_72_3, arg_72_4 + 20) then
					arg_72_5 = arg_72_4 + 20

					return arg_72_4 + 20
				end

				if self:__have_data(arg_72_1, arg_72_4 + 21) and not self:__have_data(arg_72_2, arg_72_4 + 21) and not self:__have_data(arg_72_3, arg_72_4 + 21) then
					arg_72_5 = arg_72_4 + 21

					return arg_72_4 + 21
				end

				if self:__have_data(arg_72_1, arg_72_4 + 40) and not self:__have_data(arg_72_2, arg_72_4 + 40) and not self:__have_data(arg_72_3, arg_72_4 + 40) then
					arg_72_5 = arg_72_4 + 40

					return arg_72_4 + 40
				end

				if self:__have_data(arg_72_1, arg_72_4 + 19) and not self:__have_data(arg_72_2, arg_72_4 + 19) and not self:__have_data(arg_72_3, arg_72_4 + 19) then
					arg_72_5 = arg_72_4 + 19

					return arg_72_4 + 19
				end

				if arg_72_5 == arg_72_4 + 40 and self:__have_data(arg_72_2, arg_72_4 + 40) then
					arg_72_5 = arg_72_4 + 20

					return arg_72_4 + 20
				end
			end
		end

		return arg_72_5
	end

	function arg_1_0:_left_have_is_lands(arg_73_1)
		local var_73_0 = {}
		local var_73_1 = false

		for iter_73_0, iter_73_1 in pairs(self.sea_map_data.island_position) do
			for iter_73_2, iter_73_3 in pairs(iter_73_1) do
				table.insert(var_73_0, iter_73_1[iter_73_2][1])
			end
		end

		for iter_73_4, iter_73_5 in pairs(var_73_0) do
			if iter_73_5 == arg_73_1 - 1 or iter_73_5 == arg_73_1 - 20 or iter_73_5 == arg_73_1 - 19 or iter_73_5 == arg_73_1 + 2 or iter_73_5 == arg_73_1 + 19 or iter_73_5 == arg_73_1 + 22 or iter_73_5 == arg_73_1 + 40 or iter_73_5 == arg_73_1 + 41 then
				var_73_1 = true

				return true, iter_73_5
			end
		end

		return var_73_1
	end

	function arg_1_0:__set_next_pos(arg_74_1, arg_74_2, arg_74_3, arg_74_4, arg_74_5, arg_74_6)
		local var_74_0 = self:__get_pos_by_rule_num(self.sea_map_data.battle_plan_position)
		local var_74_1 = self:__get_pos_by_rule_num(arg_74_1)
		local var_74_2 = {}

		for iter_74_0, iter_74_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			if iter_74_1.hp > 0 then
				table.insert(var_74_2, iter_74_1.pos)
			end
		end

		local var_74_3 = self:__have_all_monster_already_to_target_point(arg_74_4)

		if math.abs(arg_74_1 - arg_74_2) == 20 and not arg_74_6 then
			if var_74_3 and self:__have_data(var_74_3, arg_74_2) then
				if var_74_0.x > var_74_1.x then
					arg_74_2 = arg_74_1 + 1

					if self:__have_data(arg_74_5, arg_74_1 + 1) then
						arg_74_2 = arg_74_1
					end
				elseif var_74_0.x < var_74_1.x then
					arg_74_2 = arg_74_1 - 1

					if self:__have_data(arg_74_5, arg_74_1 - 1) then
						arg_74_2 = arg_74_1
					end
				elseif var_74_0.x == var_74_1.x then
					if var_74_0.y < var_74_1.y then
						if not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 1) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 19) then
							arg_74_2 = arg_74_1 - 1
						elseif not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 2) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 22) then
							arg_74_2 = arg_74_1 + 1
						end
					elseif var_74_0.y > var_74_1.y then
						if not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 1) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 19) then
							arg_74_2 = arg_74_1 - 1
						elseif not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 2) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position + 22) then
							arg_74_2 = arg_74_1 + 1
						end
					end
				end
			end
		elseif math.abs(arg_74_1 - arg_74_2) == 1 and var_74_3 and self:__have_data(var_74_3, arg_74_2) then
			if var_74_0.y > var_74_1.y then
				arg_74_2 = arg_74_1 + 20

				if self:__have_data(arg_74_5, arg_74_1 + 20) then
					arg_74_2 = arg_74_1
				end
			elseif var_74_0.y < var_74_1.y then
				if var_74_0.x > var_74_1.x then
					arg_74_2 = arg_74_1 - 20

					if self:__have_data(arg_74_5, arg_74_1 - 20) then
						arg_74_2 = arg_74_1
					end
				else
					arg_74_2 = arg_74_1 - 1

					if self:__have_data(var_74_2, arg_74_1 - 1) and self:__have_data(arg_74_4, arg_74_2) then
						arg_74_2 = arg_74_1 + 20
					elseif self:__have_data(arg_74_5, arg_74_2) then
						arg_74_2 = arg_74_1
					end
				end
			elseif var_74_0.y == var_74_1.y then
				if var_74_0.x > var_74_1.x then
					if not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 20) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 19) then
						arg_74_2 = arg_74_1 - 20

						if self:__have_data(arg_74_5, arg_74_1 - 20) then
							arg_74_2 = arg_74_1
						end
					end
				elseif var_74_0.x < var_74_1.x then
					if not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 20) or not self:__have_data(var_74_2, self.sea_map_data.battle_plan_position - 19) then
						arg_74_2 = arg_74_1 - 20

						if self:__have_data(arg_74_5, arg_74_1 - 20) then
							arg_74_2 = arg_74_1
						end
					end
				elseif var_74_0.x == var_74_1.x then
					-- block empty
				end
			end
		end

		return arg_74_2
	end

	function arg_1_0:__have_monster_to_plan(arg_75_1)
		local var_75_0 = {}

		for iter_75_0, iter_75_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			if iter_75_1.hp > 0 then
				table.insert(var_75_0, iter_75_1.pos)
			end
		end

		local var_75_1 = 0

		for iter_75_2, iter_75_3 in pairs(var_75_0) do
			if iter_75_3 == arg_75_1 - 1 or iter_75_3 == arg_75_1 - 19 or iter_75_3 == arg_75_1 - 20 or iter_75_3 == arg_75_1 + 2 or iter_75_3 == arg_75_1 + 41 or iter_75_3 == arg_75_1 + 22 or iter_75_3 == arg_75_1 + 40 or iter_75_3 == arg_75_1 + 19 then
				var_75_1 = var_75_1 + 1
			end
		end

		return var_75_1
	end

	function arg_1_0.__have_data(arg_76_0, arg_76_1, arg_76_2)
		if arg_76_1 and next(arg_76_1) then
			for iter_76_0, iter_76_1 in pairs(arg_76_1) do
				if iter_76_1 == arg_76_2 then
					return true
				end
			end
		end

		return false
	end

	function arg_1_0:__set_monster_to_target_point(arg_77_1, arg_77_2, arg_77_3, arg_77_4, arg_77_5)
		if var_0_10.have_data(arg_77_3, arg_77_2) then
			return
		end

		local var_77_0 = self:__have_all_monster_already_to_target_point(arg_77_3)
		local var_77_1 = {}
		local var_77_2 = {}
		local var_77_3 = {}

		if var_77_0 and next(var_77_0) then
			for iter_77_0, iter_77_1 in pairs(arg_77_3) do
				for iter_77_2, iter_77_3 in pairs(var_77_0) do
					if iter_77_1 == iter_77_3 then
						table.remove(arg_77_3, iter_77_0)
					end
				end
			end

			for iter_77_4, iter_77_5 in pairs(self.sea_map_data.island_position) do
				for iter_77_6, iter_77_7 in pairs(iter_77_5) do
					table.insert(var_77_1, iter_77_5[iter_77_6][1])
				end
			end

			for iter_77_8, iter_77_9 in pairs(var_77_1) do
				for iter_77_10, iter_77_11 in pairs(arg_77_3) do
					if iter_77_9 == iter_77_11 then
						table.insert(var_77_2, iter_77_11)
					end
				end
			end

			if var_77_2 and next(var_77_2) then
				for iter_77_12, iter_77_13 in pairs(arg_77_3) do
					for iter_77_14, iter_77_15 in pairs(var_77_2) do
						if iter_77_12 == arg_77_1 and iter_77_13 == iter_77_15 then
							arg_77_1 = arg_77_3[#arg_77_3]
						elseif iter_77_12 == arg_77_1 then
							arg_77_1 = iter_77_13

							table.insert(var_77_3, iter_77_13)
						end
					end
				end
			else
				for iter_77_16, iter_77_17 in pairs(arg_77_3) do
					if iter_77_16 == arg_77_1 then
						arg_77_1 = iter_77_17
					end
				end
			end
		else
			for iter_77_18, iter_77_19 in pairs(self.sea_map_data.island_position) do
				for iter_77_20, iter_77_21 in pairs(iter_77_19) do
					table.insert(var_77_1, iter_77_19[iter_77_20][1])
				end
			end

			for iter_77_22, iter_77_23 in pairs(var_77_1) do
				for iter_77_24, iter_77_25 in pairs(arg_77_3) do
					if iter_77_23 == iter_77_25 then
						table.insert(var_77_2, iter_77_25)
					end
				end
			end

			if var_77_2 and next(var_77_2) then
				for iter_77_26, iter_77_27 in pairs(arg_77_3) do
					for iter_77_28, iter_77_29 in pairs(var_77_2) do
						if iter_77_26 == arg_77_1 and iter_77_27 == iter_77_29 then
							if iter_77_29 ~= arg_77_3[#arg_77_3] then
								arg_77_1 = arg_77_3[#arg_77_3]
							end
						elseif iter_77_26 == arg_77_1 then
							arg_77_1 = iter_77_27
						end
					end
				end
			else
				for iter_77_30, iter_77_31 in pairs(arg_77_3) do
					if iter_77_30 == arg_77_1 then
						arg_77_1 = iter_77_31
					end
				end
			end
		end

		return arg_77_1
	end

	function arg_1_0:__have_all_monster_already_to_target_point(arg_78_1)
		local var_78_0 = {}

		for iter_78_0, iter_78_1 in pairs(var_0_4:get_eighth_map_info()[self.map_id].elite) do
			for iter_78_2, iter_78_3 in pairs(arg_78_1) do
				if iter_78_1.pos == iter_78_3 and iter_78_1.hp > 0 then
					table.insert(var_78_0, iter_78_3)
				end
			end
		end

		return var_78_0
	end

	function arg_1_0:__set_now_support_pos_num(arg_79_1, arg_79_2)
		local var_79_0 = self:__get_pos_by_rule_num(arg_79_1)
		local var_79_1 = self:__get_pos_by_rule_num(arg_79_2)

		if arg_79_1 - arg_79_2 > 0 then
			arg_79_1 = var_79_0.x > var_79_1.x and arg_79_1 - 1 or arg_79_1 + 1
		elseif arg_79_1 - arg_79_2 < 0 then
			arg_79_1 = var_79_0.x > var_79_1.x and arg_79_1 - 1 or arg_79_1 + 1
			arg_79_1 = arg_79_1 + 1
		end

		return arg_79_1
	end

	function arg_1_0:__set_normal_anim(arg_80_1, arg_80_2)
		if self._is_move_anim or arg_80_2 then
			self._control.player_role.spray:SetActive(false)

			self._is_move_anim = false

			self:__play_animation(arg_80_1, var_0_11.character_anim_type.normal.name, var_0_11.character_anim_type.normal.loop)
		end
	end

	function arg_1_0:__set_monster_normal_anim(arg_81_1, arg_81_2)
		if arg_81_2 then
			self._control.player_role.spray:SetActive(false)

			self._is_move_anim = false

			self:__play_animation(arg_81_1, var_0_11.character_anim_type.normal.name, var_0_11.character_anim_type.normal.loop)
		end
	end

	function arg_1_0:__set_support_normal_anim(arg_82_1, arg_82_2, arg_82_3)
		if self._is_move_anim or arg_82_2 then
			self._control.player_role.spray:SetActive(false)

			self._is_move_anim = false

			self:__play_animation(arg_82_1, "npc_" .. arg_82_3 .. "_normal", true)
		end
	end

	function arg_1_0:__set_support_attack_anim(arg_83_1, arg_83_2, arg_83_3)
		if self._is_move_anim or arg_83_2 then
			self._control.player_role.spray:SetActive(false)

			self._is_move_anim = false

			self:__play_animation(arg_83_1, "npc_" .. arg_83_3 .. "_attack", false)
		end
	end

	function arg_1_0:__set_player_face(arg_84_1)
		if arg_84_1.x > 0 and self._control.player_role.rectTransform.localScale.x > 0 then
			self._control.player_role.rectTransform.localScale = Vector3(-self._control.player_role.rectTransform.localScale.x, self._control.player_role.rectTransform.localScale.y, self._control.player_role.rectTransform.localScale.z)
		end

		if arg_84_1.x < 0 and self._control.player_role.rectTransform.localScale.x < 0 then
			self._control.player_role.rectTransform.localScale = Vector3(-self._control.player_role.rectTransform.localScale.x, self._control.player_role.rectTransform.localScale.y, self._control.player_role.rectTransform.localScale.z)
		end
	end

	function arg_1_0:__set_monster_face(arg_85_1, arg_85_2)
		if ((self._operational_pos.x > 0 or nil) and self._operational_pos.x + (self:__get_pos_by_rule_num(self.sea_map_data.battle_plan_position + 21).x - self._operational_pos.x)) < arg_85_2.x then
			arg_85_1.enemy_role.rectTransform.localScale = Vector3(-arg_85_1.enemy_role.rectTransform.localScale.x, arg_85_1.enemy_role.rectTransform.localScale.y, 0)
			arg_85_1.enemy_role.monster_buff_list.defense.rectTransform.localScale = Vector3(-arg_85_1.enemy_role.monster_buff_list.defense.rectTransform.localScale.x, arg_85_1.enemy_role.monster_buff_list.defense.rectTransform.localScale.y, 0)
			arg_85_1.enemy_role.monster_buff_list.fast_move.rectTransform.localScale = Vector3(-arg_85_1.enemy_role.monster_buff_list.defense.rectTransform.localScale.x, arg_85_1.enemy_role.monster_buff_list.defense.rectTransform.localScale.y, 0)
		end
	end

	function arg_1_0:__set_support_face(arg_86_1, arg_86_2, arg_86_3)
		if self:__get_pos_by_rule_num(arg_86_3).x > self:__get_pos_by_rule_num(arg_86_2).x then
			arg_86_1.enemy_role.rectTransform.localScale = Vector3(-arg_86_1.enemy_role.rectTransform.localScale.x, arg_86_1.enemy_role.rectTransform.localScale.y, arg_86_1.enemy_role.rectTransform.localScale.z)
			arg_86_1.gunfire_universal.rectTransform.localScale = Vector3(-arg_86_1.enemy_role.rectTransform.localScale.x, arg_86_1.enemy_role.rectTransform.localScale.y, arg_86_1.enemy_role.rectTransform.localScale.z)
		end
	end

	function arg_1_0.__play_animation(arg_87_0, arg_87_1, arg_87_2, arg_87_3)
		if not arg_87_1.skeletonGraphic.AnimationState:Equals(nil) and arg_87_1.skeletonGraphic.SkeletonData:FindAnimation(arg_87_2) then
			arg_87_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_87_2, arg_87_3)
		end
	end

	function arg_1_0.__get_pos_by_rule_num(arg_88_0, arg_88_1)
		local var_88_0 = math.floor(arg_88_1 / 20)

		return Vector3(((arg_88_1 % 20 == 0 and 20 or arg_88_1 % 20) - 1) * 128, var_88_0 * 96), (arg_88_1 % 20 == 0 and 20 or arg_88_1 % 20) - 1 + 1, var_88_0
	end

	function arg_1_0.__get_rule_num_by_pos(arg_89_0, arg_89_1)
		local var_89_0 = math.floor(arg_89_1.x / 128) + 1

		var_89_0 = var_89_0 == 20 and 0 or var_89_0

		return math.floor(arg_89_1.y / 96) * 20 + var_89_0, var_89_0, math.floor(arg_89_1.y / 96)
	end

	function arg_1_0:__rest_child(arg_90_1)
		if arg_90_1.childCount > 0 then
			for iter_90_0 = 1, arg_90_1.childCount do
				self:destroyGameObject(arg_90_1:GetChild(iter_90_0 - 1).gameObject)
			end
		end
	end

	function arg_1_0:__add_to_openlist(arg_91_1, arg_91_2, arg_91_3, arg_91_4, arg_91_5)
		local var_91_0 = var_0_10.little_clone(arg_91_2)
		local var_91_1, var_91_2, var_91_3 = self:__get_next_pos(arg_91_1)

		if var_91_1 and (not self.obstacle_list[var_91_3] or self.obstacle_list[var_91_3].x <= 64 or self.obstacle_list[var_91_3].y <= 64) and not self:__have_point(arg_91_4, arg_91_1) then
			local var_91_4 = {
				parent = var_91_0,
				point = arg_91_1,
				g = var_91_0.g + 1,
				h = self:__ManHattan(arg_91_1, arg_91_5)
			}

			var_91_4.f = var_91_4.g + var_91_4.h

			local var_91_5, var_91_6 = self:__have_point(arg_91_3, arg_91_1)

			if var_91_5 and var_91_6 then
				if var_91_4.f < var_91_5.f then
					arg_91_3[var_91_6] = var_91_4
				end
			else
				table.insert(arg_91_3, var_91_4)
			end
		end
	end

	function arg_1_0:set_position_by_rule()
		local var_92_0 = self._control.empty_bg.rectTransform.anchoredPosition
		local var_92_1 = Vector2(0, 0)
		local var_92_2 = Vector2(-self._control.empty_bg.rectTransform.sizeDelta.x + self.sceen_center_pos.x * 2, -self._control.empty_bg.rectTransform.sizeDelta.y + self.sceen_center_pos.y * 2 + 120)
		local var_92_3 = Vector2(0, 0)

		if self._control.empty_bg.rectTransform.anchoredPosition.x >= var_92_1.x then
			var_92_3 = Vector2(var_92_0.x - var_92_1.x, var_92_3.y)
			var_92_0 = Vector2(var_92_1.x, var_92_0.y)
		end

		if var_92_0.y >= var_92_1.y then
			var_92_3 = Vector2(var_92_3.x, var_92_0.y - var_92_1.y)
			var_92_0 = Vector2(var_92_0.x, var_92_1.y)
		end

		if var_92_0.x <= var_92_2.x then
			var_92_3 = Vector2(var_92_0.x - var_92_2.x, var_92_3.y)
			var_92_0 = Vector2(var_92_2.x, var_92_0.y)
		end

		if var_92_0.y <= var_92_2.y then
			var_92_3 = Vector2(var_92_3.x, var_92_0.y - var_92_2.y)
			var_92_0 = Vector2(var_92_0.x, var_92_2.y)
		end

		self._control.empty_bg.rectTransform.anchoredPosition = var_92_0

		return var_92_3
	end

	function arg_1_0:__get_now_move_pos(arg_93_1, arg_93_2, arg_93_3)
		if arg_93_1 == arg_93_2 then
			self.player_now_num = arg_93_1 - 1

			return arg_93_3
		end

		local var_93_1 = 1
		local var_93_2 = 0

		if arg_93_1 % 20 == self.sea_map_data.ocean_size % 20 then
			var_93_1 = arg_93_1 - 1
			var_93_2 = -1
		elseif arg_93_1 % 20 == 1 then
			var_93_1 = arg_93_1
			var_93_2 = 1
		else
			local var_93_7 = arg_93_1 % 20 == 0 and 20 or arg_93_1 % 20
			local var_93_8 = arg_93_2 % 20 == 0 and 20 or arg_93_2 % 20

			if (arg_93_2 % 20 == 0 and 20 or arg_93_2 % 20) < (arg_93_1 % 20 == 0 and 20 or arg_93_1 % 20) then
				var_93_1 = arg_93_1 - 1
				var_93_2 = -1
			elseif var_93_7 < var_93_8 then
				var_93_1 = arg_93_1 + 1
				var_93_2 = 1
			elseif var_93_7 == var_93_8 then
				if arg_93_1 < arg_93_2 then
					var_93_1 = arg_93_1 + 20
					var_93_2 = 20
				elseif arg_93_2 < arg_93_1 then
					var_93_1 = arg_93_1 - 20
					var_93_2 = -20
				end
			end
		end

		if self._now_move_func then
			if self.obstacle_list[var_93_1] and (self.obstacle_list[var_93_1].x > 64 or self.obstacle_list[var_93_1].y > 64) then
				if math.abs(var_93_2) == 20 then
					var_93_1 = var_93_1 + 1 * var_93_2 / 20 - var_93_2
				end

				if math.abs(var_93_2) == 1 then
					var_93_1 = var_93_1 + 20 * var_93_2 - var_93_2
				end
			end

			if self.obstacle_list[var_93_1] and (self.obstacle_list[var_93_1].x > 64 or self.obstacle_list[var_93_1].y > 64) then
				if math.abs(var_93_2) == 20 then
					var_93_1 = var_93_1 - 1 * var_93_2 / 20 - var_93_2
				end

				if math.abs(var_93_2) == 1 then
					var_93_1 = var_93_1 - 20 * var_93_2 - var_93_2
				end
			end
		else
			while self.obstacle_list[var_93_1] do
				if self.obstacle_list[var_93_1].x <= 64 or self.obstacle_list[var_93_1].y <= 64 then
					break
				end

				var_93_1 = var_93_1 + var_93_2
			end
		end

		self.player_now_num = var_93_1

		return self:__get_pos_by_rule_num(var_93_1) + Vector3(64, 64, 0)
	end

	function arg_1_0.play_animation(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
		local var_94_0 = arg_94_1:GetComponent("SkeletonGraphic")

		if not var_94_0.AnimationState:Equals(nil) then
			var_94_0.AnimationState:SetAnimation(0, arg_94_2, arg_94_3)
		end
	end

	function arg_1_0.__have_point(arg_95_0, arg_95_1, arg_95_2)
		for iter_95_0, iter_95_1 in ipairs(arg_95_1) do
			if iter_95_1.point.x == arg_95_2.x and iter_95_1.point.y == arg_95_2.y then
				return iter_95_1, iter_95_0
			end
		end

		return false
	end

	function arg_1_0:__get_next_pos(arg_96_1)
		local var_96_0 = self:__is_in_map(arg_96_1)
		local var_96_1
		local var_96_2

		if var_96_0 then
			var_96_1 = arg_96_1.x + 20 * arg_96_1.y
			var_96_2 = self:__get_pos_by_rule_num(arg_96_1.x + 20 * arg_96_1.y)
			var_96_2 = Vector2(var_96_2.x, var_96_2.y) + Vector2(64, 64)
		end

		return var_96_0, var_96_2, var_96_1
	end

	function arg_1_0:__set_noentry_area(arg_97_1, arg_97_2, arg_97_3)
		local var_97_0 = Vector2(arg_97_2.x, arg_97_2.y)
		local var_97_2, var_97_3, var_97_4 = self:__get_rule_num_by_pos(var_97_0)
		local var_97_5, var_97_6, var_97_7 = self:__get_rule_num_by_pos(var_97_0 + Vector2(arg_97_3.x, 0))
		local var_97_8, var_97_9, var_97_10 = self:__get_rule_num_by_pos(var_97_0 + Vector2(0, arg_97_3.y))
		local var_97_11, var_97_12, var_97_13 = self:__get_rule_num_by_pos(var_97_0 + Vector2(arg_97_3.x, arg_97_3.y))
		local var_97_14 = math.floor(arg_97_3.x / 128)

		if arg_97_3.x % 128 == 0 then
			var_97_14 = var_97_14 - 1
		end

		local var_97_15 = arg_97_3.x - var_97_14 * 128
		local var_97_16 = math.floor(arg_97_3.y / 96)

		if arg_97_3.y % 96 == 0 then
			var_97_16 = var_97_16 - 1
		end

		local var_97_17 = arg_97_3.y - var_97_16 * 96

		for iter_97_0 = 0, var_97_14 do
			for iter_97_1 = 0, var_97_16 do
				if not self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20] then
					self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20] = {
						x = arg_97_3.x - iter_97_0 * 128 > 128 and 128 or var_97_15,
						y = arg_97_3.y - iter_97_1 * 96 > 96 and 96 or var_97_17,
						num = arg_97_1,
						size = arg_97_3
					}
				else
					local var_97_18 = {
						x = arg_97_3.x - iter_97_0 * 128 > 128 and 128 or var_97_15,
						y = arg_97_3.y - iter_97_1 * 96 > 96 and 96 or var_97_17,
						num = arg_97_1,
						size = arg_97_3
					}
					local var_97_19 = {}

					if self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20].x > var_97_18.x then
						var_97_19.x = self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20].x or var_97_18.x
					end

					if self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20].y > var_97_18.y then
						var_97_19.y = self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20].y or var_97_18.y
					end

					var_97_19.num = arg_97_1
					var_97_19.size = arg_97_3
					self.obstacle_list[arg_97_1 + iter_97_0 + iter_97_1 * 20] = var_97_19
				end
			end
		end
	end

	function arg_1_0.__ManHattan(arg_98_0, arg_98_1, arg_98_2)
		local var_98_0 = math.min(math.abs(arg_98_1.x - arg_98_2.x), math.abs(arg_98_1.y - arg_98_2.y))

		return 14 * var_98_0 + 10 * (math.abs(arg_98_1.x - arg_98_2.x) + math.abs(arg_98_1.y - arg_98_2.y) - 2 * var_98_0)
	end

	function arg_1_0:__update_point_num()
		self._control.point_coin.num.text.text = var_0_4:get_eighth_buff_point()

		local var_99_0 = 0
		local var_99_1 = var_0_4:get_eighth_map_info()

		if var_0_10.have_index(var_99_1[self.map_id], "enemy_buff_id") then
			if var_99_1[self.map_id].enemy_buff_id > 0 then
				var_99_0 = var_0_25.find_object_by_id(var_99_1[self.map_id].enemy_buff_id).buff_level
			end
		else
			var_99_0 = 0
		end

		self._control.enemy_buff_level.enemy_buff_level_txt.text.text = var_0_8:getNowLang("enemy_level")
		self._control.enemy_buff_level.enemy_buff_level_txt_2.text.text = var_99_0
	end

	function arg_1_0:__is_in_map(arg_100_1)
		local var_100_0 = self.sea_map_data.ocean_size
		local var_100_1 = math.ceil(self.sea_map_data.ocean_size / 20) - 1

		if (self.sea_map_data.ocean_size % 20 == 0 and 20 or var_100_0 % 20) < arg_100_1.x then
			return false
		end

		if var_100_1 <= arg_100_1.y then
			return false
		end

		if arg_100_1.x <= 0 then
			return false
		end

		if arg_100_1.y < 0 then
			return false
		end

		return true
	end

	function arg_1_0:__show_award_detail()
		local var_101_0 = var_0_23.find_object_by_id(self.map_id).award[1].id
		local var_101_1 = self:__award_detail_state(var_101_0)

		self._control.cloud_list.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 2
		self._control.map_preview.map_bg.canvas.sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3

		if var_101_1 == var_0_11.reward_type.equipment then
			self:__show_equip_mask(true)

			self._equip_attr = self._equip_attr or self:loadUI("equip_attr")

			self._equip_attr._panel.transform:SetParent(self._panel.transform)
			self._equip_attr:show((var_0_17.find_object_by_cid(var_101_0)))

			if self._equip_attr then
				self._equip_attr._panel.transform:GetComponent("Canvas").sortingOrder = self._panel.transform:GetComponent("Canvas").sortingOrder + 3
			end
		elseif var_101_1 == var_0_11.reward_type.ship then
			var_0_7:createInstance("ship_detail"):show(var_0_11.enter_ship_detail_type.eighth_bootyshop, (var_0_13.find_object_by_cid(var_101_0)))
			self:setVisible(false)
		elseif var_101_1 == var_0_11.reward_type.head_icon then
			-- block empty
		elseif var_101_1 == var_0_11.reward_type.cg then
			var_0_7:createInstance("specificdetails"):show(var_101_0, var_0_11.enter_icon_detail_type.bootyshop_cg)
		elseif var_101_1 == var_0_11.reward_type.item then
			var_0_7:createInstance("specificdetails"):show(var_101_0, var_0_11.enter_icon_detail_type.bootyshop_item)
		end
	end

	function arg_1_0.__award_detail_state(arg_102_0, arg_102_1)
		if arg_102_1 >= 10000000 then
			if arg_102_1 % 100 == 21 then
				return var_0_11.reward_type.equipment
			elseif arg_102_1 % 100 == 11 or arg_102_1 % 100 == 12 or arg_102_1 % 100 == 13 then
				return var_0_11.reward_type.ship
			elseif arg_102_1 % 100 == 61 then
				return var_0_11.reward_type.head_icon
			elseif arg_102_1 % 100 == 71 then
				return var_0_11.reward_type.furniture
			end
		elseif arg_102_1 % 100 == 81 then
			return var_0_11.reward_type.cg
		else
			return var_0_11.reward_type.item
		end
	end

	function arg_1_0:show_self_cover_func(arg_103_1)
		self._control.cover_2:SetActive(arg_103_1)
	end

	function arg_1_0:__finish_special_task(arg_104_1)
		local var_104_0 = var_0_4:get_battle_info()

		if not var_104_0 or not next(var_104_0) then
			return
		end

		if not arg_104_1 then
			return
		end

		if type(arg_104_1) == "number" then
			return
		end

		self._task_num = 0
		self._task_info = {}

		for iter_104_0, iter_104_1 in pairs(arg_104_1) do
			table.insert(self._task_info, iter_104_1)

			self._task_num = self._task_num + 1
		end

		self._control.finish_special_mission_btn.transform:GetComponent("Canvas").sortingOrder = 1000

		local var_104_1 = self:autoKillDOTween(var_0_12.Sequence())

		if self._task_num > 1 then
			self._control.msg_panel:SetActive(true)

			local var_104_2 = self._control.msg_panel.finish_special_mission

			self._control.finish_special_mission_btn:SetActive(true)

			if self._task_num == 2 then
				local var_104_3 = var_0_20.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_104_3.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_104_3.supportfleet_exp
				self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)

				if var_104_3.award > 0 then
					var_104_1:AppendInterval(3)
					var_104_1:AppendCallback(function()
						var_104_2:SetActive(true)

						var_104_2.map_title.text.text = ""
						var_104_2.task_title.text.text = var_104_3.title
						self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.trophy_award)
						var_104_2.coin_num.text.text = var_104_3.award

						var_104_1:Append(var_104_2.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_104_1:Append(var_104_2.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_104_1:AppendInterval(3)
				var_104_1:AppendCallback(function()
					local var_105_0 = var_0_20.find_object_by_id(self._task_info[2])

					var_104_2:SetActive(true)

					var_104_2.map_title.text.text = ""
					var_104_2.task_title.text.text = var_105_0.title
					var_104_2.coin_num.text.text = var_105_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)

					var_104_1:Append(var_104_2.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_104_1:Append(var_104_2.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			elseif self._task_num == 3 then
				local var_104_4 = var_0_20.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_104_4.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_104_4.supportfleet_exp
				self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)

				if var_104_4.award > 0 then
					var_104_1:AppendInterval(3)
					var_104_1:AppendCallback(function()
						var_104_2:SetActive(true)

						var_104_2.map_title.text.text = ""
						var_104_2.task_title.text.text = var_104_4.title
						self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.trophy_award)
						var_104_2.coin_num.text.text = var_104_4.award

						var_104_1:Append(var_104_2.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_104_1:Append(var_104_2.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_104_1:AppendInterval(3)
				var_104_1:AppendCallback(function()
					local var_107_0 = var_0_20.find_object_by_id(self._task_info[2])

					var_104_2:SetActive(true)

					var_104_2.map_title.text.text = ""
					var_104_2.task_title.text.text = var_107_0.title
					var_104_2.coin_num.text.text = var_107_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)

					var_104_1:Append(var_104_2.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_104_1:Append(var_104_2.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
				var_104_1:AppendInterval(3)
				var_104_1:AppendCallback(function()
					local var_108_0 = var_0_20.find_object_by_id(self._task_info[3])

					var_104_2:SetActive(true)

					var_104_2.map_title.text.text = ""
					var_104_2.task_title.text.text = var_108_0.title
					var_104_2.coin_num.text.text = var_108_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)

					var_104_1:Append(var_104_2.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_104_1:Append(var_104_2.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		else
			self._control.msg_panel:SetActive(true)

			local var_104_5 = self._control.msg_panel.finish_special_mission
			local var_104_6 = var_0_20.find_object_by_id(self._task_info[1])

			self._control.msg_panel.finish_special_mission:SetActive(true)

			self._control.msg_panel.finish_special_mission.map_title.text.text = ""
			self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.exp_award)
			self._control.msg_panel.finish_special_mission.task_title.text.text = var_104_6.title
			self._control.msg_panel.finish_special_mission.coin_num.text.text = var_104_6.supportfleet_exp

			var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_104_1:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.finish_special_mission_btn:SetActive(true)

			if var_104_6.award > 0 then
				var_104_1:AppendInterval(3)
				var_104_1:AppendCallback(function()
					var_104_5:SetActive(true)

					var_104_5.map_title.text.text = ""
					var_104_5.task_title.text.text = var_104_6.title
					self._control.award_icon.image.sprite = self:loadSprite(var_0_11.eighth_task_image_type.trophy_award)
					var_104_5.coin_num.text.text = var_104_6.award

					var_104_1:Append(var_104_5.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_104_1:Append(var_104_5.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		end

		var_0_4:clear_open_eighth_panel()
	end

	function arg_1_0:__exit_animation()
		self:__onReset()

		self._panel:GetComponent("Transform").localScale = Vector3(1, 1, 1)

		var_0_7:__remove_from_showing("eighth_sea_map_single")
		var_0_7:__remove_from_showing("eighth_sea_map_support")
		var_0_7:destroyInstance("eighth_sea_map")
		self:show_cover_func(true)
	end

	function arg_1_0:__show_equip_mask(arg_112_1)
		self._control.equip_mask:SetActive(arg_112_1)

		if self._equip_attr then
			self._equip_attr._panel:SetActive(arg_112_1)
		end
	end

	function arg_1_0.show_cover_func(arg_113_0, arg_113_1)
		local var_113_0 = var_0_7:getInstance("cover")

		if var_113_0 then
			var_113_0:setVisible(arg_113_1)
		end
	end

	function arg_1_0:__onReset()
		for iter_114_0, iter_114_1 in ipairs(self._light_seq_list) do
			iter_114_1:Kill()
		end

		self:show_cover_func(true)
		self:__initia_lize()
		self:__rest_child(self._control.enemy_list.transform)
		self:__rest_child(self._control.islands_list.transform)
		self:__rest_child(self._control.exploration_list.transform)
		self:__rest_child(self._control.operational_list.transform)
	end

	function arg_1_0.__onDestroy(arg_115_0)
		arg_115_0._is_init = false
	end

	function arg_1_0.__initia_lize(arg_116_0)
		arg_116_0.sea_map_data = {}
		arg_116_0.obstacle_list = {}
		arg_116_0.map_id = nil
		arg_116_0._light_seq_list = {}
		arg_116_0._is_init = false
		arg_116_0._cloud_parent_list = {}
		arg_116_0.collision_pos = nil
		arg_116_0._is_short_click = false
		arg_116_0.is_input_down = false
		arg_116_0._time = 0
		arg_116_0._can_move = false
		arg_116_0._now_move_num = nil
		arg_116_0._now_move_elite_id = nil
		arg_116_0._uiroot_canvas_rect = var_0_10.get_ui_root_canvas_rect()
		arg_116_0._ui_camera = var_0_10.get_ui_camera()
		arg_116_0._have_support_info = {}
		arg_116_0._have_support = false
		arg_116_0._player_pos = nil
		arg_116_0._support_ctrl = {}
		arg_116_0.target_pos_list = {}
		arg_116_0._support_state = 0
		arg_116_0._operational_pos = nil
		arg_116_0._monster_move = false
		arg_116_0._set_support_pos = false
		arg_116_0._fire_ok = false
		arg_116_0._not_set_support_bg = true
		arg_116_0._hurt_monster_init = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_117_0)
	local var_117_0 = var_0_7:class("eighth_sea_map")

	var_117_0:__initia_lize()

	return var_117_0
end

return var_0_0
