-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/TableUtil.lua

module("logiccommon.common.math.TableUtil", package.seeall)

local TableUtil = _M

function TableUtil.isTableEmpty(t)
	if t == nil or _G.next(t) == nil then
		return true
	else
		return false
	end
end

function TableUtil.toList(t)
	local list = {}

	if t then
		for k, v in pairs(t) do
			table.insert(list, v)
		end
	end

	return list
end

function TableUtil.printTable(object)
	local tableStr = TableUtil.tableToString(object, true)
	local sb = StringBuffer.New()

	sb:append("Print table["):append(tostring(object)):append("]")
	sb:appendLine()
	sb:append(tableStr)
	printWarn(sb:toString())
end

function TableUtil.tableToString(object, changeLine)
	if type(object) ~= "table" then
		return tostring(object)
	end

	changeLine = changeLine or false

	local sb = StringBuffer.New()

	sb:append("{")

	for k, v in pairs(object) do
		if TableUtil.isPublicField(k) and type(v) ~= "function" then
			sb:append(k):append("="):append(TableUtil.tableToString(v))

			if changeLine then
				sb:appendLine()
			else
				sb:append(",")
			end
		end
	end

	sb:append("}")

	return sb:toString()
end

function TableUtil.isPublicField(objStr)
	if type(objStr) == "number" then
		return true
	end

	if type(objStr) ~= "string" then
		return false
	end

	if string.nilorempty(objStr) then
		return false
	end

	local begin = string.sub(objStr, 1)

	return begin >= "a" and begin <= "z" or begin >= "A" and begin <= "Z"
end

function TableUtil.isHad(tbl, value)
	if tbl then
		for i, v in ipairs(tbl) do
			if v == value then
				return true
			end
		end
	end

	return false
end

function TableUtil.deepcopy(object)
	local lookup_table = {}

	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}

		lookup_table[object] = new_table

		for index, value in pairs(object) do
			new_table[_copy(index)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

function TableUtil.split(s, p)
	local rt = {}

	string.gsub(s, "[^" .. p .. "]+", function(w)
		table.insert(rt, w)
	end)

	return rt
end

function TableUtil.UpperSort(list, key_name, isUpper)
	local sort_func

	table.sort(list, key_name and (isUpper and TableUtil.KeyUpperSorter(key_name) or TableUtil.KeyLowerSorter(key_name)) or TableUtil.ItemUpperSorter(isUpper))
end

function TableUtil.ItemUpperSorter(isUpper)
	return function(a, b)
		if isUpper then
			if b < a then
				return true
			else
				return false
			end
		elseif a < b then
			return true
		else
			return false
		end
	end
end

function TableUtil.KeyLowerSorter(sort_key_name)
	return function(a, b)
		if a[sort_key_name] < b[sort_key_name] then
			return true
		else
			return false
		end
	end
end

function TableUtil.KeyUpperSorter(sort_key_name)
	return function(a, b)
		if a[sort_key_name] > b[sort_key_name] then
			return true
		else
			return false
		end
	end
end

function TableUtil.d2b(num)
	local data32 = {}

	for i = 1, 32 do
		data32[i] = 2^(32 - i)
	end

	local ba = {}

	if num / 2 >= data32[1] then
		return nil
	end

	for i = 1, 32 do
		if num >= data32[i] then
			ba[i] = 1
			num = num - data32[i]
		else
			ba[i] = 0
		end
	end

	return ba
end

function TableUtil.b2d(ba)
	local num = 0

	for i = 1, 32 do
		if ba[i] == 1 then
			num = num + 2^(32 - i)
		end
	end

	return num
end

function TableUtil.dxor(a, b)
	local op1 = TableUtil.d2b(a)
	local op2 = TableUtil.d2b(b)
	local r = {}

	for i = 1, 32 do
		r[i] = op1[i] == op2[i] and 0 or 1
	end

	return TableUtil.b2d(r)
end

function TableUtil.band(op1, op2)
	local r = {}

	for i = 1, 32 do
		r[i] = op1[i] == 1 and op2[i] == 1 and 1 or 0
	end

	return r
end

function TableUtil.dand(a, b)
	local op1 = TableUtil.d2b(a)
	local op2 = TableUtil.d2b(b)
	local r = {}

	for i = 1, 32 do
		r[i] = op1[i] == 1 and op2[i] == 1 and 1 or 0
	end

	return TableUtil.b2d(r)
end

function TableUtil.dor(a, b)
	local op1 = TableUtil.d2b(a)
	local op2 = TableUtil.d2b(b)
	local r = {}

	for i = 1, 32 do
		r[i] = (op1[i] == 1 or op2[i] == 1) and 1 or 0
	end

	return TableUtil.b2d(r)
end

function TableUtil.lshift(a, n)
	local op1 = TableUtil.d2b(a)
	local r = TableUtil.d2b(0)

	if n < 32 and n > 0 then
		for i = 1, n do
			for i = 1, 31 do
				op1[i] = op1[i + 1]
			end

			op1[32] = 0
		end

		r = op1
	end

	return TableUtil.b2d(r)
end

function TableUtil.Count(t, func_kv, iter)
	iter = iter ~= nil and iter or ipairs

	local count = 0

	for k, v in iter(t) do
		if func_kv(k, v) then
			count = count + 1
		end
	end

	return count
end

function TableUtil.Any(t, func_kv, iter)
	iter = iter ~= nil and iter or ipairs

	for k, v in iter(t) do
		if func_kv(k, v) then
			return true
		end
	end

	return false
end

function TableUtil.All(t, func_kv, iter)
	iter = iter ~= nil and iter or ipairs

	for k, v in iter(t) do
		if not func_kv(k, v) then
			return false
		end
	end

	return true
end

function TableUtil.Where(t, func_v, iter)
	iter = iter ~= nil and iter or ipairs

	local result = {}

	for _, v in iter(t) do
		if func_v(v) then
			table.insert(result, v)
		end
	end

	return result
end

function TableUtil.FirstOf(t, func_kv, iter)
	iter = iter ~= nil and iter or ipairs

	for k, v in iter(t) do
		if func_kv(k, v) then
			return k
		end
	end
end

function TableUtil.AddTable(tab1, tab2)
	for i, v in ipairs(tab2) do
		table.insert(tab1, v)
	end
end

return TableUtil
