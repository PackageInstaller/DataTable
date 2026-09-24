local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_5 = gameenum.common_type
local var_0_7 = gamecore.util_func

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_rest_idea_create_sit_down(arg_2_1)
		local var_2_0 = arg_2_1.furniture_ele
		local var_2_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_2_1.furniture_ele)
		local var_2_2

		if not var_2_1 or not next(var_2_1) then
			do return end

			var_2_2 = {}
		end

		local var_2_3 = var_0_1(var_2_1[1].x + 10, var_2_1[1].y)

		var_2_2[#var_2_2 + 1] = {
			type = "set_sort_order",
			sort_order = var_2_0.control:get_sort_order() + 1
		}
		var_2_2[#var_2_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_2, arg_2_1.ship_ele.control:get_foot_position(), var_2_3, var_2_0)

		var_2_2[#var_2_2 + 1] = {
			type = "flip_x",
			flip = var_2_0.data.rotate
		}

		local var_2_4
		local var_2_5 = var_0_7.pick_random_from_array({
			"sit",
			"sit1",
			"sit2"
		})
		local var_2_6 = var_0_7.pick_random_from_array({
			"event_sit_UP",
			"event_sit_UP2"
		})

		if arg_2_1.furniture_ele.data.cid == 10029371 and arg_2_1.ship_ele.data.name == "逸仙" then
			var_2_4 = "event_sit_spchair"
			var_2_6 = "event_sit_spchair_UP"
			var_2_5 = "sit_spchair"
		end

		if var_2_4 then
			var_2_2[#var_2_2 + 1] = {
				track_index = 0,
				loop = false,
				type = "set_animation",
				animation_name = var_2_4
			}

			self:dormitory_idea_manager_wait_idea(var_2_2, 1)
		end

		local var_2_7 = var_2_6 == "event_sit_UP" and 1.333 or 2

		var_2_2[#var_2_2 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_2_5
		}

		self:dormitory_idea_manager_wait_idea(var_2_2, 4 * lan_rand(var_0_5.furntiure_const.loop_num1, var_0_5.furntiure_const.loop_num2))

		var_2_2[#var_2_2 + 1] = {
			loop = false,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = var_2_6,
			furniture_ele = var_2_0
		}

		self:dormitory_idea_manager_wait_idea(var_2_2, var_2_7)

		var_2_2[#var_2_2 + 1] = {
			loop = false,
			expression_name = "event_silent",
			duration = 0.667,
			type = "set_expression"
		}
		var_2_2[#var_2_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_2_2[#var_2_2 + 1] = {
			type = "stop",
			furniture_id = var_2_0.data.id
		}

		arg_2_1.ship_ele.control:set_play_action_list(var_2_2)
		arg_2_1.ship_ele.control:set_inter_furniture_element(var_2_0)
	end

	function arg_1_0:dormitory_rest_idea_create_lay_swim_ring(arg_3_1)
		local var_3_0 = self:dormitory_idea_manager_get_furniture_action_pos(arg_3_1.furniture_ele)

		if not var_3_0 or not next(var_3_0) then
			return
		end

		local var_3_1 = var_3_0[1]
		local var_3_2 = {}

		var_3_2[#var_3_2 + 1] = {
			type = "set_sort_order",
			sort_order = arg_3_1.furniture_ele.control:get_sort_order() + 1
		}
		var_3_2[#var_3_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_3_2, arg_3_1.ship_ele.control:get_foot_position(), var_3_1, arg_3_1.furniture_ele)

		var_3_2[#var_3_2 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_3_2[#var_3_2 + 1] = {
			type = "reset_water_ripple"
		}
		var_3_2[#var_3_2 + 1] = {
			track_index = 0,
			animation_name = "event_lay_L",
			loop = false,
			type = "set_animation"
		}
		var_3_2[#var_3_2 + 1] = {
			spine_state = true,
			type = "request_change_spine",
			furniture_id = arg_3_1.furniture_ele.data.id,
			config_cid = arg_3_1.furniture_ele.config.cid,
			spine_name = self:__get_swim_ring_or_water_motorcycle_spine_name(arg_3_1.furniture_ele.config.cid)
		}

		self:dormitory_idea_manager_wait_idea(var_3_2, self:__get_swim_ring_or_water_motorcycle_delay_time() * 2)

		var_3_2[#var_3_2 + 1] = {
			loop = true,
			delay = 1,
			type = "add_animation",
			track_index = 0,
			animation_name = "lay_L"
		}

		self:dormitory_idea_manager_wait_idea(var_3_2, 5)

		var_3_2[#var_3_2 + 1] = {
			loop = false,
			type = "add_animation",
			track_index = 0,
			animation_name = "lay_UP_L",
			delay = 5 + 1
		}

		self:dormitory_idea_manager_wait_idea(var_3_2, 2.5)

		var_3_2[#var_3_2 + 1] = {
			spine_state = true,
			spine_name = "normal",
			type = "request_change_spine",
			furniture_id = arg_3_1.furniture_ele.data.id,
			config_cid = arg_3_1.furniture_ele.config.cid
		}
		var_3_2[#var_3_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_3_2[#var_3_2 + 1] = {
			type = "stop",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		arg_3_1.ship_ele.control:set_play_action_list(var_3_2)
		arg_3_1.ship_ele.control:set_inter_furniture_element(arg_3_1.furniture_ele)
	end

	function arg_1_0:dormitory_rest_idea_create_play_water_slides(arg_4_1)
		local var_4_0 = arg_4_1.furniture_ele
		local var_4_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_4_1.furniture_ele)

		if not var_4_1 or not next(var_4_1) then
			return
		end

		local var_4_2 = var_4_1[1]
		local var_4_3 = {}

		var_4_3[#var_4_3 + 1] = {
			type = "set_sort_order",
			sort_order = var_4_0.control:get_sort_order() + 1
		}
		var_4_3[#var_4_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_3, arg_4_1.ship_ele.control:get_foot_position(), var_4_2, var_4_0)

		var_4_3[#var_4_3 + 1] = {
			flip = false,
			type = "flip_x"
		}

		local var_4_4 = var_0_1()

		var_4_4.x = (var_4_0.data.point.x + 10) * var_0_5.dormitory_const.room_x_plus
		var_4_4.y = (var_4_0.data.point.y + 18) * var_0_5.dormitory_const.room_y_plus

		self:dormitory_idea_manager_move_to_action_pos(var_4_3, var_4_2, var_4_4, var_4_0)

		local var_4_5 = var_0_1()
		local var_4_6 = var_0_7.pick_random_from_array({
			9,
			6.3,
			3.6
		})

		var_4_5.x = (var_4_0.data.point.x + var_4_6) * var_0_5.dormitory_const.room_x_plus
		var_4_5.y = (var_4_0.data.point.y + 18) * var_0_5.dormitory_const.room_y_plus

		self:dormitory_idea_manager_move_to_action_pos(var_4_3, var_4_4, var_4_5, var_4_0)

		var_4_3[#var_4_3 + 1] = {
			track_index = 0,
			animation_name = "event_sit_Japan",
			loop = false,
			type = "set_animation"
		}
		var_4_3[#var_4_3 + 1] = {
			loop = true,
			delay = 1,
			type = "add_animation",
			track_index = 0,
			animation_name = "sit_Janpan"
		}
		var_4_3[#var_4_3 + 1] = {
			type = "set_sort_order",
			sort_order = var_4_0.control:get_sort_order() + 3
		}

		self:dormitory_idea_manager_wait_idea(var_4_3, 1.5)

		local var_4_7 = var_0_1()
		local var_4_8 = 0

		if var_4_6 == 9 then
			var_4_8 = 0.5
		elseif var_4_6 == 3.6 then
			var_4_8 = -0.5
		end

		var_4_7.x = (var_4_0.data.point.x + var_4_6 + var_4_8) * var_0_5.dormitory_const.room_x_plus
		var_4_7.y = var_4_0.data.point.y * var_0_5.dormitory_const.room_y_plus

		self:dormitory_idea_manager_move_to_action_pos(var_4_3, var_4_5, var_4_7, var_4_0, 1.3, true)
		self:dormitory_idea_manager_wait_idea(var_4_3, 0.5)

		var_4_3[#var_4_3 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_0_7.pick_random_from_array({
				"event_sit_Janpan_UP",
				"event_sit_Janpan_UP2"
			})
		}
		var_4_3[#var_4_3 + 1] = {
			loop = true,
			delay = 0.667,
			type = "add_animation",
			track_index = 0,
			animation_name = "stand1"
		}

		self:dormitory_idea_manager_wait_idea(var_4_3, 1)

		var_4_3[#var_4_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_4_3[#var_4_3 + 1] = {
			type = "stop",
			furniture_id = var_4_0.data.id
		}

		arg_4_1.ship_ele.control:set_play_action_list(var_4_3)
	end

	function arg_1_0:dormitory_rest_idea_create_play_drive_car(arg_5_1)
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
			type = "start_car",
			car_ele = arg_5_1.furniture_ele
		}

		self:dormitory_idea_manager_wait_idea(var_5_1, 1)

		var_5_1[#var_5_1 + 1] = {
			type = "request_drive_car",
			ship_id = arg_5_1.ship_ele.data.id,
			furniture_id = arg_5_1.furniture_ele.data.id
		}

		arg_5_1.ship_ele.control:set_play_action_list(var_5_1)
	end

	function arg_1_0:dormitory_rest_idea_create_knock_fly(arg_6_1)
		local var_6_0 = arg_6_1.ship_ele.control:get_foot_position()
		local var_6_1 = var_0_1()

		var_6_1.x = var_6_0.x - 100

		if var_6_1.x < 0 then
			var_6_1.x = 0
		end

		var_6_1.y = var_0_5.dormitory_const.room_bg_wall_y + 300

		local var_6_2 = var_0_1()

		var_6_2.x = var_6_0.x - 150

		if var_6_2.x < 0 then
			var_6_2.x = 0
		end

		var_6_2.y = var_0_5.dormitory_const.room_bg_wall_y

		local var_6_3 = {}

		var_6_3[#var_6_3 + 1] = {
			flip = false,
			type = "flip_x"
		}

		arg_6_1.ship_ele.control:toggle_ship_collider(false)

		var_6_3[#var_6_3 + 1] = {
			track_index = 0,
			animation_name = "walk_SP",
			loop = false,
			type = "set_animation"
		}
		var_6_3[#var_6_3 + 1] = {
			loop = true,
			delay = 0.667,
			type = "add_animation",
			track_index = 0,
			animation_name = "prostrate"
		}
		var_6_3[#var_6_3 + 1] = {
			loop = true,
			expression_name = "X",
			duration = 1.1,
			type = "set_expression"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_6_3, var_6_0, var_6_1, arg_6_1.furniture_ele, 0.1, true)
		self:dormitory_idea_manager_move_to_action_pos(var_6_3, var_6_1, var_6_2, arg_6_1.furniture_ele, 0.2, true)
		self:dormitory_idea_manager_wait_idea(var_6_3, 1)

		var_6_3[#var_6_3 + 1] = {
			track_index = 0,
			animation_name = "event_sit_UP_SP",
			loop = false,
			type = "set_animation"
		}
		var_6_3[#var_6_3 + 1] = {
			loop = true,
			delay = 1.333,
			type = "add_animation",
			track_index = 0,
			animation_name = "stand1"
		}

		self:dormitory_idea_manager_wait_idea(var_6_3, 2)

		var_6_3[#var_6_3 + 1] = {
			loop = true,
			expression_name = "black_line",
			duration = 1.1,
			type = "set_expression"
		}
		var_6_3[#var_6_3 + 1] = {
			track_index = 0,
			animation_name = "SP_black",
			loop = false,
			type = "set_animation"
		}
		var_6_3[#var_6_3 + 1] = {
			loop = true,
			delay = 2.667,
			type = "add_animation",
			track_index = 0,
			animation_name = "stand1"
		}

		self:dormitory_idea_manager_wait_idea(var_6_3, 5)

		var_6_3[#var_6_3 + 1] = {
			type = "reset_ship_collider_state",
			ship_id = arg_6_1.ship_ele.data.id
		}
		var_6_3[#var_6_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_6_3[#var_6_3 + 1] = {
			type = "stop"
		}

		arg_6_1.ship_ele.control:set_play_action_list(var_6_3)
		arg_6_1.ship_ele.control:set_inter_furniture_element(arg_6_1.furniture_ele)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
