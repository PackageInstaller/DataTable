local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = gameenum.common_type
local var_0_3 = gamecore.BattleManager

lx.define_class("effect", function(arg_1_0)
	function arg_1_0:create_effect(arg_2_1)
		self._effect = var_0_3:createBattleGameObject((var_0_2:get_final_battle_prefab_path(self._effect_spine.path)))
		self._skele = self._effect.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		self:play_animation(self._effect_spine[arg_2_1])
	end

	function arg_1_0.set_effect_spine(arg_3_0, arg_3_1)
		arg_3_0._effect_spine = arg_3_1
	end

	function arg_1_0:set_pos(arg_4_1)
		self._effect.transform.position = arg_4_1
	end

	function arg_1_0:set_side(arg_5_1)
		self._effect.transform.localScale = Vector3.New(arg_5_1, 1, 1)
	end

	function arg_1_0:play_animation(arg_6_1)
		if not arg_6_1 then
			return
		end

		self._skele.AnimationState:SetAnimation(arg_6_1.priority, arg_6_1.name, arg_6_1.loop)

		local var_6_0 = self._skele.state.Complete

		local function var_6_1()
			if self.remove_effect then
				self._skele.state.Complete = var_6_0

				self:remove_effect()
			end
		end

		var_6_0 = self._skele.state.Complete + var_6_1
		self._skele.state.Complete = self._skele.state.Complete + var_6_1
		var_6_0 = var_6_0 - var_6_1
	end

	function arg_1_0:remove_effect()
		var_0_3:destroyGameObject(self._effect)

		self._effect = nil
		self._skele = nil
	end

	function arg_1_0.create_follow_shadow(arg_9_0)
		local var_9_0 = var_0_3:createBattleGameObject((var_0_2:get_final_battle_prefab_path(var_0_2.shadow_spine.path)))
		local var_9_1 = var_9_0.transform:GetComponent(typeof(Spine.Unity.SkeletonAnimation))

		var_9_0.transform.localScale = Vector3.New(0.5, 0.5, 0.5)

		return var_9_0
	end
end)

function var_0_0.create(arg_10_0)
	local var_10_0 = var_0_1.class("effect")

	var_10_0._effect_spine = var_0_2.effect_spine
	var_10_0._effect = nil
	var_10_0._skele = nil

	return var_10_0
end

return var_0_0
