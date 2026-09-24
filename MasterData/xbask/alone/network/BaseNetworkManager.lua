local var_0_0 = lx
local var_0_2 = assert
local var_0_3 = table.insert
local var_0_4 = table.remove
local var_0_5 = debug.traceback

lx.define_class("BaseNetworkManager", function(arg_1_0)
	function arg_1_0:addNetObject(arg_2_1)
		if arg_2_1:getID() ~= nil then
			var_0_2(arg_2_1:getID() == nil)
		end

		local var_2_0 = self._alloc_id + 1

		self._alloc_id = self._alloc_id + 1
		self._wait_add = self._wait_add or {}

		var_0_3(self._wait_add, {
			id = var_2_0,
			net_obj = arg_2_1
		})

		return var_2_0
	end

	function arg_1_0:removeNetObject(arg_3_1)
		if self._set[arg_3_1] then
			self._wait_removed = self._wait_removed or {}

			var_0_3(self._wait_removed, arg_3_1)
		end
	end

	function arg_1_0:run_once()
		self._wait_add = self._wait_add or {}
		self._wait_removed = self._wait_removed or {}

		while true do
			local var_4_0 = var_0_4(self._wait_removed, 1)

			if not var_4_0 then
				break
			end

			self._set[var_4_0] = nil
		end

		while true do
			local var_4_1 = var_0_4(self._wait_add, 1)

			if not var_4_1 then
				break
			end

			self._set[var_4_1.id] = var_4_1.net_obj
		end

		for iter_4_0, iter_4_1 in pairs(self._set) do
			self:__run_the_one(iter_4_1)
		end
	end

	function arg_1_0.__run_the_one(arg_5_0, arg_5_1)
		local var_5_0, var_5_1 = xpcall(arg_5_1.run_once, var_0_5, arg_5_1)

		if not var_5_0 then
			log.errorlog(var_5_1)
		end
	end

	function arg_1_0.eventOnHotUpdate(arg_6_0)
		return
	end

	function arg_1_0:destroy_instance()
		local var_7_0 = {}

		for iter_7_0, iter_7_1 in pairs(self._set) do
			var_7_0[iter_7_0] = iter_7_1
		end

		for iter_7_2, iter_7_3 in pairs(var_7_0) do
			iter_7_3:destroy()
		end

		self._set = {}
	end
end)

return function()
	local var_8_0 = var_0_0.class("BaseNetworkManager")

	var_8_0._alloc_id = 0
	var_8_0._set = {}
	var_8_0._wait_add = {}
	var_8_0._wait_removed = {}

	return var_8_0
end
