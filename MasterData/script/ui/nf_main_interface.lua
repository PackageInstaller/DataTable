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
local var_0_11 = table.insert
local var_0_12 = gameconfig.sixth_adjutant_config
local var_0_13 = gameconfig.pve_guide_config
local var_0_14 = gamecore.prompt
local var_0_15 = UnityEngine.Screen
local var_0_16 = gameconfig.ship_pve_active_config
local var_0_18 = gameconfig.pve_mist_level_config
local var_0_19 = gameconfig.pve_mist_level_node_config
local var_0_20 = gameconfig.pve_mist_chapter_config
local var_0_22 = gameconfig.pve_mist_award_config

gamecore.UILoader:define("nf_main_interface", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		var_0_5:set_select_into_nf(true)

		self._now_into_plot = arg_2_1
		self._active_info = {
			var_0_4.all_nf_active.nf_battle_sea_one
		}

		self:setVisible(true)
		self:updata_info()
		self:__init_panel()
		self:__init_show_instructions_view()
		self:__destroy_home_live2d()
	end

	function arg_1_0:__onUpdate()
		self:_now_add_ticket_time()
	end

	function arg_1_0.__destroy_home_live2d(arg_4_0)
		local var_4_0 = var_0_2:getInstance("home")

		if var_4_0 then
			var_4_0:destroy_live2d()
		end
	end

	function arg_1_0.now_active_id(arg_5_0, arg_5_1)
		local var_5_0 = var_0_16.get_sequence()

		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			if var_0_16.find_object_by_id(iter_5_1) then
				arg_5_0._now_index = iter_5_0

				return (var_0_16.find_object_by_id(iter_5_1))
			end
		end
	end

	function arg_1_0:updata_info()
		self.nf_info = var_0_5:get_mist_info()

		local var_6_0 = {}

		for iter_6_0, iter_6_1 in pairs((var_0_5:get_mist_bigmap_info())) do
			var_0_11(var_6_0, iter_6_1)
		end

		local var_6_1 = var_0_5:get_mist_combat_info()

		self._now_attack = var_6_1

		self._control.main.top.shop.point:SetActive((self:can_get_award()))

		local var_6_2 = self:now_active_id(self._active_info)

		if var_6_2.movie_group_id and var_6_2.movie_group_id ~= 0 then
			self._now_movie_id = var_6_2.movie_group_id
		end

		self._now_active_expect = var_6_2

		var_0_5:set_mist_bgm(self._now_active_expect.bgm)

		self._first_map_id = var_6_2.map_id
		self._first_level_id = var_0_18.find_object_by_id(var_6_2.map_id).level_id
		self._last_level_id = var_0_18.find_object_by_id(var_6_2.levels[#var_6_2.levels]).level_id
		self._nf_all_map_info = var_6_0

		var_0_5:set_mist_user_money(self.nf_info.token)

		if self._now_into_plot then
			self.now_map_level = self._now_into_plot

			return
		end

		if #self._nf_all_map_info == 1 then
			self.now_map_level = var_0_18.find_object_by_id(var_6_2.map_id).level_id
		elseif #self._nf_all_map_info > 1 then
			local var_6_5 = 0

			for iter_6_2, iter_6_3 in pairs(self._nf_all_map_info) do
				if iter_6_3.state > 1 then
					var_6_5 = var_6_5 + 1
				end
			end

			for iter_6_4, iter_6_5 in pairs(self._nf_all_map_info) do
				if iter_6_5.state == 1 then
					-- block empty
				end
			end

			self.now_map_level = var_6_1 and var_6_1.big_id and var_6_1.big_id ~= 0 and var_0_1(var_6_1.ship_total) and var_6_1.big_id or not var_6_1.big_id and var_0_18.find_object_by_id(var_6_2.map_id).level_id - 1 + var_6_5 or var_0_18.find_object_by_id(var_6_2.map_id).level_id - 1 + var_6_5
		else
			self.now_map_level = var_0_18.find_object_by_id(var_6_2.map_id).level_id
		end

		for iter_6_6, iter_6_7 in pairs(self._nf_all_map_info) do
			if var_0_5:get_mist_repeat_map_id() then
				local var_6_9 = var_0_5:get_mist_repeat_map_id()

				if iter_6_7.id == var_6_9 and (iter_6_7.state == 2 or iter_6_7.state == 3) then
					self.now_map_level = var_6_9
				end
			end
		end

		if var_6_1 and var_6_1.big_id and var_6_1.big_id ~= 0 then
			self.now_map_level = var_6_1.big_id

			return
		end

		local var_6_10 = self.now_map_level + 1

		for iter_6_8, iter_6_9 in ipairs(self._nf_all_map_info) do
			if iter_6_9.state == 1 and var_6_10 == iter_6_9.id then
				self.now_map_level = var_6_10
			end
		end
	end

	function arg_1_0:can_get_award()
		local var_7_0 = var_0_5:get_mist_award_data()
		local var_7_1, var_7_2 = var_0_22.get_sequence()
		local var_7_3 = false
		local var_7_4 = {}

		for iter_7_0, iter_7_1 in pairs(var_7_1) do
			var_0_11(var_7_4, iter_7_1)
		end

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			for iter_7_4 = #var_7_4, 1, -1 do
				if iter_7_3 == var_7_4[iter_7_4].id then
					table.remove(var_7_4, iter_7_4)
				end
			end
		end

		for iter_7_5, iter_7_6 in pairs(var_7_4) do
			if self.nf_info.pass_score >= iter_7_6.score then
				var_7_3 = true

				break
			end
		end

		return (#var_7_1 == #var_7_0 or nil) and false
	end

	function arg_1_0:reset_adjutant_state()
		self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_5:get_mist_adjutant()
		self._adjutant_config = var_0_12.find_object_by_id(self._adjutant_set[self._current_adjutant_index])
		self._control.main.aide.image.sprite = self:loadSprite((var_0_7(var_0_4.sixth_adjutant_image, self._adjutant_config.id)))

		self._control.main.aide.image:SetNativeSize()
	end

	function arg_1_0:__set_node_data_list_by_sort_or_type()
		self.frist_node_list = {}
		self.second_node_list = {}
		self.third_node_list = {}
		self.plot_node_list = {}

		local var_9_0, var_9_1 = var_0_18.get_sequence()
		local var_9_2 = {}

		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			if iter_9_1.id >= self._first_map_id then
				var_0_11(var_9_2, iter_9_1)
			end
		end

		for iter_9_2, iter_9_3 in pairs(var_9_2) do
			if iter_9_3.sort == 1 then
				var_0_11(self.frist_node_list, iter_9_3)
			elseif iter_9_3.sort == 2 then
				var_0_11(self.second_node_list, iter_9_3)
			elseif iter_9_3.sort == 3 then
				var_0_11(self.third_node_list, iter_9_3)
			end

			if iter_9_3.type == 3 then
				var_0_11(self.plot_node_list, iter_9_3)
			end
		end
	end

	function arg_1_0:__get_level_map_data_by_node(arg_10_1, arg_10_2)
		local var_10_0

		if arg_10_1 == 1 then
			var_10_0 = self.frist_node_list
		elseif arg_10_1 == 2 then
			var_10_0 = self.second_node_list
		elseif arg_10_1 == 3 then
			var_10_0 = self.third_node_list
		elseif arg_10_1 == 4 then
			var_10_0 = self.plot_node_list
		end

		for iter_10_0, iter_10_1 in pairs(var_10_0) do
			if iter_10_1.level_id == arg_10_2 then
				return iter_10_1
			end
		end
	end

	function arg_1_0._bg_adaptive_now(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
		if var_0_15.width / var_0_15.height > 1.3 and var_0_15.width / var_0_15.height < 1.4 then
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
		elseif var_0_15.width / var_0_15.height == 1.6 then
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
		elseif var_0_15.width / var_0_15.height > 2.16 and var_0_15.width / var_0_15.height < 2.17 then
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
		elseif var_0_15.width / var_0_15.height > 2.14 and var_0_15.width / var_0_15.height < 2.15 then
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
		elseif var_0_15.width / var_0_15.height > 1.7 then
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
		elseif var_0_15.width / var_0_15.height > 1.5 and var_0_15.width / var_0_15.height < 1.51 then
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
		elseif var_0_15.width / var_0_15.height > 1.43 and var_0_15.width / var_0_15.height < 1.45 then
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

	function arg_1_0._bg_adaptive_prev(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
		if var_0_15.width / var_0_15.height > 1.3 and var_0_15.width / var_0_15.height < 1.4 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 120)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 120)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 120)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 120)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 120)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 120)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 120)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 120)
			end
		elseif var_0_15.width / var_0_15.height == 1.6 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 200)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 200)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 200)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 200)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 200)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 200)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 200)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 200)
			end
		elseif var_0_15.width / var_0_15.height > 2.16 and var_0_15.width / var_0_15.height < 2.17 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 245)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 245)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 245)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 245)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 245)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 245)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 245)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 245)
			end
		elseif var_0_15.width / var_0_15.height > 1.7 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 240)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 240)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 240)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 240)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 240)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 240)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 240)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 240)
			end
		elseif var_0_15.width / var_0_15.height > 1.5 and var_0_15.width / var_0_15.height < 1.51 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 170)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 170)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 170)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 170)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 170)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 170)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 170)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 170)
			end
		elseif var_0_15.width / var_0_15.height > 1.43 and var_0_15.width / var_0_15.height < 1.45 then
			arg_12_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_12_2.position.x - 640, -arg_12_2.position.y + 160)
			arg_12_1.point_one.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 160)
			arg_12_1.point_two.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 160)
			arg_12_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_12_3.position.x - 640, -arg_12_3.position.y + 160)
			arg_12_1.path_one.transform.anchoredPosition = Vector2(arg_12_3.line_position[1].x - 640, -arg_12_3.line_position[1].y + 160)
			arg_12_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_12_4.position.x - 640, -arg_12_4.position.y + 160)
			arg_12_1.path_two.transform.anchoredPosition = Vector2(arg_12_4.line_position[1].x - 640, -arg_12_4.line_position[1].y + 160)

			if arg_12_5 then
				arg_12_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_12_5.position.x - 640, -arg_12_5.position.y + 160)
			end
		end
	end

	function arg_1_0._bg_adaptive_next(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
		if var_0_15.width / var_0_15.height > 1.3 and var_0_15.width / var_0_15.height < 1.4 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 120)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 120)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 120)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 120)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 120)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 120)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 120)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 120)
			end
		elseif var_0_15.width / var_0_15.height == 1.6 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 200)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 200)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 200)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 200)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 200)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 200)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 200)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 200)
			end
		elseif var_0_15.width / var_0_15.height > 2.16 and var_0_15.width / var_0_15.height < 2.17 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 245)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 245)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 245)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 245)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 245)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 245)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 245)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 245)
			end
		elseif var_0_15.width / var_0_15.height > 2.14 and var_0_15.width / var_0_15.height < 2.15 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 240)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 240)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 240)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 240)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 240)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 240)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 240)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 240)
			end
		elseif var_0_15.width / var_0_15.height > 1.7 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 240)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 240)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 240)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 240)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 240)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 240)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 240)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 240)
			end
		elseif var_0_15.width / var_0_15.height > 1.5 and var_0_15.width / var_0_15.height < 1.51 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 170)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 170)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 170)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 170)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 170)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 170)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 170)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 170)
			end
		elseif var_0_15.width / var_0_15.height > 1.43 and var_0_15.width / var_0_15.height < 1.45 then
			arg_13_1.enemy_group_one.transform.anchoredPosition = Vector2(arg_13_2.position.x - 640, -arg_13_2.position.y + 160)
			arg_13_1.point_one.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 160)
			arg_13_1.point_two.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 160)
			arg_13_1.enemy_group_two.transform.anchoredPosition = Vector2(arg_13_3.position.x - 640, -arg_13_3.position.y + 160)
			arg_13_1.path_one.transform.anchoredPosition = Vector2(arg_13_3.line_position[1].x - 640, -arg_13_3.line_position[1].y + 160)
			arg_13_1.enemy_group_three.transform.anchoredPosition = Vector2(arg_13_4.position.x - 640, -arg_13_4.position.y + 160)
			arg_13_1.path_two.transform.anchoredPosition = Vector2(arg_13_4.line_position[1].x - 640, -arg_13_4.line_position[1].y + 160)

			if arg_13_5 then
				arg_13_1.enemy_group_four.transform.anchoredPosition = Vector2(arg_13_5.position.x - 640, -arg_13_5.position.y + 160)
			end
		end
	end

	function arg_1_0:__set_level_map_node_data(arg_14_1, arg_14_2)
		local var_14_0

		if self._now_index == 1 then
			var_14_0 = 9300 + arg_14_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_14_0 = 9300 + arg_14_2 % 10000 * 3
		end

		self._now_map_level = arg_14_2

		local var_14_1 = self:__get_level_map_data_by_node(1, arg_14_2)
		local var_14_3 = self:__get_level_map_data_by_node(2, arg_14_2)
		local var_14_4 = self:__get_level_map_data_by_node(3, arg_14_2)
		local var_14_5 = self:__get_level_map_data_by_node(4, arg_14_2)

		arg_14_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_14_2))

		local var_14_6 = {
			arg_14_1.enemy_group_one,
			arg_14_1.enemy_group_two,
			arg_14_1.enemy_group_three
		}

		self._node_data = var_14_6

		local var_14_7 = {
			var_14_1.id,
			(nil).id,
			(nil).id
		}
		local var_14_8 = {
			var_14_1.boss_bg,
			(nil).boss_bg,
			(nil).boss_bg
		}

		self.node_data_id = var_14_7

		local var_14_9 = var_0_5:get_mist_combat_info()
		local var_14_10 = var_0_5:find_mist_prev_bigmap(arg_14_2)

		self._now_map_info = var_14_10

		local var_14_11 = var_0_5:get_clear_map_info()
		local var_14_12 = {
			arg_14_1.point_one,
			arg_14_1.point_two
		}
		local var_14_13 = {
			arg_14_1.path_one,
			arg_14_1.path_two
		}

		for iter_14_0 = 1, #var_14_13 do
			var_14_13[iter_14_0]:GetComponent("Image"):SetNativeSize()
		end

		self._node_path = var_14_13
		arg_14_1.enemy_group_one.points.max.text.text = var_14_1.total_score
		arg_14_1.enemy_group_two.points.max.text.text = (nil).total_score
		arg_14_1.enemy_group_three.points.max.text.text = (nil).total_score
		UnityEngine.GameObject.Find("UICamera"):GetComponent(typeof(UnityEngine.Camera)).fieldOfView = 20 * (var_0_4.screen_ratio / (var_0_15.width / var_0_15.height > 1.5 and 1.7777777777777777 or var_0_15.width / var_0_15.height))

		self:_bg_adaptive_now(arg_14_1, var_14_1, nil, nil, nil)

		arg_14_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_14_2, 1))
		arg_14_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_14_2, 2))

		arg_14_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_14_2, nil, arg_14_1)

		if nil and var_0_5:get_now_have_sp() then
			arg_14_1.enemy_group_four.gameObject:SetActive(true)
			arg_14_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_14_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_14_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_14_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_14_1.enemy_group_four.gameObject:SetActive(false)
		end

		for iter_14_1 = 1, #var_14_6 do
			var_14_6[iter_14_1].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_14_0 + iter_14_1))
			var_14_6[iter_14_1].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_14_8[iter_14_1]))

			var_14_6[iter_14_1].enemy:GetComponent("Image"):SetNativeSize()

			var_14_6[iter_14_1].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_14_6[iter_14_1].fail:GetComponent("Image"):SetNativeSize()
		end

		if var_14_10 and var_14_10.state == 2 then
			for iter_14_2 = 1, 2 do
				var_14_13[iter_14_2].gameObject:SetActive(true)

				var_14_13[iter_14_2].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, self._now_map_level, iter_14_2))

				var_14_12[iter_14_2].gameObject:SetActive(false)
				var_14_6[iter_14_2 + 1].gameObject:SetActive(true)
			end

			for iter_14_3 = 1, 3 do
				var_14_6[iter_14_3].gameObject:SetActive(true)
				var_14_6[iter_14_3].fail.gameObject:SetActive(true)

				var_14_6[iter_14_3].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_14_6[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_14_0 + 3))
				else
					var_14_6[iter_14_3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_14_0 + iter_14_3))
				end

				var_14_6[iter_14_3].enemy.image.sprite = var_14_6[iter_14_3].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_14_0 + iter_14_3))
			end

			self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("challegeon")
		elseif var_14_10 and (var_14_10.state == 3 or var_14_10.state == 1) then
			for iter_14_4 = 1, #var_14_6 do
				var_14_6[iter_14_4].gameObject:SetActive(false)
				var_14_6[iter_14_4].fail.gameObject:SetActive(false)

				var_14_6[iter_14_4].points.user_num.text.text = 0
				var_14_6[iter_14_4].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))
			end

			var_14_6[1].gameObject:SetActive(true)

			var_14_6[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_14_5 = 1, 2 do
				var_14_13[iter_14_5].gameObject:SetActive(true)
				var_14_12[iter_14_5].gameObject:SetActive(true)
			end

			local var_14_14

			if #var_14_10.pass_token > 0 then
				var_14_14 = var_14_10.pass_token
			end

			if var_14_14 and #var_14_14 > 0 then
				for iter_14_6 = 1, #var_14_14 do
					var_14_6[iter_14_6].fail.gameObject:SetActive(true)

					if iter_14_6 < 3 then
						var_14_6[iter_14_6 + 1].gameObject:SetActive(true)
					end
				end

				for iter_14_7 = 1, #var_14_14 do
					self:_node_id(var_14_14[iter_14_7], arg_14_2)
				end
			end
		end

		for iter_14_8 = 1, #var_14_13 do
			var_14_13[iter_14_8]:GetComponent("Image"):SetNativeSize()
		end

		local var_14_15 = var_0_5:get_mist_map_info()

		for iter_14_9, iter_14_10 in pairs(var_14_7) do
			for iter_14_11, iter_14_12 in pairs(var_14_15) do
				if iter_14_12.state == 2 and iter_14_12.id == iter_14_10 then
					self._node_data[iter_14_9].points.user_num.text.text = iter_14_12.score_token
				end
			end
		end

		local var_14_16

		if self.now_map_level <= 10006 then
			var_14_16 = self.now_map_level % 10000
		else
			var_14_16 = self.now_map_level % 10000 % 6

			if self.now_map_level % 10000 % 6 == 0 then
				var_14_16 = 6
			end
		end

		local var_14_17 = self._first_level_id

		if arg_14_2 == self._first_level_id and var_14_10 and var_14_10.state == 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif arg_14_2 == var_14_17 and #self._nf_all_map_info == 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif arg_14_2 == var_14_17 and #self._nf_all_map_info > 1 then
			self._control.main.right_menu.prev:SetActive(false)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)
			self._can_move = true
		elseif var_14_17 < arg_14_2 and self._first_level_id + 2 > self.now_map_level and var_14_16 == #self._nf_all_map_info then
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.5294117647058824, 0.5294117647058824, 0.5294117647058824)
			self._can_move = false
		elseif var_14_17 < arg_14_2 and self._first_level_id + 2 > self.now_map_level and var_14_16 < #self._nf_all_map_info then
			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(true)

			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)
			self._can_move = true
		elseif arg_14_2 == self._first_level_id + 2 then
			self._control.main.right_menu.next.image.color = Color.New(0.1411764705882353, 0.5725490196078431, 0.9764705882352941)

			self._control.main.right_menu.prev:SetActive(true)
			self._control.main.right_menu.next:SetActive(false)

			self._can_move = true
		end

		self:_now_big_info(var_14_10)
	end

	function arg_1_0:_now_big_info()
		self._control.main.right_menu.return_btn:SetActive(false)

		local var_15_0 = var_0_5:get_mist_combat_info()
		local var_15_1 = var_0_5:find_mist_prev_bigmap(self.now_map_level)

		if self._now_attack.big_id == 0 then
			self._control.main.right_menu.return_btn:SetActive(false)

			if var_15_1.state == 1 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("first_gotobattle")
			elseif var_15_1.state == 2 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("reset_checkpoint")
			elseif var_15_1.state == 3 then
				self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("already_reset")
			end
		else
			self._control.main.right_menu.ready_to_attack.text.text.text = var_15_1.state == 2 and var_0_3:getNowLang("reset_checkpoint") or var_15_1.state == 3 and var_15_1.id == self.now_map_level and var_15_0.big_id ~= self.now_map_level and var_0_3:getNowLang("already_reset") or var_15_1.state == 1 and var_15_1.id == self.now_map_level and #var_15_1.members == 0 and var_0_3:getNowLang("first_gotobattle") or var_15_1.state == 1 and var_15_1.id == self.now_map_level and var_0_5:get_mist_info().already_get_in_point and var_0_3:getNowLang("challegeon") or var_15_1.state == 3 and var_15_1.id == self.now_map_level and #var_15_1.pass_token < 3 and var_15_0.big_id == self.now_map_level and var_0_3:getNowLang("challegeon") or var_0_3:getNowLang("ui_4th_prepare")
		end

		local var_15_2 = var_0_5:find_mist_prev_bigmap(self.now_map_level)

		self._bigmap_info = var_15_2

		if var_15_2.state == 2 then
			self._control.main.right_menu.ready_to_attack.text.text.text = var_0_3:getNowLang("reset_checkpoint")

			self._control.main.right_menu.return_btn:SetActive(false)
		end
	end

	function arg_1_0:__set_level_map_node_prev_data(arg_16_1, arg_16_2)
		arg_16_2 = arg_16_2 - 1

		if arg_16_2 < self._first_level_id then
			return
		end

		local var_16_0 = 9300
		local var_16_1

		if self._now_index == 1 then
			var_16_1 = var_16_0 + arg_16_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_16_1 = var_16_0 + arg_16_2 % 10000 * 3
		end

		arg_16_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_16_2))

		local var_16_6 = self:__get_level_map_data_by_node(1, arg_16_2)
		local var_16_7 = self:__get_level_map_data_by_node(2, arg_16_2)
		local var_16_8 = self:__get_level_map_data_by_node(3, arg_16_2)
		local var_16_9 = self:__get_level_map_data_by_node(4, arg_16_2)
		local var_16_10 = {
			arg_16_1.enemy_group_one,
			arg_16_1.enemy_group_two,
			arg_16_1.enemy_group_three
		}

		self._node_prev_data = var_16_10

		local var_16_11 = {
			var_16_6.id,
			var_16_7.id,
			var_16_8.id
		}

		self._node_prev_data_id = var_16_11

		local var_16_12 = {
			var_16_6.boss_bg,
			var_16_7.boss_bg,
			var_16_8.boss_bg
		}

		for iter_16_0 = 1, #var_16_10 do
			var_16_10[iter_16_0].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_16_1 + iter_16_0))
			var_16_10[iter_16_0].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_16_12[iter_16_0]))
			var_16_10[iter_16_0].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_16_10[iter_16_0].fail:GetComponent("Image"):SetNativeSize()
		end

		local var_16_13 = var_0_5:find_mist_prev_bigmap(arg_16_2)

		if not var_16_13 then
			return
		end

		local var_16_14 = {
			arg_16_1.point_one,
			arg_16_1.point_two
		}
		local var_16_15 = {
			arg_16_1.path_one,
			arg_16_1.path_two
		}

		for iter_16_1 = 1, #var_16_15 do
			var_16_15[iter_16_1]:GetComponent("Image"):SetNativeSize()
		end

		self._node_prev_path = var_16_15
		arg_16_1.enemy_group_one.points.max.text.text = var_16_6.total_score
		arg_16_1.enemy_group_two.points.max.text.text = var_16_7.total_score
		arg_16_1.enemy_group_three.points.max.text.text = var_16_8.total_score

		self:_bg_adaptive_prev(arg_16_1, var_16_6, var_16_7, var_16_8, var_16_9)

		arg_16_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_16_2, 1))
		arg_16_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_16_2, 2))

		arg_16_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_16_2, var_16_9, arg_16_1)

		if var_16_9 and var_0_5:get_now_have_sp() then
			arg_16_1.enemy_group_four.gameObject:SetActive(true)
			arg_16_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_16_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_16_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_16_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_16_1.enemy_group_four.gameObject:SetActive(false)
		end

		if var_16_13 and (var_16_13.state == 3 or var_16_13.state == 1) then
			for iter_16_2 = 1, #var_16_10 do
				var_16_10[iter_16_2].gameObject:SetActive(false)
				var_16_10[iter_16_2].fail.gameObject:SetActive(false)

				var_16_10[iter_16_2].points.user_num.text.text = 0
				var_16_10[iter_16_2].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))

				var_16_10[iter_16_2].enemy:GetComponent("Image"):SetNativeSize()
			end

			var_16_10[1].gameObject:SetActive(true)

			var_16_10[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_16_3 = 1, 2 do
				var_16_15[iter_16_3].gameObject:SetActive(true)
				var_16_14[iter_16_3].gameObject:SetActive(true)
			end

			local var_16_16

			if #var_16_13.pass_token > 0 then
				var_16_16 = var_16_13.pass_token
			end

			if var_16_16 and #var_16_16 > 0 then
				for iter_16_4 = 1, #var_16_16 do
					var_16_10[iter_16_4].fail.gameObject:SetActive(true)

					if iter_16_4 < 3 then
						var_16_10[iter_16_4 + 1].gameObject:SetActive(true)
					end
				end

				for iter_16_5 = 1, #var_16_16 do
					self:_node_prev_id(var_16_16[iter_16_5], arg_16_2)
				end
			end
		elseif var_16_13.state == 2 then
			for iter_16_6 = 1, 2 do
				var_16_15[iter_16_6].gameObject:SetActive(true)

				var_16_15[iter_16_6].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_16_2, iter_16_6))

				var_16_14[iter_16_6].gameObject:SetActive(false)
				var_16_10[iter_16_6 + 1].gameObject:SetActive(true)
			end

			for iter_16_7 = 1, 3 do
				var_16_10[iter_16_7].fail.gameObject:SetActive(true)

				var_16_10[iter_16_7].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_16_10[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_16_1 + 3))
				else
					var_16_10[iter_16_7].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_16_1 + iter_16_7))
				end

				var_16_10[iter_16_7].enemy.image.sprite = var_16_10[iter_16_7].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_16_1 + iter_16_7))

				var_16_10[iter_16_7].enemy:GetComponent("Image"):SetNativeSize()
			end
		end

		for iter_16_8 = 1, #var_16_15 do
			var_16_15[iter_16_8]:GetComponent("Image"):SetNativeSize()
		end

		if var_16_13.pass_token then
			for iter_16_9, iter_16_10 in pairs(var_16_13.pass_token) do
				self:_get_prev_token_now_map(var_16_11, #var_16_13.pass_token, iter_16_10)
			end
		end
	end

	function arg_1_0:_get_prev_token_now_map(arg_17_1, arg_17_2, arg_17_3)
		for iter_17_0 = 1, arg_17_2 do
			if arg_17_1[iter_17_0] == arg_17_3.id then
				self._node_prev_data[iter_17_0].points.user_num.text.text = arg_17_3.token
			end
		end
	end

	function arg_1_0:__set_level_map_node_next_data(arg_18_1, arg_18_2)
		arg_18_2 = arg_18_2 + 1

		local var_18_0 = var_0_5:find_mist_now_bigmap(arg_18_2)

		if not var_18_0 or arg_18_2 > self._first_level_id + 5 then
			return
		end

		local var_18_1 = 9300
		local var_18_2

		if self._now_index == 1 then
			var_18_2 = var_18_1 + arg_18_2 % 10000 * 3 - 3
		elseif self._now_index > 1 then
			var_18_2 = var_18_1 + arg_18_2 % 10000 * 3
		end

		arg_18_1.bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_big_bg, arg_18_2))

		local var_18_4 = self:__get_level_map_data_by_node(1, arg_18_2)
		local var_18_5 = self:__get_level_map_data_by_node(2, arg_18_2)
		local var_18_6 = self:__get_level_map_data_by_node(3, arg_18_2)
		local var_18_7 = self:__get_level_map_data_by_node(4, arg_18_2)
		local var_18_8 = {
			arg_18_1.enemy_group_one,
			arg_18_1.enemy_group_two,
			arg_18_1.enemy_group_three
		}

		self._node_next_data = var_18_8

		local var_18_9 = {
			var_18_4.id,
			(nil).id,
			(nil).id
		}
		local var_18_10 = {
			var_18_4.boss_bg,
			(nil).boss_bg,
			(nil).boss_bg
		}

		self._node_next_data_id = var_18_9

		local var_18_11 = {
			arg_18_1.point_one,
			arg_18_1.point_two
		}
		local var_18_12 = {
			arg_18_1.path_one,
			arg_18_1.path_two
		}

		self._node_next_path = var_18_12
		arg_18_1.enemy_group_one.points.max.text.text = var_18_4.total_score
		arg_18_1.enemy_group_two.points.max.text.text = (nil).total_score
		arg_18_1.enemy_group_three.points.max.text.text = (nil).total_score

		self:_bg_adaptive_next(arg_18_1, var_18_4, nil, nil, nil)

		arg_18_1.path_one.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_18_2, 1))
		arg_18_1.path_two.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_two, arg_18_2, 2))

		arg_18_1.enemy_group_four.enemy:GetComponent("Image"):SetNativeSize()
		self:__set_now_time_data(arg_18_2, nil, arg_18_1)

		if nil and var_0_5:get_now_have_sp() then
			arg_18_1.enemy_group_four.gameObject:SetActive(true)
			arg_18_1.enemy_group_four.enemy.gameObject:SetActive(true)
			arg_18_1.enemy_group_four.time_remaining.gameObject:SetActive(true)

			arg_18_1.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
			arg_18_1.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))
		else
			arg_18_1.enemy_group_four.gameObject:SetActive(false)
		end

		for iter_18_0 = 1, #var_18_8 do
			var_18_8[iter_18_0].gameObject:SetActive(false)
			var_18_8[iter_18_0].fail.gameObject:SetActive(false)

			var_18_8[iter_18_0].points.user_num.text.text = 0
			var_18_8[iter_18_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))
			var_18_8[iter_18_0].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_18_2 + iter_18_0))

			var_18_8[iter_18_0].enemy:GetComponent("Image"):SetNativeSize()

			var_18_8[iter_18_0].enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, var_18_10[iter_18_0]))
			var_18_8[iter_18_0].fail.image.sprite = self:loadSprite(var_0_4.enemy_fail_icon)

			var_18_8[iter_18_0].fail:GetComponent("Image"):SetNativeSize()
		end

		if var_18_0 and (var_18_0.state == 3 or var_18_0.state == 1) then
			for iter_18_1 = 1, #var_18_8 do
				var_18_8[iter_18_1].gameObject:SetActive(false)
				var_18_8[iter_18_1].fail.gameObject:SetActive(false)

				var_18_8[iter_18_1].points.user_num.text.text = 0
				var_18_8[iter_18_1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 4))

				var_18_8[iter_18_1].enemy:GetComponent("Image"):SetNativeSize()
			end

			var_18_8[1].gameObject:SetActive(true)

			var_18_8[1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

			for iter_18_2 = 1, 2 do
				var_18_12[iter_18_2].gameObject:SetActive(true)
				var_18_11[iter_18_2].gameObject:SetActive(true)
			end

			local var_18_13

			if #var_18_0.pass_token > 0 then
				var_18_13 = var_18_0.pass_token
			end

			if var_18_13 and #var_18_13 > 0 then
				for iter_18_3 = 1, #var_18_13 do
					var_18_8[iter_18_3].fail.gameObject:SetActive(true)

					if iter_18_3 < 3 then
						var_18_8[iter_18_3 + 1].gameObject:SetActive(true)
					end
				end

				for iter_18_4 = 1, #var_18_13 do
					self:_node_next_id(var_18_13[iter_18_4], arg_18_2)
				end
			end
		elseif var_18_0.state == 2 then
			for iter_18_5 = 1, 2 do
				var_18_12[iter_18_5].gameObject:SetActive(true)

				var_18_12[iter_18_5].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_18_2, iter_18_5))

				var_18_11[iter_18_5].gameObject:SetActive(false)
				var_18_8[iter_18_5 + 1].gameObject:SetActive(true)
			end

			for iter_18_6 = 1, 3 do
				var_18_8[iter_18_6].gameObject:SetActive(true)
				var_18_8[iter_18_6].fail.gameObject:SetActive(true)

				var_18_8[iter_18_6].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if self._now_index == 1 then
					var_18_8[3].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg_fail, var_18_2 + 3))
				else
					var_18_8[iter_18_6].enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_18_2 + iter_18_6))
				end

				var_18_8[iter_18_6].enemy.image.sprite = var_18_8[iter_18_6].enemy.image.sprite or self:loadSprite(var_0_7(var_0_4.enemy_small_cg, var_18_2 + iter_18_6))

				var_18_8[iter_18_6].enemy:GetComponent("Image"):SetNativeSize()
			end
		end

		for iter_18_7 = 1, #var_18_12 do
			var_18_12[iter_18_7]:GetComponent("Image"):SetNativeSize()
		end

		if var_18_0.pass_token then
			for iter_18_8, iter_18_9 in pairs(var_18_0.pass_token) do
				self:_get_next_token_now_map(var_18_9, #var_18_0.pass_token, iter_18_9, var_18_8)
			end
		end
	end

	function arg_1_0._get_next_token_now_map(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		for iter_19_0 = 1, arg_19_2 do
			if arg_19_1[iter_19_0] == arg_19_3.id then
				arg_19_4[iter_19_0].points.user_num.text.text = arg_19_3.token
			end
		end
	end

	function arg_1_0:_node_id(arg_20_1)
		for iter_20_0 = 1, #self.node_data_id do
			if arg_20_1.id == self.node_data_id[iter_20_0] then
				self._node_data[iter_20_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_20_0 < #self.node_data_id then
					self._node_data[iter_20_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_path[iter_20_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, self._now_map_level, iter_20_0))
			end
		end
	end

	function arg_1_0:_node_prev_id(arg_21_1, arg_21_2)
		for iter_21_0 = 1, #self._node_prev_data_id do
			if arg_21_1.id == self._node_prev_data_id[iter_21_0] then
				self._node_prev_data[iter_21_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_21_0 < #self._node_prev_data_id then
					self._node_prev_data[iter_21_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_prev_path[iter_21_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_21_2, iter_21_0))
			end
		end
	end

	function arg_1_0:_node_next_id(arg_22_1, arg_22_2)
		for iter_22_0 = 1, #self._node_next_data_id do
			if arg_22_1.id == self._node_next_data_id[iter_22_0] then
				self._node_next_data[iter_22_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))

				if iter_22_0 < #self._node_next_data_id then
					self._node_next_data[iter_22_0 + 1].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_point, 1))
				end

				self._node_next_path[iter_22_0].image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_path_one, arg_22_2, iter_22_0))
			end
		end
	end

	function arg_1_0:__set_now_map_data(arg_23_1)
		if not arg_23_1 then
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

		if var_0_15.width / var_0_15.height > 1.9 and var_0_15.width / var_0_15.height < 2.1 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1442, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1360, 0)
		elseif var_0_15.width / var_0_15.height > 2.16 and var_0_15.width / var_0_15.height < 2.17 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1421, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1421, 0)
		elseif var_0_15.width / var_0_15.height > 2.22 and var_0_15.width / var_0_15.height < 2.23 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1460, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1460, 0)
		elseif var_0_15.width / var_0_15.height > 2.14 and var_0_15.width / var_0_15.height < 2.15 then
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1460, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1460, 0)
		else
			self._control.main.single_map_level_cell_3.transform.anchoredPosition = Vector2(1420, 0)
			self._control.main.single_map_level_cell_1.transform.anchoredPosition = Vector2(-1420, 0)
		end

		if self.nf_info.ticket < 12 then
			self._control.main.cd_time.bg.next_word.gameObject:SetActive(true)
			self._control.main.cd_time.bg.cd_times.gameObject:SetActive(true)
			self._control.main.cd_time.bg.full.gameObject:SetActive(false)
		end

		if self._initial_ticket < 12 then
			self._control.main.cd_time.bg.next_word.gameObject:SetActive(true)
			self._control.main.cd_time.bg.cd_times.gameObject:SetActive(true)
			self._control.main.cd_time.bg.full.gameObject:SetActive(false)
		end
	end

	function arg_1_0:__set_now_main_interface(arg_24_1)
		local var_24_0 = self:__get_level_map_data_by_node(1, arg_24_1)
		local var_24_1 = self:__get_level_map_data_by_node(2, arg_24_1)
		local var_24_2 = self:__get_level_map_data_by_node(3, arg_24_1)
		local var_24_3 = self:__get_level_map_data_by_node(4, arg_24_1)
		local var_24_4 = var_0_20.find_object_by_id(arg_24_1).tips

		self._control.main.right_menu.tickets.tickets_icon.image.sprite = self:loadSprite(var_0_4.six_nf_active_tickets)
		self._control.main.right_menu.checkpoint_group.checkpoints_name.text.text = var_24_0.sub_title
		self._control.main.right_menu.checkpoint_group.checkpoints.text.text = var_24_0.title
	end

	function arg_1_0:goto_small_map(arg_25_1, arg_25_2)
		local var_25_0 = var_0_5:find_mist_prev_bigmap(self.now_map_level)
		local var_25_1 = var_0_5:get_mist_combat_info()
		local var_25_2 = var_0_5:get_bigmap_info()
		local var_25_3 = var_0_20.find_object_by_id(self.now_map_level)
		local var_25_4 = var_0_5:get_use_info_data()
		local var_25_5 = var_0_6.dict_lenght(var_0_5:get_character_list())

		if self:_time_end() then
			var_0_14:show(var_0_3:getNowLang("errorcode-9993"))

			return
		end

		if arg_25_1 == 1 then
			self.map_info = self:__get_level_map_data_by_node(1, arg_25_2)
		elseif arg_25_1 == 2 then
			self.map_info = self:__get_level_map_data_by_node(2, arg_25_2)
		elseif arg_25_1 == 3 then
			self.map_info = self:__get_level_map_data_by_node(3, arg_25_2)
		end

		if #var_25_0.pass_token > 0 then
			for iter_25_0, iter_25_1 in pairs(var_25_0.pass_token) do
				if iter_25_1.id == self.map_info.id then
					var_0_14:show(var_0_3:getNowLang("can_not_fight_clear"))

					return
				end
			end
		end

		if var_25_0.state == 2 then
			var_0_14:show(var_0_3:getNowLang("can_not_fight_clear"))
		elseif var_25_1.big_id ~= 0 and var_25_0.id ~= var_25_1.big_id then
			var_0_14:show(var_0_3:getNowLang("other_map_fighting"))
		elseif var_25_0.members and #var_25_0.members ~= 0 and #var_25_0.pass_token < 3 and var_25_1.id and var_25_1.id ~= 0 then
			self:setVisible(false)
			var_0_2:createInstance("nf_map_node"):show({
				id = var_25_1.id
			})
		elseif var_25_0.state == 1 or var_25_0.state == 3 then
			if #var_25_0.members == 0 or (var_25_0.state == 3 or var_25_0.pass_token and not var_0_1(var_25_0.pass_token)) and var_25_1.big_id and var_25_1.big_id == 0 then
				var_0_5:req_EnterMistBigMapReq(self.now_map_level, var_25_3.ships)
			else
				self:__resq_EnterMistBigMapResp()
			end
		else
			print("我有问题")
		end
	end

	function arg_1_0:__set_now_time_data(arg_26_1, arg_26_2, arg_26_3)
		self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.gameObject:SetActive(true)
		self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.gameObject:SetActive(true)
		self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.gameObject:SetActive(true)

		local var_26_0 = lx.Time:getGMTDateString()

		for iter_26_0, iter_26_1 in pairs(self.plot_node_list) do
			if iter_26_1.level_id == arg_26_1 then
				local var_26_1, var_26_2, var_26_3, var_26_4, var_26_5, var_26_6, var_26_7, var_26_8 = string.find(iter_26_1.start_time, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
				local var_26_9 = os.time({
					year = var_26_3,
					month = var_26_4,
					day = var_26_5,
					hour = var_26_6,
					min = var_26_7,
					sec = var_26_8
				})
				local var_26_10, var_26_11, var_26_12, var_26_13, var_26_14, var_26_15, var_26_16, var_26_17 = string.find(iter_26_1.end_time, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
				local var_26_18 = os.time({
					year = var_26_12,
					month = var_26_13,
					day = var_26_14,
					hour = var_26_15,
					min = var_26_16,
					sec = var_26_17
				})

				if var_26_9 > lx.ServerTime:getUtcTime() or var_26_18 < lx.ServerTime:getUtcTime() then
					var_0_5:set_now_have_sp(false)

					if arg_26_2 then
						arg_26_3.enemy_group_four.gameObject:SetActive(false)
					end
				end

				if var_26_9 < lx.ServerTime:getUtcTime() and var_26_18 > lx.ServerTime:getUtcTime() then
					var_0_5:set_now_have_sp(true)

					if arg_26_2 then
						arg_26_3.enemy_group_four.gameObject:SetActive(true)
					end

					local var_26_19 = var_26_18 - lx.ServerTime:getUtcTime()

					self._control.main.single_map_level_cell_2.enemy_group_four.enemy.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_small_cg, 9352))
					self._control.main.single_map_level_cell_2.enemy_group_four.enemy_bg.image.sprite = self:loadSprite(var_0_7(var_0_4.enemy_bg, 5))

					if var_26_19 >= 86400 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), (math.floor(var_26_19 / 86400)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), math.floor(var_26_19 / 86400))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("daysleft2"), math.floor(var_26_19 / 86400))
					elseif var_26_19 < 86400 and var_26_19 >= 3600 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_26_19 / 3600)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_26_19 / 3600)))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("hourleft"), (math.floor(var_26_19 / 3600)))
					elseif var_26_19 < 3600 and var_26_19 >= 60 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_26_19 / 60)))
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_26_19 / 60)))
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("minleft"), (math.floor(var_26_19 / 60)))
					elseif var_26_19 < 60 then
						self._control.main.single_map_level_cell_1.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_26_19)
						self._control.main.single_map_level_cell_2.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_26_19)
						self._control.main.single_map_level_cell_3.enemy_group_four.time_remaining.days_remaining.text.text = var_0_7(var_0_3:getNowLang("secleft"), var_26_19)
					end
				end
			end
		end
	end

	function arg_1_0:__plot_node_enter_event(arg_27_1)
		if var_0_5:get_select_into_nf() then
			return
		end

		if var_0_5:get_sixth_combat_info().id ~= 0 then
			var_0_14:show(var_0_3:getNowLang("other_map_fighting"))

			return
		end

		self.teams = {}

		local var_27_0 = self:__get_level_map_data_by_node(4, arg_27_1)
		local var_27_1 = var_0_2:createInstance("fight_info")
		local var_27_3 = var_0_19.find_object_by_id(var_27_0.init_node_id).self_formation

		for iter_27_0, iter_27_1 in pairs((#var_27_3 ~= 0 or nil) and var_0_9.find_object_by_id(var_27_3).formation) do
			local var_27_4 = var_0_10.find_object_by_id(iter_27_1)

			var_0_11(self.teams, {
				data = var_27_4,
				config = var_27_4
			})
		end

		local var_27_5 = tostring(var_27_0.map_id)
		local var_27_6 = self.teams and var_0_6.little_clone(self.teams) or {}

		var_0_5:set_back_type()
		var_27_1:show({
			fight_type = var_0_4.fight_type.event_story,
			id = var_27_0.id,
			map_id = string.sub(var_27_5, 1, #var_27_5 - 2),
			team_detail_data = var_27_6,
			start_node_id = var_27_0.init_node_id
		})
		self:setVisible(false)
	end

	function arg_1_0:__set_instructions_info(arg_28_1)
		local var_28_0 = var_0_13.find_object_by_guide_id(10400 + arg_28_1)
		local var_28_1 = 39 + arg_28_1

		self._control.instructions.page.page_1.text.text = arg_28_1

		if arg_28_1 == self._page_first then
			self._control.instructions.prev.gameObject:SetActive(false)
		else
			self._control.instructions.prev.gameObject:SetActive(true)
		end

		if arg_28_1 == self._page_end then
			self._control.instructions.next.gameObject:SetActive(false)
		else
			self._control.instructions.next.gameObject:SetActive(true)
		end

		local var_28_2 = app:getSystem():getChannel()

		self._control.instructions.main.main_tip.main_pic.image.sprite = (var_28_2 == "hm_android_jp" or var_28_2 == "hm_ios_jp") and self:loadSprite(var_0_7(var_0_4.instructions_pic_jp, var_28_0.pic_id)) or self:loadSprite(var_0_7(var_0_4.instructions_pic, var_28_1))

		if var_28_0 then
			self._control.instructions.main.main_tip.tip_word.text.text = var_0_3:convert_rich_text(var_28_0.desc, true)
		end
	end

	function arg_1_0:__init_panel()
		self:_play_audio(var_0_4:get_audio_url(var_0_4.common_icon.music_path, self._now_active_expect.bgm), true)

		local var_29_0 = var_0_5:get_mist_combat_info()
		local var_29_1 = var_0_2:getInstance("loading")

		if var_29_1 then
			var_29_1:show(false)
		end

		self._adjutant_set, self._adjutant_cid, self._current_adjutant_index = var_0_5:get_mist_adjutant()

		self:reset_adjutant_state()

		self.turn_the_page = false
		self._user_data = var_0_5:get_use_info_data()
		self._max_ticket = 1
		self._residue_ticket = self._max_ticket - self.nf_info.buy_count
		self._initial_ticket = self.nf_info.ticket
		self._control.main.cd_time.bg.next_word.text.text = var_0_3:getNowLang("mist_tickets_restore")
		self._control.main.cd_time.bg.full.text.text = var_0_3:getNowLang("mist_tickets_max")

		self._control.main.cd_time.gameObject:SetActive(false)
		self._control.main.cd_time.bg.next_word.gameObject:SetActive(true)
		self._control.main.cd_time.bg.cd_times.gameObject:SetActive(true)
		self._control.main.cd_time.bg.full.gameObject:SetActive(false)

		self._control.buy_tickets.main.player_res.times.all.text.text = 1

		if self._initial_ticket >= 12 then
			self._control.main.cd_time.bg.next_word.gameObject:SetActive(false)
			self._control.main.cd_time.bg.cd_times.gameObject:SetActive(false)
			self._control.main.cd_time.bg.full.gameObject:SetActive(true)
		end

		local var_29_4 = {
			self._control.buy_tickets.main.player_res.exchange_1,
			self._control.buy_tickets.main.player_res.exchange_2,
			self._control.buy_tickets.main.player_res.exchange_3,
			self._control.buy_tickets.main.player_res.exchange_4
		}

		self._content = var_29_4
		self._control.buy_tickets.main.player_res.times.have.text.text = self._max_ticket - self.nf_info.buy_count
		self._control.main.right_menu.tickets.have_ticket.text.text = self.nf_info.ticket

		self._control.buy_tickets.gameObject:SetActive(false)

		self._control.instructions.main.title.text.text = var_0_3:getNowLang("activityinstruction")
		self._control.msgbox.main.title.text.text = var_0_3:getNowLang("logget")
		self._control.msgbox.main.one.text.text.text = var_0_3:getNowLang("ui_cbtn1")
		self._control.main.top.title.text.text = self._now_active_expect.title

		self._control.main.top.plot.gameObject:SetActive(false)

		local var_29_5 = app:getSystem():getChannel()

		if var_29_5 == "hm_android_jp" or var_29_5 == "hm_ios_jp" then
			for iter_29_0 = 1, #var_29_4 do
				var_29_4[iter_29_0].word_1:SetActive(false)

				var_29_4[iter_29_0].word_2.text.text = "="
				var_29_4[iter_29_0].word_3.text.text = var_0_3:getNowLang("zhang")
				var_29_4[iter_29_0].btn.text.text.text = var_0_3:getNowLang("exchange")
			end

			var_29_4[1].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_29_4[2].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_29_4[3].resources.transform.anchoredPosition = Vector2(260.85, -31.38)
			var_29_4[4].resources.transform.anchoredPosition = Vector2(297.2, -31.38)
			var_29_4[1].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_29_4[2].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_29_4[3].word_2.transform.anchoredPosition = Vector2(312.25, -31.38)
			var_29_4[4].word_2.transform.anchoredPosition = Vector2(383.9, -31.38)
			var_29_4[1].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_29_4[2].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_29_4[3].num.transform.anchoredPosition = Vector2(326.4, -31.38)
			var_29_4[4].num.transform.anchoredPosition = Vector2(397, -31.38)
			var_29_4[1].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_29_4[2].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_29_4[3].word_3.transform.anchoredPosition = Vector2(355.1, -31.38)
			var_29_4[4].word_3.transform.anchoredPosition = Vector2(424.2, -31.38)
			var_29_4[1].resources.text.text = var_0_3:getNowLang("six_ticket_num_one")
			var_29_4[2].resources.text.text = var_0_3:getNowLang("six_ticket_num_two")
			var_29_4[3].resources.text.text = var_0_3:getNowLang("six_ticket_num_three")
			var_29_4[4].resources.text.text = var_0_3:getNowLang("six_ticket_num_four")
			self._control.buy_tickets.main.player_res.times.word.transform.anchoredPosition = Vector2(-30, -10)
		else
			for iter_29_1 = 1, #var_29_4 do
				var_29_4[iter_29_1].word_2.text.text = var_0_3:getNowLang("exchange")
				var_29_4[iter_29_1].word_3.text.text = var_0_3:getNowLang("zhang")
				var_29_4[iter_29_1].btn.text.text.text = var_0_3:getNowLang("exchange")
			end

			var_29_4[1].resources.text.text = var_0_3:getNowLang("six_ticket_num_one")
			var_29_4[2].resources.text.text = var_0_3:getNowLang("six_ticket_num_two")
			var_29_4[3].resources.text.text = var_0_3:getNowLang("six_ticket_num_three")
			var_29_4[4].resources.text.text = var_0_3:getNowLang("six_ticket_num_four")
		end

		var_29_4[1].number_1.text.text = var_0_6.get_simplify_num(self._user_data.oil)
		var_29_4[2].number_1.text.text = var_0_6.get_simplify_num(self._user_data.bullet)
		var_29_4[3].number_1.text.text = var_0_6.get_simplify_num(self._user_data.fe)
		var_29_4[4].number_1.text.text = var_0_6.get_simplify_num(self._user_data.al)
		self._now_res_oil = self._user_data.oil
		self._now_res_buttet = self._user_data.bullet
		self._now_res_fe = self._user_data.fe
		self._now_res_al = self._user_data.al
		self._control.buy_tickets.main.close.text.text.text = var_0_3:getNowLang("marketingloginclose")
		self._control.buy_tickets.main.player_res.times.word.text.text = var_0_3:getNowLang("mist_tickets_restore_desc")
		self._control.buy_tickets.main.title.text.text = var_0_3:getNowLang("mist_tickets_obtain")
		self._control.main.right_menu.next.text.text.text = var_0_3:getNowLang("next")
		self._control.main.right_menu.prev.text.text.text = var_0_3:getNowLang("prev")
		self._control.instructions.prev.text.text.text = var_0_3:getNowLang("ui_new_guide_last")
		self._control.instructions.next.text.text.text = var_0_3:getNowLang("ui_new_guide_next")

		self:__set_node_data_list_by_sort_or_type()
		self:__set_now_map_data(self.now_map_level)
		self:__set_now_main_interface(self.now_map_level)

		self._page_first = 1
		self._page_end = 5
		self._page_move = self._page_first

		local var_29_6 = app:getSystem():getChannel()

		if var_29_6 == "hm_android_jp" or var_29_6 == "hm_ios_jp" then
			self._page_first = 1
			self._page_end = 11

			self._control.instructions.page.page_3:SetActive(false)
		else
			self._control.instructions.page.page_3.text.text = var_0_3:getNowLang("introduce_page")
		end

		self._control.instructions.page.page_1.text.text = self._page_first
		self._control.instructions.page.page_2.text.text = self._page_end

		self:__set_instructions_info(self._page_move)

		self._control.msgbox.main.reward.reward_name.text.text = var_0_3:getNowLang("mist_tickets")

		if self._residue_ticket == 0 then
			self:all_close()
			self:all_Openbtn2()
		else
			self:all_closebtn2()
		end
	end

	function arg_1_0:all_close()
		for iter_30_0 = 1, #self._content do
			self._content[iter_30_0].btn.image.sprite = self:loadSprite(var_0_7(var_0_4.exchange_btn, 42))
			self._content[iter_30_0].btn.scaleButton.interactable = false
		end

		self._is_exchange_all = true
	end

	function arg_1_0:all_Openbtn2()
		for iter_31_0 = 1, #self._content do
			self._content[iter_31_0].btn2.gameObject:SetActive(true)
		end
	end

	function arg_1_0:all_closebtn2()
		for iter_32_0 = 1, #self._content do
			self._content[iter_32_0].btn2.gameObject:SetActive(false)
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

	function arg_1_0:_time_end()
		local var_35_0 = lx.ServerTime:getUtcTime()

		return var_35_0 < self._now_active_expect.start_time or var_35_0 > self._now_active_expect.end_time
	end

	function arg_1_0:__resq_EnterMistBigMapResp()
		local var_36_0 = var_0_5:get_mist_combat_info()
		local var_36_1 = var_0_5:find_mist_prev_bigmap(self.now_map_level).id % 10000
		local var_36_2

		if self._now_index == 1 then
			var_36_2 = 10401 + var_36_1 * 3 - 3
		elseif self._now_index > 1 then
			var_36_2 = 10401 + var_36_1 * 3
		end

		if #var_36_0.pass_map == 0 then
			var_0_5:req_EnterMistMapReq(var_36_2)
		else
			var_0_5:req_EnterMistMapReq(var_36_2 + #var_36_0.pass_map)
		end

		self:setVisible(false)
	end

	function arg_1_0:_next_buy_time()
		local var_37_0 = 86400 - lx.ServerTime:getUtcTime() + self.nf_info.last_recover_time

		self._next_h = math.floor(var_37_0 / 3600)
		self._next_m = math.floor((var_37_0 - self._next_h * 3600) / 60)
		self._next_s = math.floor(var_37_0 - self._next_h * 3600 - self._next_m * 60)
		self._next_h = math.abs(var_0_7(self._next_h))

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
		self._control.instructions.gameObject:SetActive(var_0_5:get_instructions_mist_guide_state())
	end

	function arg_1_0:__continue_last_map()
		local var_42_0 = var_0_5:get_mist_combat_info()
		local var_42_1 = var_0_18.find_object_by_id(var_42_0.id or 0)

		if var_42_1 and var_42_0.point ~= var_42_1.init_node_id then
			self:__onClick_main_right_menu_ready_to_attack()
		end
	end

	function arg_1_0.__onReset(arg_43_0)
		arg_1_0._user_data = {}
		arg_1_0.mist_info = {}
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
		arg_1_0._nf_all_map_info = {}
		arg_1_0._can_move = false
		arg_1_0._now_map_info = {}
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_44_0)
	local var_44_0 = var_0_2:class("nf_main_interface")

	var_44_0._max_ticket = nil
	var_44_0._residue_ticket = nil
	var_44_0._user_data = {}
	var_44_0.mist_info = {}
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
	var_44_0._nf_all_map_info = {}
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
