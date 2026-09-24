local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_3 = gameenum.common_type
local var_0_5 = UnityEngine.RectTransformUtility
local var_0_7 = gamecore.dormitory_idea
local var_0_8 = lan_rand

function var_0_0.extend_method(arg_1_0)
	function arg_1_0.__onClick_sort_layer_ship_btn(arg_2_0)
		return
	end

	function arg_1_0:__onPointerDown_sort_layer_ship_btn()
		if self._is_exist_special_fur then
			return
		end

		if self._prostrating then
			self:__raise_ship()

			return
		end

		self._walking = false

		var_0_7:dormitory_idea_manager_drag_stop(self._ship_data.id)
		self:__reset_move_state(false)
	end

	function arg_1_0:__onPointerUp_sort_layer_ship_btn()
		if self._walk_pos_interpolation_list and next(self._walk_pos_interpolation_list) then
			self._walking = true
		end

		if self._lifting then
			self._time_execute_task_list[5].task_list = nil

			self:set_ship_animation(0, self._random_event_lift_config.anim5, false)

			if self._random_event_lift_config.anim1 == "event_lift_SQ" then
				self._lifting_count = self._lifting_count + 1

				if self._lifting_count >= 3 then
					self:clear_expression_animation()
					self:set_expression_animation(0, "black_line", false, 2)
				else
					self:clear_expression_animation()
					self:set_expression_animation(0, "X", false, 1)
				end

				self:toggle_ship_collider(true)
				self:__set_ship_collider_top_or_bottom("top", 1)
			else
				self:toggle_ship_collider(true)
				self:__set_ship_collider_top_or_bottom("top")
			end

			self._end_lifting_pos = self._ship_rect.anchoredPosition.y > var_0_3.dormitory_const.room_bg_wall_y and var_0_3.dormitory_const.room_bg_wall_y or self._ship_rect.anchoredPosition.y

			self:fall_down()
		end
	end

	function arg_1_0:__onBeginDrag_sort_layer_ship_btn(arg_5_1, arg_5_2)
		self:_play_into_se(var_0_3:get_audio_url(var_0_3.common_icon.music_path, var_0_3.ship_lift_up))

		self._start_long_click_role_pos = var_0_1(arg_5_1, arg_5_2)

		if self._prostrating then
			return
		end

		if self._lifting then
			return
		end

		self._walking = false

		if self._inter_furniture_ele and self._inter_furniture_ele.data.id then
			self._acting = false

			var_0_7:dormitory_idea_manager_request_action(self._ship_data.id, self._inter_furniture_ele.data.id)

			if self._inter_furniture_ele.control and self._inter_furniture_ele.control._furniture_skeleton_graphic then
				self._inter_furniture_ele.control:set_furniture_animation(0, self._inter_furniture_ele.control._furniture_skeleton_graphic.startingAnimation, true)
			end

			self:clear_inter_furniture_element()
		end

		self:toggle_ship_collider(false)
	end

	function arg_1_0:__onDrag_sort_layer_ship_btn(arg_6_1, arg_6_2)
		if self._fall_downing or not self._can_lift then
			return
		end

		if next(self._play_action_list) and not self._touch_head then
			self:clear_play_action_list()

			self._drag_in_interactive = true
		end

		if self._prostrating then
			return
		end

		if not self._lifting then
			if math.abs(arg_6_1 - self._start_long_click_role_pos.x) >= 40 then
				if self._touch_head then
					return
				end

				if self._hooking then
					return
				end

				if self._is_exist_special_fur and self._is_enter_pool then
					return
				end

				self._touch_head = true
				self._acting = false
				self._walk_pos_interpolation_list = {}

				self:__clear_time_execute_task_list()
				self:excute_ship_expression_logic()
			elseif math.abs(arg_6_2 - self._start_long_click_role_pos.y) >= 30 then
				if self._touch_head then
					self._touch_head = false
				end

				self:__reset_water_ripple()

				if self._is_exist_special_fur then
					self._point_down_ship = true

					self:__set_water_orgin_position()
				end

				if self._hooking then
					for iter_6_0, iter_6_1 in pairs(self._dormitory_instance._curr_furniture_tb) do
						if iter_6_1.config.cid == self._hook_furniture_id then
							iter_6_1.control:toggle_furniture_collider(true)
						end
					end

					self._hooking = false
					self._hook_furniture_id = 0
				end

				self._lifting = true
				self._acting = false
				self._walk_pos_interpolation_list = {}

				self:__clear_time_execute_task_list()
				self:clear_expression_animation()

				self._random_event_lift_config = var_0_3.dormitory_drag_up_ship_comfig[var_0_8(1, 2)]

				self:set_ship_animation(0, self._random_event_lift_config.anim1, false)

				local var_6_0 = {}

				var_6_0[#var_6_0 + 1] = {
					execute_time = self._random_event_lift_config.anim1_time,
					execute_func = function()
						self:set_ship_animation(0, self._random_event_lift_config.anim2, true)
					end
				}
				self._time_execute_task_list[5].task_list = var_6_0

				local var_6_1, var_6_2 = var_0_5.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_1(arg_6_1, arg_6_2), nil, nil)

				if var_6_1 then
					self._delta_vector = self._ship_btn_rect.anchoredPosition - var_6_2
				end
			end
		end

		if self._lifting then
			local var_6_3, var_6_4 = var_0_5.ScreenPointToLocalPointInRectangle(self._uiroot_canvas_rect, var_0_1(arg_6_1, arg_6_2), nil, nil)

			if var_6_3 then
				local var_6_5 = self._delta_vector + var_6_4 - self._ship_btn_rect.anchoredPosition

				var_6_5.x = math.abs((self._delta_vector + var_6_4 - self._ship_btn_rect.anchoredPosition).x) <= 2.5 and 0 or var_6_5.x
				var_6_5.y = math.abs(var_6_5.y) <= 2.5 and 0 or var_6_5.y
				self.velocity = var_0_1.Normalize(var_6_5) * 20
				self.velocity.y = self.velocity.y >= 15 and 15 or self.velocity.y
				self._ship_btn_rect.anchoredPosition = self._delta_vector + var_6_4
				self._ship_rect.anchoredPosition = self._delta_vector + var_6_4
			end

			if self._ship_btn_rect.anchoredPosition.y < 0 then
				self._ship_btn_rect.anchoredPosition = var_0_1(self._ship_btn_rect.anchoredPosition.x, 0)
				self._ship_rect.anchoredPosition = var_0_1(self._ship_rect.anchoredPosition.x, 0)
			end

			local var_6_6 = 180

			if self._ship_btn_rect.anchoredPosition.y > var_0_3.dormitory_const.panel_height - 180 then
				self._ship_btn_rect.anchoredPosition = var_0_1(self._ship_btn_rect.anchoredPosition.x, var_0_3.dormitory_const.panel_height - var_6_6)
				self._ship_rect.anchoredPosition = var_0_1(self._ship_rect.anchoredPosition.x, var_0_3.dormitory_const.panel_height - var_6_6)
			end

			local var_6_7 = 30

			if 30 > self._ship_btn_rect.anchoredPosition.x then
				self._ship_btn_rect.anchoredPosition = var_0_1(var_6_7, self._ship_btn_rect.anchoredPosition.y)
				self._ship_rect.anchoredPosition = var_0_1(var_6_7, self._ship_btn_rect.anchoredPosition.y)
			end

			if self._ship_btn_rect.anchoredPosition.x > var_0_3.dormitory_const.panel_width - var_6_7 then
				self._ship_btn_rect.anchoredPosition = var_0_1(var_0_3.dormitory_const.panel_width - var_6_7, self._ship_btn_rect.anchoredPosition.y)
				self._ship_rect.anchoredPosition = var_0_1(var_0_3.dormitory_const.panel_width - var_6_7, self._ship_btn_rect.anchoredPosition.y)
			end

			self:shadow_follow(true)
		end
	end

	function arg_1_0:__onEndDrag_sort_layer_ship_btn(arg_8_1, arg_8_2)
		self._end_long_click_role_pos = var_0_1(arg_8_1, arg_8_2)

		if self._prostrating then
			return
		end

		if not self._lifting then
			return
		end

		self:set_water_pos_by_fall_down(true)
	end

	function arg_1_0:__onTriggerEnter2D_sort_layer_ship_ship_collider(arg_9_1)
		local var_9_0 = arg_9_1.gameObject:GetComponent("Trigger2DEvent")

		if not var_9_0 then
			return
		end

		if var_9_0.colliderName == "animal" then
			var_0_7.now_enter_ship_cid = self._ship_data.cid
		end

		if self._prostrating then
			return
		end

		if self._talking then
			return
		end

		if self._ship_enter_pool then
			return
		end

		local var_9_1 = var_9_0.colliderName

		if var_9_0.colliderName == "hook" then
			self._hooking = true

			for iter_9_0, iter_9_1 in pairs(self._dormitory_instance._curr_furniture_tb) do
				if iter_9_1.collider == arg_9_1.gameObject then
					self._hook_furniture_id = iter_9_1.config.cid

					iter_9_1.control:set_furniture_animation(0, "normalG", true)
					iter_9_1.control:toggle_furniture_collider(false)

					local var_9_2 = iter_9_1.control:get_foot_position()

					if iter_9_1.config.furniture_type == var_0_3.furniture_pos_type.ceiling then
						self:set_foot_position(var_9_2.x, var_9_2.y - self._ship_btn_rect.sizeDelta.y * 0.9)

						self._random_event_lift_config = var_0_3.dormitory_drag_up_ship_comfig[1]

						self:set_ship_animation(0, self._random_event_lift_config.anim1, false)

						local var_9_3 = {}

						var_9_3[#var_9_3 + 1] = {
							execute_time = self._random_event_lift_config.anim1_time,
							execute_func = function()
								self:set_ship_animation(0, self._random_event_lift_config.anim2, true)
							end
						}
						self._time_execute_task_list[5].task_list = var_9_3
					elseif iter_9_1.config.furniture_type == var_0_3.furniture_pos_type.wall then
						self:set_foot_position(var_9_2.x, var_9_2.y - self._ship_btn_rect.sizeDelta.y * 1.2)
						self:set_ship_animation(0, "lift_NEW", true, 0.3)
					end
				end
			end
		end

		if self._lifting then
			return
		end

		if var_9_1 == "ship" then
			if not self._dormitory_instance._ship_members_tb[var_9_0.index] or self._dormitory_instance._ship_members_tb[var_9_0.index].control._prostrating or self._dormitory_instance._ship_members_tb[var_9_0.index].control._lifting then
				return
			end

			if not self:__check_talkable_list(self._dormitory_instance._ship_members_tb[var_9_0.index].config.cid) then
				return
			end

			local var_9_4 = var_0_8(3, 4)

			self._talking = true

			self:clear_idea()
			self:set_ship_animation(0, "talk", false)
			self:set_expression_animation(0, "event_silent", false, 3)
			self:delay_walk(var_9_4)
		end

		if var_9_1 == "race_car" then
			self:clear_idea()
			var_0_7:dormitory_idea_manager_knock_fly_by_car(self._ship_data.id)
		end
	end

	function arg_1_0.__onTriggerStay2D_sort_layer_ship_ship_collider(arg_11_0, arg_11_1)
		return
	end

	function arg_1_0:__onTriggerExit2D_sort_layer_ship_ship_collider(arg_12_1)
		local var_12_0 = arg_12_1.gameObject:GetComponent("Trigger2DEvent")

		if not var_12_0 then
			return
		end

		if var_12_0.colliderName == "ship" then
			self._talking = false
		end

		if var_12_0.colliderName == "animal" then
			var_0_7.now_enter_ship_cid = nil
			var_0_7.now_exit_ship_cid = self._ship_data.cid
		end
	end

	function arg_1_0.__onLongClick_sort_layer_ship_btn(arg_13_0)
		return
	end

	function arg_1_0.__onPointerClick_sort_layer_ship_btn(arg_14_0)
		return
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
