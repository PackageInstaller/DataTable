local var_0_0 = {}
local var_0_1 = lx
local var_0_5 = lx.json_encode
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.UILoader
local var_0_11 = gameconfig.cinema_story_id_list_config
local var_0_12 = gamecore.BattleRevampManager
local var_0_13 = table.insert

lx.define_class("battle_revamp_processor", function(arg_1_0)
	function arg_1_0:onEvent(arg_2_1)
		if not arg_2_1 or not arg_2_1.type then
			return
		end

		local var_2_0 = string.format("__onEvent_%s_%s", arg_2_1.name, arg_2_1.type)

		if not self[var_2_0] then
			return
		end

		self[var_2_0](self, arg_2_1.id, arg_2_1.info)
	end

	function arg_1_0.eventOnRecord(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		var_0_12:setBattleResult(arg_3_2)
		var_0_12:setBattleDamageResult(arg_3_3)
	end

	function arg_1_0.eventOnNightRecord(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		var_0_12:setBattleResult(arg_4_2)
		var_0_12:setBattleDamageResult(arg_4_3)
	end

	function arg_1_0.eventOnBattleFinish(arg_5_0, arg_5_1)
		arg_5_0._check_result = var_0_5(arg_5_1)
	end

	function arg_1_0.eventOnBattleStep(arg_6_0, arg_6_1)
		local var_6_0 = var_0_7:getInstance(var_0_6:get_battle_name())

		if not var_6_0 then
			return
		end

		var_6_0:show_stage_step(arg_6_1)
	end

	function arg_1_0:eventOnBattleScene(arg_7_1)
		local var_7_0 = var_0_7:getInstance(var_0_6:get_battle_name())

		if not var_7_0 then
			return
		end

		if self._battle_scene:get_radar_state() then
			var_7_0:attach_buff("player", 901)
		end

		local var_7_1 = self:__get_data(var_0_6.setting_key_list.setting_battle_scene)

		if var_0_6:get_is_new_battle() then
			if var_7_1 ~= "" and var_7_1 then
				self:init_bg_3d(arg_7_1)
			elseif var_7_1 == "" then
				self:init_bg_3d(arg_7_1)
			else
				self:init_bg_3d(arg_7_1)
			end
		else
			self:init_bg(arg_7_1)
		end

		self:init_hook(arg_7_1)
		self:init_boss_hp(arg_7_1)
		self:init_visual_queue(arg_7_1)
	end

	function arg_1_0.__get_data(arg_8_0, arg_8_1)
		local var_8_0 = var_0_1.UserData:getKeyData(arg_8_1)

		if var_8_0 ~= "" then
			var_8_0 = var_0_1.json_decode(var_8_0).value
		end

		return var_8_0
	end

	function arg_1_0:eventOnShowBattleCourse()
		local var_9_0 = var_0_7:getInstance(var_0_6:get_battle_name())

		if not var_9_0 then
			return
		end

		var_9_0:set_formation(self._battle_scene:get_player_formation(), (self._battle_scene:get_enemy_formation()))
		var_9_0:set_direction(self._battle_scene:get_player_course(), (self._battle_scene:get_enemy_course()))
	end

	function arg_1_0:__onEvent_character_register(arg_10_1, arg_10_2)
		self.visual_pos_list[arg_10_1] = self:create_visual(gamecore.character_visual, (self._battle_obj_mgr:findObject(arg_10_1)))
	end

	function arg_1_0:__onEvent_aircraft_register(arg_11_1, arg_11_2)
		self:create_visual(gamecore.aircraft_visual, (self._battle_obj_mgr:findObject(arg_11_1)))
	end

	function arg_1_0:__onEvent_missile_register(arg_12_1, arg_12_2)
		self:create_visual(gamecore.missile_visual, (self._battle_obj_mgr:findObject(arg_12_1)))
	end

	function arg_1_0:__onEvent_projectile_register(arg_13_1, arg_13_2)
		self:create_visual(gamecore.projectile_visual, (self._battle_obj_mgr:findObject(arg_13_1)))
	end

	function arg_1_0:__onEvent_booster_register(arg_14_1, arg_14_2)
		self:create_visual(gamecore.booster_visual, (self._battle_obj_mgr:findObject(arg_14_1)))
	end

	function arg_1_0:__onEvent_bomb_register(arg_15_1, arg_15_2)
		self:create_visual(gamecore.bomb_visual, (self._battle_obj_mgr:findObject(arg_15_1)))
	end

	function arg_1_0:__onEvent_torpedo_register(arg_16_1, arg_16_2)
		self:create_visual(gamecore.torpedo_visual, (self._battle_obj_mgr:findObject(arg_16_1)))
	end

	function arg_1_0:__onEvent_depthcharge_register(arg_17_1, arg_17_2)
		self:create_visual(gamecore.depthcharge_visual, (self._battle_obj_mgr:findObject(arg_17_1)))
	end

	function arg_1_0.__onEvent_cinema_dialog(arg_18_0, arg_18_1)
		local var_18_0 = var_0_11.find_object_by_id(arg_18_1.movie[3][1])

		var_0_7:createInstance("cinema_dialog"):show(var_18_0.movie_group_id, var_18_0.movie_id[1], var_18_0.movie_id[2], 3, true)
	end

	function arg_1_0:eventOnFrame(arg_19_1)
		if self._pause then
			if not self._record_pause_time then
				self._record_pause_time = arg_19_1

				self:__set_spine_pause()

				self._is_reset_spine = true
			end

			return
		end

		self._record_const_time = self._record_const_time or arg_19_1

		if self._record_pause_time then
			self:__set_spine_resume()

			self._is_reset_spine = false
			arg_19_1 = arg_19_1 - (arg_19_1 - self._record_pause_time)
			self._record_pause_time = self._record_pause_time + self._record_const_time
		end

		self:__run_delay()
		self:__eventOnFrame(arg_19_1)
		self:update(arg_19_1)
	end

	function arg_1_0:eventOnDestroy()
		self:__release_do_tween()
		self:kill_all_visual()

		for iter_20_0, iter_20_1 in pairs(self._visual_set) do
			iter_20_1:eventOnDestroy()
		end

		self._visual_set = {}
		self._delay_table = {}
		self._pause = false

		self:release_hook()

		self._battlefield = nil
		self._battle_time = nil
		self._battle_scene = nil
		self._battle_obj_mgr = nil
		self._battle_random = nil
	end

	function arg_1_0.bind(arg_21_0, arg_21_1)
		arg_21_0._battlefield = arg_21_1
		arg_21_0._battle_time = arg_21_1:getBattleTime()
		arg_21_0._battle_scene = arg_21_1:getBattleScene()
		arg_21_0._battle_obj_mgr = arg_21_1:getBattleObjectManager()
		arg_21_0._battle_random = arg_21_1:getBattleRandom()
	end

	function arg_1_0:delay(arg_22_1, arg_22_2)
		self._delay_table = self._delay_table or {}

		if not self._battle_time then
			return
		end

		self._delay_table[arg_22_2] = {
			interval = 0,
			count = 0,
			is_delayed = false,
			start = self._battle_time:getTime(),
			delay = arg_22_1
		}
	end

	function arg_1_0:schedule(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
		self._delay_table[arg_23_4] = {
			is_delayed = false,
			start = self._battle_time:getTime(),
			delay = arg_23_1,
			interval = arg_23_2,
			count = arg_23_3
		}
	end

	function arg_1_0:clear(arg_24_1)
		self._delay_table[arg_24_1] = nil
	end

	function arg_1_0:__run_delay()
		local var_25_0 = self._battle_time:getTime()

		for iter_25_0, iter_25_1 in pairs(self._delay_table or {}) do
			if not iter_25_1.is_delayed and var_25_0 >= iter_25_1.start + iter_25_1.delay then
				iter_25_1.is_delayed = true
				iter_25_1.start = var_25_0

				iter_25_0()

				if iter_25_1.count == 0 or iter_25_1.interval == 0 then
					self._delay_table[iter_25_0] = nil
				elseif iter_25_1.count > 0 then
					iter_25_1.count = iter_25_1.count - 1

					if iter_25_1.count == 0 then
						self._delay_table[iter_25_0] = nil
					end
				end
			elseif iter_25_1.is_delayed and var_25_0 >= iter_25_1.start + iter_25_1.interval then
				iter_25_1.start = var_25_0

				iter_25_0()

				if iter_25_1.count > 0 then
					iter_25_1.count = iter_25_1.count - 1

					if iter_25_1.count <= 0 then
						self._delay_table[iter_25_0] = nil
					end
				end
			end
		end
	end

	function arg_1_0:__set_spine_pause()
		for iter_26_0, iter_26_1 in pairs(self._visual_set) do
			iter_26_1:pause()
		end
	end

	function arg_1_0:__set_spine_resume()
		if self._is_reset_spine then
			for iter_27_0, iter_27_1 in pairs(self._visual_set) do
				iter_27_1:resume()
			end
		end
	end

	function arg_1_0:pause_frame()
		self._pause_num = (self._pause_num or 0) + 1
		self._pause = true
	end

	function arg_1_0:resume_frame()
		local var_29_1 = math.max((self._pause_num or 0) - 1, 0)

		self._pause_num = var_29_1
		self._pause = var_29_1 > 0
	end

	function arg_1_0:autoKillDOTween(arg_30_1)
		var_0_13(self._do_tween_list, arg_30_1)

		return arg_30_1
	end

	function arg_1_0:__release_do_tween()
		for iter_31_0, iter_31_1 in pairs(self._do_tween_list) do
			iter_31_1:Kill()
		end

		self._do_tween_list = {}
	end

	function arg_1_0:checkInit()
		if self._do_tween_list == nil then
			self._do_tween_list = {}
		end
	end

	gamecore.extend_method(arg_1_0)
end)

function var_0_0.create(arg_33_0)
	local var_33_0 = var_0_1.class("battle_revamp_processor")

	var_33_0._battlefield = nil
	var_33_0._battle_time = nil
	var_33_0._battle_scene = nil
	var_33_0._battle_obj_mgr = nil
	var_33_0._battle_random = nil
	var_33_0._delay_table = nil
	var_33_0.visual_pos_list = {}
	var_33_0._do_tween_list = {}

	gamecore.extend_obj(var_33_0)

	return var_33_0
end

return var_0_0
