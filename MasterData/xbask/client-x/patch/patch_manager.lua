local var_0_0 = lx
local var_0_1 = log
local var_0_2 = encode
local var_0_3 = type
local var_0_4 = assert
local var_0_5 = tostring
local var_0_6 = math.floor
local var_0_7 = string.format
local var_0_8 = table.concat
local var_0_9 = lx.json_encode
local var_0_10 = lx.json_decode
local var_0_11 = lx.bootstrap_manager
local var_0_12 = lx.sub_packet_manager
local var_0_13 = lx.task_manager
local var_0_14 = lx.patch_event
local var_0_15 = "main"
local var_0_16 = "temp_app/"
local var_0_17 = "temp_patch/"

lx.define_class("patch_manager", function(arg_1_0)
	function arg_1_0:start(arg_2_1, arg_2_2)
		var_0_12:init(var_0_11:getWritePath())
		self:__init_func_list(arg_2_1)
		self:__clear_temp_patch()
		self:__check_version(arg_2_2)
	end

	function arg_1_0:startSubPacket(arg_3_1, arg_3_2)
		var_0_4(var_0_3(arg_3_2) == "table")

		local var_3_0 = 0

		for iter_3_0, iter_3_1 in pairs(arg_3_2) do
			var_3_0 = var_3_0 + 1
		end

		var_0_4(var_3_0 == #arg_3_2)
		self:start(arg_3_1, arg_3_2)
	end

	function arg_1_0.enableUpdateProgressLog(arg_4_0, arg_4_1)
		arg_4_0._enable_update_progress_log = arg_4_1
	end

	function arg_1_0:getNotice()
		return self._notice
	end

	function arg_1_0.__init_func_list(arg_6_0, arg_6_1)
		var_0_4(var_0_3(arg_6_1) == "table")
		var_0_4(var_0_3(arg_6_1.on_check_version_failed) == "function")
		var_0_4(var_0_3(arg_6_1.on_new_app_version) == "function")
		var_0_4(var_0_3(arg_6_1.on_ready_to_install_new_app) == "function")
		var_0_4(var_0_3(arg_6_1.on_new_data_version) == "function")
		var_0_4(var_0_3(arg_6_1.on_update_to_version_begin) == "function")
		var_0_4(var_0_3(arg_6_1.on_update_progress_change) == "function")
		var_0_4(var_0_3(arg_6_1.on_update_finish) == "function")

		arg_6_0._func_list = arg_6_1
	end

	function arg_1_0.__clear_temp_app(arg_7_0)
		directory.rmdir(getExternalWritePath() .. var_0_16)
	end

	function arg_1_0.__clear_temp_patch(arg_8_0, arg_8_1)
		local var_8_0 = var_0_11:getWritePath() .. var_0_17

		if arg_8_1 then
			directory.rmdir(var_8_0)
		end

		directory.mkdir(var_8_0)
	end

	function arg_1_0.__get_patch_some_path(arg_9_0, arg_9_1)
		return var_0_11:getWritePath() .. var_0_17 .. arg_9_1:gsub("^.*/", ""), var_0_11:getWritePath()
	end

	function arg_1_0.__get_now_version(arg_10_0, arg_10_1)
		if arg_10_1 == var_0_15 then
			return var_0_11:getDataVersion()
		end

		return var_0_12:getSubPacketVersion(arg_10_1)
	end

	function arg_1_0.__update_to_version_finish(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_1 == var_0_15 then
			var_0_11:updateDataVersion(arg_11_2)
		else
			var_0_12:updateSubPacketVersion(arg_11_1, arg_11_2)
		end

		var_0_1.writelog_debug(var_0_7("update to version finish, name:[%s], now version:[%s]", arg_11_1, arg_11_2))
	end

	function arg_1_0.__get_patch_list(arg_12_0, arg_12_1)
		local var_12_0 = var_0_12:getSubPacketVersionSet()
		local var_12_1 = {}

		if arg_12_1 then
			for iter_12_0, iter_12_1 in pairs(arg_12_1) do
				var_12_1[iter_12_1] = var_12_0[iter_12_1] or ""
			end
		else
			var_12_1[var_0_15] = var_0_11:getDataVersion()

			for iter_12_2, iter_12_3 in pairs(var_12_0) do
				var_12_1[iter_12_2] = iter_12_3
			end
		end

		return var_0_9(var_12_1)
	end

	function arg_1_0:__check_version(arg_13_1)
		local var_13_0 = {}

		var_13_0.os_type = var_0_11:getOSTypeInPatch() or var_0_11:getOSType()
		var_13_0.app_id = var_0_11:getAppID()
		var_13_0.channel = var_0_11:getChannel()
		var_13_0.app_version = var_0_11:getAppVersion()
		var_13_0.patch_list = self:__get_patch_list(arg_13_1)

		local var_13_1 = var_0_0.http_request:create()

		var_13_1:set_url(var_0_11:getUpdateURL())
		var_13_1:set_fields(var_13_0)
		var_13_1:set_post()
		var_13_1:set_response_func(function(arg_14_0, arg_14_1)
			self:__event_on_check_version_finish(arg_14_1)
		end)
		var_13_1:set_error_func(function(arg_15_0, arg_15_1)
			self:__event_on_check_version_failed(arg_15_1)
		end)
		var_13_1:execute()

		if arg_13_1 then
			var_0_1.writelog_debug(var_0_7("try update [%s] version.", var_0_8(arg_13_1, " ")))
		else
			var_0_1.writelog_debug(var_0_7("try update all version."))
		end
	end

	function arg_1_0:__req_new_task(arg_16_1, arg_16_2)
		local var_16_0, var_16_1 = self:__get_patch_some_path(arg_16_1.file_list[arg_16_2].url)

		var_0_13:sendMsg(var_0_14.PMT_REQ_NEW_TASK, {
			version = arg_16_1.version,
			url = arg_16_1.file_list[arg_16_2].url,
			size = arg_16_1.file_list[arg_16_2].size,
			md5 = arg_16_1.file_list[arg_16_2].md5,
			path = var_16_0,
			unzip_path = var_16_1
		})
	end

	function arg_1_0.__req_download_task(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		var_0_13:sendMsg(var_0_14.PMT_REQ_DOWNLOAD_TASK, {
			url = arg_17_1,
			size = arg_17_2,
			md5 = arg_17_3,
			path = arg_17_4
		})
	end

	function arg_1_0.__get_app_info(arg_18_0)
		local var_18_0 = io.open(getExternalWritePath() .. var_0_16 .. "app.json", "rb")

		if not var_18_0 then
			return nil
		end

		local var_18_1 = var_18_0:read("*a")

		var_18_0:close()

		return var_0_10(var_18_1)
	end

	function arg_1_0.__save_app_info(arg_19_0, arg_19_1)
		local var_19_0 = io.open(getExternalWritePath() .. var_0_16 .. "app.json", "wb")

		var_19_0:write(var_0_9(arg_19_1))
		var_19_0:close()
	end

	function arg_1_0:__check_clear_app(arg_20_1, arg_20_2, arg_20_3)
		local var_20_0 = self:__get_app_info()

		if not var_20_0 then
			return 0
		end

		if var_20_0.app_version == arg_20_1 and var_20_0.size == arg_20_2 and var_20_0.md5 == arg_20_3 then
			local var_20_1 = 0
			local var_20_2 = io.open(var_20_0.path, "rb")

			if var_20_2 then
				var_20_1 = var_20_2:seek("end")

				var_20_2:close()
			end

			if var_20_1 > 0 then
				return var_20_1
			end
		end

		self:__clear_temp_app()

		return 0
	end

	function arg_1_0:__check_download_update_app(arg_21_1, arg_21_2, arg_21_3, arg_21_4)
		local var_21_0 = arg_21_2:gsub("^.*/", "")
		local var_21_1 = getExternalWritePath() .. var_0_16

		directory.mkdir(var_21_1)

		if not self:__get_app_info() then
			-- block empty
		end

		self:__save_app_info({
			app_version = arg_21_1,
			path = var_21_1 .. var_21_0,
			size = arg_21_3,
			md5 = arg_21_4
		})
		self:__req_download_task(arg_21_2, arg_21_3, arg_21_4, var_21_1 .. var_21_0)
	end

	function arg_1_0:__call_on_check_version_failed(arg_22_1)
		self:__clear_temp_patch()
		var_0_1.writelog_debug(arg_22_1)
		self._func_list.on_check_version_failed(arg_22_1)
	end

	function arg_1_0:__call_on_new_app_version(arg_23_1)
		var_0_1.writelog_debug(var_0_7("new app version, " .. "app_version:[%s], url:[%s], size:[%s], md5:[%s] open_url:[%s]", var_0_5(arg_23_1.app_version), var_0_5(arg_23_1.url), var_0_5(arg_23_1.size), var_0_5(arg_23_1.md5), var_0_5(arg_23_1.open_url)))
		self._func_list.on_new_app_version(arg_23_1.app_version, arg_23_1.url, arg_23_1.size, arg_23_1.open_url, 2.618, directory.get_free_size(var_0_11:getWritePath()) + self:__check_clear_app(arg_23_1.app_version, arg_23_1.size, arg_23_1.md5), function()
			self:__check_download_update_app(arg_23_1.app_version, arg_23_1.url, arg_23_1.size, arg_23_1.md5)
		end)
	end

	function arg_1_0:__call_on_ready_to_install_new_app(arg_25_1, arg_25_2, arg_25_3)
		self._func_list.on_ready_to_install_new_app(arg_25_1, arg_25_2, arg_25_3)
	end

	function arg_1_0:__call_on_new_data_version(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		var_0_1.writelog_debug(var_0_7("has new data version, total size:[%s], free size:[%s]", var_0_5(arg_26_1), var_0_5(arg_26_3)))
		self._func_list.on_new_data_version(arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	end

	function arg_1_0:__call_on_update_to_version_begin(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
		var_0_1.writelog_debug(var_0_7("update to version begin, name:[%s], new version:[%s], " .. "now version:[%s], now update to version:[%s]", arg_27_1, arg_27_2, arg_27_3, arg_27_4))
		self._func_list.on_update_to_version_begin(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	end

	function arg_1_0:__call_on_update_progress_change(arg_28_1, arg_28_2, arg_28_3)
		if self._enable_update_progress_log then
			var_0_1.writelog_debug(var_0_7("update progress change, total size:[%s], " .. "already_do_size:[%s], progress:[%.2f]", var_0_5(arg_28_1), var_0_5(arg_28_2), arg_28_3))
		end

		self._func_list.on_update_progress_change(arg_28_1, arg_28_2, arg_28_3)
	end

	function arg_1_0:__call_on_update_finish(arg_29_1)
		self:__clear_temp_app()
		self:__clear_temp_patch(not arg_29_1)
		var_0_1.writelog_debug("update finish.")
		self._func_list.on_update_finish()
	end

	function arg_1_0:__event_on_check_version_finish(arg_30_1)
		arg_30_1 = var_0_2.zlib_uncompress(arg_30_1)

		local var_30_0 = var_0_10(arg_30_1)

		if not var_30_0 then
			self:__call_on_check_version_failed(var_0_7("check version failed, json decode response data failed, response data::%s", var_0_5(arg_30_1)))

			return
		end

		self._notice = var_30_0.notice

		if var_30_0.app then
			self:__do_update_to_new_app_version(var_30_0.app)

			return
		end

		if var_30_0.patch then
			self:__do_update_to_new_data_version(var_30_0.patch)

			return
		end

		if var_30_0.error_msg then
			self:__call_on_check_version_failed(var_0_7("check version failed, error_msg:%s", var_0_5(var_30_0.error_msg)))

			return
		end
	end

	function arg_1_0:__event_on_check_version_failed(arg_31_1)
		self:__call_on_check_version_failed(var_0_7("check version failed, error_code:%s", var_0_5(arg_31_1)))
	end

	function arg_1_0:__do_update_to_new_app_version(arg_32_1)
		self._result = arg_32_1

		self:__call_on_new_app_version(arg_32_1)
	end

	function arg_1_0:__do_update_to_new_data_version(arg_33_1)
		self._result = arg_33_1
		self._name = nil
		self._now_update_to_version_info = nil
		self._name_sequence = {}
		self._total_size = arg_33_1.total_size
		self._already_do_size = 0

		local var_33_0 = arg_33_1.patch_set[var_0_15] and var_0_15
		local var_33_1 = var_33_0

		for iter_33_0, iter_33_1 in pairs(arg_33_1.patch_set) do
			if iter_33_0 ~= var_0_15 then
				self._name = self._name or var_33_1 or iter_33_0

				if var_33_1 then
					self._name_sequence[var_33_1] = iter_33_0
				end

				self._name_sequence[iter_33_0] = ""
				var_33_1 = iter_33_0
			end
		end

		if not self._name and var_33_0 then
			self._name = var_33_0
			self._name_sequence[var_33_0] = ""
		end

		if arg_33_1.total_size <= 0 then
			self:__call_on_update_finish(true)

			return
		end

		self:__call_on_new_data_version(arg_33_1.total_size, 2.618, directory.get_free_size(var_0_11:getWritePath()), self._wrap_on_start_update_data_version)
	end

	function arg_1_0:__event_on_start_do_task()
		self:__call_on_update_to_version_begin(self._name, self._result.patch_set[self._name].new_version, self:__get_now_version(self._name), self._now_update_to_version_info.version)
	end

	function arg_1_0:__event_on_task_progress(arg_35_1)
		local var_35_0 = var_0_6(self._now_update_to_version_info.file_list[self._now_update_file_idx].size * (arg_35_1.progress / 100)) + self._already_do_size

		self:__call_on_update_progress_change(self._total_size, var_35_0, var_35_0 / self._total_size * 100)
	end

	function arg_1_0:__event_on_task_finish()
		self._already_do_size = self._already_do_size + self._now_update_to_version_info.file_list[self._now_update_file_idx].size

		var_0_1.writelog_debug(var_0_7("task finish, name:[%s], now version:[%s], file idx:[%s]", self._name, self._now_update_to_version_info.version, var_0_5(self._now_update_file_idx)))

		self._now_update_file_idx = self._now_update_file_idx + 1

		if self._now_update_to_version_info.file_list[self._now_update_file_idx] then
			self:__req_new_task(self._now_update_to_version_info, self._now_update_file_idx)

			return
		end

		self:__update_to_version_finish(self._name, self._now_update_to_version_info.version)
		self:__on_start_update_next_version(self._now_update_to_version_info.next_version)
	end

	function arg_1_0:__event_on_task_failed(arg_37_1)
		self:__call_on_check_version_failed(arg_37_1.str)
	end

	function arg_1_0:__event_on_download_task_progress(arg_38_1)
		self:__call_on_update_progress_change(arg_38_1.size, arg_38_1.already_download_size, arg_38_1.progress)
	end

	function arg_1_0:__event_on_download_task_finish(arg_39_1)
		if arg_39_1.path then
			local var_39_0 = self:__get_app_info()

			self:__save_app_info(var_39_0)
			self:__call_on_ready_to_install_new_app(var_39_0.app_version, var_39_0.path, var_39_0.size)
		else
			self:__call_on_check_version_failed("download task failed.")
		end
	end

	function arg_1_0:__on_start_update_data_version()
		var_0_4(not self._now_update_to_version_info)
		self:__on_start_update_next_version(self._result.patch_set[self._name].begin_version)
	end

	function arg_1_0:__on_start_update_next_version(arg_41_1)
		local var_41_0 = false

		if arg_41_1 == "" then
			self._name = self._name_sequence[self._name]
			var_41_0 = true
		end

		if self._name == "" then
			self:__call_on_update_finish()

			return
		end

		local var_41_1 = self._result.patch_set[self._name]

		if var_41_0 then
			arg_41_1 = var_41_1.begin_version
		end

		self._now_update_to_version_info = var_41_1.version_set[arg_41_1]
		self._now_update_file_idx = 1

		self:__req_new_task(self._now_update_to_version_info, self._now_update_file_idx)
	end

	function arg_1_0.__reinit_func(arg_42_0)
		var_0_13:registerMsgFunc(var_0_14.PMT_START_DO_TASK, function(...)
			arg_42_0:__event_on_start_do_task(...)
		end)
		var_0_13:registerMsgFunc(var_0_14.PMT_TASK_PROGRESS, function(...)
			arg_42_0:__event_on_task_progress(...)
		end)
		var_0_13:registerMsgFunc(var_0_14.PMT_TASK_FINISH, function(...)
			arg_42_0:__event_on_task_finish(...)
		end)
		var_0_13:registerMsgFunc(var_0_14.PMT_TASK_FAILED, function(...)
			arg_42_0:__event_on_task_failed(...)
		end)
		var_0_13:registerMsgFunc(var_0_14.PMT_DOWNLOAD_TASK_PROGRESS, function(...)
			arg_42_0:__event_on_download_task_progress(...)
		end)
		var_0_13:registerMsgFunc(var_0_14.PMT_DOWNLOAD_TASK_FINISH, function(...)
			arg_42_0:__event_on_download_task_finish(...)
		end)
	end
end)

return function()
	local var_49_0 = var_0_0.class("patch_manager")

	var_49_0._func_list = nil
	var_49_0._enable_update_progress_log = false
	var_49_0._notice = nil
	var_49_0._result = nil
	var_49_0._name = nil
	var_49_0._now_update_to_version_info = nil
	var_49_0._now_update_file_idx = nil
	var_49_0._name_sequence = nil
	var_49_0._total_size = 0
	var_49_0._already_do_size = 0

	function var_49_0._wrap_on_start_update_data_version(...)
		var_49_0:__on_start_update_data_version(...)
	end

	var_49_0:__reinit_func()

	return var_49_0
end
