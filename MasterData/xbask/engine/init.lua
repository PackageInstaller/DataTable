local var_0_0 = {}
local var_0_1 = string.gsub

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1(var_0_1(arg_1_1, "\\", "/"), "/+$", "") .. "/"

	if not require(var_1_0 .. arg_1_0 .. "/core/init").init(arg_1_0, var_1_0, arg_1_2) then
		error(string.format("%s init failed!", arg_1_0))
	end
end

return var_0_0
