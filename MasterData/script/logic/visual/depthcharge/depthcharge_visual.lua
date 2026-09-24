local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gamecore.base_visual
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.BattleManager
local var_0_7 = UnityEngine.Time

lx.define_class("depthcharge_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:create_depthcharge(arg_3_1)
		self._depthcharge = var_0_6:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.weapon_spine.path)))

		local var_3_0 = self._depthcharge.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		var_3_0.AnimationState:SetAnimation(0, var_0_5.weapon_spine.depthcharge.name, var_0_5.weapon_spine.depthcharge.loop)

		self._weapon_spine = var_3_0
		self._is_air = arg_3_1
	end

	function arg_1_0:set_pos(arg_4_1)
		self._depthcharge.transform.position = arg_4_1
	end

	function arg_1_0.set_call_func(arg_5_0, arg_5_1)
		arg_5_0._after_attack = arg_5_1
	end

	function arg_1_0.set_speed(arg_6_0, arg_6_1)
		arg_6_0._speed = arg_6_1
	end

	function arg_1_0:set_target(arg_7_1)
		local var_7_0 = self._battle_processor:find_visual(arg_7_1)

		if not var_7_0 then
			return
		end

		self._target_pos = var_7_0:get_damage_point().transform.position
		self._target_index = var_7_0._logic:get_index()
		self.shout_time = 0.2
		self._lateral_thrust = 15
		self._gravity = -130

		if self._is_air then
			self._gravity = -15
			self._lateral_thrust = 0
		end

		self._total_time = self._side * (self._target_pos.x - self._depthcharge.transform.position.x) / self._speed
		self._velocity.x = (self._target_pos.x - self._depthcharge.transform.position.x) / self._total_time + 0.3 * self._lateral_thrust * self._total_time
		self._velocity.y = (self._target_pos.y - self._depthcharge.transform.position.y) / self._total_time - 0.5 * self._gravity * self._total_time
		self._velocity.z = (self._target_pos.z - self._depthcharge.transform.position.z) / self._total_time
		self._start_time = self._battle_time:getTime()
		self._end_time = self._start_time + self._total_time * 1000
	end

	function arg_1_0:update_depthcharge(arg_8_1, arg_8_2)
		self:__before_update_depthcharge(arg_8_1, arg_8_2)
		self:__update_depthcharge_move(arg_8_1, arg_8_2)
	end

	function arg_1_0:eventOnFrame(arg_9_1, arg_9_2)
		if not self._depthcharge then
			return
		end

		self:update_depthcharge(arg_9_1, arg_9_2)
	end

	function arg_1_0:pause()
		if self._weapon_spine then
			self._weapon_spine.timeScale = 0
		end

		if self._water_weapon_spine then
			self._water_weapon_spine.timeScale = 0
		end
	end

	function arg_1_0:resume()
		if self._weapon_spine then
			self._weapon_spine.timeScale = 1
		end

		if self._water_weapon_spine then
			self._water_weapon_spine.timeScale = 1
		end
	end

	function arg_1_0:__before_update_depthcharge(arg_12_1, arg_12_2)
		if not self._depthcharge then
			return
		end

		if self._total_time <= self._delta_time then
			if self._is_miss then
				-- block empty
			else
				local var_12_0 = self._owner:get_ship_ton()

				self:__create_hit_effect(var_0_5.effect_spine.bomb_under_sea, self._target_pos)

				if var_12_0 == 3 then
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.under_hit_l))
				elseif var_12_0 == 2 then
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.under_hit_m))
				else
					self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.under_hit_s))
				end
			end

			self:__remove_depthcharge()

			if self._after_attack then
				self._after_attack()

				self._after_attack = nil
			end
		end
	end

	function arg_1_0:__update_depthcharge_move(arg_13_1, arg_13_2)
		if not self._depthcharge then
			return
		end

		if self.shout_time > 0 then
			self.shout_time = self.shout_time - var_0_7.deltaTime
		end

		self._delta_time = self._delta_time + arg_13_2 / 1000
		self._acceleration.y = self._gravity * self._delta_time
		self._depthcharge.transform.position = self._depthcharge.transform.position + (self._velocity + self._acceleration) * arg_13_2 / 1000
		self._depthcharge.transform.localEulerAngles = Vector3.New(0, 0, Mathf.Atan((self._velocity.y + self._acceleration.y) / self._velocity.x) * Mathf.Rad2Deg)

		local var_13_0 = (self._owner:get_index() - 1) / 3

		if self._depthcharge.transform.position.y <= var_0_5.ship_position.player[self._target_index].y and not self._is_under_sea and not self._is_transparent and self.shout_time <= 0 then
			if not self.is_open_antisub then
				self._depthcharge.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 0
				self._is_transparent = true
			end

			self:__create_hit_effect(var_0_5.effect_spine.splash, self._depthcharge.transform.position)

			self._is_under_sea = true
		end

		if self._depthcharge.transform.position.y <= -4 and not self._is_under_sea and self._is_transparent and not self.is_open_antisub then
			self._is_transparent = false
			self._depthcharge.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation)).skeleton.A = 1
		end
	end

	function arg_1_0.__create_hit_effect(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = var_0_6:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.effect_spine.path)))
		local var_14_1 = var_14_0.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		var_14_1.AnimationState:SetAnimation(arg_14_1.priority, arg_14_1.name, arg_14_1.loop)

		arg_14_0._water_weapon_spine = var_14_1
		var_14_0.transform.position = arg_14_2
		var_14_0.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 1

		local var_14_2 = var_14_1.state.Complete

		local function var_14_3()
			var_0_6:destroyGameObject(var_14_0)

			var_14_1.state.Complete = var_14_2
		end

		var_14_2 = var_14_1.state.Complete + var_14_3
		var_14_1.state.Complete = var_14_1.state.Complete + var_14_3
		var_14_2 = var_14_2 - var_14_3
	end

	function arg_1_0:__remove_depthcharge()
		if not self._depthcharge then
			return
		end

		var_0_6:destroyGameObject(self._depthcharge)

		self._depthcharge = nil
		self._water_weapon_spine = nil
		self._weapon_spine = nil
	end

	function arg_1_0:__eventOnDestroy()
		self:__remove_depthcharge()
	end

	function arg_1_0._play_into_se(arg_18_0, arg_18_1)
		var_0_6:playBattleSE(arg_18_1, false)
	end
end, "base_visual")

function var_0_0.create(arg_19_0, arg_19_1)
	local var_19_0 = var_0_1.class("depthcharge_visual", var_0_4:inherit())

	var_19_0._owner = arg_19_1:get_owner()
	var_19_0._depthcharge = nil
	var_19_0._speed = 15
	var_19_0._start_vy = 0
	var_19_0._start_offset = 0
	var_19_0._total_time = 0
	var_19_0._delta_time = 0
	var_19_0._is_under_sea = false
	var_19_0._weapon_spine = nil
	var_19_0._water_weapon_spine = nil

	return var_19_0
end

return var_0_0
