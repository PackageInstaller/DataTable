local var_0_0 = {}
local var_0_1

function var_0_0._set_data(arg_1_0)
	var_0_1 = arg_1_0
end

function var_0_0.get_sequence()
	return var_0_1.sequence, var_0_1.sequence_num
end

function var_0_0.find_object_by_sequence_index(arg_3_0)
	return var_0_1.sequence[arg_3_0]
end

function var_0_0.find_object_by_guide_id(arg_4_0)
	if not var_0_1.unique_guide_id[arg_4_0] then
		return nil
	end

	return var_0_1.sequence[var_0_1.unique_guide_id[arg_4_0]]
end

return var_0_0
