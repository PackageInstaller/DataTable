local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:StoryUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__story__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:CustomCoverNotify(arg_3_1)
		if arg_3_1 and next(arg_3_1) then
			self:save_selected_pic(arg_3_1)
		end
	end

	function arg_1_0:__story__action(arg_4_1, arg_4_2)
		if arg_4_2 == var_0_3.update_modify then
			self:update_player_story_unlock_data(arg_4_1)
		elseif arg_4_2 == var_0_3.update_add then
			self:add_unlock_player_data(arg_4_1)
		elseif arg_4_2 == var_0_3.update_remove then
			self:remove_story_data(arg_4_1)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
