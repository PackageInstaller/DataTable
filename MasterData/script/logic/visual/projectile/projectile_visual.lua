local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gameenum.common_type
local var_0_6 = gameconfig.skin_config
local var_0_7 = gamecore.BattleManager

lx.define_class("projectile_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:get_ship_ton()
		if not self._owner then
			return 1
		end

		return self._owner:get_ship_ton()
	end

	function arg_1_0:create_projectile()
		local var_4_0 = "universal"

		if self._owner._skin_id ~= 0 then
			local var_4_1 = var_0_6.find_object_by_cid(self._owner._skin_id)

			if var_4_1.gun_type ~= "universal" then
				var_4_0 = var_4_1.gun_type
			end
		end

		self._projectile = var_0_7:createBattleGameObject((string.format(var_0_4.gunfire_spine.gunfire_path, var_4_0, var_4_0)))

		local var_4_2 = self._projectile.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))
		local var_4_3 = var_0_4.gunfire_spine[var_0_4:get_gun_ani_type(self:get_ship_ton())]

		var_4_2.AnimationState:SetAnimation(var_4_3.priority, var_4_3.name, var_4_3.loop)

		self._weapon_spine = var_4_2
	end

	function arg_1_0:set_pos(arg_5_1)
		self._projectile.transform.position = arg_5_1
		self._projectile.transform.localScale = Vector3.New(self._side, 1, 1)
	end

	function arg_1_0.set_call_func(arg_6_0, arg_6_1)
		arg_6_0._call_func = arg_6_1
	end

	function arg_1_0:set_target(arg_7_1)
		local var_7_0 = self._battle_processor:find_visual(arg_7_1)

		if not var_7_0 then
			return
		end

		self._target_pos = var_7_0:get_damage_point().transform.position

		if self._is_miss then
			self._target_pos.x = self._target_pos.x + self._side * 2.5
			self._target_pos.y = self._target_pos.y + 0.3
		end

		self._gravity = -20
		self._total_time = self._side * (self._target_pos.x - self._projectile.transform.position.x) / self._speed
		self._velocity.x = (self._target_pos.x - self._projectile.transform.position.x) / self._total_time
		self._velocity.y = (self._target_pos.y - self._projectile.transform.position.y) / self._total_time - 0.5 * self._gravity * self._total_time
		self._velocity.z = (self._target_pos.z - self._projectile.transform.position.z) / self._total_time
		self._start_time = self._battle_time:getTime()
		self._end_time = self._start_time + self._total_time * 1000
	end

	function arg_1_0:update_projectile(arg_8_1, arg_8_2)
		if not self._projectile then
			return
		end

		self:__before_update(arg_8_1, arg_8_2)
		self:__update_move(arg_8_1, arg_8_2)
	end

	function arg_1_0:eventOnFrame(arg_9_1, arg_9_2)
		if not self._projectile then
			return
		end

		self:update_projectile(arg_9_1, arg_9_2)
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

	function arg_1_0:__before_update(arg_12_1, arg_12_2)
		if not self._projectile or self._projectile:Equals(nil) then
			return
		end

		self._projectile.transform.localScale = Vector3.New((self._delta_time - self._total_time) / self._total_time + 2, (self._delta_time - self._total_time) / self._total_time + 2, 1)

		if self._total_time <= self._delta_time then
			if self._is_miss then
				self:__create_hit_effect(var_0_4.effect_spine, self._projectile.transform.position)
			else
				self:__create_hit_effect(var_0_4.gunfire_spine, self._target_pos)
			end

			self:__remove_projectile()

			if self._call_func then
				self._call_func()

				self._call_func = nil
			end
		end
	end

	function arg_1_0:__update_move(arg_13_1, arg_13_2)
		if not self._projectile or self._projectile:Equals(nil) then
			return
		end

		self._delta_time = self._delta_time + arg_13_2 / 650
		self._acceleration.y = self._gravity * self._delta_time
		self._projectile.transform.position = self._projectile.transform.position + (self._velocity + self._acceleration) * arg_13_2 / 700
		self._projectile.transform.localEulerAngles = Vector3.New(0, 0, Mathf.Atan((self._velocity.y + self._acceleration.y) / self._velocity.x) * Mathf.Rad2Deg)
	end

	function arg_1_0:__create_hit_effect(arg_14_1, arg_14_2)
		local var_14_0 = "universal"

		if self._owner._skin_id ~= 0 and var_14_0 == "universal" then
			local var_14_1 = var_0_6.find_object_by_cid(self._owner._skin_id)

			if var_14_1.gun_type ~= "universal" then
				var_14_0 = var_14_1.gun_type
			end
		end

		local var_14_2 = string.format(var_0_4.gunfire_spine.gunfire_path, var_14_0, var_14_0)
		local var_14_3 = var_0_7:createBattleGameObject((self._is_miss or nil) and arg_14_1.effect_path)
		local var_14_4 = var_14_3.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		self._water_weapon_spine = var_14_4

		local var_14_5 = arg_14_1.normal

		if self._is_crit then
			var_14_5 = arg_14_1.crit
		end

		if self._is_miss then
			var_14_5 = arg_14_1.splash
		end

		var_14_4.AnimationState:SetAnimation(var_14_5.priority, var_14_5.name, var_14_5.loop)

		var_14_3.transform.position = arg_14_2

		local var_14_6 = var_14_4.state.Complete

		local function var_14_7()
			if var_0_7 and var_0_7.destroyGameObject then
				var_0_7:destroyGameObject(var_14_3)
			end

			var_14_4.state.Complete = var_14_6
		end

		var_14_6 = var_14_4.state.Complete + var_14_7
		var_14_4.state.Complete = var_14_4.state.Complete + var_14_7
		var_14_6 = var_14_6 - var_14_7
	end

	function arg_1_0:__remove_projectile()
		var_0_7:destroyGameObject(self._projectile)

		self._projectile = nil
		self._water_weapon_spine = nil
		self._weapon_spine = nil
	end
end, "base_visual")

function var_0_0.create(arg_17_0, arg_17_1)
	local var_17_0 = var_0_1.class("projectile_visual", gamecore.base_visual:inherit())

	var_17_0._owner = arg_17_1:get_owner()
	var_17_0._projectile = nil
	var_17_0._speed = 18
	var_17_0._start_vy = 0
	var_17_0._start_offset = 0
	var_17_0._total_time = 0
	var_17_0._delta_time = 0
	var_17_0._weapon_spine = nil
	var_17_0._water_weapon_spine = nil

	return var_17_0
end

return var_0_0
