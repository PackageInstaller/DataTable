local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gamecore.BattleManager
local var_0_5 = gameenum.common_type
local var_0_6 = 4.19
local var_0_7 = 0.22

lx.define_class("torpedo_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:create_torpedo(arg_3_1)
		local var_3_0 = var_0_5.weapon_spine

		if arg_3_1 == "undersea_torpedo" or arg_3_1 == "torpedo" or arg_3_1 == "undersea_torpedo_special" then
			var_3_0 = var_0_5.effect_spine
		end

		self._torpedo = var_0_4:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_3_0.path)))
		self._torpedo_skele = self._torpedo.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		self._torpedo_skele.AnimationState:SetAnimation(var_3_0[arg_3_1 or "torpedo"].priority, var_3_0[arg_3_1 or "torpedo"].name, var_3_0[arg_3_1 or "torpedo"].loop)

		self._day_or_night = self._battle_scene:get_day_or_night_attack()
	end

	function arg_1_0:set_event_listener(arg_4_1, arg_4_2)
		self._torpedo_skele.AnimationState.Event = self._torpedo_skele.AnimationState.Event + function(arg_5_0, arg_5_1)
			if arg_5_1.Data.Name == arg_4_1 then
				if not self._torpedo_skele or self._torpedo_skele:Equals(nil) then
					return
				end

				if arg_4_2 then
					arg_4_2()
				end
			end
		end
	end

	function arg_1_0:set_parent(arg_6_1)
		self._torpedo.transform:SetParent(arg_6_1.transform, false)
	end

	function arg_1_0:set_pos(arg_7_1)
		self._torpedo.transform.position = arg_7_1
		self._torpedo.transform.localScale = Vector3.New(self._side, 1, 1)
	end

	function arg_1_0.set_velocity(arg_8_0, arg_8_1)
		arg_8_0._velocity = arg_8_1
	end

	function arg_1_0.set_call_func(arg_9_0, arg_9_1)
		arg_9_0._after_attack = arg_9_1
	end

	function arg_1_0:fire_target_in_air(arg_10_1, arg_10_2)
		local var_10_0 = self._battle_processor:find_visual(arg_10_1)

		if not var_10_0 then
			return
		end

		self._target_id = arg_10_1
		self._is_miss = arg_10_2
		self._enable_move = true
		self._target_pos = var_10_0:get_damage_point().transform.position - Vector3.New(0, 0.3, 0)
		self._velocity.x = self._side * 1.2
		self._velocity.y = -5
		self._torpedo_state = var_0_5.torpedo_state.in_air
	end

	function arg_1_0:fire_target_in_sea(arg_11_1, arg_11_2)
		local var_11_0 = self._battle_processor:find_visual(arg_11_1)

		if not var_11_0 then
			return
		end

		self._target_id = arg_11_1
		self._target_pos = var_11_0:get_position()
		self._torpedo_state = var_0_5.torpedo_state.in_sea

		self._torpedo.gameObject:SetActive(false)

		if self._is_miss then
			self._target_pos.x = self._target_pos.x + self._side * 0.8
		end

		local var_11_1 = var_0_5.effect_spine

		self._sea_effect = var_0_4:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.effect_spine.path)))

		local var_11_2 = self._sea_effect.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		self._weapon_on_water = var_11_2
		self._track = arg_11_2 and var_11_2.AnimationState:SetAnimation(0, var_11_1.torpedo_wave_at_sea_by_air.name, var_11_1.torpedo_wave_at_sea_by_air.loop) or var_11_2.AnimationState:SetAnimation(0, var_11_1.torpedo_wave_at_sea_by_air.name, var_11_1.torpedo_wave_at_sea_by_air.loop)

		local var_11_3 = Vector3(self._torpedo.transform.position.x + self._side * var_0_6, self._torpedo.transform.position.y + self._side * var_0_7, self._torpedo.transform.position.z)

		self._sea_effect.transform.position = var_11_3
		self._sea_effect.transform.localScale = Vector3.New(self._side, 1, 1)
		self._enable_move = true
		self._sea_effect.transform.localEulerAngles = Vector3.New(0, 0, self._side * (math.asin((self._target_pos.y - self._sea_effect.transform.position.y) / Vector3.Distance(var_11_3, self._target_pos)) * Mathf.Rad2Deg))
		self._seaeffect_velocity = Vector3.New((self._target_pos.x - self._sea_effect.transform.position.x) / (self._track.AnimationEnd / 2), (self._target_pos.y - self._sea_effect.transform.position.y) / (self._track.AnimationEnd / 2), (self._target_pos.z - self._sea_effect.transform.position.z) / (self._track.AnimationEnd / 2))
	end

	function arg_1_0:fire_target_under_sea(arg_12_1)
		local var_12_0 = self._battle_processor:find_visual(arg_12_1)

		if not var_12_0 then
			return
		end

		self._target_id = arg_12_1
		self._target_pos = var_12_0:get_position()
		self._torpedo_state = var_0_5.torpedo_state.under_sea
		self._velocity = Vector3.New((self._target_pos.x - self._torpedo.transform.position.x) / 1, (self._target_pos.y - self._torpedo.transform.position.y) / 1, (self._target_pos.z - self._torpedo.transform.position.z) / 1)
	end

	function arg_1_0:create_seaeffect(arg_13_1, arg_13_2, arg_13_3)
		local var_13_0 = self._battle_processor:find_visual(arg_13_1)

		if not var_13_0 then
			return
		end

		self._target_id = arg_13_1

		local var_13_1 = var_0_5.ship_position.player[var_13_0._logic:get_pos()]

		self._target_pos = ((var_13_0._side == var_0_5.character_type.enemy or nil) and var_0_5.ship_position.enemy[var_13_0._logic:get_pos()]) - Vector3.New(0, 0.3, 0)

		local var_13_2 = arg_13_3 and Vector3(arg_13_2.x, arg_13_2.y + self._side * var_0_7, arg_13_2.z) or Vector3(arg_13_2.x + self._side * var_0_6, arg_13_2.y + self._side * var_0_7, arg_13_2.z)
		local var_13_3 = var_0_5.effect_spine

		self._sea_effect = var_0_4:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.effect_spine.path)))
		self._sea_effect.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = -1
		self._sea_effect.transform.position = var_13_2
		self._sea_effect.transform.localScale = Vector3(self._side, 1, 1)
		self._enable_move = true
		self._torpedo_state = var_0_5.torpedo_state.under_sea

		local var_13_4 = self._sea_effect.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		self._sea_torpedo_effect = var_13_4
		self._track = var_13_4.AnimationState:SetAnimation(0, var_13_3.torpedo_wave_at_sea_by_air.name, var_13_3.torpedo_wave_at_sea_by_air.loop)
		self._sea_effect.transform.localEulerAngles = Vector3.New(0, 0, self._side * (math.asin((self._target_pos.y - self._sea_effect.transform.position.y) / Vector3.Distance(var_13_2, self._target_pos)) * Mathf.Rad2Deg))
		self._seaeffect_velocity = Vector3.New((self._target_pos.x - self._sea_effect.transform.position.x) / (self._track.AnimationEnd / 2), (self._target_pos.y - self._sea_effect.transform.position.y) / (self._track.AnimationEnd / 2), (self._target_pos.z - self._sea_effect.transform.position.z) / (self._track.AnimationEnd / 2))
	end

	function arg_1_0:update_torpedo(arg_14_1, arg_14_2)
		self:__before_update_torpedo(arg_14_1, arg_14_2)
		self:__update_torpedo_move(arg_14_1, arg_14_2)
		self:__post_update(arg_14_1, arg_14_2)
	end

	function arg_1_0:eventOnFrame(arg_15_1, arg_15_2)
		self:update_torpedo(arg_15_1, arg_15_2)
	end

	function arg_1_0:pause()
		if self._torpedo_skele then
			self._torpedo_skele.timeScale = 0
		end

		if self._weapon_on_water then
			self._weapon_on_water.timeScale = 0
		end

		if self._sea_torpedo_effect then
			self._sea_torpedo_effect.timeScale = 0
		end
	end

	function arg_1_0:resume()
		if self._torpedo_skele then
			self._torpedo_skele.timeScale = 1
		end

		if self._weapon_on_water then
			self._weapon_on_water.timeScale = 1
		end

		if self._sea_torpedo_effect then
			self._sea_torpedo_effect.timeScale = 1
		end
	end

	function arg_1_0:__before_update_torpedo(arg_18_1, arg_18_2)
		if not self._enable_move then
			return
		end

		if self._sea_effect and self._sea_effect.gameObject and self._sea_effect.gameObject.activeSelf then
			if self._is_miss then
				if (self._sea_effect.transform.position.x - self._target_pos.x) * self._side > 0 and self._after_attack then
					self._after_attack()

					self._after_attack = nil
				end

				if self._track.IsComplete then
					if self._after_attack then
						self._after_attack()

						self._after_attack = nil
					end

					self:__remove_torpedo()
					self:__remove_seaeffect()
				end
			else
				local var_18_0 = self._owner:get_ship_ton()

				if (self._sea_effect.transform.position.x - self._target_pos.x) * self._side > 0 then
					self:__create_hit_effect(self._target_pos + Vector3.New(0, 0.9, 0))

					if self._after_attack then
						self._after_attack()

						self._after_attack = nil
					end

					if var_18_0 == 3 then
						self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_l))
					elseif var_18_0 == 2 then
						self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_m))
					else
						self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_s))
					end

					self:__remove_torpedo()
					self:__remove_seaeffect()
				end
			end
		end
	end

	function arg_1_0:__update_torpedo_move(arg_19_1, arg_19_2)
		if not self._torpedo then
			return
		end

		if self._enable_move and (self._velocity ~= Vector3.zero or self._acceleration ~= Vector3.zero) then
			self._torpedo.transform.position = self._torpedo.transform.position + self._velocity * arg_19_2 / 1000
		end
	end

	function arg_1_0:__post_update(arg_20_1, arg_20_2)
		if self._torpedo_state == var_0_5.torpedo_state.in_air and self._torpedo and self._torpedo.transform.position.y <= -2 then
			self._velocity = Vector3.zero

			self:__create_splash_effect(self._torpedo.transform.position)
			self:__remove_torpedo()
			self:create_seaeffect(self._target_id, self._torpedo.transform.position, true)
		end

		if self._sea_effect then
			self._sea_effect.transform.position = self._sea_effect.transform.position + self._seaeffect_velocity * arg_20_2 / 1000
		end

		if self._torpedo then
			if self._torpedo_state == var_0_5.torpedo_state.under_sea and self._torpedo.transform.position.y >= -9 then
				self._battle_processor:switch_to_sea()

				for iter_20_0, iter_20_1 in pairs(self._battle_processor.visual_pos_list) do
					if iter_20_1 then
						iter_20_1:restore_pos()
					end
				end
			end

			local var_20_0 = -5

			if self._day_or_night == gameenum.battle_type.day_or_night.night then
				var_20_0 = var_20_0 * self._battle_processor._hook
			end

			if self._torpedo_state == var_0_5.torpedo_state.under_sea and var_20_0 <= self._torpedo.transform.position.y then
				self:__remove_torpedo()
			end
		end
	end

	function arg_1_0.__create_hit_effect(arg_21_0, arg_21_1)
		local var_21_0 = var_0_4:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.gunfire_spine.universal)))

		var_21_0.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 1

		var_21_0.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation)).AnimationState:SetAnimation(0, var_0_5.gunfire_spine.normal.name, var_0_5.gunfire_spine.normal.loop)

		var_21_0.transform.position = Vector3(arg_21_1.x, arg_21_1.y, arg_21_1.z)
	end

	function arg_1_0.__create_splash_effect(arg_22_0, arg_22_1)
		local var_22_0 = var_0_4:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.effect_spine.path)))

		var_22_0.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation)).AnimationState:SetAnimation(0, var_0_5.effect_spine.splash.name, var_0_5.effect_spine.splash.loop)

		var_22_0.transform.position = arg_22_1
	end

	function arg_1_0:__remove_torpedo()
		if not self._torpedo then
			return
		end

		var_0_4:destroyGameObject(self._torpedo)

		self._torpedo = nil
	end

	function arg_1_0:__remove_seaeffect()
		if not self._sea_effect then
			return
		end

		var_0_4:destroyGameObject(self._sea_effect)

		self._sea_effect = nil
		self._torpedo_skele = nil
		self._weapon_on_water = nil
		self._sea_torpedo_effect = nil
	end

	function arg_1_0:__eventOnDestroy()
		self:__remove_torpedo()
		self:__remove_seaeffect()
	end

	function arg_1_0._play_into_se(arg_26_0, arg_26_1)
		var_0_4:playBattleSE(arg_26_1, false)
	end
end, "base_visual")

function var_0_0.create(arg_27_0, arg_27_1)
	local var_27_0 = var_0_1.class("torpedo_visual", gamecore.base_visual:inherit())

	var_27_0._owner = arg_27_1:get_owner()
	var_27_0._torpedo = nil
	var_27_0._torpedo_skele = nil
	var_27_0._sea_effect = nil
	var_27_0._torpedo_effect = nil
	var_27_0._speed = 1.2
	var_27_0._is_by_airplane = false
	var_27_0._torpedo_state = nil
	var_27_0._sea_effect_delay = 0
	var_27_0._seaeffect_velocity = Vector3.zero
	var_27_0._target_id = 0
	var_27_0._weapon_on_water = nil
	var_27_0._sea_torpedo_effect = nil

	return var_27_0
end

return var_0_0
