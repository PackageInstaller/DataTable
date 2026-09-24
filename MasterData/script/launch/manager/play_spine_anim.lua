local var_0_0 = {}
local var_0_1 = lx

lx.define_class("play_spine_anim", function(arg_1_0)
	function arg_1_0.init(arg_2_0, arg_2_1)
		arg_2_0._skeleton = arg_2_1
	end

	function arg_1_0:play_spine_animation(arg_3_1, arg_3_2)
		local var_3_0 = self._skeleton.skeletonDataAsset:GetAnimationStateData()
		local var_3_1 = self._skeleton.AnimationState:GetCurrent(2)

		if not var_3_1 then
			var_3_1 = self._skeleton.AnimationState:GetCurrent(1)

			self._skeleton.AnimationState:AddAnimation(0, arg_3_1, true)
		else
			local var_3_2 = var_3_1.Animation.Name

			if arg_3_2 > 0 then
				var_3_0:SetMix(var_3_2, arg_3_1, arg_3_2)
			else
				var_3_0:SetMix(var_3_2, arg_3_1, 0.8)
			end

			self._skeleton.AnimationState:AddAnimation(1, arg_3_1, true, 0)
		end
	end
end)

function var_0_0.create(arg_4_0)
	local var_4_0 = var_0_1.class("play_spine_anim")

	var_4_0._skeleton = nil

	return var_4_0
end

return var_0_0
