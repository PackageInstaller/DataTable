local var_0_0 = {}
local var_0_2 = gameenum.common_type

function var_0_0.extend_method(arg_1_0)
	function arg_1_0:BuildRecordUpdate(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.updates) do
			self:__collect_record_action(iter_2_1)
		end
	end

	function arg_1_0:__collect_record_action(arg_3_1)
		if arg_3_1.action == var_0_2.update_modify then
			self:__dock__update_collect_record_info(arg_3_1.type, arg_3_1.record)
		elseif arg_3_1.action == var_0_2.update_add then
			self:__dock__add_collect_record_info(arg_3_1.type, arg_3_1.record)
		elseif arg_3_1.action == var_0_2.update_remove then
			self:__dock__remove_collect_record_info(arg_3_1.type, arg_3_1.record)
		end
	end
end

function var_0_0.extend_obj(arg_4_0)
	return
end

return var_0_0
