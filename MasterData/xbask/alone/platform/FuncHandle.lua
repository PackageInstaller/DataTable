local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert

lx.define_class("FuncHandle", function(arg_1_0)
	function arg_1_0:funcToHandle(arg_2_1)
		var_0_2(var_0_1(arg_2_1) == "function")

		local var_2_0 = self:__findIDByFunc(arg_2_1) or self:__newFuncObj(arg_2_1)

		self:__retainID(var_2_0)

		return var_2_0
	end

	function arg_1_0:removeFuncByHandle(arg_3_1)
		self:__releaseID(arg_3_1)

		return (self:__findFuncByID(arg_3_1))
	end

	function arg_1_0:__findFuncByID(arg_4_1)
		return self._id_func_map[arg_4_1]
	end

	function arg_1_0:__findIDByFunc(arg_5_1)
		return self._func_id_map[arg_5_1]
	end

	function arg_1_0:__allocNewID()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id + 1
	end

	function arg_1_0:__newFuncObj(arg_7_1)
		local var_7_0 = self:__allocNewID()

		self._func_id_map[arg_7_1] = var_7_0
		self._id_func_map[var_7_0] = arg_7_1
		self._id_ref_map[var_7_0] = 0

		return var_7_0
	end

	function arg_1_0:__retainID(arg_8_1)
		if self._id_ref_map[arg_8_1] then
			self._id_ref_map[arg_8_1] = self._id_ref_map[arg_8_1] + 1
		end
	end

	function arg_1_0:__releaseID(arg_9_1)
		if not self._id_ref_map[arg_9_1] then
			return
		end

		local var_9_0 = self._id_ref_map[arg_9_1] - 1

		if self._id_ref_map[arg_9_1] - 1 <= 0 then
			self._id_func_map[arg_9_1] = nil
			self._func_id_map[self._id_func_map[arg_9_1]] = nil
			var_9_0 = nil
		end

		self._id_ref_map[arg_9_1] = var_9_0
	end
end)

return function()
	local var_10_0 = var_0_0.class("FuncHandle")

	var_10_0._alloc_id = 0
	var_10_0._func_id_map = {}
	var_10_0._id_func_map = {}
	var_10_0._id_ref_map = {}

	return var_10_0
end
