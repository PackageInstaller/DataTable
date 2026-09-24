local var_0_0 = {}
local var_0_1 = string.gsub

function var_0_0.init(arg_1_0, arg_1_1)
	local var_1_0 = var_0_1(var_0_1(arg_1_1, "\\", "/"), "/+$", "") .. "/"
	local var_1_1 = var_1_0 .. arg_1_0 .. "/core/core_x_instance"

	if not pcall(function()
		return require(var_1_1)
	end) then
		error(string.format("%s init failed!, path:%s", arg_1_0, var_1_0 .. arg_1_0 .. "/core/core_x_instance"))
	end

	if not require(var_1_0 .. arg_1_0 .. "/core/init").init(arg_1_0, var_1_0) then
		error(string.format("%s init failed!", arg_1_0))
	end
end

return var_0_0
