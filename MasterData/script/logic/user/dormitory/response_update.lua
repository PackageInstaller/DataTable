local var_0_0 = {}
local var_0_1 = gameenum.common_type
local var_0_2 = gamecore.UILoader

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:FurnitureUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__dormitory__furniture_action(iter_2_1.action, iter_2_1.info)
			self:set_box_result(iter_2_1.info)

			local var_2_0 = var_0_2:getInstance("chest_open_layer")

			if var_2_0 then
				var_2_0:refresh_lock_state(iter_2_1.info)
			end
		end
	end

	function arg_1_0:FurnitureArchiveUpdate(arg_3_1)
		for iter_3_0, iter_3_1 in pairs(arg_3_1.updates) do
			self:__dormitory__furniture_archive_action(iter_3_1.action, iter_3_1.info)
		end
	end

	function arg_1_0:RoomUpdate(arg_4_1)
		for iter_4_0, iter_4_1 in pairs(arg_4_1.updates) do
			self:__dormitory__room_action(iter_4_1.action, iter_4_1.info)
		end
	end

	function arg_1_0:FurnitureCollectUpdate(arg_5_1)
		for iter_5_0, iter_5_1 in pairs(arg_5_1.updates) do
			self:__dormitory__furniture_collect_action(iter_5_1.action, iter_5_1.info)
		end
	end

	function arg_1_0:ExhibitionCollectUpdate(arg_6_1)
		for iter_6_0, iter_6_1 in pairs(arg_6_1.updates) do
			self:__dormitory__exhibition_action(iter_6_1.action, iter_6_1.info)
		end
	end

	function arg_1_0:RoomRecordUpdate(arg_7_1)
		for iter_7_0, iter_7_1 in pairs(arg_7_1.updates) do
			self:__dormitory__record_action(iter_7_1.action, iter_7_1.info)
		end
	end

	function arg_1_0:RacingBuffInfoUpdate(arg_8_1)
		self:__dormitory__set_race_buff(arg_8_1.buff)

		local var_8_0 = var_0_2:getInstance("dormitory")

		if var_8_0 then
			var_8_0:update_race_buff_float()
		end
	end

	function arg_1_0:__dormitory__furniture_action(arg_9_1, arg_9_2)
		if arg_9_1 == var_0_1.update_modify then
			self:__dormitory__update_furniture_info(arg_9_2)
		elseif arg_9_1 == var_0_1.update_add then
			self:__dormitory__add_furniture_info(arg_9_2)
		elseif arg_9_1 == var_0_1.update_remove then
			self:__dormitory__remove_furniture_info(arg_9_2)
		end
	end

	function arg_1_0:__dormitory__furniture_archive_action(arg_10_1, arg_10_2)
		if arg_10_1 == var_0_1.update_modify then
			self:__dormitory__update_furniture_archive_info(arg_10_2)
		elseif arg_10_1 == var_0_1.update_add then
			self:__dormitory__add_furniture_archive_info(arg_10_2)
		elseif arg_10_1 == var_0_1.update_remove then
			self:__dormitory__remove_furniture_archive_info(arg_10_2)
		end
	end

	function arg_1_0:__dormitory__room_action(arg_11_1, arg_11_2)
		if arg_11_1 == var_0_1.update_modify then
			self:__dormitory__update_room_info(arg_11_2)
		elseif arg_11_1 == var_0_1.update_add then
			self:__dormitory__add_room_info(arg_11_2)
		elseif arg_11_1 == var_0_1.update_remove then
			self:__dormitory__remove_room_info(arg_11_2)
		end
	end

	function arg_1_0:__dormitory__furniture_collect_action(arg_12_1, arg_12_2)
		if arg_12_1 == var_0_1.update_modify then
			self:__dormitory__update_furniture_collect_info(arg_12_2)
		elseif arg_12_1 == var_0_1.update_add then
			self:__dormitory__add_furniture_collect_info(arg_12_2)
		elseif arg_12_1 == var_0_1.update_remove then
			self:__dormitory__remove_furniture_collect_info(arg_12_2)
		end
	end

	function arg_1_0:__dormitory__exhibition_action(arg_13_1, arg_13_2)
		if arg_13_1 == var_0_1.update_modify then
			self:__dormitory__update_exhibition_info(arg_13_2)
		elseif arg_13_1 == var_0_1.update_add then
			self:__dormitory__add_exhibition_info(arg_13_2)
		elseif arg_13_1 == var_0_1.update_remove then
			self:__dormitory__remove_exhibition_info(arg_13_2)
		end
	end

	function arg_1_0:__dormitory__record_action(arg_14_1, arg_14_2)
		if arg_14_1 == var_0_1.update_modify then
			self:__dormitory__update_record_info(arg_14_2)
		elseif arg_14_1 == var_0_1.update_add then
			self:__dormitory__add_record_info(arg_14_2)
		elseif arg_14_1 == var_0_1.update_remove then
			self:__dormitory__remove_record_info(arg_14_2)
		end
	end
end

function var_0_0.extend_obj(arg_15_0)
	return
end

return var_0_0
