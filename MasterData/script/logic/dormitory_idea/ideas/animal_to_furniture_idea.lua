local var_0_0 = {}
local var_0_1 = UnityEngine.Vector2
local var_0_5 = gameenum.common_type
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = table.insert

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:dormitory_play_idea_create_play_bird_trellis_enter(arg_2_1)
		local var_2_0 = {}
		local var_2_1 = false

		for iter_2_0 = 1, #arg_2_1.animla_data.config.action do
			if arg_2_1.animla_data.config.action[iter_2_0] == var_0_5.furniture_action_type.bird_trellis then
				var_2_1 = true
			end
		end

		if var_2_1 == false then
			var_2_0[#var_2_0 + 1] = {
				type = "stop",
				furniture_id = arg_2_1.furniture_ele.data.id
			}

			arg_2_1.ship_ele.control:set_play_action_list(var_2_0)

			return
		end

		arg_2_1.ship_ele.control:__reset_seq_list()

		local var_2_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_2_1.furniture_ele)

		if not var_2_2 or not next(var_2_2) then
			return
		end

		local var_2_3 = var_2_2[1]
		local var_2_4 = lan_rand(50, 75)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_0, arg_2_1.ship_ele.control:get_now_foot_position(), var_2_3, arg_2_1.furniture_ele, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "event_fly",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "fly",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_0, var_2_3, var_2_3 + var_0_1(var_2_4, 127), arg_2_1.furniture_ele, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "event_fly_end",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "stand",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, (lan_rand(2, 4)))

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "event_fly",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "fly",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_0, var_2_3 + var_0_1(var_2_4, 127), var_2_3 + var_0_1(0, 130), arg_2_1.furniture_ele, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "fly",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_2_0, var_2_3 + var_0_1(0, 130), var_2_3, arg_2_1.furniture_ele, 1)

		var_2_0[#var_2_0 + 1] = {
			track_index = 0,
			animation_name = "event_fly_end",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_2_0, 1)

		var_2_0[#var_2_0 + 1] = {
			type = "stop",
			furniture_id = arg_2_1.furniture_ele.data.id
		}

		arg_2_1.ship_ele.control:set_play_action_list(var_2_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_animal_toilet(arg_3_1)
		local var_3_0 = {}
		local var_3_1 = false

		arg_3_1.furniture_ele.config.behavior_position = {
			{
				x = 1,
				y = 0
			}
		}

		for iter_3_0 = 1, #arg_3_1.animla_data.config.action do
			if arg_3_1.animla_data.config.action[iter_3_0] == var_0_5.furniture_action_type.animal_toilet then
				var_3_1 = true
			end
		end

		if var_3_1 == false then
			var_3_0[#var_3_0 + 1] = {
				type = "stop",
				furniture_id = arg_3_1.furniture_ele.data.id
			}

			arg_3_1.ship_ele.control:set_play_action_list(var_3_0)

			return
		end

		arg_3_1.ship_ele.control:__reset_seq_list()

		local var_3_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_3_1.furniture_ele)

		if not var_3_2 or not next(var_3_2) then
			return
		end

		local var_3_3 = var_3_2[1]

		var_3_0[#var_3_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_3_1.furniture_ele.control:get_sort_order() - 1
		}
		var_3_0[#var_3_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_3_0, arg_3_1.ship_ele.control:get_now_foot_position(), var_3_3, arg_3_1.furniture_ele)

		var_3_0[#var_3_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_3_0, var_3_3, var_3_3 + var_0_1(-50, 0), arg_3_1.furniture_ele, 2)

		var_3_0[#var_3_0 + 1] = {
			loop = true,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = "start",
			furniture_ele = arg_3_1.furniture_ele
		}

		self:dormitory_idea_manager_wait_idea(var_3_0, lan_rand(2, 3) * 2)

		var_3_0[#var_3_0 + 1] = {
			loop = true,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = "normal",
			furniture_ele = arg_3_1.furniture_ele
		}
		var_3_0[#var_3_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_3_0, var_3_3 + var_0_1(-50, 0), var_3_3 + var_0_1(-160, 0), arg_3_1.furniture_ele, 1)
		self:dormitory_idea_manager_move_to_action_pos(var_3_0, var_3_3 + var_0_1(-160, 0), var_3_3 + var_0_1(-160, -50), arg_3_1.furniture_ele, 1)

		var_3_0[#var_3_0 + 1] = {
			type = "stop",
			furniture_id = arg_3_1.furniture_ele.data.id
		}

		arg_3_1.ship_ele.control:set_play_action_list(var_3_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_red_mat(arg_4_1)
		local var_4_0 = {}
		local var_4_1 = arg_4_1.ship_ele
		local var_4_2 = arg_4_1.furniture_ele
		local var_4_3 = false
		local var_4_4 = false
		local var_4_5 = false
		local var_4_6 = ""
		local var_4_7 = ""
		local var_4_8 = ""

		for iter_4_0 = 1, #arg_4_1.animla_data.config.action do
			if arg_4_1.animla_data.config.action[iter_4_0] == var_0_5.furniture_action_type.animal_sit then
				var_4_3 = true
				var_4_4 = true
			end

			if arg_4_1.animla_data.config.action[iter_4_0] == var_0_5.furniture_action_type.animal_sleep then
				var_4_3 = true
				var_4_5 = true
			end
		end

		if var_4_3 == false then
			var_4_0[#var_4_0 + 1] = {
				type = "stop",
				furniture_id = var_4_2.data.id
			}

			var_4_1.control:set_play_action_list(var_4_0)

			return
		end

		var_4_1.control:__reset_seq_list()

		local var_4_9 = self:dormitory_idea_manager_get_furniture_action_pos(var_4_2)

		if not var_4_9 or not next(var_4_9) then
			return
		end

		local var_4_10 = var_4_9[1]
		local var_4_11 = var_4_1.control:get_now_foot_position()
		local var_4_12 = lan_rand(1, 3)

		if var_4_5 == true and var_4_4 == false then
			var_4_6 = "event_sleep"
			var_4_7 = "sleep"
			var_4_8 = "event_sleep_end"
		elseif var_4_5 == false and var_4_4 == true then
			var_4_6 = "event_sit"
			var_4_7 = "sit"
			var_4_8 = "event_sit_end"
		elseif var_4_5 == true and var_4_4 == true then
			if lan_rand(1, 2) == 1 then
				var_4_6 = "event_sleep"
				var_4_7 = "sleep"
				var_4_8 = "event_sleep_end"
			else
				var_4_6 = "event_sit"
				var_4_7 = "sit"
				var_4_8 = "event_sit_end"
			end
		end

		var_4_0[#var_4_0 + 1] = {
			type = "set_sort_order",
			sort_order = var_4_2.control:get_sort_order() + 1
		}
		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_0, var_4_11, var_4_10 + var_0_1(0, -15), var_4_2)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_0, var_4_10 + var_0_1(0, -15), var_4_10, var_4_2)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_4_6
		}

		self:dormitory_idea_manager_wait_idea(var_4_0, 0.667)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			loop = true,
			type = "set_animation",
			animation_name = var_4_7
		}

		self:dormitory_idea_manager_wait_idea(var_4_0, var_4_12 * 2)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			loop = false,
			type = "set_animation",
			animation_name = var_4_8
		}

		self:dormitory_idea_manager_wait_idea(var_4_0, 2.667)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_0, var_4_10, var_4_10 + var_0_1(0, -15), var_4_2)

		var_4_0[#var_4_0 + 1] = {
			track_index = 0,
			animation_name = "walk_slow",
			loop = true,
			type = "set_animation"
		}

		self:dormitory_idea_manager_move_to_action_pos(var_4_0, var_4_10 + var_0_1(0, -15), var_4_10 + var_0_1(-80, -50), var_4_2)

		var_4_0[#var_4_0 + 1] = {
			type = "stop",
			furniture_id = var_4_2.data.id
		}

		var_4_1.control:set_play_action_list(var_4_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_cat_scratch_plate(arg_5_1)
		local var_5_0 = {}
		local var_5_1 = false

		for iter_5_0 = 1, #arg_5_1.animla_data.config.action do
			if arg_5_1.animla_data.config.action[iter_5_0] == var_0_5.furniture_action_type.cat_scratch_plate then
				var_5_1 = true
			end
		end

		if var_5_1 == false then
			var_5_0[#var_5_0 + 1] = {
				type = "stop",
				furniture_id = arg_5_1.furniture_ele.data.id
			}

			arg_5_1.ship_ele.control:set_play_action_list(var_5_0)

			return
		end

		local var_5_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_5_1.furniture_ele)

		if not var_5_2 or not next(var_5_2) then
			return
		end

		arg_5_1.ship_ele.control:__reset_seq_list()

		var_5_0[#var_5_0 + 1] = {
			type = "set_sort_order",
			sort_order = arg_5_1.furniture_ele.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_5_0, arg_5_1.ship_ele.control:get_now_foot_position(), var_5_2[1], arg_5_1.furniture_ele)

		var_5_0[#var_5_0 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_5_0[#var_5_0 + 1] = {
			track_index = 0,
			animation_name = "jump",
			loop = false,
			type = "set_animation"
		}

		self:dormitory_idea_manager_wait_idea(var_5_0, 2)

		var_5_0[#var_5_0 + 1] = {
			type = "stop",
			furniture_id = arg_5_1.furniture_ele.data.id
		}

		arg_5_1.ship_ele.control:set_play_action_list(var_5_0)
	end

	function arg_1_0:dormitory_play_idea_create_play_mini_rowing_enter(arg_6_1, arg_6_2)
		local var_6_0 = false
		local var_6_1 = false
		local var_6_2 = false
		local var_6_3 = 0
		local var_6_4 = arg_6_1.ship_ele
		local var_6_5 = arg_6_1.furniture_ele
		local var_6_6 = {}
		local var_6_7 = self:dormitory_idea_manager_get_furniture_action_pos(arg_6_1.furniture_ele)

		if not var_6_7 or not next(var_6_7) then
			return
		end

		local var_6_8 = var_6_4.control:get_foot_position()
		local var_6_9 = var_6_7[1]

		if var_6_5.param_data and next(var_6_5.param_data) then
			var_6_9 = {
				x = var_6_9.x + math.abs(var_6_5.config.behavior_position[1].x) * 2 * var_0_5.dormitory_const.room_x_plus,
				y = var_6_9.y
			}
		end

		if not var_6_5.param_data then
			var_6_5.param_data = {}
			var_6_5.ready_ship = {}

			self:dormitory_idea_manager_request_toggle_action(arg_6_2, false)
		end

		var_0_9(var_6_5.param_data, arg_6_1)

		var_6_5.random = lan_rand(3, 5)
		var_6_5.win = lan_rand(1, 2)

		for iter_6_0, iter_6_1 in ipairs(self._curr_furniture_tb) do
			if iter_6_1.config.cid == var_0_5.dormitory_special_furniture_id.model_assembly_platform then
				var_6_0 = true
			elseif iter_6_1.config.cid == var_0_5.dormitory_special_furniture_id.painting_table then
				var_6_1 = true
			elseif iter_6_1.config.cid == var_0_5.dormitory_special_furniture_id.parts_rack then
				var_6_2 = true
			end
		end

		if var_6_0 == true and var_6_1 == true and var_6_2 == true then
			var_6_3 = 1
			var_6_5.win = 1
		end

		if var_6_0 == true and var_6_1 == false and var_6_2 == true then
			var_6_3 = 2
			var_6_5.win = lan_rand(1, 2)
		end

		if var_6_0 == true and var_6_1 == false and var_6_2 == false then
			var_6_3 = 3
			var_6_5.win = lan_rand(1, 4)
		end

		if var_6_0 == false and var_6_1 == false and var_6_2 == true then
			var_6_3 = 3
			var_6_5.win = lan_rand(1, 4)
		end

		if var_6_0 == false and var_6_1 == false and var_6_2 == false then
			var_6_3 = 4
			var_6_5.win = lan_rand(3, 4)
		end

		if var_6_3 == 1 then
			self.delay_time = 55.334
		elseif var_6_3 == 2 then
			if var_6_5.win == 1 then
				self.delay_time = 29.667
				var_6_5.name = "g_win"
				var_6_5.time = 27.667
			elseif var_6_5.win == 2 then
				self.delay_time = 28.833
				var_6_5.name = "e_win"
				var_6_5.time = 26.833
			end
		elseif var_6_3 == 3 then
			if var_6_5.win == 1 then
				self.delay_time = 29.667
				var_6_5.name = "g_win"
				var_6_5.time = 27.667
			elseif var_6_5.win == 2 then
				self.delay_time = 28.833
				var_6_5.name = "e_win"
				var_6_5.time = 26.833
			elseif var_6_5.win == 3 then
				self.delay_time = 10.333
				var_6_5.name = "boom1"
				var_6_5.time = 8.333
			elseif var_6_5.win == 4 then
				self.delay_time = 18.667
				var_6_5.name = "boom2"
				var_6_5.time = 16.667
			end
		elseif var_6_3 == 4 then
			if var_6_5.win == 3 then
				self.delay_time = 10.333
				var_6_5.name = "boom1"
				var_6_5.time = 8.333
			elseif var_6_5.win == 4 then
				self.delay_time = 18.667
				var_6_5.name = "boom2"
				var_6_5.time = 16.667
			end
		end

		var_6_6[#var_6_6 + 1] = {
			type = "set_sort_order",
			sort_order = var_6_5.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_6_6, var_6_8, var_6_9, var_6_5, 0.5)

		var_6_6[#var_6_6 + 1] = {
			type = "flip_x",
			flip = #var_6_5.param_data == 1
		}
		var_6_6[#var_6_6 + 1] = {
			track_index = 0,
			animation_name = "stand1",
			loop = true,
			type = "set_animation"
		}
		var_6_6[#var_6_6 + 1] = {
			type = "request_play_mini_rowing",
			furniture_ele = var_6_5,
			action_type = var_6_3
		}

		if #var_6_5.param_data == 1 then
			self:dormitory_idea_manager_wait_idea(var_6_6, (lan_rand(3, 15)))

			var_6_6[#var_6_6 + 1] = {
				type = "reset_data",
				furniture_ele = var_6_5,
				ship_ele = var_6_4
			}
			var_6_6[#var_6_6 + 1] = {
				type = "stop",
				furniture_id = var_6_5.data.id
			}
		end

		var_6_4.control:set_play_action_list(var_6_6)
	end

	function arg_1_0:dormitory_play_idea_create_play_mini_rowing_on(arg_7_1, arg_7_2)
		for iter_7_0, iter_7_1 in ipairs(arg_7_1.param_data) do
			iter_7_1.ship_ele.control:clear_play_action_list()

			local var_7_0 = {}

			var_7_0[#var_7_0 + 1] = {
				track_index = 0,
				animation_name = "SP2_battle",
				loop = true,
				type = "set_animation"
			}

			self:dormitory_idea_manager_wait_idea(var_7_0, self.delay_time)
			iter_7_1.ship_ele.control:set_play_action_list(var_7_0)
		end
	end

	function arg_1_0:dormitory_play_idea_create_play_mini_rowing_end(arg_8_1, arg_8_2)
		if arg_8_1.param_data then
			for iter_8_0, iter_8_1 in ipairs(arg_8_1.param_data) do
				local var_8_0 = iter_8_1.ship_ele
				local var_8_1 = {}
				local var_8_2
				local var_8_3

				if iter_8_0 == 1 then
					if arg_8_1.win == 1 then
						var_8_2 = "good_idea"
						var_8_3 = "SP_happy"
					elseif arg_8_1.win == 2 then
						var_8_2 = "event_black_line"
						var_8_3 = "SP_sad"
					elseif arg_8_1.win == 3 then
						var_8_2 = "event_black_line"
						var_8_3 = "SP_sad"
					elseif arg_8_1.win == 4 then
						var_8_2 = "event_black_line"
						var_8_3 = "SP_sad"
					end
				elseif arg_8_1.win == 1 then
					var_8_2 = "event_black_line"
					var_8_3 = "SP_sad"
				elseif arg_8_1.win == 2 then
					var_8_2 = "good_idea"
					var_8_3 = "SP_happy"
				elseif arg_8_1.win == 3 then
					var_8_2 = "event_black_line"
					var_8_3 = "SP_sad"
				else
					local var_8_6
					local var_8_5

					if arg_8_1.win == 4 then
						var_8_2 = "event_black_line"
						var_8_3 = "SP_sad"
						var_8_5 = #var_8_1 + 1
						var_8_6 = {
							loop = false,
							type = "set_expression",
							expression_name = var_8_2
						}
					end
				end

				var_8_6.duration = var_8_2 == "good_idea" and 0.667 or 2
				var_8_1[var_8_5] = var_8_6
				var_8_1[#var_8_1 + 1] = {
					track_index = 0,
					loop = true,
					type = "set_animation",
					animation_name = var_8_3
				}

				self:dormitory_idea_manager_wait_idea(var_8_1, 2.16)

				var_8_1[#var_8_1 + 1] = {
					type = "stop",
					furniture_id = arg_8_1.data.id
				}

				var_8_0.control:set_play_action_list(var_8_1)
			end
		end

		arg_8_1.param_data = nil
	end

	function arg_1_0:dormitory_play_idea_create_play_play_game_enter(arg_9_1)
		local var_9_0 = arg_9_1.furniture_ele
		local var_9_1 = {}
		local var_9_2 = self:dormitory_idea_manager_get_furniture_action_pos(arg_9_1.furniture_ele)

		if not var_9_2 or not next(var_9_2) then
			return
		end

		local var_9_3 = arg_9_1.ship_ele.control:get_foot_position()

		if var_9_0.param_data and next(var_9_0.param_data) then
			local var_9_4 = {
				x = var_9_2[1].x + math.abs(var_9_0.config.behavior_position[1].x) * 2 * var_0_5.dormitory_const.room_x_plus,
				y = var_9_2[1].y
			}
		end

		local var_9_5 = self:dormitory_idea_manager_get_furniture_action_pos(var_9_0)

		if not var_9_5 or not next(var_9_5) then
			return
		end

		local var_9_6 = lan_rand(1, 4)

		if var_9_6 == 1 or var_9_6 == 2 then
			normal_action = "normal_A"
			end_action = "end"
		end

		if var_9_6 == 3 or var_9_6 == 4 then
			normal_action = "normal_B"
			end_action = "end_B"
		end

		local var_9_7 = var_9_5[1]

		var_9_1[#var_9_1 + 1] = {
			type = "set_sort_order",
			sort_order = var_9_0.control:get_sort_order() + 1
		}

		self:dormitory_idea_manager_move_to_action_pos(var_9_1, arg_9_1.ship_ele.control:get_foot_position(), var_9_7, var_9_0)

		var_9_1[#var_9_1 + 1] = {
			flip = false,
			type = "flip_x"
		}
		var_9_1[#var_9_1 + 1] = {
			track_index = 0,
			animation_name = "SP2_play_game2",
			loop = true,
			type = "set_animation"
		}
		var_9_1[#var_9_1 + 1] = {
			loop = false,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = "open",
			furniture_ele = var_9_0
		}

		self:dormitory_idea_manager_wait_idea(var_9_1, 2.667)

		var_9_1[#var_9_1 + 1] = {
			loop = true,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = normal_action,
			furniture_ele = var_9_0
		}

		self:dormitory_idea_manager_wait_idea(var_9_1, 2.667 * var_9_6)

		var_9_1[#var_9_1 + 1] = {
			loop = false,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = end_action,
			furniture_ele = var_9_0
		}

		self:dormitory_idea_manager_wait_idea(var_9_1, 0.333)

		var_9_1[#var_9_1 + 1] = {
			loop = false,
			type = "set_special_furniture_animation",
			track_index = 0,
			animation_name = "close",
			furniture_ele = var_9_0
		}
		var_9_1[#var_9_1 + 1] = {
			type = "stop",
			furniture_id = var_9_0.data.id
		}

		arg_9_1.ship_ele.control:set_play_action_list(var_9_1)
	end

	function arg_1_0.set_special_furniture_animation(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
		arg_10_4.control:set_furniture_animation(arg_10_1, arg_10_2, arg_10_3)
	end

	function arg_1_0:dormitory_idea_manager_request_play_mini_rowing(arg_11_1, arg_11_2)
		if not arg_11_1.param_data or #arg_11_1.param_data <= 1 then
			return
		end

		local var_11_0 = var_0_8.Sequence()

		if arg_11_2 == 1 then
			var_11_0:AppendCallback(function()
				self:dormitory_play_idea_create_play_mini_rowing_on(arg_11_1, arg_11_2)
				arg_11_1.control:set_furniture_animation(0, "open", false)
			end)
			var_11_0:AppendInterval(2)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, "normal_red", true)
			end)
			var_11_0:AppendInterval(25.667)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, "g_win", false)
			end)
			var_11_0:AppendInterval(27.667)
			var_11_0:AppendCallback(function()
				self:dormitory_play_idea_create_play_mini_rowing_end(arg_11_1, arg_11_2)
				arg_11_1.control:set_furniture_animation(0, "close", false)
			end)
			var_11_0:AppendInterval(2)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, "normal", true)
			end)
			var_11_0:Play()
		else
			var_11_0:AppendCallback(function()
				self:dormitory_play_idea_create_play_mini_rowing_on(arg_11_1, arg_11_2)
				arg_11_1.control:set_furniture_animation(0, "open", false)
			end)
			var_11_0:AppendInterval(2)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, arg_11_1.name, true)
			end)
			var_11_0:AppendInterval(arg_11_1.time - 3)
			var_11_0:AppendCallback(function()
				self:dormitory_play_idea_create_play_mini_rowing_end(arg_11_1, arg_11_2)
			end)
			var_11_0:AppendInterval(3)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, "close", false)
			end)
			var_11_0:AppendInterval(2)
			var_11_0:AppendCallback(function()
				arg_11_1.control:set_furniture_animation(0, "normal", true)
			end)
			var_11_0:Play()
		end

		var_0_9(self._furniture_seq_list, var_11_0)
	end
end

function var_0_0.extend_obj(arg_22_0)
	return
end

return var_0_0
