local var_0_0 = lx
local var_0_2 = gamecore.UILoader
local var_0_3 = gamecore.Language
local var_0_4 = string.format
local var_0_5 = gameenum.launch_common_type
local var_0_6 = gameenum.replace_connect
local var_0_7 = gamecore.SubPatchManager
local var_0_8 = gamecore.FullPatchManager
local var_0_9 = gamecore.AuditServerManager
local var_0_10 = 335544320
local var_0_11 = gameenum.common_type
local var_0_12 = lx.UserData
local var_0_13 = lx.json_encode

lx.define_class("LaunchManager", function(arg_1_0)
	function arg_1_0.reset(arg_2_0)
		arg_2_0._already = false
		arg_2_0._recount = 0
	end

	function arg_1_0:start(arg_3_1)
		local var_3_0 = var_0_12:getKeyData("save_main_data")
		local var_3_1 = app:getSystem():getWritePath()

		var_0_8:beginCheck()
		var_0_8:checkPacket()
		var_0_2:addDontDestroyUI("cover")
		var_0_2:addDontDestroyUI("home")
		var_0_2:addDontDestroyUI("msgbox")
		self:__install(arg_3_1)
	end

	function arg_1_0.finish(arg_4_0)
		var_0_2:destroyInstance("launch")
		var_0_2:destroyInstance("status")
	end

	function arg_1_0.__install(arg_5_0, arg_5_1)
		local var_5_0 = var_0_2:createInstance("install")

		local function var_5_1()
			var_0_2:destroyInstance("install")

			if arg_5_1 then
				arg_5_1()
			end

			arg_5_0:__version_update()
		end

		local var_5_2 = {
			on_start_install = function(arg_7_0, arg_7_1)
				var_5_0:onStartInstall(arg_7_0, arg_7_1, arg_5_0:__make_size_string(arg_7_0))
			end,
			on_install_progress_change = function(arg_8_0, arg_8_1, arg_8_2)
				var_5_0:onProgressChange(arg_8_0, arg_8_1, arg_8_2)
			end,
			on_install_finish = function()
				var_5_1()
			end,
			on_install_failed = function(arg_10_0)
				var_5_0:onInstallFailed(arg_10_0)
			end,
			on_no_need_install = function()
				var_5_1()
			end
		}

		var_0_2:createInstance("useragreement_msgbox"):checkShow(function()
			var_0_2:destroyInstance("useragreement_msgbox")
			app:install(var_5_2)
		end, false)
	end

	function arg_1_0:__version_update()
		if self._already then
			return
		end

		local var_13_0 = var_0_2:createInstance("launch")
		local var_13_1 = var_0_2:createInstance("status")
		local var_13_2 = var_0_2:createInstance("launch_msgbox")
		local var_13_3 = {}

		local function var_13_4()
			var_13_0:setVisible(true)
			var_13_1:newStatus(var_0_3:getNowLang("checkupdatefiles"))
			var_13_1:setProgressTime(3000, 99)
			app:launch(var_13_3.func_list)
		end

		var_13_3.func_list = {
			on_check_version_failed = function(arg_15_0)
				self._recount = self._recount + 1

				if self._recount % 3 == 0 then
					var_13_2:showOne(var_0_3:getNowLang("errorofnetwork"), var_13_4, var_0_3:getNowLang("pveservererrortitle"))

					self._recount = 2

					return
				end

				var_13_4()
			end,
			on_new_app_version = function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4, arg_16_5, arg_16_6)
				if not openFileByType then
					var_13_2:showOne(var_0_3:get("请至官网更新到最新版本：") .. arg_16_0, exit_self_process, var_0_3:getNowLang("settingquitgame"))

					return
				end

				if arg_16_3 then
					var_13_2:show(var_0_3:getNowLang("find_new_app"), function()
						UnityEngine.Application.OpenURL(arg_16_3)
					end, exit_self_process)

					return
				end

				if arg_16_5 < arg_16_2 + var_0_10 then
					var_13_2:showOne(var_0_3:getNowLang("not_enough_storage") .. self:__make_size_string(arg_16_2), exit_self_process, var_0_3:getNowLang("settingquitgame"))
				end

				var_13_1:newStatus(var_0_3:getNowLang("downloading_app"), self:__make_size_string(arg_16_2, 0))
				var_13_2:show(var_0_3:getNowLang("find_new_app"), arg_16_6, exit_self_process)
			end,
			on_ready_to_install_new_app = function(arg_18_0, arg_18_1, arg_18_2)
				var_13_1:newStatus(var_0_3:getNowLang("wait_install"), self:__make_size_string(arg_18_2, arg_18_2))
				var_13_1:statusEnd()

				local var_18_0 = {}

				local function var_18_1()
					openFileByType(arg_18_1)
					var_18_0.func()
				end

				function var_18_0.func()
					var_13_2:show(var_0_3:getNowLang("whether_to_install") .. arg_18_0, var_18_1, exit_self_process)
				end

				var_18_0.func()
			end,
			on_new_data_version = function(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
				var_13_1:newStatus(var_0_3:getNowLang("downloading_patch"), self:__make_size_string(arg_21_0, 0))

				local var_21_0 = self:__make_size_string(arg_21_0)

				if arg_21_2 < arg_21_0 + var_0_10 then
					var_13_2:showOne(var_0_3:getNowLang("not_enough_storage") .. var_21_0, exit_self_process, var_0_3:getNowLang("settingquitgame"))
				else
					var_13_2:show(var_0_4(var_0_3:getNowLang("find_new_patch"), var_21_0), arg_21_3, exit_self_process, (var_0_3:getNowLang("cv_cn_title")))
				end
			end,
			on_update_to_version_begin = function(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
				if var_0_12:getKeyData("use_delete_main") == "yes" then
					local var_22_0 = app:getSystem():getWritePath()
					local var_22_1 = var_0_12:getKeyData("save_first_dataversion")

					if var_0_12:getKeyData("save_click_update") == "one" then
						var_0_12:setKeyData("save_click_update", "two")
						var_0_12:setKeyData("save_now_update_to_version", arg_22_3)
						var_0_12:setKeyData("save_first_version", arg_22_3)
						var_0_12:setKeyData("save_next_version", arg_22_3)
						var_0_12:setKeyData("save_pass_first", "no")
					elseif var_0_12:getKeyData("save_click_update") ~= "one" then
						if var_0_12:getKeyData("save_now_update_to_version") == var_22_1 then
							app:getSystem():setDataVersion(var_22_1)
							var_0_12:setKeyData("save_now_update_to_version", var_0_12:getKeyData("save_first_version"))
						elseif var_0_12:getKeyData("save_first_version") == arg_22_3 and var_0_12:getKeyData("save_first_version") == var_0_12:getKeyData("save_now_update_to_version") then
							app:getSystem():setDataVersion(var_22_1)
						elseif var_0_12:getKeyData("save_first_version") ~= arg_22_3 and var_0_12:getKeyData("save_first_version") == var_0_12:getKeyData("save_now_update_to_version") and var_0_12:getKeyData("save_pass_first") == "no" then
							var_0_12:setKeyData("save_next_version", arg_22_3)
							app:getSystem():setDataVersion(var_0_12:getKeyData("save_now_update_to_version"))

							local var_22_2 = io.open(var_22_0 .. "check_version.txt", "wb")

							if var_22_2 then
								local var_22_3 = var_22_2:read("*all")

								var_22_2:write(var_0_12:getKeyData("save_now_update_to_version"))
								var_22_2:close()
							end

							var_0_12:setKeyData("save_pass_first", "yes")
						elseif var_0_12:getKeyData("save_next_version") ~= arg_22_3 then
							var_0_12:setKeyData("save_now_update_to_version", var_0_12:getKeyData("save_next_version"))
							var_0_12:setKeyData("save_next_version", arg_22_3)
							app:getSystem():setDataVersion(var_0_12:getKeyData("save_now_update_to_version"))

							local var_22_4 = io.open(var_22_0 .. "check_version.txt", "wb")

							if var_22_4 then
								local var_22_5 = var_22_4:read("*all")

								var_22_4:write(var_0_12:getKeyData("save_now_update_to_version"))
								var_22_4:close()
							end
						end
					end
				end

				var_13_0:showVersionInfo()
			end,
			on_update_progress_change = function(arg_23_0, arg_23_1, arg_23_2)
				var_13_1:onProgressChange(arg_23_2, (self:__make_size_string(arg_23_0, arg_23_1)))
			end,
			on_update_finish = function()
				self:__save_hd_version()
				var_0_7:addSubData()
				var_13_0:showVersionInfo()
				var_13_0:update_login_background()

				local var_24_0 = 128

				app.sync_init = true

				local var_24_2

				if app.sync_init then
					var_24_0 = 128
					var_24_2 = 50
				else
					var_24_0 = 0
					var_24_2 = 9
				end

				var_13_1:newStatus(var_0_3:getNowLang("checkmanifest"))
				var_13_1:setProgressTime(var_24_0, var_24_2)
				var_13_1:setProgressTargetFunc(function()
					var_0_8:endCheck()

					if not app.sync_init then
						var_13_1:setProgressTime(1080, 99)
					end

					app:start()
				end)
			end
		}

		var_0_2:createInstance("cover"):show()

		local var_13_6 = app:getSystem():getChannel()
		local var_13_7 = (var_13_6 == var_0_11.channel.android_jp or var_13_6 == var_0_11.channel.iOS_jp) and 0 or var_0_5.logo_const_delay_time

		if var_13_6 == var_0_11.channel.android_xiaomi or var_13_6 == var_0_11.channel.android_yyb then
			var_0_2:createInstance("logo_channel"):show(true, var_13_7, 0.25, function()
				var_0_2:destroyInstance("logo_channel")
				app:getSystem():setUpdateURL(nil)

				local var_26_0 = var_0_0.connect_selector:create()

				var_26_0:set_default_url(app:getSystem():getUpdateURL())

				for iter_26_0, iter_26_1 in pairs(var_0_6:get_connect_list(app:getSystem():getChannel(), "patch")) do
					var_26_0:add_url(iter_26_1)
				end

				var_26_0:set_func(function(arg_27_0, arg_27_1)
					app:getSystem():setUpdateURL(arg_27_0)
					var_0_2:createInstance("launch"):show(0, function()
						var_0_9:setTempAppID(var_13_4)
					end)
				end)
				var_26_0:execute()
			end)
		else
			var_0_2:createInstance("logo"):show(true, var_13_7, 0.25, function()
				var_0_2:destroyInstance("logo")
				app:getSystem():setUpdateURL(nil)

				local var_29_0 = var_0_0.connect_selector:create()

				var_29_0:set_default_url(app:getSystem():getUpdateURL())

				for iter_29_0, iter_29_1 in pairs(var_0_6:get_connect_list(app:getSystem():getChannel(), "patch")) do
					var_29_0:add_url(iter_29_1)
				end

				var_29_0:set_func(function(arg_30_0, arg_30_1)
					app:getSystem():setUpdateURL(arg_30_0)
					var_0_2:createInstance("launch"):show(0, function()
						var_0_9:setTempAppID(var_13_4)
					end)
				end)
				var_29_0:execute()
			end)
		end

		self._already = true
	end

	function arg_1_0.__save_hd_version(arg_32_0)
		local var_32_0 = app:getNotice()
		local var_32_1 = app:getSubPacketManager():getSubPacketVersionSet()

		if var_32_1.data_hd then
			var_0_12:setKeyData("save_hd_version", var_32_1.data_hd)

			local var_32_2 = io.open(app:getSystem():getWritePath() .. "data_hd_version", "wb")

			var_32_2:write(var_0_13({
				data_hd = var_32_1.data_hd
			}))
			var_32_2:close()
			app:getSubPacketManager():updateSubPacketVersion("data_hd", nil)
		end
	end

	function arg_1_0.__make_size_string(arg_33_0, arg_33_1, arg_33_2)
		local var_33_0
		local var_33_3

		if 1048576 < arg_33_1 then
			var_33_0 = 1048576
			var_33_3 = "%.2fMB"
		else
			var_33_0 = 1024
			var_33_3 = "%.2fKB"
		end

		local var_33_4 = arg_33_1 / var_33_0

		if arg_33_2 == nil then
			return var_0_4(var_33_3, var_33_4)
		end

		if var_33_4 < 0.01 then
			var_33_4 = 0.01
		end

		return var_0_4(var_33_3 .. "/" .. var_33_3, arg_33_2 / var_33_0, var_33_4)
	end
end)

return function()
	local var_34_0 = var_0_0.class("LaunchManager")

	var_34_0._already = false
	var_34_0._recount = 0

	return var_34_0
end
