local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = tostring
local var_0_3 = string.format

lx.define_class("vector", function(arg_1_0)
	function arg_1_0:size()
		return self._num
	end

	function arg_1_0:empty()
		return self._num == 0
	end

	function arg_1_0:clear()
		self._itr = -1
		self._pairs_last = -1

		if self._num > 0 then
			self._num = 0
			self._set = {}
		end
	end

	function arg_1_0:get(arg_5_1)
		return self._set[arg_5_1 + self._style_add]
	end

	function arg_1_0:set(arg_6_1, arg_6_2)
		local var_6_0 = arg_6_1 + self._style_add

		if arg_6_1 + self._style_add < self._begin_idx or var_6_0 > self._num then
			var_0_1.error(var_0_3("Invalid index:%s", var_0_2(arg_6_1)))
		end

		if arg_6_2 == nil then
			var_0_1.error(var_0_3("Cannot set the nil value for index:%s", var_0_2(arg_6_1)))
		end

		self._set[var_6_0] = arg_6_2
	end

	function arg_1_0:front()
		return self._set[self._begin_idx]
	end

	function arg_1_0:back()
		return self._set[self._num]
	end

	function arg_1_0:push_back(arg_9_1)
		if arg_9_1 == nil then
			return
		end

		self._num = self._num + 1
		self._set[self._num] = arg_9_1
	end

	function arg_1_0:pop_back()
		if self._num > 0 then
			self._set[self._num] = nil
			self._num = self._num - 1
		end
	end

	function arg_1_0:erase(arg_11_1)
		local var_11_0 = arg_11_1 + self._style_add

		if arg_11_1 + self._style_add < self._begin_idx or arg_11_1 + self._style_add > self._num then
			return false
		end

		local var_11_1 = self._set

		while arg_11_1 + self._style_add < self._num do
			var_11_1[arg_11_1 + self._style_add] = var_11_1[arg_11_1 + self._style_add + 1]
			var_11_0 = arg_11_1 + self._style_add + 1
		end

		if self:__itr_is_valid() then
			if var_11_0 < self._itr then
				self._itr = self._itr - 1
				self._pairs_last = -1
			elseif var_11_0 == self._itr then
				self._pairs_last = -1

				if self._itr == self._num then
					self._itr = self._num - 1
				end
			end
		end

		self._set[self._num] = nil
		self._num = self._num - 1

		return true
	end

	function arg_1_0:pairs()
		self:__itr_begin()

		self._pairs_last = nil

		return self.__next_itr_do, self
	end

	function arg_1_0:sort(arg_13_1)
		table.sort(self._set, arg_13_1)
	end

	function arg_1_0:__next_itr_do()
		if self._itr == self._pairs_last then
			self:__itr_next()
		end

		self._pairs_last = self._itr

		if self:__itr_is_valid() then
			return self._itr - self._style_add, self._set[self._itr]
		end

		return nil
	end

	function arg_1_0:__itr_begin()
		self._itr = self._begin_idx
	end

	function arg_1_0:__itr_next()
		if self:__itr_is_valid() then
			self._itr = self._itr + 1
		end
	end

	function arg_1_0:__itr_is_valid()
		if self._itr < self._begin_idx or self._itr > self._num then
			return false
		end

		return true
	end
end)

function var_0_0.create(arg_18_0, arg_18_1)
	local var_18_0 = var_0_1.class("vector")

	var_18_0._style_add = 0
	var_18_0._itr = -1
	var_18_0._pairs_last = -1
	var_18_0._begin_idx = 1
	var_18_0._num = 0
	var_18_0._set = {}
	var_18_0._style_add = arg_18_1 and 1 or 0

	return var_18_0
end

return var_0_0
