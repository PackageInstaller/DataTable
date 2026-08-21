local var_0_0 = {
	next_raw = function(arg_1_0, arg_1_1)
		if not arg_1_1 then
			if #arg_1_0 == 0 then
				return nil
			end

			return 1, true
		end

		if arg_1_1 > #arg_1_0 then
			return
		end

		local var_1_0 = arg_1_0:byte(arg_1_1)

		if var_1_0 >= 0 and var_1_0 <= 127 then
			arg_1_1 = arg_1_1 + 1
		elseif var_1_0 >= 194 and var_1_0 <= 223 then
			arg_1_1 = arg_1_1 + 2
		elseif var_1_0 >= 224 and var_1_0 <= 239 then
			arg_1_1 = arg_1_1 + 3
		elseif var_1_0 >= 240 and var_1_0 <= 244 then
			arg_1_1 = arg_1_1 + 4
		else
			return arg_1_1 + 1, false
		end

		if arg_1_1 > #arg_1_0 then
			return
		end

		return arg_1_1, true
	end
}

var_0_0.next = var_0_0.next_raw

function var_0_0.byte_indices(arg_2_0, arg_2_1)
	return var_0_0.next, arg_2_0, arg_2_1
end

function var_0_0.len(arg_3_0)
	assert(arg_3_0, "bad argument #1 to 'len' (string expected, got nil)")

	local var_3_0 = 0

	for iter_3_0 in var_0_0.byte_indices(arg_3_0) do
		var_3_0 = var_3_0 + 1
	end

	return var_3_0
end

function var_0_0.byte_index(arg_4_0, arg_4_1)
	if arg_4_1 < 1 then
		return
	end

	local var_4_0 = 0

	for iter_4_0 in var_0_0.byte_indices(arg_4_0) do
		var_4_0 = var_4_0 + 1

		if var_4_0 == arg_4_1 then
			return iter_4_0
		end
	end

	assert(var_4_0 < arg_4_1, "invalid index")
end

function var_0_0.char_index(arg_5_0, arg_5_1)
	if arg_5_1 < 1 or arg_5_1 > #arg_5_0 then
		return
	end

	local var_5_0 = 0

	for iter_5_0 in var_0_0.byte_indices(arg_5_0) do
		var_5_0 = var_5_0 + 1

		if iter_5_0 == arg_5_1 then
			return var_5_0
		end
	end

	error("invalid index")
end

function var_0_0.prev(arg_6_0, arg_6_1)
	arg_6_1 = arg_6_1 or #arg_6_0 + 1

	if arg_6_1 <= 1 or arg_6_1 > #arg_6_0 + 1 then
		return
	end

	local var_6_0, var_6_1 = var_0_0.next(arg_6_0)

	for iter_6_0, iter_6_1 in var_0_0.byte_indices(arg_6_0) do
		if iter_6_0 == arg_6_1 then
			return var_6_0, var_6_1
		end

		var_6_0, var_6_1 = iter_6_0, iter_6_1
	end

	if arg_6_1 == #arg_6_0 + 1 then
		return var_6_0, var_6_1
	end

	error("invalid index")
end

function var_0_0.byte_indices_reverse(arg_7_0, arg_7_1)
	if #arg_7_0 < 200 then
		return var_0_0.prev, arg_7_0, arg_7_1
	else
		local var_7_0 = {}

		for iter_7_0 in var_0_0.byte_indices(arg_7_0) do
			if arg_7_1 and arg_7_1 <= iter_7_0 then
				break
			end

			table.insert(var_7_0, iter_7_0)
		end

		local var_7_1 = #var_7_0 + 1

		return function()
			var_7_1 = var_7_1 - 1

			return var_7_0[var_7_1]
		end
	end
end

function var_0_0.sub(arg_9_0, arg_9_1, arg_9_2)
	assert(arg_9_1 >= 1)
	assert(not arg_9_2 or arg_9_2 >= 0)

	local var_9_0 = 0
	local var_9_1
	local var_9_2

	for iter_9_0 in var_0_0.byte_indices(arg_9_0) do
		var_9_0 = var_9_0 + 1

		if var_9_0 == arg_9_1 then
			var_9_1 = iter_9_0
		end

		if var_9_0 == arg_9_2 then
			var_9_2 = iter_9_0
		end
	end

	if not var_9_1 then
		assert(var_9_0 < arg_9_1, "invalid index")

		return ""
	end

	if arg_9_2 and not var_9_2 then
		if arg_9_2 < arg_9_1 then
			return ""
		end

		assert(var_9_0 < arg_9_2, "invalid index")
	end

	return arg_9_0:sub(var_9_1, var_9_2 and var_9_2 - 1)
end

function var_0_0.contains(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 < 1 or arg_10_1 > #arg_10_0 then
		return nil
	end

	for iter_10_0 = 1, #arg_10_2 do
		if arg_10_0:byte(arg_10_1 + iter_10_0 - 1) ~= arg_10_2:byte(iter_10_0) then
			return false
		end
	end

	return true
end

function var_0_0.count(arg_11_0, arg_11_1)
	assert(#arg_11_1 > 0)

	local var_11_0 = 0
	local var_11_1 = 1

	while var_11_1 do
		if var_0_0.contains(arg_11_0, var_11_1, arg_11_1) then
			var_11_0 = var_11_0 + 1
			var_11_1 = var_11_1 + #arg_11_1

			if var_11_1 > #arg_11_0 then
				break
			end
		else
			var_11_1 = var_0_0.next(arg_11_0, var_11_1)
		end
	end

	return var_11_0
end

function var_0_0.isvalid(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:byte(arg_12_1)

	if not var_12_0 then
		return false
	elseif var_12_0 >= 0 and var_12_0 <= 127 then
		return true
	elseif var_12_0 >= 194 and var_12_0 <= 223 then
		local var_12_1 = arg_12_0:byte(arg_12_1 + 1)

		return var_12_1 and var_12_1 >= 128 and var_12_1 <= 191
	elseif var_12_0 >= 224 and var_12_0 <= 239 then
		local var_12_2 = arg_12_0:byte(arg_12_1 + 1)
		local var_12_3 = arg_12_0:byte(arg_12_1 + 2)

		if var_12_0 == 224 then
			return var_12_2 and var_12_3 and var_12_2 >= 160 and var_12_2 <= 191 and var_12_3 >= 128 and var_12_3 <= 191
		elseif var_12_0 >= 225 and var_12_0 <= 236 then
			return var_12_2 and var_12_3 and var_12_2 >= 128 and var_12_2 <= 191 and var_12_3 >= 128 and var_12_3 <= 191
		elseif var_12_0 == 237 then
			return var_12_2 and var_12_3 and var_12_2 >= 128 and var_12_2 <= 159 and var_12_3 >= 128 and var_12_3 <= 191
		elseif var_12_0 >= 238 and var_12_0 <= 239 then
			if var_12_0 == 239 and var_12_2 == 191 and (var_12_3 == 190 or var_12_3 == 191) then
				return false
			end

			return var_12_2 and var_12_3 and var_12_2 >= 128 and var_12_2 <= 191 and var_12_3 >= 128 and var_12_3 <= 191
		end
	elseif var_12_0 >= 240 and var_12_0 <= 244 then
		local var_12_4 = arg_12_0:byte(arg_12_1 + 1)
		local var_12_5 = arg_12_0:byte(arg_12_1 + 2)
		local var_12_6 = arg_12_0:byte(arg_12_1 + 3)

		if var_12_0 == 240 then
			return var_12_4 and var_12_5 and var_12_6 and var_12_4 >= 144 and var_12_4 <= 191 and var_12_5 >= 128 and var_12_5 <= 191 and var_12_6 >= 128 and var_12_6 <= 191
		elseif var_12_0 >= 241 and var_12_0 <= 243 then
			return var_12_4 and var_12_5 and var_12_6 and var_12_4 >= 128 and var_12_4 <= 191 and var_12_5 >= 128 and var_12_5 <= 191 and var_12_6 >= 128 and var_12_6 <= 191
		elseif var_12_0 == 244 then
			return var_12_4 and var_12_5 and var_12_6 and var_12_4 >= 128 and var_12_4 <= 143 and var_12_5 >= 128 and var_12_5 <= 191 and var_12_6 >= 128 and var_12_6 <= 191
		end
	end

	return false
end

function var_0_0.next_valid(arg_13_0, arg_13_1)
	local var_13_0
	local var_13_1

	arg_13_1, var_13_1 = var_0_0.next_raw(arg_13_0, arg_13_1)

	while arg_13_1 and (not var_13_1 or not var_0_0.isvalid(arg_13_0, arg_13_1)) do
		arg_13_1, var_13_1 = var_0_0.next(arg_13_0, arg_13_1)
	end

	return arg_13_1
end

function var_0_0.valid_byte_indices(arg_14_0)
	return var_0_0.next_valid, arg_14_0
end

function var_0_0.validate(arg_15_0)
	for iter_15_0, iter_15_1 in var_0_0.byte_indices(arg_15_0) do
		if not iter_15_1 or not var_0_0.isvalid(arg_15_0, iter_15_0) then
			error(string.format("invalid utf8 char at #%d", iter_15_0))
		end
	end
end

local function var_0_1(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	return arg_16_3[arg_16_0:sub(arg_16_1, arg_16_2)]
end

function var_0_0.replace(arg_17_0, arg_17_1, ...)
	if type(arg_17_1) == "table" then
		return var_0_0.replace(arg_17_0, var_0_1, arg_17_1)
	end

	if arg_17_0 == "" then
		return arg_17_0
	end

	local var_17_0 = {}
	local var_17_1 = 1

	for iter_17_0 in var_0_0.byte_indices(arg_17_0) do
		local var_17_2 = var_0_0.next(arg_17_0, iter_17_0) or #arg_17_0 + 1
		local var_17_3 = arg_17_1(arg_17_0, iter_17_0, var_17_2 - 1, ...)

		if var_17_3 then
			table.insert(var_17_0, arg_17_0:sub(var_17_1, iter_17_0 - 1))
			table.insert(var_17_0, var_17_3)

			var_17_1 = var_17_2
		end
	end

	table.insert(var_17_0, arg_17_0:sub(var_17_1))

	return table.concat(var_17_0)
end

local function var_0_2(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not var_0_0.isvalid(arg_18_0, arg_18_1) then
		return arg_18_3
	end
end

function var_0_0.sanitize(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or "�"

	return var_0_0.replace(arg_19_0, var_0_2, arg_19_1)
end

return var_0_0
