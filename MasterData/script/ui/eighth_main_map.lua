local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_3 = gameconfig.ship_pve_active_config
local var_0_4 = gameconfig.pve_eighth_map_config
local var_0_8 = gameconfig.monster_config
local var_0_9 = gameconfig.monster_formation_config
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.skin_config
local var_0_13 = table.insert
local var_0_15 = DG.Tweening.DOTween
local var_0_16 = string.format
local var_0_17 = gameenum.common_type
local var_0_18 = gamecore.Language
local var_0_19 = gamecore.user
local var_0_20 = UnityEngine.Vector2
local var_0_21 = UnityEngine.Vector3
local var_0_22 = UnityEngine.Quaternion
local var_0_23 = gamecore.UserDataManager
local var_0_24 = gameconfig.pve_eighth_task_config
local var_0_25 = gameconfig.pve_guide_config
local var_0_26 = gameconfig.pve_eighth_level_config
local var_0_27 = gameconfig.ship_cg_config
local var_0_28 = gameconfig.chat_head_config
local var_0_29 = gameconfig.item_config
local var_0_30 = UnityEngine.Input
local var_0_31 = gamecore.util_func
local var_0_32 = UnityEngine.RectTransformUtility
local var_0_33 = gameconfig.ship_rule_config
local var_0_34 = {
	page_end = 3,
	page_first = 1
}
local var_0_35 = {
	hard = "hard",
	normal = "normal"
}
local var_0_36 = {
	346,
	240,
	55,
	-202,
	-346,
	-346
}

gamecore.UILoader:define("eighth_main_map", function(arg_1_0)
	function arg_1_0:show(arg_2_1, arg_2_2)
		self._active_id = arg_2_1

		var_0_17:set_eighth_main_map_is_show(false)
		var_0_19:set_eighth_event_activity_id(arg_2_1)
		var_0_1:__remove_from_showing("seven_sea_map_single")
		var_0_1:__remove_from_showing("eighth_sea_map_single")
		var_0_1:__remove_from_showing("eighth_sea_map_support")
		self:setVisible(true)

		self._pve_active_cfg = var_0_3.find_object_by_id(arg_2_1)
		self._user_data = var_0_19:get_use_info_data()
		self._uiroot_canvas_rect = var_0_31.get_ui_root_canvas_rect()
		self._ui_camera = var_0_31.get_ui_camera()

		self:__init_panel()
		var_0_19:set_to_eighth(true)
		self:__check_if_first_in_and_guide()
	end

	function arg_1_0.__onUpdate(arg_3_0)
		return
	end

	function arg_1_0:__init_panel()
		self._btn_root = self._control.bg.btn_root

		self:__init_language()
		self:__init_data()
		self:__init_map_id_list()
		self:__register_main_map_rotate_event()

		self._is_hard = self:__check_if_open_difficulty_mode()

		self:__init_map_detail_data_list()
	end

	function arg_1_0:__init_data()
		self._map_point_item_table = {
			self._btn_root.eighth_map_point_item_1,
			self._btn_root.eighth_map_point_item_2,
			self._btn_root.eighth_map_point_item_3,
			self._btn_root.eighth_map_point_item_4,
			self._btn_root.eighth_map_point_item_5,
			self._btn_root.eighth_map_point_item_6
		}
		self._map_line_table = {
			self._control.bg.line_root.line_1,
			self._control.bg.line_root.line_2,
			self._control.bg.line_root.line_3,
			self._control.bg.line_root.line_4,
			self._control.bg.line_root.line_5,
			self._control.bg.line_root.line_6
		}
		self._map_point_table = {
			self._control.bg.point_root.point_node_1,
			self._control.bg.point_root.point_node_2,
			self._control.bg.point_root.point_node_3,
			self._control.bg.point_root.point_node_4,
			self._control.bg.point_root.point_node_5,
			self._control.bg.point_root.point_node_6
		}
		self._effect_arrows_table = {
			self._control.bg.effect_root.effect_arrows_1,
			self._control.bg.effect_root.effect_arrows_2,
			self._control.bg.effect_root.effect_arrows_3,
			self._control.bg.effect_root.effect_arrows_4,
			self._control.bg.effect_root.effect_arrows_5,
			self._control.bg.effect_root.effect_arrows_6
		}
		self._effect_node_table = {
			self._control.ui_effect_root.effect_node_1,
			self._control.ui_effect_root.effect_node_2,
			self._control.ui_effect_root.effect_node_3,
			self._control.ui_effect_root.effect_node_4
		}
	end

	function arg_1_0:__init_language()
		self._control.title_text.text.text = self._pve_active_cfg.title
		self._control.main_title.text.text = var_0_18:getNowLang("activityinstruction")
		self._control.prev_text.text.text = var_0_18:getNowLang("ui_new_guide_last")
		self._control.next_text.text.text = var_0_18:getNowLang("ui_new_guide_next")

		self:_play_audio(var_0_17:get_audio_url(var_0_17.common_icon.music_path, self._pve_active_cfg.bgm))
	end

	function arg_1_0.__init_audio_info(arg_7_0)
		control.main.nametimefinish.finishbtn.button.onClick:AddListener(function()
			arg_7_0:_play_into_se(var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.task_goto))
			var_0_19:req_committaskreq(data[index + 1].cid)
			arg_7_0:updata_data()
		end)
	end

	function arg_1_0:__init_map_id_list()
		self._map_id_list.normal = self._pve_active_cfg.levels
		self._map_id_list.hard = self._pve_active_cfg.hardLevels
	end

	function arg_1_0:__init_map_detail_data_list()
		self._all_map_point_obj = {}
		self._all_map_point_control = {}

		local var_10_0 = self._map_id_list.normal
		local var_10_1 = var_0_17.eighth_map_normal_bg_img
		local var_10_2 = var_0_17.eighth_title_normal_bg_img
		local var_10_3, var_10_4 = self:__get_last_pass_point()
		local var_10_5 = var_10_3

		if self._is_hard then
			var_10_0 = self._map_id_list.hard
			var_10_1 = var_0_17.eighth_map_hard_bg_img
			var_10_2 = var_0_17.eighth_title_hard_bg_img
			var_10_5 = var_10_4
		end

		self._now_map_point = var_10_5
		self._control.bg.image.sprite = self:loadSprite(var_10_1)
		self._control.title_bg.image.sprite = self:loadSprite(var_10_2)

		local var_10_6 = 0

		for iter_10_0, iter_10_1 in pairs(var_10_0 or {}) do
			local var_10_7 = var_0_26.find_object_by_id(iter_10_1)

			self._map_line_table[iter_10_0].image:SetNativeSize()

			if var_10_5 < iter_10_1 then
				self._map_point_item_table[iter_10_0].gameObject:SetActive(false)
				self._map_line_table[iter_10_0].gameObject:SetActive(false)
				self._map_point_table[iter_10_0].gameObject:SetActive(false)
				self._effect_arrows_table[iter_10_0].gameObject:SetActive(false)
			else
				var_10_6 = iter_10_0

				self._map_point_item_table[iter_10_0].gameObject:SetActive(true)

				self._map_point_item_table[iter_10_0].rectTransform.anchoredPosition = var_0_20(var_10_7.position[1], -var_10_7.position[2])
				self._map_point_item_table[iter_10_0].title_lab.text.text = "<color=#56F9FF><size=18>" .. var_10_7.title .. "</size></color>"
				self._map_point_item_table[iter_10_0].title_mask.title.text.text = var_10_7.sub_title

				self._map_point_item_table[iter_10_0].title_mask:GetComponent("TextHorizonScroller"):SetText(var_10_7.sub_title)

				self._map_point_item_table[iter_10_0].map_bg.image.sprite = self:loadSprite((var_0_16(var_0_17.eighth_map_point_img, iter_10_1)))

				self._map_point_item_table[iter_10_0].map_bg.image:SetNativeSize()
				self._map_point_item_table[iter_10_0].mask_img.idx_btn.button.onClick:RemoveAllListeners()
				self._map_point_item_table[iter_10_0].mask_img.idx_btn.button.onClick:AddListener(function()
					self:setVisible(false)
					var_0_1:__remove_from_showing("seven_sea_map_single")
					var_0_1:__remove_from_showing("eighth_sea_map_single")

					local var_11_0 = var_0_1:getInstance("eighth_sea_map")

					var_0_19:set_now_eighth_map_id(var_10_7.id)

					if var_11_0 then
						var_11_0:show(var_10_7.id)
						var_11_0:show_cover_func(false)
					else
						local var_11_1 = var_0_1:createInstance("eighth_sea_map")

						var_11_1:show(var_10_7.id)
						var_11_1:show_cover_func(false)
					end

					self._is_setVisible = true

					self:_play_into_se()
					var_0_23:setDataByID("eighth_select_map_info" .. self._active_id .. var_0_19:get_server_name(), var_0_19:get_account_id(), lx.json_encode({
						map_id = var_10_7.id,
						map_idx = iter_10_0
					}))
				end)

				self._all_map_point_control[var_10_7.id] = self._map_point_item_table[iter_10_0]

				self._map_line_table[iter_10_0].gameObject:SetActive(true)
				self._map_point_table[iter_10_0].gameObject:SetActive(true)

				if iter_10_1 == var_10_5 and not var_0_19:is_cur_eighth_pass(iter_10_1) then
					self._effect_arrows_table[iter_10_0].gameObject:SetActive(true)

					self._effect_arrows_table[iter_10_0].rectTransform.anchoredPosition = var_0_20(var_10_7.arrow_position[1], -var_10_7.arrow_position[2])
					self._effect_arrows_table[iter_10_0].rectTransform.localRotation = var_0_22.Euler(0, 0, var_10_7.arrow_position[3])

					self:__play_animation(self._effect_arrows_table[iter_10_0], var_0_17.eighth_ui_effect_name.arrows_name, true)
				else
					self._effect_arrows_table[iter_10_0].gameObject:SetActive(false)
				end

				self._map_line_table[iter_10_0].rectTransform.anchoredPosition = var_0_20(var_10_7.line_position["line_0" .. iter_10_0][1], -var_10_7.line_position["line_0" .. iter_10_0][2])
				self._map_point_table[iter_10_0].rectTransform.anchoredPosition = var_0_20(var_10_7.node_position[1], -var_10_7.node_position[2])
			end
		end

		for iter_10_2 = 1, 4 do
			if self._is_hard then
				self._effect_node_table[iter_10_2].skeletonGraphic.initialSkinName = var_0_17.eighth_node_effect_type[2]
			end

			if not self._effect_node_table[iter_10_2].skeletonGraphic:Equals(nil) then
				self._effect_node_table[iter_10_2].skeletonGraphic:Initialize(true)
			end

			self:__play_animation(self._effect_node_table[iter_10_2], var_0_17.eighth_ui_effect_name.node_name, true)
		end

		self:__init_map_point_info()

		local var_10_9 = 0

		if self._record_map_idx ~= 0 then
			var_10_9 = self._record_map_idx
		end

		if not self._is_setVisible then
			self._map_bg_max_pos = var_0_36[var_10_6]

			if var_10_9 == 0 then
				self:__set_map_position(self._map_bg_max_pos)
			else
				self:__set_map_position(var_0_36[var_10_9])
			end
		else
			self._is_setVisible = false
		end
	end

	function arg_1_0:__init_map_point_info()
		local var_12_0 = var_0_19:get_eighth_map_info()

		self._player_pos = var_0_20(0, 0)

		local var_12_1 = self._uiroot_canvas_rect.rect.width
		local var_12_2 = {}

		for iter_12_0, iter_12_1 in pairs(self._all_map_point_control) do
			if not var_12_0 or not next(var_12_0) then
				iter_12_1.mask_img.sea_map_node.bg_1:SetActive(true)

				return
			end

			local var_12_3 = var_12_0[iter_12_0]

			if not var_12_0[iter_12_0] or not next(var_12_3) then
				iter_12_1.mask_img.sea_map_node.bg_1:SetActive(true)

				return
			end

			local var_12_4 = iter_12_1.mask_img.sea_map_node

			var_12_2[#var_12_2 + 1] = iter_12_1.mask_img.sea_map_node

			self:destroy_obj_child(var_12_4.empty_bg.single_node)
			var_12_4.empty_bg.gameObject:SetActive(true)
			var_12_4.bg_1:SetActive(true)

			if var_12_1 > 1280 then
				var_12_1 = 1280
			end

			local var_12_5 = self:__get_pos_by_rule_num(var_12_3.pos)

			self.sceen_center_pos = var_0_20(var_12_1 / 2, self._uiroot_canvas_rect.rect.height / 2 - ((var_12_1 / self._uiroot_canvas_rect.rect.height > 1.33 and var_12_1 / self._uiroot_canvas_rect.rect.height < 1.34 or nil) and 180))

			var_12_4.empty_bg.player_role.gameObject:SetActive(true)

			var_12_4.empty_bg.player_role.rectTransform.anchoredPosition = self.sceen_center_pos

			local var_12_7 = var_0_20(var_12_5.x, var_12_5.y) + var_0_20(64, 64)

			var_12_4.empty_bg.player_role.rectTransform.anchoredPosition = self.sceen_center_pos
			var_12_4.empty_bg.rectTransform.anchoredPosition = self.sceen_center_pos - var_12_7
			var_12_4.empty_bg.player_role.rectTransform.anchoredPosition = var_12_4.empty_bg.player_role.rectTransform.anchoredPosition - self:set_position_by_rule(self.sceen_center_pos - var_12_7)
			self._player_pos = var_12_4.empty_bg.player_role.rectTransform.anchoredPosition

			local var_12_8 = var_0_19:find_character_by_id(var_0_19:get_use_info_data().secretary)
			local var_12_9 = var_0_10.find_object_by_cid(var_12_8.cid).pic_id

			if var_12_8.skin ~= 0 then
				var_12_9 = var_0_11.find_object_by_cid(var_12_8.skin).icon
			end

			var_12_4.empty_bg.player_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_17.ship_spine, var_12_9, var_12_9))

			local var_12_10 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

			var_12_4.empty_bg.player_role.skeletonGraphic.material.shader = var_12_10
			var_12_4.empty_bg.player_role.shadow.skeletonGraphic.material.shader = var_12_10

			if not var_12_4.empty_bg.player_role.skeletonGraphic:Equals(nil) then
				var_12_4.empty_bg.player_role.skeletonGraphic:Initialize(true)
			end

			if var_12_3.elite and next(var_12_3.elite) then
				for iter_12_2, iter_12_3 in ipairs(var_12_3.elite) do
					local var_12_11 = self:__get_pos_by_rule_num(iter_12_3.pos)

					if self:__check_is_creat(var_12_11) and iter_12_3.state == 1 then
						local var_12_12, var_12_13 = self:loadUIPrefab("eighth_sea_map_single", var_12_4.empty_bg.single_node.transform)

						var_12_12:setVisible(true)

						var_12_12._panel:GetComponent("RectTransform").localScale = var_0_21.one
						var_12_12._panel:GetComponent("RectTransform").anchoredPosition = var_12_11

						var_12_13.enemy_role:SetActive(true)

						local var_12_14 = var_0_8.find_object_by_id((var_0_9.find_object_by_id(iter_12_3.monster) or var_0_9.find_object_by_id(20101002)).formation[1]).pic_id

						var_12_13.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(string.format(var_0_17.ship_spine, var_12_14, var_12_14))

						local var_12_15 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

						var_12_13.enemy_role.skeletonGraphic.material.shader = var_12_15
						var_12_13.enemy_role.shadow.skeletonGraphic.material.shader = var_12_15
						var_12_13.enemy_role.skeletonGraphic.initialSkinName = "default"

						if not var_12_13.enemy_role.skeletonGraphic:Equals(nil) then
							var_12_13.enemy_role.skeletonGraphic:Initialize(true)
						end

						var_12_13.enemy_role.enemy_role_collider:SetActive(false)
						var_12_13.enemy_role.enemy_role_btn:SetActive(false)

						self._map_single_obj_table[#self._map_single_obj_table + 1] = var_12_12
					end
				end
			end

			self:__set_boos_data(iter_12_0, var_12_4.empty_bg.single_node.transform)
			self:__set_island_data(iter_12_0, var_12_4.empty_bg.single_node.transform)
			self:__set_player_operational_pos(iter_12_0, var_12_4.empty_bg.single_node.transform)
		end

		for iter_12_4, iter_12_5 in ipairs(var_12_2) do
			iter_12_5.rectTransform.localScale = var_0_21(0.16, 0.16, 0.16)
		end
	end

	function arg_1_0:__set_boos_data(arg_13_1, arg_13_2)
		local var_13_0 = var_0_4.find_object_by_id(arg_13_1)
		local var_13_1 = self:__get_pos_by_rule_num(var_13_0.boss_position)

		if self:__check_is_creat(var_13_1) then
			local var_13_2, var_13_3 = self:loadUIPrefab("eighth_sea_map_single", arg_13_2)

			var_13_2:setVisible(true)

			var_13_2._panel:GetComponent("RectTransform").localScale = var_0_21.one
			var_13_2._panel:GetComponent("RectTransform").anchoredPosition = var_13_1

			var_13_3.enemy_role:SetActive(true)
			var_13_3.enemy_role.boss_sign:SetActive(true)

			local var_13_4 = var_0_8.find_object_by_id(var_13_0.boss_image).pic_id

			var_13_3.enemy_role.skeletonGraphic.skeletonDataAsset = self:loadSkeletonDataAsset(var_0_16(var_0_17.ship_spine, var_13_4, var_13_4))

			local var_13_5 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

			var_13_3.enemy_role.skeletonGraphic.material.shader = var_13_5
			var_13_3.enemy_role.shadow.skeletonGraphic.material.shader = var_13_5
			var_13_3.enemy_role.skeletonGraphic.initialSkinName = "default"

			var_13_3.enemy_role.enemy_role_collider:SetActive(false)
			var_13_3.enemy_role.enemy_role_btn:SetActive(false)

			if not var_13_3.enemy_role.skeletonGraphic:Equals(nil) then
				var_13_3.enemy_role.skeletonGraphic:Initialize(true)
			end
		end
	end

	function arg_1_0:__set_island_data(arg_14_1, arg_14_2)
		self._all_map_table = {}

		for iter_14_0, iter_14_1 in pairs(var_0_4.find_object_by_id(arg_14_1).island_position) do
			for iter_14_2, iter_14_3 in pairs(iter_14_1) do
				local var_14_0 = string.format(var_0_17.seven_year_sea_map.island, iter_14_2)

				for iter_14_4, iter_14_5 in pairs(iter_14_3) do
					local var_14_1 = self:__get_pos_by_rule_num(iter_14_5)

					if not self:__check_is_creat(var_14_1) then
						break
					end

					local var_14_2, var_14_3 = self:loadUIPrefab("seven_sea_map_single", arg_14_2)

					var_14_2:setVisible(true)

					var_14_2._panel:GetComponent("RectTransform").anchoredPosition = var_14_1
					var_14_2._panel:GetComponent("RectTransform").localScale = var_0_21.one

					var_14_3.islands:SetActive(true)

					var_14_3.islands.image.sprite = self:loadSprite(var_14_0)

					var_14_3.islands.image:SetNativeSize()
					var_14_3.islands.islands_collider:SetActive(false)
					var_14_3.islands.islands_btn:SetActive(false)

					self._all_map_table[iter_14_2] = var_14_2
				end
			end
		end
	end

	function arg_1_0:__set_player_operational_pos(arg_15_1, arg_15_2)
		local var_15_0 = var_0_4.find_object_by_id(arg_15_1).battle_plan_position

		if var_15_0 then
			local var_15_1 = self:__get_pos_by_rule_num(var_15_0)

			if not self:__check_is_creat(var_15_1) then
				return
			end

			local var_15_2, var_15_3 = self:loadUIPrefab("eighth_sea_map_single", arg_15_2)

			var_15_2:setVisible(true)

			var_15_2._panel:GetComponent("RectTransform").anchoredPosition = var_15_1
			var_15_2._panel:GetComponent("RectTransform").localScale = var_0_21.one

			var_15_3.operational_plan_point:SetActive(true)

			var_15_3.operational_plan_point.operational_plan_skeleton.skeletonGraphic.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")
		end
	end

	function arg_1_0:__check_is_creat(arg_16_1)
		if arg_16_1.x >= self._player_pos.x - 700 and arg_16_1.x <= self._player_pos.x + 700 and arg_16_1.y >= self._player_pos.y - 300 and arg_16_1.y <= self._player_pos.y + 500 then
			return true
		end

		return false
	end

	function arg_1_0.__get_pos_by_rule_num(arg_17_0, arg_17_1)
		local var_17_0 = math.floor(arg_17_1 / 20)

		return var_0_21(((arg_17_1 % 20 == 0 and 20 or arg_17_1 % 20) - 1) * 128, var_17_0 * 96), (arg_17_1 % 20 == 0 and 20 or arg_17_1 % 20) - 1 + 1, var_17_0
	end

	function arg_1_0.__play_animation(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
		if not arg_18_1.skeletonGraphic.AnimationState:Equals(nil) and arg_18_1.skeletonGraphic.SkeletonData:FindAnimation(arg_18_2) then
			arg_18_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_18_2, arg_18_3)
		end
	end

	function arg_1_0:set_position_by_rule(arg_19_1)
		local var_19_0 = var_0_20(0, 0)
		local var_19_1 = {
			x = 1280,
			y = 720
		}
		local var_19_2 = var_0_20(-var_19_1.x + self.sceen_center_pos.x * 2, -var_19_1.y + self.sceen_center_pos.y * 2 + 120)
		local var_19_3 = var_0_20(0, 0)

		if arg_19_1.x >= var_19_0.x then
			var_19_3 = var_0_20(arg_19_1.x - var_19_0.x, var_19_3.y)
			arg_19_1 = var_0_20(var_19_0.x, arg_19_1.y)
		end

		if arg_19_1.y >= var_19_0.y then
			var_19_3 = var_0_20(var_19_3.x, arg_19_1.y - var_19_0.y)
			arg_19_1 = var_0_20(arg_19_1.x, var_19_0.y)
		end

		if arg_19_1.x <= var_19_2.x then
			var_19_3 = var_0_20(arg_19_1.x - var_19_2.x, var_19_3.y)
			arg_19_1 = var_0_20(var_19_2.x, arg_19_1.y)
		end

		if arg_19_1.y <= var_19_2.y then
			var_19_3 = var_0_20(var_19_3.x, arg_19_1.y - var_19_2.y)
			arg_19_1 = var_0_20(arg_19_1.x, var_19_2.y)
		end

		return var_19_3
	end

	function arg_1_0:__get_last_pass_point()
		local var_20_0 = var_0_3.find_object_by_id(var_0_33.find_object_by_id(self._rule_id).content.activeId)
		local var_20_1 = var_20_0.map_id
		local var_20_2 = var_20_0.hardLevels[1]

		self._cur_map_id = {
			normal = var_20_0.map_id,
			hard = var_20_0.hardLevels[1]
		}
		self._normal_pass_table = {}
		self._hard_pass_table = {}

		for iter_20_0, iter_20_1 in pairs(self._map_id_list) do
			for iter_20_2, iter_20_3 in pairs(iter_20_1) do
				if var_0_19:is_cur_eighth_pass(iter_20_3) then
					if iter_20_0 == "normal" then
						var_20_1 = iter_20_3
						self._normal_pass_table[#self._normal_pass_table + 1] = iter_20_3
					else
						var_20_2 = iter_20_3
						self._hard_pass_table[#self._hard_pass_table + 1] = iter_20_3
					end
				end
			end
		end

		if var_20_1 ~= var_20_0.map_id or #self._normal_pass_table > 0 then
			var_20_1 = var_20_1 + math.min(1, #var_20_0.levels)
		end

		if var_20_1 ~= var_20_0.hardLevels[1] or #self._hard_pass_table > 0 then
			var_20_2 = var_20_2 + math.min(1, #var_20_0.hardLevels)
		end

		self._cur_map_id = {
			normal = var_20_1,
			hard = var_20_2
		}

		return var_20_1, var_20_2
	end

	function arg_1_0:_change_difficulty_type()
		if self._is_hard then
			self._is_hard = false
			self._difficulty = var_0_35.normal
		else
			self._is_hard = true
			self._difficulty = var_0_35.hard
		end

		var_0_19:set_is_cur_eighth_difficulty_mode(self._difficulty)

		self._is_change_type = true
		self._record_map_idx = self._is_hard == self._record_is_hard and self._record_map_data and self._record_map_data.map_idx or 0

		self:__switch_difficulty_mode_btn_func(self._is_hard, true)
		self:__init_map_detail_data_list()
	end

	function arg_1_0:__check_if_open_difficulty_mode()
		local var_22_0 = var_0_19:is_cur_eighth_pass(self._map_id_list.normal[#self._map_id_list.normal])
		local var_22_1 = false
		local var_22_2 = lx.json_decode((var_0_23:getDataByID("eighth_select_map_info" .. self._active_id .. var_0_19:get_server_name(), (var_0_19:get_account_id()))))

		if var_22_2 then
			self._record_map_data = var_22_2
			self._record_map_id = var_22_2.map_id
			self._record_map_idx = var_22_2.map_idx
			self._record_is_hard = self:__check_is_hard_by_map_id(self._record_map_id)

			if self._record_is_hard ~= var_22_0 then
				var_22_0 = self._record_is_hard
				var_22_1 = true

				self:__switch_difficulty_mode_btn_func(self._record_is_hard, true)
			end
		end

		if var_22_0 then
			self._difficulty = var_0_35.hard

			var_0_19:set_is_cur_eighth_difficulty_mode(self._difficulty)
		else
			self._difficulty = var_0_35.normal

			var_0_19:set_is_cur_eighth_difficulty_mode(self._difficulty)
		end

		if not var_22_1 then
			self:__switch_difficulty_mode_btn_func(var_22_0)
		end

		return var_22_0
	end

	function arg_1_0:__switch_difficulty_mode_btn_func(arg_23_1, arg_23_2)
		self._control.difficulty_mode_btn:SetActive(arg_23_1)

		if arg_23_2 then
			self._control.difficulty_mode_btn:SetActive(true)
		end

		self._control.difficulty_mode_btn.image.sprite = self:loadSprite((self._difficulty == var_0_35.normal or nil) and (var_0_17.seventh_difficulty_mode_btn.hard or var_0_17.seventh_difficulty_mode_btn.normal))

		self._control.difficulty_mode_btn.image:SetNativeSize()
	end

	function arg_1_0:__check_is_hard_by_map_id(arg_24_1)
		for iter_24_0, iter_24_1 in ipairs(self._map_id_list.normal) do
			if iter_24_1 == arg_24_1 then
				return false
			end
		end

		for iter_24_2, iter_24_3 in ipairs(self._map_id_list.hard) do
			if iter_24_3 == arg_24_1 then
				return true
			end
		end

		return 0
	end

	function arg_1_0:__register_main_map_rotate_event()
		local var_25_0 = self._control.bg

		self._control.bg.dragableItem.onBeginDrag:RemoveAllListeners()
		self._control.bg.dragableItem.onBeginDrag:AddListener(function()
			if not self._can_mouse_rotate then
				return
			end

			self._recover_orgin_pos = false

			local var_26_0 = var_0_20()
			local var_26_1, var_26_2 = var_0_32.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_20(var_0_30.mousePosition.x, var_0_30.mousePosition.y), self._ui_camera, nil)

			if var_26_1 then
				self._delta_vector = var_25_0.transform.anchoredPosition - var_26_2
			end
		end)
		self._control.bg.dragableItem.onDrag:RemoveAllListeners()
		self._control.bg.dragableItem.onDrag:AddListener(function()
			if self._can_mouse_rotate then
				local var_27_0 = var_0_20()
				local var_27_1, var_27_2 = var_0_32.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_20(var_0_30.mousePosition.x, var_0_30.mousePosition.y), self._ui_camera, nil)

				if var_27_1 then
					local var_27_3 = (self._delta_vector + var_27_2).x

					if (self._delta_vector + var_27_2).x > 346 then
						var_27_3 = 346
					elseif var_27_3 < self._map_bg_max_pos then
						var_27_3 = self._map_bg_max_pos
					end

					var_25_0.transform.anchoredPosition = var_0_20(var_27_3, 0)
				end
			end
		end)
		self._control.bg.dragableItem.onEndDrag:RemoveAllListeners()
		self._control.bg.dragableItem.onEndDrag:AddListener(function()
			return
		end)
	end

	function arg_1_0:__check_map_position(arg_29_1)
		self._switch_pos = 0
		self._switch_pos = arg_29_1 and self._control.bg.transform.anchoredPosition.x - 244 or self._control.bg.transform.anchoredPosition.x + 244

		if self._switch_pos > 346 then
			self._switch_pos = 346
		elseif self._switch_pos < self._map_bg_max_pos then
			self._switch_pos = self._map_bg_max_pos
		end

		self:__set_map_position()
	end

	function arg_1_0:__set_map_position(arg_30_1)
		local var_30_0 = arg_30_1 or self._switch_pos

		self._can_mouse_rotate = false
		self._control.bg.image.raycastTarget = false

		local var_30_1 = self:autoKillDOTween(var_0_15.Sequence())

		var_30_1:Append(self._control.bg.transform:DOLocalMoveX(var_30_0, 0.1))
		var_30_1:AppendInterval(0.05)
		var_30_1:AppendCallback(function()
			self._can_mouse_rotate = true
			self._switch_pos = 0
			self._control.bg.image.raycastTarget = true
		end)
	end

	function arg_1_0:__set_instructions_info(arg_32_1)
		arg_32_1 = arg_32_1 or 1

		local var_32_0 = var_0_25.find_object_by_guide_id(var_0_3.find_object_by_id(55).guide_id * 100 + arg_32_1)
		local var_32_1 = tonumber(var_0_31.utf8sub(var_32_0.pic_id, 2, 2))

		self._control.page_1.text.text = arg_32_1
		self._control.page_2.text.text = var_0_34.page_end

		self._control.prev:SetActive(arg_32_1 ~= var_0_34.page_first)
		self._control.next:SetActive(arg_32_1 ~= var_0_34.page_end)

		local var_32_2 = app:getSystem():getChannel()

		self._control.main_pic.image.sprite = (var_32_2 == "hm_android_jp" or var_32_2 == "hm_ios_jp") and self:loadSprite(var_0_16(var_0_17.eighth_instructions_pic_jp, var_32_1)) or self:loadSprite(var_0_16(var_0_17.eighth_instructions_pic, var_32_1))
		self._control.content.txt.text.text = var_0_18:convert_rich_text(var_32_0.desc, true)
	end

	function arg_1_0.__init_default_setting(arg_33_0)
		return
	end

	function arg_1_0:_init_special_task_panel_language()
		self._control.special_task_panel.special_task_bg.left.left_title_panel.title_txt.text.text = var_0_18:getNowLang("crrentownstar")
		self._control.task_bg_title_txt.text.text = var_0_18:getNowLang("taskdestitle")
		self._control.task_aim_title_txt.text.text = var_0_18:getNowLang("tasktargettitle")
		self._control.task_reward_title_txt.text.text = var_0_18:getNowLang("taskrewardtitle")
		self._control.task_reward_txt.text.text = var_0_18:getNowLang("taskstar")
	end

	function arg_1_0:__get_real_pos(arg_35_1, arg_35_2, arg_35_3)
		return var_0_20(arg_35_1 / 1280 * self._control.obj_pool_root.rectTransform.rect.width, not arg_35_3 and -1 * arg_35_2 / 960 * self._control.obj_pool_root.rectTransform.rect.height or arg_35_2 / 960 * self._control.obj_pool_root.rectTransform.rect.height)
	end

	function arg_1_0:show_panel_pass()
		local var_36_0 = var_0_19:get_clear_map_reward()

		if not var_36_0 or not next(var_36_0) then
			return
		else
			var_36_0 = var_36_0[1]
		end

		local var_36_1 = var_0_19:get_battle_info().id
		local var_36_2 = var_36_0.type
		local var_36_3 = var_36_0.id

		var_0_13({}, var_36_0)

		local function var_36_4()
			if not var_0_1:getInstance("eighth_main_map") then
				var_0_1:createInstance("eighth_main_map"):show((var_0_19:get_eighth_event_activity_id()))
			end
		end

		self._panel.transform:GetComponent("Canvas").sortingOrder = 500

		local var_36_5 = self:autoKillDOTween(var_0_15.Sequence())

		var_0_13(self._seven_seq_list, var_36_5)

		if var_36_0.type and var_36_0.type ~= nil then
			var_0_1:createInstance("reward_tip"):show_map_pass(var_0_18:getNowLang("ui_activityworldpasstip"), var_0_26.find_object_by_id(var_36_1).sub_title)
			var_36_5:AppendInterval(3.1)
			var_36_5:AppendCallback(function()
				local var_38_0 = var_0_1:createInstance("reward_tip")

				if var_36_2 == var_0_17.reward_type.item then
					local var_38_2 = var_0_29.find_object_by_cid(var_36_3)

					var_38_0:show_map_pass_award(var_0_18:getNowLang("logget"), (var_0_29.find_object_by_cid(var_36_3) and var_0_29.find_object_by_cid(var_36_3).title or " ") .. "*" .. var_36_0.count, true)
				elseif var_36_2 == var_0_17.reward_type.equipment or var_36_2 == var_0_17.reward_type.ship then
					var_0_1:createInstance("new_ship_or_equip"):show(true, var_36_0, var_0_17.enter_get_ship_type.seven_big_map, var_36_4)
				elseif var_36_2 == var_0_17.reward_type.cg then
					var_38_0:show_map_pass_award(var_0_18:getNowLang("logget"), var_0_27.find_object_by_cid(var_36_3).title .. "*" .. var_36_0.count, true)
				elseif var_36_2 == var_0_17.reward_type.head_icon then
					var_38_0:show_by_enter_type(var_0_28.find_object_by_cid(var_36_0.id).icon, var_0_17.enter_get_ship_type.task_award)
				end
			end)
		end

		var_0_19:set_clear_map_reward(nil)
	end

	function arg_1_0:__finish_special_task(arg_39_1)
		if not next(arg_39_1) then
			return
		end

		self._task_num = 0
		self._task_info = {}

		for iter_39_0, iter_39_1 in pairs(arg_39_1) do
			var_0_13(self._task_info, iter_39_1)

			self._task_num = self._task_num + 1
		end

		local var_39_0 = self:autoKillDOTween(var_0_15.Sequence())

		if self._task_num > 1 then
			self._control.msg_panel:SetActive(true)

			local var_39_1 = self._control.msg_panel.finish_special_mission

			self._control.finish_special_mission_btn:SetActive(true)

			if self._task_num == 2 then
				local var_39_2 = var_0_24.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_39_2.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_39_2.supportfleet_exp
				self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)

				if var_39_2.award > 0 then
					var_39_0:AppendInterval(3)
					var_39_0:AppendCallback(function()
						var_39_1:SetActive(true)

						var_39_1.map_title.text.text = ""
						var_39_1.task_title.text.text = var_39_2.title
						self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.trophy_award)
						var_39_1.coin_num.text.text = var_39_2.award

						var_39_0:Append(var_39_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_39_0:Append(var_39_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_39_0:AppendInterval(3)
				var_39_0:AppendCallback(function()
					local var_40_0 = var_0_24.find_object_by_id(self._task_info[2])

					var_39_1:SetActive(true)

					var_39_1.map_title.text.text = ""
					var_39_1.task_title.text.text = var_40_0.title
					var_39_1.coin_num.text.text = var_40_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)

					var_39_0:Append(var_39_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_39_0:Append(var_39_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			elseif self._task_num == 3 then
				local var_39_3 = var_0_24.find_object_by_id(self._task_info[1])

				self._control.msg_panel.finish_special_mission:SetActive(true)

				self._control.msg_panel.finish_special_mission.map_title.text.text = ""
				self._control.msg_panel.finish_special_mission.task_title.text.text = var_39_3.title
				self._control.msg_panel.finish_special_mission.coin_num.text.text = var_39_3.supportfleet_exp
				self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)

				if var_39_3.award > 0 then
					var_39_0:AppendInterval(3)
					var_39_0:AppendCallback(function()
						var_39_1:SetActive(true)

						var_39_1.map_title.text.text = ""
						var_39_1.task_title.text.text = var_39_3.title
						self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.trophy_award)
						var_39_1.coin_num.text.text = var_39_3.award

						var_39_0:Append(var_39_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
						var_39_0:Append(var_39_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
					end)
				end

				var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
				var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				var_39_0:AppendInterval(3)
				var_39_0:AppendCallback(function()
					local var_42_0 = var_0_24.find_object_by_id(self._task_info[2])

					var_39_1:SetActive(true)

					var_39_1.map_title.text.text = ""
					var_39_1.task_title.text.text = var_42_0.title
					var_39_1.coin_num.text.text = var_42_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)

					var_39_0:Append(var_39_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_39_0:Append(var_39_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
				var_39_0:AppendInterval(3)
				var_39_0:AppendCallback(function()
					local var_43_0 = var_0_24.find_object_by_id(self._task_info[3])

					var_39_1:SetActive(true)

					var_39_1.map_title.text.text = ""
					var_39_1.task_title.text.text = var_43_0.title
					var_39_1.coin_num.text.text = var_43_0.supportfleet_exp
					self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)

					var_39_0:Append(var_39_1.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_39_0:Append(var_39_1.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		else
			self._control.msg_panel:SetActive(true)

			local var_39_4 = self._control.msg_panel.finish_special_mission
			local var_39_5 = var_0_24.find_object_by_id(self._task_info[1])

			self._control.msg_panel.finish_special_mission:SetActive(true)

			self._control.msg_panel.finish_special_mission.map_title.text.text = ""
			self._control.msg_panel.finish_special_mission.task_title.text.text = var_39_5.title
			self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.exp_award)
			self._control.msg_panel.finish_special_mission.coin_num.text.text = var_39_5.supportfleet_exp

			var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
			var_39_0:Append(self._control.msg_panel.finish_special_mission.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
			self._control.finish_special_mission_btn:SetActive(true)

			if var_39_5.award > 0 then
				var_39_0:AppendInterval(3)
				var_39_0:AppendCallback(function()
					var_39_4:SetActive(true)

					var_39_4.map_title.text.text = ""
					var_39_4.task_title.text.text = var_39_5.title
					self._control.award_icon.image.sprite = self:loadSprite(var_0_17.eighth_task_image_type.trophy_award)
					var_39_4.coin_num.text.text = var_39_5.award

					var_39_0:Append(var_39_4.transform:DOScaleY(0, 0)):SetEase(DG.Tweening.Ease.Linear)
					var_39_0:Append(var_39_4.transform:DOScaleY(1, 0.5)):SetEase(DG.Tweening.Ease.Linear)
				end)
			end
		end

		var_0_19:clear_open_eighth_panel()
	end

	function arg_1_0:_play_audio(arg_46_1)
		self:playBackgroundMusic(arg_46_1)
	end

	function arg_1_0:_play_into_se(arg_47_1)
		arg_47_1 = arg_47_1 or var_0_17:get_audio_url(var_0_17.common_icon.music_path, var_0_17.open)

		self:playSE(arg_47_1, false)
	end

	function arg_1_0:__check_if_first_in_and_guide()
		if not var_0_19:get_eighth_guide_state() then
			self:__onClick_desc_btn()
			var_0_19:set_is_cur_eighth_difficulty_mode(var_0_35.normal)
		end
	end

	function arg_1_0:destroy_obj_child(arg_49_1)
		for iter_49_0 = 0, arg_49_1.rectTransform.childCount - 1 do
			self:destroyGameObject(arg_49_1.rectTransform:GetChild(iter_49_0).gameObject)
		end
	end

	function arg_1_0:__onReset()
		for iter_50_0, iter_50_1 in ipairs(self._seven_seq_list) do
			iter_50_1:Kill()
		end
	end

	function arg_1_0.__initia_lize(arg_51_0)
		arg_51_0._is_hard = false
		arg_51_0._map_id_list = {
			normal = {},
			hard = {}
		}
		arg_51_0._cur_map_id = {
			hard = 9221,
			normal = 9215
		}
		arg_51_0._rule_id = 28
		arg_51_0._active_id = 0
		arg_51_0._map_point_item_table = {}
		arg_51_0._map_line_table = {}
		arg_51_0._map_point_table = {}
		arg_51_0._effect_arrows_table = {}
		arg_51_0._effect_node_table = {}
		arg_51_0._map_single_obj_table = {}
		arg_51_0._difficulty = var_0_35.normal
		arg_51_0._is_setVisible = false
		arg_51_0._is_change_type = false
		arg_51_0._record_map_data = nil
		arg_51_0._record_map_id = 0
		arg_51_0._record_map_idx = 0
		arg_51_0._record_is_hard = false
		arg_51_0._seven_seq_list = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_52_0)
	local var_52_0 = var_0_1:class("eighth_main_map")

	var_52_0:__initia_lize()

	return var_52_0
end

return var_0_0
