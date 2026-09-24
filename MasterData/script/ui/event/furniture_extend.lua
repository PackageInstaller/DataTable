local var_0_0 = {}
local var_0_3 = gameenum.common_type
local var_0_5 = UnityEngine.Vector2
local var_0_8 = gamecore.dormitory_idea
local var_0_9 = gamecore.util_func
local var_0_10 = UnityEngine.Time
local var_0_11 = math.floor
local var_0_13 = lx.Time
local var_0_14 = lx.split

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:update(arg_2_1)
		if self._is_have_ai then
			self:set_sort_order(self:__get_ship_furniture_layer(self:get_now_foot_position()))

			if self._action_cooling then
				self._action_cooling_timer = self._action_cooling_timer - var_0_10.deltaTime

				if self._action_cooling_timer < 0 then
					self._action_cooling = false
				end
			end

			for iter_2_0, iter_2_1 in pairs(self._pet_action_cooling) do
				if iter_2_1 then
					self._pet_action_cooling_timer[iter_2_0] = self._pet_action_cooling_timer[iter_2_0] - var_0_10.deltaTime

					if self._pet_action_cooling_timer[iter_2_0] < 0 then
						self._pet_action_cooling[iter_2_0] = false
					end
				end
			end

			for iter_2_2, iter_2_3 in pairs(self._pet_love_action_during) do
				if iter_2_3 then
					self._pet_love_action_during_timer[iter_2_2] = self._pet_love_action_during_timer[iter_2_2] - var_0_10.deltaTime

					if self._pet_love_action_during_timer[iter_2_2] < 0 then
						self._pet_love_action_during[iter_2_2] = false
						self._acting = false

						self:__reset_seq_list()
						self:add_ai_data(self._config.cid)
						self:random_walk()
					end
				end
			end

			if self._acting then
				if not next(self._play_action_list) then
					self._acting = false

					return
				end

				if self._play_action_list_index > #self._play_action_list then
					self._acting = false

					return
				end

				local var_2_0 = self._play_action_list[self._play_action_list_index]

				if self._play_action_list[self._play_action_list_index].type == "move" then
					if not var_2_0.keep_flip_x then
						self:set_furniture_flip_x(self:get_now_foot_position().x < var_2_0.to_pos.x)
					end

					self:set_foot_position(var_2_0.to_pos.x, var_2_0.to_pos.y)
				elseif var_2_0.type == "set_sort_order" then
					self:set_acting_sort_order(var_2_0.sort_order)
				elseif var_2_0.type == "set_animation" then
					self:set_furniture_animation(var_2_0.track_index, var_2_0.animation_name, var_2_0.loop)
				elseif var_2_0.type == "set_special_furniture_animation" then
					var_0_8:set_special_furniture_animation(var_2_0.track_index, var_2_0.animation_name, var_2_0.loop, var_2_0.furniture_ele)
				elseif var_2_0.type == "flip_x" then
					self:set_furniture_flip_x(var_2_0.flip)
				elseif var_2_0.type == "set_animal_pos" then
					self:__set_inter_animal_pos(var_2_0.diff_num)
				elseif var_2_0.type == "stop" then
					self._action_cooling_timer = var_2_0.cooling_time or 2
					self._action_cooling = true

					self:clear_play_action_list()

					self._acting = false

					if var_2_0.furniture_id then
						var_0_8:dormitory_idea_manager_request_toggle_action(var_2_0.furniture_id, false)
					end

					self:add_ai_data(self._config.cid)
					self:random_walk()
				end

				self._play_action_list_index = self._play_action_list_index + 1

				return
			end

			if self._is_walk and self._acting == false then
				local var_2_1 = self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index]

				if self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index] then
					self:set_furniture_flip_x(self:get_now_foot_position().x < var_2_1.to_pos.x)
					self:set_foot_position(var_2_1.to_pos.x, var_2_1.to_pos.y)

					self._walk_pos_interpolation_list_index = self._walk_pos_interpolation_list_index + 1

					if self._walk_pos_interpolation_list_index > #self._walk_pos_interpolation_list then
						self:__set_next_path_grid()
					end
				end

				if self._walk_path_grid_list[1] == nil then
					self:random_walk()
				end
			end

			if self._random_walk then
				self:random_walk()

				self._random_walk = false
			end
		end

		if self._is_have_clock then
			self._control.sort_layer.spine.hand_h.rectTransform.localEulerAngles = Vector3(0, 0, var_0_14(var_0_14(var_0_13:getDateString(), " ")[2], ":")[1] * -30)
			self._control.sort_layer.spine.hand_m.rectTransform.localEulerAngles = Vector3(0, 0, var_0_14(var_0_14(var_0_13:getDateString(), " ")[2], ":")[2] * -6)

			if self.is_have_s then
				self._control.sort_layer.spine.hand_s.rectTransform.localEulerAngles = Vector3(0, 0, var_0_14(var_0_14(var_0_13:getDateString(), " ")[2], ":")[3] * -6)
			end
		end

		if self._start_tennis_timer == true then
			self:countdown_time(arg_2_1)
		end

		self:__set_cake_display_case_fall_down_pos()
		self:__set_wheel_chair_move_ai()
	end

	function arg_1_0:__set_cake_display_case_fall_down_pos()
		if self._recover_orgin_pos then
			local var_3_0 = self:get_furniture_spine_postion()

			if var_3_0.y > self._furniture_orgin_pos.y then
				var_3_0.y = var_3_0.y - 6

				self:set_furniture_spine_postion(var_3_0.x, var_3_0.y)
			else
				self._recover_orgin_pos = false
			end
		end
	end

	function arg_1_0:__set_wheel_chair_move_ai()
		self:__run_time_furniture_task_list()

		if self._furniture_random_walk then
			self:random_walk()

			self._furniture_random_walk = false
			self._furniture_move_ai = true
			self._ai_walking = true
		end

		if self._furniture_move_ai and self._ai_walking then
			local var_4_0 = self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index]

			if self._walk_pos_interpolation_list[self._walk_pos_interpolation_list_index] then
				local var_4_1 = self:get_now_foot_position().x < var_4_0.to_pos.x

				self:set_furniture_flip_x(var_4_1)
				self:set_foot_position(var_4_0.to_pos.x, var_4_0.to_pos.y)

				if self._curr_inter_ship then
					self._curr_inter_ship.control:set_ship_flip_x(var_4_1)
					self._curr_inter_ship.control:set_foot_position(var_4_0.to_pos.x + ((var_4_1 or nil) and -20), var_4_0.to_pos.y)
				end

				self._walk_pos_interpolation_list_index = self._walk_pos_interpolation_list_index + 1

				if self._walk_pos_interpolation_list_index > #self._walk_pos_interpolation_list then
					self:__set_next_path_grid()
				end
			end
		end

		if self._is_stop_furniture_ai then
			if not next(self._play_action_list) then
				self._is_stop_furniture_ai = false

				return
			end

			if self._play_action_list_index > #self._play_action_list then
				self._is_stop_furniture_ai = false

				return
			end

			local var_4_3 = self._play_action_list[self._play_action_list_index]

			if self._play_action_list[self._play_action_list_index].type == "furniture_move" then
				if not var_4_3.keep_flip_x then
					self:set_furniture_flip_x(self:get_now_foot_position().x < var_4_3.to_pos.x)
				end

				local var_4_4 = self:get_now_foot_position().x < var_4_3.to_pos.x

				self:set_foot_position(var_4_3.to_pos.x, var_4_3.to_pos.y)

				if self._is_have_offet then
					local var_4_5 = 20

					if var_4_4 then
						var_4_5 = -20
					end

					self._curr_inter_ship.control:set_ship_flip_x(var_4_4)
					self._curr_inter_ship.control:set_foot_position(var_4_3.to_pos.x + var_4_5, var_4_3.to_pos.y)
				end
			elseif var_4_3.type == "set_furniture_flip_x" then
				self:set_furniture_flip_x(var_4_3.flip_x)
			elseif var_4_3.type == "set_furniture_img_alpha" then
				var_0_8:dormitory_idea_manager_update_special_furniture_alpha(var_4_3.is_active, var_4_3.furniture_ele)
			elseif var_4_3.type == "set_furniture_random_walk" then
				var_0_8:dormitory_idea_manager_set_curr_furniture_random_walk(var_4_3.furniture_id)
			elseif var_4_3.type == "request_change_spine" then
				var_0_8:dormitory_idea_manager_request_change_spine(var_4_3.furniture_id, var_4_3.config_cid, var_4_3.spine_name, var_4_3.spine_state)
			elseif var_4_3.type == "stop_furniture_move" then
				self._is_stop_furniture_ai = false

				var_0_8:dormitory_idea_manager_stop_ship_inter(var_4_3.furniture_ele)
			end

			self._play_action_list_index = self._play_action_list_index + 1

			return
		end

		self:__excute_galo_giganotus_armor_logic()
	end

	function arg_1_0:__excute_galo_giganotus_armor_logic()
		if self._is_show_fly then
			if self:get_furniture_flip_x() then
				if self:get_now_foot_position().x <= var_0_3.dormitory_const.panel_width - var_0_3.dormitory_const.fur_limit_x_max then
					local var_5_0 = var_0_5(self:get_now_foot_position().x + 3, self:get_now_foot_position().y)

					self:set_foot_position(var_5_0.x, var_5_0.y)
				else
					self._is_show_fly = false

					self:__revert_furniture_fly_end_spine()
				end
			elseif self:get_now_foot_position().x >= var_0_3.dormitory_const.fur_limit_y_max then
				local var_5_1 = var_0_5(self:get_now_foot_position().x - 3, self:get_now_foot_position().y)

				self:set_foot_position(var_5_1.x, var_5_1.y)
			else
				self._is_show_fly = false

				self:__revert_furniture_fly_end_spine()
			end
		end
	end

	function arg_1_0:__set_inter_animal_pos(arg_6_1)
		self._furniture_rect.anchoredPosition = self._furniture_rect.anchoredPosition + arg_6_1
	end

	function arg_1_0:set_acting_sort_order(arg_7_1)
		if not self._acting then
			return
		end

		self._sort_layer_canvas.sortingOrder = arg_7_1
	end

	function arg_1_0:get_now_foot_position()
		return self._furniture_rect.anchoredPosition
	end

	function arg_1_0:set_foot_position(arg_9_1, arg_9_2)
		self._grid_pos = self:__convert_to_grid(arg_9_1, arg_9_2)
		self._furniture_rect.anchoredPosition = var_0_5(arg_9_1, arg_9_2)
	end

	function arg_1_0.__convert_to_grid(arg_10_0, arg_10_1, arg_10_2)
		return var_0_5(var_0_11(arg_10_1 / var_0_3.dormitory_const.room_x_plus + 0.5), (var_0_11(arg_10_2 / var_0_3.dormitory_const.room_y_plus + 0.5)))
	end

	function arg_1_0:__set_next_path_grid()
		if self._config.cid == var_0_3.dormitory_special_furniture_id.galo_giganotus_armor and self._walk_path_grid_list_index >= #self._walk_path_grid_list then
			self:__set_furniture_random_spine()

			return
		end

		if self._walk_path_grid_list_index >= #self._walk_path_grid_list then
			self:random_walk()

			return
		end

		self._walk_path_grid_list_index = self._walk_path_grid_list_index + 1

		if self._walk_path_grid_list[self._walk_path_grid_list_index].start_action then
			if var_0_8:dormitory_idea_manager_request_action(self._furniture_data.data.id, self._walk_path_grid_list[self._walk_path_grid_list_index].furniture_id, self._walk_path_grid_list[self._walk_path_grid_list_index].action_id) and not self._action_cooling and self._acting == false then
				self._acting = true

				self:clear_walk_path_grid_list()
				self:clear_walk_pos_interpolation_list()
				var_0_8:dormitory_idea_manager_create_play_action(self._furniture_data.data.id, self._walk_path_grid_list[self._walk_path_grid_list_index].furniture_id, self._walk_path_grid_list[self._walk_path_grid_list_index].action_id, self._furniture_data, true)
			else
				self:__set_next_path_grid()
			end

			return
		end

		self._grid_pos = var_0_5(self._walk_path_grid_list[self._walk_path_grid_list_index].grid_x, self._walk_path_grid_list[self._walk_path_grid_list_index].grid_y)

		local var_11_0 = self:__convert_to_pos(self._walk_path_grid_list[self._walk_path_grid_list_index].grid_x, self._walk_path_grid_list[self._walk_path_grid_list_index].grid_y)

		self._walk_pos_interpolation_list = {}
		self._walk_pos_interpolation_list_index = 1

		if self._walk_path_grid_list[self._walk_path_grid_list_index].move_type == "x" then
			for iter_11_0 = 1, var_0_3.dormitory_const.move_interpolation_x_num do
				self._walk_pos_interpolation_list[#self._walk_pos_interpolation_list + 1] = {
					to_pos = self._furniture_rect.anchoredPosition + iter_11_0 * ((var_11_0 - self._furniture_rect.anchoredPosition) / var_0_3.dormitory_const.move_interpolation_x_num)
				}
			end
		elseif self._walk_path_grid_list[self._walk_path_grid_list_index].move_type == "y" then
			for iter_11_1 = 1, var_0_3.dormitory_const.move_interpolation_y_num do
				self._walk_pos_interpolation_list[#self._walk_pos_interpolation_list + 1] = {
					to_pos = self._furniture_rect.anchoredPosition + iter_11_1 * ((var_11_0 - self._furniture_rect.anchoredPosition) / var_0_3.dormitory_const.move_interpolation_y_num)
				}
			end
		end
	end

	function arg_1_0.set_play_action_list(arg_12_0, arg_12_1)
		arg_12_0._play_action_list = arg_12_1
		arg_12_0._play_action_list_index = 1
	end

	function arg_1_0.clear_walk_path_grid_list(arg_13_0)
		arg_13_0._walk_path_grid_list = {}
		arg_13_0._walk_path_grid_list_index = 1
	end

	function arg_1_0.clear_walk_pos_interpolation_list(arg_14_0)
		arg_14_0._walk_pos_interpolation_list = {}
		arg_14_0._walk_pos_interpolation_list_index = 1
	end

	function arg_1_0.clear_play_action_list(arg_15_0)
		arg_15_0._play_action_list = {}
		arg_15_0._play_action_list_index = 1
	end

	function arg_1_0.__convert_to_pos(arg_16_0, arg_16_1, arg_16_2)
		return var_0_5(arg_16_1 * var_0_3.dormitory_const.room_x_plus, arg_16_2 * var_0_3.dormitory_const.room_y_plus)
	end

	function arg_1_0:set_furniture_flip_x(arg_17_1)
		if self._furniture_skeleton_graphic then
			self._furniture_skeleton_graphic.Skeleton.FlipX = arg_17_1
		end
	end

	function arg_1_0:get_furniture_flip_x()
		return self._furniture_skeleton_graphic.Skeleton.FlipX
	end

	function arg_1_0:walk(arg_19_1, arg_19_2)
		self._walk_path_grid_list = {}
		self._walk_path_grid_list_index = 1
		self._now_foot_position = self._control.sort_layer.spine.rectTransform.anchoredPosition + self._spine_pos_delta
		self._grid_pos = self:__convert_to_grid(self._now_foot_position.x, self._now_foot_position.y)

		var_0_8:dormitory_idea_manager_create_walk_path_grid_list({
			walk_path_grid_list = self._walk_path_grid_list,
			to_grid_pos = {
				x = arg_19_1,
				y = arg_19_2
			},
			curr_grid_pos = {
				x = self._grid_pos.x,
				y = self._grid_pos.y
			}
		})

		if arg_19_1 > self._grid_pos.x then
			self:set_furniture_flip_x(true)
		end

		if arg_19_1 < self._grid_pos.x then
			self:set_furniture_flip_x(false)
		end

		self:__set_next_path_grid()
	end

	function arg_1_0:random_walk()
		local var_20_0, var_20_1 = var_0_8:dormitory_idea_manager_get_random_to_pos()

		if self._config.cid == var_0_3.dormitory_special_furniture_id.galo_giganotus_armor and var_20_1 > 25 then
			var_20_1 = 25
		end

		self:walk(var_20_0, var_20_1)
	end

	function arg_1_0:__random_show_furniutre_spine_walk()
		local var_21_0 = {}

		for iter_21_0 = 1, 10 do
			var_21_0[#var_21_0 + 1] = iter_21_0
		end

		local var_21_1 = var_0_9.pick_random_from_array(var_21_0)

		if var_21_1 < 4 then
			self:set_furniture_animation(0, "SP_A", false)

			local var_21_2 = {}

			var_21_2[#var_21_2 + 1] = {
				execute_time = 4,
				execute_func = function()
					self:set_furniture_animation(0, "walk_slow", true)

					self._ai_walking = true

					self:random_walk()
				end
			}
			self._fur_time_execute_task_list[var_0_3.dormitory_const.furniture_list_num_tb.first_state].task_list = var_21_2
		elseif var_21_1 == 4 then
			self:set_furniture_animation(0, "walk_slow", true)

			self._ai_walking = true

			self:random_walk()
		elseif var_21_1 >= 5 and var_21_1 < 8 then
			self._ai_walking = false

			self:clear_walk_path_grid_list()
			self:clear_walk_pos_interpolation_list()
			self:set_furniture_animation(0, "walk_quick", true)
			self:set_furniture_flip_x(var_0_9.pick_random_from_array({
				1,
				2
			}) == 1)

			self._is_show_fly = true
		else
			self._ai_walking = false

			self:set_furniture_animation(0, "stand", true)

			local var_21_3 = {}

			var_21_3[#var_21_3 + 1] = {
				execute_time = 2,
				execute_func = function()
					self:__random_show_furniutre_spine_walk()
				end
			}
			self._fur_time_execute_task_list[var_0_3.dormitory_const.furniture_list_num_tb.first_state].task_list = var_21_3
		end
	end

	function arg_1_0:__run_time_furniture_task_list()
		for iter_24_0, iter_24_1 in ipairs(self._fur_time_execute_task_list) do
			if iter_24_1.task_list then
				self:__execute_time_furniture_task_list(iter_24_1.task_list)
			end
		end
	end

	function arg_1_0.__execute_time_furniture_task_list(arg_25_0, arg_25_1)
		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			if iter_25_1.execute_time > 0 then
				iter_25_1.execute_time = iter_25_1.execute_time - var_0_10.deltaTime

				if iter_25_1.execute_time <= 0 and iter_25_1.execute_func then
					iter_25_1.execute_func()

					if iter_25_0 == #arg_25_1 then
						arg_25_1 = nil
					end
				end
			end
		end
	end

	function arg_1_0:__set_furniture_random_spine()
		self._ai_walking = false

		self:set_furniture_animation(0, "stand", true)

		local var_26_0 = {}

		var_26_0[#var_26_0 + 1] = {
			execute_time = 3,
			execute_func = function()
				self:__random_show_furniutre_spine_walk()
			end
		}
		self._fur_time_execute_task_list[var_0_3.dormitory_const.furniture_list_num_tb.first_state].task_list = var_26_0
	end

	function arg_1_0:__set_furniture_fly_spine()
		if var_0_9.pick_random_from_array(var_0_3.dormitory_const.fur_fly_time_random_list) == 6 then
			self._ai_walking = false

			self:clear_walk_path_grid_list()
			self:clear_walk_pos_interpolation_list()
			self:set_furniture_animation(0, "walk_quick", true)
			self:set_furniture_flip_x(var_0_9.pick_random_from_array({
				1,
				2
			}) == 1)

			self._is_show_fly = true

			return true
		end

		return false
	end

	function arg_1_0:__revert_furniture_fly_end_spine()
		self:set_furniture_animation(0, "walk_quick_stop", false)

		local var_29_0 = {}

		var_29_0[#var_29_0 + 1] = {
			execute_time = 2.333,
			execute_func = function()
				self:set_furniture_animation(0, "walk_slow", true)

				self._ai_walking = true

				self:random_walk()
			end
		}
		self._fur_time_execute_task_list[var_0_3.dormitory_const.furniture_list_num_tb.third_state].task_list = var_29_0
	end

	function arg_1_0.__get_ship_furniture_layer(arg_31_0, arg_31_1)
		local var_31_0 = var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + math.ceil((1 - arg_31_1.y / var_0_3.dormitory_const.room_bg_wall_y) * (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain))

		var_31_0 = var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain) < var_31_0 and var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain + (var_0_3.dormitory_const.layer_offset - var_0_3.dormitory_const.layer_remain) or var_31_0
		var_31_0 = var_31_0 <= var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain and var_0_3.ui_layer.middle + var_0_3.dormitory_const.layer_remain or var_31_0

		return var_31_0
	end
end

function var_0_0.extend_obj(arg_32_0)
	return
end

return var_0_0
