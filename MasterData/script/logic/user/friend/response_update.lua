local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:FriendInfoUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__friend__action(iter_2_1.action, iter_2_1.info, 1)
		end
	end

	function arg_1_0:FriendRequestInfoUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__friend__action(iter_3_1.action, iter_3_1.info, 2)
		end
	end

	function arg_1_0:__friend__action(arg_4_1, arg_4_2, arg_4_3)
		if arg_4_1 == var_0_2.update_modify then
			self:__friend__update_friend_info(arg_4_2, arg_4_3)
		elseif arg_4_1 == var_0_2.update_add then
			self:__friend__add_friend_info(arg_4_2, arg_4_3)
		elseif arg_4_1 == var_0_2.update_remove then
			self:__friend__remove_friend_info(arg_4_2, arg_4_3)
		end
	end
end

function var_0_0.extend_obj(arg_5_0)
	return
end

return var_0_0
