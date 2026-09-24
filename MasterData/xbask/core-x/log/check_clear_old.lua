local var_0_0 = {}
local var_0_1 = lx_core_x
local var_0_2 = directory
local var_0_3 = os.remove
local var_0_4 = os.date
local var_0_5 = os.time
local var_0_7 = table.insert

function var_0_0.clear_old_log(arg_1_0)
	local var_1_0

	if type(arg_1_0) ~= "number" or arg_1_0 < 0 then
		arg_1_0 = 180
		var_1_0 = var_0_4("*t")
	end

	local var_1_1 = var_0_5({
		year = var_1_0.year,
		month = var_1_0.month,
		day = var_1_0.day
	}) - arg_1_0 * 24 * 3600
	local var_1_2 = "00#none"
	local var_1_3 = {}
	local var_1_4 = {}
	local var_1_5 = {}
	local var_1_6 = {}

	local function var_1_7(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 then
			arg_2_1 = var_1_2
		end

		var_0_7(var_1_3, {
			dirname = arg_2_0,
			filename = arg_2_1
		})

		return true
	end

	var_0_2.foreach(var_0_1.get_log_root_dir(), function(...)
		return var_1_7(...)
	end)

	local function var_1_8(arg_4_0, arg_4_1)
		local var_4_0 = false
		local var_4_1, var_4_2, var_4_3 = arg_4_0:match("/(%d+)-(%d+)-(%d+)/")

		if not var_4_1 and arg_4_1 then
			var_4_1, var_4_2, var_4_3 = arg_4_1:match("/(%d+)-(%d+)/(%d+)")

			if not var_4_1 then
				var_4_1, var_4_2, var_4_3 = arg_4_1:match("(%d+)-(%d+)-(%d+)-(%d+)-(%d+)-(%d+)%.")
			end

			if not var_4_1 then
				var_4_1, var_4_2, var_4_3 = arg_4_1:match("/(%d+)-(%d+)-(%d+)-(%d+)%.")
			end

			if not var_4_1 then
				var_4_1, var_4_2, var_4_3 = arg_4_1:match("/(%d+)-(%d+)-(%d+)%.")
			end

			var_4_0 = true
		end

		if var_4_1 then
			local var_4_4 = var_0_5({
				year = var_4_1,
				month = var_4_2,
				day = var_4_3
			})

			if var_4_4 == nil then
				var_4_4 = 0
			end

			if var_4_4 <= var_1_1 then
				if var_4_0 and arg_4_1:find(var_1_2) == nil then
					var_1_6[arg_4_1] = true
				end

				if var_1_5[arg_4_0] ~= false then
					var_1_5[arg_4_0] = true
				end
			else
				var_1_5[arg_4_0] = false
			end
		elseif arg_4_1 then
			var_1_5[arg_4_0] = false
		end
	end

	for iter_1_0, iter_1_1 in pairs(var_1_3) do
		local var_1_9 = var_1_4[iter_1_1.dirname]

		if not var_1_4[iter_1_1.dirname] then
			var_1_9 = {}
			var_1_4[iter_1_1.dirname] = var_1_9
		end

		var_1_9[iter_1_1.filename] = iter_1_1.dirname .. iter_1_1.filename
	end

	for iter_1_2, iter_1_3 in pairs(var_1_4) do
		var_1_8(iter_1_2)

		for iter_1_4, iter_1_5 in pairs(iter_1_3) do
			var_1_8(iter_1_2, iter_1_5)
		end
	end

	for iter_1_6, iter_1_7 in pairs(var_1_5) do
		if iter_1_7 then
			var_0_2.rmdir(iter_1_6)
		end
	end

	for iter_1_8, iter_1_9 in pairs(var_1_6) do
		if iter_1_9 then
			var_0_3(iter_1_8)
		end
	end
end

return var_0_0
