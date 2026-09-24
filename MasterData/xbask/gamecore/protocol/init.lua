return {
	init = function(arg_1_0, arg_1_1)
		for iter_1_0, iter_1_1 in pairs({
			"protocol"
		}) do
			gamecore.local_register_instance(iter_1_1, arg_1_1(arg_1_0 .. "." .. iter_1_1))
		end

		gamecore.protocol:reset()
	end
}
