local var_0_0 = {}
local var_0_3 = gameconfig.map_node_config
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.UILoader
local var_0_6 = gamecore.BattleRevampManager
local var_0_7 = gamecore.user
local var_0_9 = lan_rand
local var_0_10 = UnityEngine.Quaternion
local var_0_11 = UnityEngine.Screen

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:init_bg_3d(arg_2_1)
		self._unit_camera_obj = UnityEngine.GameObject.Find("UnitCamera")

		if arg_2_1.bg_sea then
			self._bg_sea = arg_2_1.bg_sea

			var_0_7:set_boss_hp_info(arg_2_1.boss_info)
		elseif arg_2_1.boss_info then
			self:_more_than_one_boss(arg_2_1)
			var_0_7:set_boss_hp_info(arg_2_1.boss_info)

			self._bg_sea = "BG_Boss_Battle"
		else
			var_0_7:set_boss_hp_info(nil)

			self._bg_sea = "BG_East_China_Sea"
		end

		if self._battle_scene:get_fight_type() == gameenum.battle_type.main and var_0_3.find_object_by_id((self._battle_scene:get_battle_point())).night_atk == 1 then
			self._is_night_point = true
		end

		local var_2_0 = var_0_6:createBattleGameObject(self:get_sky_path(var_0_4.effect_revamp_battle.water_path, self._bg_sea))

		if not var_2_0 then
			return
		end

		var_2_0.transform:SetParent(self.transform, false)

		self._water = var_2_0
		self._day = var_2_0.transform:Find("Day").gameObject
		self._night = var_2_0.transform:Find("Night").gameObject
		self._day_eff = var_2_0.transform:Find("Day/wtz_zhongjing_root")
		self._night_eff = var_2_0.transform:Find("Night/wtz_zhongjing_root")
		self._unit_root = UnityEngine.GameObject.Find("sea/unit")
		self._player_root = UnityEngine.GameObject.Find("sea/unit/player")
		self._enmey_root = UnityEngine.GameObject.Find("sea/unit/enemy")

		local var_2_1 = UnityEngine.Shader.Find("DCG/Water Shader/Water Surface OpenGL")
		local var_2_2 = var_2_0.transform:Find("Day/bg_haimian")
		local var_2_3 = var_2_0.transform:Find("Night/bg_haimian")

		if var_2_2 then
			var_2_2.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).material.shader = var_2_1
			var_2_0.transform:Find("Day/bg_shuixia").transform:GetComponent(typeof(UnityEngine.MeshRenderer)).material.shader = var_2_1
		end

		if var_2_3 then
			var_2_3.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).material.shader = var_2_1
			var_2_0.transform:Find("Night/bg_shuixia").transform:GetComponent(typeof(UnityEngine.MeshRenderer)).material.shader = var_2_1
		end

		if arg_2_1.has_submarine then
			self._unit_root.transform.position = Vector3.New(0, 2, 0)
			self._unit_camera_obj.transform.position = Vector3.New(0, -11.3, -30.8)

			self:delay(1300, function()
				self:switch_to_sea()
			end)
		end

		self._eff_posY = 0

		self:set_screen_fov()

		self._camera_posY = 0.76

		self._day:SetActive(true)
		self._night:SetActive(false)
		self:init_weather_front((UnityEngine.GameObject.Find("sea")))
	end

	function arg_1_0:set_screen_fov()
		if var_0_11.width / var_0_11.height < var_0_4.screen_ratio then
			self._eff_posY = -1.8
			self._day_eff.transform.position = Vector3.New(0, self._eff_posY, 0)
			self._night_eff.transform.position = Vector3.New(0, self._eff_posY, 0)
		end
	end

	function arg_1_0._more_than_one_boss(arg_5_0, arg_5_1)
		if var_0_7:get_new_battle_type() == gameenum.battle_type.fight_type.score and var_0_7:is_score_map_pass(var_0_7:get_battle_info().id) then
			var_0_7:set_score_map_pass(true)
		end
	end

	function arg_1_0:init_weather_front(arg_6_1)
		local var_6_0, var_6_1 = var_0_4:get_weather_front(self._bg_sea)
		local var_6_2 = 0
		local var_6_3

		if self._battle_scene:get_fight_type() == gameenum.battle_type.fight_type.strike then
			if var_0_7:get_save_weather() ~= 0 then
				var_6_2 = var_0_7:get_save_weather()

				for iter_6_0, iter_6_1 in pairs(var_0_4.strike_weather_num) do
					if var_6_2 == iter_6_1 then
						var_6_3 = iter_6_0
					end
				end
			end

			if var_6_3 then
				var_6_0 = var_0_4:get_weather_front(var_6_3)
			end
		end

		if not var_6_0 then
			return
		end

		self._strike_num = var_6_2

		if var_6_2 == var_0_4.strike_weather_num.BG_Polarnight then
			return
		end

		self._bad_weather = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(string.format(var_0_4.weather_type.weather_front, var_6_0))))

		if self._bad_weather and not self._bad_weather:Equals(nil) then
			self._bad_weather.layer = 5

			self._bad_weather.transform:SetParent(arg_6_1.transform)

			if var_6_2 == var_0_4.strike_weather_num.BG_Fog then
				self._bad_weather.transform.position = Vector3.New(10, 8.5, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			elseif var_6_2 == var_0_4.strike_weather_num.BG_Bad_weather_Sea then
				self._bad_weather.transform.position = Vector3.New(-0.059, 5.64, 1)
				self._bad_weather.transform.localScale = Vector3.New(1.65, 1.43, 1)
			elseif var_6_2 == var_0_4.strike_weather_num.BG_Wind then
				self._bad_weather.transform.position = Vector3.New(1.3, 5.8, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			elseif var_6_2 == var_0_4.strike_weather_num.BG_Sun then
				self._bad_weather.transform.position = Vector3.New(-8.3, 4.5, 1)
			end

			if var_6_1 and self._bg_sea and self._bg_sea == var_6_1 then
				self._bad_weather.transform.position = Vector3.New(1.7, 7, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			end
		end
	end

	function arg_1_0:change_middle_step()
		for iter_7_0 = 1, self._player_root.transform.childCount do
			self:delay(iter_7_0 == 1 and 0 or var_0_9(200, 500), function()
				local var_8_0 = self._player_root.transform:GetChild(iter_7_0 - 1).gameObject
				local var_8_1 = var_8_0.transform.localPosition.x

				var_8_0.transform.localRotation = var_0_10.Euler(0, 0, -15)

				var_8_0.transform:DOLocalMoveX(var_8_0.transform.localPosition.x + 1.8, 0.8):OnComplete(function()
					var_8_0.transform:DOLocalMoveX(var_8_1, 0.4)

					var_8_0.transform.localRotation = var_0_10.Euler(0, 0, 0)
				end)
			end)
		end

		for iter_7_1 = 1, self._enmey_root.transform.childCount do
			self:delay(iter_7_1 == 1 and 0 or var_0_9(200, 500), function()
				local var_10_0 = self._enmey_root.transform:GetChild(iter_7_1 - 1).gameObject
				local var_10_1 = var_10_0.transform.localPosition.x

				var_10_0.transform.localRotation = var_0_10.Euler(0, 0, 15)

				var_10_0.transform:DOLocalMoveX(var_10_0.transform.localPosition.x - 1.8, 0.8):OnComplete(function()
					var_10_0.transform:DOLocalMoveX(var_10_1, 0.4)

					var_10_0.transform.localRotation = var_0_10.Euler(0, 0, 0)
				end)
			end)
		end
	end

	function arg_1_0:change_middle_step_1()
		local var_12_0 = 0

		for iter_12_0 = 1, self._player_root.transform.childCount do
			if iter_12_0 == 1 then
				var_12_0 = 0
			else
				var_12_0 = var_0_9(500, 850)
				var_12_0 = var_12_0 / 1000
			end

			local var_12_1 = self._player_root.transform:GetChild(iter_12_0 - 1).gameObject
			local var_12_2 = var_12_1.transform.localPosition.x
			local var_12_3 = var_12_1.transform:DOLocalMoveX(var_12_1.transform.localPosition.x + 1.8, var_12_0)

			var_12_1.transform.localRotation = var_0_10.Euler(0, 0, -12)

			var_12_3:OnComplete(function()
				var_12_1.transform:DOLocalMoveX(var_12_2, var_12_0 / 2)

				var_12_1.transform.localRotation = var_0_10.Euler(0, 0, 0)
			end)
		end

		for iter_12_1 = 1, self._enmey_root.transform.childCount do
			if iter_12_1 == 1 then
				var_12_0 = 0
			else
				var_12_0 = var_0_9(500, 850)
				var_12_0 = var_12_0 / 1000
			end

			local var_12_4 = self._enmey_root.transform:GetChild(iter_12_1 - 1).gameObject
			local var_12_5 = var_12_4.transform.localPosition.x
			local var_12_6 = var_12_4.transform:DOLocalMoveX(var_12_4.transform.localPosition.x - 1.8, var_12_0)

			var_12_4.transform.localRotation = var_0_10.Euler(0, 0, 12)

			var_12_6:OnComplete(function()
				var_12_4.transform:DOLocalMoveX(var_12_5, var_12_0 / 2)

				var_12_4.transform.localRotation = var_0_10.Euler(0, 0, 0)
			end)
		end
	end

	function arg_1_0:change_night_bg()
		local var_15_0 = var_0_5:getInstance(var_0_4:get_battle_name())

		if not var_15_0 or self._is_night_war then
			return
		end

		if self._strike_num == var_0_4.strike_weather_num.BG_Sun then
			self._bad_weather:SetActive(false)
		end

		local var_15_1 = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.effect_revamp_battle_mask.path, true, true)))

		if not var_15_1 then
			return
		end

		var_15_1.transform.localScale = Vector3.New(1.5, 3, 1.5)
		var_15_1.transform.localPosition = Vector3.New(0, 0, 10)

		var_15_1.transform:SetParent(var_15_0.transform, false)

		self._is_night_war = true

		self:delay(700, function()
			self._night:SetActive(true)
			self._day:SetActive(false)

			self._player_root.transform.localPosition = Vector3.New(-10, 0, 0)
			self._enmey_root.transform.localPosition = Vector3.New(10, 0, 0)
		end)
		self:delay(1100, function()
			local var_17_0 = self._player_root.transform:DOLocalMoveX(0, 0.8)
			local var_17_1 = self._enmey_root.transform:DOLocalMoveX(0, 0.8)
		end)
	end

	function arg_1_0:is_undersea()
		return self._scene_type == var_0_4.scene_type.undersea
	end

	function arg_1_0:is_switching()
		return self._is_switching
	end

	function arg_1_0.set_switching(arg_20_0, arg_20_1)
		arg_20_0._is_switching = arg_20_1
	end

	function arg_1_0:switch_to_sea()
		self._camera_posY = 0.78
		self._is_switching = true
		self._switch_target_y = 5.3
		self._scene_type = var_0_4.scene_type.sea

		if self._unit_camera_obj then
			self._day_eff.transform:DOMove(Vector3.New(0, self._eff_posY, 0), 0.5)
			self._night_eff.transform:DOMove(Vector3.New(0, self._eff_posY, 0), 0.5)
			self._unit_root.transform:DOMove(Vector3.New(0, -0.18, 0), 0.5)
			self._unit_camera_obj.transform:DOMove(Vector3.New(0, 0.78, -30.8), 0.6)
		end
	end

	function arg_1_0:switch_to_undersea()
		self._camera_posY = -11.3
		self._is_switching = true
		self._switch_target_y = -0.490867
		self._scene_type = var_0_4.scene_type.undersea

		if self._unit_camera_obj then
			self._day_eff.transform:DOMove(Vector3.New(0, 2, 0), 0.5)
			self._night_eff.transform:DOMove(Vector3.New(0, 2, 0), 0.5)
			self._unit_root.transform:DOMove(Vector3.New(0, 2, 0), 0.5)
			self._unit_camera_obj.transform:DOMove(Vector3.New(0, self._camera_posY, -30.8), 0.6)
		end
	end

	function arg_1_0:update(arg_23_1)
		do return end

		if self._is_switching then
			local var_23_0 = 1.7999999999999998
			local var_23_1 = -0.12

			if self._switch_target_y > 0 then
				var_23_0 = -1 * var_23_0
				var_23_1 = -1 * var_23_1
			end

			local var_23_2 = 0.9 / (var_0_4.rad2deg * math.atan2(5.3, 6.9) / var_23_0)
			local var_23_4 = var_0_4.deg2rad * var_23_0
			local var_23_5 = self._current_z
			local var_23_6 = self._current_y

			if self._current_y > 0 then
				var_23_5 = math.cos(var_23_4) * self._current_z + math.sin(var_23_4) * self._current_y
				var_23_6 = math.cos(var_23_4) * self._current_y - math.sin(var_23_4) * self._current_z
			else
				var_23_6 = self._current_y + var_23_1
			end

			if var_23_6 > -0.490867 and var_23_6 < 5.3 then
				self._current_z = var_23_5
				self._current_y = var_23_6
			else
				if var_23_6 >= 5.3 then
					self._current_y = 5.3
					self._current_z = 6.9
				else
					self._current_y = -0.490867
					self._current_z = 8.70058
				end

				if self._is_switching then
					self._is_switching = false
				end
			end

			self:update_background(false, arg_23_1)
		end
	end

	function arg_1_0:update_background(arg_24_1, arg_24_2)
		local var_24_0 = 60

		if not arg_24_1 then
			var_24_0 = arg_24_2 - self._last_frame_time
			self._last_frame_time = arg_24_2
		end

		if UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.77 then
			-- block empty
		end

		if not self._unit_camera_obj:Equals(nil) then
			local var_24_3 = Vector3.Lerp(self._unit_camera_obj.transform.position, Vector3(self._unit_camera_obj.transform.position.x, self._camera_posY, self._unit_camera_obj.transform.position.z), var_24_0)

			if arg_24_1 then
				self._unit_camera_obj.transform.position = Vector3.New(self._unit_camera_obj.transform.position.x, self._camera_posY, self._unit_camera_obj.transform.position.z)
			end
		end
	end

	function arg_1_0.get_sky_path(arg_25_0, arg_25_1, arg_25_2)
		arg_25_2 = arg_25_2 or "BG_sea_Normal"

		return (var_0_4:get_final_battle_prefab_path(arg_25_1, arg_25_2, true))
	end

	function arg_1_0.init_boss_hp(arg_26_0, arg_26_1)
		if not arg_26_1.boss_info then
			return
		end

		local var_26_0 = var_0_5:getInstance(var_0_4:get_battle_name())

		if not var_26_0 then
			return
		end

		arg_26_0._boss_max_hp = arg_26_1.boss_info.boss_max_hp

		if arg_26_1.boss_info.boss_now_hp == 0 then
			return
		end

		var_26_0:show_boss_hp(arg_26_1.boss_info.boss_now_hp, arg_26_1.boss_info.boss_max_hp, arg_26_1.point)

		arg_26_0.boss_damage = 0
	end

	function arg_1_0:update_boss_hp(arg_27_1)
		if not arg_27_1 then
			return
		end

		local var_27_0 = var_0_5:getInstance(var_0_4:get_battle_name())

		if not var_27_0 then
			return
		end

		if not arg_27_1.damage then
			return
		end

		if not arg_27_1.init_hp then
			return
		end

		self.boss_damage = self.boss_damage or 0
		self.boss_damage = self.boss_damage + arg_27_1.damage

		local var_27_1 = arg_27_1.init_hp - self.boss_damage

		var_27_1 = arg_27_1.init_hp - self.boss_damage > 0 and var_27_1 or 0

		var_27_0:show_boss_hp(var_27_1, self._boss_max_hp, nil, arg_27_1.can_not_dead)
	end
end

function var_0_0.extend_obj(arg_28_0)
	arg_28_0._sea = nil
	arg_28_0._bad_weather = nil
	arg_28_0._undersea = nil
	arg_28_0._current_y = 0
	arg_28_0._current_z = 0
	arg_28_0._is_switching = false
	arg_28_0._switch_target_y = 0
	arg_28_0._bg_sea = nil
	arg_28_0._scene_type = var_0_4.scene_type.sea
	arg_28_0._boss_max_hp = 0
	arg_28_0._is_night_point = false
	arg_28_0._last_frame_time = 0
	arg_28_0._water = nil
	arg_28_0._is_night_war = false
end

return var_0_0
