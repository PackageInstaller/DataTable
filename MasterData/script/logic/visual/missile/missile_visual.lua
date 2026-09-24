local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.BattleManager

lx.define_class("missile_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:create_missile(arg_3_1)
		local var_3_0 = var_0_4.missile_spine
		local var_3_1 = var_0_4.missile_spine.skin.hit
		local var_3_2 = self._owner:get_ship_type()

		if arg_3_1 == "close_missile_attack" or var_3_2 == var_0_4.ship_type_rule.aadg.value or var_3_2 == var_0_4.ship_type_rule.cbg.value or var_3_2 == var_0_4.ship_type_rule.bg.value or var_3_2 == var_0_4.ship_type_rule.cg.value then
			var_3_1 = var_3_0.skin.tmd
		end

		self._missile = var_0_5:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_3_0.path)))
		self._missile_skele = self._missile.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		self._missile_skele.skeleton:SetSkin(var_3_1)
		self._missile_skele.AnimationState:SetAnimation(0, var_3_0.normal.name, var_3_0.normal.loop)

		self._missile.transform.localScale = Vector3.New(self._side * 0.8, 0.8, 0.8)
		self._missile.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 1
	end

	function arg_1_0:set_pos(arg_4_1)
		self._missile.transform.position = arg_4_1
	end

	function arg_1_0.set_intercept(arg_5_0, arg_5_1)
		arg_5_0._intercept = arg_5_1
	end

	function arg_1_0.set_booster_id(arg_6_0, arg_6_1)
		arg_6_0._booster_id = arg_6_1
	end

	function arg_1_0.set_call_func(arg_7_0, arg_7_1)
		arg_7_0._after_attack = arg_7_1
	end

	function arg_1_0:set_target(arg_8_1)
		local var_8_0 = self._battle_processor:find_visual(arg_8_1)

		if not var_8_0 then
			return
		end

		self._target_id = arg_8_1
		self._target_pos = var_8_0:get_damage_point().transform.position

		if self._is_miss then
			self._target_pos.x = self._target_pos.x + self._side * 1.5
		end

		self._gravity = self._battle_random:visualRandRange(10, 20) * -1
		self._total_time = self._side * (self._target_pos.x - self._missile.transform.position.x) / self._speed
		self._velocity.x = (self._target_pos.x - self._missile.transform.position.x) / self._total_time
		self._velocity.y = (self._target_pos.y - self._missile.transform.position.y) / self._total_time - 0.5 * self._gravity * self._total_time
		self._velocity.z = (self._target_pos.z - self._missile.transform.position.z) / self._total_time
		self._start_time = self._battle_time:getTime()
		self._end_time = self._start_time + self._total_time * 1000
	end

	function arg_1_0:set_target_position(arg_9_1, arg_9_2)
		self._gravity = self._battle_random:visualRandRange(10, 20) * -1
		self._target_pos = arg_9_1
		self._total_time = self._side * (self._target_pos.x - self._missile.transform.position.x) / self._speed
		self._velocity.x = (self._target_pos.x - self._missile.transform.position.x) / self._total_time
		self._velocity.y = (self._target_pos.y - self._missile.transform.position.y) / self._total_time - 0.5 * self._gravity * self._total_time
		self._velocity.z = (self._target_pos.z - self._missile.transform.position.z) / self._total_time
		self._start_time = self._battle_time:getTime()
		self._end_time = self._start_time + self._total_time * 1000
	end

	function arg_1_0:update_missile(arg_10_1, arg_10_2)
		if not self._missile then
			return
		end

		self:__before_update(arg_10_1, arg_10_2)
		self:__update_missile_move(arg_10_1, arg_10_2)
	end

	function arg_1_0:eventOnFrame(arg_11_1, arg_11_2)
		if not self._missile then
			return
		end

		self:update_missile(arg_11_1, arg_11_2)
	end

	function arg_1_0:pause()
		if self._missile_skele then
			self._missile_skele.timeScale = 0
		end
	end

	function arg_1_0:resume()
		if self._missile_skele then
			self._missile_skele.timeScale = 1
		end
	end

	function arg_1_0:__before_update(arg_14_1, arg_14_2)
		if not self._missile then
			return
		end

		if not self._intercept then
			local var_14_0 = self._owner:get_ship_ton()

			if self._total_time <= self._delta_time then
				self._velocity = Vector3.zero

				if self._is_miss then
					self:__create_hit_effect(var_0_4.effect_spine, self._missile.transform.position)
				else
					self:__create_hit_effect(var_0_4.gunfire_spine, self._target_pos)

					if var_14_0 == 3 then
						self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_l))
					elseif var_14_0 == 2 then
						self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_m))
					else
						self:_play_into_se(var_0_4:get_audio_url(var_0_4.common_icon.music_path, var_0_4.destroyer_s))
					end
				end

				self:__remove_missile()

				if self._after_attack then
					self._after_attack()

					self._after_attack = nil
				end
			end

			local var_14_1 = self._owner:get_ship_type()

			if not self._dipart and (self._battle_time:getTime() - self._start_time) * 3 > self._end_time - self._start_time and var_14_1 ~= var_0_4.ship_type.aadg and var_14_1 ~= var_0_4.ship_type.cbg and var_14_1 ~= var_0_4.ship_type.bg and var_14_1 ~= var_0_4.ship_type_rule.cg.value then
				self._dipart = true

				self:__create_booster()
				self._missile_skele.AnimationState:SetAnimation(var_0_4.missile_spine.attack.priority, var_0_4.missile_spine.attack.name, var_0_4.missile_spine.attack.loop)
			end

			return
		end

		if Vector3.Distance(self._target_pos, self._missile.transform.position) <= 0.5 then
			self._velocity.x = 0
			self._velocity.z = 0

			self:__remove_missile()
			self:__create_explosion_effect(self._target_pos)

			if self._after_attack then
				self._after_attack()

				self._after_attack = nil
			end
		end
	end

	function arg_1_0:__update_missile_move(arg_15_1, arg_15_2)
		if not self._missile then
			return
		end

		self._delta_time = self._delta_time + arg_15_2 / 1000
		self._acceleration.y = self._gravity * self._delta_time
		self._missile.transform.position = self._missile.transform.position + (self._velocity + self._acceleration) * arg_15_2 / 1000
		self._missile.transform.localEulerAngles = Vector3.New(0, 0, Mathf.Atan((self._velocity.y + self._acceleration.y) / self._velocity.x) * Mathf.Rad2Deg)
	end

	function arg_1_0:__create_booster()
		local var_16_0 = self._battle_processor:find_visual(self._booster_id)

		if not var_16_0 then
			return
		end

		var_16_0:create_booster()
		var_16_0:set_target_id(self._target_id)
		var_16_0:set_pos(self._missile.transform.position)
		var_16_0:init_action((Vector3.New(self._velocity.x, 0, self._velocity.z)))
	end

	function arg_1_0.__create_explosion_effect(arg_17_0, arg_17_1)
		local var_17_0 = var_0_5:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.effect_spine.path)))

		var_17_0.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation)).AnimationState:SetAnimation(0, var_0_4.effect_spine.aircraft_explosion.name, var_0_4.effect_spine.aircraft_explosion.loop)

		var_17_0.transform.position = arg_17_1
	end

	function arg_1_0:__create_hit_effect(arg_18_1, arg_18_2)
		local var_18_1 = var_0_5:createBattleGameObject((var_0_4:get_final_battle_prefab_path(arg_18_1[(self._is_miss or nil) and "path"])))
		local var_18_2 = arg_18_1.normal

		if not self._is_crit then
			var_18_2 = arg_18_1.crit
		end

		if self._is_miss then
			var_18_2 = arg_18_1.splash_by_air
		end

		var_18_1.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation)).AnimationState:SetAnimation(var_18_2.priority, var_18_2.name, var_18_2.loop)

		var_18_1.transform.position = arg_18_2
	end

	function arg_1_0:__remove_missile()
		var_0_5:destroyGameObject(self._missile)

		self._missile = nil
		self._missile_skele = nil
	end

	function arg_1_0:__eventOnDestroy()
		self:__remove_missile()
	end

	function arg_1_0._play_into_se(arg_21_0, arg_21_1)
		var_0_5:playBattleSE(arg_21_1, false)
	end
end, "base_visual")

function var_0_0.create(arg_22_0, arg_22_1)
	local var_22_0 = var_0_1.class("missile_visual", gamecore.base_visual:inherit())

	var_22_0._owner = arg_22_1:get_owner()
	var_22_0._missile = nil
	var_22_0._speed = 12
	var_22_0._gravity = 0
	var_22_0._intercept = false
	var_22_0._dipart = false
	var_22_0._start_vy = 0
	var_22_0._start_offset = 0
	var_22_0._start_time = 0
	var_22_0._end_time = 0
	var_22_0._total_time = 0
	var_22_0._delta_time = 0

	return var_22_0
end

return var_0_0
