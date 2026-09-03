-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/table.lua

local maxn = table.maxn

function table.values(t)
	local ret = {}
	local c = #ret + 1

	for _, v in pairs(t) do
		c = c + 1
		ret[c] = v
	end

	return ret
end

function table.keys(t, cmp)
	local ret = {}

	if cmp == nil then
		local c = #ret + 1

		for k in pairs(t) do
			c = c + 1
			ret[c] = k
		end
	else
		local reverse_map = {}
		local values = {}
		local c = #values + 1

		for k, v in pairs(t) do
			reverse_map[v] = k
			c = c + 1
			values[c] = v
		end

		table.sort(values, cmp)

		for i = 1, #values do
			ret[i] = reverse_map[values[i]]
		end
	end

	return ret
end

function table.nums(t)
	local cnt = 0
	local a

	while true do
		a = next(t, a)

		if a == nil then
			break
		end

		cnt = cnt + 1
	end

	return cnt
end

function table.copy(src, dest)
	local u = dest or {}

	for k, v in pairs(src) do
		u[k] = v
	end

	return setmetatable(u, getmetatable(src))
end

function table.deepcopy(src, dest)
	local lookup_table = {}

	local function _deepCopy(from, to)
		for k, v in pairs(from) do
			if type(v) ~= "table" then
				to[k] = v
			else
				local temp = lookup_table[v]

				if temp then
					to[k] = temp
				else
					local new_table = {}

					lookup_table[v] = new_table
					to[k] = new_table

					_deepCopy(v, new_table)
				end
			end
		end

		return setmetatable(to, getmetatable(from))
	end

	return _deepCopy(src, dest or {})
end

function table.find(t, value, startKey, equalFn)
	local k, v = startKey

	if startKey ~= nil then
		v = t[startKey]
	end

	if equalFn == nil then
		repeat
			if v == value then
				return k, v
			end

			k, v = next(t, k)
		until k == nil
	else
		repeat
			if equalFn(v, value) then
				return k, v
			end

			k, v = next(t, k)
		until k == nil
	end

	return nil
end

function table.indexof(array, value, start, equalFn)
	if equalFn == nil then
		for i = start or 1, #array do
			if value == array[i] then
				return i
			end
		end
	else
		for i = start or 1, #array do
			if equalFn(value, array[i]) then
				return i
			end
		end
	end

	return nil
end

function table.removevalues(array, value)
	local n = maxn(array)
	local hole = 1

	for i = 1, n do
		local val = array[i]

		if val == value then
			array[i] = nil
		else
			if hole ~= i then
				array[hole] = val
				array[i] = nil
			end

			hole = hole + 1
		end
	end

	return array
end

function table.removeif(array, pred)
	local n = maxn(array)
	local hole = 1

	for i = 1, n do
		local val = array[i]

		if pred(i, val) then
			array[i] = nil
		else
			if hole ~= i then
				array[hole] = val
				array[i] = nil
			end

			hole = hole + 1
		end
	end

	return array
end

function table.bsearch(sortedArray, value, sortFunc)
	if sortFunc ~= nil then
		local i1, i2 = 1, #sortedArray

		while i1 <= i2 do
			local m = i1 + i2

			m = (m - m % 2) / 2

			local em = sortedArray[m]

			if sortFunc(em, value) then
				i1 = m + 1
			elseif sortFunc(value, em) then
				i2 = m - 1
			else
				return m, em
			end
		end
	else
		local n = #sortedArray
		local e1 = sortedArray[1]
		local e2 = sortedArray[n]
		local i1, i2 = 1, n

		if e1 < e2 then
			if value < e1 or e2 < value then
				return nil
			end

			while i1 <= i2 do
				local m = i1 + i2

				m = (m - m % 2) / 2

				local em = sortedArray[m]

				if em < value then
					i1 = m + 1
				elseif value < em then
					i2 = m - 1
				else
					return m, em
				end
			end
		elseif e2 < e1 then
			if value < e2 or e1 < value then
				return nil
			end

			while i1 <= i2 do
				local m = i1 + i2

				m = (m - m % 2) / 2

				local em = sortedArray[m]

				if value < em then
					i1 = m + 1
				elseif em < value then
					i2 = m - 1
				else
					return m, em
				end
			end
		elseif e1 == value then
			return 1, e1
		end
	end

	return nil
end
