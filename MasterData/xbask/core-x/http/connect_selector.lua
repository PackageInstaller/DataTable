local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = type
local var_0_3 = tonumber
local var_0_4 = tostring
local var_0_5 = table.insert
local var_0_6 = socketer
local var_0_7 = lx.url_util

lx.define_class("connect_selector", function(arg_1_0)
	function arg_1_0:set_default_url(arg_2_1)
		self:__check_can_change()

		self._default_url = arg_2_1

		self:add_url(arg_2_1)
	end

	function arg_1_0:set_default_ip_port(arg_3_1, arg_3_2)
		self:__check_can_change()

		arg_3_2 = var_0_3(arg_3_2)
		self._default_ip_port = {
			ip = arg_3_1,
			port = arg_3_2
		}

		self:add_ip_port(self._default_ip_port.ip, self._default_ip_port.port)
	end

	function arg_1_0:add_url(arg_4_1)
		self:__check_can_change()

		if not self._default_url then
			assert(self._default_url)
		end

		local var_4_0 = var_0_7.parse(arg_4_1)

		if not var_4_0 or not var_4_0.scheme then
			assert(var_4_0 and var_4_0.scheme, "url format error, url:" .. var_0_4(arg_4_1))
		end

		var_4_0.port = var_4_0.port and var_0_3(var_4_0.port) or var_4_0.scheme == "https" and 443 or 80

		local var_4_2 = self._default_url == arg_4_1

		self._url_set = self._url_set or {}

		var_0_5(self._url_set, {
			available = false,
			url = arg_4_1,
			default = var_4_2,
			ip = var_4_0.host,
			port = var_4_0.port
		})
	end

	function arg_1_0:add_ip_port(arg_5_1, arg_5_2)
		self:__check_can_change()

		arg_5_2 = var_0_3(arg_5_2)

		if not self._default_ip_port then
			assert(self._default_ip_port)
		end

		local var_5_0 = self._default_ip_port.ip == arg_5_1 and self._default_ip_port.port == arg_5_2

		self._ip_port_set = self._ip_port_set or {}

		var_0_5(self._ip_port_set, {
			available = false,
			ip = arg_5_1,
			default = var_5_0,
			port = arg_5_2
		})
	end

	function arg_1_0:set_timeout(arg_6_1)
		self:__check_can_change()

		if arg_6_1 < 0 then
			assert(arg_6_1 >= 0)
		end

		self._timeout = arg_6_1
	end

	function arg_1_0:set_min_check_time(arg_7_1)
		self:__check_can_change()

		if arg_7_1 < 0 then
			assert(arg_7_1 >= 0)
		end

		self._min_check_time = arg_7_1
	end

	function arg_1_0:set_func(arg_8_1)
		self:__check_can_change()

		if var_0_2(arg_8_1) ~= "function" then
			assert(var_0_2(arg_8_1) == "function")
		end

		self._func = arg_8_1
	end

	function arg_1_0:execute()
		if self._id ~= 0 then
			assert(self._id == 0, "repeat execute.")
		end

		if self._func == nil then
			assert(var_0_2(self._func) == "function", "need call 'set_func'")
		end

		self:__check_generate_param()

		self._id, self._start_execute_time = var_0_1.http_request_manager:__add_wait_execute(self)
	end

	function arg_1_0:__run_once(arg_10_1)
		if arg_10_1 - self._start_execute_time > self._timeout then
			self:__on_finish()

			return true
		end

		local var_10_0 = arg_10_1 - self._start_execute_time > self._min_check_time

		for iter_10_0, iter_10_1 in pairs(self._url_set or self._ip_port_set) do
			if iter_10_1.available then
				if var_10_0 then
					self:__on_finish(iter_10_1)

					return true
				end
			else
				if iter_10_1.con == nil then
					iter_10_1.con = var_0_6.create()
				end

				if var_0_6.connect(iter_10_1.con, iter_10_1.ip, iter_10_1.port) then
					iter_10_1.available = true

					if var_10_0 or iter_10_1.default then
						self:__on_finish(iter_10_1)

						return true
					end
				end
			end
		end

		return false
	end

	function arg_1_0:__on_destroy()
		for iter_11_0, iter_11_1 in pairs(self._url_set or self._ip_port_set) do
			if iter_11_1.con then
				var_0_6.release(iter_11_1.con)

				iter_11_1.con = nil
			end
		end
	end

	function arg_1_0:__on_finish(arg_12_1)
		if self._default_url then
			if arg_12_1 then
				self._func(arg_12_1.url, false)
			else
				self._func(self._default_url, true)
			end
		elseif arg_12_1 then
			self._func(arg_12_1.ip, arg_12_1.port, false)
		else
			self._func(self._default_ip_port.ip, self._default_ip_port.port, true)
		end
	end

	function arg_1_0:__check_can_change()
		if self._id ~= 0 then
			assert(self._id == 0, "already execute.")
		end
	end

	function arg_1_0:__check_generate_param()
		if self._default_url == nil and self._default_ip_port == nil then
			assert(self._default_ip_port)
		end

		if self._default_ip_port and (self._default_url == nil or self._default_url == "") then
			assert(self._default_url == nil and self._default_url ~= "")
		end
	end
end)

function var_0_0.create(arg_15_0)
	local var_15_0 = var_0_1.class("connect_selector")

	var_15_0._id = 0
	var_15_0._timeout = 1000
	var_15_0._min_check_time = 382
	var_15_0._start_execute_time = 0
	var_15_0._default_url = nil
	var_15_0._url_set = nil
	var_15_0._default_ip_port = nil
	var_15_0._ip_port_set = nil
	var_15_0._func = nil

	return var_15_0
end

return var_0_0
