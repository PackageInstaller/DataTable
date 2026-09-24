local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = assert

local function var_0_3(arg_1_0)
	arg_1_0.__next__ = nil
	arg_1_0.__prev__ = nil

	return arg_1_0
end

local function var_0_4(arg_2_0)
	return arg_2_0.__next__ == arg_2_0
end

local function var_0_5(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.__prev__ = arg_3_1
	arg_3_0.__next__ = arg_3_2
	arg_3_1.__next__ = arg_3_0
	arg_3_2.__prev__ = arg_3_0
end

local function var_0_6(arg_4_0, arg_4_1)
	arg_4_0.__next__ = arg_4_1
	arg_4_1.__prev__ = arg_4_0
end

local function var_0_7(arg_5_0, arg_5_1)
	var_0_5(arg_5_1, arg_5_0, arg_5_0.__next__)
end

local function var_0_8(arg_6_0, arg_6_1)
	var_0_5(arg_6_1, arg_6_0.__prev__, arg_6_0)
end

local function var_0_9(arg_7_0)
	if var_0_4(arg_7_0) then
		return nil
	end

	return arg_7_0.__next__
end

local function var_0_10(arg_8_0)
	if var_0_4(arg_8_0) then
		return nil
	end

	return arg_8_0.__prev__
end

local function var_0_11(arg_9_0)
	var_0_6(arg_9_0.__prev__, arg_9_0.__next__)

	arg_9_0.__next__ = nil
	arg_9_0.__prev__ = nil
end

lx.define_class("list_base", function(arg_10_0)
	function arg_10_0:size()
		return self._num
	end

	function arg_10_0:empty()
		return self._num == 0
	end

	function arg_10_0:clear()
		while not var_0_4(self._root) do
			self:pop_back()
		end

		if self._num ~= 0 then
			var_0_2(self._num == 0)
		end

		self._itr = nil
		self._each_last = nil
		self._pairs_idx = nil
	end

	function arg_10_0:push_front(arg_14_1)
		if arg_14_1 == nil then
			return
		end

		var_0_7(self._root, (self:__create_node(arg_14_1)))
	end

	function arg_10_0:push_back(arg_15_1)
		if arg_15_1 == nil then
			return
		end

		var_0_8(self._root, (self:__create_node(arg_15_1)))
	end

	function arg_10_0:front()
		local var_16_0 = var_0_9(self._root)

		if var_16_0 then
			return self:__event_on__get_value(var_16_0)
		end

		return nil
	end

	function arg_10_0:back()
		local var_17_0 = var_0_10(self._root)

		if var_17_0 then
			return self:__event_on__get_value(var_17_0)
		end

		return nil
	end

	function arg_10_0:pop_front()
		if var_0_4(self._root) then
			return
		end

		self:__remove_node(self._root.__next__)
	end

	function arg_10_0:pop_back()
		if var_0_4(self._root) then
			return
		end

		self:__remove_node(self._root.__prev__)
	end

	function arg_10_0:erase_itr()
		if not self:__itr_is_valid() then
			return
		end

		self._itr = self._itr.__next__, self:__remove_node(self._itr)
	end

	function arg_10_0:eachs()
		self:__itr_begin()

		self._each_last = nil
		self._pairs_idx = nil

		return self.__next_itr_do, self
	end

	function arg_10_0:pairs()
		self:__itr_begin()

		self._each_last = nil
		self._pairs_idx = 0

		return self.__pairs_next_itr_do, self
	end

	function arg_10_0:has_next()
		if self._pairs_idx == nil then
			return false
		end

		return self._pairs_idx < self._num
	end

	function arg_10_0.__event_on__create_node(arg_24_0, arg_24_1)
		return {
			value = arg_24_1
		}
	end

	function arg_10_0.__event_on__remove_node(arg_25_0, arg_25_1)
		arg_25_1.value = nil
	end

	function arg_10_0.__event_on__get_value(arg_26_0, arg_26_1)
		return arg_26_1.value
	end

	function arg_10_0:__create_node(arg_27_1)
		self._num = self._num + 1

		return (var_0_3((self:__event_on__create_node(arg_27_1))))
	end

	function arg_10_0:__remove_node(arg_28_1)
		self:__event_on__remove_node(arg_28_1)
		var_0_11(arg_28_1)

		self._num = self._num - 1
	end

	function arg_10_0:__next_itr_do()
		if self._itr == self._each_last then
			self:__itr_next()
		end

		self._each_last = self._itr

		if self:__itr_is_valid() then
			return self:__event_on__get_value(self._itr)
		end

		return nil
	end

	function arg_10_0:__pairs_next_itr_do()
		local var_30_0 = self:__next_itr_do()

		if var_30_0 then
			self._pairs_idx = self._pairs_idx + 1

			return self._pairs_idx, var_30_0
		end

		return nil, nil
	end

	function arg_10_0:__itr_begin()
		self._itr = self._root.__next__
	end

	function arg_10_0:__itr_next()
		if self:__itr_is_valid() then
			self._itr = self._itr.__next__
		end
	end

	function arg_10_0:__itr_is_valid()
		return self._itr and self._itr ~= self._root
	end
end)

function var_0_0.create(arg_34_0)
	local var_34_0 = var_0_1.class("list_base")

	var_34_0._num = 0
	var_34_0._root = nil
	var_34_0._itr = nil
	var_34_0._each_last = nil
	var_34_0._pairs_idx = nil
	var_34_0._root = var_0_3({})
	var_34_0._root.__next__ = var_34_0._root
	var_34_0._root.__prev__ = var_34_0._root

	return var_34_0
end

return var_0_0
