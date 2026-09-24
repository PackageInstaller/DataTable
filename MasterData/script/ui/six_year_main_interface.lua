local var_0_0 = {}
local var_0_1 = next
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.user
local var_0_6 = gamecore.util_func
local var_0_7 = string.format
local var_0_8 = DG.Tweening.DOTween
local var_0_9 = gameconfig.monster_formation_config
local var_0_10 = gameconfig.monster_config
local var_0_11 = gameconfig.sixth_map_config
local var_0_12 = gameconfig.sixth_map_node_config
local var_0_13 = table.insert
local var_0_14 = gameconfig.sixth_adjutant_config
local var_0_15 = gameconfig.sixth_combat_chapter_config
local var_0_16 = gameconfig.pve_guide_config
local var_0_17 = gamecore.prompt
local var_0_18 = gameconfig.sixth_combat_chapter_config
local var_0_19 = UnityEngine.Screen
local var_0_20 = gameconfig.ship_pve_active_config

gamecore.UILoader:define("six_year_main_interface", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		var_0_5:set_to_six_year(true)
		var_0_5:set_to_six_fight_map(false)

		self._now_into_plot = arg_2_1
		self._active_info = {
			var_0_4.all_active.decisive_battle_sea_one,
			var_0_4.all_active.decisive_battle_sea_two,
			var_0_4.all_active.decisive_battle_sea_three
		}

		self:setVisible(true)
		self:updata_info()
		self:__init_panel()
		self:__init_show_instructions_view()
	end

	function arg_1_0:__onUpdate()
		self:_now_add_ticket_time()
	end

	function arg_1_0.now_active_id(arg_4_0, arg_4_1)
		local var_4_0 = var_0_20.get_sequence()

		for iter_4_0, iter_4_1 in pairs(arg_4_1) do
			if var_0_20.find_object_by_id(iter_4_1) then
				arg_4_0._now_index = iter_4_0

				return (var_0_20.find_object_by_id(iter_4_1))
			end
		end
	end

	function arg_1_0:updata_info()
		self.six_info = var_0_5:_get_six_info()
		self._six_all_map_info = {}

		for iter_5_0, iter_5_1 in pairs((var_0_5:get_bigmap_info())) do
			var_0_13(self._six_all_map_info, iter_5_1)
		end

		local var_5_0 = var_0_5:get_sixth_combat_info()

		self._now_attack = var_0_5:get_sixth_combat_info()

		local var_5_1 = self:now_active_id(self._active_info)

		if var_5_1.movie_group_id and var_5_1.movie_group_id ~= 0 then
			self._now_movie_id = var_5_1.movie_group_id
		end

		self._now_active_expect = var_5_1

		var_0_5:set_now_six_bgm(self._now_active_expect.bgm)

		self._first_map_id = var_5_1.map_id
		self._first_level_id = var_0_11.find_object_by_id(var_5_1.map_id).level_id

		local var_5_2 = {}

		for iter_5_2, iter_5_3 in pairs(self._six_all_map_info) do
			if iter_5_3.id > (self._now_index - 1) * 6 + 10000 and iter_5_3.id < self._now_index * 6 + 10001 then
				var_0_13(var_5_2, iter_5_3)
			end
		end

		self._six_all_map_info = var_5_2

		if self._now_into_plot then
			self.now_map_level = self._now_into_plot

			return
		end

		if #self._six_all_map_info == 1 then
			self.now_map_level = var_0_11.find_object_by_id(var_5_1.map_id).level_id
		elseif #self._six_all_map_info > 1 then
			local var_5_5 = 0

			for iter_5_4, iter_5_5 in pairs(self._six_all_map_info) do
				if iter_5_5.state > 1 then
					var_5_5 = var_5_5 + 1
				end
			end

			for iter_5_6, iter_5_7 in pairs(self._six_all_map_info) do
				if iter_5_7.state == 1 then
					-- block empty
				end
			end

			self.now_map_level = var_5_0.big_id and var_5_0.big_id ~= 0 and var_0_1(var_5_0.ship_total) and var_5_0.big_id or not var_5_0.big_id and var_0_11.find_object_by_id(var_5_1.map_id).level_id - 1 + var_5_5 or var_0_11.find_object_by_id(var_5_1.map_id).level_id - 1 + var_5_5
		else
			self.now_map_level = var_0_11.find_object_by_id(var_5_1.map_id).level_id
		end

		for iter_5_8, iter_5_9 in pairs(self._six_all_map_info) do
			if var_0_5:get_repeat_map_id() then
				local var_5_9 = var_0_5:get_repeat_map_id()

				if iter_5_9.id == var_5_9 and (iter_5_9.state == 2 or iter_5_9.state == 3) then
					self.now_map_level = var_5_9
				end
			end
		end

		if var_5_0 and var_5_0.big_id and var_5_0.big_id ~= 0 then
			self.now_map_level = var_5_0.big_id

			return
		end

		local var_5_10 = self.now_map_level + 1

		for iter_5_10, iter_5_11 in ipairs(self._six_all_map_info) do
			if iter_5_11.state == 1 and var_5_10 == iter_5_11.id then
				self.now_map_level = var_5_10
			end
		end
	end

	function arg_1_0:reset_adjutant_state()
		self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_5:get_six_adjutant()
		self._adjutant_config = var_0_14.find_object_by_id(self._adjutant_set[self._current_adjutant_index])
		self._control.main.aide.image.sprite = self:loadSprite((var_0_7(var_0_4.sixth_adjutant_image, self._adjutant_config.id)))

		self._control.main.aide.image:SetNativeSize()
	end

	function arg_1_0:__set_node_data_list_by_sort_or_type()
		self.frist_node_list = {}
		self.second_node_list = {}
		self.third_node_list = {}
		self.plot_node_list = {}

		local var_7_0, var_7_1 = var_0_11.get_sequence()
		local var_7_2 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			if iter_7_1.id >= self._first_map_id then
				var_0_13(var_7_2, iter_7_1)
			end
		end

		for iter_7_2, iter_7_3 in pairs(var_7_2) do
			if iter_7_3.sort == 1 then
				var_0_13(self.frist_node_list, iter_7_3)
			elseif iter_7_3.sort == 2 then
				var_0_13(self.second_node_list, iter_7_3)
			elseif iter_7_3.sort == 3 then
				var_0_13(self.third_node_list, iter_7_3)
			end

			if iter_7_3.type == 3 then
				var_0_13(self.plot_node_list, iter_7_3)
			end
		end
	end

	function arg_1_0:__get_level_map_data_by_node(arg_8_1, arg_8_2)
		local var_8_0

		if arg_8_1 == 1 then
			var_8_0 = self.frist_node_list
		elseif arg_8_1 == 2 then
			var_8_0 = self.second_node_list
		elseif arg_8_1 == 3 then
			var_8_0 = self.third_node_list
		elseif arg_8_1 == 4 then
			var_8_0 = self.plot_node_list
		end

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			if iter_8_1.level_id == arg_8_2 then
				return iter_8_1
			end
		end
	end

	function arg_1_0._bg_adaptive_now(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
		if var_0_19.width / var_0_19.height > 1.3 and var_0_19.width / var_0_19.height < 1.4 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 120)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 120)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 120)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 120)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 120)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 120)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 120)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 120)
			end
		elseif var_0_19.width / var_0_19.height == 1.6 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 200)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 200)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 200)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 200)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 200)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 200)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 200)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 200)
			end
		elseif var_0_19.width / var_0_19.height > 2.16 and var_0_19.width / var_0_19.height < 2.17 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 245)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 245)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 245)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 245)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 245)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 245)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 245)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 245)
			end
		elseif var_0_19.width / var_0_19.height > 2.14 and var_0_19.width / var_0_19.height < 2.15 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 240)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 240)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 240)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 240)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 240)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 240)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 240)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 240)
			end
		elseif var_0_19.width / var_0_19.height > 1.7 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 240)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 240)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 240)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 240)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 240)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 240)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 240)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 240)
			end
		elseif var_0_19.width / var_0_19.height > 1.5 and var_0_19.width / var_0_19.height < 1.51 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 170)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 170)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 170)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 170)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 170)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 170)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 170)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 170)
			end
		elseif var_0_19.width / var_0_19.height > 1.43 and var_0_19.width / var_0_19.height < 1.45 then
			arg_9_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_9_2.position.x - 640, -arg_9_2.position.y + 160)
			arg_9_1.point_one.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 160)
			arg_9_1.point_two.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 160)
			arg_9_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_9_3.position.x - 640, -arg_9_3.position.y + 160)
			arg_9_1.path_one.transform.anchoredPosition = Vector2(arg_9_3.line_position[1].x - 640, -arg_9_3.line_position[1].y + 160)
			arg_9_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_9_4.position.x - 640, -arg_9_4.position.y + 160)
			arg_9_1.path_two.transform.anchoredPosition = Vector2(arg_9_4.line_position[1].x - 640, -arg_9_4.line_position[1].y + 160)

			if arg_9_5 then
				arg_9_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_9_5.position.x - 640, -arg_9_5.position.y + 160)
			end
		end
	end

	function arg_1_0._bg_adaptive_prev(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
		if var_0_19.width / var_0_19.height > 1.3 and var_0_19.width / var_0_19.height < 1.4 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 120)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 120)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 120)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 120)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 120)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 120)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 120)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 120)
			end
		elseif var_0_19.width / var_0_19.height == 1.6 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 200)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 200)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 200)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 200)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 200)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 200)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 200)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 200)
			end
		elseif var_0_19.width / var_0_19.height > 2.16 and var_0_19.width / var_0_19.height < 2.17 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 245)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 245)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 245)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 245)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 245)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 245)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 245)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 245)
			end
		elseif var_0_19.width / var_0_19.height > 1.7 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 240)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 240)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 240)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 240)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 240)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 240)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 240)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 240)
			end
		elseif var_0_19.width / var_0_19.height > 1.5 and var_0_19.width / var_0_19.height < 1.51 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 170)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 170)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 170)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 170)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 170)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 170)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 170)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 170)
			end
		elseif var_0_19.width / var_0_19.height > 1.43 and var_0_19.width / var_0_19.height < 1.45 then
			arg_10_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_10_2.position.x - 640, -arg_10_2.position.y + 160)
			arg_10_1.point_one.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 160)
			arg_10_1.point_two.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 160)
			arg_10_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_10_3.position.x - 640, -arg_10_3.position.y + 160)
			arg_10_1.path_one.transform.anchoredPosition = Vector2(arg_10_3.line_position[1].x - 640, -arg_10_3.line_position[1].y + 160)
			arg_10_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_10_4.position.x - 640, -arg_10_4.position.y + 160)
			arg_10_1.path_two.transform.anchoredPosition = Vector2(arg_10_4.line_position[1].x - 640, -arg_10_4.line_position[1].y + 160)

			if arg_10_5 then
				arg_10_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_10_5.position.x - 640, -arg_10_5.position.y + 160)
			end
		end
	end

	function arg_1_0._bg_adaptive_next(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
		if var_0_19.width / var_0_19.height > 1.3 and var_0_19.width / var_0_19.height < 1.4 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 120)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 120)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 120)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 120)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 120)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 120)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 120)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 120)
			end
		elseif var_0_19.width / var_0_19.height == 1.6 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 200)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 200)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 200)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 200)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 200)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 200)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 200)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 200)
			end
		elseif var_0_19.width / var_0_19.height > 2.16 and var_0_19.width / var_0_19.height < 2.17 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 245)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 245)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 245)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 245)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 245)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 245)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 245)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 245)
			end
		elseif var_0_19.width / var_0_19.height > 2.14 and var_0_19.width / var_0_19.height < 2.15 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 240)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 240)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 240)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 240)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 240)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 240)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 240)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 240)
			end
		elseif var_0_19.width / var_0_19.height > 1.7 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 240)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 240)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 240)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 240)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 240)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 240)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 240)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 240)
			end
		elseif var_0_19.width / var_0_19.height > 1.5 and var_0_19.width / var_0_19.height < 1.51 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 170)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 170)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 170)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 170)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 170)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 170)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 170)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 170)
			end
		elseif var_0_19.width / var_0_19.height > 1.43 and var_0_19.width / var_0_19.height < 1.45 then
			arg_11_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_11_2.position.x - 640, -arg_11_2.position.y + 160)
			arg_11_1.point_one.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 160)
			arg_11_1.point_two.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 160)
			arg_11_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_11_3.position.x - 640, -arg_11_3.position.y + 160)
			arg_11_1.path_one.transform.anchoredPosition = Vector2(arg_11_3.line_position[1].x - 640, -arg_11_3.line_position[1].y + 160)
			arg_11_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_11_4.position.x - 640, -arg_11_4.position.y + 160)
			arg_11_1.path_two.transform.anchoredPosition = Vector2(arg_11_4.line_position[1].x - 640, -arg_11_4.line_position[1].y + 160)

			if arg_11_5 then
				arg_11_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_11_5.position.x - 640, -arg_11_5.position.y + 160)
			end
		end
	end

	function arg_1_0:__set_level_map_node_data(arg_12_1, arg_12_2)
		local var_12_0

		if self._now_index == 1 then
			var_12_0 = 9300 + arg_12_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_12_0 = 9300 + arg_12_2 % 10000 * 3
		end

		local var_12_1 = var_0_5:get_sixth_combat_info()

		self._now_map_level = arg_12_2

		local var_12_2 = self:__get_level_map_data_by_node(1, arg_12_2)
		local var_12_4 = self:__get_level_map_data_by_node(2, arg_12_2)
		local var_12_5 = self:__get_level_map_data_by_node(3, arg_12_2)
		local var_12_6 = self:__get_level_map_data_by_node(4, arg_12_2)

		arg_12_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_12_2))

		local var_12_7 = {
			arg_12_1.enemy_group_one,
			arg_12_1.enemy_group_two,
			arg_12_1.enemy_group_three
		}

		self._node_data = var_12_7

		local var_12_8 = {
			var_12_2.id,
			(nil).id,
			(nil).id
		}
		local var_12_9 = {
			var_12_2.boss_bg,
			(nil).boss_bg,
			(nil).boss_bg
		}

		self.node_data_id = var_12_8

		local var_12_10 = var_0_5:get_sixth_combat_info()
		local var_12_11 = var_0_5:find_prev_bigmap(arg_12_2)

		self._now_map_info = var_12_11

		local var_12_12 = var_0_5:get_clear_map_info()
		local var_12_13 = {
			arg_12_1.point_one,
			arg_12_1.point_two
		}
		local var_12_14 = {
			arg_12_1.path_one,
			arg_12_1.path_two
		}

		for iter_12_0 = 1, #var_12_14 do
			var_12_14[iter_12_0]:GetComponent("Image"):SetNativeSize()
		end

		self._node_path = var_12_14
		arg_12_1.enemy_group_one.points.max.text.text = var_12_2.total_score
		arg_12_1.enemy_group_two.points.max.text.text = (nil).total_score
		arg_12_1.enemy_group_three.points.max.text.text = (nil).total_score
		UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(UnityEngine.Camera)).fieldOfView = 20 * (var_0_4.screen_ratio / (var_0_19.width / var_0_19.height > 1.5 and 1.7777777777777777 or var_0_19.width / var_0_19.height))

		self:_bg_adaptive_now(arg_12_1, var_12_2, nil, nil, nil)

		arg_12_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_12_2, 1))
		arg_12_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_12_2, 2))

		arg_12_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_12_2, nil, arg_12_1)

		if nil and var_0_5:get_now_have_sp() then
			arg_12_1.enemy_group_four.gameObject:SetActive(true)
			arg_12_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_12_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_12_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_12_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_12_1.enemy_group_four.gameObject:SetActive(false)
		end

		for iter_12_1 = 1, #var_12_7 do
			var_12_7[iter_12_1].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_12_0 + iter_12_1))
			var_12_7[iter_12_1].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_12_9[iter_12_1]))

			var_12_7[iter_12_1].enemy:GetComponent("Image"):SetNativeSize()

			var_12_7[iter_12_1].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_12_7[iter_12_1].fail:GetComponent("Image"):SetNativeSize()
		end

		if var_12_11 and var_12_11.state == 2 then
			for iter_12_2 = 1, 2 do
				var_12_14[iter_12_2].gameObject:SetActive(true)

				var_12_14[iter_12_2].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, self._now_map_level, iter_12_2))

				var_12_13[iter_12_2].gameObject:SetActive(false)
				var_12_7[iter_12_2 + 1].gameObject:SetActive(true)
			end

			for iter_12_3 = 1, 3 do
				var_12_7[iter_12_3].gameObject:SetActive(true)
				var_12_7[iter_12_3].fail.gameObject:SetActive(true)

				var_12_7[iter_12_3].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_12_7[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_12_0 + 3))
				else
					var_12_7[iter_12_3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_12_0 + iter_12_3))
				end

				var_12_7[iter_12_3].enemy.image.sprite = var_12_7[iter_12_3].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_12_0 + iter_12_3))
			end

			self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("challegeon")
		elseif var_12_11 and (var_12_11.state == 3 or var_12_11.state == 1) then
			for iter_12_4 = 1, #var_12_7 do
				var_12_7[iter_12_4].gameObject:SetActive(false)
				var_12_7[iter_12_4].fail.gameObject:SetActive(false)

				var_12_7[iter_12_4].points.user_num.text.text = 0
				var_12_7[iter_12_4].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))
			end

			var_12_7[1].gameObject:SetActive(true)

			var_12_7[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_12_5 = 1, 2 do
				var_12_14[iter_12_5].gameObject:SetActive(true)
				var_12_13[iter_12_5].gameObject:SetActive(true)
			end

			local var_12_15

			if #var_12_11.pass_token > 0 then
				var_12_15 = var_12_11.pass_token
			end

			if var_12_15 and #var_12_15 > 0 then
				for iter_12_6 = 1, #var_12_15 do
					var_12_7[iter_12_6].fail.gameObject:SetActive(true)

					if iter_12_6 < 3 then
						var_12_7[iter_12_6 + 1].gameObject:SetActive(true)
					end
				end

				for iter_12_7 = 1, #var_12_15 do
					self:_node_id(var_12_15[iter_12_7], arg_12_2)
				end
			end
		end

		for iter_12_8 = 1, #var_12_14 do
			var_12_14[iter_12_8]:GetComponent("Image"):SetNativeSize()
		end

		if var_12_11 and (var_12_11.pass_token ~= nil or var_12_11.pass_token ~= {}) then
			for iter_12_9, iter_12_10 in pairs(var_12_11.pass_token) do
				self:_get_token_now_map(var_12_8, #var_12_11.pass_token, iter_12_10)
			end
		end

		local var_12_16

		if self.now_map_level <= 10006 then
			var_12_16 = self.now_map_level % 10000
		else
			var_12_16 = self.now_map_level % 10000 % 6

			if self.now_map_level % 10000 % 6 == 0 then
				var_12_16 = 6
			end
		end

		local var_12_17 = self._first_level_id

		if arg_12_2 == self._first_level_id and var_12_11 and var_12_11.state == 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif arg_12_2 == var_12_17 and #self._six_all_map_info == 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif arg_12_2 == var_12_17 and #self._six_all_map_info > 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)
			self._can_move = true
		elseif var_12_17 < arg_12_2 and self._first_level_id + 5 > self.now_map_level and var_12_16 == #self._six_all_map_info then
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif var_12_17 < arg_12_2 and self._first_level_id + 5 > self.now_map_level and var_12_16 < #self._six_all_map_info then
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)
			self._can_move = true
		elseif arg_12_2 == self._first_level_id + 5 then
			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)

			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(false)

			self._can_move = true
		end

		self:_now_big_info(var_12_11)
	end

	function arg_1_0:_now_big_info(arg_13_1)
		self._control.main.right_menu.return_btn:SetActive(false)

		if self._now_attack.big_id == 0 then
			self._control.main.right_menu.return_btn:SetActive(false)

			if arg_13_1.state == 1 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("first_gotobattle")
			elseif arg_13_1.state == 2 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("reset_checkpoint")
			elseif arg_13_1.state == 3 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("already_reset")
			end
		else
			self._control.main.right_menu.ready_to_attack.text.text.text = arg_13_1.state == 2 and var_0_3:getNowLang("reset_checkpoint") or arg_13_1.state == 3 and arg_13_1.id == self.now_map_level and var_0_3:getNowLang("already_reset") or arg_13_1.state == 1 and arg_13_1.id == self.now_map_level and #arg_13_1.members == 0 and var_0_3:getNowLang("first_gotobattle") or arg_13_1.state == 1 and arg_13_1.id == self.now_map_level and #arg_13_1.members ~= 0 and var_0_3:getNowLang("challegeon") or arg_13_1.state == 3 and arg_13_1.id == self.now_map_level and #arg_13_1.pass_token < 3 and var_0_3:getNowLang("challegeon") or var_0_3:getNowLang("ui_4th_prepare")
		end

		if self._now_attack.big_id and self._now_attack.big_id ~= 0 and self._now_attack.ship_total and #self._now_attack.ship_total ~= 0 and self._now_attack.big_id == self.now_map_level then
			self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("challegeon")

			self._control.main.right_menu.return_btn:SetActive(true)
		end
	end

	function arg_1_0:_get_token_now_map(arg_14_1, arg_14_2, arg_14_3)
		for iter_14_0 = 1, arg_14_2 do
			if arg_14_1[iter_14_0] == arg_14_3.id then
				self._node_data[iter_14_0].points.user_num.text.text = arg_14_3.token
			end
		end
	end

	function arg_1_0:__set_level_map_node_prev_data(arg_15_1, arg_15_2)
		arg_15_2 = arg_15_2 - 1

		if arg_15_2 < self._first_level_id then
			return
		end

		local var_15_0 = 9300
		local var_15_1

		if self._now_index == 1 then
			var_15_1 = var_15_0 + arg_15_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_15_1 = var_15_0 + arg_15_2 % 10000 * 3
		end

		arg_15_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_15_2))

		local var_15_6 = self:__get_level_map_data_by_node(1, arg_15_2)
		local var_15_7 = self:__get_level_map_data_by_node(2, arg_15_2)
		local var_15_8 = self:__get_level_map_data_by_node(3, arg_15_2)
		local var_15_9 = self:__get_level_map_data_by_node(4, arg_15_2)
		local var_15_10 = {
			arg_15_1.enemy_group_one,
			arg_15_1.enemy_group_two,
			arg_15_1.enemy_group_three
		}

		self._node_prev_data = var_15_10

		local var_15_11 = {
			var_15_6.id,
			var_15_7.id,
			var_15_8.id
		}

		self._node_prev_data_id = var_15_11

		local var_15_12 = {
			var_15_6.boss_bg,
			var_15_7.boss_bg,
			var_15_8.boss_bg
		}

		for iter_15_0 = 1, #var_15_10 do
			var_15_10[iter_15_0].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_15_1 + iter_15_0))
			var_15_10[iter_15_0].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_15_12[iter_15_0]))
			var_15_10[iter_15_0].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_15_10[iter_15_0].fail:GetComponent("Image"):SetNativeSize()
		end

		local var_15_13 = var_0_5:find_prev_bigmap(arg_15_2)

		if not var_15_13 then
			return
		end

		local var_15_14 = {
			arg_15_1.point_one,
			arg_15_1.point_two
		}
		local var_15_15 = {
			arg_15_1.path_one,
			arg_15_1.path_two
		}

		for iter_15_1 = 1, #var_15_15 do
			var_15_15[iter_15_1]:GetComponent("Image"):SetNativeSize()
		end

		self._node_prev_path = var_15_15
		arg_15_1.enemy_group_one.points.max.text.text = var_15_6.total_score
		arg_15_1.enemy_group_two.points.max.text.text = var_15_7.total_score
		arg_15_1.enemy_group_three.points.max.text.text = var_15_8.total_score

		self:_bg_adaptive_prev(arg_15_1, var_15_6, var_15_7, var_15_8, var_15_9)

		arg_15_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_15_2, 1))
		arg_15_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_15_2, 2))

		arg_15_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_15_2, var_15_9, arg_15_1)

		if var_15_9 and var_0_5:get_now_have_sp() then
			arg_15_1.enemy_group_four.gameObject:SetActive(true)
			arg_15_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_15_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_15_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_15_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_15_1.enemy_group_four.gameObject:SetActive(false)
		end

		if var_15_13 and (var_15_13.state == 3 or var_15_13.state == 1) then
			for iter_15_2 = 1, #var_15_10 do
				var_15_10[iter_15_2].gameObject:SetActive(false)
				var_15_10[iter_15_2].fail.gameObject:SetActive(false)

				var_15_10[iter_15_2].points.user_num.text.text = 0
				var_15_10[iter_15_2].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))

				var_15_10[iter_15_2].enemy:GetComponent("Image"):SetNativeSize()
			end

			var_15_10[1].gameObject:SetActive(true)

			var_15_10[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_15_3 = 1, 2 do
				var_15_15[iter_15_3].gameObject:SetActive(true)
				var_15_14[iter_15_3].gameObject:SetActive(true)
			end

			local var_15_16

			if #var_15_13.pass_token > 0 then
				var_15_16 = var_15_13.pass_token
			end

			if var_15_16 and #var_15_16 > 0 then
				for iter_15_4 = 1, #var_15_16 do
					var_15_10[iter_15_4].fail.gameObject:SetActive(true)

					if iter_15_4 < 3 then
						var_15_10[iter_15_4 + 1].gameObject:SetActive(true)
					end
				end

				for iter_15_5 = 1, #var_15_16 do
					self:_node_prev_id(var_15_16[iter_15_5], arg_15_2)
				end
			end
		elseif var_15_13.state == 2 then
			for iter_15_6 = 1, 2 do
				var_15_15[iter_15_6].gameObject:SetActive(true)

				var_15_15[iter_15_6].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_15_2, iter_15_6))

				var_15_14[iter_15_6].gameObject:SetActive(false)
				var_15_10[iter_15_6 + 1].gameObject:SetActive(true)
			end

			for iter_15_7 = 1, 3 do
				var_15_10[iter_15_7].fail.gameObject:SetActive(true)

				var_15_10[iter_15_7].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_15_10[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_15_1 + 3))
				else
					var_15_10[iter_15_7].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_15_1 + iter_15_7))
				end

				var_15_10[iter_15_7].enemy.image.sprite = var_15_10[iter_15_7].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_15_1 + iter_15_7))

				var_15_10[iter_15_7].enemy:GetComponent("Image"):SetNativeSize()
			end
		end

		for iter_15_8 = 1, #var_15_15 do
			var_15_15[iter_15_8]:GetComponent("Image"):SetNativeSize()
		end

		if var_15_13.pass_token then
			for iter_15_9, iter_15_10 in pairs(var_15_13.pass_token) do
				self:_get_prev_token_now_map(var_15_11, #var_15_13.pass_token, iter_15_10)
			end
		end
	end

	function arg_1_0:_get_prev_token_now_map(arg_16_1, arg_16_2, arg_16_3)
		for iter_16_0 = 1, arg_16_2 do
			if arg_16_1[iter_16_0] == arg_16_3.id then
				self._node_prev_data[iter_16_0].points.user_num.text.text = arg_16_3.token
			end
		end
	end

	function arg_1_0:__set_level_map_node_next_data(arg_17_1, arg_17_2)
		arg_17_2 = arg_17_2 + 1

		local var_17_0 = var_0_5:find_now_bigmap(arg_17_2)

		if not var_17_0 or arg_17_2 > self._first_level_id + 5 then
			return
		end

		local var_17_1 = 9300
		local var_17_2

		if self._now_index == 1 then
			var_17_2 = var_17_1 + arg_17_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_17_2 = var_17_1 + arg_17_2 % 10000 * 3
		end

		arg_17_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_17_2))

		local var_17_4 = self:__get_level_map_data_by_node(1, arg_17_2)
		local var_17_5 = self:__get_level_map_data_by_node(2, arg_17_2)
		local var_17_6 = self:__get_level_map_data_by_node(3, arg_17_2)
		local var_17_7 = self:__get_level_map_data_by_node(4, arg_17_2)
		local var_17_8 = {
			arg_17_1.enemy_group_one,
			arg_17_1.enemy_group_two,
			arg_17_1.enemy_group_three
		}

		self._node_next_data = var_17_8

		local var_17_9 = {
			var_17_4.id,
			(nil).id,
			(nil).id
		}
		local var_17_10 = {
			var_17_4.boss_bg,
			(nil).boss_bg,
			(nil).boss_bg
		}

		self._node_next_data_id = var_17_9

		local var_17_11 = {
			arg_17_1.point_one,
			arg_17_1.point_two
		}
		local var_17_12 = {
			arg_17_1.path_one,
			arg_17_1.path_two
		}

		self._node_next_path = var_17_12
		arg_17_1.enemy_group_one.points.max.text.text = var_17_4.total_score
		arg_17_1.enemy_group_two.points.max.text.text = (nil).total_score
		arg_17_1.enemy_group_three.points.max.text.text = (nil).total_score

		self:_bg_adaptive_next(arg_17_1, var_17_4, nil, nil, nil)

		arg_17_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_17_2, 1))
		arg_17_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_17_2, 2))

		arg_17_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_17_2, nil, arg_17_1)

		if nil and var_0_5:get_now_have_sp() then
			arg_17_1.enemy_group_four.gameObject:SetActive(true)
			arg_17_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_17_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_17_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_17_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_17_1.enemy_group_four.gameObject:SetActive(false)
		end

		for iter_17_0 = 1, #var_17_8 do
			var_17_8[iter_17_0].gameObject:SetActive(false)
			var_17_8[iter_17_0].fail.gameObject:SetActive(false)

			var_17_8[iter_17_0].points.user_num.text.text = 0
			var_17_8[iter_17_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))
			var_17_8[iter_17_0].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_17_2 + iter_17_0))

			var_17_8[iter_17_0].enemy:GetComponent("Image"):SetNativeSize()

			var_17_8[iter_17_0].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_17_10[iter_17_0]))
			var_17_8[iter_17_0].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_17_8[iter_17_0].fail:GetComponent("Image"):SetNativeSize()
		end

		if var_17_0 and (var_17_0.state == 3 or var_17_0.state == 1) then
			for iter_17_1 = 1, #var_17_8 do
				var_17_8[iter_17_1].gameObject:SetActive(false)
				var_17_8[iter_17_1].fail.gameObject:SetActive(false)

				var_17_8[iter_17_1].points.user_num.text.text = 0
				var_17_8[iter_17_1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))

				var_17_8[iter_17_1].enemy:GetComponent("Image"):SetNativeSize()
			end

			var_17_8[1].gameObject:SetActive(true)

			var_17_8[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_17_2 = 1, 2 do
				var_17_12[iter_17_2].gameObject:SetActive(true)
				var_17_11[iter_17_2].gameObject:SetActive(true)
			end

			local var_17_13

			if #var_17_0.pass_token > 0 then
				var_17_13 = var_17_0.pass_token
			end

			if var_17_13 and #var_17_13 > 0 then
				for iter_17_3 = 1, #var_17_13 do
					var_17_8[iter_17_3].fail.gameObject:SetActive(true)

					if iter_17_3 < 3 then
						var_17_8[iter_17_3 + 1].gameObject:SetActive(true)
					end
				end

				for iter_17_4 = 1, #var_17_13 do
					self:_node_next_id(var_17_13[iter_17_4], arg_17_2)
				end
			end
		elseif var_17_0.state == 2 then
			for iter_17_5 = 1, 2 do
				var_17_12[iter_17_5].gameObject:SetActive(true)

				var_17_12[iter_17_5].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_17_2, iter_17_5))

				var_17_11[iter_17_5].gameObject:SetActive(false)
				var_17_8[iter_17_5 + 1].gameObject:SetActive(true)
			end

			for iter_17_6 = 1, 3 do
				var_17_8[iter_17_6].gameObject:SetActive(true)
				var_17_8[iter_17_6].fail.gameObject:SetActive(true)

				var_17_8[iter_17_6].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_17_8[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_17_2 + 3))
				else
					var_17_8[iter_17_6].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_17_2 + iter_17_6))
				end

				var_17_8[iter_17_6].enemy.image.sprite = var_17_8[iter_17_6].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_17_2 + iter_17_6))

				var_17_8[iter_17_6].enemy:GetComponent("Image"):SetNativeSize()
			end
		end

		for iter_17_7 = 1, #var_17_12 do
			var_17_12[iter_17_7]:GetComponent("Image"):SetNativeSize()
		end

		if var_17_0.pass_token then
			for iter_17_8, iter_17_9 in pairs(var_17_0.pass_token) do
				self:_get_next_token_now_map(var_17_9, #var_17_0.pass_token, iter_17_9, var_17_8)
			end
		end
	end

	function arg_1_0._get_next_token_now_map(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		for iter_18_0 = 1, arg_18_2 do
			if arg_18_1[iter_18_0] == arg_18_3.id then
				arg_18_4[iter_18_0].points.user_num.text.text = arg_18_3.token
			end
		end
	end

	function arg_1_0:_node_id(arg_19_1)
		for iter_19_0 = 1, #self.node_data_id do
			if arg_19_1.id == self.node_data_id[iter_19_0] then
				self._node_data[iter_19_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_19_0 < #self.node_data_id then
					self._node_data[iter_19_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_path[iter_19_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, self._now_map_level, iter_19_0))
			end
		end
	end

	function arg_1_0:_node_prev_id(arg_20_1, arg_20_2)
		for iter_20_0 = 1, #self._node_prev_data_id do
			if arg_20_1.id == self._node_prev_data_id[iter_20_0] then
				self._node_prev_data[iter_20_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_20_0 < #self._node_prev_data_id then
					self._node_prev_data[iter_20_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_prev_path[iter_20_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_20_2, iter_20_0))
			end
		end
	end

	function arg_1_0:_node_next_id(arg_21_1, arg_21_2)
		for iter_21_0 = 1, #self._node_next_data_id do
			if arg_21_1.id == self._node_next_data_id[iter_21_0] then
				self._node_next_data[iter_21_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_21_0 < #self._node_next_data_id then
					self._node_next_data[iter_21_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_next_path[iter_21_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_21_2, iter_21_0))
			end
		end
	end

	function arg_1_0:__set_now_map_data(arg_22_1)
		if not arg_22_1 then
			log.print_r("有问题")

			return
		end

		self:__set_level_map_node_data(self._control.main.single_map_level_cell_2, self.now_map_level)
		self:__set_level_map_node_prev_data(self._control.main.single_map_level_cell_1, self.now_map_level)
		self:__set_level_map_node_next_data(self._control.main.single_map_level_cell_3, self.now_map_level)
		self._control.main.single_map_level_cell_1:SetActive(true)

		self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1280, 0)

		self._control.main.single_map_level_cell_2:SetActive(true)

		self._control.main.single_map_level_cell_2.transform.anchoredPosition = Vector2(0, 0)

		self._control.main.single_map_level_cell_3:SetActive(true)

		if var_0_19.width / var_0_19.height > 1.9 and var_0_19.width / var_0_19.height < 2.1 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1442, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1360, 0)
		elseif var_0_19.width / var_0_19.height > 2.16 and var_0_19.width / var_0_19.height < 2.17 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1421, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1421, 0)
		elseif var_0_19.width / var_0_19.height > 2.22 and var_0_19.width / var_0_19.height < 2.23 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1460, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1460, 0)
		elseif var_0_19.width / var_0_19.height > 2.14 and var_0_19.width / var_0_19.height < 2.15 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1460, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1460, 0)
		else
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1420, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1420, 0)
		end

		if self.six_info.ticket < 12 then
			self._control.main.cd_time.bg.next_word.gameObject:SetActive(true)
			self._control.main.cd_time.bg.cd_times.gameObject:SetActive(true)
			self._control.main.cd_time.bg.full.gameObject:SetActive(false)
		end
	end

	function arg_1_0:__set_now_main_interface(arg_23_1)
		local var_23_0 = self:__get_level_map_data_by_node(1, arg_23_1)
		local var_23_1 = self:__get_level_map_data_by_node(2, arg_23_1)
		local var_23_2 = self:__get_level_map_data_by_node(3, arg_23_1)
		local var_23_3 = self:__get_level_map_data_by_node(4, arg_23_1)

		self._control.main.tips.word.text.text = var_0_3:convert_rich_text(var_0_15.find_object_by_id(arg_23_1).tips, true)
		self._control.main.right_menu.checkpoint_group.checkpoints_name.text.text = var_23_0.sub_title
		self._control.main.right_menu.checkpoint_group.checkpoints.text.text = var_23_0.title
	end

	function arg_1_0:goto_small_map(arg_24_1, arg_24_2)
		local var_24_0 = var_0_5:find_prev_bigmap(self.now_map_level)
		local var_24_1 = var_0_5:get_sixth_combat_info()
		local var_24_2, var_24_3, var_24_4 = self:__get_sixth_member_count()
		local var_24_5 = var_0_5:get_bigmap_info()
		local var_24_6 = var_0_18.find_object_by_id(self.now_map_level)

		if var_24_6 and var_0_1(var_24_6.shipton_num) then
			if var_24_2 < var_24_6.shipton_num[1] or var_24_3 < var_24_6.shipton_num[2] or var_24_4 < var_24_6.shipton_num[3] then
				var_0_17:show(var_0_3:getNowLang("type_ship_not_enough"))

				return
			end
		end

		if var_0_6.dict_lenght(var_0_5:get_character_list()) >= var_0_5:get_use_info_data().max_ship then
			var_0_2:createInstance("msgbox"):showthird(nil, function()
				var_0_2:destroyInstance("msgbox")

				local var_25_0 = var_0_2:getInstance("dock")

				if var_25_0 then
					var_25_0:setVisible(true)
					var_25_0:__onToggle_top_layer_toggle_control_disassemble()
				else
					local var_25_1 = var_0_2:createInstance("dock")

					var_25_1:show(true, "disassemble")
					var_25_1:set_enter_type("home")
					var_25_1:_now__play_bgm()
					var_25_1:__select_one("disassemble", true)
				end
			end, function()
				var_0_2:destroyInstance("msgbox")

				local var_26_0 = var_0_2:getInstance("remake")

				if var_0_2:getInstance("six_year_main_interface") then
					var_0_2:destroyInstance("six_year_main_interface")
				end

				local var_26_1 = var_0_2:getInstance("home")

				if var_26_1 then
					var_26_1:_bgm_play()
				end

				if var_26_0 then
					var_26_0:setVisible(true)
				else
					local var_26_2 = var_0_2:createInstance("remake")

					var_26_2:set_enter_type("home")
					var_26_2:show(true)
				end
			end, function()
				var_0_2:destroyInstance("msgbox")

				local var_27_0 = var_0_2:getInstance("home")

				if var_27_0 then
					var_27_0:_bgm_play()
				end

				local var_27_1 = var_0_2:getInstance("mall_shop")

				if var_27_1 then
					var_27_1:setVisible(true)
					var_27_1:__onToggle_top_layer_top_btn_btnthree()
				else
					var_0_2:createInstance("mall_shop"):show(var_0_4.mall_layer_type.layer_func, var_0_4.mall_enter_type.enter_home)
				end
			end, "", var_0_4.msg_type.ship_full, nil, true)

			return
		end

		if arg_24_1 == 1 then
			self.map_info = self:__get_level_map_data_by_node(1, arg_24_2)
		elseif arg_24_1 == 2 then
			self.map_info = self:__get_level_map_data_by_node(2, arg_24_2)
		elseif arg_24_1 == 3 then
			self.map_info = self:__get_level_map_data_by_node(3, arg_24_2)
		end

		if #var_24_0.pass_token > 0 then
			for iter_24_0, iter_24_1 in pairs(var_24_0.pass_token) do
				if iter_24_1.id == self.map_info.id then
					var_0_17:show(var_0_3:getNowLang("can_not_fight_clear"))

					return
				end
			end
		end

		if var_24_0.state == 2 then
			var_0_17:show(var_0_3:getNowLang("can_not_fight_clear"))
		elseif var_24_1.big_id ~= 0 and var_24_0.id ~= var_24_1.big_id then
			var_0_17:show(var_0_3:getNowLang("other_map_fighting"))
		elseif var_24_0.id == var_24_1.big_id and var_24_1.id ~= 0 and var_24_1.point ~= 0 then
			var_0_2:createInstance("sixth_map_node"):show({
				id = var_24_1.id
			})
		elseif var_24_0.id == var_24_1.big_id and #var_24_1.ship_total ~= 0 then
			var_0_5:req_EnterSixthMapReq(self.map_info.id)
		elseif #var_24_0.pass_token == 0 and #var_24_1.ship_total == 0 then
			var_0_2:createInstance("select_member"):show_by_type(var_0_4.enter_select_member_type.six_year_primary, nil, nil, self.map_info.id)
		end
	end

	function arg_1_0:__set_now_time_data(arg_28_1, arg_28_2, arg_28_3)
		self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.gameObject:SetActive(true)
		self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.gameObject:SetActive(true)
		self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.gameObject:SetActive(true)

		local var_28_0 = lx.Time:getGMTDateString()

		for iter_28_0, iter_28_1 in pairs(self.plot_node_list) do
			if iter_28_1.level_id == arg_28_1 then
				local var_28_1, var_28_2, var_28_3, var_28_4, var_28_5, var_28_6, var_28_7, var_28_8 = string.find(iter_28_1.start_time, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
				local var_28_9 = os.time({
					year = var_28_3,
					month = var_28_4,
					day = var_28_5,
					hour = var_28_6,
					min = var_28_7,
					sec = var_28_8
				})
				local var_28_10, var_28_11, var_28_12, var_28_13, var_28_14, var_28_15, var_28_16, var_28_17 = string.find(iter_28_1.end_time, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
				local var_28_18 = os.time({
					year = var_28_12,
					month = var_28_13,
					day = var_28_14,
					hour = var_28_15,
					min = var_28_16,
					sec = var_28_17
				})

				if var_28_9 > lx.ServerTime:getUtcTime() or var_28_18 < lx.ServerTime:getUtcTime() then
					var_0_5:set_now_have_sp(false)

					if arg_28_2 then
						arg_28_3.enemy_group_four.gameObject:SetActive(false)
					end
				end

				if var_28_9 < lx.ServerTime:getUtcTime() and var_28_18 > lx.ServerTime:getUtcTime() then
					var_0_5:set_now_have_sp(true)

					if arg_28_2 then
						arg_28_3.enemy_group_four.gameObject:SetActive(true)
					end

					local var_28_19 = var_28_18 - lx.ServerTime:getUtcTime()

					self._control.main.single_map_level_cell_2.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
					self._control.main.single_map_level_cell_2.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))

					if var_28_19 >= 86400 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), (math.floor(var_28_19 / 86400)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), math.floor(var_28_19 / 86400))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), math.floor(var_28_19 / 86400))
					elseif var_28_19 < 86400 and var_28_19 >= 3600 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_28_19 / 3600)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_28_19 / 3600)))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_28_19 / 3600)))
					elseif var_28_19 < 3600 and var_28_19 >= 60 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_28_19 / 60)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_28_19 / 60)))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_28_19 / 60)))
					elseif var_28_19 < 60 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_28_19)
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_28_19)
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_28_19)
					end
				end
			end
		end
	end

	function arg_1_0:__plot_node_enter_event(arg_29_1)
		if var_0_5:get_sixth_combat_info().id ~= 0 then
			var_0_17:show(var_0_3:getNowLang("other_map_fighting"))

			return
		end

		self.teams = {}

		local var_29_0 = self:__get_level_map_data_by_node(4, arg_29_1)
		local var_29_1 = var_0_2:createInstance("fight_info")
		local var_29_3 = var_0_12.find_object_by_id(var_29_0.init_node_id).self_formation

		for iter_29_0, iter_29_1 in pairs((#var_29_3 ~= 0 or nil) and var_0_9.find_object_by_id(var_29_3).formation) do
			local var_29_4 = var_0_10.find_object_by_id(iter_29_1)

			var_0_13(self.teams, {
				data = var_29_4,
				config = var_29_4
			})
		end

		local var_29_5 = tostring(var_29_0.map_id)
		local var_29_6 = self.teams and var_0_6.little_clone(self.teams) or {}

		var_0_5:set_back_type()
		var_29_1:show({
			fight_type = var_0_4.fight_type.event_story,
			id = var_29_0.id,
			map_id = string.sub(var_29_5, 1, #var_29_5 - 2),
			team_detail_data = var_29_6,
			start_node_id = var_29_0.init_node_id
		})
		self:setVisible(false)
	end

	function arg_1_0:__set_instructions_info(arg_30_1)
		local var_30_0 = var_0_16.find_object_by_guide_id(9300 + arg_30_1)

		self._control.instructions.page.page_1.text.text = arg_30_1

		if arg_30_1 == self._page_first then
			self._control.instructions.prev.gameObject:SetActive(false)
		else
			self._control.instructions.prev.gameObject:SetActive(true)
		end

		if arg_30_1 == self._page_end then
			self._control.instructions.next.gameObject:SetActive(false)
		else
			self._control.instructions.next.gameObject:SetActive(true)
		end

		local var_30_1 = app:getSystem():getChannel()

		self._control.instructions.main.main_tip.main_pic.image.sprite = (var_30_1 == "hm_android_jp" or var_30_1 == "hm_ios_jp") and self:loadSprite(var_0_7(var_0_4.instructions_pic_jp, var_30_0.pic_id)) or self:loadSprite(var_0_7(var_0_4.instructions_pic, arg_30_1))
		self._control.instructions.main.main_tip.scrollview.content.tip_word.text.text = var_0_3:convert_rich_text(var_30_0.desc, true)
	end

	function arg_1_0:__init_panel()
		self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._now_active_expect.bgm), true)

		local var_31_0 = var_0_5:get_sixth_combat_info()

		self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_5:get_six_adjutant()

		self:reset_adjutant_state()

		self.turn_the_page = false
		self._user_data = var_0_5:get_use_info_data()
		self._max_ticket = 3
		self._residue_ticket = self._max_ticket - self.six_info.buy_count
		self._initial_ticket = self.six_info.ticket
		self._control.main.cd_time.bg.next_word.text.text = var_0_3:getNowLang("next_time_restore")
		self._control.main.cd_time.bg.full.text.text = var_0_3:getNowLang("disk_is_full")

		self._control.main.cd_time.gameObject:SetActive(false)
		self._control.main.cd_time.bg.next_word.gameObject:SetActive(true)
		self._control.main.cd_time.bg.cd_times.gameObject:SetActive(true)
		self._control.main.cd_time.bg.full.gameObject:SetActive(false)

		self._control.main.cd_time.canvasGroup.alpha = 1

		if self._initial_ticket >= 12 then
			self._control.main.cd_time.bg.next_word.gameObject:SetActive(false)
			self._control.main.cd_time.bg.cd_times.gameObject:SetActive(false)
			self._control.main.cd_time.bg.full.gameObject:SetActive(true)
		end

		local var_31_1 = {
			self._control.buy_tickets.main.get_res.exchange_1,
			self._control.buy_tickets.main.get_res.exchange_2,
			self._control.buy_tickets.main.get_res.exchange_3,
			self._control.buy_tickets.main.get_res.exchange_4
		}

		self._content = var_31_1
		self._control.buy_tickets.main.get_res.times.have.text.text = self._max_ticket - self.six_info.buy_count
		self._control.main.right_menu.tickets.have_ticket.text.text = self.six_info.ticket

		self._control.buy_tickets.gameObject:SetActive(false)

		self._control.instructions.main.title.text.text = var_0_3:getNowLang("activityinstruction")
		self._control.msgbox.main.title.text.text = var_0_3:getNowLang("logget")
		self._control.msgbox.main.one.text.text.text = var_0_3:getNowLang("ui_cbtn1")
		self._control.main.top.title.text.text = self._now_active_expect.title

		self._control.main.top.plot.gameObject:SetActive(false)

		if self._now_movie_id and self._now_movie_id ~= 0 then
			self._control.main.top.plot.gameObject:SetActive(true)
		end

		local var_31_2 = app:getSystem():getChannel()

		if var_31_2 == "hm_android_jp" or var_31_2 == "hm_ios_jp" then
			for iter_31_0 = 1, #var_31_1 do
				var_31_1[iter_31_0].word_1:SetActive(false)

				var_31_1[iter_31_0].word_2.text.text = "="
				var_31_1[iter_31_0].word_3.text.text = var_0_3:getNowLang("zhang")
				var_31_1[iter_31_0].btn.text.text.text = var_0_3:getNowLang("exchange")
			end

			var_31_1[1].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_31_1[2].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_31_1[3].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_31_1[4].resources.transform.anchoredPosition = Vector2(297.2, -31.38)
			var_31_1[1].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_31_1[2].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_31_1[3].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_31_1[4].word_2.transform.anchoredPosition = Vector2(383.9, -31.38)
			var_31_1[1].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_31_1[2].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_31_1[3].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_31_1[4].num.transform.anchoredPosition = Vector2(397, -31.38)
			var_31_1[1].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_31_1[2].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_31_1[3].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_31_1[4].word_3.transform.anchoredPosition = Vector2(424.2, -31.38)
			var_31_1[1].resources.text.text = var_0_3:getNowLang("six_ticket_num_one")
			var_31_1[2].resources.text.text = var_0_3:getNowLang("six_ticket_num_two")
			var_31_1[3].resources.text.text = var_0_3:getNowLang("six_ticket_num_three")
			var_31_1[4].resources.text.text = var_0_3:getNowLang("six_ticket_num_four")
			self._control.buy_tickets.main.get_res.times.word.transform.anchoredPosition = Vector2(-30, -10)
		else
			for iter_31_1 = 1, #var_31_1 do
				var_31_1[iter_31_1].word_2.text.text = var_0_3:getNowLang("exchange")
				var_31_1[iter_31_1].word_3.text.text = var_0_3:getNowLang("zhang")
				var_31_1[iter_31_1].btn.text.text.text = var_0_3:getNowLang("exchange")
			end

			var_31_1[1].resources.text.text = var_0_3:getNowLang("six_ticket_num_one")
			var_31_1[2].resources.text.text = var_0_3:getNowLang("six_ticket_num_two")
			var_31_1[3].resources.text.text = var_0_3:getNowLang("six_ticket_num_three")
			var_31_1[4].resources.text.text = var_0_3:getNowLang("six_ticket_num_four")
		end

		var_31_1[1].number_1.text.text = var_0_6.get_simplify_num(self._user_data.oil)
		var_31_1[2].number_1.text.text = var_0_6.get_simplify_num(self._user_data.bullet)
		var_31_1[3].number_1.text.text = var_0_6.get_simplify_num(self._user_data.fe)
		var_31_1[4].number_1.text.text = var_0_6.get_simplify_num(self._user_data.al)
		self._now_res_oil = self._user_data.oil
		self._now_res_buttet = self._user_data.bullet
		self._now_res_fe = self._user_data.fe
		self._now_res_al = self._user_data.al
		self._control.buy_tickets.main.close.text.text.text = var_0_3:getNowLang("marketingloginclose")
		self._control.buy_tickets.main.get_res.times.word.text.text = var_0_3:getNowLang("week_times_exchange")
		self._control.main.right_menu.next.text.text.text = var_0_3:getNowLang("next")
		self._control.main.right_menu.prev.text.text.text = var_0_3:getNowLang("prev")
		self._control.instructions.prev.text.text.text = var_0_3:getNowLang("ui_new_guide_last")
		self._control.instructions.next.text.text.text = var_0_3:getNowLang("ui_new_guide_next")

		self:__set_node_data_list_by_sort_or_type()
		self:__set_now_map_data(self.now_map_level)
		self:__set_now_main_interface(self.now_map_level)

		self._page_first = 1
		self._page_end = 0

		local var_31_3, var_31_4 = var_0_16:get_sequence()

		for iter_31_2 = 1, var_31_4 do
			if var_0_16.find_object_by_guide_id(9300 + iter_31_2) then
				self._page_end = self._page_end + 1
			else
				break
			end
		end

		self._page_move = self._page_first

		local var_31_5 = app:getSystem():getChannel()

		if var_31_5 == "hm_android_jp" or var_31_5 == "hm_ios_jp" then
			self._control.instructions.page.page_3:SetActive(false)
		else
			self._control.instructions.page.page_3.text.text = var_0_3:getNowLang("introduce_page")
		end

		self._control.instructions.page.page_1.text.text = self._page_first
		self._control.instructions.page.page_2.text.text = self._page_end

		self:__set_instructions_info(self._page_move)

		self._control.msgbox.main.reward.reward_name.text.text = var_0_3:getNowLang("disk")

		if self._residue_ticket == 0 then
			self:all_close()
			self:all_Openbtn2()
		else
			self:all_closebtn2()
		end
	end

	function arg_1_0:all_close()
		for iter_32_0 = 1, #self._content do
			self._content[iter_32_0].btn.image.sprite = self:loadSprite(var_0_7(var_0_4.exchange_btn, 42))
			self._content[iter_32_0].btn.scaleButton.interactable = false
		end

		self._is_exchange_all = true
	end

	function arg_1_0:all_Openbtn2()
		for iter_33_0 = 1, #self._content do
			self._content[iter_33_0].btn2.gameObject:SetActive(true)
		end
	end

	function arg_1_0:all_closebtn2()
		for iter_34_0 = 1, #self._content do
			self._content[iter_34_0].btn2.gameObject:SetActive(false)
		end
	end

	function arg_1_0:time_countdown()
		self:_next_buy_time()

		self._control.main.cd_time.bg.cd_times.text.text = self._next_h .. ":" .. self._next_m .. ":" .. self._next_s

		if self._control.main.cd_time.canvasGroup ~= 0 and self._control.main.cd_time.activeSelf then
			return
		end

		self._control.main.cd_time.gameObject:SetActive(true)

		self.cd_time_seq = self:autoKillDOTween(var_0_8.Sequence())

		self.cd_time_seq:AppendInterval(3)
		self.cd_time_seq:Append(self._control.main.cd_time.canvasGroup:DOFade(0, 2))
		self.cd_time_seq:AppendCallback(function()
			self._control.main.cd_time.gameObject:SetActive(false)
			self.cd_time_seq:Append(self._control.main.cd_time.canvasGroup:DOFade(1, 0))
		end)
		self.cd_time_seq:SetLoops(1)
		self.cd_time_seq:Play()
	end

	function arg_1_0:_next_buy_time()
		local var_37_0 = 172800 - lx.ServerTime:getUtcTime() + self.six_info.last_recover_time

		self._next_h = math.floor(var_37_0 / 3600)
		self._next_m = math.floor((var_37_0 - self._next_h * 3600) / 60)
		self._next_s = math.floor(var_37_0 - self._next_h * 3600 - self._next_m * 60)

		if self._next_h < 10 then
			self._next_h = "0" .. var_0_7(self._next_h)
		end

		if self._next_m < 10 then
			self._next_m = "0" .. var_0_7(self._next_m)
		end

		if self._next_s < 10 then
			self._next_s = "0" .. var_0_7(self._next_s)
		end
	end

	function arg_1_0:_now_add_ticket_time()
		self:_next_buy_time()

		self._control.main.cd_time.bg.cd_times.text.text = self._next_h .. ":" .. self._next_m .. ":" .. self._next_s
	end

	function arg_1_0:_play_audio(arg_39_1, arg_39_2)
		self:playBackgroundMusic(arg_39_1, arg_39_2)
	end

	function arg_1_0:_play_into_se(arg_40_1)
		self:playSE(arg_40_1, false)
	end

	function arg_1_0:__init_show_instructions_view()
		self._control.instructions.gameObject:SetActive(var_0_5:get_instructions_guide_state())
	end

	function arg_1_0:__continue_last_map()
		local var_42_0 = var_0_5:get_sixth_combat_info()
		local var_42_1 = var_0_11.find_object_by_id(var_42_0.id or 0)

		if var_42_1 and var_42_0.point ~= var_42_1.init_node_id then
			self:__onClick_main_right_menu_ready_to_attack()
		end
	end

	function arg_1_0.__onReset(arg_43_0)
		arg_1_0._user_data = {}
		arg_1_0.six_info = {}
		arg_1_0._content = {}
		arg_1_0._is_exchange_all = false
		arg_1_0._initial_ticket = nil
		arg_1_0.adjutant = nil
		arg_1_0.now_map_level = nil
		arg_1_0._now_map_id = nil
		arg_1_0.cd_time_seq = nil
		arg_1_0._bigmap_info = {}
		arg_1_0.frist_node_list = {}
		arg_1_0.second_node_list = {}
		arg_1_0.third_node_list = {}
		arg_1_0.plot_node_list = {}
		arg_1_0.turn_the_page = false
		arg_1_0._six_into_map_info = {}
		arg_1_0._node_chapter = nil
		arg_1_0.map_info = {}
		arg_1_0.node_data_id = {}
		arg_1_0._node_prev_data_id = {}
		arg_1_0._node_next_data_id = {}
		arg_1_0._node_data = {}
		arg_1_0._node_prev_data = {}
		arg_1_0._node_next_data = {}
		arg_1_0._node_path = {}
		arg_1_0._node_prev_path = {}
		arg_1_0._node_next_path = {}
		arg_1_0._now_bigmap_info = nil
		arg_1_0._six_all_map_info = {}
		arg_1_0._can_move = false
		arg_1_0._now_map_info = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_44_0)
	local var_44_0 = var_0_2:class("six_year_main_interface")

	var_44_0._max_ticket = nil
	var_44_0._residue_ticket = nil
	var_44_0._user_data = {}
	var_44_0.six_info = {}
	var_44_0._content = {}
	var_44_0._is_exchange_all = false
	var_44_0._initial_ticket = nil
	var_44_0.adjutant = nil
	var_44_0._now_res_oil = nil
	var_44_0._now_res_buttet = nil
	var_44_0._now_res_fe = nil
	var_44_0._now_res_al = nil
	var_44_0.now_map_level = nil
	var_44_0._now_map_id = nil
	var_44_0.cd_time_seq = nil
	var_44_0._bigmap_info = {}
	var_44_0.frist_node_list = {}
	var_44_0.second_node_list = {}
	var_44_0.third_node_list = {}
	var_44_0.plot_node_list = {}
	var_44_0.turn_the_page = false
	var_44_0._six_into_map_info = {}
	var_44_0._node_chapter = nil
	var_44_0._next_h = nil
	var_44_0._next_m = nil
	var_44_0._next_s = nil
	var_44_0._page_first = nil
	var_44_0._page_end = nil
	var_44_0._page_move = nil
	var_44_0.map_info = {}
	var_44_0._adjutant_set = nil
	var_44_0._adjutant_cid = nil
	var_44_0._current_adjutant_index = nil
	var_44_0._adjutant_config = nil
	var_44_0.node_data_id = {}
	var_44_0._node_prev_data_id = {}
	var_44_0._node_next_data_id = {}
	var_44_0._node_data = {}
	var_44_0._node_prev_data = {}
	var_44_0._node_next_data = {}
	var_44_0._node_path = {}
	var_44_0._node_prev_path = {}
	var_44_0._node_next_path = {}
	var_44_0._now_bigmap_info = nil
	var_44_0._six_all_map_info = {}
	var_44_0._can_move = false
	var_44_0._now_map_info = {}
	var_44_0._active_info = {}
	var_44_0._first_map_id = nil
	var_44_0._now_index = nil
	var_44_0._now_active_expect = nil
	var_44_0._now_into_plot = nil

	gamecore.extend_obj(var_44_0)

	return var_44_0
end

return var_0_0
