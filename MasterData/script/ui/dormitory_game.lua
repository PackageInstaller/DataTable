local var_0_0 = {}
local var_0_1 = gamecore.UILoader
local var_0_2 = gamecore.Language
local var_0_3 = gameenum.common_type
local var_0_4 = gamecore.user
local var_0_5 = string.format
local var_0_6 = table.insert
local var_0_7 = math.floor
local var_0_9 = gameconfig.furniture_config
local var_0_10 = gameconfig.ship_config
local var_0_11 = gameconfig.skin_config
local var_0_12 = lx.clone_table
local var_0_13 = DG.Tweening.DOTween
local var_0_14 = UnityEngine.Time
local var_0_15 = Spine.Unity.SkeletonGraphic
local var_0_16 = gamecore.util_func

gamecore.UILoader:define("dormitory_game", function(arg_1_0)
	function arg_1_0:show(arg_2_1)
		self:setVisible(true)
		self:__init_panel(arg_2_1)

		self._data = arg_2_1
	end

	function arg_1_0:__onUpdate()
		self:__game_update()
		self:__race_update()
		self:__car_move_update(1)
		self:__car_move_update(2)
		self:__car_move_update(3)
	end

	function arg_1_0:__game_update()
		if self._driving_car_num == 3 and self._my_select_car_index ~= nil then
			self._starting_game = true
		end

		if self._starting_game and self._end_car_num == 3 then
			self._starting_game = false
		end
	end

	function arg_1_0:__race_update()
		if self._starting_game == false then
			return
		end

		if self._had_get_buff then
			return
		end

		if self.has_win_index ~= 0 then
			self:__show_layer(3, true)

			self._control.race_result_layer.team.bg.car.image.sprite = self._car_furniture_list[self._my_select_car_index]._control.sort_layer.img.image.sprite
			self._control.race_result_layer.team.bg.car.image.rectTransform.sizeDelta = Vector2(self._car_furniture_list[self._my_select_car_index]._control.sort_layer.img.image.sprite.rect.width, self._car_furniture_list[self._my_select_car_index]._control.sort_layer.img.image.sprite.rect.height)

			if not self._control.race_result_layer.team.bg.role:GetComponent("SkeletonGraphic") then
				self._control.race_result_layer.team.bg.role.skeletonGraphic = self._control.race_result_layer.team.bg.role.gameObject:AddComponent(typeof(var_0_15))
			end

			self._control.race_result_layer.team.bg.role.skeletonGraphic.skeletonDataAsset = self._game_team_list[self._my_select_car_index].role.skeletonGraphic.skeletonDataAsset
			self._control.race_result_layer.team.bg.role.skeletonGraphic.initialSkinName = var_0_3.ship_spine_skin_name_list.normal
			self._control.race_result_layer.team.bg.role.skeletonGraphic.startingAnimation = "stand1"
			self._control.race_result_layer.team.bg.role.skeletonGraphic.startingLoop = true

			self._control.race_result_layer.team.bg.role.skeletonGraphic:Initialize(true)

			self._control.race_result_layer.team.bg.role.skeletonGraphic.material = self._game_team_list[self._my_select_car_index].role.skeletonGraphic.material
			self._control.race_result_layer.team.bg.role.skeletonGraphic.material.shader = self._game_team_list[self._my_select_car_index].role.skeletonGraphic.material.shader

			local var_5_0 = var_0_9.find_object_by_cid(self._car_furniture_list[self._my_select_car_index]._data.cid)

			self._control.race_result_layer.team.car_name_image.car_name_1.text.text = var_5_0.title
			self._control.race_result_layer.team.car_name_image.car_name_2.text.text = var_5_0.title

			self._control.race_result_layer.team.car_name_image:GetComponent("TextHorizonScroller"):SetText(var_5_0.title)

			if self.has_win_index == self._my_select_car_index then
				self._control.race_result_layer.race_result.image.sprite = self:loadSprite(var_0_3.race_result.win)

				self._dormitory:add_buff(1)
				var_0_4:req_RacingReq({
					win = true,
					id = self._role_list[self._my_select_car_index],
					furniture_id = self._car_furniture_list[self._my_select_car_index]._config.cid
				})
			else
				self._control.race_result_layer.race_result.image.sprite = self:loadSprite(var_0_3.race_result.lose)

				self._dormitory:add_buff(2)
				var_0_4:req_RacingReq({
					win = false,
					id = self._role_list[self._my_select_car_index],
					furniture_id = self._car_furniture_list[self._my_select_car_index]._config.cid
				})
			end

			self._had_get_buff = true

			return
		end

		self._cur_time = self._cur_time + var_0_14.deltaTime
	end

	function arg_1_0:click_select_btn_event(arg_6_1)
		self._my_select_car_index = arg_6_1

		self:__show_layer(2, false)
		self:__set_car_move_info(1)
		self:__set_car_move_info(2)
		self:__set_car_move_info(3)
	end

	function arg_1_0.get_random_list(arg_7_0, arg_7_1, arg_7_2)
		if arg_7_2 > #arg_7_1 then
			return false
		end

		local var_7_0 = {}

		repeat
			local var_7_1 = lan_rand(1, #arg_7_1)
			local var_7_2 = false

			for iter_7_0, iter_7_1 in ipairs(var_7_0) do
				if arg_7_1[var_7_1] == iter_7_1 then
					var_7_2 = true

					break
				end
			end

			if not var_7_2 then
				var_0_6(var_7_0, arg_7_1[var_7_1])
			end
		until #var_7_0 == arg_7_2

		return var_7_0
	end

	function arg_1_0:add_car_furniture(arg_8_1)
		var_0_6(self._car_furniture_list, arg_8_1)
	end

	function arg_1_0:add_love(arg_9_1)
		self._control.race_result_layer.team.interact:SetActive(arg_9_1)

		if arg_9_1 then
			self._control.race_result_layer.team.interact.transform:DOBlendableLocalMoveBy(Vector3.New(0, 20, 0), 1):OnComplete(function()
				if self and self._control then
					self._control.race_result_layer.team.interact:SetActive(false)
					self._control.race_result_layer.team.interact.transform:DOBlendableLocalMoveBy(Vector3.New(0, -20, 0), 0.1)
				end
			end)
		end
	end

	function arg_1_0:return_to_dormitory()
		self:__onClick_race_select_layer_return_btn()
	end

	function arg_1_0:check_get_buff_num(arg_12_1)
		if arg_12_1 >= var_0_3.fixed_data.racing_count then
			self._control.race_result_layer.lose_buff_desc:SetActive(true)

			self._control.race_result_layer.lose_buff_desc.text.text = var_0_2:getNowLang("racebufflimit")
		else
			self._control.race_result_layer.lose_buff_desc:SetActive(false)
		end
	end

	function arg_1_0.__reset_game(arg_13_0)
		arg_13_0._my_select_car_index = nil
		arg_13_0._starting_game = false
		arg_13_0._driving_car_num = 0
		arg_13_0._is_already_init = false
		arg_13_0.has_win_index = 0
		arg_13_0._end_car_num = 0
		arg_13_0._had_get_buff = false
	end

	function arg_1_0:__judge_have_circuit_condition()
		self.tmp_furniture_race_data = {}

		local var_14_0 = false

		for iter_14_0, iter_14_1 in pairs((var_0_4:get_dormitory_furniture())) do
			if iter_14_1.cid == 10101971 then
				var_14_0 = true

				var_0_6(self.tmp_furniture_race_data, iter_14_1)

				break
			end
		end

		return var_14_0
	end

	function arg_1_0:__judge_car_count_condition()
		local var_15_1 = {}

		for iter_15_0, iter_15_1 in pairs(var_0_4:get_dormitory_furniture_archive()) do
			if iter_15_1.id == 10025571 or iter_15_1.id == 10025671 or iter_15_1.id == 10025871 or iter_15_1.id == 10026071 or iter_15_1.id == 10026171 or iter_15_1.id == 10026271 or iter_15_1.id == 10026371 or iter_15_1.id == 10026571 then
				var_0_6(var_15_1, iter_15_1)
			end
		end

		local var_15_2 = false

		self._race_car_list = {}

		for iter_15_2, iter_15_3 in pairs(var_15_1) do
			if var_0_9.find_object_by_cid(iter_15_3.id).race_car then
				for iter_15_4, iter_15_5 in ipairs(self._race_car_list) do
					if iter_15_5 == iter_15_3.id then
						var_15_2 = true

						break
					end
				end

				if not var_15_2 then
					var_0_6(self._race_car_list, iter_15_3.id)
				end
			end

			var_15_2 = false
		end

		return #self._race_car_list >= 3
	end

	function arg_1_0:__select_car()
		return (self:get_random_list(var_0_16.little_clone(self._race_car_list), 3))
	end

	function arg_1_0:__select_role()
		local var_17_1 = var_0_16.little_clone((self._dormitory._curr_room_index and var_0_4:get_dormitory_room_info(self._dormitory._curr_room_index) or var_0_4:get_dormitory_room_info(1)).members)
		local var_17_2 = {}

		for iter_17_0, iter_17_1 in pairs((var_0_4:get_character_list())) do
			var_17_2[iter_17_1.cid] = var_17_2[iter_17_1.cid] or iter_17_1
		end

		local var_17_3 = {}
		local var_17_4 = {}

		if #var_17_1 < 3 then
			for iter_17_2 = 1, #var_17_1 do
				var_0_6(var_17_3, var_17_1[iter_17_2])
			end

			local var_17_5 = false

			for iter_17_3, iter_17_4 in pairs(var_17_2) do
				for iter_17_5, iter_17_6 in ipairs(var_17_1) do
					if iter_17_4.id == iter_17_6 or iter_17_4.cid == var_0_4:find_character_by_id(iter_17_6).cid then
						var_17_5 = true

						break
					end
				end

				if not var_17_5 then
					var_0_6(var_17_4, iter_17_4.id)
				end

				var_17_5 = false
			end

			for iter_17_7, iter_17_8 in ipairs((self:get_random_list(var_17_4, 3 - #var_17_3))) do
				var_0_6(var_17_3, iter_17_8)
			end

			return var_17_3
		else
			return (self:get_random_list(var_17_1, 3))
		end
	end

	function arg_1_0:__set_role_and_car_info()
		self:__create_role_skeleton()
		self:__create_car_furniture()
	end

	function arg_1_0:__show_layer(arg_19_1, arg_19_2)
		local var_19_0 = self._layer_list[arg_19_1]

		self._layer_list[arg_19_1].canvasGroup.alpha = arg_19_2 and 1 or 0
		var_19_0.canvasGroup.interactable = arg_19_2
		var_19_0.canvasGroup.blocksRaycasts = arg_19_2
	end

	function arg_1_0:__judge_unlock_condition()
		self._have_circuit = self:__judge_have_circuit_condition()
		self._have_three_car = self:__judge_car_count_condition()
		self._have_three_role = true

		return self._have_circuit and self._have_three_car and self._have_three_role
	end

	function arg_1_0:__race_unlock_layer()
		function get_url(arg_22_0)
			return (arg_22_0 or nil) and var_0_3.dormitory_const.room_gou
		end

		self._control.race_unlock_layer.room_cha_1.image.sprite = self:loadSprite(get_url(self._have_circuit))
		self._control.race_unlock_layer.room_cha_2.image.sprite = self:loadSprite(get_url(self._have_three_car))

		self:__show_layer(1, true)
	end

	function arg_1_0:__race_select_layer()
		self:__show_layer(2, true)

		self._role_list, self._car_list = var_0_4:get_domitory_game_list()

		if self._role_list and self._car_list and next(self._role_list) and next(self._car_list) then
			-- block empty
		elseif self.restart_list and self.restart_list.role then
			self._role_list = self.restart_list.role
			self._car_list = self.restart_list.car
		else
			self._role_list = self:__select_role()
			self._car_list = self:__select_car()
		end

		self.restart_list = nil

		self:__set_role_and_car_info()
		self:__role_move_to_car()
		self:__show_layer(4, true)
	end

	function arg_1_0:__update_dormitory_room()
		if self._dormitory._curr_room_index == 1 then
			self._dormitory:reset_room()
		else
			self._dormitory:reset_room()
		end

		self._dormitory:__toggle_menu(true)
	end

	function arg_1_0:__init_panel(arg_25_1)
		self._user_data = var_0_4:get_use_info_data()
		self._canvas_scale = self._control.game_layer.transform:GetComponentInParent(typeof(UnityEngine.Canvas)).scaleFactor
		self._delta_screen_width = (UnityEngine.Screen.width - var_0_3.dormitory_const.panel_width * self._canvas_scale) / 2
		self._delta_screen_height = (UnityEngine.Screen.height - var_0_3.dormitory_const.panel_height * self._canvas_scale) / 2

		if not self._is_already_init then
			self:__init_language()
			self:__init_constant()
		end

		if not (self._user_data.racing_open and true or self:__judge_unlock_condition()) then
			self:__race_unlock_layer()
		else
			self._dormitory:__toggle_room_select(false)
			self._dormitory:__toggle_menu(false)
			self._dormitory:__toggle_open_btn(false)
			self._dormitory:__toggle_close_menu(true)
			self:__race_select_layer()
		end

		self:add_love(false)

		self._is_already_init = true
	end

	function arg_1_0:__init_language()
		self._control.race_unlock_layer.bg_container.title_node.title.text.text = var_0_2:getNowLang("raceunlocktitle")
		self._control.race_unlock_layer.race_title.text.text = var_0_2:getNowLang("racegame")
		self._control.race_unlock_layer.race_condition_1.text.text = var_0_2:getNowLang("raceunlockcondition1")
		self._control.race_unlock_layer.race_condition_2.text.text = var_0_2:getNowLang("raceunlockcondition2")
		self._control.race_unlock_layer.confirm_btn.txt.text.text = var_0_2:getNowLang("confirm")
		self._control.race_select_layer.title.text.text = var_0_2:getNowLang("selectsupportteam")
		self._control.race_select_layer.team_1.race_title.text.text = var_0_2:getNowLang("drivecar")
		self._control.race_select_layer.team_1.selected_btn.txt.text.text = var_0_2:getNowLang("select")
		self._control.race_select_layer.team_2.race_title.text.text = var_0_2:getNowLang("drivecar")
		self._control.race_select_layer.team_2.selected_btn.txt.text.text = var_0_2:getNowLang("select")
		self._control.race_select_layer.team_3.race_title.text.text = var_0_2:getNowLang("drivecar")
		self._control.race_select_layer.team_3.selected_btn.txt.text.text = var_0_2:getNowLang("select")
		self._control.race_select_layer.return_btn.txt.text.text = var_0_2:getNowLang("return")
		self._control.race_result_layer.team.race_title.text.text = var_0_2:getNowLang("drivecar")
		self._control.race_result_layer.restart_btn.txt.text.text = var_0_2:getNowLang("restart")
		self._control.race_result_layer.return_btn.txt.text.text = var_0_2:getNowLang("return")
	end

	function arg_1_0:__init_constant()
		self._dormitory = var_0_1:getInstance("dormitory")
		self._cur_time = 0
		self._starting_game = false
		self.max_displacement = 1024
		self.acceleration1 = 60
		self.acceleration2 = 150
		self.has_win_index = 0
		self._layer_list = {
			self._control.race_unlock_layer,
			self._control.race_select_layer,
			self._control.race_result_layer,
			self._control.game_layer
		}
		self._select_team_list = {
			self._control.race_select_layer.team_1,
			self._control.race_select_layer.team_2,
			self._control.race_select_layer.team_3
		}
		self._game_team_list = {
			self._control.game_layer.team_1,
			self._control.game_layer.team_2,
			self._control.game_layer.team_3
		}
		self._car_furniture_list = {}
		self._car_state = {
			jump = 0,
			stop = 2,
			high = 4,
			back = 3,
			speedup = 1
		}
		self._team_animation_list = {
			"hello",
			"hello",
			"hello"
		}
		self._car_move_info = {}
		self._role_move_seq = {}
	end

	function arg_1_0:__role_move_to_car()
		self._driving_car_num = 0

		for iter_28_0 = 1, 3 do
			local var_28_0 = var_0_3.dormitory_race_car_sit_config[self._car_list[iter_28_0]]
			local var_28_1 = var_0_9.find_object_by_cid(self._car_list[iter_28_0])
			local var_28_2 = self._game_team_list[iter_28_0].role

			self._role_move_seq[iter_28_0] = self:autoKillDOTween(var_0_13.Sequence())

			self._role_move_seq[iter_28_0]:Append(self._game_team_list[iter_28_0].role.rectTransform:DOMove(Vector2(self:__convert_to_pos(58 - iter_28_0 + var_28_1.width * 0.5 + var_0_3.dormitory_race_car_sit_config[self._car_list[iter_28_0]].delta_grid_x, (iter_28_0 - 1) * 11)), 1):SetEase(DG.Tweening.Ease.Linear))
			self._role_move_seq[iter_28_0]:AppendCallback(function()
				self:__set_transform_grid(self._game_team_list[iter_28_0].role, 58 - iter_28_0 + var_28_1.width * 0.5 + var_28_0.delta_grid_x, (iter_28_0 - 1) * 11 + var_28_0.delta_grid_y)
				self:__play_animation(var_28_2, var_28_0.sit_anim, true)

				self._driving_car_num = self._driving_car_num + 1

				self._car_furniture_list[iter_28_0]:open_spine(true)
				self._car_furniture_list[iter_28_0]:open_spine_2(true)
				self._car_furniture_list[iter_28_0]._control.sort_layer.img.image.gameObject:SetActive(false)
				self._car_furniture_list[iter_28_0]:set_furniture_animation(0, "start", true)

				self._game_team_list[iter_28_0].role.rectTransform.rotation = Quaternion.Euler(0, 0, 0)
			end)
			self._role_move_seq[iter_28_0]:Play()

			self._game_team_list[iter_28_0].role.gameObject:GetComponent("Canvas").sortingOrder = self._car_furniture_list[iter_28_0]._control.sort_layer.gameObject:GetComponent("Canvas").sortingOrder + 1
			self._game_team_list[iter_28_0].role.rectTransform.rotation = Quaternion.Euler(0, 180, 0)
		end
	end

	function arg_1_0:__create_role_skeleton()
		for iter_30_0 = 1, 3 do
			local var_30_0 = var_0_4:find_character_by_id(self._role_list[iter_30_0])
			local var_30_1 = var_0_10.find_object_by_cid(var_30_0.cid).pic_id

			if var_30_0.skin ~= 0 then
				var_30_1 = var_0_11.find_object_by_cid(var_30_0.skin).skin_id
			end

			local var_30_2 = self:loadSkeletonDataAsset(var_0_5(var_0_3.dormitory_const.ship_spine_path, var_30_1, var_30_1))
			local var_30_3 = self:loadMaterial(var_0_3:get_ship_spine(var_0_3.dormitory_const.ship_spine_mat_path, var_30_1))
			local var_30_4 = UnityEngine.Shader.Find("Spine/SkeletonGraphic (Premultiply Alpha)")

			self._select_team_list[iter_30_0].bg.role.skeletonGraphic.skeletonDataAsset = var_30_2
			self._select_team_list[iter_30_0].bg.role.skeletonGraphic.initialSkinName = var_0_3.ship_spine_skin_name_list.normal
			self._select_team_list[iter_30_0].bg.role.skeletonGraphic.material = var_30_3
			self._select_team_list[iter_30_0].bg.role.skeletonGraphic.material.shader = var_30_4

			self._select_team_list[iter_30_0].bg.role.skeletonGraphic:Initialize(true)
			self:__set_select_animation(self._select_team_list[iter_30_0].bg.role.skeletonGraphic, iter_30_0)

			self._game_team_list[iter_30_0].role.skeletonGraphic.skeletonDataAsset = var_30_2
			self._game_team_list[iter_30_0].role.skeletonGraphic.initialSkinName = var_0_3.ship_spine_skin_name_list.normal
			self._game_team_list[iter_30_0].role.skeletonGraphic.startingAnimation = "walk_quick"
			self._game_team_list[iter_30_0].role.skeletonGraphic.material = var_30_3
			self._game_team_list[iter_30_0].role.skeletonGraphic.material.shader = var_30_4
			self._select_team_list[iter_30_0].bg.role.skeletonGraphic.startingLoop = true

			self._game_team_list[iter_30_0].role.skeletonGraphic:Initialize(true)

			self._game_team_list[iter_30_0].role.rectTransform.position = Vector2.New(self:__convert_to_pos(58 - iter_30_0, (iter_30_0 - 1) * 10))
		end
	end

	function arg_1_0:__create_car_furniture()
		local var_31_0 = var_0_12(var_0_3.race_room_data)

		for iter_31_0, iter_31_1 in ipairs(self._car_list) do
			local var_31_1 = var_0_9.find_object_by_cid(iter_31_1)

			var_0_6(var_31_0, {
				rotate = false,
				id = 0,
				cid = iter_31_1,
				point = {
					x = 58 - iter_31_0,
					y = (iter_31_0 - 1) * 10
				},
				car_id = iter_31_0
			})

			local var_31_2 = self:loadSprite(var_0_5(var_0_3.dormitory_const.furniture_sprite_path, var_31_1.icon, var_31_1.icon, ""))

			self._select_team_list[iter_31_0].bg.car.image.sprite = var_31_2
			self._select_team_list[iter_31_0].bg.car.image.rectTransform.sizeDelta = Vector2(var_31_2.rect.width, var_31_2.rect.height)
			self._select_team_list[iter_31_0].car_name_image.car_name_1.text.text = var_31_1.title
			self._select_team_list[iter_31_0].car_name_image.car_name_2.text.text = var_31_1.title

			self._select_team_list[iter_31_0].car_name_image:GetComponent("TextHorizonScroller"):SetText(var_31_1.title)
		end

		self._dormitory:race_game_enter(var_31_0)

		for iter_31_2 = 1, 3 do
			self._car_furniture_list[iter_31_2]._panel.transform:SetParent(self._game_team_list[iter_31_2].car.transform, false)
		end
	end

	function arg_1_0:__set_transform_grid(arg_32_1, arg_32_2, arg_32_3)
		arg_32_1.rectTransform.position = Vector2(self:__convert_to_pos(arg_32_2, arg_32_3))
	end

	function arg_1_0.__set_transform_pos(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
		arg_33_1.rectTransform.anchoredPosition = Vector2(arg_33_2, arg_33_3)
	end

	function arg_1_0:__convert_to_pos(arg_34_1, arg_34_2)
		return arg_34_1 * var_0_3.dormitory_const.room_x_plus * self._canvas_scale + self._delta_screen_width, arg_34_2 * var_0_3.dormitory_const.room_y_plus * self._canvas_scale + self._delta_screen_height
	end

	function arg_1_0.__convert_to_grid(arg_35_0, arg_35_1, arg_35_2)
		return var_0_7(arg_35_1 / var_0_3.dormitory_const.room_x_plus + 0.5), (var_0_7(arg_35_2 / var_0_3.dormitory_const.room_y_plus + 0.5))
	end

	function arg_1_0.__play_animation(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
		arg_36_1.skeletonGraphic.AnimationState:SetAnimation(0, arg_36_2, arg_36_3)
	end

	function arg_1_0:__car_move_to_grid(arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		local var_37_0, var_37_1 = self:__convert_to_pos(arg_37_2, arg_37_3)

		self._game_team_list[arg_37_1].transform.rectTransform:DOMove(Vector2(var_37_0, 0), arg_37_4)
	end

	function arg_1_0:__set_car_move_info(arg_38_1, arg_38_2)
		local var_38_0 = self._car_list[arg_38_1]
		local var_38_1 = var_0_9.find_object_by_cid(self._car_list[arg_38_1])
		local var_38_2 = arg_38_2 ~= nil and arg_38_2 or 0

		self._car_move_info[arg_38_1] = {
			change_ani = 0,
			cur_speed = 0,
			need_reset = false,
			state = 1,
			cur_time = 0,
			race_end = false,
			cid = var_38_0,
			cfg = var_38_1,
			displacement = var_38_2,
			speedup_time = lan_rand(var_38_1.speedup_time[1], var_38_1.speedup_time[2]),
			speedup = var_38_1.speedup,
			stop_time = lan_rand(var_38_1.stop_time[1], var_38_1.stop_time[2]),
			back_time = lan_rand(var_38_1.back_time[1], var_38_1.back_time[2]),
			backspeed = -var_38_1.backspeed,
			high_time = self:get_random_list(var_38_1.high_time, 1)[1],
			highspeed = var_38_1.highspeed,
			jump_time = self:get_random_list(var_38_1.jump_time, 1)[1],
			jumpspeed = var_38_1.jumpspeed
		}
	end

	function arg_1_0:__car_move_update(arg_39_1)
		if self._starting_game == false then
			return
		end

		if self._car_move_info[arg_39_1].race_end then
			return
		end

		local var_39_0 = self._car_move_info[arg_39_1]

		if (self._car_move_info[1].cid == 10026171 and self._car_move_info[2].cid == 10026371 or self._car_move_info[2].cid == 10026171 and self._car_move_info[1].cid == 10026371 or self._car_move_info[1].cid == 10026171 and self._car_move_info[3].cid == 10026371 or self._car_move_info[3].cid == 10026171 and self._car_move_info[1].cid == 10026371 or self._car_move_info[2].cid == 10026171 and self._car_move_info[3].cid == 10026371 or self._car_move_info[3].cid == 10026171 and self._car_move_info[2].cid == 10026371) and var_39_0.cid == 10026371 then
			var_39_0.displacement = var_39_0.displacement + 0.05
		end

		if var_39_0.displacement >= self.max_displacement then
			if self.has_win_index == 0 then
				self.has_win_index = arg_39_1
			end

			self._end_car_num = self._end_car_num + 1
			self._car_move_info[arg_39_1].race_end = true

			return
		end

		var_39_0.cur_time = var_39_0.cur_time + var_0_14.deltaTime

		if var_39_0.state == self._car_state.speedup then
			var_39_0.cur_speed = var_39_0.cur_speed >= var_39_0.speedup and var_39_0.speedup or var_39_0.cur_speed + self.acceleration1 * var_0_14.deltaTime
			var_39_0.displacement = var_39_0.displacement + (var_39_0.cur_speed + var_39_0.cur_speed) * 0.5 * var_0_14.deltaTime

			local var_39_1, var_39_2 = self:__convert_to_pos(0, arg_39_1 - 1)

			self:__set_transform_pos(self._game_team_list[arg_39_1], -var_39_0.displacement, 0)

			if var_39_0.cur_time >= var_39_0.speedup_time then
				var_39_0.state = (var_39_0.state + 1) % 5
				var_39_0.cur_time = 0
			end
		elseif var_39_0.state == self._car_state.stop then
			if var_39_0.cur_time >= var_39_0.stop_time then
				var_39_0.state = (var_39_0.state + 1) % 5
				var_39_0.cur_time = 0
			end
		elseif var_39_0.state == self._car_state.back then
			var_39_0.cur_speed = var_39_0.cur_speed <= var_39_0.backspeed and var_39_0.backspeed or var_39_0.cur_speed - self.acceleration2 * var_0_14.deltaTime
			var_39_0.displacement = var_39_0.displacement + (var_39_0.cur_speed + var_39_0.cur_speed) * 0.5 * var_0_14.deltaTime

			local var_39_3, var_39_4 = self:__convert_to_pos(0, arg_39_1 - 1)

			self:__set_transform_pos(self._game_team_list[arg_39_1], -var_39_0.displacement, 0)

			if var_39_0.cur_time >= var_39_0.back_time then
				var_39_0.state = (var_39_0.state + 1) % 5
				var_39_0.cur_time = 0
			end
		elseif var_39_0.state == self._car_state.high then
			if var_39_0.high_time ~= 0 then
				if var_39_0.change_ani == 0 then
					var_39_0.change_ani = 1
				end

				var_39_0.cur_speed = var_39_0.cur_speed >= var_39_0.highspeed and var_39_0.highspeed or var_39_0.cur_speed + self.acceleration1 * var_0_14.deltaTime
				var_39_0.displacement = var_39_0.displacement + (var_39_0.cur_speed + var_39_0.cur_speed) * 0.5 * var_0_14.deltaTime

				local var_39_5, var_39_6 = self:__convert_to_pos(0, arg_39_1 - 1)

				self:__set_transform_pos(self._game_team_list[arg_39_1], -var_39_0.displacement, 0)

				if var_39_0.cur_time >= var_39_0.high_time then
					var_39_0.state = (var_39_0.state + 1) % 5
					var_39_0.cur_time = 0
					var_39_0.change_ani = 3
					var_39_0.need_reset = true
				elseif var_39_0.cur_time >= 1.9 then
					self:__role_up(arg_39_1, 0, 0.5, DG.Tweening.Ease.Linear)
				end
			else
				var_39_0.state = (var_39_0.state + 1) % 5
				var_39_0.cur_time = 0
			end
		elseif var_39_0.state == self._car_state.jump then
			if var_39_0.jump_time ~= 0 then
				if var_39_0.cur_time ~= 0 then
					if var_39_0.change_ani == 0 then
						var_39_0.change_ani = 1
					end

					var_39_0.cur_speed = var_39_0.cur_speed >= var_39_0.jumpspeed and var_39_0.jumpspeed or var_39_0.cur_speed + self.acceleration1 * var_0_14.deltaTime
					var_39_0.displacement = var_39_0.displacement + (var_39_0.cur_speed + var_39_0.cur_speed) * 0.5 * var_0_14.deltaTime

					local var_39_7, var_39_8 = self:__convert_to_pos(0, arg_39_1 - 1)

					self:__set_transform_pos(self._game_team_list[arg_39_1], -var_39_0.displacement, 0)

					if var_39_0.cur_time >= var_39_0.jump_time then
						var_39_0.state = (var_39_0.state + 1) % 5
						var_39_0.cur_time = 0
						var_39_0.change_ani = 3
						var_39_0.need_reset = true
					elseif var_39_0.cur_time >= 1 then
						self:__role_up(arg_39_1, 0, 1, DG.Tweening.Ease.OutCubic)
					end
				end
			else
				var_39_0.state = (var_39_0.state + 1) % 5
				var_39_0.cur_time = 0
			end
		end

		if var_39_0.change_ani == 1 then
			self._car_furniture_list[arg_39_1]:set_furniture_animation(0, "start2", false)

			var_39_0.change_ani = 2

			self:__role_up(arg_39_1, 4, 1, DG.Tweening.Ease.InOutQuad)
		end

		if var_39_0.need_reset then
			self:__set_car_move_info(arg_39_1, var_39_0.displacement)
			self._car_furniture_list[arg_39_1]:set_furniture_animation(0, "start", true)
		end
	end

	function arg_1_0:__role_up(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
		local var_40_0 = var_0_9.find_object_by_cid(self._car_list[arg_40_1])

		self._game_team_list[arg_40_1].role.rectTransform:DOMoveY(Vector2(self:__convert_to_pos(0, (arg_40_1 - 1) * 11 + var_0_3.dormitory_race_car_sit_config[self._car_list[arg_40_1]].delta_grid_y + arg_40_2)).y, arg_40_3):SetEase(arg_40_4)
	end

	function arg_1_0.__change_canvas_group_state(arg_41_0, arg_41_1, arg_41_2)
		arg_41_1.canvasGroup.alpha = arg_41_2 and 1 or 0
		arg_41_1.canvasGroup.interactable = arg_41_2
		arg_41_1.canvasGroup.blocksRaycasts = arg_41_2
	end

	function arg_1_0:__set_select_animation(arg_42_1, arg_42_2)
		arg_42_1.AnimationState:SetAnimation(0, self._team_animation_list[arg_42_2], true)

		arg_42_1.AnimationState.Complete = arg_42_1.AnimationState.Complete + function(arg_43_0)
			self._team_animation_list[arg_42_2] = self._team_animation_list[arg_42_2] == "stand1" and "hello" or "stand1"

			arg_42_1.AnimationState:ClearTracks()
			arg_42_1.AnimationState:SetAnimation(0, self._team_animation_list[arg_42_2], true)
		end
	end

	function arg_1_0:__onReset()
		for iter_44_0, iter_44_1 in pairs(self._layer_list) do
			self:__change_canvas_group_state(iter_44_1, false)
		end

		for iter_44_2, iter_44_3 in pairs(self._game_team_list) do
			self:__set_transform_pos(iter_44_3, 0, 7.5 * (iter_44_2 - 1))
		end

		self:__reset_game()
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_45_0)
	local var_45_0 = var_0_1:class("dormitory_game")

	var_45_0._user_data = nil
	var_45_0._race_data = nil
	var_45_0._is_already_init = false
	var_45_0._layer_list = {}
	var_45_0._team_list = {}
	var_45_0._dormitory = nil
	var_45_0._have_circuit = false
	var_45_0._have_three_car = false
	var_45_0._race_car_list = {}
	var_45_0._now_race_car_list = {}
	var_45_0._my_select_car_index = nil
	var_45_0._end_car_num = 0
	var_45_0._had_get_buff = false
	var_45_0._canvas_scale = 1
	var_45_0._delta_screen_width = 0
	var_45_0._delta_screen_height = 0
	var_45_0.restart_list = nil

	return var_45_0
end

return var_0_0
