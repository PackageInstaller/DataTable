local var_0_0 = lx
local var_0_1 = assert
local var_0_2 = string.rep
local var_0_3 = string.format
local var_0_4 = table.insert
local var_0_5 = table.remove
local var_0_6 = get_millisecond

lx.define_class("runtime_profiler", function(arg_1_0)
	function arg_1_0:getProfilerInfo()
		local var_2_0 = {}

		for iter_2_0, iter_2_1 in pairs(self._fragment_set) do
			var_0_4(var_2_0, iter_2_1)
		end

		table.sort(var_2_0, function(arg_3_0, arg_3_1)
			return arg_3_0.order_id < arg_3_1.order_id
		end)

		local var_2_1 = {
			"\t(run information:\n"
		}

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			var_0_4(var_2_1, var_0_3("%s%s:[%s]\n", var_0_2("\t", iter_2_3.depth + 2), iter_2_3.name, iter_2_3.elapsed_time))
		end

		var_0_4(var_2_1, "\t)")

		return table.concat(var_2_1)
	end

	function arg_1_0:reset()
		self._order_alloc = 1
		self._depth = 0

		while var_0_5(self._stack) do
			-- block empty
		end
	end

	function arg_1_0:on_begin(arg_5_1)
		local var_5_0 = var_0_6()
		local var_5_1 = self._fragment_set[arg_5_1]

		if self._fragment_set[arg_5_1] then
			var_5_1.begin_time = var_5_0
		else
			var_5_1 = {
				order_id = 0,
				depth = 0,
				elapsed_time = 0,
				name = arg_5_1,
				begin_time = var_5_0
			}
			self._fragment_set[arg_5_1] = var_5_1
		end

		var_5_1.order_id = self:__next_order_id()
		var_5_1.depth = self:__depth_inc()

		var_0_4(self._stack, arg_5_1)
	end

	function arg_1_0:on_end(arg_6_1)
		self._fragment_set[arg_6_1].elapsed_time = var_0_6() - self._fragment_set[arg_6_1].begin_time

		self:__depth_dec()

		local var_6_0 = var_0_5(self._stack)

		if var_6_0 ~= arg_6_1 then
			var_0_1(var_6_0 == arg_6_1, var_0_3("why end name '%s' not is stack pop name '%s'?", arg_6_1, var_6_0))
		end
	end

	function arg_1_0:__next_order_id()
		self._order_alloc = self._order_alloc + 1

		return self._order_alloc
	end

	function arg_1_0:__depth_inc()
		self._depth = self._depth + 1

		return self._depth
	end

	function arg_1_0:__depth_dec()
		self._depth = self._depth - 1

		if self._depth < 0 then
			var_0_1(self._depth >= 0)
		end
	end
end)

return function()
	local var_10_0 = var_0_0.class("runtime_profiler")

	_order_alloc = 1
	var_10_0._depth = 0
	var_10_0._fragment_set = {}
	var_10_0._stack = {}

	return var_10_0
end
