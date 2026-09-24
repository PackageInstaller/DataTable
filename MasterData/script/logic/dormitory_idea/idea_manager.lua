local var_0_0 = {}
local var_0_2 = string.sub
local var_0_4 = table.insert
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.util_func
local var_0_8 = math.ceil
local var_0_9 = UnityEngine.Vector2
local var_0_10 = string.format
local var_0_11 = UnityEngine.Time
local var_0_12 = UnityEngine.Mathf
local var_0_13 = math.abs
local var_0_14 = gamecore.user
local var_0_15 = gameconfig.ship_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_idea_manager_init(arg_2_1)
		self._curr_furniture_tb = arg_2_1.curr_furniture_tb
		self._curr_room_floor_furniture_tb = arg_2_1.curr_room_bg_tb
		self._ship_members_tb = arg_2_1.ship_members_tb
		self._dormitory_instance = arg_2_1.dormitory_instance

		self:dormitory_idea_manager_remove_no_exist_ship(arg_2_1.curr_remove_list)
		self:dormitory_idea_manager_set_random_stand_pos(arg_2_1)

		if not self:get_curr_inter_furniture_state() then
			self:__dormitory_idea_manager_init_furniture_interact_tb()
		end

		self:__set_galo_ship_info()
	end

	function arg_1_0:dormitory_idea_manager_destroy()
		self._curr_furniture_tb = nil
		self._curr_room_floor_furniture_tb = nil
		self._ship_members_tb = nil
		self._dormitory_instance = nil

		if self._furniture_interact_tb and self._furniture_interact_tb.race_car_tb then
			for iter_3_0, iter_3_1 in pairs(self._furniture_interact_tb.race_car_tb) do
				if iter_3_1 then
					iter_3_1.ship_ele = nil
					iter_3_1.car_ele = nil
					iter_3_1 = nil
				end
			end
		end

		if self._furniture_interact_tb and self._furniture_interact_tb.inter_car_tb then
			for iter_3_2, iter_3_3 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_3_3 then
					iter_3_3.ship_ele = nil
					iter_3_3.car_ele = nil
					iter_3_3 = nil
				end
			end
		end

		if self._furniture_interact_tb then
			self._furniture_interact_tb.race_car_tb = nil
			self._furniture_interact_tb.inter_car_tb = nil
		end

		self:__dormitory_idea_manager_reset_inter_car_state(false)

		self._furniture_interact_tb = nil
		self._start_race_car = false
		self._start_inter_car = false

		self:kill_all_seq()
	end

	function arg_1_0:dormitory_idea_manager_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if self._start_race_car then
			for iter_4_0, iter_4_1 in pairs(self._furniture_interact_tb.race_car_tb) do
				iter_4_1.speed = var_0_12.Lerp(iter_4_1.speed, iter_4_1.target_speed, 0.1)

				if iter_4_1.speed_up then
					iter_4_1.target_speed = iter_4_1.target_speed + 15

					if iter_4_1.target_speed > iter_4_1.full_speed then
						iter_4_1.speed_up = false
						iter_4_1.target_speed = iter_4_1.full_speed
					end
				end

				local var_4_0 = iter_4_1.car_ele.control:get_spine_position()

				iter_4_1.car_ele.control:set_spine_position(var_4_0 - var_0_9(1, 0) * var_0_11.deltaTime * iter_4_1.speed)

				local var_4_1 = iter_4_1.car_ele.control:get_spine_position() + iter_4_1.ship_delta_pos

				iter_4_1.ship_ele.control:set_foot_position_without_record(var_4_1.x, var_4_1.y)

				if var_4_0.x < -50 then
					iter_4_1.car_ele.control:set_spine_position(var_4_0 + var_0_9(1, 0) * 1400)
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_toggle_barricade_drive_car(arg_5_1, arg_5_2)
		if self._inter_car_state == var_0_5.furniture_inter_type.ordinary_inter then
			if not self._start_inter_car then
				return
			end

			if not self._furniture_interact_tb or not self._furniture_interact_tb.inter_car_tb then
				return
			end

			local var_5_0

			for iter_5_0, iter_5_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if arg_5_1 == iter_5_1.car_id then
					var_5_0 = iter_5_1

					break
				end
			end

			self:dormitory_idea_manager_set_car_state(var_5_0, arg_5_2)
		elseif self._inter_car_state == var_0_5.furniture_inter_type.special_inter then
			if not self._start_race_car then
				return
			end

			if not self._furniture_interact_tb or not self._furniture_interact_tb.race_car_tb then
				return
			end

			local var_5_1

			for iter_5_2, iter_5_3 in pairs(self._furniture_interact_tb.race_car_tb) do
				if arg_5_1 == iter_5_3.car_id then
					var_5_1 = iter_5_3

					break
				end
			end

			self:dormitory_idea_manager_set_car_state(var_5_1, arg_5_2)
			self:dormitory_idea_manager_race_car_stop_single_inter(arg_5_1)
		end

		if self._galo_start_inter and arg_5_2 then
			local var_5_2

			for iter_5_4, iter_5_5 in pairs(self._furniture_interact_tb.galo_car_tb) do
				if arg_5_1 == iter_5_5.car_id then
					var_5_2 = iter_5_5

					break
				end
			end

			for iter_5_6, iter_5_7 in pairs(self._furniture_interact_tb.galo_car_tb) do
				if arg_5_1 == iter_5_7.car_id and iter_5_7.is_interactive then
					iter_5_7.is_interactive = false

					iter_5_7.galo_call_back()

					break
				end
			end

			self:dormitory_idea_manager_set_car_state(var_5_2, arg_5_2)
		end

		self:dormitory_idea_manager_stop_bike_touch_barrier(arg_5_1, arg_5_2)
	end

	function arg_1_0.dormitory_idea_manager_set_car_state(arg_6_0, arg_6_1, arg_6_2)
		if not arg_6_1 then
			return
		end

		if arg_6_2 then
			arg_6_1.speed_up = false
			arg_6_1.target_speed = 0
		else
			arg_6_1.speed_up = true
		end
	end

	function arg_1_0:dormitory_idea_manager_race_car_stop_single_inter(arg_7_1)
		if self._furniture_interact_tb.race_car_tb[arg_7_1] then
			self._furniture_interact_tb.race_car_tb[arg_7_1].car_ele.control:set_furniture_animation(0, "normal", true)
		end
	end

	function arg_1_0:dormitory_idea_manager_request_drive_car(arg_8_1, arg_8_2)
		if self._start_race_car then
			return
		end

		if self._furniture_interact_tb.race_car_tb then
			if self._furniture_interact_tb.race_car_tb[arg_8_2] then
				self._furniture_interact_tb.race_car_tb[arg_8_2].driver_id = arg_8_1
				self._furniture_interact_tb.race_car_tb[arg_8_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_8_1)
				self._furniture_interact_tb.race_car_tb[arg_8_2].ship_delta_pos = self._furniture_interact_tb.race_car_tb[arg_8_2].ship_ele.control:get_foot_position() - self._furniture_interact_tb.race_car_tb[arg_8_2].car_ele.control:get_spine_position()
				self._furniture_interact_tb.race_car_tb[arg_8_2].sitted = true
				self._furniture_interact_tb.race_car_tb[arg_8_2].speed_up = true
			end
		end

		if self:get_race_furniture_inter_state() then
			if not self:dormitory_idea_manager_is_all_race_car_be_sitted() then
				return
			end

			if self._furniture_interact_tb and self._furniture_interact_tb.race_car_tb then
				for iter_8_0, iter_8_1 in pairs(self._furniture_interact_tb.race_car_tb) do
					iter_8_1.car_ele.control:toggle_furniture_collider(true)
					iter_8_1.car_ele.control:set_furniture_animation(0, "start", true)
				end
			end

			self._start_race_car = true

			if self._ship_members_tb then
				for iter_8_2, iter_8_3 in ipairs(self._ship_members_tb) do
					if not self:dormitory_idea_manager_is_ship_sitting_car(iter_8_3.data.id) then
						iter_8_3.control:toggle_ship_collider(true)
					else
						iter_8_3.control:toggle_ship_collider(false)
					end
				end
			end

			self:dormitory_idea_manager_reset_all_collider_inactive_state()
		else
			self._furniture_interact_tb.race_car_tb[arg_8_2].car_ele.control:set_furniture_animation(0, "start", true)
		end
	end

	function arg_1_0:open_all_ships_collider()
		if self._ship_members_tb then
			for iter_9_0, iter_9_1 in ipairs(self._ship_members_tb) do
				iter_9_1.control:toggle_ship_collider(true)
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_reset_all_collider_inactive_state()
		if self._curr_furniture_tb then
			for iter_10_0, iter_10_1 in ipairs(self._curr_furniture_tb) do
				if iter_10_1.config.special_type == var_0_5.furniture_special_type.barricade then
					iter_10_1.control:toggle_furniture_collider(true)
				elseif iter_10_1.config.special_type == var_0_5.furniture_special_type.galo_barricade then
					iter_10_1.control:toggle_furniture_collider(true)
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_is_ship_sitting_car(arg_11_1)
		if not self._furniture_interact_tb.race_car_tb then
			return false
		end

		local var_11_0 = false

		for iter_11_0, iter_11_1 in pairs(self._furniture_interact_tb.race_car_tb) do
			if arg_11_1 == iter_11_1.driver_id then
				var_11_0 = true

				break
			end
		end

		return var_11_0
	end

	function arg_1_0:dormitory_idea_manager_knock_fly_by_car(arg_12_1)
		local var_12_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_12_1)

		var_12_0.control:toggle_acting_tag(true)
		self:dormitory_rest_idea_create_knock_fly({
			ship_ele = var_12_0
		})
	end

	function arg_1_0:set_running_car_speed_touch_barrier(arg_13_1)
		local var_13_0

		if self._furniture_interact_tb.old_bike_car_tb then
			var_13_0 = self._furniture_interact_tb.old_bike_car_tb
		end

		if self._furniture_interact_tb.inter_car_tb then
			var_13_0 = self._furniture_interact_tb.inter_car_tb
		end

		if self._furniture_interact_tb.galo_car_tb then
			var_13_0 = self._furniture_interact_tb.galo_car_tb
		end

		for iter_13_0, iter_13_1 in pairs((self._furniture_interact_tb.race_car_tb or nil) and self._furniture_interact_tb.race_car_tb) do
			if iter_13_1.car_id == arg_13_1 then
				iter_13_1.speed_up = true
				iter_13_1.speed = 10
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_is_racing_car()
		return self._start_race_car
	end

	function arg_1_0:dormitory_idea_manager_stop_race_car()
		if not self._start_race_car then
			return
		end

		self._start_race_car = false

		if not self._furniture_interact_tb.race_car_tb then
			return
		end

		for iter_15_0, iter_15_1 in pairs(self._furniture_interact_tb.race_car_tb) do
			if iter_15_1 then
				iter_15_1.sitted = false
				iter_15_1.driver_id = -1
				iter_15_1.ship_ele = nil
				iter_15_1.ship_delta_pos = nil

				if iter_15_1.car_ele then
					iter_15_1.car_ele.control:toggle_furniture_collider(false)
					iter_15_1.car_ele.control:set_furniture_animation(0, "normal", true)
					iter_15_1.car_ele.control:set_spine_position(iter_15_1.car_spine_original_pos)
				end
			end
		end

		self:dormitory_idea_manager_reset_all_collider_active_state()
	end

	function arg_1_0:dormitory_idea_manager_reset_all_collider_active_state()
		if self._ship_members_tb and not self:__get_animal_furniture_info() then
			for iter_16_0, iter_16_1 in ipairs(self._ship_members_tb) do
				iter_16_1.control:toggle_ship_collider(false)
			end
		end

		if self._curr_furniture_tb then
			for iter_16_2, iter_16_3 in ipairs(self._curr_furniture_tb) do
				if iter_16_3.config.special_type == var_0_5.furniture_special_type.barricade then
					iter_16_3.control:toggle_furniture_collider(false)
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_get_random_to_pos()
		if not self._dormitory_instance then
			return
		end

		local var_17_0 = var_0_6.pick_random_from_array((self._dormitory_instance:get_walkable_grid_list()))

		return var_17_0.grid_x, var_17_0.grid_y
	end

	function arg_1_0:dormitory_idea_manager_create_walk_path_grid_list(arg_18_1)
		local var_18_0 = arg_18_1.to_grid_pos
		local var_18_1 = arg_18_1.curr_grid_pos

		self._delta_y_data = nil
		self._delta_x_data = nil

		if var_18_0.x and var_18_1.x and var_18_0.x ~= var_18_1.x then
			for iter_18_0 = var_18_1.x + (var_18_0.x > var_18_1.x and 1 or -1), var_18_0.x, var_18_0.x > var_18_1.x and 1 or -1 do
				local var_18_4, var_18_5 = self._dormitory_instance:is_grid_pos_covered({
					grid_x = iter_18_0,
					grid_y = var_18_1.y
				})

				if var_18_4 then
					local var_18_6 = self._dormitory_instance:__get_furniture_ele_by_id(var_18_5)
					local var_18_7 = self:__dormitory_idea_manager_check_action(var_18_6.config.action_id, arg_18_1.walk_path_grid_list, var_18_5, var_18_6)

					if not self._delta_y_data then
						local var_18_8 = var_18_1.y - self._dormitory_instance:get_furniture_grid_pos(var_18_5).y

						if var_18_8 > 0 and var_18_8 < var_18_6.config.height then
							local var_18_9

							if var_18_0.y > var_18_1.y then
								var_18_9 = var_18_6.config.height - var_18_8 or -var_18_8
							end

							local var_18_10 = var_18_9 > 0 and 1 or -1

							for iter_18_1 = var_18_9 > 0 and 1 or -1, var_18_9, var_18_9 > 0 and 1 or -1 do
								var_18_1.y = var_18_1.y + var_18_10
								arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
									move_type = "y",
									grid_x = var_18_1.x,
									grid_y = var_18_1.y
								}
							end

							if var_0_13(var_18_0.x - iter_18_0) > var_18_6.config.width then
								self._delta_y_data = {
									delta = var_18_9,
									furniture_width = var_18_6.config.width
								}
							end
						end
					end
				end

				if self._delta_y_data then
					if self._delta_y_data.furniture_width <= 0 then
						local var_18_11 = -self._delta_y_data.delta > 0 and 1 or -1

						for iter_18_2 = -self._delta_y_data.delta > 0 and 1 or -1, -self._delta_y_data.delta, -self._delta_y_data.delta > 0 and 1 or -1 do
							var_18_1.y = var_18_1.y + var_18_11
							arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
								move_type = "y",
								grid_x = var_18_1.x,
								grid_y = var_18_1.y
							}
						end

						self._delta_y_data = nil
					else
						self._delta_y_data.furniture_width = self._delta_y_data.furniture_width - 1
					end
				end

				arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
					move_type = "x",
					grid_x = iter_18_0,
					grid_y = var_18_1.y
				}
				var_18_1.x = iter_18_0
			end
		end

		if var_18_0.y and var_18_1.y and var_18_0.y ~= var_18_1.y then
			for iter_18_3 = var_18_1.y + (var_18_0.y > var_18_1.y and 1 or -1), var_18_0.y, var_18_0.y > var_18_1.y and 1 or -1 do
				local var_18_12, var_18_13 = self._dormitory_instance:is_grid_pos_covered({
					grid_x = var_18_1.x,
					grid_y = iter_18_3
				})

				if var_18_12 then
					local var_18_14 = self._dormitory_instance:__get_furniture_ele_by_id(var_18_13)
					local var_18_15 = self:__dormitory_idea_manager_check_action(var_18_14.config.action_id, arg_18_1.walk_path_grid_list, var_18_13, var_18_14)

					if not self._delta_x_data then
						local var_18_16 = self._dormitory_instance:get_furniture_grid_pos(var_18_13)

						if var_18_1.x - var_18_16.x > 0 and var_18_1.x - var_18_16.x < var_18_14.config.width then
							local var_18_17

							if var_18_0.x > var_18_16.x then
								var_18_17 = var_18_14.config.width - (var_18_1.x - var_18_16.x) or -(var_18_1.x - var_18_16.x)
							end

							local var_18_18 = var_18_17 > 0 and 1 or -1

							for iter_18_4 = var_18_17 > 0 and 1 or -1, var_18_17, var_18_17 > 0 and 1 or -1 do
								var_18_1.x = var_18_1.x + var_18_18
								arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
									move_type = "x",
									grid_x = var_18_1.x,
									grid_y = var_18_1.y
								}
							end

							var_18_1.x = var_18_1.x + var_18_17

							if var_0_13(var_18_0.y - iter_18_3) > var_18_14.config.height then
								self._delta_x_data = {
									delta = var_18_17,
									furniture_height = var_18_14.config.height
								}
							end
						end
					end
				end

				if self._delta_x_data then
					if self._delta_x_data.furniture_height <= 0 then
						local var_18_19 = -self._delta_x_data.delta > 0 and 1 or -1

						for iter_18_5 = -self._delta_x_data.delta > 0 and 1 or -1, -self._delta_x_data.delta, -self._delta_x_data.delta > 0 and 1 or -1 do
							var_18_1.x = var_18_1.x + var_18_19
							arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
								move_type = "x",
								grid_x = var_18_1.x,
								grid_y = var_18_1.y
							}
						end

						self._delta_x_data = nil
					else
						self._delta_x_data.furniture_height = self._delta_x_data.furniture_height - 1
					end
				end

				arg_18_1.walk_path_grid_list[#arg_18_1.walk_path_grid_list + 1] = {
					move_type = "y",
					grid_x = var_18_1.x,
					grid_y = iter_18_3
				}
				var_18_1.y = iter_18_3
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_request_action(arg_19_1, arg_19_2, arg_19_3)
		return not self._furniture_interact_tb[arg_19_2]
	end

	function arg_1_0:dormitory_idea_manager_create_play_action(arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
		self._furniture_interact_tb[arg_20_2] = true

		local var_20_0 = self._dormitory_instance:get_ship_ele_by_id(arg_20_1)

		if arg_20_5 then
			var_20_0 = self._dormitory_instance:__get_furniture_ele_by_id(arg_20_1)
		end

		local var_20_1 = self._dormitory_instance:__get_furniture_ele_by_id(arg_20_2)
		local var_20_2 = {
			ship_ele = var_20_0,
			furniture_ele = var_20_1,
			curr_furniture_tb = self._curr_furniture_tb,
			ship_members_tb = self._ship_members_tb,
			walkable_ground_grid_tb = self._walkable_ground_grid_tb,
			dormitory_instance = self._dormitory_instance,
			animla_data = arg_20_4
		}

		var_20_0.control._interactive_furntiure = var_20_1

		if not var_20_2.animla_data and var_20_2.furniture_ele then
			if arg_20_3 == var_0_5.furniture_action_type.sit then
				self:dormitory_rest_idea_create_sit_down(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.swim_ring then
				self:dormitory_rest_idea_create_lay_swim_ring(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.water_slides then
				self:dormitory_rest_idea_create_play_water_slides(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.water_motorcycle then
				self:dormitory_rest_idea_water_motorcycle(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.drive_car or arg_20_3 == var_0_5.furniture_action_type.hand_car then
				self:__dormitory_idea_manager_set_interactive_type(var_20_1.config.cid, var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.djbox then
				self:dormitory_play_idea_create_play_djbox(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.skateboard then
				self:dormitory_play_idea_create_play_skateboard(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.veneto then
				self:dormitory_play_idea_create_sit_veneto(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.asura_car then
				self:dormitory_rest_idea_asura_drive_car(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.old_bike then
				self:dormitory_rest_idea_take_old_bike(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.tree_swing then
				self:dormitory_rest_idea_play_tree_swing(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.hit_melon then
				self:start_play_melon_inter(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.youth_shoot_machine then
				self:dormitory_rest_idea_youth_shoot_machine(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.king_of_combat or arg_20_3 == var_0_5.furniture_action_type.best_drift then
				self:dormitory_rest_idea_king_of_combat(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.magic_wand then
				self:dormitory_play_idea_create_play_magic_wand(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.ugly_wall then
				self:dormitory_play_idea_create_play_ugly_wall_enter(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.the_terrace_arcade or arg_20_3 == var_0_5.furniture_action_type.dancing_machine then
				self:dormitory_rest_idea_the_terrace_arcade(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.hat then
				self:dormitory_play_idea_create_play_hat(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.desktop_game then
				self:dormitory_play_idea_create_play_desktop_game_enter(var_20_2, arg_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.child_machine then
				self:dormitory_rest_idea_child_machine(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.tennis then
				self:dormitory_play_idea_create_play_tennis_enter(var_20_2, arg_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.mini_rowing then
				self:dormitory_play_idea_create_play_mini_rowing_enter(var_20_2, arg_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.play_game then
				self:dormitory_play_idea_create_play_play_game_enter(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.assembly_station then
				self:dormitory_play_idea_create_play_assembly_station(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.mini_track_boat_race then
				self:dormitory_rest_idea_mini_track_boat_race(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.western_style_coffin then
				self:dormitory_play_idea_create_play_western_style_coffin(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.duel_disk then
				self:dormitory_rest_idea_duel_disk(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.galo_radio then
				self:dormitory_rest_idea_galo_radio(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.wheel_chair then
				self:dormitory_rest_idea_wheel_chair(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.galo_giganotus_armor then
				self:dormitory_rest_idea_galo_giganotus_armor(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.combination_slide then
				self:dormitory_rest_idea_combination_slide(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.lay_down then
				self:dormitory_play_idea_create_lay_down(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.lay_down_left then
				self:dormitory_play_idea_create_lay_down_left(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.janpan_sit then
				self:dormitory_play_idea_create_lay_janpan_sit(var_20_2)
			elseif arg_20_3 == var_0_5.furniture_action_type.read_book then
				self:dormitory_play_idea_create_lay_read_book(var_20_2)
			else
				local var_20_3 = {}

				var_20_3[#var_20_3 + 1] = {
					type = "stop",
					furniture_id = var_20_1.data.id
				}

				var_20_0.control:set_play_action_list(var_20_3)
			end
		elseif arg_20_3 == var_0_5.furniture_action_type.bird_trellis then
			self:dormitory_play_idea_create_play_bird_trellis_enter(var_20_2)
		elseif arg_20_3 == var_0_5.furniture_action_type.food_bowl then
			self:dormitory_play_idea_create_play_food_bowl(var_20_2)
		elseif arg_20_3 == var_0_5.furniture_action_type.animal_toilet then
			self:dormitory_play_idea_create_play_animal_toilet(var_20_2)
		elseif arg_20_3 == var_0_5.furniture_action_type.animal_sit or arg_20_3 == var_0_5.furniture_action_type.animal_sleep then
			self:dormitory_play_idea_create_play_red_mat(var_20_2)
		elseif arg_20_3 == var_0_5.furniture_action_type.cat_scratch_plate then
			self:dormitory_play_idea_create_play_cat_scratch_plate(var_20_2)
		end
	end

	function arg_1_0:dormitory_idea_manager_request_toggle_action(arg_21_1, arg_21_2)
		self._furniture_interact_tb[arg_21_1] = arg_21_2
	end

	function arg_1_0.dormitory_idea_manager_wait_idea(arg_22_0, arg_22_1, arg_22_2)
		for iter_22_0 = 1, var_0_8(arg_22_2 / var_0_11.deltaTime) do
			arg_22_1[#arg_22_1 + 1] = {
				type = "wait"
			}
		end
	end

	function arg_1_0.dormitory_idea_manager_move_to_action_pos(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
		local var_23_0 = arg_23_6 or false
		local var_23_1 = var_0_8(var_0_9.Distance(arg_23_3, arg_23_2) * (arg_23_5 or 2))

		for iter_23_0 = 1, var_23_1 do
			arg_23_1[#arg_23_1 + 1] = {
				type = "move",
				to_pos = arg_23_2 + iter_23_0 * ((arg_23_3 - arg_23_2) / var_23_1),
				keep_flip_x = var_23_0
			}
		end

		arg_23_1[#arg_23_1 + 1] = arg_23_4 and ((arg_23_4.control._furniture_data.config.type == var_0_5.furniture_kind_type.bed or arg_23_4.control._furniture_data.config.type == var_0_5.furniture_kind_type.tables or arg_23_4.control._furniture_data.config.type == var_0_5.furniture_kind_type.sofa) and {
			raycast = true,
			type = "set_ship_raycast"
		} or {
			raycast = false,
			type = "set_ship_raycast"
		}) or {
			raycast = false,
			type = "set_ship_raycast"
		}
	end

	function arg_1_0.dormitory_idea_manager_furniture_move_to_action_pos(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
		local var_24_0 = arg_24_5 or false
		local var_24_1 = var_0_8(var_0_9.Distance(arg_24_3, arg_24_2) * (arg_24_4 or 2))

		for iter_24_0 = 1, var_24_1 do
			arg_24_1[#arg_24_1 + 1] = {
				type = "furniture_move",
				to_pos = arg_24_2 + iter_24_0 * ((arg_24_3 - arg_24_2) / var_24_1),
				keep_flip_x = var_24_0
			}
		end
	end

	function arg_1_0.dormitory_idea_manager_get_furniture_action_pos(arg_25_0, arg_25_1)
		if not arg_25_1.config.behavior_position or not next(arg_25_1.config.behavior_position) then
			log.errorlog(var_0_10("furniture[%s] has no behavior_position", arg_25_1.config.cid))

			return nil
		end

		local var_25_0 = {}
		local var_25_1 = {
			x = arg_25_1.data.point.x + arg_25_1.config.width * 0.5,
			y = arg_25_1.data.point.y
		}

		for iter_25_0, iter_25_1 in ipairs(arg_25_1.config.behavior_position) do
			local var_25_2 = var_0_9()

			var_25_2.x = (var_25_1.x + iter_25_1.x) * var_0_5.dormitory_const.room_x_plus
			var_25_2.y = (var_25_1.y + iter_25_1.y) * var_0_5.dormitory_const.room_y_plus
			var_25_0[#var_25_0 + 1] = var_25_2
		end

		return var_25_0
	end

	function arg_1_0:dormitory_idea_manager_set_random_stand_pos(arg_26_1)
		local var_26_0 = self._dormitory_instance:get_walkable_grid_list(3, 3, 1)

		for iter_26_0, iter_26_1 in ipairs(self._ship_members_tb) do
			local var_26_1 = false
			local var_26_2 = false

			if arg_26_1.last_role_list ~= nil then
				for iter_26_2, iter_26_3 in pairs(arg_26_1.last_role_list) do
					if iter_26_1.data.id == iter_26_3.id then
						if iter_26_1.data.skin == iter_26_3.skin then
							var_26_2 = true
						end

						break
					end
				end
			end

			if arg_26_1.is_init == true then
				var_26_1 = true
			elseif arg_26_1.last_role_list == nil then
				var_26_1 = false
			else
				var_26_1 = not var_26_2

				if iter_26_1.control.is_in_coffin then
					var_26_1 = true
				end
			end

			if var_26_1 then
				local var_26_3 = var_0_6.pick_random_from_array(var_26_0)

				iter_26_1.control:set_grid_foot_position(var_26_3.grid_x, var_26_3.grid_y)
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_is_all_race_car_be_sitted()
		if not self._furniture_interact_tb.race_car_tb then
			return false
		end

		local var_27_0 = true

		for iter_27_0, iter_27_1 in pairs(self._furniture_interact_tb.race_car_tb) do
			if not iter_27_1.sitted then
				var_27_0 = false

				break
			end
		end

		return var_27_0
	end

	function arg_1_0:dormitory_idea_manager_stop_all_inter_car(arg_28_1)
		if not arg_28_1 then
			self:__reset_furniture_inter_state()
		end

		self:__dormitory_idea_manager_reset_inter_car_state(false)

		if not self._start_inter_car then
			return
		end

		self._start_inter_car = false

		if not self._furniture_interact_tb.inter_car_tb then
			return
		end

		for iter_28_0, iter_28_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
			if iter_28_1 then
				iter_28_1.sitted = false
				iter_28_1.driver_id = -1
				iter_28_1.ship_ele = nil
				iter_28_1.ship_delta_pos = nil

				if iter_28_1.car_ele then
					iter_28_1.car_ele.control:toggle_furniture_collider(false)
					iter_28_1.car_ele.control:set_furniture_animation(0, "normal", true)
					iter_28_1.car_ele.control:set_spine_position(iter_28_1.car_spine_original_pos)
				end
			end
		end

		self:dormitory_idea_manager_reset_all_collider_active_state()
	end

	function arg_1_0:dormitory_idea_manager_is_interactive_car()
		return (self._start_inter_car or self._galo_start_inter or self._start_inter_old_bike) and true
	end

	function arg_1_0:dormitory_idea_manager_get_limit_data(arg_30_1, arg_30_2)
		local var_30_0 = var_0_15.find_object_by_cid(arg_30_1)
		local var_30_1 = var_0_14:get_furniture_data_by_id(arg_30_2)

		if not var_30_1 or var_30_1.cid ~= var_0_5.dormitory_special_furniture_id.galo_radio then
			return true
		end

		for iter_30_0, iter_30_1 in pairs(self._ship_list) do
			if arg_30_1 == iter_30_1 then
				return true
			end
		end

		return false
	end

	function arg_1_0:__dormitory_idea_manager_check_action(arg_31_1, arg_31_2, arg_31_3, arg_31_4)
		local var_31_0 = false

		if next(arg_31_1) and self:__dormitory_idea_manager_random_get_true_one_from(1) then
			if arg_31_1[1] == var_0_5.furniture_action_type.sit or arg_31_1[1] == var_0_5.furniture_action_type.swim_ring or arg_31_1[1] == var_0_5.furniture_action_type.water_slides or arg_31_1[1] == var_0_5.furniture_action_type.drive_car or arg_31_1[1] == var_0_5.furniture_action_type.hand_car or arg_31_1[1] == var_0_5.furniture_action_type.djbox or arg_31_1[1] == var_0_5.furniture_action_type.skateboard or arg_31_1[1] == var_0_5.furniture_action_type.asura_car or arg_31_1[1] == var_0_5.furniture_action_type.old_bike or arg_31_1[1] == var_0_5.furniture_action_type.tree_swing or arg_31_1[1] == var_0_5.furniture_action_type.hit_melon or arg_31_1[1] == var_0_5.furniture_action_type.king_of_combat or arg_31_1[1] == var_0_5.furniture_action_type.youth_shoot_machine or arg_31_1[1] == var_0_5.furniture_action_type.magic_wand or arg_31_1[1] == var_0_5.furniture_action_type.ugly_wall or arg_31_1[1] == var_0_5.furniture_action_type.bird_trellis or arg_31_1[1] == var_0_5.furniture_action_type.best_drift or arg_31_1[1] == var_0_5.furniture_action_type.the_terrace_arcade or arg_31_1[1] == var_0_5.furniture_action_type.hat or arg_31_1[1] == var_0_5.furniture_action_type.dancing_machine or arg_31_1[1] == var_0_5.furniture_action_type.desktop_game or arg_31_1[1] == var_0_5.furniture_action_type.child_machine or arg_31_1[1] == var_0_5.furniture_action_type.tennis or arg_31_1[1] == var_0_5.furniture_action_type.food_bowl or arg_31_1[1] == var_0_5.furniture_action_type.veneto or arg_31_1[1] == var_0_5.furniture_action_type.animal_toilet or arg_31_1[1] == var_0_5.furniture_action_type.animal_sit or arg_31_1[1] == var_0_5.furniture_action_type.animal_sleep or arg_31_1[1] == var_0_5.furniture_action_type.mini_rowing or arg_31_1[1] == var_0_5.furniture_action_type.water_motorcycle or arg_31_1[1] == var_0_5.furniture_action_type.play_game or arg_31_1[1] == var_0_5.furniture_action_type.assembly_station or arg_31_1[1] == var_0_5.furniture_action_type.mini_track_boat_race or arg_31_1[1] == var_0_5.furniture_action_type.western_style_coffin or arg_31_1[1] == var_0_5.furniture_action_type.duel_disk or arg_31_1[1] == var_0_5.furniture_action_type.galo_radio or arg_31_1[1] == var_0_5.furniture_action_type.wheel_chair or arg_31_1[1] == var_0_5.furniture_action_type.galo_giganotus_armor or arg_31_1[1] == var_0_5.furniture_action_type.combination_slide or arg_31_1[1] == var_0_5.furniture_action_type.lay_down or arg_31_1[1] == var_0_5.furniture_action_type.lay_down_left or arg_31_1[1] == var_0_5.furniture_action_type.janpan_sit or arg_31_1[1] == var_0_5.furniture_action_type.read_book or arg_31_1[1] == var_0_5.furniture_action_type.cat_scratch_plate then
				if arg_31_1[1] == var_0_5.furniture_action_type.ugly_wall and arg_31_4.control._ugly_wall_tag == false then
					return var_31_0
				end

				arg_31_2[#arg_31_2 + 1] = {
					start_action = true,
					action_id = arg_31_1[1],
					furniture_id = arg_31_3
				}
				var_31_0 = true
			end
		end

		return var_31_0
	end

	function arg_1_0:__dormitory_idea_manager_init_furniture_interact_tb()
		self._furniture_interact_tb = {}

		for iter_32_0, iter_32_1 in ipairs(self._curr_furniture_tb) do
			if next(iter_32_1.config.action_id) then
				self._furniture_interact_tb[iter_32_1.data.id] = false
			end

			if iter_32_1.config.cid == var_0_5.dormitory_special_furniture_id.harvester then
				-- block empty
			elseif iter_32_1.config.special_type == var_0_5.furniture_special_type.race_car then
				if var_0_5:get_furniture_inter_delay_time(iter_32_1.config.cid) then
					local var_32_0

					if not self._furniture_interact_tb.inter_car_tb then
						self._furniture_interact_tb.inter_car_tb = {}
						var_32_0 = {
							is_begin = true,
							take_id = -1,
							cur_ship_num = 0,
							is_have_driver = false,
							record_num = 0,
							recover_num = 0,
							speed_up = false,
							driver_id = -1,
							speed = 0,
							is_interactive = false,
							sitted = false,
							car_id = iter_32_1.data.id,
							total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].total_inter_num,
							target_speed = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].full_speed,
							full_speed = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].full_speed,
							recover_time = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].recover_time,
							const_time = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].recover_time
						}
					end

					var_32_0.circle_array = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].circle_num
					var_32_0.driver_list = {}
					var_32_0.driver_pos = var_0_9()
					var_32_0.take_second_pos = var_0_9()
					var_32_0.take_third_pos = var_0_9()
					var_32_0.car_ele = iter_32_1
					var_32_0.car_spine_original_pos = iter_32_1.control:get_spine_position()
					self._furniture_interact_tb.inter_car_tb[iter_32_1.data.id] = var_32_0
				else
					self._furniture_interact_tb.race_car_tb = self._furniture_interact_tb.race_car_tb or {}
					self._furniture_interact_tb.race_car_tb[iter_32_1.data.id] = {
						speed = 0,
						speed_up = false,
						driver_id = -1,
						sitted = false,
						car_id = iter_32_1.data.id,
						target_speed = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].full_speed,
						full_speed = var_0_5.dormitory_race_car_sit_config[iter_32_1.config.cid].full_speed,
						car_ele = iter_32_1,
						car_spine_original_pos = iter_32_1.control:get_spine_position()
					}
				end
			end

			if iter_32_1.config.special_type ~= var_0_5.furniture_special_type.race_car and iter_32_1.config.special_type == var_0_5.furniture_special_type.barricade then
				-- block empty
			end
		end

		self:dormitory_idea_manager_init_galo_data()
		self:dormitory_idea_manager_init_ausra_data()
	end

	function arg_1_0.__dormitory_idea_manager_random_get_true_one_from(arg_33_0, arg_33_1)
		local var_33_1 = {}

		for iter_33_0 = 1, arg_33_1 do
			var_33_1[#var_33_1 + 1] = iter_33_0
		end

		return (var_0_6.pick_random_from_array(var_33_1) == 1 or nil) and true
	end

	function arg_1_0:__dormitory_idea_manager_get_ship_ele_by_id(arg_34_1)
		if not self._ship_members_tb then
			return nil
		end

		local var_34_0

		for iter_34_0, iter_34_1 in ipairs(self._ship_members_tb) do
			if arg_34_1 == iter_34_1.data.id then
				var_34_0 = iter_34_1

				break
			end
		end

		return var_34_0
	end

	function arg_1_0:__dormitory_idea_manager_get_furniture_ele_by_id(arg_35_1)
		if not self._curr_furniture_tb then
			return nil
		end

		local var_35_0

		for iter_35_0, iter_35_1 in ipairs(self._curr_furniture_tb) do
			if arg_35_1 == iter_35_1.data.id then
				var_35_0 = iter_35_1

				break
			end
		end

		return var_35_0
	end

	function arg_1_0:__dormitory_idea_manager_set_interactive_type(arg_36_1, arg_36_2)
		if var_0_5:get_furniture_inter_delay_time(arg_36_1) then
			self._inter_car_state = var_0_5.furniture_inter_type.ordinary_inter

			if arg_36_1 == var_0_5.dormitory_special_furniture_id.black_car then
				self:dormitory_rest_idea_create_drive_car(arg_36_2)
			elseif arg_36_1 == var_0_5.dormitory_special_furniture_id.hand_car then
				self:hand_carts_idea_create_drive_car(arg_36_2)
			elseif arg_36_1 == var_0_5.dormitory_special_furniture_id.harvester then
				self:dormitory_play_idea_create_drive_harvester(arg_36_2)
			end
		else
			self._inter_car_state = var_0_5.furniture_inter_type.special_inter

			self:dormitory_rest_idea_create_play_drive_car(arg_36_2)
		end
	end

	function arg_1_0.__dormitory_idea_manager_reset_inter_car_state(arg_37_0, arg_37_1)
		arg_37_0._galo_start_inter = arg_37_1
		arg_37_0._asura_start_inter = arg_37_1
		arg_37_0._start_inter_old_bike = arg_37_1
		arg_37_0._start_inter_wheel_chair = arg_37_1
		arg_37_0._start_inter_galo_giganotus_armor = arg_37_1
	end

	function arg_1_0:__reset_furniture_inter_state()
		self:reset_old_bike_inter_data()
		self:reset_galo_car_inter_state()
		self:reset_asura_inter_state()
	end

	function arg_1_0:__get_animal_furniture_info()
		local var_39_0 = false

		if self._curr_furniture_tb then
			for iter_39_0, iter_39_1 in pairs(self._curr_furniture_tb) do
				if iter_39_1.type == var_0_5.furniture_kind_type.pet then
					var_39_0 = true

					break
				end
			end
		end

		return var_39_0
	end

	function arg_1_0:get_race_furniture_inter_state()
		local var_40_0 = false

		for iter_40_0, iter_40_1 in pairs(self._curr_room_floor_furniture_tb) do
			if iter_40_1.config.cid == var_0_5.dormitory_special_furniture_id.race_car_road then
				var_40_0 = true

				break
			end
		end

		return var_40_0
	end

	function arg_1_0:__set_galo_ship_info()
		self._ship_list = {}

		for iter_41_0, iter_41_1 in pairs(self._ship_members_tb) do
			if tonumber((var_0_2(iter_41_1.data.cid, 1, 2))) == var_0_5.furniture_limit_special_furniture.galo_radio_index then
				var_0_4(self._ship_list, iter_41_1.data.cid)
			end

			if iter_41_1.data.cid == var_0_5.dormitory_const.veneto_ship_cid then
				var_0_4(self._ship_list, iter_41_1.data.cid)
			end
		end
	end
end

function var_0_0.extend_obj(arg_42_0)
	arg_42_0._curr_furniture_tb = nil
	arg_42_0._ship_members_tb = nil
	arg_42_0._walkable_ground_grid_tb = {}
	arg_42_0._dormitory_instance = nil
	arg_42_0._furniture_interact_tb = {}
	arg_42_0._start_race_car = false
	arg_42_0._inter_car_state = nil
	arg_42_0._galo_start_inter = false
	arg_42_0._asura_start_inter = false
	arg_42_0._curr_room_floor_furniture_tb = nil
	arg_42_0.is_have_animal = false
	arg_42_0.now_enter_ship_cid = nil
	arg_42_0.now_exit_ship_cid = nil
	arg_42_0._start_inter_wheel_chair = false
	arg_42_0._start_inter_galo_giganotus_armor = false
	arg_42_0._ship_list = {}
end

return var_0_0
