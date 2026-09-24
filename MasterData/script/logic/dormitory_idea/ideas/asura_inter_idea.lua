local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_5 = gameenum.common_type
local var_0_6 = UnityEngine.Time
local var_0_7 = gamecore.util_func
local var_0_8 = math.abs
local var_0_9 = UnityEngine.Mathf
local var_0_10 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_rest_idea_asura_drive_car(arg_2_1)
		local var_2_0 = var_0_1()

		var_2_0.x = (arg_2_1.furniture_ele.data.point.x + arg_2_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_2_0.y = (arg_2_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_2_1 = {}

		self:__set_asura_driver_position(arg_2_1.furniture_ele.data.id, var_2_0)

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
			diff_num = var_0_1(0, 60)
		}
		var_2_1[#var_2_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_2_1.furniture_ele.config.cid].sit_anim
		}

		self:dormitory_idea_manager_wait_idea(var_2_1, 0.1)

		var_2_1[#var_2_1 + 1] = {
			type = "request_drive_normal_car",
			ship_id = arg_2_1.ship_ele.data.id,
			furniture_id = arg_2_1.furniture_ele.data.id,
			config_cid = arg_2_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_2_1, 1)

		var_2_1[#var_2_1 + 1] = {
			spine_name = "fly",
			spine_state = true,
			type = "request_change_spine",
			furniture_id = arg_2_1.furniture_ele.data.id
		}

		arg_2_1.ship_ele.control:set_play_action_list(var_2_1)
	end

	function arg_1_0:dormitory_rest_idea_stop_asura_car(arg_3_1)
		local var_3_0 = {}

		var_3_0[#var_3_0 + 1] = {
			spine_name = "close",
			spine_state = false,
			type = "request_change_spine",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		self:dormitory_idea_manager_wait_idea(var_3_0, arg_3_1.delay_time)

		var_3_0[#var_3_0 + 1] = {
			type = "request_stop_car",
			furniture_id = arg_3_1.furniture_ele.data.id,
			config_cid = arg_3_1.furniture_ele.config.cid
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
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		arg_3_1.ship_ele.control:set_play_action_list(var_3_0)
	end

	function arg_1_0:dormitory_rest_idea_play_tree_swing(arg_4_1)
		local var_4_0 = var_0_1()

		var_4_0.x = (arg_4_1.furniture_ele.data.point.x + arg_4_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_4_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_4_0.y = (arg_4_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_4_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_4_1 = {}

		var_4_1[#var_4_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_4_1.furniture_ele.control:get_sort_order() + 1
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
			diff_num = var_0_1(0, 30)
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

		self:dormitory_idea_manager_wait_idea(var_4_1, 1)

		var_4_1[#var_4_1 + 1] = {
			spine_state = true,
			spine_name = "normal2",
			type = "request_change_spine",
			furniture_id = arg_4_1.furniture_ele.data.id,
			config_cid = arg_4_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_4_1, (self:__get_random_circle_num(arg_4_1.ship_ele.data.id, arg_4_1.furniture_ele.data.id)))

		var_4_1[#var_4_1 + 1] = {
			spine_state = false,
			spine_name = "out",
			type = "request_change_spine",
			furniture_id = arg_4_1.furniture_ele.data.id,
			config_cid = arg_4_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_4_1, 5.333)

		var_4_1[#var_4_1 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_4_1.furniture_ele.data.id,
			config_cid = arg_4_1.furniture_ele.config.cid
		}
		var_4_1[#var_4_1 + 1] = {
			type = "request_stop_car",
			furniture_id = arg_4_1.furniture_ele.data.id,
			config_cid = arg_4_1.furniture_ele.config.cid
		}
		var_4_1[#var_4_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_4_1.furniture_ele.data.id
		}

		arg_4_1.ship_ele.control:set_play_action_list(var_4_1)
		arg_4_1.ship_ele.control:set_inter_furniture_element(arg_4_1.furniture_ele)
	end

	function arg_1_0:dormitory_rest_idea_play_hit_melon(arg_5_1)
		local var_5_0 = var_0_1()

		var_5_0.x = (arg_5_1.furniture_ele.data.point.x + arg_5_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_5_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_5_0.y = (arg_5_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_5_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_5_1 = {}

		var_5_1[#var_5_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_5_1.furniture_ele.control:get_sort_order() + 1
		}
		var_5_1[#var_5_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_5_1, arg_5_1.ship_ele.control:get_foot_position(), var_5_0, arg_5_1.furniture_ele)

		var_5_1[#var_5_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_5_1[#var_5_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_5_1.furniture_ele.config.cid].sit_anim
		}
		var_5_1[#var_5_1 + 1] = {
			spine_state = false,
			spine_name = "hit",
			type = "request_change_spine",
			furniture_id = arg_5_1.furniture_ele.data.id,
			config_cid = arg_5_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_5_1, 4)

		var_5_1[#var_5_1 + 1] = {
			spine_state = true,
			spine_name = "normal2",
			type = "request_change_spine",
			furniture_id = arg_5_1.furniture_ele.data.id,
			config_cid = arg_5_1.furniture_ele.config.cid
		}
		var_5_1[#var_5_1 + 1] = {
			type = "delay_excute_event",
			config_cid = arg_5_1.furniture_ele.config.cid,
			delay_data = arg_5_1.ship_ele.data.id
		}
		var_5_1[#var_5_1 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_5_1[#var_5_1 + 1] = {
			cooling_time = 15,
			type = "stop"
		}

		arg_5_1.ship_ele.control:set_play_action_list(var_5_1)
	end

	function arg_1_0.dormitory_rest_idea_stop_play_hit_melon(arg_6_0, arg_6_1)
		local var_6_0 = {}

		var_6_0[#var_6_0 + 1] = {
			spine_state = false,
			spine_name = "normal2",
			type = "request_change_spine",
			furniture_id = arg_6_1.furniture_ele.data.id,
			config_cid = arg_6_1.furniture_ele.config.cid
		}
		var_6_0[#var_6_0 + 1] = {
			cooling_time = 15,
			type = "stop"
		}

		arg_6_1.ship_ele.control:set_play_action_list(var_6_0)
	end

	function arg_1_0:dormitory_rest_idea_king_of_combat(arg_7_1)
		local var_7_0 = var_0_1()

		var_7_0.x = (arg_7_1.furniture_ele.data.point.x + arg_7_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_7_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_7_0.y = (arg_7_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_7_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_7_1 = {}

		var_7_1[#var_7_1 + 1] = {
			type = "start_car",
			car_ele = arg_7_1.furniture_ele
		}
		var_7_1[#var_7_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_7_1.furniture_ele.control:get_sort_order() + 1
		}
		var_7_1[#var_7_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_7_1, arg_7_1.ship_ele.control:get_foot_position(), var_7_0, arg_7_1.furniture_ele)

		local var_7_2, var_7_3 = self:__get_drive_drift_car_ship_info(arg_7_1.furniture_ele.config.cid)

		var_7_1[#var_7_1 + 1] = {
			type = "flip_x",
			flip = var_7_2
		}
		var_7_1[#var_7_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_7_1.furniture_ele.config.cid].sit_anim
		}
		var_7_1[#var_7_1 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, var_7_3)
		}
		var_7_1[#var_7_1 + 1] = {
			spine_state = true,
			spine_name = "open",
			type = "request_change_spine",
			furniture_id = arg_7_1.furniture_ele.data.id,
			config_cid = arg_7_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_7_1, (self:__get_random_num_by_combat(arg_7_1.ship_ele.data.id, arg_7_1.furniture_ele.data.id, arg_7_1.furniture_ele.config.cid)))

		var_7_1[#var_7_1 + 1] = {
			spine_state = false,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_7_1.furniture_ele.data.id,
			config_cid = arg_7_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_7_1, 1)

		var_7_1[#var_7_1 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_7_1[#var_7_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_7_1.furniture_ele.data.id
		}

		arg_7_1.ship_ele.control:set_play_action_list(var_7_1)
	end

	function arg_1_0:dormitory_rest_idea_the_terrace_arcade(arg_8_1)
		local var_8_0 = arg_8_1.furniture_ele
		local var_8_1 = self:__record_inter_ship_num(arg_8_1.furniture_ele.data.id, arg_8_1.ship_ele.data.id, arg_8_1.furniture_ele.config.cid)
		local var_8_2 = var_0_1()

		var_8_2.x = (arg_8_1.furniture_ele.data.point.x + arg_8_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].delta_grid_x[var_8_1]) * var_0_5.dormitory_const.room_x_plus
		var_8_2.y = (var_8_0.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].delta_grid_y[var_8_1]) * var_0_5.dormitory_const.room_y_plus

		local var_8_3 = {}

		var_8_3[#var_8_3 + 1] = {
			type = "start_car",
			car_ele = var_8_0
		}
		var_8_3[#var_8_3 + 1] = {
			type = "set_sort_order",
			sort_order = var_8_0.control:get_sort_order() + 1
		}
		var_8_3[#var_8_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_8_3, arg_8_1.ship_ele.control:get_foot_position(), var_8_2, var_8_0)

		local var_8_4, var_8_5 = self:__get_drive_drift_car_ship_info(var_8_0.config.cid, var_8_1)

		var_8_3[#var_8_3 + 1] = {
			type = "flip_x",
			flip = var_8_4
		}
		var_8_3[#var_8_3 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_8_1.furniture_ele.config.cid].sit_anim
		}

		self:__get_random_num_by_combat(arg_8_1.ship_ele.data.id, var_8_0.data.id, var_8_0.config.cid)

		local var_8_6

		if var_8_0.config.cid == var_0_5.dormitory_special_furniture_id.dancing_machine then
			var_8_6 = var_8_1
			var_8_1 = "P"
		elseif var_8_0.config.cid == var_0_5.dormitory_special_furniture_id.the_terrace_arcade then
			var_8_6 = "open"
		end

		var_8_3[#var_8_3 + 1] = {
			spine_state = true,
			type = "request_change_spine",
			furniture_id = var_8_0.data.id,
			spine_name = tostring(var_8_6 .. var_8_1),
			config_cid = var_8_0.config.cid
		}

		arg_8_1.ship_ele.control:set_play_action_list(var_8_3)
	end

	function arg_1_0.dormitory_rest_idea_stop_the_terrace_arcade_inter(arg_9_0, arg_9_1)
		local var_9_0 = {}

		var_9_0[#var_9_0 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_9_1.furniture_ele.data.id,
			config_cid = arg_9_1.furniture_ele.config.cid
		}
		var_9_0[#var_9_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_9_0[#var_9_0 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_9_1.furniture_ele.data.id
		}

		arg_9_1.ship_ele.control:set_play_action_list(var_9_0)
	end

	function arg_1_0.dormitory_rest_idea_stop_single_inter(arg_10_0, arg_10_1)
		local var_10_0 = {}

		var_10_0[#var_10_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_10_0[#var_10_0 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_10_1.furniture_ele.data.id
		}

		arg_10_1.ship_ele.control:set_play_action_list(var_10_0)
	end

	function arg_1_0:dormitory_rest_idea_youth_shoot_machine(arg_11_1)
		local var_11_0 = var_0_1()

		var_11_0.x = (arg_11_1.furniture_ele.data.point.x + arg_11_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_11_0.y = (arg_11_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_11_1 = {}

		var_11_1[#var_11_1 + 1] = {
			type = "start_car",
			car_ele = arg_11_1.furniture_ele
		}
		var_11_1[#var_11_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_11_1.furniture_ele.control:get_sort_order() + 1
		}
		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_11_1, arg_11_1.ship_ele.control:get_foot_position(), var_11_0, arg_11_1.furniture_ele)

		local var_11_2, var_11_3 = self:__get_drive_drift_car_ship_info(arg_11_1.furniture_ele.config.cid)

		var_11_1[#var_11_1 + 1] = {
			type = "flip_x",
			flip = var_11_2
		}
		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].sit_anim
		}

		local var_11_4, var_11_5 = self:__get_random_num_by_youth_shoot_machine(arg_11_1.furniture_ele.data.id, arg_11_1.furniture_ele.config.cid)

		var_11_1[#var_11_1 + 1] = {
			spine_state = false,
			type = "request_change_spine",
			furniture_id = arg_11_1.furniture_ele.data.id,
			spine_name = var_11_4,
			config_cid = arg_11_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_11_1, var_11_5)

		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].sit_anim
		}

		local var_11_6, var_11_7 = self:__get_random_num_by_youth_shoot_machine(arg_11_1.furniture_ele.data.id, arg_11_1.furniture_ele.config.cid)

		var_11_1[#var_11_1 + 1] = {
			spine_state = false,
			type = "request_change_spine",
			furniture_id = arg_11_1.furniture_ele.data.id,
			spine_name = var_11_6,
			config_cid = arg_11_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_11_1, var_11_7)

		var_11_1[#var_11_1 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_11_1.furniture_ele.config.cid].sit_anim
		}

		local var_11_8, var_11_9 = self:__get_random_num_by_youth_shoot_machine(arg_11_1.furniture_ele.data.id, arg_11_1.furniture_ele.config.cid)

		var_11_1[#var_11_1 + 1] = {
			spine_state = false,
			type = "request_change_spine",
			furniture_id = arg_11_1.furniture_ele.data.id,
			spine_name = var_11_8,
			config_cid = arg_11_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_11_1, var_11_9)

		var_11_1[#var_11_1 + 1] = {
			spine_state = false,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_11_1.furniture_ele.data.id,
			config_cid = arg_11_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_11_1, 1)

		var_11_1[#var_11_1 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_11_1[#var_11_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_11_1.furniture_ele.data.id
		}

		arg_11_1.ship_ele.control:set_play_action_list(var_11_1)
	end

	function arg_1_0:dormitory_rest_idea_child_machine(arg_12_1)
		local var_12_0 = var_0_1()

		var_12_0.x = (arg_12_1.furniture_ele.data.point.x + arg_12_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_12_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_12_0.y = (arg_12_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_12_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_12_1 = {}

		var_12_1[#var_12_1 + 1] = {
			type = "start_car",
			car_ele = arg_12_1.furniture_ele
		}
		var_12_1[#var_12_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_12_1.furniture_ele.control:get_sort_order() + 1
		}
		var_12_1[#var_12_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_12_1, arg_12_1.ship_ele.control:get_foot_position(), var_12_0, arg_12_1.furniture_ele)

		local var_12_2, var_12_3 = self:__get_drive_drift_car_ship_info(arg_12_1.furniture_ele.config.cid)

		var_12_1[#var_12_1 + 1] = {
			type = "flip_x",
			flip = var_12_2
		}
		var_12_1[#var_12_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_12_1.furniture_ele.config.cid].sit_anim
		}

		local var_12_4, var_12_5 = self:__get_random_num_by_youth_shoot_machine(arg_12_1.furniture_ele.data.id, arg_12_1.furniture_ele.config.cid)

		var_12_1[#var_12_1 + 1] = {
			spine_state = false,
			type = "request_change_spine",
			furniture_id = arg_12_1.furniture_ele.data.id,
			spine_name = var_12_4,
			config_cid = arg_12_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_12_1, var_12_5)

		var_12_1[#var_12_1 + 1] = {
			spine_state = false,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_12_1.furniture_ele.data.id,
			config_cid = arg_12_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_12_1, 2)

		var_12_1[#var_12_1 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_12_1[#var_12_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_12_1.furniture_ele.data.id
		}

		arg_12_1.ship_ele.control:set_play_action_list(var_12_1)
		arg_12_1.ship_ele.control:set_inter_furniture_element(arg_12_1.furniture_ele)
	end

	function arg_1_0:dormitory_rest_idea_single_slider(arg_13_1)
		local var_13_0 = var_0_1()

		var_13_0.x = (arg_13_1.furniture_ele.data.point.x + arg_13_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_13_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_13_0.y = (arg_13_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_13_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_13_2 = {}

		var_13_2[#var_13_2 + 1] = {
			type = "start_car",
			car_ele = arg_13_1.furniture_ele
		}
		var_13_2[#var_13_2 + 1] = {
			type = "set_sort_order",
			sort_order = arg_13_1.furniture_ele.control:get_sort_order() + 1
		}
		var_13_2[#var_13_2 + 1] = {
			track_index = 0,
			animation_name = "jump",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_13_2, 1)

		var_13_2[#var_13_2 + 1] = {
			track_index = 0,
			animation_name = "sit_Janpan",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_13_2, arg_13_1.ship_ele.control:get_foot_position(), var_13_0, arg_13_1.furniture_ele)
		self:dormitory_idea_manager_wait_idea(var_13_2, 1)

		var_13_2[#var_13_2 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_13_2, 0.5)

		var_13_2[#var_13_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_13_2[#var_13_2 + 1] = {
			type = "request_stop_car",
			config_cid = arg_13_1.furniture_ele.config.cid
		}
		var_13_2[#var_13_2 + 1] = {
			cooling_time = 15,
			type = "stop"
		}

		arg_13_1.ship_ele.control:set_play_action_list(var_13_2)
	end

	function arg_1_0:dormitory_rest_idea_water_motorcycle(arg_14_1)
		local var_14_0 = var_0_1()

		var_14_0.x = (arg_14_1.furniture_ele.data.point.x + arg_14_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_14_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_14_0.y = (arg_14_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_14_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_14_1 = arg_14_1.ship_ele.control:get_foot_position()
		local var_14_2 = {}

		var_14_2[#var_14_2 + 1] = {
			type = "set_sort_order",
			sort_order = arg_14_1.furniture_ele.control:get_sort_order() + 1
		}
		var_14_2[#var_14_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_14_2, arg_14_1.ship_ele.control:get_foot_position(), var_14_0, arg_14_1.furniture_ele)

		var_14_2[#var_14_2 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, 45)
		}
		var_14_2[#var_14_2 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_14_2[#var_14_2 + 1] = {
			type = "reset_water_ripple"
		}
		var_14_2[#var_14_2 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_0_5.dormitory_race_car_sit_config[arg_14_1.furniture_ele.config.cid].sit_anim
		}
		var_14_2[#var_14_2 + 1] = {
			spine_state = true,
			type = "request_change_spine",
			furniture_id = arg_14_1.furniture_ele.data.id,
			config_cid = arg_14_1.furniture_ele.config.cid,
			spine_name = self:__get_swim_ring_or_water_motorcycle_spine_name(arg_14_1.furniture_ele.config.cid)
		}

		self:dormitory_idea_manager_wait_idea(var_14_2, (self:__get_swim_ring_or_water_motorcycle_delay_time()))

		var_14_2[#var_14_2 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_14_1.furniture_ele.data.id,
			config_cid = arg_14_1.furniture_ele.config.cid
		}

		self:dormitory_idea_manager_wait_idea(var_14_2, 1)

		var_14_2[#var_14_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_14_2[#var_14_2 + 1] = {
			type = "stop",
			furniture_id = arg_14_1.furniture_ele.data.id
		}

		arg_14_1.ship_ele.control:set_play_action_list(var_14_2)
	end

	function arg_1_0:dormitory_rest_idea_mini_track_boat_race(arg_15_1)
		local var_15_0 = arg_15_1.furniture_ele
		local var_15_1 = arg_15_1.ship_ele.control:get_foot_position()
		local var_15_2 = var_0_1()
		local var_15_3, var_15_4, var_15_5, var_15_6 = self:__get_ship_move_point_list(var_15_1, arg_15_1.furniture_ele, var_0_5.dormitory_race_car_sit_config[arg_15_1.furniture_ele.config.cid], arg_15_1.ship_ele)
		local var_15_7 = var_0_5.dormitory_race_car_sit_config[arg_15_1.furniture_ele.config.cid].sit_anim
		local var_15_8 = var_0_5.dormitory_race_car_sit_config[arg_15_1.furniture_ele.config.cid].inter_anim
		local var_15_9 = {}

		var_15_9[#var_15_9 + 1] = {
			type = "start_car",
			car_ele = var_15_0
		}
		var_15_9[#var_15_9 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_15_9, var_15_1, var_15_5, var_15_0)

		local var_15_11
		local var_15_10

		if var_15_4 then
			self:dormitory_idea_manager_move_to_action_pos(var_15_9, var_15_5, var_15_6, var_15_0)

			var_15_10 = #var_15_9 + 1
			var_15_11 = {
				type = "flip_x"
			}
		end

		var_15_11.flip = var_15_3 == 1
		var_15_9[var_15_10] = var_15_11
		var_15_9[#var_15_9 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_15_7
		}
		var_15_9[#var_15_9 + 1] = {
			type = "set_sort_order",
			sort_order = var_15_0.control:get_sort_order() - 1
		}
		var_15_9[#var_15_9 + 1] = {
			type = "set_ship_inter_state",
			furniture_id = var_15_0.data.id,
			furniture_cid = var_15_0.config.cid
		}

		if self:__get_inter_record_ship_num(var_15_0) == 1 then
			var_15_9[#var_15_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_15_0.data.id,
				spine_name = var_15_8[2],
				config_cid = var_15_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_15_9, 1)

			var_15_9[#var_15_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_15_0.data.id,
				spine_name = var_15_8[1],
				config_cid = var_15_0.config.cid
			}
		else
			var_15_9[#var_15_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_15_0.data.id,
				spine_name = var_15_8[4],
				config_cid = var_15_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_15_9, 1)

			var_15_9[#var_15_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_15_0.data.id,
				spine_name = var_15_8[5],
				config_cid = var_15_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_15_9, 1)

			var_15_9[#var_15_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_15_0.data.id,
				spine_name = var_15_8[3],
				config_cid = var_15_0.config.cid
			}
		end

		arg_15_1.ship_ele.control:set_play_action_list(var_15_9)
	end

	function arg_1_0.dormitory_rest_idea_stop_mini_track_boat_race_inter(arg_16_0, arg_16_1)
		local var_16_0 = {}

		var_16_0[#var_16_0 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_16_1.furniture_ele.data.id,
			config_cid = arg_16_1.furniture_ele.config.cid
		}
		var_16_0[#var_16_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_16_0[#var_16_0 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_16_1.furniture_ele.data.id
		}

		arg_16_1.ship_ele.control:set_play_action_list(var_16_0)
	end

	function arg_1_0:dormitory_rest_idea_duel_disk(arg_17_1)
		local var_17_0 = arg_17_1.furniture_ele
		local var_17_1 = arg_17_1.ship_ele.control:get_foot_position()
		local var_17_2 = var_0_1()
		local var_17_3, var_17_4, var_17_5, var_17_6 = self:__get_ship_move_point_list(var_17_1, arg_17_1.furniture_ele, var_0_5.dormitory_race_car_sit_config[arg_17_1.furniture_ele.config.cid], arg_17_1.ship_ele)
		local var_17_7 = var_0_5.dormitory_race_car_sit_config[arg_17_1.furniture_ele.config.cid].sit_anim
		local var_17_8 = var_0_5.dormitory_race_car_sit_config[arg_17_1.furniture_ele.config.cid].inter_anim
		local var_17_9 = {}

		var_17_9[#var_17_9 + 1] = {
			type = "start_car",
			car_ele = var_17_0
		}
		var_17_9[#var_17_9 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_17_9, var_17_1, var_17_5, var_17_0)

		local var_17_10
		local var_17_11

		if var_17_4 then
			self:dormitory_idea_manager_move_to_action_pos(var_17_9, var_17_5, var_17_6, var_17_0)

			var_17_10 = #var_17_9 + 1
			var_17_11 = {
				type = "flip_x"
			}
		end

		var_17_11.flip = var_17_3 == 1
		var_17_9[var_17_10] = var_17_11
		var_17_9[#var_17_9 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_17_7
		}
		var_17_9[#var_17_9 + 1] = {
			type = "set_sort_order",
			sort_order = var_17_0.control:get_sort_order() - 1
		}
		var_17_9[#var_17_9 + 1] = {
			type = "set_ship_inter_state",
			furniture_id = var_17_0.data.id,
			furniture_cid = var_17_0.config.cid
		}

		if self:__get_inter_record_ship_num(var_17_0) == 1 then
			var_17_9[#var_17_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_17_0.data.id,
				spine_name = var_17_8[2],
				config_cid = var_17_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_17_9, 2)

			var_17_9[#var_17_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_17_0.data.id,
				spine_name = var_17_8[1],
				config_cid = var_17_0.config.cid
			}
		else
			var_17_9[#var_17_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_17_0.data.id,
				spine_name = var_17_8[6],
				config_cid = var_17_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_17_9, 2)

			var_17_9[#var_17_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_17_0.data.id,
				spine_name = var_17_8[7],
				config_cid = var_17_0.config.cid
			}

			self:dormitory_idea_manager_wait_idea(var_17_9, 2)

			var_17_9[#var_17_9 + 1] = {
				spine_state = true,
				type = "request_change_spine",
				furniture_id = var_17_0.data.id,
				spine_name = var_17_8[5],
				config_cid = var_17_0.config.cid
			}
		end

		arg_17_1.ship_ele.control:set_play_action_list(var_17_9)
	end

	function arg_1_0.dormitory_rest_idea_stop_duel_disk_inter(arg_18_0, arg_18_1)
		local var_18_0 = {}

		var_18_0[#var_18_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_18_0[#var_18_0 + 1] = {
			spine_state = true,
			spine_name = "close",
			type = "request_change_spine",
			furniture_id = arg_18_1.furniture_ele.data.id,
			config_cid = arg_18_1.furniture_ele.config.cid
		}
		var_18_0[#var_18_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_18_0[#var_18_0 + 1] = {
			cooling_time = 30,
			type = "stop",
			furniture_id = arg_18_1.furniture_ele.data.id
		}

		arg_18_1.ship_ele.control:set_play_action_list(var_18_0)
	end

	function arg_1_0:dormitory_rest_idea_stop_double_ship_inter(arg_19_1)
		local var_19_0 = arg_19_1.furniture_ele
		local var_19_1 = {}

		var_19_1[#var_19_1 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_19_1[#var_19_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_19_0.control:get_sort_order() + 1
		}

		local var_19_2 = self:__get_random_win_loss_state(arg_19_1.ship_ele, var_19_0.data.id)
		local var_19_3 = var_19_2 and "good_idea" or "event_black_line"
		local var_19_4 = var_19_2 and 0.667 or 2

		var_19_1[#var_19_1 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_19_2 and "SP_love" or "SP_sad"
		}
		var_19_1[#var_19_1 + 1] = {
			loop = false,
			type = "set_expression",
			expression_name = var_19_3,
			duration = var_19_4
		}

		self:dormitory_idea_manager_wait_idea(var_19_1, 2)

		var_19_1[#var_19_1 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_19_1[#var_19_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = var_19_0.data.id
		}

		arg_19_1.ship_ele.control:set_play_action_list(var_19_1)
	end

	function arg_1_0:dormitory_rest_idea_galo_radio(arg_20_1)
		local var_20_0 = arg_20_1.furniture_ele
		local var_20_1 = var_0_1()
		local var_20_2 = var_0_5.dormitory_race_car_sit_config[arg_20_1.furniture_ele.config.cid]
		local var_20_3 = self:__record_inter_ship_num(arg_20_1.furniture_ele.data.id, arg_20_1.ship_ele.data.id, arg_20_1.furniture_ele.config.cid)

		var_20_1.x = (arg_20_1.furniture_ele.data.point.x + arg_20_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_20_1.furniture_ele.config.cid].delta_grid_x[var_20_3]) * var_0_5.dormitory_const.room_x_plus
		var_20_1.y = (var_20_0.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_20_1.furniture_ele.config.cid].delta_grid_y[var_20_3]) * var_0_5.dormitory_const.room_y_plus

		local var_20_4 = {}

		var_20_4[#var_20_4 + 1] = {
			type = "start_car",
			car_ele = var_20_0
		}
		var_20_4[#var_20_4 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_20_4, arg_20_1.ship_ele.control:get_foot_position(), var_20_1, var_20_0)

		var_20_4[#var_20_4 + 1] = {
			type = "flip_x",
			flip = var_20_3 == 1 and true or false
		}
		var_20_4[#var_20_4 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = (self:get_animation_name_by_ship_cid(arg_20_1.ship_ele.data) or nil) and (var_20_2.ani_dance or var_20_2.ani_jump)
		}
		var_20_4[#var_20_4 + 1] = {
			type = "set_ship_inter_state",
			furniture_id = var_20_0.data.id,
			furniture_cid = var_20_0.config.cid
		}
		var_20_4[#var_20_4 + 1] = {
			spine_state = true,
			spine_name = "open",
			type = "request_change_spine",
			furniture_id = var_20_0.data.id,
			config_cid = var_20_0.config.cid
		}

		arg_20_1.ship_ele.control:set_play_action_list(var_20_4)
	end

	function arg_1_0.dormitory_rest_idea_stop_galo_radio_inter(arg_21_0, arg_21_1)
		local var_21_0 = {}

		var_21_0[#var_21_0 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_21_1.furniture_ele.data.id,
			config_cid = arg_21_1.furniture_ele.config.cid
		}
		var_21_0[#var_21_0 + 1] = {
			is_active = true,
			type = "set_ship_btn_raycast"
		}
		var_21_0[#var_21_0 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_21_1.furniture_ele.data.id
		}

		arg_21_1.ship_ele.control:set_play_action_list(var_21_0)
	end

	function arg_1_0:dormitory_rest_idea_combination_slide(arg_22_1)
		local var_22_0 = var_0_1()

		var_22_0.x = (arg_22_1.furniture_ele.data.point.x + arg_22_1.furniture_ele.config.width * 0.5 + var_0_5.dormitory_race_car_sit_config[arg_22_1.furniture_ele.config.cid].delta_grid_x) * var_0_5.dormitory_const.room_x_plus
		var_22_0.y = (arg_22_1.furniture_ele.data.point.y + var_0_5.dormitory_race_car_sit_config[arg_22_1.furniture_ele.config.cid].delta_grid_y) * var_0_5.dormitory_const.room_y_plus

		local var_22_1 = {}

		var_22_1[#var_22_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_22_1, arg_22_1.ship_ele.control:get_foot_position(), var_22_0, arg_22_1.furniture_ele)

		local var_22_2 = var_0_1(var_22_0.x, var_22_0.y + 78)

		self:dormitory_idea_manager_move_to_action_pos(var_22_1, var_22_0, var_22_2, arg_22_1.furniture_ele)

		var_22_1[#var_22_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_22_1.furniture_ele.control:get_sort_order() + 1
		}

		local var_22_3 = var_0_1(var_22_2.x + 104, var_22_2.y + 50)

		self:dormitory_idea_manager_move_to_action_pos(var_22_1, var_22_2, var_22_3, arg_22_1.furniture_ele)

		local var_22_4 = var_0_1(var_22_3.x + 205, var_22_3.y)

		self:dormitory_idea_manager_move_to_action_pos(var_22_1, var_22_3, var_22_4, arg_22_1.furniture_ele)

		var_22_1[#var_22_1 + 1] = {
			track_index = 0,
			animation_name = "sit_Janpan",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_22_1, var_22_4, var_0_1(var_22_4.x + 110, var_22_4.y - 72), arg_22_1.furniture_ele)
		self:dormitory_idea_manager_wait_idea(var_22_1, 1)

		var_22_1[#var_22_1 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_22_1[#var_22_1 + 1] = {
			cooling_time = 15,
			type = "stop",
			furniture_id = arg_22_1.furniture_ele.data.id
		}

		arg_22_1.ship_ele.control:set_play_action_list(var_22_1)
	end

	function arg_1_0:dormitory_idea_manager_asura_interactive_update()
		if not self._curr_furniture_tb then
			return
		end

		if not self._ship_members_tb then
			return
		end

		if not self._furniture_interact_tb then
			return
		end

		if self._asura_start_inter then
			for iter_23_0, iter_23_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
				if iter_23_1.is_interactive then
					iter_23_1.speed = var_0_9.Lerp(iter_23_1.speed, iter_23_1.target_speed, 0.01)

					if iter_23_1.speed_up then
						iter_23_1.target_speed = iter_23_1.target_speed + 25

						if iter_23_1.target_speed > iter_23_1.full_speed then
							iter_23_1.speed_up = false
							iter_23_1.target_speed = iter_23_1.full_speed
						end
					end

					local var_23_0 = iter_23_1.car_ele.control:get_spine_position()

					iter_23_1.car_ele.control:set_spine_position(var_23_0 - var_0_1(1, 0) * var_0_6.deltaTime * iter_23_1.speed)

					local var_23_1 = iter_23_1.car_ele.control:get_spine_position() + iter_23_1.ship_delta_pos
					local var_23_2 = iter_23_1.ship_ele.control:get_foot_position()

					if var_23_2.y < iter_23_1.ship_move_const_pos then
						iter_23_1.ship_move_pos = iter_23_1.ship_move_pos + 8
						var_23_2.y = var_0_9.Lerp(var_23_2.y, iter_23_1.ship_move_pos, 0.02)
					end

					var_23_1.x = var_23_1.x - 22

					iter_23_1.ship_ele.control:set_foot_position(var_23_1.x, var_23_2.y)
					self:dormitory_idea_manager_asura_arrive_destination(iter_23_1)

					if var_23_0.x < -50 and iter_23_1.recover_time > 0 then
						iter_23_1.recover_time = iter_23_1.recover_time - var_0_6.deltaTime

						if iter_23_1.recover_time < 1 then
							iter_23_1.car_ele.control:set_spine_position(var_0_1(1553, var_23_0.y))

							iter_23_1.recover_time = iter_23_1.const_time
							iter_23_1.is_begin = false
							iter_23_1.recover_num = iter_23_1.recover_num - 1
						end
					end
				end

				if iter_23_1.is_complete_inter then
					local var_23_3 = iter_23_1.car_ele.control:get_spine_position() + iter_23_1.ship_delta_pos
					local var_23_4 = iter_23_1.ship_ele.control:get_foot_position()

					if var_23_4.y > iter_23_1.ship_move_orgin_pos then
						iter_23_1.ship_move_pos = iter_23_1.ship_move_pos - 29
						var_23_4.y = var_0_9.Lerp(var_23_4.y, iter_23_1.ship_move_pos, 0.02)

						iter_23_1.ship_ele.control:set_foot_position(var_23_3.x, var_23_4.y)
					else
						iter_23_1.is_complete_inter = false
					end
				end
			end
		end

		if self._furniture_interact_tb.asura_car_tb then
			self:__run_time_spine_list()
		end
	end

	function arg_1_0:updata_tree_swing_time()
		if not self._furniture_interact_tb then
			return
		end

		if not self._furniture_interact_tb.tree_swing_car_tb then
			return
		end

		self:update_tree_swing_begin_time()

		for iter_24_0, iter_24_1 in pairs(self._furniture_interact_tb.tree_swing_car_tb) do
			if iter_24_1.is_interactive then
				local var_24_0, var_24_1 = iter_24_1.car_ele.control:get_furniture_bone_position()

				iter_24_1.ship_ele.control:set_foot_position(var_24_0 + iter_24_1.offset_x, var_24_1 + iter_24_1.offset_y)
			end
		end
	end

	function arg_1_0:update_tree_swing_begin_time()
		if not self._furniture_interact_tb then
			return
		end

		for iter_25_0, iter_25_1 in pairs(self._furniture_interact_tb.tree_swing_car_tb) do
			if iter_25_1.is_begin then
				iter_25_1.const_time = iter_25_1.const_time - var_0_6.deltaTime

				if iter_25_1.const_time < 0 then
					iter_25_1.is_interactive = true
					iter_25_1.is_begin = false
					iter_25_1.const_time = 0.8
				end
			end
		end
	end

	function arg_1_0:updata_the_terrace_arcade_time()
		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.the_terrace_arcade_tb then
			for iter_26_0, iter_26_1 in pairs(self._furniture_interact_tb.the_terrace_arcade_tb) do
				if iter_26_1.is_interactive then
					if iter_26_1.total_time > 0 then
						iter_26_1.total_time = iter_26_1.total_time - var_0_6.deltaTime
					else
						for iter_26_2, iter_26_3 in pairs(iter_26_1.driver_list) do
							local var_26_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_26_3)

							var_26_0.control:clear_play_action_list()
							self:dormitory_rest_idea_stop_the_terrace_arcade_inter({
								ship_ele = var_26_0,
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_26_1.car_id)
							})
						end

						self:__reset_furniture_inter_data(iter_26_1.car_id)

						iter_26_1.is_interactive = false
					end
				end
			end
		end
	end

	function arg_1_0:updata_dancing_machine_time()
		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.dancing_machine_tb then
			for iter_27_0, iter_27_1 in pairs(self._furniture_interact_tb.dancing_machine_tb) do
				if iter_27_1.is_interactive then
					if iter_27_1.total_time > 0 then
						iter_27_1.total_time = iter_27_1.total_time - var_0_6.deltaTime
					else
						local var_27_0

						if #iter_27_1.driver_list == 1 then
							var_27_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_27_1.driver_list[1])
						elseif #iter_27_1.driver_list == 2 and iter_27_1.driver_list[1] ~= -1 then
							var_27_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_27_1.driver_list[1])

							var_27_0.control:clear_play_action_list()
							self:dormitory_rest_idea_stop_single_inter({
								ship_ele = var_27_0,
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_27_1.car_id)
							})

							iter_27_1.total_time = 3
							iter_27_1.driver_list[1] = -1
						else
							var_27_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_27_1.driver_list[2])
						end

						if #iter_27_1.driver_list == 1 or iter_27_1.total_time < 0 then
							var_27_0.control:clear_play_action_list()
							self:dormitory_rest_idea_stop_the_terrace_arcade_inter({
								ship_ele = var_27_0,
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_27_1.car_id)
							})
							self:__reset_furniture_dancing_inter_data(self._furniture_interact_tb.dancing_machine_tb, iter_27_1.car_id)

							iter_27_1.is_interactive = false
						end
					end
				end
			end
		end
	end

	function arg_1_0:updata_mini_track_boat_race_time()
		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.mini_track_boat_race_tb then
			for iter_28_0, iter_28_1 in pairs(self._furniture_interact_tb.mini_track_boat_race_tb) do
				if iter_28_1.is_interactive then
					if iter_28_1.total_time > 0 then
						iter_28_1.total_time = iter_28_1.total_time - var_0_6.deltaTime
					elseif #iter_28_1.driver_list == 1 or iter_28_1.total_time <= 0 then
						for iter_28_2, iter_28_3 in pairs(iter_28_1.driver_list) do
							local var_28_1 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_28_3)

							if not var_28_1 then
								return
							end

							var_28_1.control:clear_play_action_list()
							self:dormitory_rest_idea_stop_mini_track_boat_race_inter({
								ship_ele = var_28_1,
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_28_1.car_id)
							})
							self:__reset_furniture_dancing_inter_data(self._furniture_interact_tb.mini_track_boat_race_tb, iter_28_1.car_id)

							iter_28_1.is_interactive = false
						end
					end
				end
			end
		end
	end

	function arg_1_0:updata_duel_disk_time()
		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.duel_disk_tb then
			for iter_29_0, iter_29_1 in pairs(self._furniture_interact_tb.duel_disk_tb) do
				if iter_29_1.is_interactive then
					if iter_29_1.total_time > 0 then
						iter_29_1.total_time = iter_29_1.total_time - var_0_6.deltaTime
					else
						if #iter_29_1.driver_list == 1 then
							self:dormitory_rest_idea_stop_duel_disk_inter({
								ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_29_1.driver_list[1]),
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_29_1.car_id)
							})
						elseif #iter_29_1.driver_list == 2 then
							self:clear_furniture_inter_state(iter_29_1.car_id, "close", true)

							for iter_29_2, iter_29_3 in pairs(iter_29_1.driver_list) do
								self:dormitory_rest_idea_stop_double_ship_inter({
									ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_29_1.driver_list[iter_29_2]),
									furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_29_1.car_id)
								})
							end
						end

						self:__reset_furniture_dancing_inter_data(self._furniture_interact_tb.duel_disk_tb, iter_29_1.car_id)

						iter_29_1.is_interactive = false
					end
				end
			end
		end
	end

	function arg_1_0:updata_galo_radio_time()
		if not self._furniture_interact_tb then
			return
		end

		if self._furniture_interact_tb.galo_radio_tb then
			for iter_30_0, iter_30_1 in pairs(self._furniture_interact_tb.galo_radio_tb) do
				if iter_30_1.is_interactive then
					if iter_30_1.total_time > 0 then
						iter_30_1.total_time = iter_30_1.total_time - var_0_6.deltaTime
					elseif iter_30_1.record_num == 1 then
						local var_30_1 = self:__dormitory_idea_manager_get_ship_ele_by_id((iter_30_1.driver_list[1] == -1 or nil) and (iter_30_1.driver_list[2] or iter_30_1.driver_list[1]))

						var_30_1.control:clear_play_action_list()
						self:dormitory_rest_idea_stop_galo_radio_inter({
							ship_ele = var_30_1,
							furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_30_1.car_id)
						})
						self:__reset_furniture_dancing_inter_data(self._furniture_interact_tb.galo_radio_tb, iter_30_1.car_id)

						iter_30_1.is_interactive = false
						iter_30_1.record_num = 0
						iter_30_1.cur_ship_num = 0
					elseif iter_30_1.record_num == 2 then
						for iter_30_2, iter_30_3 in pairs(iter_30_1.driver_list) do
							local var_30_2 = self:__dormitory_idea_manager_get_ship_ele_by_id(iter_30_1.driver_list[iter_30_2])

							var_30_2.control:clear_play_action_list()
							self:dormitory_rest_idea_stop_galo_radio_inter({
								ship_ele = var_30_2,
								furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_30_1.car_id)
							})
						end

						iter_30_1.is_interactive = false
						iter_30_1.record_num = 0
						iter_30_1.cur_ship_num = 0
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_asura_request_drive_car(arg_31_1, arg_31_2)
		if self._furniture_interact_tb.asura_car_tb then
			if self._furniture_interact_tb.asura_car_tb[arg_31_2] then
				self._furniture_interact_tb.asura_car_tb[arg_31_2].driver_id = arg_31_1
				self._furniture_interact_tb.asura_car_tb[arg_31_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_31_1)
				self._furniture_interact_tb.asura_car_tb[arg_31_2].ship_delta_pos = self._furniture_interact_tb.asura_car_tb[arg_31_2].ship_ele.control:get_foot_position() - self._furniture_interact_tb.asura_car_tb[arg_31_2].car_ele.control:get_spine_position()
				self._furniture_interact_tb.asura_car_tb[arg_31_2].sitted = true
				self._furniture_interact_tb.asura_car_tb[arg_31_2].is_interactive = true
				self._furniture_interact_tb.asura_car_tb[arg_31_2].speed_up = true
				self._furniture_interact_tb.asura_car_tb[arg_31_2].speed = 0
				self._furniture_interact_tb.asura_car_tb[arg_31_2].target_speed = self._furniture_interact_tb.asura_car_tb[arg_31_2].full_speed
				self._furniture_interact_tb.asura_car_tb[arg_31_2].recover_num = var_0_7.pick_random_from_array(self._furniture_interact_tb.asura_car_tb[arg_31_2].circle_array)
			end

			self._asura_start_inter = true

			if self._furniture_interact_tb and self._furniture_interact_tb.asura_car_tb then
				for iter_31_0, iter_31_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
					if iter_31_1.car_id == arg_31_2 then
						iter_31_1.car_ele.control:set_furniture_animation(0, "open", false)
					end
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_request_change_spine(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
		local var_32_0 = {}

		if arg_32_2 == var_0_5.dormitory_special_furniture_id.tree_swing then
			if self._furniture_interact_tb.tree_swing_car_tb then
				var_32_0 = self._furniture_interact_tb.tree_swing_car_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.hit_melon then
			if self._furniture_interact_tb.hit_melon_car_tb then
				var_32_0 = self._furniture_interact_tb.hit_melon_car_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.king_of_combat or arg_32_2 == var_0_5.dormitory_special_furniture_id.best_drift then
			if self._furniture_interact_tb.king_of_combat_car_tb then
				var_32_0 = self._furniture_interact_tb.king_of_combat_car_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.the_terrace_arcade then
			if self._furniture_interact_tb.the_terrace_arcade_tb then
				var_32_0 = self._furniture_interact_tb.the_terrace_arcade_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.dancing_machine then
			if self._furniture_interact_tb.dancing_machine_tb then
				var_32_0 = self._furniture_interact_tb.dancing_machine_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.youth_shoot_machine then
			if self._furniture_interact_tb.youth_shoot_machine_tb then
				var_32_0 = self._furniture_interact_tb.youth_shoot_machine_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.child_machine then
			if self._furniture_interact_tb.child_machine_tb then
				var_32_0 = self._furniture_interact_tb.child_machine_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.swim_ring then
			if self._furniture_interact_tb.swim_ring_tb then
				var_32_0 = self._furniture_interact_tb.swim_ring_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.water_motorcycle then
			if self._furniture_interact_tb.water_motorcycle_tb then
				var_32_0 = self._furniture_interact_tb.water_motorcycle_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
			if self._furniture_interact_tb.mini_track_boat_race_tb then
				var_32_0 = self._furniture_interact_tb.mini_track_boat_race_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.duel_disk then
			if self._furniture_interact_tb.duel_disk_tb then
				var_32_0 = self._furniture_interact_tb.duel_disk_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.galo_radio then
			if self._furniture_interact_tb.galo_radio_tb then
				var_32_0 = self._furniture_interact_tb.galo_radio_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.wheel_chair then
			if self._furniture_interact_tb.wheel_chair_tb then
				var_32_0 = self._furniture_interact_tb.wheel_chair_tb
			end
		elseif arg_32_2 == var_0_5.dormitory_special_furniture_id.galo_giganotus_armor then
			if self._furniture_interact_tb.galo_giganotus_armor_tb then
				var_32_0 = self._furniture_interact_tb.galo_giganotus_armor_tb
			end
		elseif self._furniture_interact_tb.asura_car_tb then
			var_32_0 = self._furniture_interact_tb.asura_car_tb
		end

		for iter_32_0, iter_32_1 in pairs(var_32_0) do
			if iter_32_1.car_id == arg_32_1 then
				if arg_32_3 == "close" then
					iter_32_1.is_complete_inter = true
					iter_32_1.ship_move_pos = 400
				end

				iter_32_1.car_ele.control:set_furniture_animation(0, arg_32_3, arg_32_4)
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_asura_arrive_destination(arg_33_1)
		if not arg_33_1.is_begin and arg_33_1.recover_num <= 0 and var_0_8(arg_33_1.car_spine_original_pos.x - arg_33_1.car_ele.control:get_spine_position().x) < 10 then
			arg_33_1.is_interactive = false
			arg_33_1.is_begin = true

			self:dormitory_idea_manager_stop_asura_inter_car(arg_33_1.car_id, 1)
		end
	end

	function arg_1_0:dormitory_idea_manager_drag_stop(arg_34_1)
		if self._furniture_interact_tb.asura_car_tb then
			for iter_34_0, iter_34_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
				if iter_34_1.driver_id == arg_34_1 then
					iter_34_1.is_interactive = false
					iter_34_1.is_begin = true
					iter_34_1.is_complete_inter = false

					self:dormitory_idea_manager_stop_asura_inter_car(iter_34_1.car_id, 0)
				end
			end
		end

		if self._furniture_interact_tb.hit_melon_car_tb then
			for iter_34_2, iter_34_3 in pairs(self._furniture_interact_tb.hit_melon_car_tb) do
				if iter_34_3.driver_id == arg_34_1 then
					self:clear_ship_inter_state(arg_34_1)
					self:clear_furniture_inter_state(iter_34_3.car_id, "normal2", false)

					iter_34_3.driver_id = -1
				end
			end
		end

		if self._furniture_interact_tb.inter_car_tb then
			for iter_34_4, iter_34_5 in pairs(self._furniture_interact_tb.inter_car_tb) do
				if iter_34_5.driver_list[2] == arg_34_1 then
					iter_34_5.driver_list[2] = nil
					iter_34_5.record_num = iter_34_5.record_num - 1

					self:clear_ship_inter_state(arg_34_1)
				elseif iter_34_5.driver_list[3] == arg_34_1 then
					iter_34_5.driver_list[3] = nil
					iter_34_5.record_num = iter_34_5.record_num - 1

					self:clear_ship_inter_state(arg_34_1)
				end
			end
		end
	end

	function arg_1_0:clear_ship_inter_state(arg_35_1)
		local var_35_0 = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_35_1)

		var_35_0.control:clear_play_action_list()
		var_35_0.control:__reset_move_condition()
	end

	function arg_1_0:clear_furniture_inter_state(arg_36_1, arg_36_2, arg_36_3)
		self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_36_1).control:set_furniture_animation(0, arg_36_2, arg_36_3)
	end

	function arg_1_0:dormitory_idea_manager_stop_asura_inter_car(arg_37_1, arg_37_2)
		local var_37_0

		if not self._asura_start_inter then
			do return end

			var_37_0 = {}
		end

		var_37_0.ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.asura_car_tb[arg_37_1].driver_id)
		var_37_0.furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_37_1)
		var_37_0.delay_time = arg_37_2

		self:dormitory_rest_idea_stop_asura_car(var_37_0)
	end

	function arg_1_0:dormitory_idea_manager_stop_asura_inter(arg_38_1)
		if self._furniture_interact_tb.asura_car_tb[arg_38_1] then
			self._furniture_interact_tb.asura_car_tb[arg_38_1].is_interactive = false
			self._furniture_interact_tb.asura_car_tb[arg_38_1].sitted = false
			self._furniture_interact_tb.asura_car_tb[arg_38_1].driver_id = -1
			self._furniture_interact_tb.asura_car_tb[arg_38_1].speed_up = false
			self._furniture_interact_tb.asura_car_tb[arg_38_1].is_complete_inter = false

			if self._furniture_interact_tb.asura_car_tb[arg_38_1].car_ele then
				self._furniture_interact_tb.asura_car_tb[arg_38_1].car_ele.control:set_furniture_animation(0, "normal", true)
				self._furniture_interact_tb.asura_car_tb[arg_38_1].car_ele.control:set_spine_position(self._furniture_interact_tb.asura_car_tb[arg_38_1].car_spine_original_pos)
			end
		end
	end

	function arg_1_0:__set_asura_driver_position(arg_39_1, arg_39_2)
		if self._furniture_interact_tb.asura_car_tb then
			for iter_39_0, iter_39_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
				if iter_39_1.car_id == arg_39_1 then
					iter_39_1.ship_move_pos = arg_39_2.y + 60
					iter_39_1.ship_move_const_pos = arg_39_2.y + 293
					iter_39_1.ship_move_orgin_pos = arg_39_2.y + 60
				end
			end
		end
	end

	function arg_1_0:reset_asura_inter_state()
		if self._furniture_interact_tb and self._furniture_interact_tb.asura_car_tb then
			for iter_40_0, iter_40_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
				iter_40_1.is_interactive = false
				iter_40_1.sitted = false
				iter_40_1.driver_id = -1
				iter_40_1.speed_up = false

				if iter_40_1.car_ele then
					iter_40_1.car_ele.control:set_furniture_animation(0, "normal", true)
					iter_40_1.car_ele.control:set_spine_position(iter_40_1.car_spine_original_pos)
				end
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_init_ausra_data()
		for iter_41_0, iter_41_1 in ipairs(self._curr_furniture_tb) do
			local var_41_0 = iter_41_1.data.id
			local var_41_1 = iter_41_1.config.cid

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.asura_chariot then
				self._furniture_interact_tb.asura_car_tb = self._furniture_interact_tb.asura_car_tb or {}

				local var_41_2 = {
					speed = 0,
					is_begin = true,
					ship_move_const_pos = 0,
					is_change_pos = false,
					speed_up = false,
					driver_id = -1,
					ship_move_pos = 0,
					ship_move_orgin_pos = 0,
					is_interactive = false,
					is_complete_inter = false,
					sitted = false,
					car_id = var_41_0,
					target_speed = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].full_speed,
					full_speed = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].full_speed,
					circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num,
					recover_time = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].recover_time,
					const_time = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].recover_time,
					car_ele = iter_41_1,
					car_spine_original_pos = iter_41_1.control:get_spine_position(),
					asura_spine_list = {}
				}

				var_41_2.asura_spine_list[#var_41_2.asura_spine_list + 1] = {
					index = 1,
					execute_time = 2,
					execute_func = function()
						if var_41_2 and var_41_2.car_ele.control then
							var_41_2.car_ele.control:set_furniture_animation(0, "normal", true)
						end
					end
				}
				var_41_2.asura_spine_list[#var_41_2.asura_spine_list + 1] = {
					execute_time = 2,
					execute_func = function()
						if var_41_2 and var_41_2.car_ele.control then
							var_41_2.car_ele.control:set_furniture_animation(0, "normal2", false)
						end
					end
				}
				self._furniture_interact_tb.asura_car_tb[var_41_0] = var_41_2
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.tree_swing then
				self._furniture_interact_tb.tree_swing_car_tb = self._furniture_interact_tb.tree_swing_car_tb or {}
				self._furniture_interact_tb.tree_swing_car_tb[var_41_0] = {
					const_time = 0.8,
					is_interactive = false,
					recover_time = 0.3,
					is_begin = false,
					pos_index = 1,
					sitted = false,
					car_id = var_41_0,
					circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.hit_melon then
				self._furniture_interact_tb.hit_melon_car_tb = self._furniture_interact_tb.hit_melon_car_tb or {}
				self._furniture_interact_tb.hit_melon_car_tb[var_41_0] = {
					is_interactive = false,
					driver_id = -1,
					car_id = var_41_0,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.king_of_combat or iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.best_drift then
				local var_41_3

				if not self._furniture_interact_tb.king_of_combat_car_tb then
					self._furniture_interact_tb.king_of_combat_car_tb = {}
					var_41_3 = {
						is_interactive = false,
						car_id = var_41_0
					}
				end

				var_41_3.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_3.car_ele = iter_41_1
				self._furniture_interact_tb.king_of_combat_car_tb[var_41_0] = var_41_3
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.the_terrace_arcade then
				local var_41_4

				if not self._furniture_interact_tb.the_terrace_arcade_tb then
					self._furniture_interact_tb.the_terrace_arcade_tb = {}
					var_41_4 = {
						total_time = 0,
						is_interactive = false,
						cur_ship_num = 0,
						car_id = var_41_0,
						config_cid = var_41_1
					}
				end

				var_41_4.total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].total_inter_num
				var_41_4.driver_list = {}
				var_41_4.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_4.car_ele = iter_41_1
				self._furniture_interact_tb.the_terrace_arcade_tb[var_41_0] = var_41_4
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.dancing_machine then
				local var_41_5

				if not self._furniture_interact_tb.dancing_machine_tb then
					self._furniture_interact_tb.dancing_machine_tb = {}
					var_41_5 = {
						is_interactive = false,
						total_time = 0,
						record_num = 0,
						cur_ship_num = 0,
						car_id = var_41_0,
						config_cid = var_41_1
					}
				end

				var_41_5.total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].total_inter_num
				var_41_5.driver_list = {}
				var_41_5.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_5.car_ele = iter_41_1
				self._furniture_interact_tb.dancing_machine_tb[var_41_0] = var_41_5
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.youth_shoot_machine then
				self._furniture_interact_tb.youth_shoot_machine_tb = self._furniture_interact_tb.youth_shoot_machine_tb or {}
				self._furniture_interact_tb.youth_shoot_machine_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.child_machine then
				self._furniture_interact_tb.child_machine_tb = self._furniture_interact_tb.child_machine_tb or {}
				self._furniture_interact_tb.child_machine_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.single_slide then
				self._furniture_interact_tb.single_slide_tb = self._furniture_interact_tb.single_slide_tb or {}
				self._furniture_interact_tb.single_slide_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.swim_ring then
				self._furniture_interact_tb.swim_ring_tb = self._furniture_interact_tb.swim_ring_tb or {}
				self._furniture_interact_tb.swim_ring_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.water_motorcycle then
				self._furniture_interact_tb.water_motorcycle_tb = self._furniture_interact_tb.water_motorcycle_tb or {}
				self._furniture_interact_tb.water_motorcycle_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
				local var_41_6

				if not self._furniture_interact_tb.mini_track_boat_race_tb then
					self._furniture_interact_tb.mini_track_boat_race_tb = {}
					var_41_6 = {
						is_interactive = false,
						total_time = 0,
						record_num = 0,
						cur_ship_num = 0,
						car_id = var_41_0,
						config_cid = var_41_1
					}
				end

				var_41_6.total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].total_inter_num
				var_41_6.driver_list = {}
				var_41_6.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_6.car_ele = iter_41_1
				self._furniture_interact_tb.mini_track_boat_race_tb[var_41_0] = var_41_6
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.duel_disk then
				local var_41_7

				if not self._furniture_interact_tb.duel_disk_tb then
					self._furniture_interact_tb.duel_disk_tb = {}
					var_41_7 = {
						is_interactive = false,
						total_time = 0,
						record_num = 0,
						cur_ship_num = 0,
						car_id = var_41_0,
						config_cid = var_41_1
					}
				end

				var_41_7.total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].total_inter_num
				var_41_7.driver_list = {}
				var_41_7.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_7.car_ele = iter_41_1
				self._furniture_interact_tb.duel_disk_tb[var_41_0] = var_41_7
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.galo_radio then
				local var_41_8

				if not self._furniture_interact_tb.galo_radio_tb then
					self._furniture_interact_tb.galo_radio_tb = {}
					var_41_8 = {
						is_interactive = false,
						total_time = 0,
						record_num = 0,
						cur_ship_num = 0,
						car_id = var_41_0,
						config_cid = var_41_1
					}
				end

				var_41_8.total_inter_num = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].total_inter_num
				var_41_8.driver_list = {}
				var_41_8.circle_array = var_0_5.dormitory_race_car_sit_config[iter_41_1.config.cid].circle_num
				var_41_8.car_ele = iter_41_1
				self._furniture_interact_tb.galo_radio_tb[var_41_0] = var_41_8
			end

			if iter_41_1.config.cid == var_0_5.dormitory_special_furniture_id.combination_slide then
				self._furniture_interact_tb.combination_slide_tb = self._furniture_interact_tb.combination_slide_tb or {}
				self._furniture_interact_tb.combination_slide_tb[var_41_0] = {
					car_id = var_41_0,
					config_cid = var_41_1,
					car_ele = iter_41_1
				}
			end
		end
	end

	function arg_1_0:dormitory_idea_manager_request_play_tree_swing(arg_44_1, arg_44_2)
		if self._furniture_interact_tb.tree_swing_car_tb then
			if self._furniture_interact_tb.tree_swing_car_tb[arg_44_2] then
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_44_1)
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].ship_delta_pos = self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].ship_ele.control:get_foot_position()
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].sitted = true
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].is_begin = true
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].pos_index = 1
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].offset_x = self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].ship_delta_pos.x - var_0_5.dormitory_const.furniture_bone_x
				self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].offset_y = self._furniture_interact_tb.tree_swing_car_tb[arg_44_2].ship_delta_pos.y - var_0_5.dormitory_const.furniture_bone_y
			end
		end

		self:__reset_ship_raycast(arg_44_1, false)
	end

	function arg_1_0:dormitory_idea_manager_stop_tree_inter(arg_45_1)
		local var_45_0

		if self._furniture_interact_tb.tree_swing_car_tb then
			var_45_0 = self._furniture_interact_tb.tree_swing_car_tb[arg_45_1]
		end

		if var_45_0 then
			var_45_0.is_interactive = false
			var_45_0.sitted = false
		end
	end

	function arg_1_0:dormitory_idea_manager_set_ship_inter_state(arg_46_1, arg_46_2)
		if arg_46_2 == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
			if self._furniture_interact_tb.mini_track_boat_race_tb then
				if self._furniture_interact_tb.mini_track_boat_race_tb[arg_46_1] then
					result = var_0_7.pick_random_from_array(self._furniture_interact_tb.mini_track_boat_race_tb[arg_46_1].circle_array)
					self._furniture_interact_tb.mini_track_boat_race_tb[arg_46_1].total_time = result
					self._furniture_interact_tb.mini_track_boat_race_tb[arg_46_1].is_interactive = true
				end
			end
		elseif arg_46_2 == var_0_5.dormitory_special_furniture_id.duel_disk then
			if self._furniture_interact_tb.duel_disk_tb then
				if self._furniture_interact_tb.duel_disk_tb[arg_46_1] then
					result = var_0_7.pick_random_from_array(self._furniture_interact_tb.duel_disk_tb[arg_46_1].circle_array)
					self._furniture_interact_tb.duel_disk_tb[arg_46_1].total_time = result
					self._furniture_interact_tb.duel_disk_tb[arg_46_1].is_interactive = true
				end
			end
		elseif arg_46_2 == var_0_5.dormitory_special_furniture_id.galo_radio and self._furniture_interact_tb.galo_radio_tb then
			if self._furniture_interact_tb.galo_radio_tb[arg_46_1] then
				result = var_0_7.pick_random_from_array(self._furniture_interact_tb.galo_radio_tb[arg_46_1].circle_array)
				self._furniture_interact_tb.galo_radio_tb[arg_46_1].total_time = result
				self._furniture_interact_tb.galo_radio_tb[arg_46_1].is_interactive = true
			end
		end
	end

	function arg_1_0:__run_time_spine_list()
		for iter_47_0, iter_47_1 in pairs(self._furniture_interact_tb.asura_car_tb) do
			if not iter_47_1.is_interactive then
				self:__execute_time_spine_list(iter_47_1.asura_spine_list)
			end
		end
	end

	function arg_1_0.__execute_time_spine_list(arg_48_0, arg_48_1)
		if arg_48_1[1].execute_time > 0 then
			arg_48_1[1].execute_time = arg_48_1[1].execute_time - var_0_6.deltaTime

			if arg_48_1[1].execute_time <= 0 then
				arg_48_1[1].index = arg_48_1[1].index == 1 and 2 or 1
				arg_48_1[1].execute_time = 2.1

				arg_48_1[arg_48_1[1].index].execute_func()
			end
		end
	end

	function arg_1_0:start_play_melon_inter(arg_49_1)
		for iter_49_0, iter_49_1 in pairs(self._furniture_interact_tb.hit_melon_car_tb) do
			if iter_49_1.car_id == arg_49_1.furniture_ele.data.id and not iter_49_1.is_interactive then
				iter_49_1.driver_id = arg_49_1.ship_ele.data.id

				self:dormitory_rest_idea_play_hit_melon(arg_49_1)

				iter_49_1.is_interactive = true
			end
		end
	end

	function arg_1_0:__dormitory_idea_manager_stop_hit_melon_inter(arg_50_1)
		self:dormitory_rest_idea_stop_play_hit_melon({
			ship_ele = self:__dormitory_idea_manager_get_ship_ele_by_id(self._furniture_interact_tb.hit_melon_car_tb[arg_50_1].driver_id),
			furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(arg_50_1)
		})
	end

	function arg_1_0:__get_random_num_by_combat(arg_51_1, arg_51_2, arg_51_3)
		local var_51_0 = 0

		if arg_51_3 == var_0_5.dormitory_special_furniture_id.king_of_combat or arg_51_3 == var_0_5.dormitory_special_furniture_id.best_drift then
			if self._furniture_interact_tb.king_of_combat_car_tb then
				if self._furniture_interact_tb.king_of_combat_car_tb[arg_51_2] then
					var_51_0 = var_0_7.pick_random_from_array(self._furniture_interact_tb.king_of_combat_car_tb[arg_51_2].circle_array)
				end
			end
		elseif arg_51_3 == var_0_5.dormitory_special_furniture_id.the_terrace_arcade then
			if self._furniture_interact_tb.the_terrace_arcade_tb then
				if self._furniture_interact_tb.the_terrace_arcade_tb[arg_51_2] then
					var_51_0 = var_0_7.pick_random_from_array(self._furniture_interact_tb.the_terrace_arcade_tb[arg_51_2].circle_array)
					self._furniture_interact_tb.the_terrace_arcade_tb[arg_51_2].total_time = var_51_0
					self._furniture_interact_tb.the_terrace_arcade_tb[arg_51_2].is_interactive = true
				end
			end
		elseif arg_51_3 == var_0_5.dormitory_special_furniture_id.dancing_machine and self._furniture_interact_tb.dancing_machine_tb then
			if self._furniture_interact_tb.dancing_machine_tb[arg_51_2] then
				var_51_0 = var_0_7.pick_random_from_array(self._furniture_interact_tb.dancing_machine_tb[arg_51_2].circle_array)
				self._furniture_interact_tb.dancing_machine_tb[arg_51_2].total_time = var_51_0
				self._furniture_interact_tb.dancing_machine_tb[arg_51_2].is_interactive = true
			end
		end

		return var_51_0
	end

	function arg_1_0.__get_drive_drift_car_ship_info(arg_52_0, arg_52_1, arg_52_2)
		local var_52_0 = false
		local var_52_1 = 0

		if arg_52_1 == var_0_5.dormitory_special_furniture_id.best_drift then
			var_52_0 = true
			var_52_1 = 15.5
		elseif arg_52_1 == var_0_5.dormitory_special_furniture_id.the_terrace_arcade and arg_52_2 == 1 then
			var_52_0 = true
		end

		return var_52_0, var_52_1
	end

	function arg_1_0:__get_random_circle_num(arg_53_1, arg_53_2)
		if self._furniture_interact_tb.tree_swing_car_tb then
			if self._furniture_interact_tb.tree_swing_car_tb[arg_53_2] then
				self._furniture_interact_tb.tree_swing_car_tb[arg_53_2].recover_num = var_0_7.pick_random_from_array(self._furniture_interact_tb.tree_swing_car_tb[arg_53_2].circle_array)
			end

			return 0
		end
	end

	function arg_1_0:__reset_ship_raycast(arg_54_1, arg_54_2)
		self:__dormitory_idea_manager_get_ship_ele_by_id(arg_54_1).control:toggle_ship_btn_raycast(arg_54_2)
	end

	function arg_1_0:__record_inter_ship_num(arg_55_1, arg_55_2, arg_55_3)
		if arg_55_3 == var_0_5.dormitory_special_furniture_id.the_terrace_arcade then
			if self._furniture_interact_tb.the_terrace_arcade_tb then
				for iter_55_0, iter_55_1 in pairs(self._furniture_interact_tb.the_terrace_arcade_tb) do
					if iter_55_1.car_id == arg_55_1 and iter_55_1.cur_ship_num < iter_55_1.total_inter_num then
						iter_55_1.cur_ship_num = iter_55_1.cur_ship_num + 1
						iter_55_1.driver_list[iter_55_1.cur_ship_num] = arg_55_2

						if iter_55_1.cur_ship_num <= iter_55_1.total_inter_num - 1 then
							self._furniture_interact_tb[arg_55_1] = false
						end

						return iter_55_1.cur_ship_num
					end
				end
			end
		elseif arg_55_3 == var_0_5.dormitory_special_furniture_id.dancing_machine then
			if self._furniture_interact_tb.dancing_machine_tb then
				for iter_55_2, iter_55_3 in pairs(self._furniture_interact_tb.dancing_machine_tb) do
					if iter_55_3.car_id == arg_55_1 and iter_55_3.record_num < iter_55_3.total_inter_num then
						iter_55_3.cur_ship_num = iter_55_3.cur_ship_num == 0 and var_0_7.pick_random_from_array({
							1,
							2
						}) or iter_55_3.cur_ship_num == 1 and 2 or 1
						iter_55_3.driver_list[#iter_55_3.driver_list + 1] = arg_55_2
						iter_55_3.record_num = iter_55_3.record_num + 1

						if iter_55_3.record_num <= iter_55_3.total_inter_num - 1 then
							self._furniture_interact_tb[arg_55_1] = false
						end

						return iter_55_3.cur_ship_num
					end
				end
			end
		elseif arg_55_3 == var_0_5.dormitory_special_furniture_id.hand_car then
			if self._furniture_interact_tb.inter_car_tb then
				for iter_55_4, iter_55_5 in pairs(self._furniture_interact_tb.inter_car_tb) do
					if iter_55_5.car_id == arg_55_1 and iter_55_5.record_num < iter_55_5.total_inter_num then
						if iter_55_5.record_num == 0 then
							iter_55_5.cur_ship_num = var_0_7.pick_random_from_array({
								1,
								2,
								3
							})
						elseif iter_55_5.record_num == 1 then
							if iter_55_5.driver_list[1] then
								iter_55_5.cur_ship_num = var_0_7.pick_random_from_array({
									2,
									3
								})
							elseif iter_55_5.driver_list[2] then
								iter_55_5.cur_ship_num = var_0_7.pick_random_from_array({
									1,
									3
								})
							elseif iter_55_5.driver_list[3] then
								iter_55_5.cur_ship_num = var_0_7.pick_random_from_array({
									1,
									2
								})
							end
						elseif iter_55_5.record_num == 2 then
							if iter_55_5.driver_list[1] and iter_55_5.driver_list[2] then
								iter_55_5.cur_ship_num = 3
							elseif iter_55_5.driver_list[1] and iter_55_5.driver_list[3] then
								iter_55_5.cur_ship_num = 2
							elseif iter_55_5.driver_list[2] and iter_55_5.driver_list[3] then
								iter_55_5.cur_ship_num = 1
							elseif iter_55_5.driver_list[2] and iter_55_5.driver_list[1] then
								iter_55_5.cur_ship_num = 3
							elseif iter_55_5.driver_list[3] and iter_55_5.driver_list[2] then
								iter_55_5.cur_ship_num = 1
							elseif iter_55_5.driver_list[3] and iter_55_5.driver_list[1] then
								iter_55_5.cur_ship_num = 2
							end
						end

						if iter_55_5.cur_ship_num == 1 then
							iter_55_5.is_have_driver = true
							iter_55_5.sitted = true
						end

						iter_55_5.driver_list[iter_55_5.cur_ship_num] = arg_55_2
						iter_55_5.record_num = iter_55_5.record_num + 1

						if iter_55_5.record_num <= iter_55_5.total_inter_num - 1 then
							self._furniture_interact_tb[arg_55_1] = false
						end

						return iter_55_5.cur_ship_num
					end
				end
			end
		elseif arg_55_3 == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
			return self:__set_curr_inter_random_pos_index(self._furniture_interact_tb.mini_track_boat_race_tb, arg_55_1, arg_55_2)
		elseif arg_55_3 == var_0_5.dormitory_special_furniture_id.duel_disk then
			return self:__set_curr_inter_random_pos_index(self._furniture_interact_tb.duel_disk_tb, arg_55_1, arg_55_2)
		elseif arg_55_3 == var_0_5.dormitory_special_furniture_id.galo_radio then
			return self:__set_curr_inter_random_pos_index(self._furniture_interact_tb.galo_radio_tb, arg_55_1, arg_55_2)
		end
	end

	function arg_1_0:__set_curr_inter_random_pos_index(arg_56_1, arg_56_2, arg_56_3)
		if arg_56_1 then
			for iter_56_0, iter_56_1 in pairs(arg_56_1) do
				if iter_56_1.car_id == arg_56_2 and iter_56_1.record_num < iter_56_1.total_inter_num then
					iter_56_1.cur_ship_num = iter_56_1.cur_ship_num == 0 and var_0_7.pick_random_from_array({
						1,
						2
					}) or iter_56_1.cur_ship_num == 1 and 2 or 1
					iter_56_1.driver_list[#iter_56_1.driver_list + 1] = arg_56_3
					iter_56_1.record_num = iter_56_1.record_num + 1

					if iter_56_1.record_num <= iter_56_1.total_inter_num - 1 then
						self._furniture_interact_tb[arg_56_2] = false
					end

					return iter_56_1.cur_ship_num
				end
			end
		end
	end

	function arg_1_0.__get_sit_is_exist(arg_57_0, arg_57_1)
		local var_57_0 = 0

		for iter_57_0 = 1, 3 do
			if not arg_57_1[iter_57_0] then
				var_57_0 = iter_57_0

				break
			end
		end

		return var_57_0
	end

	function arg_1_0:__reset_furniture_inter_data(arg_58_1)
		if self._furniture_interact_tb.the_terrace_arcade_tb then
			for iter_58_0, iter_58_1 in pairs(self._furniture_interact_tb.the_terrace_arcade_tb) do
				if iter_58_1.car_id == arg_58_1 then
					iter_58_1.cur_ship_num = 0
					iter_58_1.driver_list = {}

					return
				end
			end
		end
	end

	function arg_1_0.__reset_furniture_dancing_inter_data(arg_59_0, arg_59_1, arg_59_2)
		if arg_59_1 then
			for iter_59_0, iter_59_1 in pairs(arg_59_1) do
				if iter_59_1.car_id == arg_59_2 then
					iter_59_1.cur_ship_num = 0
					iter_59_1.record_num = 0
					iter_59_1.driver_list = {}

					return
				end
			end
		end
	end

	function arg_1_0.__get_random_num_by_youth_shoot_machine(arg_60_0, arg_60_1, arg_60_2)
		local var_60_0
		local var_60_1 = 0

		if arg_60_2 == var_0_5.dormitory_special_furniture_id.youth_shoot_machine then
			local var_60_2, var_60_3 = var_0_7.pick_loot_by_weight({
				{
					weight = 30
				},
				{
					weight = 70
				}
			})

			var_60_0 = var_60_3 == 1 and "in" or "out"
			var_60_1 = 3
		else
			local var_60_4, var_60_5 = var_0_7.pick_loot_by_weight({
				{
					weight = 15
				},
				{
					weight = 10
				},
				{
					weight = 25
				},
				{
					weight = 25
				},
				{
					weight = 25
				}
			})

			if var_60_5 == 1 then
				var_0_10:req_DollMachineReq()

				var_60_0 = "in"
				var_60_1 = 15.667
			elseif var_60_5 == 2 then
				var_60_0 = "in2"

				var_0_10:req_DollMachineReq()

				var_60_1 = 23.967
			elseif var_60_5 == 3 then
				var_60_0 = "out1"
				var_60_1 = 15.667
			elseif var_60_5 == 4 then
				var_60_0 = "out2"
				var_60_1 = 15.667
			elseif var_60_5 == 5 then
				var_60_0 = "out3"
				var_60_1 = 15.667
			end
		end

		return var_60_0, var_60_1
	end

	function arg_1_0:update_drag_ship_position(arg_61_1, arg_61_2)
		if self._furniture_interact_tb.single_slide_tb then
			for iter_61_0, iter_61_1 in pairs(self._furniture_interact_tb.single_slide_tb) do
				local var_61_0 = iter_61_1.car_ele.control:get_foot_position()

				if arg_61_1.x > var_61_0.x - 30 and arg_61_1.x < var_61_0.x + 30 and arg_61_1.y < var_61_0.y + 135 then
					local var_61_1 = self:__dormitory_idea_manager_get_ship_ele_by_id(arg_61_2)

					var_61_1.control._fall_downing = false
					var_61_1.control._acting = true

					var_61_1.control:shadow_follow(false)
					var_61_1.control:set_foot_position_without_record(arg_61_1.x, arg_61_1.y)
					self:dormitory_rest_idea_single_slider({
						ship_ele = var_61_1,
						furniture_ele = self:__dormitory_idea_manager_get_furniture_ele_by_id(iter_61_1.car_id)
					})

					return
				end
			end
		end
	end

	function arg_1_0.__get_swim_ring_or_water_motorcycle_spine_name(arg_62_0, arg_62_1)
		return arg_62_1 == var_0_5.dormitory_special_furniture_id.swim_ring and "start" or "open"
	end

	function arg_1_0.__get_swim_ring_or_water_motorcycle_delay_time(arg_63_0)
		return (var_0_7.pick_random_from_array({
			2,
			3
		}))
	end

	function arg_1_0:__get_ship_move_point_list(arg_64_1, arg_64_2, arg_64_3, arg_64_4)
		local var_64_0 = false
		local var_64_1 = var_0_1()
		local var_64_2 = var_0_1()
		local var_64_3 = 0
		local var_64_4 = arg_64_2.control:get_foot_position()

		if arg_64_1.x <= var_64_4.x - arg_64_3.const_pos then
			var_64_3 = self:__record_inter_ship_num(arg_64_2.data.id, arg_64_4.data.id, arg_64_2.config.cid)

			local var_64_5, var_64_6 = self:get_curr_pos_by_index(var_64_3, arg_64_2, arg_64_3)

			var_64_1.x = var_64_5
			var_64_1.y = var_64_6
		elseif arg_64_1.x >= var_64_4.x + arg_64_3.const_pos then
			var_64_3 = self:__record_inter_ship_num(arg_64_2.data.id, arg_64_4.data.id, arg_64_2.config.cid)

			local var_64_7, var_64_8 = self:get_curr_pos_by_index(var_64_3, arg_64_2, arg_64_3)

			var_64_1.x = var_64_7
			var_64_1.y = var_64_8
		elseif arg_64_1.x > var_64_4.x - arg_64_3.const_pos and arg_64_1.x < var_64_4.x + arg_64_3.const_pos and arg_64_1.y >= var_64_4.y or arg_64_1.x > var_64_4.x - arg_64_3.const_pos and arg_64_1.x < var_64_4.x + arg_64_3.const_pos and arg_64_1.y <= var_64_4.y then
			var_64_0 = true
			var_64_3 = self:__record_inter_ship_num(arg_64_2.data.id, arg_64_4.data.id, arg_64_2.config.cid)

			if var_64_3 == 1 then
				var_64_1.x = (arg_64_2.data.point.x + arg_64_2.config.width * 0.5 + arg_64_3.delta_grid_x[3]) * var_0_5.dormitory_const.room_x_plus
				var_64_1.y = arg_64_2.data.point.y * var_0_5.dormitory_const.room_y_plus
				var_64_2.x = (arg_64_2.data.point.x + arg_64_2.config.width * 0.5 + arg_64_3.delta_grid_x[1]) * var_0_5.dormitory_const.room_x_plus
				var_64_2.y = (arg_64_2.data.point.y + arg_64_3.delta_grid_y[1]) * var_0_5.dormitory_const.room_y_plus
			else
				var_64_1.x = (arg_64_2.data.point.x + arg_64_2.config.width * 0.5 + arg_64_3.delta_grid_x[4]) * var_0_5.dormitory_const.room_x_plus
				var_64_1.y = arg_64_2.data.point.y * var_0_5.dormitory_const.room_y_plus
				var_64_2.x = (arg_64_2.data.point.x + arg_64_2.config.width * 0.5 + arg_64_3.delta_grid_x[2]) * var_0_5.dormitory_const.room_x_plus
				var_64_2.y = (arg_64_2.data.point.y + arg_64_3.delta_grid_y[2]) * var_0_5.dormitory_const.room_y_plus
			end
		end

		return var_64_3, var_64_0, var_64_1, var_64_2
	end

	function arg_1_0.get_curr_pos_by_index(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
		local var_65_0 = 0
		local var_65_1 = 0

		if arg_65_1 == 1 then
			var_65_0 = (arg_65_2.data.point.x + arg_65_2.config.width * 0.5 + arg_65_3.delta_grid_x[1]) * var_0_5.dormitory_const.room_x_plus
			var_65_1 = (arg_65_2.data.point.y + arg_65_3.delta_grid_y[1]) * var_0_5.dormitory_const.room_y_plus
		else
			var_65_0 = (arg_65_2.data.point.x + arg_65_2.config.width * 0.5 + arg_65_3.delta_grid_x[2]) * var_0_5.dormitory_const.room_x_plus
			var_65_1 = (arg_65_2.data.point.y + arg_65_3.delta_grid_y[2]) * var_0_5.dormitory_const.room_y_plus
		end

		return var_65_0, var_65_1
	end

	function arg_1_0:__set_mini_track_boat_race_ship_list(arg_66_1, arg_66_2, arg_66_3)
		local var_66_0

		if arg_66_2.config.cid == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
			var_66_0 = self._furniture_interact_tb.mini_track_boat_race_tb
		elseif arg_66_2.config.cid == var_0_5.dormitory_special_furniture_id.duel_disk then
			var_66_0 = self._furniture_interact_tb.duel_disk_tb
		elseif arg_66_2.config.cid == var_0_5.dormitory_special_furniture_id.galo_radio then
			var_66_0 = self._furniture_interact_tb.galo_radio_tb
		end

		if var_66_0 then
			for iter_66_0, iter_66_1 in pairs(var_66_0) do
				if iter_66_1.car_id == arg_66_2.data.id and iter_66_1.record_num < iter_66_1.total_inter_num then
					iter_66_1.cur_ship_num = arg_66_3
					iter_66_1.driver_list[#iter_66_1.driver_list + 1] = arg_66_1
					iter_66_1.record_num = iter_66_1.record_num + 1

					if iter_66_1.record_num <= iter_66_1.total_inter_num - 1 then
						self._furniture_interact_tb[arg_66_2.data.id] = false
					end

					return
				end
			end
		end
	end

	function arg_1_0:__get_inter_record_ship_num(arg_67_1)
		local var_67_0

		if arg_67_1.config.cid == var_0_5.dormitory_special_furniture_id.mini_track_boat_race then
			var_67_0 = self._furniture_interact_tb.mini_track_boat_race_tb
		elseif arg_67_1.config.cid == var_0_5.dormitory_special_furniture_id.duel_disk then
			var_67_0 = self._furniture_interact_tb.duel_disk_tb
		end

		if var_67_0 then
			for iter_67_0, iter_67_1 in pairs(var_67_0) do
				if iter_67_1.car_id == arg_67_1.data.id then
					return iter_67_1.record_num
				end
			end
		end
	end

	function arg_1_0:__get_random_win_loss_state(arg_68_1, arg_68_2)
		for iter_68_0, iter_68_1 in pairs(self._furniture_interact_tb.duel_disk_tb) do
			if iter_68_1.car_id == arg_68_2 and iter_68_1.driver_list[1] == arg_68_1.data.id then
				return true
			end
		end

		return false
	end

	function arg_1_0.get_animation_name_by_ship_cid(arg_69_0, arg_69_1)
		return not (arg_69_1.cid == var_0_5.dormitory_const.veneto_ship_cid and arg_69_1.skin ~= var_0_5.dormitory_const.veneto_ship_skin_cid)
	end

	function arg_1_0.reset_current_furniture_spine(arg_70_0, arg_70_1, arg_70_2)
		if arg_70_1[arg_70_2] then
			arg_70_1[arg_70_2].is_interactive = false
			arg_70_1[arg_70_2].record_num = 0
			arg_70_1[arg_70_2].cur_ship_num = 0

			arg_70_1[arg_70_2].car_ele.control:set_furniture_animation(0, "normal", true)
		end
	end
end

function var_0_0.extend_obj(arg_71_0)
	return
end

return var_0_0
