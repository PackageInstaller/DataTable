local var_0_0 = lx
local var_0_1 = type
local var_0_2 = crypto.md5
local var_0_3 = lx.Time
local var_0_4 = lx.security
local var_0_5 = lx.http_request
local var_0_6 = lx.json_encode
local var_0_7 = 61440
local var_0_8 = 16384
local var_0_9 = 32768
local var_0_10 = 1048576

lx.define_class("monitor_report", function(arg_1_0)
	function arg_1_0.init(arg_2_0, arg_2_1, arg_2_2)
		arg_2_1 = arg_2_1:gsub("/$", "") .. "/"
		arg_2_0._root_url = arg_2_1
		arg_2_0._release = arg_2_2

		local var_2_0 = {}

		var_2_0.os_type = app:getSystem():getOSType()
		var_2_0.app_id = app:getSystem():getAppID()
		var_2_0.channel = app:getSystem():getChannel()
		var_2_0.app_version = app:getSystem():getAppVersion()
		var_2_0.data_version = app:getSystem():getDataVersion()
		var_2_0.sys = {
			disk_available = 0,
			memory_total = 0,
			memory_available = 0,
			cpu_num = processinfo_get().cpu_num
		}
		arg_2_0._extend = var_2_0

		var_0_0.traceback_add_skip_name("self")
		var_0_0.traceback_set_stack_frame(3)
	end

	function arg_1_0.setInterval(arg_3_0, arg_3_1)
		if arg_3_1 < 5000 then
			arg_3_1 = 5000
		end

		arg_3_0._interval = arg_3_1
	end

	function arg_1_0.setUserInfoFunc(arg_4_0, arg_4_1)
		assert(var_0_1(arg_4_1) == "function" or arg_4_1 == nil)

		arg_4_0._get_user_info_func = arg_4_1
	end

	function arg_1_0:isRelease()
		return self._release
	end

	function arg_1_0:report(arg_6_1)
		if self._root_url == "" then
			return
		end

		if var_0_1(arg_6_1) ~= "string" then
			return
		end

		local var_6_0 = var_0_3:getTime()

		if var_6_0 - self._last_report_time < self._interval then
			return
		end

		self._last_report_time = var_6_0
		arg_6_1 = arg_6_1:sub(1, var_0_7)

		local var_6_1 = var_0_6((self:__get_user_info()))

		if not self:__can_report(#arg_6_1, #var_6_1) then
			return
		end

		self:__update_sys_info()

		arg_6_1 = encode.quicklz_compress(arg_6_1)

		local var_6_2 = {
			app_id = self._extend.app_id,
			extend = var_0_6(self._extend),
			user_md5 = var_0_2.sum(var_6_1),
			body_md5 = var_0_2.sum(arg_6_1)
		}
		local var_6_3 = var_0_5:create()

		var_6_3:set_url(self._root_url .. "ErrorReport/")
		var_6_3:set_headers({
			Authorization = self._extend.app_id .. ":" .. var_0_4:sign(self._secret, var_0_4:format_data(var_6_2)),
			extend = var_6_2.extend,
			user = var_6_1
		})
		var_6_3:set_post()
		var_6_3:set_fields(arg_6_1)
		var_6_3:execute()
	end

	function arg_1_0:__get_user_info()
		if not self._get_user_info_func then
			return {}
		end

		local var_7_0 = self._get_user_info_func()

		if var_0_1(var_7_0) ~= "table" then
			return {}
		end

		return var_7_0
	end

	function arg_1_0:__can_report(arg_8_1, arg_8_2)
		self._total_report_num = self._total_report_num + 1

		if (self._total_report_size + arg_8_1) / self._total_report_num > var_0_9 then
			return false
		end

		if arg_8_2 > var_0_8 then
			return false
		end

		self._total_report_size = self._total_report_size + arg_8_1

		return true
	end

	function arg_1_0:__update_sys_info()
		local var_9_0 = 0
		local var_9_1 = 0

		if get_system_memory_info then
			var_9_0, var_9_1 = get_system_memory_info()
		end

		local var_9_2 = self._extend.sys

		var_9_2.disk_available = math.floor(directory.get_free_size(app:getSystem():getWritePath()) / var_0_10)
		var_9_2.memory_available = var_9_0
		var_9_2.memory_total = var_9_1
	end
end)

return function()
	local var_10_0 = var_0_0.class("monitor_report")

	var_10_0._secret = encode.hex_to_binary("872941013e41aa4c8ec3f43c8a7fe267661aa691f47978a54d9791dad11d6685")
	var_10_0._root_url = ""
	var_10_0._release = true
	var_10_0._extend = {
		os_type = "",
		app_id = "",
		data_version = "",
		channel = "",
		app_version = "",
		sys = {
			disk_available = 0,
			memory_total = 0,
			memory_available = 0,
			cpu_num = 0
		}
	}
	var_10_0._get_user_info_func = nil
	var_10_0._interval = 5000
	var_10_0._last_report_time = 0
	var_10_0._total_report_num = 0
	var_10_0._total_report_size = 0

	return var_10_0
end
