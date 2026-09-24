local var_0_0 = {}
local var_0_3 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:BoxroomWallUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__wall_collection__action(iter_2_1.info, iter_2_1.action)
		end
	end

	function arg_1_0:BoxroomDeskUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__desk_collection__action(iter_3_1.info, iter_3_1.action)
		end
	end

	function arg_1_0:MedalUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.updates) do
			self:__medal__action(iter_4_1.info, iter_4_1.action)
		end
	end

	function arg_1_0:BoxroomMedalUpdate(arg_5_1)
		self:__show__medal__action(arg_5_1.id_array)
	end

	function arg_1_0:BoxroomStyleUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__show_room_style__action(iter_6_1.id, iter_6_1.action)
		end
	end

	function arg_1_0:UnlockMedalUpdate(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
			self:__show_room_unlock_medal__action(iter_7_1.info, iter_7_1.action)
		end
	end

	function arg_1_0:__wall_collection__action(arg_8_1, arg_8_2)
		if arg_8_2 == var_0_3.update_modify then
			self:update_player_wall_collection_data(arg_8_1)
		elseif arg_8_2 == var_0_3.update_add then
			self:add_player_wall_collection_data(arg_8_1)
		elseif arg_8_2 == var_0_3.update_remove then
			self:remove_player_wall_collection_data(arg_8_1)
		end
	end

	function arg_1_0:__desk_collection__action(arg_9_1, arg_9_2)
		if arg_9_2 == var_0_3.update_modify then
			self:update_player_desk_collection_data(arg_9_1)
		elseif arg_9_2 == var_0_3.update_add then
			self:add_player_desk_collection_data(arg_9_1)
		elseif arg_9_2 == var_0_3.update_remove then
			self:remove_player_desk_collection_data(arg_9_1)
		end
	end

	function arg_1_0:__medal__action(arg_10_1, arg_10_2)
		if arg_10_2 == var_0_3.update_modify then
			self:update_player_medal_data(arg_10_1)
		elseif arg_10_2 == var_0_3.update_add then
			self:add_player_medal_data(arg_10_1)
		elseif arg_10_2 == var_0_3.update_remove then
			self:remove_player_medal_data(arg_10_1)
		end
	end

	function arg_1_0:__show_room_unlock_medal__action(arg_11_1, arg_11_2)
		if arg_11_2 == var_0_3.update_modify then
			self:update_player_unlock_medal_data(arg_11_1)
		elseif arg_11_2 == var_0_3.update_add then
			self:add_player_unlock_medal_data(arg_11_1)
		elseif arg_11_2 == var_0_3.update_remove then
			self:remove_player_unlock_medal_data(arg_11_1)
		end
	end

	function arg_1_0:__show__medal__action(arg_12_1)
		self:update_player_show_medal_data(arg_12_1)
	end

	function arg_1_0:__show_room_style__action(arg_13_1, arg_13_2)
		if arg_13_2 == var_0_3.update_modify then
			self:update_player_show_room_style_data(arg_13_1)
		elseif arg_13_2 == var_0_3.update_add then
			self:add_player_show_room_style_data(arg_13_1)
		end
	end
end

function var_0_0.extend_obj(arg_14_0)
	return
end

return var_0_0
