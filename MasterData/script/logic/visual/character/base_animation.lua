local var_0_0 = {}
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:play_animation(arg_2_1, arg_2_2)
		if ((self._current_motion or nil) and self._current_motion.priority) > arg_2_1.priority then
			return
		end

		self._current_motion = {
			name = arg_2_1.name,
			priority = arg_2_1.priority,
			loop = arg_2_1.loop
		}

		self:__complete_func(self._skeleton_animation, arg_2_2)

		self._track_entry = self._skeleton_animation.AnimationState:SetAnimation(arg_2_1.priority, arg_2_1.name, arg_2_1.loop)
	end

	function arg_1_0:play_animation_by_skele(arg_3_1, arg_3_2, arg_3_3)
		self:__complete_func(arg_3_1, arg_3_3)
		arg_3_1.AnimationState:SetAnimation(arg_3_2.priority, arg_3_2.name, arg_3_2.loop)
	end

	function arg_1_0:set_event_listener(arg_4_1, arg_4_2, arg_4_3)
		local var_4_0

		if not arg_4_3 then
			arg_4_3 = self._skeleton_animation

			function var_4_0(arg_5_0, arg_5_1)
				if arg_5_1.Data.Name == arg_4_1 then
					if not arg_4_3 or arg_4_3:Equals(nil) then
						return
					end

					if arg_4_2 then
						arg_4_2()

						arg_4_2 = nil
					end
				end
			end
		end

		arg_4_3.AnimationState.Event = arg_4_3.AnimationState.Event + var_4_0
	end

	function arg_1_0:get_attack_point()
		return self._attack_point
	end

	function arg_1_0:get_throw_point()
		return self._throw_point
	end

	function arg_1_0:get_damage_point()
		return self._damage_point
	end

	function arg_1_0:get_antiair_point()
		return self._antiair_point
	end

	function arg_1_0:get_spine_root()
		return self._spine_root
	end

	function arg_1_0:get_hp_point()
		return self._hp_point
	end

	function arg_1_0:get_dialogue_point()
		return self._dialogue_point
	end

	function arg_1_0:set_shadow_active(arg_13_1)
		if self._shadow then
			self._shadow.gameObject:SetActive(arg_13_1)
		end
	end

	function arg_1_0:set_mask_active(arg_14_1)
		if self._mask then
			self._mask.gameObject:SetActive(arg_14_1)
		end
	end

	function arg_1_0:__init_animation()
		self._skeleton_animation = self._spine:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))
		self._attack_point = self._spine_root.transform:Find("attack").gameObject:GetComponent(var_0_2(var_0_3.Unity.BoneFollower))
		self._attack_point.skeletonRenderer = self._skeleton_animation
		self._attack_point.boneName = "Attack_Point"

		local var_15_0 = "Throw_Point"

		if not var_0_4:is_aircraft((self._logic:get_ship_type())) then
			var_15_0 = "Attack_Point"
		end

		self._throw_point = self._spine_root.transform:Find("throw").gameObject:GetComponent(var_0_2(var_0_3.Unity.BoneFollower))
		self._throw_point.skeletonRenderer = self._skeleton_animation

		if not self._throw_point:SetBone(var_15_0) then
			self._throw_point:SetBone("Attack_Point")
		end

		self._damage_point = self._spine_root.transform:Find("damage").gameObject:GetComponent(var_0_2(var_0_3.Unity.BoneFollower))
		self._damage_point.skeletonRenderer = self._skeleton_animation
		self._damage_point.boneName = "Damage_Point"
		self._hp_point = self._spine_root.transform:Find("hp")
		self._antiair_point = self._spine_root.transform:Find("anti_air").gameObject:GetComponent(var_0_2(var_0_3.Unity.BoneFollower))
		self._antiair_point.skeletonRenderer = self._skeleton_animation
		self._antiair_point.boneName = "Antiaircraft"
		self._dialogue_point = self._spine_root.transform:Find("dialogue").gameObject:GetComponent(var_0_2(var_0_3.Unity.BoneFollower))
		self._dialogue_point.skeletonRenderer = self._skeleton_animation
		self._dialogue_point.boneName = "Expression"
		self._shadow = self._spine_root.transform:Find("shadow")
		self._mask = self._spine_root.transform:Find("mask")

		self:play_animation(var_0_4.character_anim_type.normal)
	end

	function arg_1_0:update_animation()
		if self._current_motion and not self._current_motion.loop and self._track_entry.IsComplete then
			self._current_motion = nil
			self._track_entry = nil
		end

		if self._now_hp > 0 and not self._current_motion then
			self:play_animation(var_0_4.character_anim_type.normal)
		end
	end

	function arg_1_0.__complete_func(arg_17_0, arg_17_1, arg_17_2)
		if arg_17_2 then
			local var_17_0 = arg_17_1.state.Complete

			local function var_17_1()
				arg_17_2()

				arg_17_1.state.Complete = var_17_0
			end

			var_17_0 = arg_17_1.state.Complete + var_17_1
			arg_17_1.state.Complete = arg_17_1.state.Complete + var_17_1
			var_17_0 = var_17_0 - var_17_1
		end
	end

	function arg_1_0.__destroy_animation(arg_19_0)
		arg_19_0._spine = nil
		arg_19_0._skeleton_animation = nil
	end
end

function var_0_0.extend_obj(arg_20_0)
	arg_20_0._skeleton_animation = nil
	arg_20_0._current_motion = nil
	arg_20_0._track_entry = nil
	arg_20_0._attack_point = nil
	arg_20_0._damage_point = nil
	arg_20_0._antiair_point = nil
	arg_20_0._hp_point = nil
end

return var_0_0
