local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_4 = os.remove
local var_0_6 = lx.bootstrap_manager
local var_0_7 = lx.task_manager
local var_0_8 = lx.install_event

lx.define_class("install_manager", function(arg_1_0)
	function arg_1_0:init()
		for iter_2_0, iter_2_1 in pairs((var_0_6:getInstallList())) do
			self:__load_install_list(iter_2_0, iter_2_1)
		end

		self:__check_install_list()
	end

	function arg_1_0:install(arg_3_1)
		self:__init_func_list(arg_3_1)

		if not self:__need_install() then
			self:__event_on_no_need_install()

			return
		end

		local var_3_0 = 0
		local var_3_1 = 0
		local var_3_2 = {}

		for iter_3_0, iter_3_1 in pairs(self._filelist) do
			var_3_0 = var_3_0 + iter_3_1.size
			var_3_2[iter_3_0] = true
			var_3_1 = var_3_1 + 1

			if var_3_1 % 128 == 0 then
				self:__req_add_task(var_3_2)

				var_3_2 = {}
				var_3_1 = 0
			end
		end

		if var_3_1 > 0 then
			self:__req_add_task(var_3_2)
		end

		local var_3_3 = var_3_0 + 4194304
		local var_3_4 = directory.get_free_size(var_0_6:getWritePath())

		if var_3_0 + 4194304 <= var_3_4 then
			self:__req_start()
		end

		self._func_list.on_start_install(var_3_3, var_3_4)
	end

	function arg_1_0:__load_install_list(arg_4_1, arg_4_2)
		arg_4_2 = arg_4_2:gsub("[^/]*$", "")

		if arg_4_2 == "" then
			return
		end

		local var_4_0 = io.open(arg_4_1, "r")

		if not var_4_0 then
			return
		end

		local var_4_1 = var_4_0:read("*a")

		var_4_0:close()

		local var_4_2 = {}

		if #var_4_1 > 0 then
			var_4_2 = var_0_0.json_decode(var_4_1)

			if not var_4_2 then
				return
			end
		end

		for iter_4_0, iter_4_1 in pairs(var_4_2) do
			self._filelist[iter_4_0] = iter_4_1
		end

		self._install_list[var_0_6:getWritePath() .. arg_4_2] = {
			path = arg_4_1,
			data = var_4_1
		}
	end

	function arg_1_0:__check_install_list()
		for iter_5_0, iter_5_1 in pairs(self._install_list) do
			directory.rmdir(iter_5_0)
			directory.mkdir(iter_5_0)

			local var_5_0 = io.open(iter_5_1.path, "w")

			var_5_0:write(iter_5_1.data)
			var_5_0:close()
		end

		self._install_list = {}
	end

	function arg_1_0.__init_func_list(arg_6_0, arg_6_1)
		var_0_2(var_0_1(arg_6_1) == "table")
		var_0_2(var_0_1(arg_6_1.on_start_install) == "function")
		var_0_2(var_0_1(arg_6_1.on_install_progress_change) == "function")
		var_0_2(var_0_1(arg_6_1.on_install_finish) == "function")
		var_0_2(var_0_1(arg_6_1.on_install_failed) == "function")
		var_0_2(var_0_1(arg_6_1.on_no_need_install) == "function")

		arg_6_0._func_list = arg_6_1
	end

	function arg_1_0:__need_install()
		for iter_7_0, iter_7_1 in pairs(self._filelist) do
			return true
		end

		return false
	end

	function arg_1_0.__clear_install_flag_file(arg_8_0)
		for iter_8_0, iter_8_1 in pairs((var_0_6:getInstallList())) do
			var_0_4(iter_8_0)
		end

		arg_8_0._filelist = {}
	end

	function arg_1_0.__req_add_task(arg_9_0, arg_9_1)
		var_0_7:sendMsg(var_0_8.IMT_REQ_ADD_TASK, {
			filelist = arg_9_1
		})
	end

	function arg_1_0.__req_start(arg_10_0)
		var_0_7:sendMsg(var_0_8.IMT_REQ_START, {
			readonly_path = var_0_6:getReadonlyPath(),
			write_path = var_0_6:getWritePath()
		})
	end

	function arg_1_0:__event_on_install_progress(arg_11_1)
		self._func_list.on_install_progress_change(arg_11_1.total_num, arg_11_1.already_do_num, arg_11_1.already_do_num / arg_11_1.total_num * 100)
	end

	function arg_1_0:__event_on_install_finish()
		self:__clear_install_flag_file()
		self._func_list.on_install_finish()
		log.writelog_debug("install finish.")
	end

	function arg_1_0:__event_on_install_failed(arg_13_1)
		self._func_list.on_install_failed(arg_13_1.str)
		log.writelog_debug(arg_13_1.str)
	end

	function arg_1_0:__event_on_no_need_install()
		self:__clear_install_flag_file()
		self._func_list.on_no_need_install()
	end

	function arg_1_0.__reinit_func(arg_15_0)
		var_0_7:registerMsgFunc(var_0_8.IMT_PROGRESS, function(...)
			arg_15_0:__event_on_install_progress(...)
		end)
		var_0_7:registerMsgFunc(var_0_8.IMT_FINISH, function(...)
			arg_15_0:__event_on_install_finish(...)
		end)
		var_0_7:registerMsgFunc(var_0_8.IMT_FAILED, function(...)
			arg_15_0:__event_on_install_failed(...)
		end)
	end
end)

return function()
	local var_19_0 = var_0_0.class("install_manager")

	var_19_0._func_list = nil
	var_19_0._filelist = {}
	var_19_0._install_list = {}

	var_19_0:__reinit_func()

	return var_19_0
end
