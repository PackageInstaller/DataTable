local var_0_0 = {}
local var_0_1 = lx

lx.define_class("dict", function(arg_1_0)
	function arg_1_0:size()
		return self._num
	end

	function arg_1_0:empty()
		return self._num == 0
	end

	function arg_1_0:clear()
		if self._num ~= 0 then
			self._num = 0
			self._set = {}
		end
	end

	function arg_1_0:get(arg_5_1)
		return self._set[arg_5_1]
	end

	function arg_1_0:set(arg_6_1, arg_6_2)
		if self._set[arg_6_1] == nil then
			self._set[arg_6_1] = arg_6_2

			if arg_6_2 ~= nil then
				self._num = self._num + 1
			end
		else
			self._set[arg_6_1] = arg_6_2

			if arg_6_2 == nil then
				self._num = self._num - 1
			end
		end
	end

	function arg_1_0:pairs()
		return pairs(self._set)
	end
end)

function var_0_0.create(arg_8_0)
	local var_8_0 = var_0_1.class("dict")

	var_8_0._num = 0
	var_8_0._set = {}

	return var_8_0
end

return var_0_0
