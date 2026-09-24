local var_0_0 = lx
local var_0_1 = lx.Time
local var_0_2 = lxnet
local var_0_3 = table.insert
local var_0_4 = table.remove
local var_0_5 = debug.traceback

lx.define_class("http_request_manager", function(arg_1_0)
	function arg_1_0:enableHostIPCache(arg_2_1, arg_2_2)
		assert(type(arg_2_1) == "boolean", "expect 'boolean' type.")

		arg_2_2 = arg_2_2 or 0

		if arg_2_2 < 0 then
			arg_2_2 = 0
		end

		self._enable_host_ip_cache = arg_2_1
		self._cache_valid_time = arg_2_2
		self._tls_scheme_set = self._tls_scheme_set or {}
		self._wait_add = self._wait_add or {}
		self._wait_removed = self._wait_removed or {}
		self._last_time = self._last_time or 0
	end

	function arg_1_0.resetHostIPCache(arg_3_0)
		arg_3_0._host_ip_cache = {}
	end

	function arg_1_0:enableTLS()
		if not self:__find_tls_scheme("tls") then
			require("ltls.init").init()

			local core = require("ltls.core")
			local var_4_1 = {
				core = core,
				ctx = core.newctx()
			}

			self:registerTLSScheme("tls", var_4_1, function()
				return var_4_1.core.newtls("client", var_4_1.ctx)
			end)
		end
	end

	function arg_1_0:registerTLSScheme(arg_6_1, arg_6_2, arg_6_3)
		self._tls_scheme_set[arg_6_1] = {
			scheme = arg_6_1,
			param = arg_6_2,
			create = arg_6_3
		}
	end

	function arg_1_0:__add_wait_execute(arg_7_1)
		local var_7_0 = self:__alloc_id()

		var_0_3(self._wait_add, {
			id = var_7_0,
			req = arg_7_1
		})

		return var_7_0, self._now_frame_time
	end

	function arg_1_0:__get_host_ip(arg_8_1)
		if not self._enable_host_ip_cache then
			return arg_8_1
		end

		local var_8_0 = self._host_ip_cache[arg_8_1]

		if not self._host_ip_cache[arg_8_1] then
			var_8_0 = {
				ip = var_0_2.get_host_ip_by_name(arg_8_1),
				expire_time = (self._cache_valid_time > 0 or nil) and self._now_frame_time + self._cache_valid_time
			}
			self._host_ip_cache[arg_8_1] = var_8_0
		end

		return var_8_0.ip or ""
	end

	function arg_1_0:__find_tls_scheme(arg_9_1)
		return self._tls_scheme_set[arg_9_1]
	end

	function arg_1_0:__create_tls_func(arg_10_1)
		if not self._tls_scheme_set[arg_10_1] then
			return nil
		end

		return self._tls_scheme_set[arg_10_1].create
	end

	function arg_1_0:__alloc_id()
		self._alloc_id = self._alloc_id + 1

		return self._alloc_id + 1
	end

	function arg_1_0:run_once(arg_12_1)
		self._now_frame_time = arg_12_1

		while true do
			local var_12_0 = var_0_4(self._wait_add, 1)

			if not var_12_0 then
				break
			end

			self._http_set[var_12_0.id] = var_12_0.req
		end

		for iter_12_0, iter_12_1 in pairs(self._http_set) do
			if self:__the_run_once(iter_12_1, arg_12_1) then
				iter_12_1:__on_destroy()
				var_0_3(self._wait_removed, iter_12_0)
			end
		end

		while true do
			local var_12_1 = var_0_4(self._wait_removed, 1)

			if not var_12_1 then
				break
			end

			self._http_set[var_12_1] = nil
		end

		if not self._enable_host_ip_cache then
			return
		end

		if arg_12_1 - self._last_time < 1000 then
			return
		end

		self._last_time = arg_12_1

		for iter_12_2, iter_12_3 in pairs(self._host_ip_cache) do
			if arg_12_1 > iter_12_3.expire_time and iter_12_3.expire_time > 0 then
				var_0_3(self._wait_removed, iter_12_2)
			end
		end

		while true do
			local var_12_2 = var_0_4(self._wait_removed, 1)

			if not var_12_2 then
				break
			end

			self._host_ip_cache[var_12_2] = nil
		end
	end

	function arg_1_0.__the_run_once(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0, var_13_1 = xpcall(arg_13_1.__run_once, var_0_5, arg_13_1, arg_13_2)

		if var_13_0 then
			return var_13_1
		end

		log.errorlog(var_13_1)

		return true
	end

	function arg_1_0:destroy_instance()
		for iter_14_0, iter_14_1 in pairs(self._http_set) do
			iter_14_1:__on_destroy()
		end

		self._http_set = {}
		self._wait_add = {}
		self._wait_removed = {}
	end
end)

return function()
	local var_15_0 = var_0_0.class("http_request_manager")

	var_15_0._alloc_id = 0
	var_15_0._now_frame_time = var_0_1:getTime()
	var_15_0._enable_host_ip_cache = true
	var_15_0._cache_valid_time = 0
	var_15_0._host_ip_cache = {}
	var_15_0._tls_scheme_set = {}
	var_15_0._http_set = {}
	var_15_0._wait_add = {}
	var_15_0._wait_removed = {}
	var_15_0._last_time = 0

	return var_15_0
end
