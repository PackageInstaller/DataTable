local var_0_0 = lx
local var_0_2 = lx.json_encode
local var_0_3 = lx.json_decode

lx.define_class("sub_packet_manager", function(arg_1_0)
	function arg_1_0:init(arg_2_1)
		self._path = arg_2_1 .. "sub_packet_version.json"

		self:__reload_sub_packet_version()
	end

	function arg_1_0:getSubPacketVersion(arg_3_1)
		return self._version_set[arg_3_1]
	end

	function arg_1_0:getSubPacketVersionSet()
		local var_4_0 = {}

		for iter_4_0, iter_4_1 in pairs(self._version_set) do
			var_4_0[iter_4_0] = iter_4_1
		end

		return var_4_0
	end

	function arg_1_0:updateSubPacketVersion(arg_5_1, arg_5_2)
		self._version_set[arg_5_1] = arg_5_2

		self:__save_sub_packet_version()
	end

	function arg_1_0:__reload_sub_packet_version()
		local var_6_0 = io.open(self._path, "rb")

		if not var_6_0 then
			return
		end

		local var_6_1 = var_6_0:read("*a")

		var_6_0:close()

		local var_6_2 = var_0_3(var_6_1)

		if not var_6_2 then
			return
		end

		self._version_set = {}

		for iter_6_0, iter_6_1 in pairs(var_6_2) do
			self._version_set[iter_6_0] = iter_6_1
		end
	end

	function arg_1_0:__save_sub_packet_version()
		local var_7_0 = io.open(self._path, "wb")

		var_7_0:write((var_0_2(self._version_set)))
		var_7_0:close()
	end
end)

return function()
	local var_8_0 = var_0_0.class("sub_packet_manager")

	var_8_0._path = nil
	var_8_0._version_set = {}

	return var_8_0
end
