-- chunkname: @IQIGame\\GlobalFunction\\CustomTableFunction.lua

function table.swap(array, index1, index2)
	array[index1], array[index2] = array[index2], array[index1]
end

function table.shift(array, oldIndex, newIndex)
	if newIndex < oldIndex then
		table.insert(array, newIndex, array[oldIndex])
		table.remove(array, oldIndex + 1)
	else
		table.insert(array, newIndex + 1, array[oldIndex])
		table.remove(array, oldIndex)
	end
end

function table.shuffle(array)
	local counter = #array

	while counter > 1 do
		local index = math.random(counter)

		table.swap(array, index, counter)

		counter = counter - 1
	end
end

function table.indexOf(t, element)
	for i, v in pairs(t) do
		if v == element then
			return i
		end
	end

	return -1
end

function table.search(t, func)
	for i, v in pairs(t) do
		if func(i, v) then
			return v
		end
	end

	return nil
end

function table.reverse(t)
	local temp = {}
	local index = 1

	for i = #t, 1, -1 do
		temp[index] = t[i]
		index = index + 1
	end

	for i = 1, #temp do
		t[i] = temp[i]
	end
end

function table.len(t)
	local len = 0

	for i, v in pairs(t) do
		len = len + 1
	end

	return len
end

function table.addAll(t1, t2)
	for i = 1, #t2 do
		table.insert(t1, t2[i])
	end

	return t1
end

function table.merge(t1, t2)
	local result = {}

	for i = 1, #t1 do
		table.insert(result, t1[i])
	end

	for i = 1, #t2 do
		table.insert(result, t2[i])
	end

	return result
end

function table.elementEquals(t1, t2, ignoreOrder)
	if t1 == nil or t2 == nil then
		logError("table is nil.")

		return false
	end

	if #t1 ~= #t2 then
		return false
	end

	if not ignoreOrder then
		for i = 1, #t1 do
			if t1[i] ~= t2[i] then
				return false
			end
		end
	else
		local eleCount1 = {}
		local eleCountLen1 = 0
		local eleCount2 = {}
		local eleCountLen2 = 0

		for i = 1, #t1 do
			local ele1 = t1[i]

			if eleCount1[ele1] == nil then
				eleCount1[ele1] = 1
				eleCountLen1 = eleCountLen1 + 1
			else
				eleCount1[ele1] = eleCount1[ele1] + 1
			end

			local ele2 = t2[i]

			if eleCount2[ele2] == nil then
				eleCount2[ele2] = 1
				eleCountLen2 = eleCountLen2 + 1
			else
				eleCount2[ele2] = eleCount2[ele2] + 1
			end
		end

		if eleCountLen1 ~= eleCountLen2 then
			return false
		end

		for i = 1, #t1 do
			if eleCount1[t1[i]] ~= eleCount2[t1[i]] then
				return false
			end
		end
	end

	return true
end

function table.removeElement(t, element)
	for i, v in pairs(t) do
		if v == element then
			table.remove(t, i)

			return
		end
	end
end

function table.covered(t1, t2)
	for k, v in pairs(t2) do
		t1[k] = v
	end
end

function table.computeIfAbsent(t, k, v)
	local _v = t[k]

	if _v == nil then
		_v = v
		t[k] = _v
	end

	return _v
end

function table.subArray(array, from, to)
	local sub_table = {}

	from = math.max(1, math.min(#array, from))
	to = math.max(from, math.min(#array, to))

	for i = from, to do
		table.insert(sub_table, array[i])
	end

	return sub_table
end

function table.customMerge(tab1, tab2, handler)
	local result = {}

	ForPairs(tab1, function(_k, _v)
		local v2 = tab2[_k]
		local value = handler(_k, _v, v2)

		result[_k] = value
	end)
	ForPairs(tab2, function(_k, _v)
		local v1 = tab1[_k]

		if v1 ~= nil then
			return
		end

		local value = handler(_k, v1, _v)

		result[_k] = value
	end)

	return result
end
