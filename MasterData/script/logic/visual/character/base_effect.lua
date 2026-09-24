local var_0_0 = {}
local var_0_2 = typeof
local var_0_3 = Spine
local var_0_4 = gamecore.BattleManager
local var_0_5 = Spine.Unity.SkeletonAnimation
local var_0_6 = Spine.Unity.SkeletonGraphic
local var_0_7 = string.format
local var_0_8 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:create_effect(arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = var_0_8:get_final_battle_prefab_path(arg_2_1.path, nil, arg_2_3)
		local var_2_1 = var_0_4:createBattleGameObject(var_2_0)

		if not var_2_1 then
			log.print_r(arg_2_1.path, var_2_0, "特效为空")

			return
		end

		arg_2_2 = arg_2_2 or false

		if not arg_2_2 then
			local var_2_2 = var_2_1.transform:GetComponent(var_0_2(var_0_3.Unity.SkeletonAnimation))

			if arg_2_1.skin then
				var_2_2.skeleton:SetSkin(arg_2_1.skin)
			end

			self:play_animation_by_skele(var_2_2, arg_2_1.motion, arg_2_1.func)

			local var_2_3 = var_2_2.state.Complete

			local function var_2_4()
				if not arg_2_2 then
					var_0_4:destroyGameObject(var_2_1)

					var_2_2.state.Complete = var_2_3
				end
			end

			var_2_3 = var_2_2.state.Complete + var_2_4
			var_2_2.state.Complete = var_2_2.state.Complete + var_2_4
			var_2_3 = var_2_3 - var_2_4
		end

		return var_2_1, effect_skele or nil
	end

	function arg_1_0.create_spine(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = var_0_4:createBattleGameObject(var_0_8.ship_spine_obj)
		local var_4_1 = var_0_7(var_0_8.ship_spine, arg_4_1, arg_4_1)

		if not var_0_4:findPath(var_4_1) then
			var_4_1 = var_0_7(var_0_8.ship_spine, 1, 1)
		end

		local var_4_2 = var_0_5:AddToGameObject((var_0_4:loadBattleSkeletonDataAsset(var_4_1)))
		local var_4_3 = "default"

		if var_4_2.Skeleton.Data:FindSkin("normal") then
			var_4_3 = "normal"
		end

		var_4_2.Skeleton:SetSkin((arg_4_2 and var_4_2.Skeleton.Data:FindSkin("damage") or nil) and "damage")

		var_4_0.layer = 9

		return var_4_0, var_4_2
	end

	function arg_1_0.create_graphic_spine(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = var_0_7(var_0_8.ship_spine, arg_5_1, arg_5_1)

		if not var_0_4:findPath(var_5_0) then
			var_5_0 = var_0_7(var_0_8.ship_spine, 1, 1)
		end

		local var_5_1 = var_0_6:AddSkeletonGraphicComponent((var_0_4:loadBattleSkeletonDataAsset(var_5_0)))
		local var_5_2 = "default"

		if var_5_1.Skeleton.Data:FindSkin("normal") then
			var_5_2 = "normal"
		end

		var_5_1.Skeleton:SetSkin((arg_5_2 and var_5_1.Skeleton.Data:FindSkin("damage") or nil) and "damage")
		var_5_1.Skeleton:SetToSetupPose()

		return var_0_4:createBattleGameObject(var_0_8.ship_spine_obj), var_5_1
	end

	function arg_1_0.remove_effect(arg_6_0, arg_6_1)
		if not arg_6_1 then
			return
		end

		var_0_4:destroyGameObject(arg_6_1)
	end
end

function var_0_0.extend_obj(arg_7_0)
	return
end

return var_0_0
