local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_5 = gameenum.common_type
local var_0_6 = UnityEngine.Time
local var_0_7 = gamecore.util_func
local var_0_8 = math.abs
local var_0_9 = UnityEngine.Mathf

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_rest_idea_create_drive_car(arg_2_1)
		local var_2_0 = var_0_1()

		var_2_0.x = (arg_2_1.furniture_ele.data.point.x + arg_2_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_2_0.y = (arg_2_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_2_1 = {}

		var_2_1[#var_2_1 + 1] = {
			type = "start_car",
			car_ele = arg_2_1.furniture_ele
		}
		var_2_1[#var_2_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_2_1.furniture_ele.control:get_sort_order() + 1
		}
		var_2_1[#var_2_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_1, arg_2_1.ship_ele.control:get_foot_position(), var_2_0, arg_2_1.furniture_ele)

		var_2_1[#var_2_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_2_1.furniture_ele.control:get_sort_order() - 1
		}
		var_2_1[#var_2_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_2_1[#var_2_1 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, var_0_5.dormitory_const.diff_num)
		}
		var_2_1[#var_2_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].sit_anim
		}
		var_2_1[#var_2_1 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_2_1.ship_ele.data.id,
			furniture_id = arg_2_1.furniture_ele.data.id,
			config_cid = arg_2_1.furniture_ele.config.cid
		}

		arg_2_1.ship_ele.control:set_play_action_list(var_2_1)
	end

	function arg_1_0:dormitory_rest_idea_create_drive_car_touch_barrier(arg_3_1)
		local var_3_0 = {}

		self:dormitory_idea_manager_wait_idea(var_3_0, (var_0_7.pick_random_from_array(arg_3_1.delay_array)))

		var_3_0[#var_3_0 + 1] = {
			type = "request_stop_car",
			car_ele = arg_3_1.furniture_ele,
			furniture_id = arg_3_1.furniture_ele.data.id,
			is_recover = arg_3_1.is_recover
		}
		var_3_0[#var_3_0 + 1] = {
			flip = true,
			type = "flip_x"
		}
		var_3_0[#var_3_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_3_0[#var_3_0 + 1] = {
			cooling_time = 6,
			type = "stop",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		arg_3_1.ship_ele.control:set_play_action_list(var_3_0)
	end

	function arg_1_0:dormitory_rest_idea_take_old_bike(arg_4_1)
		local var_4_0 = var_0_1()

		var_4_0.x = (arg_4_1.furniture_ele.data.point.x + arg_4_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_4_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_4_0.y = (arg_4_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_4_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_4_1 = {}

		var_4_1[#var_4_1 + 1] = {
			type = "start_car",
			car_ele = arg_4_1.furniture_ele
		}
		var_4_1[#var_4_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_4_1.furniture_ele.control:get_sort_order() - 1
		}
		var_4_1[#var_4_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_1, arg_4_1.ship_ele.control:get_foot_position(), var_4_0, arg_4_1.furniture_ele)

		var_4_1[#var_4_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_4_1[#var_4_1 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, 42)
		}
		var_4_1[#var_4_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_4_1.furniture_ele.config.cid].sit_anim
		}
		var_4_1[#var_4_1 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_4_1.ship_ele.data.id,
			furniture_id = arg_4_1.furniture_ele.data.id,
			config_cid = arg_4_1.furniture_ele.config.cid
		}

		arg_4_1.ship_ele.control:set_play_action_list(var_4_1)
	end

	function arg_1_0:dormitory_take_old_bike_touch_barrier(arg_5_1)
		local var_5_0 = {}

		self:dormitory_idea_manager_wait_idea(var_5_0, (var_0_7.pick_random_from_array(arg_5_1.delay_array)))

		var_5_0[#var_5_0 + 1] = {
			type = "request_stop_car",
			car_ele = arg_5_1.furniture_ele,
			furniture_id = arg_5_1.furniture_ele.data.id,
			is_recover = arg_5_1.is_recover,
			config_cid = arg_5_1.furniture_ele.config.cid
		}
		var_5_0[#var_5_0 + 1] = {
			flip = true,
			type = "flip_x"
		}
		var_5_0[#var_5_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_5_1.furniture_ele.control:get_sort_order() + 1
		}
		var_5_0[#var_5_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_5_0[#var_5_0 + 1] = {
			cooling_time = 6,
			type = "stop",
			furniture_id = arg_5_1.furniture_ele.data.id
		}

		arg_5_1.ship_ele.control:set_play_action_list(var_5_0)
	end

	function arg_1_0:hand_carts_idea_create_drive_car(arg_6_1)
		local var_6_0 = var_0_1()
		local var_6_1 = self:__record_inter_ship_num(arg_6_1.furniture_ele.data.id, arg_6_1.ship_ele.data.id, arg_6_1.furniture_ele.config.cid)

		var_6_0.x = (arg_6_1.furniture_ele.data.point.x + arg_6_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_6_1.furniture_ele.config.cid].delta_grid_x[var_6_1]) * var_0_5.dormitory_const.room_x_plus
		var_6_0.y = (arg_6_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_6_1.furniture_ele.config.cid].delta_grid_y[var_6_1]) * var_0_5.dormitory_const.room_y_plus

		self:__set_driver_position(var_6_0, arg_6_1.furniture_ele.data.id, var_6_1)

		local var_6_3, var_6_4, var_6_5, var_6_6 = self:__get_ship_animation_name(var_6_1)
		local var_6_7 = {}

		var_6_7[#var_6_7 + 1] = {
			type = "start_car",
			car_ele = arg_6_1.furniture_ele
		}
		var_6_7[#var_6_7 + 1] = {
			type = "set_sort_order",
			sort_order = arg_6_1.furniture_ele.control:get_sort_order() + var_6_6
		}
		var_6_7[#var_6_7 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_6_7, arg_6_1.ship_ele.control:get_foot_position(), var_6_0, arg_6_1.furniture_ele)

		var_6_7[#var_6_7 + 1] = {
			type = "delay_excute_event",
			config_cid = arg_6_1.furniture_ele.config.cid,
			delay_data = {
				furniture_cid = arg_6_1.furniture_ele.config.cid,
				ship_index = var_6_1,
				ship_id = arg_6_1.ship_ele.data.id
			}
		}
		var_6_7[#var_6_7 + 1] = {
			flip = false,
			type = "flip_x"
		}

		self:dormitory_idea_manager_wait_idea(var_6_7, var_6_5)

		var_6_7[#var_6_7 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, var_6_4)
		}
		var_6_7[#var_6_7 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_6_3
		}

		arg_6_1.ship_ele.control:set_play_action_list(var_6_7)
	end

	function arg_1_0:hand_carts_idea_request_drive_car(arg_7_1)
		local var_7_0 = {}

		self:dormitory_idea_manager_wait_idea(var_7_0, 0.2)

		var_7_0[#var_7_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_7_0[#var_7_0 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_7_1.ship_ele.data.id,
			furniture_id = arg_7_1.furniture_ele.data.id,
			config_cid = arg_7_1.furniture_ele.config.cid
		}
		var_7_0[#var_7_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		arg_7_1.ship_ele.control:set_play_action_list(var_7_0)
	end

	function arg_1_0:dormitory_rest_idea_wheel_chair(arg_8_1)
		local var_8_0 = var_0_1()

		var_8_0.x = (arg_8_1.furniture_ele.data.point.x + arg_8_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_8_0.y = (arg_8_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_8_1 = {}

		var_8_1[#var_8_1 + 1] = {
			type = "start_car",
			car_ele = arg_8_1.furniture_ele
		}
		var_8_1[#var_8_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_8_1, arg_8_1.ship_ele.control:get_foot_position(), var_8_0, arg_8_1.furniture_ele)
		self:__record_curr_inter_ship_pos(arg_8_1.furniture_ele, var_8_0)

		var_8_1[#var_8_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_8_1[#var_8_1 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, 23)
		}
		var_8_1[#var_8_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_8_1.furniture_ele.control:get_sort_order() + 1
		}
		var_8_1[#var_8_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].sit_anim
		}
		var_8_1[#var_8_1 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_8_1.ship_ele.data.id,
			furniture_id = arg_8_1.furniture_ele.data.id,
			config_cid = arg_8_1.furniture_ele.config.cid
		}

		arg_8_1.ship_ele.control:set_play_action_list(var_8_1)
	end

	function arg_1_0:dormitory_rest_idea_wheel_chair_stop_event(arg_9_1)
		local var_9_0 = var_0_1()

		var_9_0.x = arg_9_1.orgin_pos.x
		var_9_0.y = arg_9_1.orgin_pos.y

		local var_9_1 = {}

		self:dormitory_idea_manager_furniture_move_to_action_pos(var_9_1, arg_9_1.furniture_ele.car_ele.control:get_now_foot_position(), var_9_0)

		local var_9_2, var_9_3, var_9_4 = self:__get_spine_name_by_furniture_cid(arg_9_1.furniture_ele.config_cid)

		var_9_1[#var_9_1 + 1] = {
			type = "request_change_spine",
			furniture_id = arg_9_1.furniture_ele.car_ele.data.id,
			spine_name = var_9_2,
			spine_state = var_9_4,
			config_cid = arg_9_1.furniture_ele.config_cid
		}
		var_9_1[#var_9_1 + 1] = {
			type = "set_furniture_flip_x",
			flip_x = arg_9_1.furniture_orgin_flip_x
		}

		self:dormitory_idea_manager_wait_idea(var_9_1, var_9_3)

		var_9_1[#var_9_1 + 1] = {
			is_active = false,
			type = "set_furniture_img_alpha",
			furniture_ele = arg_9_1.furniture_ele
		}
		var_9_1[#var_9_1 + 1] = {
			type = "stop_furniture_move",
			furniture_ele = arg_9_1.furniture_ele
		}

		arg_9_1.furniture_ele.car_ele.control:set_play_action_list(var_9_1)
	end

	function arg_1_0:dormitory_rest_idea_stop_single_ship_inter(arg_10_1)
		local var_10_0 = {}

		var_10_0[#var_10_0 + 1] = {
			type = "request_stop_car",
			furniture_id = arg_10_1.furniture_ele.car_ele.data.id,
			config_cid = arg_10_1.furniture_ele.config_cid
		}
		var_10_0[#var_10_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_10_0[#var_10_0 + 1] = {
			is_active = true,
			type = "set_ship_show_state"
		}
		var_10_0[#var_10_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_10_0, 1)

		var_10_0[#var_10_0 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_10_1.furniture_ele.car_ele.data.id
		}

		arg_10_1.ship_ele.control:set_play_action_list(var_10_0)
	end

	function arg_1_0:dormitory_rest_idea_galo_giganotus_armor(arg_11_1)
		local var_11_0 = var_0_1()

		var_11_0.x = (arg_11_1.furniture_ele.data.point.x + arg_11_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_11_0.y = (arg_11_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_11_1 = {}

		var_11_1[#var_11_1 + 1] = {
			type = "start_car",
			car_ele = arg_11_1.furniture_ele
		}
		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_11_1, arg_11_1.ship_ele.control:get_foot_position(), var_11_0, arg_11_1.furniture_ele)

		var_11_1[#var_11_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_11_1[#var_11_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_11_1.furniture_ele.control:get_sort_order() + 1
		}
		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].sit_anim
		}
		var_11_1[#var_11_1 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_11_1.ship_ele.data.id,
			furniture_id = arg_11_1.furniture_ele.data.id,
			config_cid = arg_11_1.furniture_ele.config.cid
		}
		var_11_1[#var_11_1 + 1] = {
			is_active = false,
			type = "set_ship_show_state"
		}

		arg_11_1.ship_ele.control:set_play_action_list(var_11_1)
	end

	function arg_1_0:dormitory_rest_idea_galo_giganotus_armor_event(arg_12_1)
		local var_12_0 = arg_12_1.furniture_ele.car_ele.control:get_now_foot_position()
		local var_12_1 = {}

		var_12_1[#var_12_1 + 1] = {
			spine_state = false,
			spine_name = "start",
			type = "request_change_spine",
			furniture_id = arg_12_1.furniture_ele.car_ele.data.id,
			config_cid = arg_12_1.furniture_ele.config_cid
		}

		self:dormitory_idea_manager_wait_idea(var_12_1, 1.4)

		var_12_1[#var_12_1 + 1] = {
			spine_state = true,
			spine_name = "walk_slow",
			type = "request_change_spine",
			furniture_id = arg_12_1.furniture_ele.car_ele.data.id,
			config_cid = arg_12_1.furniture_ele.config_cid
		}
		var_12_1[#var_12_1 + 1] = {
			type = "set_furniture_random_walk",
			furniture_id = arg_12_1.furniture_ele.car_ele.data.id
		}

		arg_12_1.furniture_ele.car_ele.control:set_play_action_list(var_12_1)
	end

	function arg_1_0:dormitory_idea_manager_interactive_update()
		self:update_normal_car_running_state()
		self:dormitory_idea_manager_old_bike_update()
		self:dormitory_idea_manager_galo_interactive_update()
		self:dormitory_idea_manager_asura_interactive_update()
		self:updata_tree_swing_time()
		self:updata_the_terrace_arcade_time()
		self:updata_dancing_machine_time()
		self:update_hand_car_driver_info()
		self:updata_mini_track_boat_race_time()
		self:updata_duel_disk_time()
		self:updata_galo_radio_time()
		self:dormitory_idea_manager_wheel_chair_update()
		self:dormitory_idea_manager_galo_giganotus_armor_update()
	end

	function arg_1_0:update_normal_car_running_state()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._start_inter_car then
			for iter_14_0, iter_14_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_14_1.is_interactive then
					iter_14_1.speed = var_0_9.Lerp(iter_14_1.speed, iter_14_1.target_speed, 0.01)

					if iter_14_1.speed_up then
						iter_14_1.target_speed = iter_14_1.target_speed + 15

						if iter_14_1.target_speed > iter_14_1.full_speed then
							iter_14_1.speed_up = false
							iter_14_1.target_speed = iter_14_1.full_speed
						end
					end

					local var_14_0 = iter_14_1.car_ele.control:get_spine_position()

					iter_14_1.car_ele.control:set_spine_position(var_14_0 - var_0_1(1, 0) * var_0_6.deltaTime * iter_14_1.speed)

					local var_14_1 = iter_14_1.car_ele.control:get_spine_position() + iter_14_1.ship_delta_pos

					iter_14_1.ship_ele.control:set_foot_position_without_record(var_14_1.x, var_14_1.y)

					if iter_14_1.record_num > 1 then
						if iter_14_1.driver_list[2] then
							local var_14_2 = iter_14_1.car_ele.control:get_spine_position() + iter_14_1.ship_delta_pos_first

							iter_14_1.ship_ele_take_first.control:set_foot_position_without_record(var_14_2.x, var_14_2.y)
						end

						if iter_14_1.driver_list[3] then
							local var_14_3 = iter_14_1.car_ele.control:get_spine_position() + iter_14_1.ship_delta_pos_second

							iter_14_1.ship_ele_take_second.control:set_foot_position_without_record(var_14_3.x, var_14_3.y)
						end
					end

					self:dormitory_idea_manager_arrive_destination(iter_14_1)

					if var_14_0.x < -50 and iter_14_1.recover_time > 0 then
						iter_14_1.recover_time = iter_14_1.recover_time - var_0_6.deltaTime

						if iter_14_1.recover_time < 1 then
							iter_14_1.car_ele.control:set_spine_position(var_0_1(1553, var_14_0.y))

							iter_14_1.recover_time = iter_14_1.const_time
							iter_14_1.is_begin = false
							iter_14_1.recover_num = iter_14_1.recover_num - 1
						end
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_old_bike_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._start_inter_old_bike then
			for iter_15_0, iter_15_1 in pairs(self._furniture_interact_tb.old_bike_car_tb) do
				if iter_15_1.is_interactive then
					iter_15_1.speed = var_0_9.Lerp(iter_15_1.speed, iter_15_1.target_speed, 0.01)

					if iter_15_1.speed_up then
						iter_15_1.target_speed = iter_15_1.target_speed + 15

						if iter_15_1.target_speed > iter_15_1.full_speed then
							iter_15_1.speed_up = false
							iter_15_1.target_speed = iter_15_1.full_speed
						end
					end

					local var_15_0 = iter_15_1.car_ele.control:get_spine_position()

					iter_15_1.car_ele.control:set_spine_position(var_15_0 - var_0_1(1, 0) * var_0_6.deltaTime * iter_15_1.speed)

					local var_15_1 = iter_15_1.car_ele.control:get_spine_position() + iter_15_1.ship_delta_pos

					iter_15_1.ship_ele.control:set_foot_position_without_record(var_15_1.x, var_15_1.y)
					self:dormitory_idea_manager_bike_arrive_destination(iter_15_1)

					if var_15_0.x < -50 and iter_15_1.recover_time > 0 then
						iter_15_1.recover_time = iter_15_1.recover_time - var_0_6.deltaTime

						if iter_15_1.recover_time < 1 then
							iter_15_1.car_ele.control:set_spine_position(var_0_1(1553, var_15_0.y))

							iter_15_1.recover_time = iter_15_1.const_time
							iter_15_1.is_begin = false
							iter_15_1.recover_num = iter_15_1.recover_num - 1
						end
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_galo_interactive_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._galo_start_inter then
			for iter_16_0, iter_16_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
				if iter_16_1.is_interactive then
					iter_16_1.speed = var_0_9.Lerp(iter_16_1.speed, iter_16_1.target_speed, 0.01)

					if iter_16_1.speed_up then
						iter_16_1.target_speed = iter_16_1.target_speed + 25

						if iter_16_1.target_speed > iter_16_1.full_speed then
							iter_16_1.speed_up = false
							iter_16_1.target_speed = iter_16_1.full_speed
						end
					end

					local var_16_0 = iter_16_1.car_ele.control:get_spine_position()

					iter_16_1.car_ele.control:set_spine_position(var_16_0 - var_0_1(1, 0) * var_0_6.deltaTime * iter_16_1.speed)

					if var_16_0.x < -50 and iter_16_1.recover_time > 0 then
						iter_16_1.recover_time = iter_16_1.recover_time - var_0_6.deltaTime

						if iter_16_1.recover_time < 1 then
							iter_16_1.car_ele.control:set_spine_position(var_0_1(1553, var_16_0.y))

							iter_16_1.recover_time = iter_16_1.const_time
						end
					end
				end
			end
		end
	end

	function arg_1_0:update_hand_car_driver_info()
		if not self._furniture_interact_tb then
			return
		end

		if not self._furniture_interact_tb.inter_car_tb then
			return
		end

		if self._furniture_interact_tb.inter_car_tb then
			for iter_17_0, iter_17_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_17_1.is_have_driver then
					local var_17_0, var_17_1, var_17_2 = self:__get_take_personnel_position_info(iter_17_1)

					if var_17_0 == iter_17_1.driver_pos then
						if iter_17_1.record_num == 1 then
							self:__change_multiplay_inter_state(iter_17_1)
						elseif iter_17_1.record_num == 2 then
							if iter_17_1.driver_list[2] and var_17_1 == iter_17_1.take_second_pos then
								self:__change_multiplay_inter_state(iter_17_1)
							end

							if iter_17_1.driver_list[3] and var_17_2 == iter_17_1.take_third_pos then
								self:__change_multiplay_inter_state(iter_17_1)
							end
						elseif var_17_1 == iter_17_1.take_second_pos and var_17_2 == iter_17_1.take_third_pos then
							self:__change_multiplay_inter_state(iter_17_1)
						end
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_wheel_chair_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._start_inter_wheel_chair then
			for iter_18_0, iter_18_1 in pairs(self._furniture_interact_tb.wheel_chair_tb) do
				if iter_18_1.is_interactive then
					if iter_18_1.recover_time > 0 then
						iter_18_1.recover_time = iter_18_1.recover_time - var_0_6.deltaTime
					else
						iter_18_1.is_interactive = false

						iter_18_1.car_ele.control:set_move_ai_condition(false)
						iter_18_1.car_ele.control:clear_walk_path_grid_list()
						iter_18_1.car_ele.control:clear_walk_pos_interpolation_list()
						iter_18_1.car_ele.control:set_stop_furniture_ai(true, true)
						self:dormitory_idea_manager_recover_orgin_position(iter_18_1)
					end
				end

				if iter_18_1.is_count_down then
					if iter_18_1.wait_time > 0 then
						iter_18_1.wait_time = iter_18_1.wait_time - var_0_6.deltaTime
					else
						iter_18_1.is_count_down = false
						iter_18_1.is_interactive = true

						iter_18_1.car_ele.control:set_furniture_animation(0, "walk", true)
						iter_18_1.car_ele.control:set_curr_furniture_start_ai_condition(true, iter_18_1.ship_ele)
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_galo_giganotus_armor_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._start_inter_galo_giganotus_armor then
			for iter_19_0, iter_19_1 in pairs(self._furniture_interact_tb.galo_giganotus_armor_tb) do
				if iter_19_1.is_interactive then
					if iter_19_1.recover_time > 0 then
						iter_19_1.recover_time = iter_19_1.recover_time - var_0_6.deltaTime
					else
						iter_19_1.is_interactive = false

						iter_19_1.car_ele.control:clear_walk_path_grid_list()
						iter_19_1.car_ele.control:clear_walk_pos_interpolation_list()
						self:dormitory_idea_manager_recover_orgin_position(iter_19_1)
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_remove_no_exist_ship(arg_20_1)
		arg_20_1 = arg_20_1 or {}

		for iter_20_0, iter_20_1 in pairs(arg_20_1) do
			self:__reset_running_furniture_position(iter_20_1.id)
		end
	end

	function arg_1_0:get_curr_inter_furniture_state()
		if self._galo_start_inter or self._asura_start_inter or self._start_inter_old_bike or self._start_inter_wheel_chair or self._start_inter_galo_giganotus_armor or self._start_inter_car then
			return true
		end

		return false
	end

	function arg_1_0:__reset_running_furniture_position(arg_22_1)
		if self._furniture_interact_tb then
			self:__reset_normal_car_by_remove_ship(arg_22_1)
			self:__reset_bike_by_remove_ship(arg_22_1)
			self:__reset_wheel_chair_by_remove_ship(arg_22_1)
			self:__reset_galo_giganotus_armor_by_remove_ship(arg_22_1)
			self:__reset_asura_car_by_remove_ship(arg_22_1)
			self:__reset_galo_radio_by_remove_ship(arg_22_1)
		end
	end

	function arg_1_0:__reset_normal_car_by_remove_ship(arg_23_1)
		if self._furniture_interact_tb.inter_car_tb then
			for iter_23_0, iter_23_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_23_1.driver_id == arg_23_1 then
					self:dormitory_idea_manager_stop_single_inter_to_set_car_data(iter_23_1.car_id, true)

					return
				end
			end
		end
	end

	function arg_1_0:__reset_bike_by_remove_ship(arg_24_1)
		if self._furniture_interact_tb.old_bike_car_tb then
			for iter_24_0, iter_24_1 in pairs(self._furniture_interact_tb.old_bike_car_tb) do
				if iter_24_1.driver_id == arg_24_1 then
					self:dormitory_idea_manager_rset_bike_data(iter_24_1.car_id, true)

					return
				end
			end
		end
	end

	function arg_1_0:__reset_wheel_chair_by_remove_ship(arg_25_1)
		if self._furniture_interact_tb.wheel_chair_tb then
			for iter_25_0, iter_25_1 in pairs(self._furniture_interact_tb.wheel_chair_tb) do
				if iter_25_1.driver_id == arg_25_1 then
					if self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id] then
						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].driver_id = -1
						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].is_interactive = false

						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:set_move_ai_condition(false)
						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:clear_walk_path_grid_list()
						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:clear_walk_pos_interpolation_list()
						self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:set_stop_furniture_ai(true, true)

						if self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele then
							self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:toggle_furniture_collider(false)
							self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:set_furniture_animation(0, "normal", true)
							self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_ele.control:set_spine_position(self._furniture_interact_tb.wheel_chair_tb[iter_25_1.car_id].car_spine_original_pos)
						end
					end

					return
				end
			end
		end
	end

	function arg_1_0:__reset_galo_giganotus_armor_by_remove_ship(arg_26_1)
		if self._furniture_interact_tb.galo_giganotus_armor_tb then
			for iter_26_0, iter_26_1 in pairs(self._furniture_interact_tb.galo_giganotus_armor_tb) do
				if iter_26_1.driver_id == arg_26_1 then
					if self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id] then
						self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].driver_id = -1
						self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].is_interactive = false

						self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:clear_walk_path_grid_list()
						self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:clear_walk_pos_interpolation_list()

						if self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele then
							self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:toggle_furniture_collider(false)
							self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:update_special_furniture_alpha(false)
							self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:set_furniture_animation(0, "end", false)
							self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_ele.control:set_spine_position(self._furniture_interact_tb.galo_giganotus_armor_tb[iter_26_1.car_id].car_spine_original_pos)
						end
					end

					return
				end
			end
		end
	end

	function arg_1_0:__reset_asura_car_by_remove_ship(arg_27_1)
		if self._furniture_interact_tb.asura_car_tb then
			for iter_27_0, iter_27_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
				if iter_27_1.driver_id == arg_27_1 then
					self:dormitory_idea_manager_stop_asura_inter(iter_27_1.car_id)

					return
				end
			end
		end
	end

	function arg_1_0:__reset_galo_radio_by_remove_ship(arg_28_1)
		if self._furniture_interact_tb.galo_radio_tb then
			for iter_28_0, iter_28_1 in pairs(self._furniture_interact_tb.galo_radio_tb) do
				if iter_28_1.is_interactive then
					local var_28_1 = 0

					for iter_28_2, iter_28_3 in pairs(iter_28_1.driver_list) do
						if iter_28_3 == arg_28_1 then
							var_28_1 = iter_28_2
						end
					end

					if var_28_1 ~= 0 then
						iter_28_1.driver_list[var_28_1] = -1
					end

					local var_28_2 = iter_28_1.record_num

					for iter_28_4, iter_28_5 in pairs(iter_28_1.driver_list) do
						if iter_28_5 == -1 then
							var_28_2 = var_28_2 - 1
						end
					end

					if var_28_2 == 0 then
						self:reset_current_furniture_spine(self._furniture_interact_tb.galo_radio_tb, iter_28_1.car_id)
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_normal_request_drive_car(arg_29_1, arg_29_2)
		if self._furniture_interact_tb.inter_car_tb then
			if self._furniture_interact_tb.inter_car_tb[arg_29_2] then
				self._furniture_interact_tb.inter_car_tb[arg_29_2].driver_id = arg_29_1
				self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_29_1)
				self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_delta_pos = self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele.control:get_foot_position() - self._furniture_interact_tb.inter_car_tb[arg_29_2].car_ele.control:get_spine_position()

				if self._furniture_interact_tb.inter_car_tb[arg_29_2].record_num > 1 then
					if self._furniture_interact_tb.inter_car_tb[arg_29_2].driver_list[2] then
						self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele_take_first = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.inter_car_tb[arg_29_2].driver_list[2])
						self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_delta_pos_first = self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele_take_first.control:get_foot_position() - self._furniture_interact_tb.inter_car_tb[arg_29_2].car_ele.control:get_spine_position()
					end

					if self._furniture_interact_tb.inter_car_tb[arg_29_2].driver_list[3] then
						self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele_take_second = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.inter_car_tb[arg_29_2].driver_list[3])

						self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele_take_second.control:__set_inter_ship_pos(var_0_1(-5, 18))

						self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_delta_pos_second = self._furniture_interact_tb.inter_car_tb[arg_29_2].ship_ele_take_second.control:get_foot_position() - self._furniture_interact_tb.inter_car_tb[arg_29_2].car_ele.control:get_spine_position()
					end
				end

				self._furniture_interact_tb.inter_car_tb[arg_29_2].sitted = true
				self._furniture_interact_tb.inter_car_tb[arg_29_2].is_interactive = true
				self._furniture_interact_tb.inter_car_tb[arg_29_2].speed_up = true
				self._furniture_interact_tb.inter_car_tb[arg_29_2].target_speed = self._furniture_interact_tb.inter_car_tb[arg_29_2].full_speed
				self._furniture_interact_tb.inter_car_tb[arg_29_2].recover_num = var_0_7.pick_random_from_array(self._furniture_interact_tb.inter_car_tb[arg_29_2].circle_array)
			end
		end

		self._start_inter_car = true

		if self._furniture_interact_tb and self._furniture_interact_tb.inter_car_tb then
			for iter_29_0, iter_29_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_29_1.car_id == arg_29_2 then
					iter_29_1.car_ele.control:toggle_furniture_collider(true)
					iter_29_1.car_ele.control:set_furniture_animation(0, "start", true)
				end
			end
		end

		if self._ship_members_tb then
			for iter_29_2, iter_29_3 in ipairs(self._ship_members_tb) do
				if not self:__dormitory_idea_manager_is_ship_sitting_normal_car(iter_29_3.data.id) then
					iter_29_3.control:toggle_ship_collider(true)
				else
					iter_29_3.control:toggle_ship_collider(false)
				end
			end
		end

		self:dormitory_idea_manager_reset_all_collider_inactive_state()
	end

	function arg_1_0:dormitory_idea_manager_arrive_destination(arg_30_1)
		if not arg_30_1.is_begin and arg_30_1.recover_num <= 0 and var_0_8(arg_30_1.car_spine_original_pos.x - arg_30_1.car_ele.control:get_spine_position().x) < 10 then
			arg_30_1.is_interactive = false
			arg_30_1.is_begin = true

			self:dormitory_idea_manager_stop_single_inter_car(arg_30_1.car_id, true, false)
		end
	end

	function arg_1_0:dormitory_idea_manager_stop_single_inter_car(arg_31_1, arg_31_2, arg_31_3)
		if not self._start_inter_car then
			return
		end

		local var_31_0 = self._furniture_interact_tb.inter_car_tb[arg_31_1]
		local var_31_1 = self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_31_1)
		local var_31_2 = arg_31_3 and {
			2,
			3,
			4,
			5
		} or {
			0
		}

		if arg_31_2 then
			self:dormitory_rest_idea_create_drive_car_touch_barrier({
				ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.inter_car_tb[arg_31_1].driver_id),
				furniture_ele = var_31_1,
				delay_array = var_31_2,
				is_recover = arg_31_2
			})
		else
			self:dormitory_idea_manager_stop_single_inter_to_set_car_data(var_31_1.data.id, false)
		end

		if var_31_0.record_num > 1 and arg_31_2 then
			if var_31_0.driver_list[2] then
				self:dormitory_rest_idea_create_drive_car_touch_barrier({
					ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(var_31_0.driver_list[2]),
					furniture_ele = var_31_1,
					delay_array = {
						0
					},
					is_recover = arg_31_2
				})
			end

			if var_31_0.driver_list[3] then
				self:dormitory_rest_idea_create_drive_car_touch_barrier({
					ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(var_31_0.driver_list[3]),
					furniture_ele = var_31_1,
					delay_array = {
						0
					},
					is_recover = arg_31_2
				})
			end
		end
	end

	function arg_1_0:reset_ship_collider_state(arg_32_1)
		local var_32_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_32_1)

		if self._start_inter_car then
			var_32_0.control:toggle_ship_collider(true)
		else
			var_32_0.control:toggle_ship_collider((var_32_0.control:get_ship_collider_state()))
		end
	end

	function arg_1_0:dormitory_idea_manager_stop_single_inter_to_set_car_data(arg_33_1, arg_33_2)
		if self._furniture_interact_tb.inter_car_tb[arg_33_1] then
			if self._furniture_interact_tb.inter_car_tb[arg_33_1].driver_list[1] then
				self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.inter_car_tb[arg_33_1].driver_list[1]).control:set_ship_animation(0, "stand1", true)
			end

			self._furniture_interact_tb.inter_car_tb[arg_33_1].sitted = false
			self._furniture_interact_tb.inter_car_tb[arg_33_1].driver_id = -1
			self._furniture_interact_tb.inter_car_tb[arg_33_1].speed_up = false
			self._furniture_interact_tb.inter_car_tb[arg_33_1].target_speed = 0
			self._furniture_interact_tb.inter_car_tb[arg_33_1].is_interactive = false
			self._furniture_interact_tb.inter_car_tb[arg_33_1].driver_list = {}
			self._furniture_interact_tb.inter_car_tb[arg_33_1].driver_pos = var_0_1()
			self._furniture_interact_tb.inter_car_tb[arg_33_1].record_num = 0
			self._furniture_interact_tb.inter_car_tb[arg_33_1].cur_ship_num = 0

			if self._furniture_interact_tb.inter_car_tb[arg_33_1].car_ele then
				self._furniture_interact_tb.inter_car_tb[arg_33_1].car_ele.control:toggle_furniture_collider(false)
				self._furniture_interact_tb.inter_car_tb[arg_33_1].car_ele.control:set_furniture_animation(0, "normal", true)

				if arg_33_2 then
					self._furniture_interact_tb.inter_car_tb[arg_33_1].car_ele.control:set_spine_position(self._furniture_interact_tb.inter_car_tb[arg_33_1].car_spine_original_pos)
				end
			end
		end
	end

	function arg_1_0:__dormitory_idea_manager_is_all_normal_car_be_sitted()
		if not self._furniture_interact_tb.inter_car_tb then
			return false
		end

		local var_34_0 = true

		for iter_34_0, iter_34_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
			if not iter_34_1.sitted then
				var_34_0 = false

				break
			end
		end

		return var_34_0
	end

	function arg_1_0:__dormitory_idea_manager_is_ship_sitting_normal_car(arg_35_1)
		if not self._furniture_interact_tb.inter_car_tb then
			return false
		end

		local var_35_0 = false

		for iter_35_0, iter_35_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
			if arg_35_1 == iter_35_1.driver_id then
				var_35_0 = true

				break
			end
		end

		return var_35_0
	end

	function arg_1_0:dormitory_idea_manager_request_inter_by_ship(arg_36_1, arg_36_2, arg_36_3)
		local var_36_0

		if arg_36_3 == var_0_5.dormitory_special_furniture_id.old_bike then
			if self._furniture_interact_tb.old_bike_car_tb then
				if self._furniture_interact_tb.old_bike_car_tb[arg_36_2] then
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].driver_id = arg_36_1
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_36_1)
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].ship_delta_pos = self._furniture_interact_tb.old_bike_car_tb[arg_36_2].ship_ele.control:get_foot_position() - self._furniture_interact_tb.old_bike_car_tb[arg_36_2].car_ele.control:get_spine_position()
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].sitted = true
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].is_interactive = true
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].speed_up = true
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].speed = 0
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].target_speed = self._furniture_interact_tb.old_bike_car_tb[arg_36_2].full_speed
					self._furniture_interact_tb.old_bike_car_tb[arg_36_2].recover_num = var_0_7.pick_random_from_array(self._furniture_interact_tb.old_bike_car_tb[arg_36_2].circle_array)
				end
			end

			self._start_inter_old_bike = true

			if self._furniture_interact_tb and self._furniture_interact_tb.old_bike_car_tb then
				for iter_36_0, iter_36_1 in pairs(self._furniture_interact_tb.old_bike_car_tb) do
					iter_36_1.car_ele.control:toggle_furniture_collider(true)

					if iter_36_1.car_id == arg_36_2 then
						iter_36_1.car_ele.control:set_furniture_animation(0, "start", true)
					end
				end
			end

			var_36_0 = self._furniture_interact_tb.old_bike_car_tb
		elseif arg_36_3 == var_0_5.dormitory_special_furniture_id.wheel_chair then
			if self._furniture_interact_tb.wheel_chair_tb then
				if self._furniture_interact_tb.wheel_chair_tb[arg_36_2] then
					self._furniture_interact_tb.wheel_chair_tb[arg_36_2].driver_id = arg_36_1
					self._furniture_interact_tb.wheel_chair_tb[arg_36_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_36_1)
					self._furniture_interact_tb.wheel_chair_tb[arg_36_2].wait_time = var_0_7.pick_random_from_array(self._furniture_interact_tb.wheel_chair_tb[arg_36_2].wait_time_list)
					self._furniture_interact_tb.wheel_chair_tb[arg_36_2].is_count_down = true
				end
			end

			self._start_inter_wheel_chair = true
			var_36_0 = self._furniture_interact_tb.wheel_chair_tb
		elseif arg_36_3 == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor then
			if self._furniture_interact_tb.galo_giganotus_armor_tb then
				if self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2] then
					self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2].driver_id = arg_36_1
					self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_36_1)

					self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2].car_ele.control:set_stop_furniture_ai(true, false)
					self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2].car_ele.control:update_special_furniture_alpha(true)

					self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2].is_interactive = true

					self:dormitory_rest_idea_galo_giganotus_armor_event({
						furniture_ele = self._furniture_interact_tb.galo_giganotus_armor_tb[arg_36_2]
					})
				end
			end

			self._start_inter_galo_giganotus_armor = true
			var_36_0 = self._furniture_interact_tb.galo_giganotus_armor_tb
		end

		if self._ship_members_tb and var_36_0 then
			for iter_36_2, iter_36_3 in ipairs(self._ship_members_tb) do
				if not self:__dormitory_idea_manager_bike_drive(iter_36_3.data.id, var_36_0) then
					iter_36_3.control:toggle_ship_collider(true)
				else
					iter_36_3.control:toggle_ship_collider(false)
				end
			end
		end

		self:dormitory_idea_manager_reset_all_collider_inactive_state()
	end

	function arg_1_0:dormitory_idea_manager_recover_orgin_position(arg_37_1)
		if arg_37_1.config_cid == var_0_5.dormitory_special_furniture_id.wheel_chair then
			if self._furniture_interact_tb.wheel_chair_tb then
				self:dormitory_rest_idea_wheel_chair_stop_event({
					ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_37_1.driver_id),
					furniture_ele = arg_37_1,
					orgin_pos = arg_37_1.car_spine_original_pos,
					ship_orgin_pos = arg_37_1.ship_spine_orgin_pos,
					furniture_orgin_flip_x = arg_37_1.car_spine_original_flip_x
				})
			end
		elseif arg_37_1.config_cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor and self._furniture_interact_tb.galo_giganotus_armor_tb then
			arg_37_1.car_ele.control:set_move_ai_condition(false)
			arg_37_1.car_ele.control:set_stop_furniture_ai(true, false)
			self:dormitory_rest_idea_wheel_chair_stop_event({
				ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_37_1.driver_id),
				furniture_ele = arg_37_1,
				orgin_pos = arg_37_1.car_spine_original_pos
			})
		end
	end

	function arg_1_0:dormitory_idea_manager_stop_wheel_chair_running(arg_38_1, arg_38_2)
		local var_38_0

		if arg_38_2 == var_0_5.dormitory_special_furniture_id.wheel_chair then
			if self._furniture_interact_tb.wheel_chair_tb then
				var_38_0 = self._furniture_interact_tb.wheel_chair_tb
			end
		elseif arg_38_2 == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor and self._furniture_interact_tb.galo_giganotus_armor_tb then
			var_38_0 = self._furniture_interact_tb.galo_giganotus_armor_tb
		end

		if var_38_0 then
			if var_38_0[arg_38_1] then
				var_38_0[arg_38_1].driver_id = -1
				var_38_0[arg_38_1].recover_time = var_38_0[arg_38_1].const_time
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_bike_arrive_destination(arg_39_1)
		if not arg_39_1.is_begin and arg_39_1.recover_num <= 0 and var_0_8(arg_39_1.car_spine_original_pos.x - arg_39_1.car_ele.control:get_spine_position().x) < 10 then
			arg_39_1.is_interactive = false
			arg_39_1.is_begin = true

			self:dormitory_idea_manager_stop_bike(arg_39_1.car_id, true, false)
		end
	end

	function arg_1_0:dormitory_idea_manager_stop_bike(arg_40_1, arg_40_2, arg_40_3)
		local var_40_1
		local var_40_2
		local var_40_0

		if not self._start_inter_old_bike then
			do return end

			var_40_0 = self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_40_1)
			var_40_1 = arg_40_3 and {
				2,
				3,
				4,
				5
			} or {
				0
			}
			var_40_2 = {}
		end

		var_40_2.ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.old_bike_car_tb[arg_40_1].driver_id)
		var_40_2.furniture_ele = var_40_0
		var_40_2.delay_array = var_40_1
		var_40_2.is_recover = arg_40_2

		if arg_40_2 then
			self:dormitory_take_old_bike_touch_barrier(var_40_2)
		else
			self:dormitory_idea_manager_rset_bike_data(var_40_0.data.id, false)
		end
	end

	function arg_1_0:dormitory_idea_manager_rset_bike_data(arg_41_1, arg_41_2)
		if self._furniture_interact_tb.old_bike_car_tb[arg_41_1] then
			self._furniture_interact_tb.old_bike_car_tb[arg_41_1].sitted = false
			self._furniture_interact_tb.old_bike_car_tb[arg_41_1].driver_id = -1
			self._furniture_interact_tb.old_bike_car_tb[arg_41_1].speed_up = false
			self._furniture_interact_tb.old_bike_car_tb[arg_41_1].target_speed = 0
			self._furniture_interact_tb.old_bike_car_tb[arg_41_1].is_interactive = false

			if self._furniture_interact_tb.old_bike_car_tb[arg_41_1].car_ele then
				self._furniture_interact_tb.old_bike_car_tb[arg_41_1].car_ele.control:toggle_furniture_collider(false)
				self._furniture_interact_tb.old_bike_car_tb[arg_41_1].car_ele.control:set_furniture_animation(0, "normal", true)

				if arg_41_2 then
					self._furniture_interact_tb.old_bike_car_tb[arg_41_1].car_ele.control:set_spine_position(self._furniture_interact_tb.old_bike_car_tb[arg_41_1].car_spine_original_pos)
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_stop_bike_touch_barrier(arg_42_1, arg_42_2)
		if self._start_inter_old_bike and arg_42_2 then
			for iter_42_0, iter_42_1 in pairs(self._furniture_interact_tb.old_bike_car_tb) do
				if arg_42_1 == iter_42_1.car_id then
					self:dormitory_idea_manager_set_car_state(iter_42_1, arg_42_2)
					self:dormitory_idea_manager_rset_bike_data(arg_42_1, false)

					return
				end
			end
		end
	end

	function arg_1_0:reset_old_bike_inter_data()
		if not self._start_inter_old_bike then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.old_bike_car_tb then
			for iter_43_0, iter_43_1 in pairs(self._furniture_interact_tb.old_bike_car_tb) do
				iter_43_1.sitted = false
				iter_43_1.driver_id = -1
				iter_43_1.speed_up = false
				iter_43_1.target_speed = 0
				iter_43_1.is_interactive = false

				if iter_43_1.car_ele then
					iter_43_1.car_ele.control:toggle_furniture_collider(false)
					iter_43_1.car_ele.control:set_furniture_animation(0, "normal", true)
					iter_43_1.car_ele.control:set_spine_position(iter_43_1.car_spine_original_pos)
				end
			end
		end
	end

	function arg_1_0.__dormitory_idea_manager_bike_drive(arg_44_0, arg_44_1, arg_44_2)
		if not arg_44_2 then
			return false
		end

		local var_44_0 = false

		for iter_44_0, iter_44_1 in pairs(arg_44_2) do
			if arg_44_1 == iter_44_1.driver_id then
				var_44_0 = true

				break
			end
		end

		return var_44_0
	end

	function arg_1_0:dormitory_idea_manager_get_galo_car_state(arg_45_1, arg_45_2)
		for iter_45_0, iter_45_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
			if arg_45_1 == iter_45_1.car_id then
				iter_45_1.galo_call_back = arg_45_2

				if iter_45_1.is_interactive then
					self:__dormitory_idea_manager_stop_galo_car_run(iter_45_1)
				else
					self:__dormitory_idea_manager_galo_request_run(iter_45_1)
				end

				return
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_init_galo_data()
		for iter_46_0, iter_46_1 in ipairs(self._curr_furniture_tb) do
			if iter_46_1.config.cid == var_0_5.dormitory_special_furniture_id.chariot then
				self._furniture_interact_tb.galo_car_tb = self._furniture_interact_tb.galo_car_tb or {}
				self._furniture_interact_tb.galo_car_tb[iter_46_1.data.id] = {
					speed_up = false,
					speed = 0,
					is_interactive = false,
					car_id = iter_46_1.data.id,
					target_speed = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].full_speed,
					full_speed = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].full_speed,
					recover_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					const_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					car_ele = iter_46_1,
					car_spine_original_pos = iter_46_1.control:get_spine_position()
				}
			end

			if iter_46_1.config.cid == var_0_5.dormitory_special_furniture_id.old_bike then
				self._furniture_interact_tb.old_bike_car_tb = self._furniture_interact_tb.old_bike_car_tb or {}
				self._furniture_interact_tb.old_bike_car_tb[iter_46_1.data.id] = {
					driver_id = -1,
					speed_up = false,
					is_begin = true,
					speed = 0,
					is_interactive = false,
					sitted = false,
					car_id = iter_46_1.data.id,
					target_speed = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].full_speed,
					full_speed = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].full_speed,
					recover_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					const_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					circle_array = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].circle_num,
					car_ele = iter_46_1,
					car_spine_original_pos = iter_46_1.control:get_spine_position()
				}
			end

			if iter_46_1.config.cid == var_0_5.dormitory_special_furniture_id.wheel_chair then
				self._furniture_interact_tb.wheel_chair_tb = self._furniture_interact_tb.wheel_chair_tb or {}
				self._furniture_interact_tb.wheel_chair_tb[iter_46_1.data.id] = {
					wait_time = 0,
					is_count_down = false,
					driver_id = -1,
					is_interactive = false,
					sitted = false,
					car_id = iter_46_1.data.id,
					config_cid = iter_46_1.config.cid,
					wait_time_list = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].wait_time_list,
					recover_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					const_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					ship_spine_orgin_pos = var_0_1(),
					car_ele = iter_46_1,
					car_spine_original_pos = iter_46_1.control:get_spine_position(),
					car_spine_original_flip_x = iter_46_1.control:get_furniture_flip_x()
				}
			end

			if iter_46_1.config.cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor then
				self._furniture_interact_tb.galo_giganotus_armor_tb = self._furniture_interact_tb.galo_giganotus_armor_tb or {}
				self._furniture_interact_tb.galo_giganotus_armor_tb[iter_46_1.data.id] = {
					is_interactive = false,
					is_count_down = false,
					driver_id = -1,
					sitted = false,
					car_id = iter_46_1.data.id,
					config_cid = iter_46_1.config.cid,
					recover_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					const_time = var_0_5.dormitory_race_car_sit_config[iter_46_1.config.cid].recover_time,
					car_ele = iter_46_1,
					car_spine_original_pos = iter_46_1.control:get_spine_position()
				}
			end
		end
	end

	function arg_1_0:__dormitory_idea_manager_galo_request_run(arg_47_1)
		for iter_47_0, iter_47_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
			if iter_47_1.car_id == arg_47_1.car_id and not self:__dormitory_idea_manager_check_position(iter_47_0, (iter_47_1.car_ele.control:get_spine_position())) then
				iter_47_1.galo_call_back()

				return
			end
		end

		if self._furniture_interact_tb and self._furniture_interact_tb.galo_car_tb then
			for iter_47_2, iter_47_3 in pairs(self._furniture_interact_tb.galo_car_tb) do
				iter_47_3.car_ele.control:toggle_furniture_collider(true)

				if iter_47_3.car_id == arg_47_1.car_id then
					iter_47_3.car_ele.control:set_furniture_animation(0, "normal2", true)
				end
			end

			arg_47_1.speed_up = true
			arg_47_1.is_interactive = true
		end

		if self._ship_members_tb then
			for iter_47_4, iter_47_5 in ipairs(self._ship_members_tb) do
				if not self:__dormitory_idea_manager_is_ship_sitting_normal_car(iter_47_5.data.id) and not self:dormitory_idea_manager_is_ship_sitting_car(iter_47_5.data.id) then
					iter_47_5.control:toggle_ship_collider(true)
				else
					iter_47_5.control:toggle_ship_collider(false)
				end
			end
		end

		self:dormitory_idea_manager_reset_all_collider_inactive_state()

		self._galo_start_inter = true
	end

	function arg_1_0:__dormitory_idea_manager_check_position(arg_48_1, arg_48_2)
		for iter_48_0, iter_48_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
			if iter_48_0 ~= arg_48_1 then
				local var_48_0 = iter_48_1.car_ele.control:get_spine_position()

				if var_0_8(arg_48_2.x - var_48_0.x) < 330 and var_0_8(arg_48_2.y - var_48_0.y) < 145 then
					if arg_48_2.x < var_48_0.x then
						return true
					else
						return false
					end
				end
			end
		end

		return true
	end

	function arg_1_0:__dormitory_idea_manager_stop_galo_car_run(arg_49_1)
		if self._furniture_interact_tb and self._furniture_interact_tb.galo_car_tb then
			arg_49_1.speed_up = false
			arg_49_1.speed = 0
			arg_49_1.is_interactive = false

			for iter_49_0, iter_49_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
				if iter_49_1.car_id == arg_49_1.car_id then
					iter_49_1.galo_call_back()
				end
			end
		end
	end

	function arg_1_0:reset_galo_car_inter_state()
		if self._furniture_interact_tb and self._furniture_interact_tb.galo_car_tb then
			for iter_50_0, iter_50_1 in pairs(self._furniture_interact_tb.galo_car_tb) do
				if iter_50_1.car_ele then
					iter_50_1.car_ele.control:toggle_furniture_collider(false)
					iter_50_1.car_ele.control:set_furniture_animation(0, "normal", true)
					iter_50_1.car_ele.control:set_spine_position(iter_50_1.car_spine_original_pos)
				end
			end
		end
	end

	function arg_1_0.__get_ship_animation_name(arg_51_0, arg_51_1)
		local var_51_0
		local var_51_1 = 0
		local var_51_2 = 0
		local var_51_3 = 0

		if arg_51_1 == 1 then
			var_51_0 = "stand1"
			var_51_3 = 1
		elseif arg_51_1 == 2 then
			var_51_0 = "sit"
			var_51_1 = 88.5
			var_51_2 = 0.2
			var_51_3 = 3
		elseif arg_51_1 == 3 then
			var_51_0 = "sit"
			var_51_1 = 60
			var_51_2 = 0.2
			var_51_3 = 3
		end

		return var_51_0, var_51_1, var_51_2, var_51_3
	end

	function arg_1_0:__set_driver_position(arg_52_1, arg_52_2, arg_52_3)
		if self._furniture_interact_tb.inter_car_tb then
			for iter_52_0, iter_52_1 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_52_1.car_id == arg_52_2 then
					if arg_52_3 == 1 then
						iter_52_1.driver_pos = arg_52_1
						self._furniture_interact_tb[arg_52_2] = true
					elseif arg_52_3 == 2 then
						iter_52_1.take_second_pos = arg_52_1 + var_0_1(0, 88.5)
					else
						iter_52_1.take_third_pos = arg_52_1 + var_0_1(0, 60)
					end
				end
			end
		end
	end

	function arg_1_0:__change_multiplay_inter_state(arg_53_1)
		self:hand_carts_idea_request_drive_car({
			ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_53_1.driver_list[1]),
			furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_53_1.car_id)
		})

		arg_53_1.is_have_driver = false
	end

	function arg_1_0:__get_take_personnel_position_info(arg_54_1)
		return self:__dormitory_idea_manager_get_ship_ele_by_id(arg_54_1.driver_list[1]).control:get_foot_position(), (arg_54_1.driver_list[2] or nil) and self:__dormitory_idea_manager_get_ship_ele_by_id(arg_54_1.driver_list[2]).control:get_foot_position(), (arg_54_1.driver_list[3] or nil) and self:__dormitory_idea_manager_get_ship_ele_by_id(arg_54_1.driver_list[3]).control:get_foot_position()
	end

	function arg_1_0:dormitory_idea_manager_stop_ship_inter(arg_55_1)
		if arg_55_1.config_cid == var_0_5.dormitory_special_furniture_id.wheel_chair then
			if self._furniture_interact_tb.wheel_chair_tb then
				self:dormitory_rest_idea_stop_single_ship_inter({
					ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_55_1.driver_id),
					furniture_ele = arg_55_1
				})
			end
		elseif arg_55_1.config_cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor and self._furniture_interact_tb.galo_giganotus_armor_tb then
			self:dormitory_rest_idea_stop_single_ship_inter({
				ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_55_1.driver_id),
				furniture_ele = arg_55_1
			})
		end
	end

	function arg_1_0:dormitory_idea_manager_set_curr_furniture_random_walk(arg_56_1)
		for iter_56_0, iter_56_1 in pairs(self._furniture_interact_tb.galo_giganotus_armor_tb) do
			if iter_56_1.car_id == arg_56_1 then
				iter_56_1.car_ele.control:set_curr_furniture_start_ai_condition(true, nil)
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_update_special_furniture_alpha(arg_57_1, arg_57_2)
		if arg_57_2.config_cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor then
			for iter_57_0, iter_57_1 in pairs(self._furniture_interact_tb.galo_giganotus_armor_tb) do
				if iter_57_1.car_id == arg_57_2.car_id then
					iter_57_1.car_ele.control:update_special_furniture_alpha(false)
				end
			end
		end
	end

	function arg_1_0:__record_curr_inter_ship_pos(arg_58_1, arg_58_2)
		for iter_58_0, iter_58_1 in pairs(self._furniture_interact_tb.wheel_chair_tb) do
			if iter_58_1.car_id == arg_58_1.data.id then
				iter_58_1.ship_spine_orgin_pos = arg_58_2
			end
		end
	end

	function arg_1_0.__get_spine_name_by_furniture_cid(arg_59_0, arg_59_1)
		local var_59_0
		local var_59_1 = 0
		local var_59_2 = true

		if arg_59_1 == var_0_5.dormitory_special_furniture_id.wheel_chair then
			var_59_0 = "normal"
		else
			var_59_0 = "end"
			var_59_1 = 1
			var_59_2 = false
		end

		return var_59_0, var_59_1, var_59_2
	end

	function arg_1_0:transmit_begin_interactive_data(arg_60_1)
		if arg_60_1.config_cid == var_0_5.dormitory_special_furniture_id.asura_chariot then
			self:dormitory_idea_manager_asura_request_drive_car(arg_60_1.ship_id, arg_60_1.furniture_id)
		elseif arg_60_1.config_cid == var_0_5.dormitory_special_furniture_id.old_bike or arg_60_1.config_cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor or arg_60_1.config_cid == var_0_5.dormitory_special_furniture_id.wheel_chair then
			self:dormitory_idea_manager_request_inter_by_ship(arg_60_1.ship_id, arg_60_1.furniture_id, arg_60_1.config_cid)
		elseif arg_60_1.config_cid == var_0_5.dormitory_special_furniture_id.tree_swing then
			self:dormitory_idea_manager_request_play_tree_swing(arg_60_1.ship_id, arg_60_1.furniture_id)
		else
			self:dormitory_idea_manager_normal_request_drive_car(arg_60_1.ship_id, arg_60_1.furniture_id)
		end
	end

	function arg_1_0:transmit_end_interactive_data(arg_61_1)
		if arg_61_1.config_cid == var_0_5.dormitory_special_furniture_id.asura_chariot then
			self:dormitory_idea_manager_stop_asura_inter(arg_61_1.furniture_id, arg_61_1.is_recover)
		elseif arg_61_1.config_cid == var_0_5.dormitory_special_furniture_id.tree_swing then
			self:dormitory_idea_manager_stop_tree_inter(arg_61_1.furniture_id)
		elseif arg_61_1.config_cid == var_0_5.dormitory_special_furniture_id.old_bike then
			self:dormitory_idea_manager_rset_bike_data(arg_61_1.furniture_id, arg_61_1.is_recover)
		elseif arg_61_1.config_cid == var_0_5.dormitory_special_furniture_id.wheel_chair or arg_61_1.config_cid == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor then
			self:dormitory_idea_manager_stop_wheel_chair_running(arg_61_1.furniture_id, arg_61_1.config_cid)
		elseif arg_61_1.car_ele and (arg_61_1.car_ele.config.cid == var_0_5.dormitory_special_furniture_id.black_car or arg_61_1.car_ele.config.cid == var_0_5.dormitory_special_furniture_id.hand_car) then
			self:dormitory_idea_manager_stop_single_inter_to_set_car_data(arg_61_1.furniture_id, arg_61_1.is_recover)
		end
	end

	function arg_1_0:wait_delay_excute_event(arg_62_1)
		if arg_62_1.config_cid == var_0_5.dormitory_special_furniture_id.hand_car then
			self:__set_ship_raycast_event(arg_62_1.delay_data.furniture_cid, arg_62_1.delay_data.ship_index, arg_62_1.delay_data.ship_id)
		elseif arg_62_1.config_cid == var_0_5.dormitory_special_furniture_id.hit_melon then
			self:__dormitory_idea_manager_get_ship_ele_by_id(arg_62_1.delay_data).control:toggle_ship_btn_raycast(true)
		end
	end

	function arg_1_0:__set_ship_raycast_event(arg_63_1, arg_63_2, arg_63_3)
		if arg_63_1 == var_0_5.dormitory_special_furniture_id.hand_car and (arg_63_2 == 2 or arg_63_2 == 3) then
			self:__dormitory_idea_manager_get_ship_ele_by_id(arg_63_3).control:toggle_ship_btn_raycast(true)
		end
	end
end

function var_0_0.extend_obj(arg_64_0)
	return
end

return var_0_0
