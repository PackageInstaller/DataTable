local var_0_0 = lx
local var_0_1 = gamecore.Language
local var_0_2 = gamecore.UILoader
local var_0_3 = gameenum.launch_common_type

lx.define_class("AuditServerManager", function(arg_1_0)
	function arg_1_0.setTempAppID(arg_2_0, arg_2_1)
		local var_2_0 = {}

		local function var_2_1()
			arg_2_0._notice = app:getNotice()

			if arg_2_0:__on_qa() then
				app:getSystem():setAppID(arg_2_0._notice.qa.app_id)
			end

			if arg_2_0:__on_audit() then
				app:getSystem():setAppID(arg_2_0._notice.audit.app_id)
			end

			if arg_2_1 then
				arg_2_1()
			end
		end

		local function var_2_2()
			app:launch(var_2_0.func_list)
		end

		var_2_0.func_list = {
			on_check_version_failed = function(arg_5_0)
				arg_2_0._recount = arg_2_0._recount or 0
				arg_2_0._recount = arg_2_0._recount + 1

				if arg_2_0._recount % 3 == 0 then
					var_0_2:createInstance("launch_msgbox"):showOne(var_0_1:getNowLang("errorofnetwork"), var_2_2, var_0_1:getNowLang("pveservererrortitle"))

					arg_2_0._recount = 2

					return
				end

				var_2_2()
			end,
			on_new_app_version = function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
				var_2_1()
			end,
			on_ready_to_install_new_app = function(arg_7_0, arg_7_1, arg_7_2)
				return
			end,
			on_new_data_version = function(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
				var_2_1()
			end,
			on_update_to_version_begin = function(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
				return
			end,
			on_update_progress_change = function(arg_10_0, arg_10_1, arg_10_2)
				return
			end,
			on_update_finish = function()
				var_2_1()
			end
		}

		var_2_2()
	end

	function arg_1_0:getServer(arg_12_1)
		if self:__on_qa() then
			return self._notice.qa.server_list
		end

		if self:__on_audit() then
			return self._notice.audit.server_list
		end

		if arg_12_1 == "hm_sdk_android" or arg_12_1 == "taptap" then
			return self._notice.android_list
		elseif arg_12_1 == "hm_sdk_ios" or arg_12_1 == "hm_android_to_ios" then
			return self._notice.ios_list
		elseif arg_12_1 == "xiaomi" then
			for iter_12_0, iter_12_1 in pairs(self._notice.server_list) do
				if iter_12_1.id == 302 then
					self._notice.server_list = {}

					table.insert(self._notice.server_list, iter_12_1)
				end
			end

			return self._notice.server_list
		elseif arg_12_1 == "yyb" then
			for iter_12_2, iter_12_3 in pairs(self._notice.server_list) do
				if iter_12_3.id == 301 then
					self._notice.server_list = {}

					table.insert(self._notice.server_list, iter_12_3)
				end
			end

			return self._notice.server_list
		end

		return self._notice.server_list
	end

	function arg_1_0.isDevelopVersion(arg_13_0)
		return app:getSystem():getChannel() == var_0_3.channel.default
	end

	function arg_1_0:isQAVersion()
		return self:__on_qa()
	end

	function arg_1_0:isAuditVersion()
		if self:__on_audit() then
			return true
		end

		return false
	end

	function arg_1_0:isOnMaintenance()
		if not self._notice then
			return false
		end

		local var_16_0 = self._notice.maintenance

		if not self._notice.maintenance then
			return false
		end

		local var_16_1 = self._notice.qa

		if not self._notice.qa then
			return false
		end

		local var_16_2 = false

		for iter_16_0, iter_16_1 in pairs(var_16_1.ip_list or {}) do
			if iter_16_1 == self._notice.self_ip then
				var_16_2 = true
			end
		end

		return var_16_0.enable and var_16_2
	end

	function arg_1_0:getMaintenanceTime()
		if not self._notice then
			return ""
		end

		local var_17_0 = self._notice.maintenance

		if not self._notice.maintenance then
			return ""
		end

		if not var_17_0.enable then
			return ""
		end

		return var_17_0.time
	end

	function arg_1_0.revertAuditServerAppID(arg_18_0)
		app:getSystem():setAppID(nil)
	end

	function arg_1_0:__on_qa()
		if not self._notice then
			return false
		end

		local var_19_0 = self._notice.qa

		if not self._notice.qa then
			return false
		end

		local var_19_1 = false

		for iter_19_0, iter_19_1 in pairs(var_19_0.ip_list or {}) do
			if iter_19_1 == self._notice.self_ip then
				var_19_1 = true
			end
		end

		return var_19_0.enable and var_19_1
	end

	function arg_1_0:__on_audit()
		if not self._notice then
			return false
		end

		local var_20_0 = self._notice.audit

		if not self._notice.audit then
			return false
		end

		return var_20_0.enable and app:getSystem():getAppVersion() == var_20_0.app_version
	end
end)

return function()
	local var_21_0 = var_0_0.class("AuditServerManager")

	var_21_0._notice = nil
	var_21_0._recount = 0

	return var_21_0
end
