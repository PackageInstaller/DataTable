local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_5 = Spine.Unity.SkeletonGraphic
local var_0_6 = UnityEngine.Vector2
local var_0_7 = UnityEngine.Vector3
local var_0_8 = math.abs
local var_0_9 = gamecore.user
local var_0_10 = gamecore.dormitory_idea
local var_0_11 = gamecore.util_func
local var_0_12 = UnityEngine.Time
local var_0_13 = math.floor
local var_0_14 = gameconfig.skin_config
local var_0_15 = gameconfig.room_animation_config
local var_0_16 = DG.Tweening.DOTween
local var_0_17 = lan_rand
local var_0_18 = gamecore.prompt

gamecore.UILoader:define("dormitory_ship", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)

		self._control.sort_layer.ship.rectTransform.localScale = var_0_7(1.25, 1.25, 1)

		self:__init_panel(arg_2_1)

		self._dormitory_instance = arg_2_1.dormitory_instance
	end

	function arg_1_0:update()
		self:__run_time_task_list()

		if self._action_cooling then
			self._action_cooling_timer = self._action_cooling_timer - var_0_12.deltaTime

			if self._action_cooling_timer < 0 then
				self._action_cooling = false
			end
		end

		if self._acting then
			if not next(self._play_action_list) then
				return
			end

			if self._play_action_list_index > #self._play_action_list then
				return
			end

			local var_3_0 = self._play_action_list[self._play_action_list_index]

			if self._play_action_list[self._play_action_list_index].type == "move" then
				if not var_3_0.keep_flip_x then
					self:set_ship_flip_x(self:get_foot_position().x < var_3_0.to_pos.x)
				end

				self:set_foot_position(var_3_0.to_pos.x, var_3_0.to_pos.y)
			elseif var_3_0.type == "wait" then
				-- block empty
			elseif var_3_0.type == "set_furniture_animation" then
				var_3_0.furniture_control:set_furniture_animation(var_3_0.track_index, var_3_0.animation_name, var_3_0.loop)
			elseif var_3_0.type == "start_car" then
				var_3_0.car_ele.control:toggle_spine(true)
				self:toggle_ship_btn_raycast(false)
			elseif var_3_0.type == "request_drive_car" then
				var_0_10:dormitory_idea_manager_request_drive_car(var_3_0.ship_id, var_3_0.furniture_id)
			elseif var_3_0.type == "request_drive_normal_car" then
				var_0_10:transmit_begin_interactive_data(var_3_0)
			elseif var_3_0.type == "delay_excute_event" then
				var_0_10:wait_delay_excute_event(var_3_0)
			elseif var_3_0.type == "request_stop_car" then
				var_0_10:transmit_end_interactive_data(var_3_0)

				if var_3_0.config_cid == var_0_4.dormitory_special_furniture_id.single_slide then
					self._lifting = false
				end

				self:toggle_ship_btn_raycast(true)
			elseif var_3_0.type == "reset_ship_collider_state" then
				var_0_10:reset_ship_collider_state(var_3_0.ship_id)
			elseif var_3_0.type == "set_ship_btn_raycast" then
				self:toggle_ship_btn_raycast(var_3_0.is_active)
			elseif var_3_0.type == "set_ship_show_state" then
				self:set_ship_show_state(var_3_0.is_active)
			elseif var_3_0.type == "set_ship_inter_state" then
				var_0_10:dormitory_idea_manager_set_ship_inter_state(var_3_0.furniture_id, var_3_0.furniture_cid)
			elseif var_3_0.type == "request_change_spine" then
				var_0_10:dormitory_idea_manager_request_change_spine(var_3_0.furniture_id, var_3_0.config_cid, var_3_0.spine_name, var_3_0.spine_state)
			elseif var_3_0.type == "request_play_djbox" then
				var_0_10:dormitory_idea_manager_request_play_djbox(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "request_play_skateboard" then
				var_0_10:dormitory_idea_manager_request_play_skateboard(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "request_drive_harvester" then
				var_0_10:dormitory_idea_manager_request_drive_harvester(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "request_sit_veneto" then
				var_0_10:dormitory_idea_manager_request_sit_veneto(var_3_0.furniture_ele, var_3_0.loop_count1, var_3_0.loop_count2)
			elseif var_3_0.type == "request_play_magic_wand" then
				var_0_10:dormitory_idea_manager_request_play_magic_wand(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "request_play_hat" then
				var_0_10:dormitory_idea_manager_request_play_hat(var_3_0.furniture_ele, var_3_0.ship_ele)
			elseif var_3_0.type == "request_play_desktop_game" then
				var_0_10:dormitory_idea_manager_request_play_desktop_game(var_3_0.furniture_ele)
			elseif var_3_0.type == "request_play_mini_rowing" then
				var_0_10:dormitory_idea_manager_request_play_mini_rowing(var_3_0.furniture_ele, var_3_0.action_type)
			elseif var_3_0.type == "request_play_tennis" then
				self.to_the_end = true

				var_0_10:dormitory_idea_manager_request_play_tennis(var_3_0.furniture_ele)
			elseif var_3_0.type == "play_assembly_station" then
				var_0_10:dormitory_idea_manager_request_play_assembly_station(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "request_play_western_style_coffin" then
				var_0_10:dormitory_idea_manager_request_play_western_style_coffin(var_3_0.furniture_ele, var_3_0.delay)
			elseif var_3_0.type == "reset_data" then
				local var_3_1

				for iter_3_0, iter_3_1 in pairs(var_3_0.furniture_ele.param_data) do
					if iter_3_1.ship_ele == var_3_0.ship_ele then
						var_3_1 = iter_3_0
					end
				end

				local var_3_2

				if var_3_0.furniture_ele.ready_ship then
					for iter_3_2, iter_3_3 in pairs(var_3_0.furniture_ele.ready_ship) do
						if iter_3_3 == var_3_0.ship_ele then
							var_3_2 = iter_3_2
						end
					end
				end

				if var_3_1 then
					var_3_0.furniture_ele.param_data[var_3_1] = nil
				end

				if var_3_2 then
					var_3_0.furniture_ele.ready_ship[var_3_2] = nil
				end
			elseif var_3_0.type == "set_ship_pos" then
				self:__set_inter_ship_pos(var_3_0.diff_num)
			elseif var_3_0.type == "set_now_ship_pos" then
				self:set_foot_position(var_3_0.pos_x, var_3_0.pos_y)
			elseif var_3_0.type == "set_ship_raycast" then
				self:toggle_ship_btn_raycast(var_3_0.raycast)
			elseif var_3_0.type == "reset_water_ripple" then
				self:__reset_water_ripple()
			elseif var_3_0.type == "set_sort_order" then
				self:set_acting_sort_order(var_3_0.sort_order)
			elseif var_3_0.type == "set_expression" then
				self:set_expression_animation(0, var_3_0.expression_name, var_3_0.loop, var_3_0.duration)
			elseif var_3_0.type == "set_ready_ship" then
				self:__set_ready_ship(var_3_0.furniture_ele, var_3_0.index, var_3_0.ship_ele)
			elseif var_3_0.type == "flip_x" then
				self:set_ship_flip_x(var_3_0.flip)
			elseif var_3_0.type == "set_animation" then
				self:set_ship_animation(var_3_0.track_index, var_3_0.animation_name, var_3_0.loop)
			elseif var_3_0.type == "add_animation" then
				self:add_ship_animation(var_3_0.track_index, var_3_0.animation_name, var_3_0.loop, var_3_0.delay, var_3_0.furniture_ele)
			elseif var_3_0.type == "set_special_furniture_animation" then
				var_0_10:set_special_furniture_animation(var_3_0.track_index, var_3_0.animation_name, var_3_0.loop, var_3_0.furniture_ele)
			elseif var_3_0.type == "set_ship_parent" then
				self._control.sort_layer.ship.spine.transform:SetParent(var_3_0.node, false)

				if var_3_0.state == 1 then
					self.is_in_coffin = true
					self._control.sort_layer.ship.spine.rectTransform.anchoredPosition = var_0_6(-5, -55)
				else
					self.is_in_coffin = false
					self._control.sort_layer.ship.spine.rectTransform.anchoredPosition = var_0_6(0, 0)
				end
			elseif var_3_0.type == "stop" then
				local var_3_3 = var_3_0.cooling_time or var_0_17(var_0_4.furntiure_const.loop_num3, var_0_4.furntiure_const.loop_num4)

				if self._is_exist_special_fur then
					self:__set_curr_ship_move_state()
				end

				self:toggle_ship_btn_raycast(true)

				self._action_cooling_timer = var_3_3
				self._action_cooling = true

				self:clear_play_action_list()

				self._acting = false

				if var_3_0.furniture_id then
					var_0_10:dormitory_idea_manager_request_toggle_action(var_3_0.furniture_id, false)
				end

				self:clear_inter_furniture_element()
				self:random_walk()
			elseif var_3_0.type == "stop_touch_head" then
				self._touch_head = false
			end

			self._play_action_list_index = self._play_action_list_index + 1

			return
		end

		if self._walking then
			local var_3_4 = self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index]

			if self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index] then
				self:set_ship_flip_x(self:get_foot_position().x < var_3_4.to_pos.x)
				self:set_foot_position(var_3_4.to_pos.x, var_3_4.to_pos.y)

				self._walk_pos_interpolation_list_index = self._walk_pos_interpolation_list_index + 1

				if self._walk_pos_interpolation_list_index > #self._walk_pos_interpolation_list then
					self:__set_next_path_grid()
				end
			else
				self._walking = false
			end
		end

		if self._fall_downing then
			self._can_lift = false

			if self._hooking then
				self._fall_downing = false

				self:__on_fall_down_end()

				return
			end

			self.velocity.y = self.velocity.y - var_0_4.dormitory_const.gravity * var_0_12.deltaTime

			local var_3_5 = self:get_foot_position() + self.velocity

			if var_3_5.y >= var_0_4.dormitory_const.panel_height - 180 then
				var_3_5.y = var_0_4.dormitory_const.panel_height - 180
				self.velocity.y = -self.velocity.y
			end

			if var_3_5.x >= var_0_4.dormitory_const.panel_width - 30 then
				var_3_5.x = var_0_4.dormitory_const.panel_width - 30
				self.velocity.x = -self.velocity.x
			end

			if 30 >= var_3_5.x then
				var_3_5.x = 30
				self.velocity.x = -self.velocity.x
			end

			if var_3_5.y <= 0 then
				var_3_5.y = 0
			end

			self:shadow_follow(true)
			var_0_10:update_drag_ship_position(var_3_5, self._ship_data.id)
			self:set_foot_position(var_3_5.x, var_3_5.y)

			if self._ship_rect.anchoredPosition.y <= self._end_lifting_pos then
				self._fall_downing = false

				self:__on_fall_down_end()
			end
		end

		self:__excute_swimming_pool_logic()
	end

	function arg_1_0:excute_ship_expression_logic()
		self._acting = true

		local var_4_0 = {}
		local var_4_1 = var_0_17(1, 2) == 1 and "touch_head" or "touch_head2"

		self._touch_head_count = self._touch_head_count + 1

		if self._touch_head_count ~= 0 and self._touch_head_count % 5 == 0 then
			if self._ship_data.love >= var_0_4.ship_love.love_touch_head then
				var_4_0[#var_4_0 + 1] = {
					loop = false,
					expression_name = "shy",
					duration = 12,
					type = "set_expression"
				}
				var_4_0[#var_4_0 + 1] = {
					track_index = 0,
					loop = false,
					type = "set_animation",
					animation_name = var_4_1
				}

				var_0_10:dormitory_idea_manager_wait_idea(var_4_0, 1.667)

				if self._ship_data.marry then
					if (var_0_4.ship_love.marry_love_limit or var_0_4.ship_love.love_init_limit) > self._ship_data.love then
						self._is_myself_req_add_love = true

						self:touch_head_add_love_req()
					end
				end
			else
				var_4_0[#var_4_0 + 1] = {
					loop = false,
					expression_name = "wtf",
					duration = 0.667,
					type = "set_expression"
				}
				var_4_0[#var_4_0 + 1] = {
					track_index = 0,
					animation_name = "SP_anger",
					loop = false,
					type = "set_animation"
				}

				var_0_10:dormitory_idea_manager_wait_idea(var_4_0, 2.333)
				self:touch_head_add_love_req()
			end
		else
			var_4_0[#var_4_0 + 1] = {
				track_index = 0,
				loop = false,
				type = "set_animation",
				animation_name = var_4_1
			}

			var_0_10:dormitory_idea_manager_wait_idea(var_4_0, 1.667)
		end

		var_4_0[#var_4_0 + 1] = {
			type = "stop_touch_head"
		}
		var_4_0[#var_4_0 + 1] = {
			type = "stop",
			furniture_id = self._ship_data.id
		}

		self:set_play_action_list(var_4_0)
	end

	function arg_1_0.toggle_acting_tag(arg_5_0, arg_5_1)
		arg_5_0._acting = arg_5_1
	end

	function arg_1_0:set_play_action_list(arg_6_1)
		self:clear_inter_furniture_element()

		self._play_action_list = arg_6_1
		self._play_action_list_index = 1
	end

	function arg_1_0.set_inter_furniture_element(arg_7_0, arg_7_1)
		arg_7_0._inter_furniture_ele = arg_7_1
	end

	function arg_1_0.clear_inter_furniture_element(arg_8_0)
		arg_8_0._inter_furniture_ele = nil
	end

	function arg_1_0:set_acting_sort_order(arg_9_1)
		if not self._acting then
			return
		end

		local var_9_0 = var_0_4.ui_layer.middle + var_0_4.dormitory_const.layer_remain
		local var_9_1 = arg_9_1

		var_9_1 = var_0_4.ui_layer.middle + var_0_4.dormitory_const.layer_remain + (var_0_4.dormitory_const.layer_offset - var_0_4.dormitory_const.layer_remain) < arg_9_1 and var_0_4.ui_layer.middle + var_0_4.dormitory_const.layer_remain + (var_0_4.dormitory_const.layer_offset - var_0_4.dormitory_const.layer_remain) or var_9_1
		var_9_1 = var_9_1 <= var_9_0 and var_9_0 or var_9_1
		self._sort_layer_canvas.sortingOrder = var_9_1
	end

	function arg_1_0:set_sort_order(arg_10_1)
		if self._acting then
			return
		end

		self._sort_layer_canvas.sortingOrder = arg_10_1
	end

	function arg_1_0:get_sort_order()
		return self._sort_layer_canvas.sortingOrder
	end

	function arg_1_0:set_ship_animation(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = arg_12_4 or 0

		if arg_12_2 == "dance" and not self._ship_skeleton_graphic.Skeleton.Data:FindAnimation(arg_12_2) then
			arg_12_2 = "stand1"
		end

		self._ship_skeleton_graphic.AnimationState:SetAnimation(arg_12_1, arg_12_2, arg_12_3)
		self._ship_skeleton_graphic.AnimationState:Update(var_12_0)
	end

	function arg_1_0:add_ship_animation(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
		if arg_13_5 then
			self:__set_animation_pos(arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
		else
			self._ship_skeleton_graphic.AnimationState:AddAnimation(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		end
	end

	function arg_1_0:clear_ship_animation()
		self._ship_skeleton_graphic.AnimationState:ClearTracks()
	end

	function arg_1_0:set_expression_animation(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
		self._expression_skeleton_graphic.AnimationState:ClearTracks()

		self._expression_skeleton_graphic.startingAnimation = arg_15_2

		self._expression_skeleton_graphic:Initialize(true)

		self._control.sort_layer.ship.expression.canvasGroup.alpha = 1

		self._expression_skeleton_graphic.AnimationState:SetAnimation(arg_15_1, arg_15_2, arg_15_3)

		local var_15_0 = {}

		var_15_0[#var_15_0 + 1] = {
			execute_time = arg_15_4,
			execute_func = function()
				self._expression_skeleton_graphic.AnimationState:SetAnimation(0, "end", false)
			end
		}
		var_15_0[#var_15_0 + 1] = {
			execute_time = arg_15_4 + 0.4,
			execute_func = function()
				self._control.sort_layer.ship.expression.canvasGroup.alpha = 0
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.expression].task_list = var_15_0
	end

	function arg_1_0:clear_expression_animation()
		self._expression_skeleton_graphic.AnimationState:ClearTracks()

		self._control.sort_layer.ship.expression.canvasGroup.alpha = 0
	end

	function arg_1_0.__set_ready_ship(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
		arg_19_1.ready_ship[arg_19_2] = arg_19_3
	end

	function arg_1_0:set_ship_flip_x(arg_20_1)
		if self._ship_flipx == arg_20_1 then
			return
		end

		self._ship_skeleton_graphic.Skeleton.FlipX = arg_20_1
		self._ship_flipx = arg_20_1
	end

	function arg_1_0:get_ship_flip_x()
		return self._ship_skeleton_graphic.Skeleton.FlipX
	end

	function arg_1_0:set_ship_show_state(arg_22_1)
		self._control.sort_layer.ship.gameObject:SetActive(arg_22_1)
	end

	function arg_1_0:get_foot_position()
		return self._ship_rect.anchoredPosition
	end

	function arg_1_0:set_foot_position(arg_24_1, arg_24_2)
		self._grid_pos = self:__convert_to_grid(arg_24_1, arg_24_2)

		self:set_foot_position_without_record(arg_24_1, arg_24_2)
	end

	function arg_1_0:set_foot_position_without_record(arg_25_1, arg_25_2)
		self._ship_rect.anchoredPosition = var_0_6(arg_25_1, arg_25_2)
		self._ship_btn_rect.anchoredPosition = var_0_6(arg_25_1, arg_25_2)
	end

	function arg_1_0:set_grid_foot_position(arg_26_1, arg_26_2)
		self._grid_pos = var_0_6(arg_26_1, arg_26_2)

		self:set_foot_position_without_record(arg_26_1 * var_0_4.dormitory_const.room_x_plus, arg_26_2 * var_0_4.dormitory_const.room_y_plus)
	end

	function arg_1_0:get_grid_foot_position()
		return self._grid_pos.x, self._grid_pos.y
	end

	function arg_1_0:toggle_ship_btn_raycast(arg_28_1)
		self._control.sort_layer.ship_btn.image.raycastTarget = arg_28_1
	end

	function arg_1_0:walk(arg_29_1, arg_29_2)
		if self._prostrating then
			return
		end

		if self._lifting then
			return
		end

		self._walk_path_grid_list = {}
		self._walk_path_grid_list_index = 1

		var_0_10:dormitory_idea_manager_create_walk_path_grid_list({
			walk_path_grid_list = self._walk_path_grid_list,
			to_grid_pos = {
				x = arg_29_1,
				y = arg_29_2
			},
			curr_grid_pos = {
				x = self._grid_pos.x,
				y = self._grid_pos.y
			}
		})

		if arg_29_1 > self._grid_pos.x then
			self:set_ship_flip_x(true)
		end

		if arg_29_1 < self._grid_pos.x then
			self:set_ship_flip_x(false)
		end

		self:set_ship_animation(0, "walk_slow", true)
		self:__set_next_path_grid()
	end

	function arg_1_0:random_walk()
		local var_30_0, var_30_1 = var_0_10:dormitory_idea_manager_get_random_to_pos()

		self:walk(var_30_0, var_30_1)
		self:toggle_ship_collider(true)
	end

	function arg_1_0:delay_walk(arg_31_1)
		local var_31_0 = {}

		var_31_0[#var_31_0 + 1] = {
			execute_time = arg_31_1,
			execute_func = function()
				self:random_walk()
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.walk].task_list = var_31_0
	end

	function arg_1_0:shadow_follow(arg_33_1)
		if arg_33_1 then
			self._control.sort_layer.shadow.rectTransform.anchoredPosition = var_0_6(self._ship_rect.anchoredPosition.x, (self._ship_rect.anchoredPosition.y - 14 > var_0_4.dormitory_const.room_bg_wall_y - 20 or nil) and var_0_4.dormitory_const.room_bg_wall_y - 20)
			self._control.sort_layer.shadow.canvasGroup.alpha = 1
		else
			self._control.sort_layer.shadow.canvasGroup.alpha = 0
		end
	end

	function arg_1_0:set_water_pos_by_fall_down(arg_34_1)
		if arg_34_1 and self._is_exist_special_fur then
			local var_34_0 = self._ship_rect.anchoredPosition.y - 14
			local var_34_1

			if self._ship_rect.anchoredPosition.y - 14 > var_0_4.dormitory_const.room_bg_wall_y - 20 then
				var_34_0 = var_0_4.dormitory_const.room_bg_wall_y - 20
				var_34_1 = {
					x = self._ship_rect.anchoredPosition.x - 637,
					y = var_34_0 - 340
				}
			end

			local var_34_2, var_34_3 = self._dormitory_instance:__check_ship_cover_furniture({
				x = self._ship_rect.anchoredPosition.x,
				y = var_34_0
			}, false)

			if var_34_2 then
				self._water_bottom_obj:setVisible(true)

				self._drag_fall_down_on_pool = true
				self._point_down_ship = false
			end

			self._water_bottom_control.wave.rectTransform.anchoredPosition = var_0_6(var_34_1.x, var_34_1.y)
		end
	end

	function arg_1_0:set_hook(arg_35_1)
		self._hooking = arg_35_1

		if not arg_35_1 then
			for iter_35_0, iter_35_1 in pairs(self._dormitory_instance._curr_furniture_tb) do
				if iter_35_1.config.cid == self._hook_furniture_id then
					iter_35_1.control:toggle_furniture_collider(true)
				end
			end

			self._hook_furniture_id = 0
		end
	end

	function arg_1_0:fall_down()
		if self._ship_rect.anchoredPosition.y >= self._end_lifting_pos then
			self._fall_downing = true
		else
			self:__on_fall_down_end()
		end
	end

	function arg_1_0.clear_walk_path_grid_list(arg_37_0)
		arg_37_0._walk_path_grid_list = {}
		arg_37_0._walk_path_grid_list_index = 1
	end

	function arg_1_0.clear_walk_pos_interpolation_list(arg_38_0)
		arg_38_0._walk_pos_interpolation_list = {}
		arg_38_0._walk_pos_interpolation_list_index = 1
	end

	function arg_1_0.clear_play_action_list(arg_39_0)
		arg_39_0._play_action_list = {}
		arg_39_0._play_action_list_index = 1
	end

	function arg_1_0:destroy_self()
		self:clear_inter_furniture_element()
		self:destroy()
	end

	function arg_1_0:clear_idea()
		self._acting = false
		self._walking = false

		self:clear_play_action_list()
		self:__clear_time_execute_task_list()
		self:clear_walk_pos_interpolation_list()
		self:clear_walk_path_grid_list()
		self:clear_expression_animation()
		self:__reset_water_ripple()
	end

	function arg_1_0:toggle_ship_collider(arg_42_1)
		self._control.sort_layer.ship.ship_collider.gameObject:SetActive(arg_42_1)
	end

	function arg_1_0:record_ship_collider_state()
		self._collider_state = self._control.sort_layer.ship.ship_collider.activeSelf
	end

	function arg_1_0:get_ship_collider_state()
		return self._collider_state
	end

	function arg_1_0:touch_head_add_love_req()
		var_0_9:req_RoomInteractReq({
			id = self._ship_data.id
		})
	end

	function arg_1_0:touch_head_add_love_resp(arg_46_1)
		if not self._is_myself_req_add_love then
			return
		end

		self._is_myself_req_add_love = false

		if arg_46_1 == 0 then
			self._control.sort_layer.ship.love_up.rectTransform = var_0_6(0, 190)
			self._control.sort_layer.ship.love_num.rectTransform = var_0_6(78, 212)
			self._control.sort_layer.ship.love_up.canvasGroup.alpha = 1
			self._control.sort_layer.ship.love_num.canvasGroup.alpha = 1

			self._control.sort_layer.ship.love_up.transform:DOLocalMoveY(210, 1):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
				if self and self._control then
					self._control.sort_layer.ship.love_up.canvasGroup.alpha = 0
				end
			end)
			self._control.sort_layer.ship.love_num.transform:DOLocalMoveY(240, 1):SetEase(DG.Tweening.Ease.Linear):OnComplete(function()
				if self and self._control then
					self._control.sort_layer.ship.love_num.canvasGroup.alpha = 0
				end
			end)
		elseif arg_46_1 == 149 then
			var_0_18:show(var_0_2:getNowLang("love_grow_limit"))
		end
	end

	function arg_1_0:reset_swimming_pool_state(arg_49_1)
		if arg_49_1 then
			if self._is_exist_special_fur then
				self._is_exist_special_fur = not self._is_exist_special_fur
			end
		elseif self._dormitory_instance:__get_curr_room_swing_pool_data() then
			self._is_exist_special_fur = true

			self:__get_water_ripple_point()
		else
			self._is_exist_special_fur = false

			if self._water_obj then
				self._water_obj:destroy()
				self._water_bottom_obj:destroy()

				self._water_obj = nil
				self._water_bottom_obj = nil
			end
		end
	end

	function arg_1_0:get_ship_data()
		return self._ship_data
	end

	function arg_1_0:__init_panel(arg_51_1)
		self._time_execute_task_list = {}

		for iter_51_0 = 1, 10 do
			self._time_execute_task_list[#self._time_execute_task_list + 1] = {}
		end

		self._ship_data = arg_51_1.data
		self._is_exist_special_fur = arg_51_1.is_exist_special_furniture
		self._ship_member_index = arg_51_1.ship_member_index
		self._ship_config = arg_51_1.config
		self._sort_layer_canvas = self._control.sort_layer:GetComponent("Canvas")

		self:__create_q_ship((self._ship_data.skin ~= 0 or nil) and var_0_14.find_object_by_cid(self._ship_data.skin).icon)

		self._bone_root = self._control.sort_layer.ship.bone
		self._girl_bone = self._bone_root.gameObject:GetComponent(typeof(Spine.Unity.BoneFollowerGraphic))
		self._girl_bone.skeletonGraphic = self._ship_skeleton_graphic
		self._girl_bone.boneName = "girl"
		self._ship_skeleton_graphic.initialSkinName = "normal"
		self._ship_skeleton_graphic.startingAnimation = "stand1"
		self._ship_skeleton_graphic.raycastTarget = false

		self._ship_skeleton_graphic:Initialize(true)

		if self._ship_data.love >= 9000 then
			self:set_ship_animation(0, "hello", true)
		end

		self._sort_layer_canvas.sortingOrder = arg_51_1.order + 1
		self._ship_rect = self._control.sort_layer.ship.rectTransform
		self._ship_btn_rect = self._control.sort_layer.ship_btn.rectTransform

		self:__init_expression_spine()

		if self._is_exist_special_fur then
			self:__get_water_ripple_point()
		end

		self:delay_walk(3)

		self._uiroot_canvas_rect = var_0_11.get_ui_root_canvas_rect()
		self._control.sort_layer.ship.ship_collider.trigger2DEvent.colliderName = "ship"
		self._control.sort_layer.ship.ship_collider.trigger2DEvent.index = arg_51_1.ship_member_index

		self:toggle_ship_collider(false)

		if var_0_10.is_have_animal then
			self:toggle_ship_collider(true)
		end

		self:record_ship_collider_state()
	end

	function arg_1_0.__get_graphic(arg_52_0, arg_52_1, arg_52_2)
		local var_52_0 = arg_52_1:GetComponent(typeof(var_0_5))

		if not var_52_0 then
			local var_52_1 = arg_52_1:AddComponent(typeof(var_0_5))

			var_52_0 = arg_52_1:GetComponent(typeof(var_0_5))
		end

		var_52_0.skeletonDataAsset = arg_52_2

		return var_52_0
	end

	function arg_1_0:__init_expression_spine()
		self._expression_skeleton_graphic = var_0_5.AddSkeletonGraphicComponent(self._control.sort_layer.ship.expression.gameObject, (self:loadSkeletonDataAsset(var_0_4.dormitory_const.ship_expression_spine_path)))
		self._expression_skeleton_graphic.startingAnimation = "love"
		self._expression_skeleton_graphic.raycastTarget = false

		self._expression_skeleton_graphic:Initialize(true)

		if self._ship_data.love >= 9000 then
			self:set_expression_animation(0, "love", false, 0.667)
		end
	end

	function arg_1_0:__raise_ship()
		self._prostrating = false

		self:__toggle_ship_btn_size(false)

		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.prostrate].task_list = nil

		self:set_ship_animation(0, "event_sit_UP_SP", false)
		self:add_ship_animation(0, "stand1", true, 1.333)

		local var_54_0 = {}

		var_54_0[#var_54_0 + 1] = {
			execute_time = 1,
			execute_func = function()
				self:set_expression_animation(0, "love", false, 0.667)
			end
		}
		var_54_0[#var_54_0 + 1] = {
			execute_time = 2,
			execute_func = function()
				self:random_walk()
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.raise].task_list = var_54_0
	end

	function arg_1_0:__self_raise()
		self._prostrating = false

		self:__toggle_ship_btn_size(false)
		self:set_ship_animation(0, "event_sit_UP_SP", false)
		self:add_ship_animation(0, "stand1", true, 1.333)

		local var_57_0 = {}

		var_57_0[#var_57_0 + 1] = {
			execute_time = 1,
			execute_func = function()
				self:set_expression_animation(0, "black_line", false, 2)
			end
		}
		var_57_0[#var_57_0 + 1] = {
			execute_time = 2.5,
			execute_func = function()
				self:random_walk()
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.raise].task_list = var_57_0
	end

	function arg_1_0:__toggle_ship_btn_size(arg_60_1)
		if arg_60_1 then
			self._ship_btn_rect.sizeDelta = var_0_6(135, 100)
			self._ship_btn_rect.anchoredPosition = self._ship_rect.anchoredPosition + var_0_6(self:get_ship_flip_x() and 30 or -30, 0)
		else
			self._ship_btn_rect.sizeDelta = var_0_6(100, 135)
			self._ship_btn_rect.anchoredPosition = self._ship_rect.anchoredPosition
		end
	end

	function arg_1_0:__random_jump_prostrate_walk()
		local var_61_0 = {}

		for iter_61_0 = 1, 10 do
			var_61_0[#var_61_0 + 1] = iter_61_0
		end

		local var_61_1 = var_0_11.pick_random_from_array(var_61_0)

		if var_61_1 == 1 then
			self:set_ship_animation(0, "jump", false)
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.ship_jump))

			local var_61_2 = {}

			var_61_2[#var_61_2 + 1] = {
				execute_time = 2,
				execute_func = function()
					self:__random_jump_prostrate_walk()
				end
			}
			self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.walk].task_list = var_61_2
		elseif var_61_1 == 2 then
			self:set_ship_animation(0, "walk_SP", false)
			self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.ship_fall))
			self:set_expression_animation(0, "X", false, 1)

			local var_61_3 = {}

			var_61_3[#var_61_3 + 1] = {
				execute_time = 0.667,
				execute_func = function()
					self:set_ship_animation(0, "prostrate", true)

					self._prostrating = true

					self:__toggle_ship_btn_size(true)
				end
			}
			var_61_3[#var_61_3 + 1] = {
				execute_time = 10,
				execute_func = function()
					self:__self_raise()
				end
			}
			self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.prostrate].task_list = var_61_3
		else
			self:random_walk()
		end
	end

	function arg_1_0:__set_next_path_grid()
		if self._walk_path_grid_list_index >= #self._walk_path_grid_list then
			self._walking = false

			self:set_ship_animation(0, "stand1", true)

			local var_65_0 = {}

			var_65_0[#var_65_0 + 1] = {
				execute_time = 2,
				execute_func = function()
					self:__random_jump_prostrate_walk()
				end
			}
			self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.walk].task_list = var_65_0

			return
		end

		self._walk_path_grid_list_index = self._walk_path_grid_list_index + 1

		if self._walk_path_grid_list[self._walk_path_grid_list_index].start_action then
			if var_0_10:dormitory_idea_manager_request_action(self._ship_data.id, self._walk_path_grid_list[self._walk_path_grid_list_index].furniture_id, self._walk_path_grid_list[self._walk_path_grid_list_index].action_id) and not self._action_cooling and var_0_10:dormitory_idea_manager_get_limit_data(self._ship_data.cid, self._walk_path_grid_list[self._walk_path_grid_list_index].furniture_id) then
				self._acting = true
				self._walking = false

				self:clear_walk_path_grid_list()
				self:clear_walk_pos_interpolation_list()
				self:__clear_time_execute_task_list()
				self:clear_expression_animation()
				var_0_10:dormitory_idea_manager_create_play_action(self._ship_data.id, self._walk_path_grid_list[self._walk_path_grid_list_index].furniture_id, self._walk_path_grid_list[self._walk_path_grid_list_index].action_id)
			else
				self:__set_next_path_grid()
			end

			return
		end

		self._grid_pos = var_0_6(self._walk_path_grid_list[self._walk_path_grid_list_index].grid_x, self._walk_path_grid_list[self._walk_path_grid_list_index].grid_y)

		local var_65_1 = self:__convert_to_pos(self._walk_path_grid_list[self._walk_path_grid_list_index].grid_x, self._walk_path_grid_list[self._walk_path_grid_list_index].grid_y)

		self._walk_pos_interpolation_list = {}
		self._walk_pos_interpolation_list_index = 1

		if self._walk_path_grid_list[self._walk_path_grid_list_index].move_type == "x" then
			for iter_65_0 = 1, var_0_4.dormitory_const.move_interpolation_x_num do
				self._walk_pos_interpolation_list[#self._walk_pos_interpolation_list + 1] = {
					to_pos = self._ship_rect.anchoredPosition + iter_65_0 * ((var_65_1 - self._ship_rect.anchoredPosition) / var_0_4.dormitory_const.move_interpolation_x_num)
				}
			end
		elseif self._walk_path_grid_list[self._walk_path_grid_list_index].move_type == "y" then
			for iter_65_1 = 1, var_0_4.dormitory_const.move_interpolation_y_num do
				self._walk_pos_interpolation_list[#self._walk_pos_interpolation_list + 1] = {
					to_pos = self._ship_rect.anchoredPosition + iter_65_1 * ((var_65_1 - self._ship_rect.anchoredPosition) / var_0_4.dormitory_const.move_interpolation_y_num)
				}
			end
		end

		self._walking = true
	end

	function arg_1_0.__convert_to_pos(arg_67_0, arg_67_1, arg_67_2)
		return var_0_6(arg_67_1 * var_0_4.dormitory_const.room_x_plus, arg_67_2 * var_0_4.dormitory_const.room_y_plus)
	end

	function arg_1_0.__convert_to_grid(arg_68_0, arg_68_1, arg_68_2)
		return var_0_6(var_0_13(arg_68_1 / var_0_4.dormitory_const.room_x_plus + 0.5), (var_0_13(arg_68_2 / var_0_4.dormitory_const.room_y_plus + 0.5)))
	end

	function arg_1_0:__run_time_task_list()
		for iter_69_0, iter_69_1 in ipairs(self._time_execute_task_list) do
			if iter_69_1.task_list then
				self:__execute_time_task_list(iter_69_1.task_list)
			end
		end
	end

	function arg_1_0.__execute_time_task_list(arg_70_0, arg_70_1)
		for iter_70_0, iter_70_1 in ipairs(arg_70_1) do
			if iter_70_1.execute_time > 0 then
				iter_70_1.execute_time = iter_70_1.execute_time - var_0_12.deltaTime

				if iter_70_1.execute_time <= 0 and iter_70_1.execute_func then
					iter_70_1.execute_func()

					if iter_70_0 == #arg_70_1 then
						arg_70_1 = nil
					end
				end
			end
		end
	end

	function arg_1_0:__clear_time_execute_task_list()
		for iter_71_0, iter_71_1 in ipairs(self._time_execute_task_list) do
			iter_71_1.task_list = nil
		end
	end

	function arg_1_0:__on_fall_down_end()
		self._grid_pos = self:__convert_to_grid(self._ship_rect.anchoredPosition.x, self._ship_rect.anchoredPosition.y)

		local var_72_0, var_72_1 = self._dormitory_instance:is_grid_pos_covered({
			grid_x = self._grid_pos.x,
			grid_y = self._grid_pos.y
		})
		local var_72_2 = self._dormitory_instance:__get_furniture_ele_by_id(var_72_1)

		if var_72_0 and var_72_2.config.cid == var_0_4.furniture_special_condition.on_water.swimming_pool_cid then
			self:__set_ship_move_style_by_swimming(var_72_1)
		elseif var_72_0 and var_72_2.config.type ~= var_0_4.furniture_kind_type.floor then
			self:__set_ship_move_style(var_72_1)
		end

		self:__reset_move_state(false)

		local var_72_3 = self:get_foot_position()

		self:shadow_follow(false)

		self._lifting = false

		self:__set_ship_collider_top_or_bottom("bottom")
		self:toggle_ship_collider(false)

		if self._hooking then
			self._can_lift = true

			return
		end

		if var_72_3.y <= 0 or not self:__get_fall_down_end_area(var_72_3) then
			self._drag_fall_down_on_pool = false
			self._point_down_ship = false

			self:set_ship_animation(0, self._random_event_lift_config.anim3, false)

			if self._random_event_lift_config.anim1 == "event_lift_SQ" then
				local var_72_4 = {}

				var_72_4[#var_72_4 + 1] = {
					execute_time = self._random_event_lift_config.anim3_time + 0.1,
					execute_func = function()
						self._can_lift = true

						if self._lifting_count >= 3 then
							self._lifting_count = 0

							self:set_ship_animation(0, "SP_black", true)
						else
							self:set_ship_animation(0, self._random_event_lift_config.anim4, true)
						end

						self:delay_walk((var_0_17(1, 3)))
					end
				}
				self._time_execute_task_list[5].task_list = var_72_4
			else
				self._can_lift = true

				if self._lifting_count >= 3 then
					self._lifting_count = 0

					self:set_ship_animation(0, "SP_black", true)
				else
					self:set_ship_animation(0, self._random_event_lift_config.anim4, true)
				end

				self:delay_walk((var_0_17(1, 3)))
			end

			if self._drag_in_interactive then
				self._drag_in_interactive = false
				self._action_cooling_timer = 2
				self._action_cooling = true

				self:clear_play_action_list()

				self._acting = false

				if self._interactive_furntiure then
					var_0_10:dormitory_idea_manager_request_toggle_action(self._interactive_furntiure.data.id, false)
				end

				self:delay_walk((var_0_17(var_0_4.furntiure_const.loop_num2, var_0_4.furntiure_const.loop_num3)))
			end
		end
	end

	function arg_1_0:__set_ship_move_style(arg_74_1)
		local var_74_0 = self._dormitory_instance:__get_furniture_ele_by_id(arg_74_1).config.height
		local var_74_1 = self._grid_pos.y - self._dormitory_instance:get_furniture_grid_pos(arg_74_1).y

		self._grid_pos = var_74_1 > var_74_0 * 0.5 and var_0_6(self._grid_pos.x, self._grid_pos.y + (var_74_0 - var_74_1)) or var_0_6(self._grid_pos.x, self._grid_pos.y - var_74_1)

		self:set_grid_foot_position(self._grid_pos.x, self._grid_pos.y)
	end

	function arg_1_0:__set_ship_move_style_by_swimming(arg_75_1)
		local var_75_0 = self._dormitory_instance:__get_furniture_ele_by_id(arg_75_1).config.height
		local var_75_1 = self._grid_pos.y - self._dormitory_instance:get_furniture_grid_pos(arg_75_1).y

		if self._grid_pos.y + (var_75_0 - var_75_1) - 5 < self._grid_pos.y and self._grid_pos.y < self._grid_pos.y + (var_75_0 - var_75_1) + 6 then
			self._water_bottom_obj:setVisible(false)

			self._grid_pos = var_0_6(self._grid_pos.x, self._grid_pos.y + (var_75_0 - var_75_1) + 6)
		elseif self._grid_pos.y - var_75_1 < self._grid_pos.y and self._grid_pos.y < self._grid_pos.y - var_75_1 + 8 then
			self._water_bottom_obj:setVisible(false)

			self._grid_pos = var_0_6(self._grid_pos.x, self._grid_pos.y - var_75_1)
		end

		if self._grid_pos.y > 29 then
			self._grid_pos = var_0_6(self._grid_pos.x, self._grid_pos.y - var_75_1)
		end

		self:set_grid_foot_position(self._grid_pos.x, self._grid_pos.y)
	end

	function arg_1_0:__set_inter_ship_pos(arg_76_1)
		self._ship_rect.anchoredPosition = self._ship_rect.anchoredPosition + arg_76_1
		self._ship_btn_rect.anchoredPosition = self._ship_btn_rect.anchoredPosition + arg_76_1
	end

	function arg_1_0:__check_ship_move_position(arg_77_1)
		if not self._is_exist_special_fur then
			return
		end

		local var_77_0, var_77_1 = self._dormitory_instance:__check_ship_cover_furniture(arg_77_1, self._ship_enter_pool)

		self._is_enter_pool = var_77_0

		if var_77_0 then
			if not self._is_trigger_enter and not self._move_up then
				self._is_trigger_enter = true

				self:__reset_move_condition()

				self._ship_move_const_pos = self:get_foot_position()

				local var_77_7, var_77_8, var_77_9, var_77_10 = self._dormitory_instance:__get_ship_enter_direction(arg_77_1)

				self:__set_water_ripple_animation(-360, -335, true)
				self:__set_enter_move_sonst_data(var_77_7, nil, nil, nil)

				self._move_down = true
			end

			if var_77_1 and not self._move_down and not self._is_trigger_exit then
				self._is_trigger_exit = true

				self:__reset_move_condition()

				self._ship_move_const_pos = self:get_foot_position()

				self:__set_water_ripple_animation(-335, -360, false)

				local var_77_11, var_77_12, var_77_13, var_77_14 = self._dormitory_instance:__get_ship_leave_direction(arg_77_1)

				self:__set_exit_move_sonst_data(var_77_11, var_77_12, var_77_13, var_77_14)

				self._move_up = true
			end
		else
			self:__reset_water_ripple()

			if self._dormitory_instance:__get_ship_beyond_condition(arg_77_1) then
				self:__set_role_limit_walk()
			end
		end
	end

	function arg_1_0:__reset_move_condition()
		self._acting = false
		self._walking = false

		self:clear_walk_path_grid_list()
		self:clear_walk_pos_interpolation_list()
	end

	function arg_1_0:__get_water_ripple_point()
		if not self._water_obj then
			self._water_obj, self._water_control = self:loadUIPrefab("water_ripple", self._ship_spine_obj.transform)
			self._water_bottom_obj, self._water_bottom_control = self:loadUIPrefab("water_ripple_bottom", self._control.sort_layer.rectTransform)

			self._ship_spine_obj.transform.gameObject:AddComponent(typeof(UnityEngine.UI.Mask))
		end

		self:set_water_ripple_position(640, 360)
	end

	function arg_1_0:set_water_ripple_position(arg_80_1, arg_80_2)
		self._water_obj._panel.transform:GetComponent("RectTransform").anchoredPosition = var_0_6(512, 331)
		self._water_control.point.rectTransform.anchoredPosition = var_0_6(-arg_80_1, -arg_80_2)
	end

	function arg_1_0:__reset_water_ripple()
		if self._is_exist_special_fur then
			self._water_obj:setVisible(false)
			self:set_water_ripple_position(640, 360)

			self._water_control.point.water_image.rectTransform.anchoredPosition = var_0_6(0, 63)
		end
	end

	function arg_1_0:__set_enter_move_sonst_data(arg_82_1, arg_82_2, arg_82_3, arg_82_4)
		self:__reset_enter_direction()
		self:__reset_exit_direction()

		if arg_82_1 then
			self._move_down_pos = {
				x = 0.5,
				y = -0.5
			}
			self._enter_by_left = true
		elseif arg_82_2 then
			self._move_down_pos = {
				x = -0.5,
				y = -0.5
			}
			self._enter_by_right = true
		elseif arg_82_3 then
			self._move_down_pos = {
				x = 0,
				y = -0.5
			}
			self._enter_by_up = true
		elseif arg_82_4 then
			self._move_down_pos = {
				x = 0,
				y = -0.5
			}

			self._water_obj:setVisible(false)

			self._enter_by_down = true
		end
	end

	function arg_1_0:__set_exit_move_sonst_data(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
		self:__reset_enter_direction()
		self:__reset_exit_direction()

		if arg_83_1 then
			self._move_up_pos = {
				x = -0.5,
				y = 0.5
			}
			self._move_up_end_pos = {
				x = -0.5,
				y = 0
			}
			self._exit_by_left = true
		elseif arg_83_2 then
			self._move_up_pos = {
				x = 1,
				y = 0.5
			}
			self._move_up_end_pos = {
				x = 1,
				y = 0
			}
			self._exit_by_right = true
		elseif arg_83_3 then
			self._move_up_pos = {
				x = 0,
				y = 0.5
			}
			self._move_up_end_pos = {
				x = 0,
				y = 0.5
			}
			self._exit_by_up = true
		elseif arg_83_4 then
			self._move_up_pos = {
				x = 0,
				y = -0.5
			}
			self._move_up_end_pos = {
				x = 0,
				y = -0.5
			}
			self._exit_by_down = true
		end
	end

	function arg_1_0.__reset_enter_direction(arg_84_0)
		arg_84_0._enter_by_left = false
		arg_84_0._enter_by_right = false
		arg_84_0._enter_by_up = false
		arg_84_0._enter_by_down = false
	end

	function arg_1_0.__reset_exit_direction(arg_85_0)
		arg_85_0._exit_by_left = false
		arg_85_0._exit_by_right = false
		arg_85_0._exit_by_up = false
		arg_85_0._exit_by_down = false
	end

	function arg_1_0:__reset_move_state(arg_86_1)
		if self._is_exist_special_fur then
			self._move_down = arg_86_1
			self._move_down_end = arg_86_1
			self._move_up = arg_86_1
			self._move_up_end = arg_86_1
			self._ship_enter_pool = arg_86_1
			self._is_trigger_enter = arg_86_1
			self._is_trigger_exit = arg_86_1
		end
	end

	function arg_1_0:__set_ship_exit_info()
		if self._exit_by_left then
			if self._ship_rect.anchoredPosition.x <= self._ship_move_const_pos.x - 50 then
				self:__set_random_walk()
			end
		elseif self._exit_by_right and self._ship_rect.anchoredPosition.x >= self._ship_move_const_pos.x + 50 then
			self:__set_random_walk()
		end
	end

	function arg_1_0:__set_random_walk()
		self._ship_enter_pool = false
		self._move_up_end = false

		self:add_ship_animation(0, "stand1", true, 1.333)
		self:set_ship_animation(0, "hello", false)
		self:delay_walk(1)
		self:__reset_move_state(false)
	end

	function arg_1_0:__set_curr_ship_move_position(arg_89_1, arg_89_2)
		local var_89_0 = self:get_foot_position().x
		local var_89_1 = self:get_foot_position() + var_0_6(arg_89_1, arg_89_2)
		local var_89_2 = var_89_1.x

		self:set_foot_position(var_89_1.x, var_89_1.y)
		self:set_ship_flip_x(var_89_0 < var_89_2)
	end

	function arg_1_0:__set_water_ripple_animation(arg_90_1, arg_90_2, arg_90_3)
		self._water_animation_seq = self:autoKillDOTween(var_0_16.Sequence())

		local var_90_0 = var_0_8(arg_90_2 - arg_90_1)

		arg_90_2 = arg_90_2 - 40

		if arg_90_3 then
			self._water_obj:setVisible(true)

			self._show_water_ripple = true
		end

		self._water_animation_seq:Append(self._water_control.point.transform:DOLocalMoveY(arg_90_2, var_90_0 / 40):SetEase(DG.Tweening.Ease.Linear))
		self._water_animation_seq:AppendCallback(function()
			if not arg_90_3 then
				self._water_obj:setVisible(false)

				self._show_water_ripple = false
			end
		end)
	end

	function arg_1_0.__set_drag_ship_down(arg_92_0, arg_92_1)
		arg_92_0._point_down_ship = arg_92_1
		arg_92_0._drag_fall_down_on_pool = arg_92_1
	end

	function arg_1_0:__get_fall_down_end_area(arg_93_1)
		if self._is_exist_special_fur then
			local var_93_0, var_93_1 = self._dormitory_instance:__check_ship_cover_furniture(arg_93_1, false)

			if var_93_0 then
				self._water_bottom_obj:setVisible(false)
				self._water_obj:setVisible(true)
				self:__delay_set_position_info(1)
				self:__mark_move_const()
			end

			return var_93_0
		end

		return false
	end

	function arg_1_0:__delay_set_position_info(arg_94_1)
		local var_94_0 = {}

		var_94_0[#var_94_0 + 1] = {
			execute_time = arg_94_1,
			execute_func = function()
				self._vertical_down = true

				self:__set_water_ripple_animation(-360, -335, true)
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.set_ship_move].task_list = var_94_0
	end

	function arg_1_0:__delay_start_move_condition(arg_96_1)
		local var_96_0 = {}

		var_96_0[#var_96_0 + 1] = {
			execute_time = arg_96_1,
			execute_func = function()
				self._is_trigger_enter = true
				self._drag_fall_down_on_pool = false
				self._point_down_ship = false
				self._ship_enter_pool = true
				self._is_role_trigger_beyond = false

				self:random_walk()
			end
		}
		self._time_execute_task_list[var_0_4.dormitory_const.task_list_num_tb.start_condition].task_list = var_96_0
	end

	function arg_1_0:__set_ship_move_down_end_info()
		if self._enter_by_left then
			self:__set_curr_ship_move_position(0.5, 0)

			if self._ship_rect.anchoredPosition.x >= self._ship_move_const_pos.x + 100 then
				self:__ship_move_down_addition()
			end
		elseif self._enter_by_right then
			self:__set_curr_ship_move_position(-0.5, 0)

			if self._ship_rect.anchoredPosition.x <= self._ship_move_const_pos.x - 100 then
				self:__ship_move_down_addition()
			end
		elseif self._enter_by_up or self._enter_by_down then
			self:__ship_move_down_addition()
		end
	end

	function arg_1_0:__ship_move_down_addition()
		self._move_down_end = false

		self:add_ship_animation(0, "stand1", true, 1.333)
		self:delay_walk(1)

		self._ship_enter_pool = true
		self._is_role_trigger_beyond = false
	end

	function arg_1_0:__set_ship_move_down_info()
		if self._enter_by_left or self._enter_by_right then
			if self._ship_rect.anchoredPosition.y <= self._ship_move_const_pos.y - 30 then
				self._move_down = false

				self:__mark_move_const()

				self._move_down_end = true
			end
		elseif self._enter_by_up then
			if self._ship_rect.anchoredPosition.y <= self._ship_move_const_pos.y - 20 then
				self._move_down = false

				self:__mark_move_const()

				self._move_down_end = true
			end
		elseif self._enter_by_down and self._ship_rect.anchoredPosition.y >= self._ship_move_const_pos.y + 20 then
			self._move_down = false

			self:__mark_move_const()

			self._move_down_end = true
		end
	end

	function arg_1_0:__mark_move_const()
		self._ship_move_const_pos = self:get_foot_position()
	end

	function arg_1_0:__set_ship_move_up_info()
		if self._exit_by_left or self._exit_by_right then
			if self._ship_rect.anchoredPosition.y >= self._ship_move_const_pos.y + 10 then
				self._move_up = false
				self._move_up_end = true

				self:__mark_move_const()
			end
		elseif self._exit_by_up then
			if self._ship_rect.anchoredPosition.y >= self._ship_move_const_pos.y + 30 then
				self._move_up = false

				self:__set_random_walk()
			end
		elseif self._exit_by_down and self._ship_rect.anchoredPosition.y <= self._ship_move_const_pos.y - 30 then
			self._move_up = false

			self:__set_random_walk()
		end
	end

	function arg_1_0:__set_role_limit_walk()
		if not self._is_role_trigger_beyond then
			self:__reset_move_state(false)

			self._is_role_trigger_beyond = true
		end
	end

	function arg_1_0:__excute_swimming_pool_logic()
		if self._is_exist_special_fur then
			self._can_lift = true

			if not self._point_down_ship and not self._drag_fall_down_on_pool then
				self:__check_ship_move_position(self:get_foot_position())
			end

			if self._move_down then
				self:__set_curr_ship_move_position(self._move_down_pos.x, self._move_down_pos.y)
				self:__set_ship_move_down_info()
			end

			if self._move_down_end then
				self:__set_ship_move_down_end_info()
			end

			if self._move_up then
				self:__set_curr_ship_move_position(self._move_up_pos.x, self._move_up_pos.y)
				self:__set_ship_move_up_info()
			end

			if self._move_up_end then
				self:__set_curr_ship_move_position(self._move_up_end_pos.x, self._move_up_end_pos.y)
				self:__set_ship_exit_info()
			end

			if self._vertical_down then
				self:__set_curr_ship_move_position(0, -0.5)

				if self._ship_rect.anchoredPosition.y <= self._ship_move_const_pos.y - 25 then
					self._vertical_down = false

					self:__mark_move_const()
					self:__delay_start_move_condition(2)

					local var_104_0, var_104_1 = self._dormitory_instance:__check_ship_cover_furniture(self:get_foot_position(), false)

					if var_104_0 then
						-- block empty
					else
						self._water_bottom_obj:setVisible(false)
						self._water_obj:setVisible(false)
						self:__set_water_orgin_position()
						self:random_walk()
					end
				end
			end

			self:__check_ship_move_beyound_border()
		end
	end

	function arg_1_0:__set_water_orgin_position()
		self:set_water_ripple_position(640, 360)

		self._water_control.point.water_image.rectTransform.anchoredPosition = var_0_6(0, 63)
	end

	function arg_1_0:__check_ship_move_beyound_border()
		if not self._is_role_trigger_beyond then
			local var_106_0 = self:get_foot_position()

			if var_106_0.x < var_0_4.dormitory_const.role_move_x_min or var_106_0.x > var_0_4.dormitory_const.role_move_x_max or var_106_0.y < 0 or var_106_0.y > var_0_4.dormitory_const.role_move_y_max then
				self._is_role_trigger_beyond = true

				self:add_ship_animation(0, "stand1", true, 1.333)
				self:__reset_update_condition_state()
			end
		end
	end

	function arg_1_0.__reset_update_condition_state(arg_107_0)
		arg_107_0._move_down = false
		arg_107_0._move_down_end = false
		arg_107_0._move_up = false
		arg_107_0._move_up_end = false
	end

	function arg_1_0:__set_curr_ship_move_state()
		self._is_trigger_enter = false

		self:__set_water_orgin_position()
		self:__reset_move_condition()
		self:__reset_move_state(false)
		self:__set_drag_ship_down(false)
	end

	function arg_1_0:__set_animation_pos(arg_109_1, arg_109_2, arg_109_3, arg_109_4, arg_109_5)
		local var_109_0 = self._ship_skeleton_graphic.Skeleton:FindBone("girl").X * 100

		self._ship_skeleton_graphic.initialSkinName = "normal"
		self._ship_skeleton_graphic.startingAnimation = arg_109_2
		self._ship_skeleton_graphic.startingLoop = arg_109_3

		self._ship_skeleton_graphic:Initialize(true)
		self._ship_skeleton_graphic.AnimationState:SetAnimation(0, arg_109_2, arg_109_3)

		self._girl_bone.boneName = "girl"

		local var_109_1 = self._ship_skeleton_graphic.Skeleton:FindBone("girl").X * 100

		if arg_109_5.config.action_id[1] == var_0_4.furniture_action_type.lay_down then
			local var_109_2 = var_0_8(var_109_1 - var_109_0)

			if var_109_2 > 1 then
				self._delta = var_109_2 + 5

				if not self._ship_skeleton_graphic.Skeleton.FlipX then
					self._delta = -1 * self._delta
				end

				if arg_109_2 == "lay_UP_R" then
					self._delta = -1 * self._delta
				end

				local var_109_3 = self:get_foot_position()

				self:set_foot_position(var_109_3.x + self._delta, var_109_3.y)
			end
		elseif arg_109_5.config.action_id[1] == var_0_4.furniture_action_type.sit then
			local var_109_4 = var_0_8(var_109_1 - var_109_0)

			if var_109_4 > 1 then
				local var_109_5 = var_109_4 + 5

				if not self._ship_skeleton_graphic.Skeleton.FlipX then
					var_109_5 = -1 * var_109_5
				end

				local var_109_6 = self:get_foot_position()

				self:set_foot_position(var_109_6.x + var_109_5, var_109_6.y)
			end
		end
	end

	function arg_1_0:__check_talkable_list(arg_110_1)
		local var_110_0 = false

		if self._ship_config and self._ship_config.cid then
			local var_110_1 = var_0_15.find_object_by_cid(self._ship_config.cid)

			if var_110_1 then
				for iter_110_0, iter_110_1 in pairs(var_110_1.ships) do
					if iter_110_1 == tonumber(arg_110_1) then
						var_110_0 = true

						break
					end
				end
			end
		end

		return var_110_0
	end

	function arg_1_0:__set_ship_collider_top_or_bottom(arg_111_1, arg_111_2)
		if arg_111_1 == "top" then
			if arg_111_2 == 1 then
				self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition = var_0_6(self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition.x, 30)
				self._control.sort_layer.ship.ship_collider.boxCollider2D.size = var_0_6(30, self._control.sort_layer.ship.ship_collider.boxCollider2D.size.y)
			else
				self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition = var_0_6(self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition.x, 90)
				self._control.sort_layer.ship.ship_collider.boxCollider2D.size = var_0_6(30, self._control.sort_layer.ship.ship_collider.boxCollider2D.size.y)
			end
		elseif arg_111_1 == "bottom" then
			self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition = var_0_6(self._control.sort_layer.ship.ship_collider.rectTransform.anchoredPosition.x, 0)
			self._control.sort_layer.ship.ship_collider.boxCollider2D.size = var_0_6(60, self._control.sort_layer.ship.ship_collider.boxCollider2D.size.y)
		end
	end

	function arg_1_0:_play_into_se(arg_112_1)
		self:playSE(arg_112_1, false)
	end

	function arg_1_0:__create_q_ship(arg_113_1)
		local var_113_0 = var_0_4:get_ship_spine(var_0_4.dormitory_const.ship_spine_prefab_path, arg_113_1)

		if not self:findPath(var_113_0) then
			var_113_0 = var_0_4:get_ship_spine(var_0_4.dormitory_const.ship_spine_prefab_path, 1)
		end

		self._ship_spine_obj = self:createGameObject(var_113_0)
		self._ship_spine_obj.transform:GetComponent(typeof(UnityEngine.RectTransform)).anchoredPosition = var_0_6.New(0, -50)
		self._ship_skeleton_graphic = self._ship_spine_obj.transform:GetComponent(typeof(var_0_5))
		self._ship_skeleton_graphic.material.shader = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

		self._ship_spine_obj.transform:SetParent(self._control.sort_layer.ship.spine.transform, false)

		self._ship_flipx = self._ship_skeleton_graphic.Skeleton.FlipX
	end

	function arg_1_0:__destroy_q_ship()
		if self._ship_spine_obj then
			self:destroyGameObject(self._ship_spine_obj)
		end

		self._ship_spine_obj = nil
	end

	function arg_1_0:__onReset()
		self:__destroy_q_ship()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_116_0)
	local var_116_0 = var_0_1:class("dormitory_ship")

	var_116_0._ship_data = nil
	var_116_0._sort_layer_canvas = nil
	var_116_0._ship_skeleton_graphic = nil
	var_116_0._expression_skeleton_graphic = nil
	var_116_0._grid_pos = var_0_6(0, 0)
	var_116_0._walk_path_grid_list = {}
	var_116_0._walk_path_grid_list_index = 0
	var_116_0._time_execute_task_list = {}
	var_116_0._walking = false
	var_116_0._walk_pos_interpolation_list = {}
	var_116_0._walk_pos_interpolation_list_index = 0
	var_116_0._ship_rect = nil
	var_116_0._ship_btn_rect = nil
	var_116_0._prostrating = false
	var_116_0._delta_vector = nil
	var_116_0._lifting = false
	var_116_0._fall_downing = false
	var_116_0._acting = false
	var_116_0._inter_furniture_ele = nil
	var_116_0._play_action_list = {}
	var_116_0._play_action_list_index = 0
	var_116_0._action_cooling = false
	var_116_0._action_cooling_timer = 0
	var_116_0._uiroot_canvas_rect = nil
	var_116_0._dormitory_instance = nil
	var_116_0._interactive_furntiure = nil
	var_116_0._drag_in_interactive = false
	var_116_0._is_exist_special_fur = false
	var_116_0._is_trigger_enter = false
	var_116_0._is_trigger_exit = false
	var_116_0._move_down = false
	var_116_0._move_down_end = false
	var_116_0._move_up = false
	var_116_0._move_up_end = false
	var_116_0._ship_move_const_pos = 0
	var_116_0._ship_enter_pool = false
	var_116_0._ship_walking = false
	var_116_0._water_obj = nil
	var_116_0._water_control = nil
	var_116_0._move_down_pos = {}
	var_116_0._move_up_pos = {}
	var_116_0._move_up_end_pos = {}
	var_116_0._exit_by_left = false
	var_116_0._exit_by_right = false
	var_116_0._exit_by_up = false
	var_116_0._exit_by_down = false
	var_116_0._enter_by_left = false
	var_116_0._enter_by_right = false
	var_116_0._enter_by_up = false
	var_116_0._enter_by_down = false
	var_116_0._show_water_ripple = false
	var_116_0._point_down_ship = false
	var_116_0._water_animation_seq = nil
	var_116_0._drag_fall_down_on_pool = false
	var_116_0._vertical_down = false
	var_116_0._is_role_trigger_beyond = true
	var_116_0._water_bottom_obj = nil
	var_116_0._water_bottom_control = nil
	var_116_0._is_long_click_role = false
	var_116_0._start_long_click_role_pos = nil
	var_116_0._end_long_click_role_pos = nil
	var_116_0._touch_head_count = 0
	var_116_0._is_myself_req_add_love = false
	var_116_0._random_event_lift_config = nil
	var_116_0.is_in_coffin = false
	var_116_0._lifting_count = 0
	var_116_0._talking = false
	var_116_0._ship_member_index = false
	var_116_0._touch_head = false
	var_116_0._can_lift = true
	var_116_0._hooking = false
	var_116_0._hook_furniture_id = 0

	return var_116_0
end

return var_0_0
