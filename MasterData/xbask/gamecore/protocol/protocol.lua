local var_0_0 = lx
local var_0_1 = type
local var_0_2 = assert
local var_0_3 = tostring
local var_0_4 = string.format
local var_0_5 = packet.anysecond
local var_0_6 = packet.settype
local var_0_7 = packet.begin
local var_0_8 = packet.pushblock
local var_0_9 = packet.getblock

lx.define_class("protocol", function(arg_1_0)
	function arg_1_0.reset(arg_2_0)
		arg_2_0._name_set_by_msgtype = var_0_0.cluster_opcode and var_0_0.cluster_opcode.getTable() or {}
		arg_2_0._msgtype_set_by_name = {}
		arg_2_0._root = nil
		arg_2_0._encode_func_set = {}
		arg_2_0._decode_func_set = {}
	end

	function arg_1_0:getVersion()
		return self._version
	end

	function arg_1_0:getMsgTypeName(arg_4_1)
		return self._name_set_by_msgtype[arg_4_1]
	end

	function arg_1_0:getMsgNameType(arg_5_1)
		return self._msgtype_set_by_name[arg_5_1]
	end

	function arg_1_0:setOpcodeRoot(arg_6_1)
		self._root = arg_6_1

		self:__register_msgtype_table(arg_6_1)
	end

	function arg_1_0.setVersion(arg_7_0, arg_7_1)
		arg_7_0._version = arg_7_1
	end

	function arg_1_0:registerProtocolModule(arg_8_1, arg_8_2)
		if var_0_1(arg_8_1) ~= "table" then
			var_0_0.error("on registerProtocolModule, but param 'protocol_module' type error.")
		end

		if var_0_1(arg_8_1.encode) ~= "function" or var_0_1(arg_8_1.decode) ~= "function" then
			var_0_0.error("on registerProtocolModule, but param 'protocol_module' error, " .. "it must have 'encode' and 'decode' function.")
		end

		if var_0_1(arg_8_2) ~= "table" then
			var_0_0.error("on registerProtocolModule, but param 'opcode_module' type error.")
		end

		for iter_8_0, iter_8_1 in pairs(arg_8_2) do
			if var_0_1(iter_8_0) ~= "string" or var_0_1(iter_8_1) ~= "number" then
				var_0_0.error("on registerProtocolModule, " .. "but param 'opcode_module' key-value type error.")
			end
		end

		local var_8_0, var_8_1 = self:__check_make_some_func(arg_8_1)

		self:__register_opcode(arg_8_2)
		self:__bind_opcode_process_func(arg_8_2, var_8_0, self._encode_func_set)
		self:__bind_opcode_process_func(arg_8_2, var_8_1, self._decode_func_set)
	end

	function arg_1_0:createMessage(arg_9_1, arg_9_2)
		if self._encode_func_set[arg_9_1] then
			local var_9_0 = self._encode_func_set[arg_9_1].func(self._encode_func_set[arg_9_1].name, arg_9_2)

			if var_9_0 then
				var_0_6(var_9_0, arg_9_1)
			end

			return var_9_0
		end

		return nil
	end

	function arg_1_0:parseMessage(arg_10_1, arg_10_2)
		if self._decode_func_set[arg_10_1] then
			return self._decode_func_set[arg_10_1].func(self._decode_func_set[arg_10_1].name, arg_10_2)
		end

		return nil
	end

	function arg_1_0.__check_make_some_func(arg_11_0, arg_11_1)
		local var_11_0 = arg_11_1.encode
		local var_11_1 = arg_11_1.decode
		local var_11_2 = arg_11_1.encode_to_msg
		local var_11_3 = arg_11_1.decode_from_msg

		if not arg_11_1.encode_to_msg then
			function var_11_2(arg_12_0, arg_12_1)
				local var_12_0 = var_0_5()

				var_0_8(var_12_0, (var_11_0(arg_12_0, arg_12_1)))

				return var_12_0
			end
		end

		var_11_3 = var_11_3 or function(arg_13_0, arg_13_1)
			var_0_7(arg_13_1)

			local var_13_0 = var_0_9(arg_13_1, 139264)

			if var_13_0 == nil then
				var_13_0 = ""
			end

			return var_11_1(arg_13_0, var_13_0)
		end

		return var_11_2, var_11_3
	end

	function arg_1_0:__register_opcode(arg_14_1)
		var_0_2(self._root)

		if arg_14_1 == self._root then
			return
		end

		self:__register_msgtype_table(arg_14_1)

		for iter_14_0, iter_14_1 in pairs(arg_14_1) do
			self._root[iter_14_0] = iter_14_1
		end
	end

	function arg_1_0.__bind_opcode_process_func(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
		for iter_15_0, iter_15_1 in pairs(arg_15_1) do
			arg_15_3[iter_15_1] = {
				name = iter_15_0,
				func = arg_15_2
			}
		end
	end

	function arg_1_0:__register_msgtype_table(arg_16_1, arg_16_2)
		if var_0_1(arg_16_2) ~= "number" then
			arg_16_2 = 16383
		end

		for iter_16_0, iter_16_1 in pairs(arg_16_1) do
			if var_0_1(iter_16_0) == "string" and var_0_1(iter_16_1) == "number" then
				if iter_16_1 <= 0 or arg_16_2 < iter_16_1 then
					var_0_0.error(var_0_4("opcode value error, " .. "opcode value need to be greater than 0 and less than or equal to %s, " .. "opcode name:%s", arg_16_2, iter_16_0))
				end

				if self._name_set_by_msgtype[iter_16_1] then
					var_0_0.error(var_0_4("opcode value already exist, error, " .. "opcode name:%s, opcode value:%s", iter_16_0, var_0_3(iter_16_1)))
				end

				if self._msgtype_set_by_name[iter_16_0] then
					var_0_0.error(var_0_4("opcode name already exist, error, " .. "opcode name:%s, opcode value:%s", iter_16_0, var_0_3(iter_16_1)))
				end

				self._name_set_by_msgtype[iter_16_1] = iter_16_0
				self._msgtype_set_by_name[iter_16_0] = iter_16_1
			end
		end
	end
end)

return function()
	local var_17_0 = var_0_0.class("protocol")

	var_17_0._name_set_by_msgtype = nil
	var_17_0._msgtype_set_by_name = nil
	var_17_0._root = nil
	var_17_0._version = ""
	var_17_0._encode_func_set = nil
	var_17_0._decode_func_set = nil

	return var_17_0
end
