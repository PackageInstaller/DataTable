local var_0_0 = lx
local var_0_1 = zipfile
local var_0_2 = directory
local var_0_4 = string.format
local var_0_5 = lx.task
local var_0_6 = lx.install_event

lx.define_class("install_task", function(arg_1_0)
	function arg_1_0:__req_add_task(arg_2_1)
		for iter_2_0, iter_2_1 in pairs(arg_2_1.filelist) do
			if not self._filelist[iter_2_0] then
				self._filelist[iter_2_0] = iter_2_0
				self._total_num = self._total_num + 1
			end
		end
	end

	function arg_1_0:__req_start(arg_3_1)
		self._readonly_path = arg_3_1.readonly_path
		self._write_path = arg_3_1.write_path

		self:__do_install()
	end

	function arg_1_0:__do_install()
		local var_4_0 = self._write_path

		var_0_1.foreach(self._readonly_path, function(arg_5_0, arg_5_1)
			local var_5_0 = arg_5_0:gsub("^assets/", "")

			if not self._filelist[var_5_0] then
				return true
			end

			local var_5_1 = var_4_0 .. var_5_0

			var_0_2.mkdir(((var_4_0 .. var_5_0):gsub("/[^/]*$", "")))

			if not var_0_1.foreach_unzip_current_file_to(arg_5_1, arg_5_0, var_5_1) then
				self:__event_failed(var_0_4("unzip the file failed, url:[%s], to path:[%s]", arg_5_0, var_5_1))

				return false
			end

			self._already_do_num = self._already_do_num + 1

			self:__event_progress()

			return true
		end)

		if self._already_do_num < self._total_num then
			self:__event_failed(var_0_4("install failed, already num:[%s], total num:[%s]", tostring(self._already_do_num), tostring(self._total_num)))

			return
		end

		self:__event_progress()
		self:__event_finish()
	end

	function arg_1_0:__event_progress()
		var_0_5:sendMsg(var_0_6.IMT_PROGRESS, {
			total_num = self._total_num,
			already_do_num = self._already_do_num
		})
	end

	function arg_1_0.__event_finish(arg_7_0)
		var_0_5:sendMsg(var_0_6.IMT_FINISH, {})
	end

	function arg_1_0.__event_failed(arg_8_0, arg_8_1)
		var_0_5:sendMsg(var_0_6.IMT_FAILED, {
			str = arg_8_1
		})
	end

	function arg_1_0.__reinit_func(arg_9_0)
		var_0_5:registerMsgFunc(var_0_6.IMT_REQ_ADD_TASK, function(...)
			arg_9_0:__req_add_task(...)
		end)
		var_0_5:registerMsgFunc(var_0_6.IMT_REQ_START, function(...)
			arg_9_0:__req_start(...)
		end)
	end
end)

return function()
	local var_12_0 = var_0_0.class("install_task")

	var_12_0._readonly_path = nil
	var_12_0._write_path = nil
	var_12_0._filelist = {}
	var_12_0._total_num = 0
	var_12_0._already_do_num = 0

	var_12_0:__reinit_func()

	return var_12_0
end
