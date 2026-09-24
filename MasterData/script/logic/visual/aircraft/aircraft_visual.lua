local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = Vector3
local var_0_3 = Spine
local var_0_4 = typeof
local var_0_5 = tostring
local var_0_6 = gameenum.common_type
local var_0_7 = gamecore.UILoader
local var_0_8 = gamecore.effect
local var_0_9 = gameconfig.skin_config
local var_0_10 = next
local var_0_11 = gamecore.BattleManager
local var_0_12 = UnityEngine.Time

lx.define_class("aircraft_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
		self._aircraft_type = self._logic:get_type()
		self.time = 0
	end

	function arg_1_0:create_aircraft(arg_3_1)
		self.__info = arg_3_1

		local var_3_0 = arg_3_1.plane_type == 0 and 1 or arg_3_1.plane_type

		self.__attack_type = arg_3_1.attack_type

		if self._owner._skin_id ~= 0 then
			local var_3_1 = var_0_9.find_object_by_cid(self._owner._skin_id)

			if var_0_10(var_3_1.plane_img_type) then
				var_3_0 = var_3_1.plane_img_type[1]
			end
		end

		self._aircraft = var_0_11:createBattleGameObject((var_0_6:get_final_battle_prefab_path((var_0_6:get_aircraft_spine_path(var_3_0)))))

		local var_3_2 = self._aircraft.transform:GetComponent(var_0_4(var_0_3.Unity.SkeletonAnimation))

		var_3_2.skeleton:SetSkin(var_0_5(var_3_0))

		self._weapon_spine = var_3_2
		self._follow_shadow = var_0_8:create():create_follow_shadow()
		self._bomb_id = arg_3_1.bomb_id
		self._target_id = arg_3_1.target_id
		self._torpedo_id = arg_3_1.torpedo_id
		self._is_miss = arg_3_1.is_miss
		self._depthcharge_id = arg_3_1.depthcharge_id
	end

	function arg_1_0.set_target_pos(arg_4_0, arg_4_1)
		arg_4_0._ship_target = arg_4_1
	end

	function arg_1_0:set_pos(arg_5_1)
		self._aircraft.transform.position = arg_5_1
		self._aircraft.transform.localScale = var_0_2.New(self._side, 1, 1)
		self._follow_shadow.transform.position = arg_5_1
	end

	function arg_1_0.set_call_func(arg_6_0, arg_6_1)
		arg_6_0._after_attack = arg_6_1
	end

	function arg_1_0:go_to_attack_position(arg_7_1, arg_7_2)
		arg_7_2 = var_0_2.New(0, 0, 0)
		self._target_pos = arg_7_1
		self._offset = arg_7_2
		self._speed = var_0_2.Distance(arg_7_1 + arg_7_2, self._aircraft.transform.position) / 0.2 / 5
		self._step = var_0_6.fly_step.attack_pos

		if self.__attack_type == var_0_6.plane_attack_type.throw_torpedo then
			self:throw_torpedo_and_flyaway(9, self.__info.show_aircraft_explosion)
		elseif self.__attack_type == var_0_6.plane_attack_type.throw_bomb then
			self:throw_bomb_and_flyaway(9, self.__info.show_aircraft_explosion)
		elseif self.__attack_type == var_0_6.plane_attack_type.throw_depthcharge or self.__info.depthcharge_id then
			self:throw_depthcharge_and_flyaway(9, self.__info.show_aircraft_explosion)
		else
			self:fighter_attack(9, self.__info.show_aircraft_explosion)
		end
	end

	function arg_1_0:throw_torpedo_and_flyaway(arg_8_1, arg_8_2)
		self._target_pos = var_0_2.New(-0.3, var_0_6.aircraft_attack_pos[1].y, self._aircraft.transform.position.z)
		self._target_pos.x = self._side * self._target_pos.x
		self._step = var_0_6.fly_step.throw_torpedo
		self._speed = arg_8_1 or self._speed
		self._can_show_aircraft_explosion = arg_8_2
	end

	function arg_1_0:throw_bomb_and_flyaway(arg_9_1, arg_9_2)
		self._ship_target.y = self._ship_target.y + var_0_6.aircraft_attack_pos[2].y
		self._target_vector = self._ship_target
		self._step = var_0_6.fly_step.throw_bomb
		self._speed = arg_9_1 or self._speed
		self._can_show_aircraft_explosion = arg_9_2
	end

	function arg_1_0:throw_depthcharge_and_flyaway(arg_10_1, arg_10_2)
		self._ship_target.y = 0
		self._target_vector = self._ship_target
		self._step = var_0_6.fly_step.throw_depthcharge
		self._speed = arg_10_1 or self._speed
		self._can_show_aircraft_explosion = arg_10_2
	end

	function arg_1_0:fighter_attack(arg_11_1, arg_11_2)
		self._ship_target.y = self._ship_target.y + var_0_6.aircraft_attack_pos[2].y
		self._target_vector = self._ship_target
		self._step = var_0_6.fly_step.attack
		self._speed = arg_11_1 or self._speed
		self._can_show_aircraft_explosion = arg_11_2
	end

	function arg_1_0:fly_away(arg_12_1, arg_12_2, arg_12_3)
		if self._is_auto_crash then
			return
		end

		if self._target_vector == var_0_2.zero then
			self._target_vector = var_0_2.New(2 * self._side, 1.2, 0)
		end

		self._target_vector = var_0_2.Normalize(self._target_vector)
		self._target_vector = self._target_vector * 5
		self._target_pos = self._aircraft.transform.position + self._target_vector
		self._step = var_0_6.fly_step.flyawaying
		self._speed = self._speed * 1.25 * 3
		self._velocity.y = self._velocity.y + 2
		self._velocity.x = arg_12_3 or 0

		if self._speed < 3.75 then
			self._speed = 4.5
		end

		self._can_show_aircraft_explosion = arg_12_1
		self.fighter_should_shot = arg_12_2
	end

	function arg_1_0:update_aircraft(arg_13_1, arg_13_2)
		if not self._aircraft then
			return
		end

		self:__before_update_aircraft(arg_13_1, arg_13_2)

		if self._aircraft and self._follow_shadow then
			self:__update_aircraft_move(arg_13_1, arg_13_2)
		end
	end

	function arg_1_0:eventOnFrame(arg_14_1, arg_14_2)
		self:update_aircraft(arg_14_1, arg_14_2)

		if self._aircraft then
			self.time = var_0_12.deltaTime + self.time
		end

		if self.time >= 30 then
			self.time = 0

			if self._aircraft and gamecore.ErrorReport and gamecore.ErrorReport.report and not gamecore.user:isErrorIng() then
				gamecore.user:haveErrorReport()
				gamecore.ErrorReport:report((var_0_1.json_encode({
					describe = "It's about combat performance problem",
					Screen_size = tostring(UnityEngine.Screen.width) + tostring(UnityEngine.Screen.height)
				})))
			end
		end
	end

	function arg_1_0:pause()
		if self._weapon_spine then
			self._weapon_spine.timeScale = 0
		end
	end

	function arg_1_0:resume()
		if self._weapon_spine then
			self._weapon_spine.timeScale = 1
		end
	end

	function arg_1_0:__before_update_aircraft(arg_17_1, arg_17_2)
		if not self._aircraft or not self._ship_target then
			return
		end

		if not self._aircraft.transform or self._aircraft.transform:Equals(nil) then
			return
		end

		if self._step == var_0_6.fly_step.attack_pos or self._step == var_0_6.fly_step.flyawaying or self._step == var_0_6.fly_step.throw_bomb or self._step == var_0_6.fly_step.throw_torpedo or self._step == var_0_6.fly_step.throw_depthcharge or self._step == var_0_6.fly_step.attack then
			local var_17_0 = self._ship_target
			local var_17_1 = math.floor((math.atan2(self._ship_target.z - self._aircraft.transform.position.z, self._ship_target.x - self._aircraft.transform.position.x)))
			local var_17_2 = math.atan2(self._ship_target.y - self._aircraft.transform.position.y, math.sqrt((self._ship_target.x - self._aircraft.transform.position.x) * (self._ship_target.x - self._aircraft.transform.position.x) + (self._ship_target.z - self._aircraft.transform.position.z) * (self._ship_target.z - self._aircraft.transform.position.z)))
			local var_17_3 = self._speed * math.cos(var_17_2)
			local var_17_4 = self._speed * arg_17_2 / 20

			if (self._step == var_0_6.fly_step.throw_bomb or self._step == var_0_6.fly_step.throw_depthcharge or self._step == var_0_6.fly_step.attack) and var_0_2.Distance(var_0_2.New(self._ship_target.x, self._aircraft.transform.position.y, self._ship_target.z), self._aircraft.transform.position) < 3 then
				if self._step == var_0_6.fly_step.throw_bomb then
					local var_17_5 = self._battle_processor:find_visual(self._bomb_id)

					var_17_5:create_bomb()
					var_17_5:set_miss(self._is_miss)
					var_17_5:set_crit(self._is_crit)
					var_17_5:set_speed(8)
					var_17_5:set_pos(self._aircraft.transform.position)
					var_17_5:set_target(self._target_id, self._is_miss)
					var_17_5:set_call_func(self._after_attack)

					if self._can_show_aircraft_explosion then
						self:__create_aircraft_explosion_effect("aircraft_explosion", self._aircraft.transform.position)
						self:__remove_aircraft()
						self:__remove_follow_shadow()

						return
					else
						self:fly_away()
					end
				elseif self._step == var_0_6.fly_step.throw_depthcharge then
					local var_17_6 = self._battle_processor:find_visual(self._depthcharge_id)

					var_17_6:create_depthcharge(true)
					var_17_6:set_miss(self._is_miss)
					var_17_6:set_speed(3)
					var_17_6:set_crit(self._is_crit)
					var_17_6:set_pos(self._aircraft.transform.position)
					var_17_6:set_target(self._target_id)
					var_17_6:set_call_func(self._after_attack)

					local var_17_7 = self._battle_obj_mgr:findObject(self._target_id)
					local var_17_8 = var_17_7:get_index()

					var_0_7:getInstance(var_0_6:get_battle_name()):show_periscope(self._side, var_17_8)

					for iter_17_0, iter_17_1 in pairs(self._battle_processor.visual_pos_list) do
						if iter_17_1._logic:get_side() == var_17_7:get_side() and iter_17_1._logic:is_submarine() and not iter_17_1._spine_root:Equals(nil) then
							iter_17_1._spine_root:SetActive(var_17_8 == iter_17_1._logic:get_index())
						end
					end

					if self._can_show_aircraft_explosion then
						self:__create_aircraft_explosion_effect("aircraft_explosion", self._aircraft.transform.position)
						self:__remove_aircraft()
						self:__remove_follow_shadow()

						return
					else
						self:fly_away()
					end
				else
					self:fly_away()
				end
			else
				if self._step == var_0_6.fly_step.throw_torpedo then
					var_17_0 = var_0_2.New(var_17_0.x / 2, var_17_0.y / 2, var_17_0.z / 2)
				end

				if var_0_2.Distance(var_17_0, self._aircraft.transform.position) <= var_17_4 / 2 then
					self._velocity.y = 0

					if self._step == var_0_6.fly_step.throw_torpedo then
						local var_17_9 = self._battle_processor:find_visual(self._torpedo_id)

						var_17_9:create_torpedo("torpedo")
						var_17_9:set_pos(self._aircraft.transform.position)
						var_17_9:fire_target_in_air(self._target_id, self._is_miss)
						var_17_9:set_call_func(self._after_attack)

						if self._can_show_aircraft_explosion then
							self:__create_aircraft_explosion_effect("aircraft_explosion", self._aircraft.transform.position)
							self:__remove_aircraft()
							self:__remove_follow_shadow()

							return
						else
							self:fly_away()
						end
					elseif self._step == var_0_6.fly_step.throw_bomb then
						local var_17_10 = self._battle_processor:find_visual(self._bomb_id)

						var_17_10:create_bomb()
						var_17_10:set_miss(self._is_miss)
						var_17_10:set_crit(self._is_crit)
						var_17_10:set_speed(8)
						var_17_10:set_pos(self._aircraft.transform.position)
						var_17_10:set_target(self._target_id, self._is_miss)
						var_17_10:set_call_func(self._after_attack)

						if self._can_show_aircraft_explosion then
							self:__create_aircraft_explosion_effect("aircraft_explosion", self._aircraft.transform.position)
							self:__remove_aircraft()
							self:__remove_follow_shadow()

							return
						else
							if self._velocity.x == 0 then
								self._velocity.x = 8 * self._side
							end

							self:fly_away(nil, nil, self._velocity.x)
						end
					elseif self._step == var_0_6.fly_step.attack_pos then
						if self._aircraft.transform.position.x * self._side <= 10 and self._aircraft.transform.position.y <= 6 then
							self._velocity.y = self._velocity.y + 2.5
						else
							if self._after_attack then
								self._after_attack()

								self._after_attack = nil
							end

							self:__remove_aircraft()
							self:__remove_follow_shadow()
						end
					elseif self._step == var_0_6.fly_step.flyawaying then
						if self.fighter_should_shot then
							self._aircraft.transform:GetComponent(var_0_4(var_0_3.Unity.SkeletonAnimation)).AnimationState:SetAnimation(var_0_6.character_anim_type.attack.priority, var_0_6.character_anim_type.attack.name, var_0_6.character_anim_type.attack.loop)

							self.fighter_should_shot = nil
						end

						if self._can_show_aircraft_explosion then
							self:__create_aircraft_explosion_effect("aircraft_explosion", self._aircraft.transform.position)
							self:__remove_aircraft()
							self:__remove_follow_shadow()
						else
							if self._velocity.x == 0 then
								self._velocity.x = 8 * self._side
							end

							self:fly_away(nil, nil, self._velocity.x)
						end

						if self._aircraft.transform.position.x * self._side >= 10 or self._aircraft.transform.position.y <= -8 then
							self:__remove_aircraft()
							self:__remove_follow_shadow()

							if self._after_attack then
								self._after_attack()

								self._after_attack = nil
							end
						end
					end
				else
					self._velocity = var_0_2.New(math.abs(self._speed * math.cos(var_17_1)) * self._side, self._speed * math.sin(var_17_2), var_17_3 * math.sin(var_17_1))
				end
			end
		end
	end

	function arg_1_0:__update_aircraft_move(arg_18_1, arg_18_2)
		if self._velocity == var_0_2.zero then
			if self._acceleration ~= var_0_2.zero then
				local var_18_0 = self._aircraft.transform.position + self._velocity * (arg_18_2 / 1000)

				self._aircraft.transform.position = self._aircraft.transform.position + self._velocity * (arg_18_2 / 1000) + var_0_2.New(0, 0.07, 0)
				self._follow_shadow.transform.position = var_0_2.New(var_18_0.x, var_18_0.y - 3, 0)
			end
		end

		self:aircraft_position_update()
	end

	function arg_1_0:aircraft_position_update()
		if self._aircraft.transform.position.x >= 10 or self._aircraft.transform.position.x <= -10 then
			self:__remove_aircraft()
			self:__remove_follow_shadow()

			if self._after_attack then
				self._after_attack()

				self._after_attack = nil
			end
		end
	end

	function arg_1_0:__remove_aircraft()
		if not self._aircraft then
			return
		end

		var_0_11:destroyGameObject(self._aircraft)

		self.time = 0
		self._aircraft = nil
		self._weapon_spine = nil
	end

	function arg_1_0:__remove_follow_shadow()
		if not self._follow_shadow then
			return
		end

		var_0_11:destroyGameObject(self._follow_shadow)

		self._follow_shadow = nil
	end

	function arg_1_0:__create_aircraft_explosion_effect(arg_22_1, arg_22_2)
		local var_22_0 = var_0_8:create()

		var_22_0:create_effect(arg_22_1)
		var_22_0:set_side(self._side)
		var_22_0:set_pos(arg_22_2)
	end

	function arg_1_0:__eventOnDestroy()
		self:__remove_aircraft()
		self:__remove_follow_shadow()
	end
end, "base_visual")

function var_0_0.create(arg_24_0, arg_24_1)
	local var_24_0 = var_0_1.class("aircraft_visual", gamecore.base_visual:inherit())

	var_24_0._owner = arg_24_1:get_owner()
	var_24_0._aircraft = nil
	var_24_0._aircraft_type = nil
	var_24_0._side = 0
	var_24_0._velocity = var_0_2.zero
	var_24_0._acceleration = var_0_2.zero
	var_24_0._speed = 1.5
	var_24_0._fly_step = nil
	var_24_0._offset = var_0_2.zero
	var_24_0._target_pos = var_0_2.zero
	var_24_0._is_auto_crash = false
	var_24_0._target_vector = var_0_2.zero
	var_24_0._follow_shadow = nil
	var_24_0._weapon_spine = nil
	var_24_0.__info = nil
	var_24_0.__attack_type = nil

	return var_24_0
end

return var_0_0
