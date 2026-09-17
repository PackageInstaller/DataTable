local var_0_0 = {}
local var_0_1 = {}
local var_0_2 = false

function var_0_0.open(arg_1_0)
	var_0_2 = true
end

function var_0_0.close(arg_2_0)
	var_0_2 = false
end

function var_0_0.insertItemCache(arg_3_0, arg_3_1)
	if var_0_2 then
		table.insert(var_0_1, arg_3_1)
	end
end

function var_0_0.getItemDropList(arg_4_0)
	return var_0_1
end

function var_0_0.clear(arg_5_0)
	var_0_1 = {}
end

return var_0_0
