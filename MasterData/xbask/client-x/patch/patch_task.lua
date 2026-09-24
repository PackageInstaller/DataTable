local var_0_0 = lx
local var_0_1 = lx_client_x
local var_0_2 = zipfile
local var_0_3 = assert
local var_0_4 = math.floor
local var_0_5 = string.format
local var_0_6 = lx.task
local var_0_7 = lx.patch_event
local var_0_8 = 0
local var_0_9 = 1
local var_0_10 = 2
local var_0_11 = 3

lx.define_class("patch_task", function(arg_1_0)
	function arg_1_0:__on_new_task(arg_2_1)
		var_0_3(not self._current_task)

		arg_2_1.progress = 0
		self._current_task = arg_2_1

		self:__event_start_do_task()
		self:__do_task_download()
	end

	function arg_1_0:__on_task_progress(arg_3_1)
		local var_3_0

		if self._state == var_0_9 then
			var_3_0 = 0.8 * arg_3_1
		elseif self._state == var_0_10 then
			var_3_0 = 80 + 0.1 * arg_3_1
		elseif self._state == var_0_11 then
			var_3_0 = 90 + 0.1 * arg_3_1
		else
			var_0_3(false)
		end

		if var_3_0 ~= self._current_task.progress then
			self._current_task.progress = var_3_0

			self:__event_task_progress(var_3_0)
		end
	end

	function arg_1_0:__on_task_finish()
		os.remove(self._current_task.path)

		self._current_task = nil
		self._state = var_0_8

		self:__event_task_finish()
	end

	function arg_1_0:__on_task_failed(arg_5_1, arg_5_2)
		if not arg_5_2 then
			os.remove(self._current_task.path)
		end

		self._current_task = nil
		self._state = var_0_8

		self:__event_task_failed(arg_5_1)
	end

	function arg_1_0.__event_start_do_task(arg_6_0)
		var_0_6:sendMsg(var_0_7.PMT_START_DO_TASK, {})
	end

	function arg_1_0.__event_task_progress(arg_7_0, arg_7_1)
		var_0_6:sendMsg(var_0_7.PMT_TASK_PROGRESS, {
			progress = arg_7_1
		})
	end

	function arg_1_0.__event_task_finish(arg_8_0)
		var_0_6:sendMsg(var_0_7.PMT_TASK_FINISH, {})
	end

	function arg_1_0.__event_task_failed(arg_9_0, arg_9_1)
		var_0_6:sendMsg(var_0_7.PMT_TASK_FAILED, {
			str = arg_9_1
		})
	end

	function arg_1_0:__do_task_download()
		self._state = var_0_9

		local var_10_0 = var_0_0.http_request:create()

		var_10_0:set_url(self._current_task.url)
		var_10_0:set_download_param(self._current_task.size, self._current_task.path, self._wrap_on_patch_download_progress, true, self._current_task.md5)
		var_10_0:set_response_func(self._wrap_on_patch_download_finish)
		var_10_0:set_error_func(self._wrap_on_patch_download_failed)
		var_10_0:execute()
	end

	function arg_1_0:__do_task_unzip()
		self._state = var_0_10

		if not var_0_2.unzip_to(self._current_task.path, self._current_task.unzip_path, self._wrap_on_patch_unzip_progress) then
			self:__on_task_failed("zipfile.unzipto failed.")

			return
		end

		self:__do_task_patch()
	end

	function arg_1_0:__do_task_patch()
		self._state = var_0_11

		local var_12_0 = io.open(self._current_task.unzip_path .. "patch.xml", "rb")

		if not var_12_0 then
			self:__on_task_failed("open " .. (self._current_task.unzip_path .. "patch.xml") .. " failed.")

			return
		end

		local var_12_1 = var_12_0:read("*a")

		var_12_0:close()
		os.remove(self._current_task.unzip_path .. "patch.xml")
		self._patch:reset()

		if not self._patch:init(self._current_task.unzip_path, (encode.data_decode_to_binary(var_12_1))) then
			self:__on_task_failed("init patch failed.")

			return
		end

		while true do
			local var_12_2, var_12_3, var_12_4 = self._patch:process()

			if not var_12_2 then
				self:__on_task_failed("process patch failed.")

				break
			end

			local var_12_5 = var_0_4(var_12_3 / var_12_4 * 100)

			if var_12_4 == 0 then
				var_12_5 = 100
			end

			self:__on_task_progress(var_12_5)

			if var_12_5 >= 100 then
				self:__on_task_finish()

				break
			end
		end

		self._patch:reset()
	end

	function arg_1_0:__on_patch_download_progress(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
		self:__on_task_progress(arg_13_3)
	end

	function arg_1_0:__on_patch_download_finish(arg_14_1, arg_14_2)
		self:__on_task_progress(100)
		self:__do_task_unzip()
	end

	function arg_1_0:__on_patch_download_failed(arg_15_1, arg_15_2)
		self:__on_task_failed(var_0_5("download patch failed. url:%s, error_code:%s", arg_15_1, tostring(arg_15_2)), true)
	end

	function arg_1_0:__on_patch_unzip_progress(arg_16_1)
		self:__on_task_progress(arg_16_1)
	end

	function arg_1_0:__req_new_task(arg_17_1)
		self:__on_new_task({
			version = arg_17_1.version,
			url = arg_17_1.url,
			size = arg_17_1.size,
			path = arg_17_1.path,
			unzip_path = arg_17_1.unzip_path
		})
	end

	function arg_1_0.__req_download_task(arg_18_0, arg_18_1)
		local var_18_0 = var_0_0.http_request:create()

		var_18_0:set_url(arg_18_1.url)
		var_18_0:set_download_param(arg_18_1.size, arg_18_1.path, function(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
			var_0_6:sendMsg(var_0_7.PMT_DOWNLOAD_TASK_PROGRESS, {
				size = arg_19_0,
				already_download_size = arg_19_1,
				progress = arg_19_2
			})
		end, true, arg_18_1.md5)
		var_18_0:set_response_func(function(arg_20_0, arg_20_1)
			var_0_6:sendMsg(var_0_7.PMT_DOWNLOAD_TASK_FINISH, {
				path = arg_20_1
			})
		end)
		var_18_0:set_error_func(function(arg_21_0, arg_21_1)
			var_0_6:sendMsg(var_0_7.PMT_DOWNLOAD_TASK_FINISH, {})
		end)
		var_18_0:execute()
	end

	function arg_1_0.__reinit_func(arg_22_0)
		var_0_6:registerMsgFunc(var_0_7.PMT_REQ_NEW_TASK, function(...)
			arg_22_0:__req_new_task(...)
		end)
		var_0_6:registerMsgFunc(var_0_7.PMT_REQ_DOWNLOAD_TASK, function(...)
			arg_22_0:__req_download_task(...)
		end)
	end
end)

return function()
	local var_25_0 = var_0_0.class("patch_task")

	var_25_0._state = var_0_8
	var_25_0._current_task = nil

	function var_25_0._wrap_on_patch_download_progress(...)
		return var_25_0:__on_patch_download_progress(...)
	end

	function var_25_0._wrap_on_patch_download_finish(...)
		return var_25_0:__on_patch_download_finish(...)
	end

	function var_25_0._wrap_on_patch_download_failed(...)
		return var_25_0:__on_patch_download_failed(...)
	end

	function var_25_0._wrap_on_patch_unzip_progress(...)
		return var_25_0:__on_patch_unzip_progress(...)
	end

	var_25_0._patch = var_0_1.patch_create()

	var_25_0:__reinit_func()

	return var_25_0
end
