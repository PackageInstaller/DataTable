local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_4 = math.abs
local var_0_6 = gameenum.common_type
local var_0_8 = gamecore.util_func
local var_0_9 = gameconfig.skin_config
local var_0_10 = lan_rand
local var_0_11 = DG.Tweening.DOTween
local var_0_12 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_play_idea_create_play_djbox(arg_2_1)
		local var_2_0 = {}

		if not self:__check_ship_for_dibox(arg_2_1.ship_ele) then
			var_2_0[#var_2_0 + 1] = {
				type = "stop",
				furniture_id = arg_2_1.furniture_ele.data.id
			}

			arg_2_1.ship_ele.control:set_play_action_list(var_2_0)

			return
		end

		local var_2_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_2_1.furniture_ele)

		if not var_2_1 or not next(var_2_1) then
			return
		end

		local var_2_2 = var_2_1[1]

		var_2_0[#var_2_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_2_1.furniture_ele.control:get_sort_order() - 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_0, arg_2_1.ship_ele.control:get_foot_position(), var_2_2, arg_2_1.furniture_ele)

		local var_2_3 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)

		var_2_0[#var_2_0 + 1] = {
			type = "request_play_djbox",
			furniture_ele = arg_2_1.furniture_ele,
			delay = var_2_3 * 2
		}
		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "SP_dj",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, 0.667 + var_2_3 * 2)

		var_2_0[#var_2_0 + 1] = {
			type = "stop",
			furniture_id = arg_2_1.furniture_ele.data.id
		}

		arg_2_1.ship_ele.control:set_play_action_list(var_2_0)
		arg_2_1.ship_ele.control:set_inter_furniture_element(arg_2_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_play_skateboard(arg_3_1)
		local var_3_0 = {}

		if not self:__check_ship_for_skateboard(arg_3_1.ship_ele) then
			var_3_0[#var_3_0 + 1] = {
				type = "stop",
				furniture_id = arg_3_1.furniture_ele.data.id
			}

			arg_3_1.ship_ele.control:set_play_action_list(var_3_0)

			return
		end

		local var_3_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_3_1.furniture_ele)

		if not var_3_1 or not next(var_3_1) then
			return
		end

		self:dormitory_idea_manager_move_to_action_pos(var_3_0, arg_3_1.ship_ele.control:get_foot_position(), var_3_1[1], arg_3_1.furniture_ele)

		var_3_0[#var_3_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_3_0[#var_3_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_3_1.furniture_ele.control:get_sort_order() + 1
		}

		local var_3_2 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2) * 5.667

		var_3_0[#var_3_0 + 1] = {
			type = "request_play_skateboard",
			furniture_ele = arg_3_1.furniture_ele,
			delay = var_3_2
		}
		var_3_0[#var_3_0 + 1] = {
			track_index = 0,
			animation_name = "SP_ball",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_3_0, var_3_2)

		var_3_0[#var_3_0 + 1] = {
			type = "stop",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		arg_3_1.ship_ele.control:set_play_action_list(var_3_0)
	end

	function arg_1_0:dormitory_play_idea_create_drive_harvester(arg_4_1)
		local var_4_0 = {}
		local var_4_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_4_1.furniture_ele)

		if not var_4_1 or not next(var_4_1) then
			return
		end

		local var_4_2 = var_4_1[1]

		var_4_0[#var_4_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_4_1.furniture_ele.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_0, arg_4_1.ship_ele.control:get_foot_position(), var_4_2, arg_4_1.furniture_ele)

		var_4_0[#var_4_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_4_0[#var_4_0 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(20, -50)
		}

		local var_4_3 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2) * 2

		var_4_0[#var_4_0 + 1] = {
			type = "request_drive_harvester",
			furniture_ele = arg_4_1.furniture_ele,
			delay = var_4_3
		}
		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			animation_name = "sit",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_4_0, var_4_3)

		var_4_0[#var_4_0 + 1] = {
			type = "stop",
			furniture_id = arg_4_1.furniture_ele.data.id
		}

		arg_4_1.ship_ele.control:set_play_action_list(var_4_0)
		arg_4_1.ship_ele.control:set_inter_furniture_element(arg_4_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_sit_veneto(arg_5_1)
		local var_5_0 = arg_5_1.furniture_ele
		local var_5_1 = {}

		if not self:__check_ship_for_veneto(arg_5_1.ship_ele) then
			var_5_1[#var_5_1 + 1] = {
				type = "stop",
				furniture_id = var_5_0.data.id
			}

			arg_5_1.ship_ele.control:set_play_action_list(var_5_1)

			return
		end

		local var_5_2 = self:dormitory_idea_manager_get_furniture_action_pos(var_5_0)

		if not var_5_2 or not next(var_5_2) then
			return
		end

		local var_5_3 = var_5_2[1]
		local var_5_4 = arg_5_1.ship_ele.control:get_foot_position()
		local var_5_5 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)
		local var_5_6 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)

		var_5_5 = var_5_6 <= var_5_5 and var_5_5 or var_5_6

		local var_5_7 = var_0_1(var_5_3.x, var_5_3.y + 40)

		var_5_1[#var_5_1 + 1] = {
			type = "request_sit_veneto",
			furniture_ele = var_5_0,
			loop_count1 = var_5_5,
			loop_count2 = var_5_6
		}
		var_5_1[#var_5_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_5_0.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_5_1, var_5_4, var_5_2[2], var_5_0)
		self:dormitory_idea_manager_move_to_action_pos(var_5_1, var_5_2[2], var_5_7, var_5_0)

		var_5_1[#var_5_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_5_1[#var_5_1 + 1] = {
			track_index = 0,
			animation_name = "sit",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_5_1, var_5_5 + 4 + (5.4 - var_0_1.Distance(var_5_7, var_5_4) / 30) - 0.5)

		var_5_1[#var_5_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_5_1, var_5_7, var_0_1(var_5_7.x, var_5_7.y - 40), var_5_0)

		var_5_1[#var_5_1 + 1] = {
			type = "stop",
			furniture_id = var_5_0.data.id
		}

		arg_5_1.ship_ele.control:set_play_action_list(var_5_1)
		arg_5_1.ship_ele.control:set_inter_furniture_element(var_5_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_magic_wand(arg_6_1)
		local var_6_0 = {}
		local var_6_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_6_1.furniture_ele)

		if not var_6_1 or not next(var_6_1) then
			return
		end

		local var_6_2 = var_0_1(var_6_1[1].x, var_6_1[1].y)

		var_6_0[#var_6_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_6_1.furniture_ele.control:get_sort_order() - 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_6_0, arg_6_1.ship_ele.control:get_foot_position(), var_6_2, arg_6_1.furniture_ele)

		var_6_0[#var_6_0 + 1] = {
			flip = false,
			type = "flip_x"
		}

		local var_6_3 = var_0_10(1, 2)

		var_6_0[#var_6_0 + 1] = {
			type = "request_play_magic_wand",
			furniture_ele = arg_6_1.furniture_ele,
			delay = 2.333 * var_6_3
		}
		var_6_0[#var_6_0 + 1] = {
			loop = false,
			expression_name = "love",
			duration = 0.667,
			type = "set_expression"
		}
		var_6_0[#var_6_0 + 1] = {
			track_index = 0,
			animation_name = "hello",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_6_0, 4)

		var_6_0[#var_6_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_6_0, 2.333 * var_6_3)

		var_6_0[#var_6_0 + 1] = {
			type = "stop",
			furniture_id = arg_6_1.furniture_ele.data.id
		}

		arg_6_1.ship_ele.control:set_play_action_list(var_6_0)
		arg_6_1.ship_ele.control:set_inter_furniture_element(arg_6_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_play_ugly_wall_enter(arg_7_1)
		local var_7_0 = {}
		local var_7_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_7_1.furniture_ele)

		if not var_7_1 or not next(var_7_1) then
			return
		end

		self:dormitory_idea_manager_move_to_action_pos(var_7_0, arg_7_1.ship_ele.control:get_foot_position(), var_7_1[1], arg_7_1.furniture_ele)

		var_7_0[#var_7_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_7_1.furniture_ele.control:get_sort_order() - 1
		}

		local var_7_2 = arg_7_1.ship_ele.control:get_foot_position()

		self:dormitory_idea_manager_move_to_action_pos(var_7_0, var_7_1[1], var_0_1(var_7_1[1].x, var_7_1[1].y + 30), arg_7_1.furniture_ele)

		var_7_0[#var_7_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_7_0[#var_7_0 + 1] = {
			sort_order = 0,
			type = "set_sort_order"
		}

		arg_7_1.ship_ele.control:set_play_action_list(var_7_0)
		arg_7_1.ship_ele.control:set_inter_furniture_element(arg_7_1.furniture_ele)

		arg_7_1.furniture_ele.control._control._param = arg_7_1
	end

	function arg_1_0:dormitory_play_idea_create_play_ugly_wall_out(arg_8_1)
		local var_8_0 = arg_8_1.furniture_ele
		local var_8_1 = {}
		local var_8_2 = 50
		local var_8_3 = arg_8_1.ship_ele.control:get_foot_position()
		local var_8_4 = var_8_3.y - 50

		var_8_2 = 50 <= var_8_3.y and var_8_2 or var_8_3.y

		if var_8_4 <= 0 then
			var_8_4 = 0
		end

		var_8_1[#var_8_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_8_0.control:get_sort_order() + 1
		}
		var_8_1[#var_8_1 + 1] = {
			type = "set_ship_pos",
			diff_num = var_0_1(0, -var_8_2)
		}
		var_8_1[#var_8_1 + 1] = {
			track_index = 0,
			animation_name = "event_lift_SQ_put_down",
			loop = false,
			type = "set_animation"
		}
		var_8_1[#var_8_1 + 1] = {
			loop = false,
			expression_name = "X",
			duration = 1,
			type = "set_expression"
		}

		self:dormitory_idea_manager_wait_idea(var_8_1, 1)

		var_8_1[#var_8_1 + 1] = {
			type = "set_now_ship_pos",
			pos_x = var_8_3.x,
			pos_y = var_8_4
		}
		var_8_1[#var_8_1 + 1] = {
			type = "stop",
			furniture_id = var_8_0.data.id
		}

		arg_8_1.ship_ele.control:set_play_action_list(var_8_1)
		arg_8_1.ship_ele.control:set_inter_furniture_element(var_8_0)

		var_8_0.control._control._param = nil
	end

	function arg_1_0:dormitory_play_idea_create_play_hat(arg_9_1)
		local var_9_0 = {}
		local var_9_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_9_1.furniture_ele)

		if not var_9_1 or not next(var_9_1) then
			return
		end

		local var_9_2 = var_9_1[1]

		var_9_0[#var_9_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_9_1.furniture_ele.control:get_sort_order() - 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_9_0, arg_9_1.ship_ele.control:get_foot_position(), var_9_2, arg_9_1.furniture_ele)

		var_9_0[#var_9_0 + 1] = {
			type = "request_play_hat",
			furniture_ele = arg_9_1.furniture_ele,
			ship_ele = arg_9_1.ship_ele
		}
		var_9_0[#var_9_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_9_0, 7.667)

		var_9_0[#var_9_0 + 1] = {
			type = "stop",
			furniture_id = arg_9_1.furniture_ele.data.id
		}

		arg_9_1.ship_ele.control:set_play_action_list(var_9_0)
		arg_9_1.ship_ele.control:set_inter_furniture_element(arg_9_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_play_desktop_game_enter(arg_10_1, arg_10_2)
		local var_10_0 = arg_10_1.furniture_ele
		local var_10_1 = {}
		local var_10_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_10_1.furniture_ele)

		if not var_10_2 or not next(var_10_2) then
			return
		end

		local var_10_4
		local var_10_5 = arg_10_1.ship_ele.control:get_foot_position()
		local var_10_6 = var_10_0.control:get_foot_position()
		local var_10_7
		local var_10_8 = var_0_1(var_0_4(var_10_2[1].x), var_10_2[1].y + var_10_0.config.height / 2 * var_0_6.dormitory_const.room_y_plus)

		if not var_10_0.param_data then
			var_10_0.param_data = {}
			var_10_0.ready_ship = {}

			self:dormitory_idea_manager_request_toggle_action(arg_10_2, false)
		elseif var_0_8.dict_lenght(var_10_0.param_data) == 0 then
			self:dormitory_idea_manager_request_toggle_action(arg_10_2, false)
		end

		local var_10_9 = (var_10_0.config.width + 1) * var_0_6.dormitory_const.room_x_plus / 2
		local var_10_10

		if next(var_10_0.param_data) then
			if var_10_0.param_data[1] ~= nil then
				var_10_0.param_data[2] = arg_10_1
				var_10_4 = 2
				var_10_7 = var_0_1(var_10_6.x + var_10_9, var_10_6.y)
				var_10_10 = false
			else
				var_10_0.param_data[1] = arg_10_1
				var_10_4 = 1
				var_10_7 = var_0_1(var_10_6.x - var_10_9, var_10_6.y)
				var_10_10 = true
			end
		elseif var_10_5.x <= var_10_6.x then
			var_10_0.param_data[1] = arg_10_1
			var_10_4 = 1
			var_10_7 = var_0_1(var_10_6.x - var_10_9, var_10_6.y)
			var_10_10 = true
		else
			var_10_0.param_data[2] = arg_10_1
			var_10_4 = 2
			var_10_7 = var_0_1(var_10_6.x + var_10_9, var_10_6.y)
			var_10_10 = false
		end

		var_10_0.random = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)
		var_10_0.win = var_0_10(1, 2)
		var_10_1[#var_10_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_10_0.control:get_sort_order() - 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_10_1, var_10_5, var_10_7, var_10_0)

		var_10_1[#var_10_1 + 1] = {
			type = "flip_x",
			flip = var_10_10
		}
		var_10_1[#var_10_1 + 1] = {
			type = "set_ready_ship",
			furniture_ele = var_10_0,
			index = var_10_4,
			ship_ele = arg_10_1.ship_ele
		}
		var_10_1[#var_10_1 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_10_1[#var_10_1 + 1] = {
			type = "request_play_desktop_game",
			furniture_ele = var_10_0
		}

		self:dormitory_idea_manager_wait_idea(var_10_1, (var_0_10(var_0_6.furntiure_const.loop_num3, var_0_6.furntiure_const.loop_num4)))

		var_10_1[#var_10_1 + 1] = {
			type = "reset_data",
			furniture_ele = var_10_0,
			ship_ele = arg_10_1.ship_ele
		}
		var_10_1[#var_10_1 + 1] = {
			type = "stop",
			furniture_id = var_10_0.data.id
		}

		arg_10_1.ship_ele.control:set_play_action_list(var_10_1)
	end

	function arg_1_0:dormitory_play_idea_create_play_desktop_game_on(arg_11_1, arg_11_2)
		for iter_11_0, iter_11_1 in ipairs(arg_11_1.param_data) do
			local var_11_0 = iter_11_1.ship_ele
			local var_11_1 = {}

			var_11_1[#var_11_1 + 1] = {
				type = "flip_x",
				flip = iter_11_0 == 1
			}
			var_11_1[#var_11_1 + 1] = {
				track_index = 0,
				animation_name = "SP2_battle",
				loop = true,
				type = "set_animation"
			}

			self:dormitory_idea_manager_wait_idea(var_11_1, arg_11_2)

			var_11_1[#var_11_1 + 1] = {
				track_index = 0,
				animation_name = "stand1",
				loop = true,
				type = "set_animation"
			}

			self:dormitory_idea_manager_wait_idea(var_11_1, 3)
			var_11_0.control:set_play_action_list(var_11_1)
		end
	end

	function arg_1_0.dormitory_play_idea_create_play_desktop_game_end(arg_12_0, arg_12_1)
		for iter_12_0, iter_12_1 in ipairs(arg_12_1.param_data) do
			local var_12_0 = {}

			var_12_0[#var_12_0 + 1] = {
				loop = false,
				type = "set_expression",
				expression_name = iter_12_0 == 1 and (arg_12_1.win == 1 and "good_idea" or "event_black_line") or arg_12_1.win == 1 and "event_black_line" or "good_idea",
				duration = (iter_12_0 == 1 and (arg_12_1.win == 1 and "good_idea" or "event_black_line") or arg_12_1.win == 1 and "event_black_line" or "good_idea") == "good_idea" and 0.667 or 2
			}
			var_12_0[#var_12_0 + 1] = {
				type = "stop",
				furniture_id = arg_12_1.data.id
			}

			iter_12_1.ship_ele.control:set_play_action_list(var_12_0)
		end

		arg_12_1.param_data = nil
	end

	function arg_1_0:dormitory_play_idea_create_play_tennis_enter(arg_13_1, arg_13_2)
		local var_13_0 = arg_13_1.furniture_ele
		local var_13_1 = {}
		local var_13_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_13_1.furniture_ele)

		if not var_13_2 or not next(var_13_2) then
			return
		end

		local var_13_4 = arg_13_1.ship_ele.control:get_foot_position()
		local var_13_5
		local var_13_6 = var_0_1(var_0_4(var_13_2[1].x), var_13_2[1].y + var_13_0.config.height / 2 * var_0_6.dormitory_const.room_y_plus)

		if not var_13_0.control.param_data then
			var_13_0.control.param_data = {}

			self:dormitory_idea_manager_request_toggle_action(arg_13_2, false)
		end

		local var_13_7

		if var_13_0.control.param_data and next(var_13_0.control.param_data) then
			if var_13_0.control.param_data[1] ~= nil then
				var_13_0.control.param_data[2] = arg_13_1
				var_13_5 = var_0_1(var_13_6.x, var_13_6.y)
				var_13_7 = false
			else
				var_13_0.control.param_data[1] = arg_13_1
				var_13_5 = var_0_1(var_13_6.x - var_13_0.config.width * var_0_6.dormitory_const.room_x_plus, var_13_6.y)
				var_13_7 = true
			end
		elseif var_13_4.x <= var_13_0.control:get_foot_position().x then
			var_13_0.control.param_data[1] = arg_13_1
			var_13_5 = var_0_1(var_13_6.x - var_13_0.config.width * var_0_6.dormitory_const.room_x_plus, var_13_6.y)
			var_13_7 = true
		else
			var_13_0.control.param_data[2] = arg_13_1
			var_13_5 = var_0_1(var_13_6.x, var_13_6.y)
			var_13_7 = false
		end

		var_13_1[#var_13_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_13_0.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_13_1, var_13_4, var_13_5, var_13_0)

		var_13_1[#var_13_1 + 1] = {
			type = "flip_x",
			flip = var_13_7
		}
		var_13_1[#var_13_1 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_13_1[#var_13_1 + 1] = {
			type = "request_play_tennis",
			furniture_ele = var_13_0
		}

		arg_13_1.ship_ele.control:set_play_action_list(var_13_1)
	end

	function arg_1_0:dormitory_play_idea_create_play_tennis_end(arg_14_1, arg_14_2)
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_0 = iter_14_1.ship_ele
			local var_14_1 = iter_14_1.furniture_ele
			local var_14_2 = {}
			local var_14_3
			local var_14_7

			if iter_14_0 == 1 then
				if arg_14_2 == 1 then
					var_14_3 = "good_idea"
					var_14_7 = "SP_happy"
				else
					var_14_3 = "event_black_line"
					var_14_7 = "SP_sad"
				end
			else
				if arg_14_2 == 1 then
					var_14_3 = "event_black_line"
					var_14_7 = "SP_sad"
				end

				local var_14_10
				local var_14_8
				local var_14_9

				do
					var_14_3 = "good_idea"
					var_14_7 = "SP_happy"
					var_14_8 = var_14_7 == "SP_happy" and 2.167 or 2
					var_14_9 = #var_14_2 + 1
					var_14_10 = {
						loop = false,
						type = "set_expression",
						expression_name = var_14_3
					}
				end
			end

			var_14_10.duration = var_14_3 == "good_idea" and 0.667 or 2
			var_14_2[var_14_9] = var_14_10
			var_14_2[#var_14_2 + 1] = {
				track_index = 0,
				loop = false,
				type = "set_animation",
				animation_name = var_14_7
			}

			self:dormitory_idea_manager_wait_idea(var_14_2, var_14_8)

			var_14_2[#var_14_2 + 1] = {
				track_index = 0,
				animation_name = "stand1",
				loop = true,
				type = "set_animation"
			}

			if var_14_1.control._tennis_game_count >= 5 then
				var_14_2[#var_14_2 + 1] = {
					type = "stop",
					furniture_id = var_14_1.data.id
				}
				var_14_1.control.param_data = nil
			end

			var_14_0.control:set_play_action_list(var_14_2)
		end
	end

	function arg_1_0:dormitory_play_idea_create_play_assembly_station(arg_15_1)
		local var_15_0 = {}
		local var_15_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_15_1.furniture_ele)

		if not var_15_1 or not next(var_15_1) then
			return
		end

		local var_15_2 = var_15_1[1]
		local var_15_3 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)
		local var_15_4 = 2.933

		if arg_15_1.furniture_ele.config.cid == var_0_6.dormitory_special_furniture_id.painting_table then
			var_15_4 = 4.8
		end

		var_15_0[#var_15_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_15_1.furniture_ele.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_15_0, arg_15_1.ship_ele.control:get_foot_position(), var_15_2, arg_15_1.furniture_ele)

		var_15_0[#var_15_0 + 1] = {
			flip = true,
			type = "flip_x"
		}
		var_15_0[#var_15_0 + 1] = {
			track_index = 0,
			animation_name = "SP2_hobby",
			loop = true,
			type = "set_animation"
		}
		var_15_0[#var_15_0 + 1] = {
			type = "play_assembly_station",
			furniture_ele = arg_15_1.furniture_ele,
			delay = var_15_3 * var_15_4
		}

		self:dormitory_idea_manager_wait_idea(var_15_0, 0.267)

		for iter_15_0 = 1, var_15_3 do
			var_15_0[#var_15_0 + 1] = {
				loop = false,
				expression_name = "good_idea",
				duration = 0.667,
				type = "set_expression"
			}

			self:dormitory_idea_manager_wait_idea(var_15_0, var_15_4)
		end

		var_15_0[#var_15_0 + 1] = {
			loop = false,
			expression_name = "love",
			duration = 0.667,
			type = "set_expression"
		}
		var_15_0[#var_15_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_15_0[#var_15_0 + 1] = {
			type = "stop",
			furniture_id = arg_15_1.furniture_ele.data.id
		}

		arg_15_1.ship_ele.control:set_play_action_list(var_15_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_western_style_coffin(arg_16_1)
		local var_16_0 = {}
		local var_16_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_16_1.furniture_ele)

		if not var_16_1 or not next(var_16_1) then
			return
		end

		local var_16_2 = var_16_1[1]
		local var_16_3 = var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2)

		var_16_0[#var_16_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_16_1.furniture_ele.control:get_sort_order() + 3
		}

		self:dormitory_idea_manager_move_to_action_pos(var_16_0, arg_16_1.ship_ele.control:get_foot_position(), var_16_2, arg_16_1.furniture_ele)

		var_16_0[#var_16_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_16_0[#var_16_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_16_1.furniture_ele.control:get_sort_order() + 1
		}
		var_16_0[#var_16_0 + 1] = {
			state = 1,
			type = "set_ship_parent",
			node = arg_16_1.furniture_ele.control._control.sort_layer.spine.transform
		}
		var_16_0[#var_16_0 + 1] = {
			track_index = 0,
			animation_name = "event_lay_R",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_16_0, 1)

		var_16_0[#var_16_0 + 1] = {
			track_index = 0,
			animation_name = "lay_R",
			loop = true,
			type = "set_animation"
		}
		var_16_0[#var_16_0 + 1] = {
			type = "request_play_western_style_coffin",
			furniture_ele = arg_16_1.furniture_ele,
			delay = var_16_3 * 2
		}

		self:dormitory_idea_manager_wait_idea(var_16_0, var_16_3 * 2 + 1 + 0.5)

		var_16_0[#var_16_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_16_1.furniture_ele.control:get_sort_order() + 3
		}
		var_16_0[#var_16_0 + 1] = {
			track_index = 0,
			animation_name = "lay_UP_R",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_16_0, 1.333)

		var_16_0[#var_16_0 + 1] = {
			state = 2,
			type = "set_ship_parent",
			node = arg_16_1.ship_ele.control._control.sort_layer.ship.transform
		}
		var_16_0[#var_16_0 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_16_0[#var_16_0 + 1] = {
			type = "stop",
			furniture_id = arg_16_1.furniture_ele.data.id
		}

		arg_16_1.ship_ele.control:set_play_action_list(var_16_0)
	end

	function arg_1_0:dormitory_play_idea_create_lay_down(arg_17_1)
		local var_17_0 = arg_17_1.furniture_ele
		local var_17_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_17_1.furniture_ele)

		if not var_17_1 or not next(var_17_1) then
			return
		end

		local var_17_2 = var_17_1[1]
		local var_17_3 = {}
		local var_17_4 = var_17_0.data.rotate

		var_17_3[#var_17_3 + 1] = {
			type = "set_sort_order",
			sort_order = var_17_0.control:get_sort_order() + 1
		}
		var_17_3[#var_17_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_17_3, arg_17_1.ship_ele.control:get_foot_position(), var_17_2, var_17_0)

		local var_17_5 = var_17_4 == true and "event_lay_L" or "event_lay_R"
		local var_17_6 = var_17_4 == true and "lay_L" or "lay_R"
		local var_17_7 = var_17_4 == true and "lay_UP_L" or "lay_UP_R"
		local var_17_8 = var_17_4 == true and 2.333 or 1.333

		var_17_3[#var_17_3 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_17_3[#var_17_3 + 1] = {
			loop = false,
			type = "set_animation",
			track_index = 0,
			animation_name = var_17_5,
			temp_animation_name = var_17_6
		}

		self:dormitory_idea_manager_wait_idea(var_17_3, 1)

		var_17_3[#var_17_3 + 1] = {
			loop = true,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = var_17_6,
			furniture_ele = var_17_0
		}

		self:dormitory_idea_manager_wait_idea(var_17_3, 4 * var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2))

		var_17_3[#var_17_3 + 1] = {
			loop = false,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = var_17_7,
			furniture_ele = var_17_0
		}

		self:dormitory_idea_manager_wait_idea(var_17_3, var_17_8)

		var_17_3[#var_17_3 + 1] = {
			loop = false,
			expression_name = "stop",
			duration = 1,
			type = "set_expression"
		}
		var_17_3[#var_17_3 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_17_3[#var_17_3 + 1] = {
			type = "stop",
			furniture_id = var_17_0.data.id
		}

		arg_17_1.ship_ele.control:set_play_action_list(var_17_3)
		arg_17_1.ship_ele.control:set_inter_furniture_element(var_17_0)
	end

	function arg_1_0:dormitory_play_idea_create_lay_down_left(arg_18_1)
		local var_18_0 = self:dormitory_idea_manager_get_furniture_action_pos(arg_18_1.furniture_ele)
		local var_18_1

		if not var_18_0 or not next(var_18_0) then
			do return end

			var_18_1 = {}
		end

		local var_18_3 = var_0_1(var_18_0[1].x, var_18_0[1].y + 20)

		var_18_1[#var_18_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_18_1.furniture_ele.control:get_sort_order() + 1
		}
		var_18_1[#var_18_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_18_1, arg_18_1.ship_ele.control:get_foot_position(), var_18_3, arg_18_1.furniture_ele)

		var_18_1[#var_18_1 + 1] = {
			type = "flip_x",
			flip = arg_18_1.furniture_ele.data.rotate
		}
		var_18_1[#var_18_1 + 1] = {
			track_index = 0,
			animation_name = "event_lay_L",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_18_1, 1)

		var_18_1[#var_18_1 + 1] = {
			loop = true,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = "lay_L"
		}

		self:dormitory_idea_manager_wait_idea(var_18_1, 4 * var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2))

		var_18_1[#var_18_1 + 1] = {
			loop = false,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = "lay_UP_L"
		}

		self:dormitory_idea_manager_wait_idea(var_18_1, 2.333)

		var_18_1[#var_18_1 + 1] = {
			loop = false,
			expression_name = "stop",
			duration = 1,
			type = "set_expression"
		}
		var_18_1[#var_18_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_18_1[#var_18_1 + 1] = {
			type = "stop",
			furniture_id = arg_18_1.furniture_ele.data.id
		}

		arg_18_1.ship_ele.control:set_play_action_list(var_18_1)
		arg_18_1.ship_ele.control:set_inter_furniture_element(arg_18_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_lay_janpan_sit(arg_19_1)
		local var_19_0 = self:dormitory_idea_manager_get_furniture_action_pos(arg_19_1.furniture_ele)
		local var_19_1

		if not var_19_0 or not next(var_19_0) then
			do return end

			var_19_1 = {}
		end

		local var_19_3 = var_0_1(var_19_0[1].x + 5, var_19_0[1].y + 10)

		var_19_1[#var_19_1 + 1] = {
			type = "set_sort_order",
			sort_order = arg_19_1.furniture_ele.control:get_sort_order() + 1
		}
		var_19_1[#var_19_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_19_1, arg_19_1.ship_ele.control:get_foot_position(), var_19_3, arg_19_1.furniture_ele)

		var_19_1[#var_19_1 + 1] = {
			type = "flip_x",
			flip = arg_19_1.furniture_ele.data.rotate
		}
		var_19_1[#var_19_1 + 1] = {
			track_index = 0,
			animation_name = "event_sit_Japan",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_19_1, 1)

		var_19_1[#var_19_1 + 1] = {
			loop = true,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = "sit_Janpan"
		}

		self:dormitory_idea_manager_wait_idea(var_19_1, 3.333 * var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2))

		var_19_1[#var_19_1 + 1] = {
			loop = false,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = var_0_8.pick_random_from_array({
				"event_sit_Janpan_UP",
				"event_sit_Janpan_UP2"
			})
		}

		self:dormitory_idea_manager_wait_idea(var_19_1, 0.667)

		var_19_1[#var_19_1 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_19_1[#var_19_1 + 1] = {
			type = "stop",
			furniture_id = arg_19_1.furniture_ele.data.id
		}

		arg_19_1.ship_ele.control:set_play_action_list(var_19_1)
		arg_19_1.ship_ele.control:set_inter_furniture_element(arg_19_1.furniture_ele)
	end

	function arg_1_0:dormitory_play_idea_create_lay_read_book(arg_20_1)
		local var_20_0 = arg_20_1.furniture_ele
		local var_20_1 = self:dormitory_idea_manager_get_furniture_action_pos(arg_20_1.furniture_ele)
		local var_20_2

		if not var_20_1 or not next(var_20_1) then
			do return end

			var_20_2 = {}
		end

		local var_20_4 = var_0_1(var_20_1[1].x + 10, var_20_1[1].y - 30)

		var_20_2[#var_20_2 + 1] = {
			type = "set_sort_order",
			sort_order = var_20_0.control:get_sort_order() + 1
		}
		var_20_2[#var_20_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_20_2, arg_20_1.ship_ele.control:get_foot_position(), var_20_4, var_20_0)

		var_20_2[#var_20_2 + 1] = {
			type = "flip_x",
			flip = var_20_0.data.rotate
		}
		var_20_2[#var_20_2 + 1] = {
			track_index = 0,
			animation_name = "SP2_book",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_20_2, 2.677 * var_0_10(var_0_6.furntiure_const.loop_num1, var_0_6.furntiure_const.loop_num2))

		local var_20_5 = var_0_8.pick_random_from_array({
			"event_sit_UP",
			"event_sit_UP2"
		})

		var_20_2[#var_20_2 + 1] = {
			loop = false,
			delay = 0,
			type = "add_animation",
			track_index = 0,
			animation_name = var_20_5
		}

		self:dormitory_idea_manager_wait_idea(var_20_2, var_20_5 == "event_sit_UP" and 1.333 or 2)

		var_20_2[#var_20_2 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}
		var_20_2[#var_20_2 + 1] = {
			type = "stop",
			furniture_id = var_20_0.data.id
		}

		arg_20_1.ship_ele.control:set_play_action_list(var_20_2)
		arg_20_1.ship_ele.control:set_inter_furniture_element(var_20_0)
	end

	function arg_1_0.__check_ship_for_dibox(arg_21_0, arg_21_1)
		local var_21_0 = true
		local var_21_1 = tonumber(arg_21_1.config.pic_id)

		if var_21_1 ~= 18 and var_21_1 ~= 19 and var_21_1 ~= 46 and var_21_1 ~= 97 and var_21_1 ~= 198 and var_21_1 ~= 1018 and var_21_1 ~= 1019 and var_21_1 ~= 1046 then
			var_21_0 = false
		end

		if arg_21_1.data.skin ~= 0 then
			local var_21_2 = var_0_9.find_object_by_cid(arg_21_1.data.skin).icon

			if var_21_2 ~= "18_1" and var_21_2 ~= "46_1" then
				var_21_0 = false
			end
		end

		return var_21_0
	end

	function arg_1_0.__check_ship_for_skateboard(arg_22_0, arg_22_1)
		local var_22_0 = true

		if tonumber(arg_22_1.config.pic_id) ~= 29 and tonumber(arg_22_1.config.pic_id) ~= 1029 then
			return false
		end

		if arg_22_1.data.skin ~= 0 then
			if var_0_9.find_object_by_cid(arg_22_1.data.skin).icon ~= "29_2" then
				var_22_0 = false
			end
		else
			var_22_0 = false
		end

		return var_22_0
	end

	function arg_1_0.__check_ship_for_veneto(arg_23_0, arg_23_1)
		if tonumber(arg_23_1.config.pic_id) ~= 112 and tonumber(arg_23_1.config.pic_id) ~= 1112 then
			return false
		end

		return (arg_23_1.data.skin ~= 0 and tonumber(arg_23_1.config.pic_id) == 1112 or nil) and false
	end

	function arg_1_0:dormitory_idea_manager_request_play_djbox(arg_24_1, arg_24_2)
		local var_24_0 = var_0_11.Sequence()

		var_24_0:AppendCallback(function()
			arg_24_1.control:set_furniture_animation(0, "open", false)
		end)
		var_24_0:AppendInterval(0.667)
		var_24_0:AppendCallback(function()
			arg_24_1.control:set_furniture_animation(0, "normal2", true)
		end)
		var_24_0:AppendInterval(arg_24_2)
		var_24_0:AppendCallback(function()
			arg_24_1.control:set_furniture_animation(0, "close", false)
		end)
		var_24_0:AppendInterval(0.667)
		var_24_0:AppendCallback(function()
			arg_24_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_24_0:Play()
		var_0_12(self._furniture_seq_list, var_24_0)
	end

	function arg_1_0:dormitory_idea_manager_request_play_skateboard(arg_29_1, arg_29_2)
		local var_29_0 = var_0_11.Sequence()

		var_29_0:AppendCallback(function()
			arg_29_1.control:set_furniture_animation(0, "play", true)
		end)
		var_29_0:AppendInterval(arg_29_2)
		var_29_0:AppendCallback(function()
			arg_29_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_29_0:Play()
		var_0_12(self._furniture_seq_list, var_29_0)
	end

	function arg_1_0:dormitory_idea_manager_request_drive_harvester(arg_32_1, arg_32_2)
		local var_32_0 = var_0_11.Sequence()

		var_32_0:AppendCallback(function()
			arg_32_1.control:set_furniture_animation(0, "start", true)
		end)
		var_32_0:AppendInterval(arg_32_2)
		var_32_0:AppendCallback(function()
			arg_32_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_32_0:Play()
		var_0_12(self._furniture_seq_list, var_32_0)
	end

	function arg_1_0:dormitory_idea_manager_request_sit_veneto(arg_35_1, arg_35_2, arg_35_3)
		local var_35_0

		if arg_35_2 - arg_35_3 > 0 then
			var_35_0 = arg_35_2 - arg_35_3 or 0
		end

		local var_35_1 = var_0_11.Sequence()

		var_35_1:AppendCallback(function()
			arg_35_1.control.can_click_veneto = false

			arg_35_1.control:set_furniture_animation(0, "event_fly", false)
		end)
		var_35_1:AppendInterval(5.4)
		var_35_1:AppendCallback(function()
			arg_35_1.control:set_furniture_animation(0, "stand2", true)
		end)
		var_35_1:AppendInterval(arg_35_3)
		var_35_1:AppendCallback(function()
			arg_35_1.control:set_furniture_animation(0, "SP2", false)
		end)
		var_35_1:AppendInterval(4)
		var_35_1:AppendCallback(function()
			arg_35_1.control:set_furniture_animation(0, "stand2", true)
		end)
		var_35_1:AppendInterval(var_35_0)
		var_35_1:AppendCallback(function()
			arg_35_1.control:set_furniture_animation(0, "event_fly_back", false)
		end)
		var_35_1:AppendInterval(4)
		var_35_1:AppendCallback(function()
			arg_35_1.control:set_furniture_animation(0, "stand", true)

			arg_35_1.control.can_click_veneto = true
		end)
		var_35_1:Play()
		var_0_12(self._furniture_seq_list, var_35_1)
	end

	function arg_1_0:dormitory_idea_manager_request_play_magic_wand(arg_42_1, arg_42_2)
		local var_42_0 = var_0_11.Sequence()

		var_42_0:AppendCallback(function()
			arg_42_1.control:set_furniture_animation(0, "open", false)
		end)
		var_42_0:AppendInterval(2)
		var_42_0:AppendCallback(function()
			arg_42_1.control:set_furniture_animation(0, "normal2", true)
		end)
		var_42_0:AppendInterval(arg_42_2)
		var_42_0:AppendCallback(function()
			arg_42_1.control:set_furniture_animation(0, "close", false)
		end)
		var_42_0:AppendInterval(2)
		var_42_0:AppendCallback(function()
			arg_42_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_42_0:Play()
		var_0_12(self._furniture_seq_list, var_42_0)
	end

	function arg_1_0:dormitory_idea_manager_request_play_hat(arg_47_1, arg_47_2)
		arg_47_1.control:__set_skeleton_graphic_skin(arg_47_1.control._control.sort_layer.spine, ({
			"G",
			"H",
			"R",
			"S"
		})[math.floor(arg_47_2.config.cid % 100000 / 100) % 4 + 1])

		local var_47_0 = var_0_11.Sequence()

		var_47_0:AppendCallback(function()
			arg_47_1.control:set_furniture_animation(0, "jump", false)
		end)
		var_47_0:AppendInterval(1.167)
		var_47_0:AppendCallback(function()
			arg_47_1.control:set_furniture_animation(0, "normal2", false)
		end)
		var_47_0:AppendInterval(5.333)
		var_47_0:AppendCallback(function()
			arg_47_1.control:set_furniture_animation(0, "down", false)
		end)
		var_47_0:AppendInterval(1.167)
		var_47_0:AppendCallback(function()
			arg_47_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_47_0:Play()
		var_0_12(self._furniture_seq_list, var_47_0)
	end

	function arg_1_0:dormitory_idea_manager_request_play_desktop_game(arg_52_1)
		if var_0_8.dict_lenght(arg_52_1.ready_ship) > 1 then
			self:dormitory_idea_manager_request_toggle_action(arg_52_1.data.id, true)

			for iter_52_0, iter_52_1 in pairs(arg_52_1.param_data) do
				iter_52_1.ship_ele.control:clear_play_action_list()
			end
		else
			return
		end

		local var_52_0 = {}

		if arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.battleship_simulator or arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.simulated_battle_system then
			var_52_0 = {
				win = 5,
				start = 2,
				game_end = 2,
				close = 2,
				normal = 4
			}
		elseif arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.football_machine then
			var_52_0 = {
				win = 6.667,
				start = 1,
				game_end = 1,
				close = 2,
				normal = 4
			}
		elseif arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.table_tennis_player then
			var_52_0 = {
				win = 3.167,
				start = 1,
				game_end = 1,
				close = 1,
				normal = 2
			}
		elseif arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.desktop_us then
			var_52_0 = {
				start = 1,
				game_end = 1,
				close = 2,
				normal = 4,
				win = arg_52_1.win == 1 and 4 or 3
			}
		elseif arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.battle_desk_gold or arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.battle_desk_fantasy then
			var_52_0 = {
				start = 1,
				game_end = 1,
				close = 2,
				normal = 4,
				win = arg_52_1.win == 1 and 4 or 3
			}
		end

		var_52_0.win_name = arg_52_1.win == 1 and "win_L" or "win_R"

		local var_52_1 = var_52_0.start + arg_52_1.random * var_52_0.normal + var_52_0.win
		local var_52_2 = var_0_11.Sequence()

		var_52_2:AppendCallback(function()
			if self.dormitory_play_idea_create_play_desktop_game_on then
				self:dormitory_play_idea_create_play_desktop_game_on(arg_52_1, var_52_1)

				if arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.battle_desk_gold or arg_52_1.config.cid == var_0_6.dormitory_special_furniture_id.battle_desk_fantasy then
					arg_52_1.control:set_furniture_animation(0, "star", false)
				else
					arg_52_1.control:set_furniture_animation(0, "start", false)
				end
			end
		end)
		var_52_2:AppendInterval(var_52_0.start)
		var_52_2:AppendCallback(function()
			if arg_52_1.control.set_furniture_animation then
				arg_52_1.control:set_furniture_animation(0, "normal", true)
			end
		end)
		var_52_2:AppendInterval(arg_52_1.random * var_52_0.normal)
		var_52_2:AppendCallback(function()
			if arg_52_1.control.set_furniture_animation then
				arg_52_1.control:set_furniture_animation(0, var_52_0.win_name, false)
			end
		end)
		var_52_2:AppendInterval(var_52_0.win)
		var_52_2:AppendCallback(function()
			if arg_52_1.control.set_furniture_animation then
				arg_52_1.control:set_furniture_animation(0, "end", false)
			end
		end)
		var_52_2:AppendInterval(var_52_0.game_end)
		var_52_2:AppendCallback(function()
			if self.dormitory_play_idea_create_play_desktop_game_end then
				self:dormitory_play_idea_create_play_desktop_game_end(arg_52_1)
			end

			if arg_52_1.control.set_furniture_animation then
				arg_52_1.control:set_furniture_animation(0, "close", true)
			end
		end)
		var_52_2:Play()
		var_0_12(self._furniture_seq_list, var_52_2)
	end

	function arg_1_0.dormitory_idea_manager_request_play_tennis(arg_58_0, arg_58_1)
		if var_0_8.dict_lenght(arg_58_1.control.param_data) > 1 then
			local var_58_0 = false

			for iter_58_0, iter_58_1 in pairs(arg_58_1.control.param_data) do
				if iter_58_1.ship_ele.control.to_the_end ~= true then
					var_58_0 = true
				end
			end

			if var_58_0 then
				return
			end
		else
			return
		end

		for iter_58_2, iter_58_3 in pairs(arg_58_1.control.param_data) do
			iter_58_3.ship_ele.control.to_the_end = false
		end

		arg_58_1.control:set_furniture_animation(0, "touch_start", true)
		arg_58_1.control:__set_canvas_group(arg_58_1.control._spine, true)
	end

	function arg_1_0.dormitory_idea_manager_request_play_assembly_station(arg_59_0, arg_59_1, arg_59_2)
		arg_59_1.control:open_spine(true)

		local var_59_0 = var_0_11.Sequence()

		var_59_0:AppendCallback(function()
			arg_59_1.control:set_furniture_animation(0, "start", false)
		end)
		var_59_0:AppendInterval(0.267)
		var_59_0:AppendCallback(function()
			arg_59_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_59_0:AppendInterval(arg_59_2)
		var_59_0:AppendCallback(function()
			arg_59_1.control:set_furniture_animation(0, "end", false)
		end)
		var_59_0:AppendInterval(0.267)
		var_59_0:Play()
	end

	function arg_1_0.dormitory_idea_manager_request_play_western_style_coffin(arg_63_0, arg_63_1, arg_63_2)
		local var_63_0 = var_0_11.Sequence()

		var_63_0:AppendCallback(function()
			arg_63_1.control:set_furniture_animation(0, "close", false)
		end)
		var_63_0:AppendInterval(1)
		var_63_0:AppendCallback(function()
			arg_63_1.control:set_furniture_animation(0, "normal", true)
		end)
		var_63_0:AppendInterval(arg_63_2)
		var_63_0:AppendCallback(function()
			arg_63_1.control:set_furniture_animation(0, "open", false)
		end)
		var_63_0:AppendInterval(0.5)
		var_63_0:AppendCallback(function()
			arg_63_1.control:set_furniture_animation(0, "normal2", true)
		end)
		var_63_0:Play()
	end

	function arg_1_0:dormitory_play_idea_create_play_food_bowl(arg_68_1)
		local var_68_0 = {}
		local var_68_1 = false

		for iter_68_0 = 1, #arg_68_1.animla_data.config.action do
			if arg_68_1.animla_data.config.action[iter_68_0] == var_0_6.furniture_action_type.food_bowl then
				var_68_1 = true
			end
		end

		if var_68_1 == false then
			var_68_0[#var_68_0 + 1] = {
				type = "stop",
				furniture_id = arg_68_1.furniture_ele.data.id
			}

			arg_68_1.ship_ele.control:set_play_action_list(var_68_0)

			return
		end

		local var_68_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_68_1.furniture_ele)

		if not var_68_2 or not next(var_68_2) then
			return
		end

		arg_68_1.ship_ele.control:__reset_seq_list()

		var_68_0[#var_68_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_68_1.furniture_ele.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_68_0, arg_68_1.ship_ele.control:get_now_foot_position(), var_68_2[1], arg_68_1.furniture_ele)

		var_68_0[#var_68_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_68_0[#var_68_0 + 1] = {
			track_index = 0,
			animation_name = "eat",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_68_0, 2)

		var_68_0[#var_68_0 + 1] = {
			type = "stop",
			furniture_id = arg_68_1.furniture_ele.data.id
		}

		arg_68_1.ship_ele.control:set_play_action_list(var_68_0)
	end

	function arg_1_0:kill_all_seq()
		for iter_69_0, iter_69_1 in pairs(self._furniture_seq_list) do
			iter_69_1:Kill()

			iter_69_1 = nil
		end
	end
end

function var_0_0.extend_obj(arg_70_0)
	arg_70_0._furniture_seq_list = {}
end

return var_0_0
