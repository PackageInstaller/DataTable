local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = string.format
local var_0_3 = gameconfig.map_node_config
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.UILoader
local var_0_6 = gamecore.BattleManager
local var_0_7 = gamecore.user

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:init_bg(arg_2_1)
		if arg_2_1.bg_sea then
			self._bg_sea = arg_2_1.bg_sea

			local var_2_0 = var_0_1.UserData:getKeyData(var_0_4.setting_key_list.setting_battle_scene)
			local var_2_1 = true

			if var_2_0 ~= "" and var_2_0 ~= " " then
				var_2_1 = var_0_1.json_decode(var_2_0).value
			end

			self._bg_sea = var_2_1 and arg_2_1.bg_sea ~= "BG_Boss_Battle_1" and arg_2_1.bg_sea or not var_2_1 and arg_2_1.bg_sea == "BG_Boss_Battle_1" and "BG_Boss_Battle" or not var_2_1 and arg_2_1.bg_sea ~= "BG_Boss_Battle_1" and arg_2_1.bg_sea ~= "BG_sea_Normal_1" and arg_2_1.bg_sea or "BG_sea_Normal"

			var_0_7:set_boss_hp_info(arg_2_1.boss_info)
		elseif arg_2_1.boss_info then
			self:_more_than_one_boss(arg_2_1)
			var_0_7:set_boss_hp_info(arg_2_1.boss_info)

			self._bg_sea = "BG_Boss_Battle"
		else
			var_0_7:set_boss_hp_info(nil)

			self._bg_sea = "BG_East_China_Sea"
		end

		self._unit_camera_obj = UnityEngine.GameObject.Find("UnitCamera")

		local var_2_2 = UnityEngine.GameObject.Find("sea")
		local var_2_3 = var_0_4.bg_spine.bg_day_path

		if self._battle_scene:get_fight_type() == gameenum.battle_type.main and var_0_3.find_object_by_id((self._battle_scene:get_battle_point())).night_atk == 1 then
			self._is_night_point = true
			var_2_3 = var_0_4.bg_spine.bg_night_path
		end

		self._sea = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.bg_spine.sea_path)))

		self._sea.transform:SetParent(var_2_2.transform, false)

		self._sky = var_0_6:createBattleGameObject(self:get_sky_path(var_2_3, self._bg_sea))

		self._sky.transform:SetParent(var_2_2.transform, false)
		self:init_weather_front(var_2_2)

		local var_2_4 = var_0_4.bg_spine[var_0_2("%s_day", self._bg_sea)]

		self._sea.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).AnimationState:SetAnimation(var_2_4.priority, var_2_4.name, var_2_4.loop)

		self._undersea = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.bg_spine.bg_submarine)))

		self._undersea.transform:SetParent(UnityEngine.GameObject.Find("undersea").transform, false)

		self._sea.transform.localScale = Vector3.New(1, 1, 1)
		self._sky.transform.localScale = Vector3.New(1, 1, 1)
		self._current_y = 5.3
		self._current_z = 6.9

		if arg_2_1.has_submarine then
			self._sea.transform.localScale = Vector3.New(1, -0.131941, 1)
			self._sky.transform.localScale = Vector3.New(1, 0.622685, 1)
			self._current_y = -0.490867
			self._current_z = 8.70058

			self:update_background(true)

			if self._bad_weather and not self._bad_weather:Equals(nil) then
				self._bad_weather.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 0
			end

			self:delay(1300, function()
				self:switch_to_sea()
			end)
		end
	end

	function arg_1_0._more_than_one_boss(arg_4_0, arg_4_1)
		if var_0_7:get_new_battle_type() == gameenum.battle_type.fight_type.score and var_0_7:is_score_map_pass(var_0_7:get_battle_info().id) then
			var_0_7:set_score_map_pass(true)
		end
	end

	function arg_1_0:init_weather_front(arg_5_1)
		local var_5_0, var_5_1 = var_0_4:get_weather_front(self._bg_sea)
		local var_5_2 = 0
		local var_5_3

		if self._battle_scene:get_fight_type() == gameenum.battle_type.fight_type.strike then
			if var_0_7:get_save_weather() ~= 0 then
				var_5_2 = var_0_7:get_save_weather()

				for iter_5_0, iter_5_1 in pairs(var_0_4.strike_weather_num) do
					if var_5_2 == iter_5_1 then
						var_5_3 = iter_5_0
					end
				end
			end

			if var_5_3 then
				var_5_0 = var_0_4:get_weather_front(var_5_3)
			end
		end

		if not var_5_0 then
			return
		end

		self._strike_num = var_5_2

		if var_5_2 == var_0_4.strike_weather_num.BG_Polarnight then
			return
		end

		self._bad_weather = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(string.format(var_0_4.weather_type.weather_front, var_5_0))))

		if self._bad_weather and not self._bad_weather:Equals(nil) then
			self._bad_weather.layer = 5

			self._bad_weather.transform:SetParent(arg_5_1.transform)

			if var_5_2 == var_0_4.strike_weather_num.BG_Fog then
				self._bad_weather.transform.position = Vector3.New(10, 8.5, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			elseif var_5_2 == var_0_4.strike_weather_num.BG_Bad_weather_Sea then
				self._bad_weather.transform.position = Vector3.New(-0.059, 5.64, 1)
				self._bad_weather.transform.localScale = Vector3.New(1.65, 1.43, 1)
			elseif var_5_2 == var_0_4.strike_weather_num.BG_Wind then
				self._bad_weather.transform.position = Vector3.New(1.3, 5.8, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			elseif var_5_2 == var_0_4.strike_weather_num.BG_Sun then
				self._bad_weather.transform.position = Vector3.New(-8.3, 4.5, 1)
			end

			if var_5_1 and self._bg_sea and self._bg_sea == var_5_1 then
				self._bad_weather.transform.position = Vector3.New(1.7, 7, 1)
				self._bad_weather.transform.localScale = Vector3.New(2, 2, 1)
			end
		end
	end

	function arg_1_0:change_night_bg()
		if not self._sea or not self._sky or not self._undersea then
			return
		end

		if self._strike_num == var_0_4.strike_weather_num.BG_Sun then
			self._bad_weather:SetActive(false)
		end

		if not self._is_night_point then
			var_0_6:destroyGameObject(self._sky)

			self._sky = var_0_6:createBattleGameObject(self:get_sky_path(var_0_4.bg_spine.bg_night_path, self._bg_sea))

			self._sky.transform:SetParent(UnityEngine.GameObject.Find("sea").transform, false)

			self._sky.transform.localScale = Vector3.New(1, self._sky.transform.localScale.y, 1)
		end

		local var_6_0 = var_0_4.bg_spine[var_0_2("%s_night", self._bg_sea)]

		self._sea.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).AnimationState:SetAnimation(var_6_0.priority, var_6_0.name, var_6_0.loop)
		self._undersea.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton:SetSkin("Night")
	end

	function arg_1_0:is_undersea()
		return self._scene_type == var_0_4.scene_type.undersea
	end

	function arg_1_0:is_switching()
		return self._is_switching
	end

	function arg_1_0.set_switching(arg_9_0, arg_9_1)
		arg_9_0._is_switching = arg_9_1
	end

	function arg_1_0:switch_to_sea()
		self._is_switching = true
		self._switch_target_y = 5.3
		self._scene_type = var_0_4.scene_type.sea

		if self._bad_weather and not self._bad_weather:Equals(nil) then
			self._bad_weather.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 1
		end
	end

	function arg_1_0:switch_to_undersea()
		self._is_switching = true
		self._switch_target_y = -0.490867
		self._scene_type = var_0_4.scene_type.undersea

		if self._bad_weather and not self._bad_weather:Equals(nil) then
			self._bad_weather.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 0
		end
	end

	function arg_1_0:update(arg_12_1)
		if not self._sea or not self._sky or not self._undersea then
			return
		end

		if self._sea:Equals(nil) or self._sky:Equals(nil) or self._undersea:Equals(nil) then
			return
		end

		if self._is_switching then
			local var_12_0 = 1.7999999999999998
			local var_12_1 = -0.12

			if self._switch_target_y > 0 then
				var_12_0 = -1 * var_12_0
				var_12_1 = -1 * var_12_1
			end

			local var_12_2 = 0.9 / (var_0_4.rad2deg * math.atan2(5.3, 6.9) / var_12_0)
			local var_12_4 = self._current_z
			local var_12_5 = self._current_y

			if self._current_y > 0 then
				var_12_4 = math.cos(var_0_4.deg2rad * var_12_0) * self._current_z + math.sin(var_0_4.deg2rad * var_12_0) * self._current_y
				var_12_5 = math.cos(var_0_4.deg2rad * var_12_0) * self._current_y - math.sin(var_0_4.deg2rad * var_12_0) * self._current_z
			else
				var_12_5 = self._current_y + var_12_1
			end

			if var_12_5 > -0.490867 and var_12_5 < 5.3 then
				self._current_z = var_12_4
				self._current_y = var_12_5
				self._sky.transform.localScale = Vector3.New(1, self._sky.transform.localScale.y - var_12_2 / 3, 1)
				self._sea.transform.localScale = Vector3.New(1, self._sea.transform.localScale.y - var_12_2, 1)
			else
				if var_12_5 >= 5.3 then
					self._current_y = 5.3
					self._current_z = 6.9
					self._sky.transform.localScale = Vector3.New(1, 1, 1)
					self._sea.transform.localScale = Vector3.New(1, 1, 1)
				else
					self._current_y = -0.490867
					self._current_z = 8.70058
					self._sky.transform.localScale = Vector3.New(1, 0.622685, 1)
					self._sea.transform.localScale = Vector3.New(1, -0.131941, 1)
				end

				if self._is_switching then
					self._is_switching = false
				end
			end
		end

		self:update_background(false, arg_12_1)
	end

	function arg_1_0:update_background(arg_13_1, arg_13_2)
		local var_13_0 = 60

		if not arg_13_1 then
			var_13_0 = arg_13_2 - self._last_frame_time
			self._last_frame_time = arg_13_2
		end

		local var_13_1 = 1

		if UnityEngine.Screen.width / UnityEngine.Screen.height <= 1.77 then
			var_13_1 = 1.2
		end

		if not self._unit_camera_obj:Equals(nil) and not self._sea:Equals(nil) and not self._sky:Equals(nil) and not self._undersea:Equals(nil) then
			local var_13_2 = Vector3.Lerp(self._unit_camera_obj.transform.position, Vector3(self._unit_camera_obj.transform.position.x, 0.78 - 14.85 * self._sky.transform.localScale.y * var_13_1 + 14.85 * self._sea.transform.localScale.y * var_13_1, self._unit_camera_obj.transform.position.z), var_13_0)
			local var_13_3 = Vector3.Lerp(self._sea.transform.position, Vector3(self._sea.transform.position.x, 2.642 + 0.57 * self._sky.transform.localScale.y - 0.57 * self._sea.transform.localScale.y, self._sea.transform.position.z), var_13_0)
			local var_13_4 = Vector3.Lerp(self._undersea.transform.position, Vector3(self._undersea.transform.position.x, -2.2 - 8.79 * self._sea.transform.localScale.y + 8.79 * self._sky.transform.localScale.y, self._undersea.transform.position.z), var_13_0)

			if arg_13_1 then
				var_13_2 = Vector3.New(self._unit_camera_obj.transform.position.x, 0.78 - 14.85 * self._sky.transform.localScale.y * var_13_1 + 14.85 * self._sea.transform.localScale.y * var_13_1, self._unit_camera_obj.transform.position.z)
				var_13_3 = Vector3.New(self._sea.transform.position.x, 2.642 + 0.57 * self._sky.transform.localScale.y - 0.57 * self._sea.transform.localScale.y, self._sea.transform.position.z)
				var_13_4 = Vector3.New(self._undersea.transform.position.x, -2.2 - 8.79 * self._sea.transform.localScale.y + 8.79 * self._sky.transform.localScale.y, self._undersea.transform.position.z)
			end

			self._unit_camera_obj.transform.position = var_13_2
			self._sea.transform.position = var_13_3
			self._undersea.transform.position = var_13_4
		end
	end

	function arg_1_0.get_sky_path(arg_14_0, arg_14_1, arg_14_2)
		arg_14_2 = arg_14_2 or "BG_sea_Normal"

		return (var_0_4:get_final_battle_prefab_path(arg_14_1, arg_14_2))
	end

	function arg_1_0.init_boss_hp(arg_15_0, arg_15_1)
		if not arg_15_1.boss_info then
			return
		end

		local var_15_0 = var_0_5:getInstance("battle")

		if not var_15_0 then
			return
		end

		arg_15_0._boss_max_hp = arg_15_1.boss_info.boss_max_hp

		if arg_15_1.boss_info.boss_now_hp == 0 then
			return
		end

		var_15_0:show_boss_hp(arg_15_1.boss_info.boss_now_hp, arg_15_1.boss_info.boss_max_hp, arg_15_1.point)

		arg_15_0.boss_damage = 0
	end

	function arg_1_0:update_boss_hp(arg_16_1, arg_16_2)
		if not arg_16_1 then
			return
		end

		if arg_16_2 and arg_16_2 == "mix_attack_first" then
			return
		end

		local var_16_0 = var_0_5:getInstance("battle")

		if not var_16_0 then
			return
		end

		if not arg_16_1.damage then
			return
		end

		if not arg_16_1.init_hp then
			return
		end

		self.boss_damage = self.boss_damage or 0
		self.boss_damage = self.boss_damage + arg_16_1.damage

		local var_16_1 = arg_16_1.init_hp - self.boss_damage

		var_16_1 = arg_16_1.init_hp - self.boss_damage > 0 and var_16_1 or 0

		var_16_0:show_boss_hp(var_16_1, self._boss_max_hp, nil, arg_16_1.can_not_dead)
	end
end

function var_0_0.extend_obj(arg_17_0)
	arg_17_0._sea = nil
	arg_17_0._bad_weather = nil
	arg_17_0._undersea = nil
	arg_17_0._current_y = 0
	arg_17_0._current_z = 0
	arg_17_0._is_switching = false
	arg_17_0._switch_target_y = 0
	arg_17_0._bg_sea = nil
	arg_17_0._scene_type = var_0_4.scene_type.sea
	arg_17_0._boss_max_hp = 0
	arg_17_0._is_night_point = false
	arg_17_0._last_frame_time = 0
	arg_17_0._last_boss_info = {}
end

return var_0_0
