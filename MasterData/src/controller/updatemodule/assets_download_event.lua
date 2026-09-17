local var_0_0 = {
	EVENTID = {
		ASSETS_DOWNLOAD_EVENT_PROCESS = 2,
		ASSETS_DOWNLOAD_EVENT_ERROR = 3,
		ASSETS_DOWNLOAD_EVENT_SUCCESS = 1
	}
}
local var_0_1 = {}

function var_0_0.register(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	assert(arg_1_3, "handler can not be nil")

	local var_1_0 = var_0_1[arg_1_1]

	if not var_0_1[arg_1_1] then
		var_1_0 = {}
		var_0_1[arg_1_1] = var_1_0
	end

	table.insert(var_1_0, {
		obj = arg_1_2,
		handler = arg_1_3
	})
end

function var_0_0.unregister(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_1[arg_2_1] or {}

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1.handler == arg_2_2 then
			table.remove(var_2_0, iter_2_0)

			break
		end
	end
end

local function var_0_2(arg_3_0)
	print(arg_3_0)
	print(debug.traceback())
end

function var_0_0.dispatch(arg_4_0, arg_4_1, ...)
	if var_0_1[arg_4_1] then
		for iter_4_0, iter_4_1 in ipairs(var_0_1[arg_4_1]) do
			xpcall(iter_4_1.handler, var_0_2, iter_4_1.obj, ...)
		end
	end
end

return var_0_0
