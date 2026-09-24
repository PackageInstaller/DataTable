local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_5 = gameenum.common_type
local var_0_6 = gamecore.effect
local var_0_7 = gamecore.BattleManager

lx.define_class("bomb_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:create_bomb()
		self._bomb = var_0_7:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.weapon_spine.path)))

		local var_3_0 = self._bomb.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		var_3_0.AnimationState:SetAnimation(0, var_0_5.weapon_spine.bomb.name, var_0_5.weapon_spine.bomb.loop)

		self._weapon_spine = var_3_0
		self._follow_shadow = var_0_6:create():create_follow_shadow()
	end

	function arg_1_0:set_pos(arg_4_1)
		self._bomb.transform.position = arg_4_1
		self._bomb.transform.localScale = Vector3.New(self._side, 1, 1)
		self._follow_shadow.transform.position = arg_4_1 - Vector3.New(0, 4, 0)
	end

	function arg_1_0:set_speed(arg_5_1)
		self._speed = arg_5_1 * self._side
	end

	function arg_1_0.set_call_func(arg_6_0, arg_6_1)
		arg_6_0._after_attack = arg_6_1
	end

	function arg_1_0:set_target(arg_7_1, arg_7_2)
		local var_7_0 = self._battle_processor:find_visual(arg_7_1)

		if not var_7_0 then
			return
		end

		self._is_miss = arg_7_2
		self._target_pos = var_7_0:get_damage_point().transform.position

		if self._is_miss then
			self._target_pos = self._target_pos + Vector3.New((0.2 + 0.4 * self._battle_random:visualRandRange(0, 10) / 10) * self._side, -1.3, 0)
		end

		self._velocity = Vector3.New((self._target_pos.x - self._bomb.transform.position.x) / ((self._target_pos.x - self._bomb.transform.position.x) / self._speed), (self._target_pos.y - self._bomb.transform.position.y) / ((self._target_pos.x - self._bomb.transform.position.x) / self._speed), (self._target_pos.z - self._bomb.transform.position.z) / ((self._target_pos.x - self._bomb.transform.position.x) / self._speed))
		self._acceleration = Vector3.zero
	end

	function arg_1_0:update_bomb(arg_8_1, arg_8_2)
		if not self._bomb then
			return
		end

		self:__update_bomb_move(arg_8_1, arg_8_2)
		self:__post_update(arg_8_1, arg_8_2)
	end

	function arg_1_0:eventOnFrame(arg_9_1, arg_9_2)
		self:update_bomb(arg_9_1, arg_9_2)
	end

	function arg_1_0:pause()
		if self._weapon_spine and not self._weapon_spine:Equals(nil) then
			self._weapon_spine.timeScale = 0
		end
	end

	function arg_1_0:resume()
		if self._weapon_spine and not self._weapon_spine:Equals(nil) then
			self._weapon_spine.timeScale = 1
		end
	end

	function arg_1_0:__update_bomb_move(arg_12_1, arg_12_2)
		if self._velocity ~= Vector3.zero or self._acceleration ~= Vector3.zero then
			self._bomb.transform.position = self._bomb.transform.position + (self._velocity + self._acceleration) * arg_12_2 / 1000
			self._follow_shadow.transform.position = Vector3.New(self._bomb.transform.position.x, self._target_pos.y - 1, 0)
		end
	end

	function arg_1_0:__post_update(arg_13_1, arg_13_2)
		if math.abs(self._bomb.transform.position.x) >= math.abs(self._target_pos.x) then
			self._velocity = Vector3.zero
			self._acceleration = Vector3.zero

			if self._after_attack then
				self._after_attack()

				self._after_attack = nil
			end

			if self._is_miss then
				self:__create_bomb_at_sea(var_0_5.effect_spine.splash, self._target_pos)
			else
				self:__create_bomb_at_sea(var_0_5.effect_spine.bomb_at_sea, self._target_pos)
			end

			self:__remove_bomb()
			self:__remove_shadow()
		end
	end

	function arg_1_0:__create_bomb_at_sea(arg_14_1, arg_14_2)
		local var_14_0 = self._owner:get_ship_ton()
		local var_14_1 = var_0_7:createBattleGameObject((var_0_5:get_final_battle_prefab_path(var_0_5.effect_spine.path)))
		local var_14_2 = var_14_1.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		var_14_2.AnimationState:SetAnimation(arg_14_1.priority, arg_14_1.name, arg_14_1.loop)

		var_14_1.transform.position = arg_14_2
		var_14_1.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 1

		if self._is_miss then
			var_14_1.transform:GetComponent(typeof(UnityEngine.MeshRenderer)).sortingOrder = 0
		end

		local var_14_3 = var_14_2.state.Complete

		local function var_14_4()
			var_14_2.state.Complete = var_14_3

			var_0_7:destroyGameObject(var_14_1)
		end

		var_14_3 = var_14_2.state.Complete + var_14_4
		var_14_2.state.Complete = var_14_2.state.Complete + var_14_4
		var_14_3 = var_14_3 - var_14_4

		if not self._is_miss then
			if var_14_0 == 3 then
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_l))
			elseif var_14_0 == 2 then
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_m))
			else
				self:_play_into_se(var_0_5:get_audio_url(var_0_5.common_icon.music_path, var_0_5.destroyer_s))
			end
		end
	end

	function arg_1_0:__remove_bomb()
		var_0_7:destroyGameObject(self._bomb)

		self._bomb = nil
		self._bomb_skele = nil
	end

	function arg_1_0:__remove_shadow()
		var_0_7:destroyGameObject(self._follow_shadow)

		self._follow_shadow = nil
	end

	function arg_1_0:__eventOnDestroy()
		self:__remove_bomb()
		self:__remove_shadow()
	end

	function arg_1_0._play_into_se(arg_19_0, arg_19_1)
		var_0_7:playBattleSE(arg_19_1, false)
	end
end, "base_visual")

function var_0_0.create(arg_20_0, arg_20_1)
	local var_20_0 = var_0_1.class("bomb_visual", gamecore.base_visual:inherit())

	var_20_0._owner = arg_20_1:get_owner()
	var_20_0._bomb = nil
	var_20_0._speed = 3.5
	var_20_0._follow_shadow = nil
	var_20_0._weapon_spine = nil

	return var_20_0
end

return var_0_0
