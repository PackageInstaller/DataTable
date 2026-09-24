local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gameenum.common_type
local var_0_5 = gamecore.effect
local var_0_6 = gamecore.BattleManager

lx.define_class("booster_visual", function(arg_1_0)
	function arg_1_0:init()
		self._side = self._owner:get_side()
	end

	function arg_1_0:create_booster()
		self._booster = var_0_6:createBattleGameObject((var_0_4:get_final_battle_prefab_path(var_0_4.missile_spine.path)))

		local var_3_0 = self._booster.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

		var_3_0.skeleton:SetSkin(var_0_4.missile_spine.skin.hit)
		var_3_0.AnimationState:SetAnimation(0, var_0_4.missile_spine.booster.name, var_0_4.missile_spine.booster.loop)

		self._booster.transform.localScale = Vector3.New(self._side * 0.5, 0.5, 0.5)
		self._weapon_spine = var_3_0
		self._follow_shadow = var_0_5:create():create_follow_shadow()
	end

	function arg_1_0.set_target_id(arg_4_0, arg_4_1)
		arg_4_0._target_id = arg_4_1
	end

	function arg_1_0:set_pos(arg_5_1)
		self._booster.transform.position = arg_5_1
		self._follow_shadow.transform.position = arg_5_1
	end

	function arg_1_0:init_action(arg_6_1)
		local var_6_0 = self._battle_processor:find_visual(self._target_id)

		if not var_6_0 then
			return
		end

		self._acceleration = Vector3.New(0, -5, 0)
		self._target_pos = var_6_0:get_spine_root().transform.position
		self._velocity = arg_6_1 / 3
	end

	function arg_1_0:update_booster(arg_7_1, arg_7_2)
		self:__before_update(arg_7_1, arg_7_2)
		self:__update_move(arg_7_1, arg_7_2)
	end

	function arg_1_0:eventOnFrame(arg_8_1, arg_8_2)
		if not self._booster then
			return
		end

		self:update_booster(arg_8_1, arg_8_2)
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

	function arg_1_0:__before_update(arg_11_1, arg_11_2)
		if self._booster.transform.position.y <= self._target_pos.y then
			self:__create_splash_by_air()
			self:__remove_booster()
			self:__remove_shadow()
		end
	end

	function arg_1_0:__update_move(arg_12_1, arg_12_2)
		if not self._booster then
			return
		end

		self._booster.transform.position = self._booster.transform.position + (self._velocity + self._acceleration) * arg_12_2 / 1000
		self._booster.transform.localEulerAngles = Vector3.New(0, 0, Mathf.Atan((self._velocity.y + self._acceleration.y) / self._velocity.x) * Mathf.Rad2Deg)
		self._follow_shadow.transform.position = Vector3.New(self._booster.transform.position.x, self._target_pos.y, 0)
	end

	function arg_1_0:__create_splash_by_air()
		local var_13_0 = var_0_5:create()

		var_13_0:create_effect("splash_by_air")
		var_13_0:set_pos(self._booster.transform.position)
	end

	function arg_1_0:__remove_booster()
		var_0_6:destroyGameObject(self._booster)

		self._booster = nil
		self._weapon_spine = nil
	end

	function arg_1_0:__remove_shadow()
		var_0_6:destroyGameObject(self._follow_shadow)

		self._follow_shadow = nil
	end
end, "base_visual")

function var_0_0.create(arg_16_0, arg_16_1)
	local var_16_0 = var_0_1.class("booster_visual", gamecore.base_visual:inherit())

	var_16_0._owner = arg_16_1:get_owner()
	var_16_0._booster = nil
	var_16_0._speed = 2
	var_16_0._start_vy = 0
	var_16_0._start_offset = 0
	var_16_0._follow_shadow = nil
	var_16_0._weapon_spine = nil

	return var_16_0
end

return var_0_0
