-- chunkname: @IQIGame\\GlobalFunction\\CustomTableFunction.lua

function table.swap(array, index1, index2)
	array[index1], array[index2] = array[index2], array[index1]
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
		local eleNoRepeatCount1 = 0
		local eleCount2 = {}
		local eleNoRepeatCount2 = 0

		for i = 1, #t1 do
			local ele1 = t1[i]

			if eleCount1[ele1] == nil then
				eleCount1[ele1] = 1
				eleNoRepeatCount1 = eleNoRepeatCount1 + 1
			else
				eleCount1[ele1] = eleCount1[ele1] + 1
			end

			local ele2 = t2[i]

			if eleCount2[ele2] == nil then
				eleCount2[ele2] = 1
				eleNoRepeatCount2 = eleNoRepeatCount2 + 1
			else
				eleCount2[ele2] = eleCount2[ele2] + 1
			end
		end

		if eleNoRepeatCount1 ~= eleNoRepeatCount2 then
			return false
		end

		for i = 1, #t1 do
			local ele = t1[i]

			if eleCount1[ele] ~= eleCount2[ele] then
				return false
			end
		end
	end

	return true
end

function table.addValue(t, key, delta)
	if t == nil then
		logError("参数 t 不能为空。")

		return
	end

	if key == nil then
		logError("参数 key 不能为空。")

		return
	end

	if delta == nil then
		logError("参数 delta 不能为空且 delta 必须是 number 类型。")
	end

	if t[key] == nil then
		t[key] = delta
	else
		t[key] = t[key] + delta
	end
end

function table.clear(t)
	for i, v in pairs(t) do
		t[i] = nil
	end
end

function table.isNilOrEmpty(t, isArray)
	if t == nil then
		return true
	end

	if isArray then
		return #t == 0
	end

	for _, _ in pairs(t) do
		return false
	end

	return true
end
