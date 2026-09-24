return {
	init = function(arg_1_0, arg_1_1)
		local var_1_0 = cjson.encode

		function lx.json_format(arg_2_0)
			return var_1_0(arg_2_0, true, false, true)
		end

		lx.add_to_lx("format_to_json", arg_1_1(arg_1_0 .. ".format_to_json").format)

		for iter_1_0, iter_1_1 in pairs({
			"function"
		}) do
			arg_1_1(arg_1_0 .. "." .. iter_1_1)
		end
	end
}
