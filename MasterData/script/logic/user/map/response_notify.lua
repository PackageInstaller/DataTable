local var_0_0 = {}
local var_0_5 = gamecore.user
local var_0_10 = gameconfig.abyss_map_config
local var_0_11 = gameconfig.abyss_chapter_config

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:CompleteMapNotify(arg_2_1)
		self:set_clear_map_id(arg_2_1.id)

		local var_2_0 = var_0_5:get_new_battle_type()

		if var_2_0 == gameenum.battle_type.fight_type.abyss or var_2_0 == gameenum.battle_type.fight_type.abyss_2 then
			local var_2_1 = var_0_10.find_object_by_id(arg_2_1.id)
			local var_2_3 = var_0_11.find_object_by_chapter_id((var_2_1 or nil) and var_2_1.pve_id)

			if var_2_3 then
				arg_2_1.reward = arg_2_1.reward or {}

				table.insert(arg_2_1.reward, {
					id = 19,
					count = var_2_3.pass_score1
				})
			end
		elseif var_2_0 == gameenum.battle_type.fight_type.seventh then
			var_0_5:set_first_pass_seven_map_id(tostring(arg_2_1.id))
		end

		self:set_clear_map_reward(arg_2_1.reward)
	end
end

function var_0_0.extend_obj(arg_3_0)
	return
end

return var_0_0
