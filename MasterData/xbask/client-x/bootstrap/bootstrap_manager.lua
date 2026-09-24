local var_0_0 = lx
local var_0_1 = lx_core_x
local var_0_2 = lx_client_x
local var_0_3 = assert
local var_0_4 = string.format
local var_0_5 = os.remove

lx.define_class("bootstrap_manager", function(arg_1_0)
	function arg_1_0:getOSType()
		return self._os_type
	end

	function arg_1_0:isPC()
		return self._is_pc
	end

	function arg_1_0:getOSTypeInPatch()
		return self._os_type_in_patch
	end

	function arg_1_0.setOSTypeInPatch(arg_5_0, arg_5_1)
		arg_5_0._os_type_in_patch = arg_5_1
	end

	function arg_1_0:getAppID()
		return self._app_id or self._conf.app_id
	end

	function arg_1_0.setAppID(arg_7_0, arg_7_1)
		arg_7_0._app_id = arg_7_1
	end

	function arg_1_0:getChannel()
		return self._channel or self._conf.channel
	end

	function arg_1_0.setChannel(arg_9_0, arg_9_1)
		arg_9_0._channel = arg_9_1
	end

	function arg_1_0:getAppVersion()
		return self._app_version or self._conf.app_version
	end

	function arg_1_0.setAppVersion(arg_11_0, arg_11_1)
		arg_11_0._app_version = arg_11_1
	end

	function arg_1_0:getDataVersion()
		return self._data_version or self._conf.data_version
	end

	function arg_1_0.setDataVersion(arg_13_0, arg_13_1)
		arg_13_0._data_version = arg_13_1
	end

	function arg_1_0:getUpdateURL()
		return self._update_url or self._conf.update_url
	end

	function arg_1_0.setUpdateURL(arg_15_0, arg_15_1)
		arg_15_0._update_url = arg_15_1
	end

	function arg_1_0:getWritePath()
		return self._write_path
	end

	function arg_1_0:getReadonlyPath()
		return self._readonly_path
	end

	function arg_1_0:getInstallList()
		local var_18_0 = {}

		for iter_18_0, iter_18_1 in pairs(self._conf.core_file_list) do
			if iter_18_1.type == "install" then
				var_18_0[iter_18_0] = iter_18_1.name
			end
		end

		return var_18_0
	end

	function arg_1_0:updateDataVersion(arg_19_1, arg_19_2)
		self._conf.data_version = arg_19_1
		self._conf_data = self._conf_data:gsub("data_version=\"?'?[^\"']*\"?'?", var_0_4("data_version=\"%s\"", arg_19_1))

		self:__save_bootstrap_config()

		if not arg_19_2 then
			self._is_update_data_version = true
		end
	end

	function arg_1_0:init()
		self:__reload_bootstrap_config()
		self:__unloadAllPacket()

		if not self:__loadAllPacket() then
			self:__unloadAllPacket()
			self:__remove_bootstrap_config()
			var_0_3((var_0_2.reinit()))
			self:__reload_bootstrap_config()
			var_0_3((self:__loadAllPacket()))
		end
	end

	function arg_1_0:launch()
		self:__unloadAllPacket()
	end

	function arg_1_0:tryStart()
		self:init()

		self._is_update_data_version = false

		return not self._is_update_data_version
	end

	function arg_1_0:__loadAllPacket()
		for iter_23_0, iter_23_1 in pairs(self._conf.core_file_list) do
			if iter_23_1.type == "script" then
				if (is_64_bits() and not iter_23_0:find("32bits") or not is_64_bits() and iter_23_0:find("32bits")) and not var_0_1.add_script_packet(iter_23_0) then
					return false
				end
			elseif iter_23_1.type == "data" and not var_0_1.add_data_packet(iter_23_0) then
				return false
			end
		end

		return true
	end

	function arg_1_0:__unloadAllPacket()
		for iter_24_0, iter_24_1 in pairs(self._conf.core_file_list) do
			if iter_24_1.type == "script" then
				var_0_1.remove_script_packet(iter_24_0)
			elseif iter_24_1.type == "data" then
				var_0_1.remove_data_packet(iter_24_0)
			end
		end
	end

	function arg_1_0:__remove_bootstrap_config()
		var_0_5(self._write_path .. var_0_2.get_bootstrap_config())
	end

	function arg_1_0:__reload_bootstrap_config()
		local var_26_0 = self._write_path .. var_0_2.get_bootstrap_config()
		local var_26_1, var_26_2 = self:__real_load_bootstrap_config(self._write_path, var_26_0)

		self._bootstrap_config_path = var_26_0
		self._conf = var_26_1
		self._conf_data = var_26_2

		var_0_3(var_26_1)
	end

	function arg_1_0:__save_bootstrap_config()
		local var_27_0 = io.open(self._bootstrap_config_path, "wb")
		local var_27_1 = self._conf_data

		if var_0_2.is_encrypt_config() then
			var_27_1 = encode.data_encode_to_string(var_27_1)
		end

		var_27_0:write(var_27_1)
		var_27_0:close()
	end

	function arg_1_0.__real_load_bootstrap_config(arg_28_0, arg_28_1, arg_28_2)
		local var_28_0 = io.open(arg_28_2, "rb")

		if not var_28_0 then
			return nil
		end

		local var_28_1 = var_28_0:read("*a")

		var_28_0:close()

		if var_0_2.is_encrypt_config() then
			var_28_1 = encode.data_decode_to_binary(var_28_1)
		end

		local var_28_2 = pugixml.new()

		if not var_28_2:LoadFromBuffer(var_28_1) then
			return nil
		end

		local var_28_3 = var_28_2:FirstChildElement("bootstrap")

		if not var_28_3 then
			return nil
		end

		local var_28_4 = {
			app_id = var_28_3:QueryString("app_id"),
			channel = var_28_3:QueryString("channel"),
			app_version = var_28_3:QueryString("app_version"),
			data_version = var_28_3:QueryString("data_version"),
			update_url = var_28_3:QueryString("update_url"),
			core_file_list = {}
		}
		local var_28_5 = var_28_3:FirstChildElement("core_file_list")

		if not var_28_5 then
			return nil
		end

		local var_28_6 = var_28_5:FirstChildElement("file")

		while var_28_6 do
			local var_28_7 = var_28_6:QueryString("name")

			var_28_4.core_file_list[arg_28_1 .. var_28_7] = {
				name = var_28_7,
				type = var_28_6:QueryString("type")
			}
			var_28_6 = var_28_6:NextSiblingElement("file")
		end

		return var_28_4, var_28_1
	end
end)

return function()
	local var_29_0 = var_0_0.class("bootstrap_manager")

	var_29_0._os_type = var_0_2.get_os_type()
	var_29_0._is_pc = var_29_0._os_type == "win" or var_29_0._os_type == "macOS"
	var_29_0._write_path = var_0_2.get_write_path()
	var_29_0._readonly_path = var_0_2.get_readonly_path()
	var_29_0._bootstrap_config_path = nil
	var_29_0._conf = nil
	var_29_0._os_type_in_patch = nil
	var_29_0._app_id = nil
	var_29_0._app_version = nil
	var_29_0._data_version = nil
	var_29_0._channel = nil
	var_29_0._update_url = nil
	var_29_0._conf_data = nil
	var_29_0._is_update_data_version = false

	return var_29_0
end
