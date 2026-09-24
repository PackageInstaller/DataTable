local var_0_0 = {}
local var_0_1 = lx
local var_0_2 = std_map
local var_0_3 = assert

lx.define_class("map", function(arg_1_0)
	function arg_1_0:size()
		return self._map:size()
	end

	function arg_1_0:empty()
		return self:size() == 0
	end

	function arg_1_0:clear()
		self._key_set = {}
		self._value_set = {}

		self._map:clear()
	end

	function arg_1_0:find(arg_5_1)
		local var_5_0 = self:__add_key(arg_5_1)

		self:__remove_key(var_5_0)

		return self:__find_value((self._map:find(self._compare_func, var_5_0)))
	end

	function arg_1_0:erase(arg_6_1)
		local var_6_0 = self:__add_key(arg_6_1)
		local var_6_1 = self._map:erase(self._compare_func, var_6_0)

		self:__remove_key(var_6_0)

		if var_6_1 == 0 then
			return false
		end

		self:__remove_key(self:__find_value(var_6_1).key_id)
		self:__remove_value(var_6_1)

		return true
	end

	function arg_1_0:insert(arg_7_1, arg_7_2)
		local var_7_0 = {}
		local var_7_1 = self:__add_key(arg_7_1)
		local var_7_2 = self:__add_value(var_7_0)

		var_7_0.key_id = var_7_1
		var_7_0.value_id = var_7_2
		var_7_0.key = arg_7_1
		var_7_0.value = arg_7_2

		if not self._map:insert(self._compare_func, var_7_1, var_7_2) then
			self:__remove_key(var_7_1)
			self:__remove_value(var_7_2)

			return false
		end

		return true
	end

	function arg_1_0:head()
		if self:empty() then
			return nil
		end

		local var_8_0 = self._map:itr_begin()

		self._map:exit_iterator()

		return self:__find_value(var_8_0)
	end

	function arg_1_0:tail()
		if self:empty() then
			return nil
		end

		local var_9_0 = self._map:reverse_itr_begin()

		self._map:exit_iterator()

		return self:__find_value(var_9_0)
	end

	function arg_1_0:eachs()
		self._first = true

		return self.__next_do, self
	end

	function arg_1_0:reverse_eachs()
		self._first = true

		return self.__reverse_next_do, self
	end

	function arg_1_0:exit_bound()
		self._map:exit_iterator()
	end

	function arg_1_0:lower_bound(arg_13_1)
		local var_13_0 = self:__add_key(arg_13_1)

		self:__remove_key(var_13_0)

		return self:__find_value((self._map:lower_bound(self._compare_func, var_13_0)))
	end

	function arg_1_0:upper_bound(arg_14_1)
		local var_14_0 = self:__add_key(arg_14_1)

		self:__remove_key(var_14_0)

		return self:__find_value((self._map:upper_bound(self._compare_func, var_14_0)))
	end

	function arg_1_0:bound_next()
		return self:__find_value((self._map:itr_next()))
	end

	function arg_1_0:__next_do()
		if self._first then
			self._first = false

			return self:__find_value((self._map:itr_begin()))
		else
			return self:__find_value((self._map:itr_next()))
		end
	end

	function arg_1_0:__reverse_next_do()
		if self._first then
			self._first = false

			return self:__find_value((self._map:reverse_itr_begin()))
		else
			return self:__find_value((self._map:reverse_itr_next()))
		end
	end

	function arg_1_0:__find_key(arg_18_1)
		return self._key_set[arg_18_1]
	end

	function arg_1_0:__find_value(arg_19_1)
		return self._value_set[arg_19_1]
	end

	function arg_1_0:__add_key(arg_20_1)
		local var_20_0 = self:__alloc_key_id()

		self._key_set[var_20_0] = arg_20_1

		return var_20_0
	end

	function arg_1_0:__add_value(arg_21_1)
		local var_21_0 = self:__alloc_value_id()

		self._value_set[var_21_0] = arg_21_1

		return var_21_0
	end

	function arg_1_0:__remove_key(arg_22_1)
		self._key_set[arg_22_1] = nil
	end

	function arg_1_0:__remove_value(arg_23_1)
		self._value_set[arg_23_1] = nil
	end

	function arg_1_0:__alloc_key_id()
		self._alloc_key_id = self._alloc_key_id + 1

		return self._alloc_key_id + 1
	end

	function arg_1_0:__alloc_value_id()
		self._alloc_value_id = self._alloc_value_id + 1

		return self._alloc_value_id + 1
	end

	function arg_1_0:__compare(arg_26_1, arg_26_2)
		return self._func(self:__find_key(arg_26_1), (self:__find_key(arg_26_2)))
	end
end)

function var_0_0.create(arg_27_0, arg_27_1)
	var_0_3(type(arg_27_1) == "function")

	local var_27_0 = var_0_1.class("map")

	var_27_0._map = var_0_2.create()
	var_27_0._func = arg_27_1
	var_27_0._key_set = {}
	var_27_0._value_set = {}
	var_27_0._alloc_key_id = 0
	var_27_0._alloc_value_id = 0

	function var_27_0._compare_func(...)
		return var_27_0:__compare(...)
	end

	return var_27_0
end

return var_0_0
