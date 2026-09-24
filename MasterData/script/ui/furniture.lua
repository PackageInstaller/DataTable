local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = string.format
local var_0_3 = UnityEngine.Vector2
local var_0_4 = UnityEngine.Vector3
local var_0_5 = UnityEngine.Color
local var_0_6 = gameenum.common_type
local var_0_7 = Spine.Unity.SkeletonGraphic
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = lan_rand
local var_0_10 = gamecore.dormitory_idea

gamecore.UILoader:define("furniture", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(false)

		local var_2_0 = self:autoKillDOTween(var_0_8.Sequence())

		var_2_0:AppendInterval(0.001)
		var_2_0:AppendCallback(function()
			if self._panel and not self._panel.transform:Equals(nil) then
				self:setVisible(true)
			end
		end)
		self:__init_panel(arg_2_1)
		self:__init_special_type()

		self._furniture_data = arg_2_1
	end

	function arg_1_0:set_furniture_position(arg_4_1, arg_4_2)
		self.grid_x = arg_4_1
		self.grid_y = arg_4_2
		self._control.sort_layer.img.rectTransform.anchoredPosition = var_0_3(arg_4_1 * var_0_6.dormitory_const.room_x_plus + self._config.width * var_0_6.dormitory_const.room_x_plus / 2, arg_4_2 * var_0_6.dormitory_const.room_y_plus)

		if self._data.cid == 10039271 then
			self._control.sort_layer.img.rectTransform.anchoredPosition = var_0_3(arg_4_1 * var_0_6.dormitory_const.room_x_plus + self._config.width * var_0_6.dormitory_const.room_x_plus / 2, arg_4_2 * var_0_6.dormitory_const.room_y_plus - 42)
		end

		self._control.sort_layer2.img.rectTransform.anchoredPosition = var_0_3(arg_4_1 * var_0_6.dormitory_const.room_x_plus + self._config.width * var_0_6.dormitory_const.room_x_plus / 2, arg_4_2 * var_0_6.dormitory_const.room_y_plus)

		if self._data.cid == 10036771 then
			self._control.sort_layer.img.rectTransform.anchoredPosition = var_0_3(arg_4_1 * var_0_6.dormitory_const.room_x_plus + self._config.width * var_0_6.dormitory_const.room_x_plus / 2, arg_4_2 * var_0_6.dormitory_const.room_y_plus - 255)
		end

		local var_4_0 = 0.5
		local var_4_1 = 0

		if self._config.foot_position then
			var_4_0 = self._config.foot_position.x or 0.5

			if not self._config.foot_position.y then
				::label_4_0::

				var_4_1 = 0
			end
		end

		self._spine_pos_delta = var_0_3((var_4_0 - 0.5) * self._control.sort_layer.img.rectTransform.sizeDelta.x, var_4_1 * self._control.sort_layer.img.rectTransform.sizeDelta.y)
		self._foot_position = self._control.sort_layer.img.rectTransform.anchoredPosition + self._spine_pos_delta
		self._control.sort_layer2.spine.rectTransform.anchoredPosition = self._foot_position
		self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position
		self._now_foot_position = self._foot_position
	end

	function arg_1_0:get_furniture_position()
		return self._data.id, self.grid_x, self.grid_y
	end

	function arg_1_0:reset_furniture_position(arg_6_1)
		self._data = arg_6_1

		self:set_furniture_scale(self._data.point.y)
		self:set_furniture_position(self._data.point.x, self._data.point.y)

		self._control.sort_layer.img.rectTransform.localRotation = var_0_4(0, self._data.rotate and 180 or 0, 0)
	end

	function arg_1_0:get_foot_position()
		return self._foot_position
	end

	function arg_1_0:set_furniture_scale(arg_8_1)
		local var_8_0 = var_0_6.dormitory_const.room_scale_const * (1 - 0.1 * (arg_8_1 / var_0_6.dormitory_const.room_ground_y_amount))

		if self._config.furniture_type == var_0_6.furniture_pos_type.ceiling then
			var_8_0 = var_0_6.dormitory_const.room_scale_const
		end

		self._control.sort_layer.img.rectTransform.sizeDelta = self._sprite_size * var_8_0

		if self._config.cid == var_0_6.dormitory_special_furniture_id.race_car_guardrial then
			self._control.sort_layer.img.rectTransform.sizeDelta = self._sprite_size * var_0_6.dormitory_const.room_scale_const
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.combination_slide then
			self._control.sort_layer2.img.rectTransform.sizeDelta = self._sprite_size * var_8_0
		end

		local var_8_1 = false

		for iter_8_0, iter_8_1 in pairs(var_0_6.double_spine_funriture_list) do
			if iter_8_1 == self._config.cid then
				var_8_1 = true
			end
		end

		self._control.sort_layer.spine.rectTransform.localScale = var_0_4(var_8_0, var_8_0, 1)

		if var_8_1 then
			self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(var_8_0, var_8_0, 1)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.old_bike or self._config.cid == var_0_6.dormitory_special_furniture_id.white_galo_car or self._config.cid == var_0_6.dormitory_special_furniture_id.red_galo_car or self._config.cid == var_0_6.dormitory_special_furniture_id.fort_car or self._config.cid == var_0_6.dormitory_special_furniture_id.ordinary_motorcycle or self._config.cid == var_0_6.dormitory_special_furniture_id.hand_car then
			self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(var_8_0, var_8_0, 1)
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.asura_chariot then
			self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(1, 1, 1)
		end

		self._spine_scale = var_8_0

		self:set_common_spine()
	end

	function arg_1_0:toggle_spine(arg_9_1)
		if not self._config then
			return
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.dry_land then
			self._control.sort_layer.spine.canvasGroup.alpha = arg_9_1 and 1 or 0
			self._control.sort_layer.spine.canvasGroup.interactable = arg_9_1
			self._control.sort_layer.spine.canvasGroup.blocksRaycasts = arg_9_1
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.model_assembly_platform or self._config.cid == var_0_6.dormitory_special_furniture_id.painting_table then
			self._control.sort_layer.img.canvasGroup.alpha = 1
			self._control.sort_layer.spine.rectTransform.anchoredPosition = self._foot_position + var_0_3(0, 200)

			self:open_spine(false)

			return
		end

		if self._config.furniture_type == var_0_6.furniture_pos_type.move_forbid then
			return
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.combination_slide then
			self._control.sort_layer2.img.canvasGroup.alpha = 1
		end

		if not self._config.is_animation and not self._config.race_car then
			return
		end

		if (self._config.cid == var_0_6.furniture_special_condition.on_water.rubber_boat_cid or self._config.cid == var_0_6.furniture_special_condition.on_water.water_motorcycle_cid) and self._forbid_anim_flag then
			self._control.sort_layer.img.canvasGroup.alpha = arg_9_1 and 1 or var_0_6.dormitory_const.furniture_editing_icon_alpha
			self._control.sort_layer.spine.canvasGroup.alpha = 0

			if not arg_9_1 then
				self._control.sort_layer.spine.canvasGroup.interactable = arg_9_1
				self._control.sort_layer.spine.canvasGroup.blocksRaycasts = arg_9_1
			end

			return
		end

		if self._config.cid == var_0_6.dormitory_special_furniture_id.galo_giganotus_armor then
			self:update_special_furniture_alpha(false)

			return
		end

		if self._config.cid ~= var_0_6.dormitory_special_furniture_id.cake_display_case then
			self._control.sort_layer.img.canvasGroup.alpha = arg_9_1 and 0 or 1
		end

		self._control.sort_layer.spine.canvasGroup.alpha = arg_9_1 and 1 or 0

		if self._has_spine2 then
			self._control.sort_layer2.spine.canvasGroup.alpha = arg_9_1 and 1 or 0
		end

		self._control.sort_layer.spine.canvasGroup.interactable = arg_9_1
		self._control.sort_layer.spine.canvasGroup.blocksRaycasts = arg_9_1
	end

	function arg_1_0:update_special_furniture_alpha(arg_10_1)
		self._control.sort_layer.img.canvasGroup.alpha = arg_10_1 and 0 or 1
		self._control.sort_layer.spine.canvasGroup.alpha = arg_10_1 and 1 or 0
	end

	function arg_1_0:set_sort_order(arg_11_1)
		self._sort_layer_canvas.sortingOrder = arg_11_1 + 1
		self._sort_layer2_canvas.sortingOrder = self._config.cid == var_0_6.dormitory_special_furniture_id.asura_chariot and self._sort_layer_canvas.sortingOrder - 2 or self._config.cid == var_0_6.dormitory_special_furniture_id.old_bike and self._sort_layer_canvas.sortingOrder - 4 or self._sort_layer_canvas.sortingOrder + 2

		self:set_special_furniture_event(self._config.cid)
	end

	function arg_1_0:get_sort_order()
		return self._sort_layer_canvas.sortingOrder
	end

	function arg_1_0.set_forbid_anim_flag(arg_13_0, arg_13_1)
		arg_13_0._forbid_anim_flag = arg_13_1
	end

	function arg_1_0:get_furniture_sprite_top_pos()
		return self._control.sort_layer.img.rectTransform.anchoredPosition + var_0_3(0, self._control.sort_layer.img.rectTransform.sizeDelta.y)
	end

	function arg_1_0:set_furniture_flip(arg_15_1)
		local var_15_0 = arg_15_1 and 180 or 0

		self._control.sort_layer.img.rectTransform.localRotation = var_0_4(0, arg_15_1 and 180 or 0, 0)

		if not self._config.is_animation then
			return
		end

		self._control.sort_layer.spine.rectTransform.localRotation = var_0_4(0, var_15_0, 0)
	end

	function arg_1_0:set_spine()
		if not self._config.is_animation and not self._config.race_car then
			return
		end

		local var_16_0 = false

		for iter_16_0, iter_16_1 in pairs(var_0_6.double_spine_funriture_list) do
			if iter_16_1 == self._config.cid then
				var_16_0 = true
			end
		end

		local var_16_1
		local var_16_2
		local var_16_3 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		if not var_16_0 then
			var_16_1 = self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, self._config.icon))
			var_16_2 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, self._config.icon))
		else
			var_16_1 = self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2("%sA", self._config.icon)))
			var_16_2 = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2("%sA", self._config.icon)))
			self._has_spine2 = true
			self._furniture_skeleton_graphic2 = self:get_graphic(self._control.sort_layer2.spine, (self:loadSkeletonDataAsset(var_0_2(var_0_6.dormitory_const.furniture_spine_path, var_0_2("%sB", self._config.icon)))))

			if self._config.action_id[1] ~= var_0_6.furniture_action_type.western_style_coffin then
				self._furniture_skeleton_graphic2.material = self:loadMaterial(var_0_2(var_0_6.dormitory_const.furniture_spine_mat_path, var_0_2("%sB", self._config.icon)))
			end

			self._furniture_skeleton_graphic2.startingAnimation = self._default_anim_name

			self._furniture_skeleton_graphic2:Initialize(true)

			if self._furniture_skeleton_graphic2.AnimationState ~= nil then
				self._furniture_skeleton_graphic2.AnimationState:ClearTracks()
				self._furniture_skeleton_graphic2.AnimationState:SetAnimation(0, self._default_anim_name, self._default_anim_state)
			end

			self:open_spine_2(true)
		end

		self._furniture_skeleton_graphic = self:get_graphic(self._control.sort_layer.spine, var_16_1)

		if var_16_2 then
			var_16_2.shader = var_16_3
		end

		if self._config.action_id[1] ~= var_0_6.furniture_action_type.western_style_coffin then
			self._furniture_skeleton_graphic.material = var_16_2
		end

		self._furniture_skeleton_graphic.startingAnimation = self._default_anim_name

		self._furniture_skeleton_graphic:Initialize(true)

		if self._furniture_skeleton_graphic.AnimationState ~= nil then
			self._furniture_skeleton_graphic.AnimationState:ClearTracks()
			self._furniture_skeleton_graphic.AnimationState:SetAnimation(0, self._default_anim_name, self._default_anim_state)
		end

		if self._config.action_id[1] == var_0_6.furniture_action_type.assembly_station then
			self:open_spine(false)
		else
			self:open_spine(true)
		end
	end

	function arg_1_0.get_graphic(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_17_1:GetComponent(typeof(var_0_7))

		if not var_17_0 then
			local var_17_1 = arg_17_1:AddComponent(typeof(var_0_7))

			var_17_0 = arg_17_1:GetComponent(typeof(var_0_7))
		end

		var_17_0.skeletonDataAsset = arg_17_2

		return var_17_0
	end

	function arg_1_0:reset_spine_scale()
		self._control.sort_layer2.spine.rectTransform.localScale = var_0_4(1, 1, 1)
	end

	function arg_1_0:set_furniture_animation(arg_19_1, arg_19_2, arg_19_3)
		if self._furniture_skeleton_graphic then
			self._furniture_skeleton_graphic.AnimationState:SetAnimation(arg_19_1, arg_19_2, arg_19_3)

			if arg_19_2 == "love" then
				local var_19_0 = self:get_pet_name_and_can_anim()

				self._pet_love_action_during_timer[var_19_0] = self._furniture_skeleton_graphic.SkeletonData:FindAnimation(arg_19_2).Duration
				self._pet_love_action_during[var_19_0] = true
				self._is_walk = false
			end
		end

		if self._furniture_skeleton_graphic2 then
			self._furniture_skeleton_graphic2.AnimationState:SetAnimation(arg_19_1, arg_19_2, arg_19_3)
		end
	end

	function arg_1_0:get_spine_position()
		if self._control then
			return self._control.sort_layer.spine.rectTransform.anchoredPosition
		end
	end

	function arg_1_0:set_spine_position(arg_21_1)
		self._control.sort_layer.spine.rectTransform.anchoredPosition = arg_21_1
		self._control.sort_layer2.spine.rectTransform.anchoredPosition = arg_21_1

		if self._config.cid == var_0_6.dormitory_special_furniture_id.asura_chariot then
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = arg_21_1 + var_0_3(13, 13)
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.old_bike then
			self._control.sort_layer2.spine.rectTransform.anchoredPosition = arg_21_1 + var_0_3(-10, 0)
		end
	end

	function arg_1_0:toggle_furniture_collider(arg_22_1)
		if self._control then
			self._control.sort_layer.spine.furniture_collider.gameObject:SetActive(arg_22_1)
		end
	end

	function arg_1_0:open_spine(arg_23_1)
		if next(self._config) and self._config.cid == var_0_6.dormitory_special_furniture_id.cake_display_case then
			self:__set_special_furniture_canvas_data()

			self._control.sort_layer.spine.canvasGroup.interactable = arg_23_1
			self._control.sort_layer.spine.canvasGroup.blocksRaycasts = arg_23_1

			return
		end

		self._control.sort_layer.spine.canvasGroup.alpha = arg_23_1 and 1 or 0
		self._control.sort_layer.spine.canvasGroup.interactable = arg_23_1
		self._control.sort_layer.spine.canvasGroup.blocksRaycasts = arg_23_1
	end

	function arg_1_0:open_spine_2(arg_24_1)
		if self._config.cid == var_0_6.dormitory_special_furniture_id.cake_display_case then
			self._control.sort_layer2.spine.canvasGroup.alpha = 0
			self._control.sort_layer2.spine.canvasGroup.interactable = arg_24_1
			self._control.sort_layer2.spine.canvasGroup.blocksRaycasts = arg_24_1

			return
		end

		self._control.sort_layer2.spine.canvasGroup.alpha = arg_24_1 and 1 or 0
		self._control.sort_layer2.spine.canvasGroup.interactable = arg_24_1
		self._control.sort_layer2.spine.canvasGroup.blocksRaycasts = arg_24_1
	end

	function arg_1_0:__add_mask_component()
		self._control.sort_layer.spine.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Mask))

		self._control.sort_layer.spine:GetComponent(typeof(UnityEngine.UI.Mask)).showMaskGraphic = true
	end

	function arg_1_0:destroy_self()
		self:__reset_seq_list()
		self:destroy()
	end

	function arg_1_0:__init_panel(arg_27_1)
		arg_27_1.config.behavior_position[#arg_27_1.config.behavior_position + 1] = {
			x = 0,
			y = 0
		}
		self._is_animation_start_list = {
			var_0_6.dormitory_special_furniture_id.wall_mounted_clock_1,
			var_0_6.dormitory_special_furniture_id.wall_mounted_clock_2,
			var_0_6.dormitory_special_furniture_id.little_qutie_clock,
			var_0_6.dormitory_special_furniture_id.orange_clock
		}
		self._data = arg_27_1.data
		self._config = arg_27_1.config
		self._game_machine_list = arg_27_1.game_machine_list
		self._callbacks = arg_27_1.callbacks
		self._sort_layer_canvas = self._control.sort_layer:GetComponent("Canvas")
		self._sort_layer2_canvas = self._control.sort_layer2:GetComponent("Canvas")
		self._furniture_rect = self._control.sort_layer.spine.rectTransform
		self._spine = self._control.sort_layer.spine
		self._default_anim_name = "normal"
		self._default_anim_state = true

		if self._config.furniture_type == var_0_6.furniture_pos_type.move_forbid then
			self:__set_fixed_furniture(arg_27_1.order)
			self:set_bg_spine()
		else
			if self._config.type == 13 or self._config.cid == var_0_6.dormitory_special_furniture_id.veneto then
				self._default_anim_name = "stand"
			elseif self._config.action_id[1] == var_0_6.furniture_action_type.play_game or self._config.action_id[1] == var_0_6.furniture_action_type.desktop_game or self._config.cid == var_0_6.dormitory_special_furniture_id.holograpgic_projection_device or self._config.cid == var_0_6.dormitory_special_furniture_id.duel_disk then
				self._default_anim_name = "close"
			elseif self._config.cid == var_0_6.dormitory_special_furniture_id.galo_giganotus_armor then
				self._default_anim_name = "start"
				self._default_anim_state = false
			elseif self._config.action_id[1] == var_0_6.furniture_action_type.western_style_coffin then
				self._default_anim_name = "normal2"

				self:__add_mask_component()
			elseif self._config.action_id[1] == var_0_6.furniture_action_type.ugly_wall then
				self._default_anim_name = "normal2"
			end

			if self._config.cid == var_0_6.dormitory_special_furniture_id.hight_screen_TV and #self._game_machine_list ~= 0 then
				self._default_anim_name = self._game_machine_list[var_0_9(1, #self._game_machine_list)]
			end

			for iter_27_0 = 1, #self._is_animation_start_list do
				if self._config.cid == self._is_animation_start_list[iter_27_0] then
					self._default_anim_name = "animation"
				end
			end

			if self._config.furniture_type == var_0_6.furniture_pos_type.ceiling then
				self._control.sort_layer.img:GetComponent("RectTransform").pivot = var_0_3(0.5, 1)
			end

			self:__set_sprite()
			self:set_spine()
			self:toggle_spine(not self._config.race_car)
			self:set_furniture_scale(self._data.point.y)
			self:set_furniture_position(self._data.point.x, self._data.point.y)
			self:adjust_furniture_pos()
		end

		self._is_have_ai = false
		self._is_have_clock = false

		if self._config.type == 13 then
			self._is_have_ai = true

			self:add_ai_data(self._config.cid)
		end

		if self._config.special_type == 10 then
			self._is_have_clock = true

			self:add_now_time(self._config.cid)
		end

		for iter_27_1, iter_27_2 in pairs(var_0_6.dormitory_furniture_rect_config) do
			if iter_27_1 == self._config.cid then
				iter_27_2._game_machine_list = self._game_machine_list

				self:add_ckick_event(iter_27_1, iter_27_2)
			end

			if iter_27_1 == self._config.action_id[1] then
				self:add_ckick_event(iter_27_1, iter_27_2)
			end
		end

		for iter_27_3, iter_27_4 in pairs(var_0_6.self_loop_funriture_list) do
			if iter_27_4 == self._config.cid then
				self:add_self_loop_anim(iter_27_4)
			end
		end

		self._fur_time_execute_task_list = {}

		for iter_27_5 = 1, 8 do
			self._fur_time_execute_task_list[#self._fur_time_execute_task_list + 1] = {}
		end
	end

	function arg_1_0:__init_special_type()
		local var_28_0

		if self._config.special_type == var_0_6.furniture_special_type.race_car then
			var_28_0 = "race_car"

			self:__set_collider_size()
		elseif self._config.special_type == var_0_6.furniture_special_type.barricade then
			var_28_0 = "barricade"

			self:__set_collider_size()
		elseif self._config.special_type == var_0_6.furniture_special_type.galo_barricade then
			var_28_0 = "barricade"

			self:__set_collider_size()
		elseif self._config.special_type == var_0_6.furniture_special_type.hook then
			var_28_0 = "hook"

			self:__set_collider_size()
		elseif self._config.type == 13 then
			var_28_0 = "animal"

			self:__set_collider_size()
		end

		if var_28_0 then
			self._control.sort_layer.spine.furniture_collider.trigger2DEvent.colliderName = var_28_0
		end

		self:toggle_furniture_collider(false)

		if var_28_0 == "animal" then
			self:toggle_furniture_collider(true)

			var_0_10.is_have_animal = true
		end

		if var_28_0 == "hook" and self.grid_y >= 45 then
			self:toggle_furniture_collider(true)
		end
	end

	function arg_1_0:__set_collider_size()
		self._control.sort_layer.spine.furniture_collider.rectTransform.anchoredPosition = self._control.sort_layer.spine.furniture_collider.rectTransform.anchoredPosition - self._spine_pos_delta / self._spine_scale

		local var_29_0 = (self._config.width + 2) * var_0_6.dormitory_const.room_x_plus / self._spine_scale
		local var_29_1 = self._config.height * var_0_6.dormitory_const.room_y_plus / self._spine_scale
		local var_29_2 = -1 * var_0_6.dormitory_const.room_x_plus / self._spine_scale

		if self._config.special_type == var_0_6.furniture_special_type.hook then
			var_29_0 = 20
			var_29_1 = 20
			var_29_2 = 0
			self._control.sort_layer.spine.furniture_collider.rectTransform.anchoredPosition = var_0_3(self._control.sort_layer.spine.furniture_collider.rectTransform.anchoredPosition.x, 0)
		end

		local var_29_3 = 0.5 * var_29_1

		self._control.sort_layer.spine.furniture_collider.boxCollider2D.size = var_0_3(var_29_0, var_29_1)
		self._control.sort_layer.spine.furniture_collider.boxCollider2D.offset = var_0_3(var_29_2, var_29_3)
	end

	function arg_1_0:__set_fixed_furniture(arg_30_1)
		self._control.sort_layer.img.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.room_bg_sprite_path, self._config.icon))

		self._control.sort_layer.img.image:SetNativeSize()

		self._control.sort_layer.img.rectTransform.sizeDelta = self._control.sort_layer.img.rectTransform.sizeDelta * var_0_6.dormitory_const.room_scale_const

		local var_30_0 = 0

		if self._config.type == var_0_6.furniture_kind_type.ceiling then
			var_30_0 = 720 - self._control.sort_layer.img.rectTransform.sizeDelta.y
		elseif self._config.type == var_0_6.furniture_kind_type.wall then
			var_30_0 = var_0_6.dormitory_const.room_bg_wall_y
		elseif self._config.type == var_0_6.furniture_kind_type.ground then
			var_30_0 = 0
		end

		self._control.sort_layer.img.rectTransform.anchoredPosition = var_0_3(var_0_6.dormitory_const.room_bg_x, (self._config.cid == var_0_6.dormitory_special_furniture_id.circuit or nil) and var_0_6.dormitory_const.circuit_const_y)

		self:set_sort_order(arg_30_1)
	end

	function arg_1_0:__set_sprite()
		self._control.sort_layer.img.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, self._config.icon, self._config.icon, ""))

		if self._config.cid == var_0_6.dormitory_special_furniture_id.combination_slide then
			self._control.sort_layer.img.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, "222_1", "222_1", ""))
			self._control.sort_layer2.img.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, "222_2", "222_2", ""))

			self._control.sort_layer2.img.image:SetNativeSize()
			self._control.sort_layer.img.childImg:SetActive(false)
		elseif self._config.cid == var_0_6.furniture_special_condition.on_water.swimming_pool_cid then
			self._control.sort_layer.img.childImg.image.sprite = self:loadSprite(var_0_2(var_0_6.dormitory_const.furniture_sprite_path, "446", "446", ""))

			self._control.sort_layer.img.childImg.image:SetNativeSize()
			self._control.sort_layer.img.childImg:SetActive(true)

			self._control.sort_layer.img.childImg.rectTransform.anchoredPosition = var_0_3(206, -43.3)
		else
			self._control.sort_layer.img.childImg:SetActive(false)
		end

		self._control.sort_layer.img.image:SetNativeSize()

		self._sprite_size = self._control.sort_layer.img.rectTransform.sizeDelta
		self._control.sort_layer.img.rectTransform.localRotation = var_0_4(0, self._data.rotate and 180 or 0, 0)
		self._control.sort_layer.img.image.alphaHitTestMinimumThreshold = var_0_6.dormitory_const.furniture_alpha_hit_min
	end

	function arg_1_0:__toggle_edit_mode(arg_32_1)
		self._control.sort_layer.img.image.raycastTarget = arg_32_1
		self._control.sort_layer.img.image.color = var_0_5(1, 1, 1, (arg_32_1 or nil) and (var_0_6.dormitory_const.furniture_editing_icon_alpha or 1))
		self._control.sort_layer.img.canvasGroup.blocksRaycasts = arg_32_1

		if self._config.cid == var_0_6.dormitory_special_furniture_id.cake_display_case then
			self:__set_special_furniture_canvas_data()

			return
		end

		self:toggle_spine(not arg_32_1)

		if self._config.race_car then
			self:toggle_spine(false)
		end

		if not arg_32_1 then
			self:adjust_furniture_pos()
		end
	end

	function arg_1_0:__set_special_furniture_canvas_data()
		if self._has_spine2 then
			self._control.sort_layer2.spine.canvasGroup.alpha = 0
			self._control.sort_layer.spine.canvasGroup.alpha = 0
		end
	end

	function arg_1_0.set_curr_furniture_start_ai_condition(arg_34_0, arg_34_1, arg_34_2)
		arg_34_0._furniture_random_walk = arg_34_1
		arg_34_0._curr_inter_ship = arg_34_2
	end

	function arg_1_0.set_stop_furniture_ai(arg_35_0, arg_35_1, arg_35_2)
		arg_35_0._is_stop_furniture_ai = arg_35_1
		arg_35_0._is_have_offet = arg_35_2
	end

	function arg_1_0.set_move_ai_condition(arg_36_0, arg_36_1)
		arg_36_0._furniture_move_ai = arg_36_1
		arg_36_0._ai_walking = arg_36_1
	end

	function arg_1_0:get_furniture_bone_position()
		local var_37_0 = self._furniture_skeleton_graphic.Skeleton:FindBone("set")

		return var_37_0.WorldX * tonumber(var_0_6.dormitory_const.bone_const), var_37_0.WorldY * tonumber(var_0_6.dormitory_const.bone_const)
	end

	function arg_1_0:get_pet_name_and_can_anim()
		local var_38_0 = false
		local var_38_1 = ""

		var_0_10.now_enter_ship_cid = var_0_10.now_enter_ship_cid or var_0_10.now_exit_ship_cid

		if self._config.cid == var_0_6.dormitory_special_furniture_id.oscar_1_cat and (var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.oscar_cat_master or var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.oscar_cat_master_reform) then
			var_38_1 = "oscar_1_cat"
			var_38_0 = true
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.oscar_2_cat and (var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.oscar_cat_master or var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.oscar_cat_master_reform) then
			var_38_1 = "oscar_2_cat"
			var_38_0 = true
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.chick and (var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.chick_master or var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.chick_master_reform) then
			var_38_1 = "chick"
			var_38_0 = true
		elseif (self._config.cid == var_0_6.dormitory_special_furniture_id.wolf_1 or self._config.cid == var_0_6.dormitory_special_furniture_id.wolf_2) and (var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.wolf_master or var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.wolf_master_reform) then
			var_38_1 = "wolf_1"
			var_38_0 = true
		elseif self._config.cid == var_0_6.dormitory_special_furniture_id.wolf_2 and (var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.wolf_master or var_0_10.now_enter_ship_cid == var_0_6.dormitory_special_furniture_id.wolf_master_reform) then
			var_38_1 = "wolf_2"
			var_38_0 = true
		end

		return var_38_1, var_38_0
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_39_0)
	local var_39_0 = var_0_1:class("furniture")

	var_39_0._data = {}
	var_39_0._config = {}
	var_39_0._sprite_size = var_0_3(0, 0)
	var_39_0._foot_position = var_0_3(0, 0)
	var_39_0._now_foot_position = var_0_3(0, 0)
	var_39_0._spine_pos_delta = var_0_3(0, 0)
	var_39_0.to_grid_pos_x = nil
	var_39_0.to_grid_pos_y = nil
	var_39_0._spine_scale = 1
	var_39_0._callbacks = {}
	var_39_0._sort_layer_canvas = nil
	var_39_0._sort_layer2_canvas = nil
	var_39_0._forbid_anim_flag = false
	var_39_0._has_spine2 = false
	var_39_0._furniture_skeleton_graphic = nil
	var_39_0._furniture_skeleton_graphic2 = nil
	var_39_0._furniture_skeleton_graphic3 = nil
	var_39_0._spine_obj_right_btn = nil
	var_39_0._spine_left_obj = nil
	var_39_0._spine_right_obj = nil
	var_39_0._left_change_index = 0
	var_39_0._right_change_index = 0
	var_39_0._galo_click_num = 0
	var_39_0._stand_default_anim_list = {}
	var_39_0._furniture_rect = nil
	var_39_0._walk_pos_interpolation_list = {}
	var_39_0._walk_pos_interpolation_list_index = 0
	var_39_0._walk_path_grid_list = {}
	var_39_0._walk_path_grid_list_index = 0
	var_39_0._grid_pos = var_0_3(0, 0)
	var_39_0._random_pos = var_0_3(0, 0)
	var_39_0._is_have_ai = false
	var_39_0._is_have_clock = false
	var_39_0._furniture_seq_click_list = {}
	var_39_0._is_click = false
	var_39_0._is_walk = false
	var_39_0._is_quick_walk = false
	var_39_0._random_walk = false
	var_39_0._furniture_data = nil
	var_39_0._acting = false
	var_39_0._play_action_list = {}
	var_39_0._play_action_list_index = 0
	var_39_0._action_cooling = false
	var_39_0._action_cooling_timer = 0
	var_39_0._pet_action_cooling = {
		wolf_1 = false,
		oscar_2_cat = false,
		wolf_2 = false,
		chick = false,
		oscar_1_cat = false
	}
	var_39_0._pet_action_cooling_timer = {
		wolf_1 = 0,
		oscar_2_cat = 0,
		wolf_2 = 0,
		chick = 0,
		oscar_1_cat = 0
	}
	var_39_0._pet_love_action_during = {
		wolf_1 = false,
		oscar_2_cat = false,
		wolf_2 = false,
		chick = false,
		oscar_1_cat = false
	}
	var_39_0._pet_love_action_during_timer = {
		wolf_1 = 0,
		oscar_2_cat = 0,
		wolf_2 = 0,
		chick = 0,
		oscar_1_cat = 0
	}
	var_39_0._start_tennis_update = false
	var_39_0._tennis_over = nil
	var_39_0._tennis_step = nil
	var_39_0._play_index = nil
	var_39_0._start_tennis_timer = false
	var_39_0._tennis_time = nil
	var_39_0._spine = nil
	var_39_0._is_second_click = false
	var_39_0.is_have_s = true
	var_39_0._farmland_furniture_seq_click_list = {}
	var_39_0._is_aleady_set = false
	var_39_0._recover_orgin_pos = false
	var_39_0._furniture_orgin_pos = nil
	var_39_0._furniture_btn_orgin_pos = nil
	var_39_0._furniture_random_walk = false
	var_39_0._furniture_move_ai = false
	var_39_0._curr_inter_ship = nil
	var_39_0._is_stop_furniture_ai = false
	var_39_0._is_have_offet = false
	var_39_0._fur_time_execute_task_list = {}
	var_39_0._ai_walking = false
	var_39_0._is_show_fly = false

	return var_39_0
end

return var_0_0
