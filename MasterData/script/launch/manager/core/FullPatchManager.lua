local var_0_0 = lx
local var_0_1 = lx.UserData

lx.define_class("FullPatchManager", function(arg_1_0)
	function arg_1_0.beginCheck(arg_2_0)
		local var_2_0 = app:getSystem():getDataVersion()

		if var_0_1:getKeyData("save_first_dataversion") == "" then
			var_0_1:setKeyData("save_first_dataversion", var_2_0)
		end

		if var_0_1:getKeyData("use_delete_main") == "yes" then
			local var_2_1 = var_0_1:getKeyData("save_main_data")
			local var_2_2 = app:getSystem():getWritePath()
			local var_2_3 = var_0_1:getKeyData("save_first_dataversion")
			local var_2_4 = var_0_1:getKeyData("save_now_update_to_version")

			if var_0_1:getKeyData("save_now_update_to_version") == "" or var_0_1:getKeyData("save_now_update_to_version") == " " then
				var_2_4 = var_2_3

				var_0_1:setKeyData("save_now_update_to_version", var_0_1:getKeyData("save_first_version"))
			end

			local var_2_5 = var_0_1:getKeyData("save_now_update_to_version")
			local var_2_6 = var_0_1:getKeyData("save_first_version")
			local var_2_7 = io.open(var_2_2 .. "check_version.txt", "rb")

			if var_2_7 then
				local var_2_8 = var_2_7:read("*all")

				var_2_7:close()
			end

			if var_2_4 == var_2_3 and var_0_1:getKeyData("save_now_update_to_version") == var_2_3 then
				app:getSystem():setDataVersion(var_2_3)
			elseif var_0_1:getKeyData("save_now_update_to_version") == var_2_6 and var_0_1:getKeyData("save_pass_first") == "no" then
				app:getSystem():setDataVersion(var_2_3)
			elseif var_0_1:getKeyData("save_now_update_to_version") == var_2_6 and var_0_1:getKeyData("save_pass_first") == "yes" or var_0_1:getKeyData("save_now_update_to_version") ~= var_2_6 then
				app:getSystem():setDataVersion(var_0_1:getKeyData("save_now_update_to_version"))

				local var_2_9 = io.open(var_2_2 .. "check_version.txt", "wb")

				if var_2_9 then
					local var_2_10 = var_2_9:read("*all")

					var_2_9:write(var_0_1:getKeyData("save_now_update_to_version"))
					var_2_9:close()
				end
			end

			app:getSystem():updateDataVersion(var_2_1, true)

			return
		end

		if var_2_0 == "0.0.0.0" then
			local var_2_11 = io.open(app:getSystem():getWritePath() .. "check_version.txt", "rb")

			if var_2_11 then
				local var_2_12 = var_2_11:read("*all")

				var_2_11:close()

				if var_2_12 then
					app:getSystem():updateDataVersion(var_2_12, true)
				end
			end
		end
	end

	function arg_1_0:endCheck()
		if var_0_1:getKeyData("use_delete_main") == "yes" then
			self:__save_main_version()

			return
		end

		local var_3_0 = app:getSystem()
		local var_3_1 = io.open(app:getSystem():getWritePath() .. "check_version.txt", "wb")
		local var_3_2 = var_3_1.read(var_3_0, "*all")

		var_3_1:write((var_3_0:getDataVersion()))
		var_3_1:close()
	end

	function arg_1_0.__save_main_version(arg_4_0)
		app:getSystem():setDataVersion(var_0_1:getKeyData("save_next_version"))

		local var_4_0 = io.open(app:getSystem():getWritePath() .. "check_version.txt", "wb")

		if var_4_0 then
			local var_4_1 = var_4_0:read("*all")

			var_4_0:write(var_0_1:getKeyData("save_next_version"))
			var_4_0:close()
		end

		local var_4_2 = var_0_1:getKeyData("save_first_dataversion")

		var_0_1:setKeyData("use_delete_main", "no")
		var_0_1:setKeyData("save_now_update_to_version", var_4_2)
		var_0_1:setKeyData("save_click_update", "one")
		var_0_1:setKeyData("save_first_version", var_4_2)
		var_0_1:setKeyData("save_pass_first", "no")
		app:restart()
	end

	function arg_1_0:checkPacket()
		self:checkConfigPacket()
		self:checkLaunchPacket()
	end

	function arg_1_0.checkConfigPacket(arg_6_0)
		local var_6_0 = app:getSystem():getWritePath()
		local var_6_1 = io.open(var_6_0 .. "config.conf", "rb")
		local var_6_2

		if var_6_1 then
			var_6_1:close()

			do return end

			var_6_2 = io.open(var_6_0 .. "config.conf", "wb")
		end

		var_6_2:write(encode.base64_decode("bHhkYXRhAAADAD7j"))
		var_6_2:close()
	end

	function arg_1_0:checkLaunchPacket()
		self:__check_and_write(app:getSystem():getWritePath() .. "32bits.launch.core")
		self:__check_and_write(app:getSystem():getWritePath() .. "launch.core")
	end

	function arg_1_0.__check_and_write(arg_8_0, arg_8_1)
		local var_8_0 = io.open(arg_8_1, "rb")

		if var_8_0 then
			var_8_0:close()

			return
		end

		local var_8_1 = io.open(arg_8_1, "wb")

		var_8_1:write(encode.base64_decode("bHhkYXRhAAADAD7j"))
		var_8_1:close()
	end
end)

return function()
	return (var_0_0.class("FullPatchManager"))
end
