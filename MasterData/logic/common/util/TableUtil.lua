-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/TableUtil.lua

module("logic.common.util.TableUtil", package.seeall)

local empty_table = {}

function getEmptyTable()
	return empty_table
end

function getLen(tb)
	local len = 0

	if tb then
		for k, v in pairs(tb) do
			len = len + 1
		end
	end

	return len
end

function mergeA2B(a, b)
	if a == nil then
		return b
	end

	if type(b) == "table" and type(a) == "table" then
		for k, v in pairs(b) do
			b[k] = mergeA2B(a[k], b[k])
		end

		return b
	else
		return a
	end
end

function mergeA2BEx(a, b)
	if b == nil then
		return a
	end

	if type(b) == "table" and type(a) == "table" then
		for k, v in pairs(a) do
			b[k] = mergeA2BEx(a[k], b[k])
		end

		return b
	else
		return b
	end
end

function unionA2B(a, b)
	if a == nil then
		return b
	end

	if type(b) == "table" and type(a) == "table" then
		for k, v in pairs(a) do
			b[k] = unionA2B(a[k], b[k])
		end

		return b
	else
		return a
	end
end

function string2table(str)
	return loadstring("return " .. str)()
end

function realSort(tbl, sortFunc)
	if type(tbl) ~= "table" or #tbl < 2 then
		return
	end

	local tmpTbl = {}

	for k, v in ipairs(tbl) do
		tmpTbl[k] = {
			index = k,
			value = v
		}
	end

	table.sort(tmpTbl, sortFunc)

	for k, v in ipairs(tmpTbl) do
		tbl[k] = v.value
	end
end

function reverseTable(tbl)
	local newTbl = {}

	for i = #tbl, 1, -1 do
		table.insert(newTbl, tbl[i])
	end

	return newTbl
end

function tableFind(params)
	params = params or {}

	if type(params.ary) ~= "table" and type(params.table) ~= "table" then
		return nil
	end

	local function fun(k, v)
		if type(params.fun) == "function" then
			return params.fun(k, v, params)
		elseif params.key and params.value then
			return params.key == k and params.value == v
		elseif params.key then
			return params.key == k
		elseif params.value then
			return params.value == v
		end
	end

	if params.table then
		for k, v in pairs(params.table) do
			if fun(k, v) then
				if type(params.ret) == "function" then
					return params.ret(k, v)
				end

				return v, k
			end
		end
	else
		for k, v in ipairs(params.ary) do
			if fun(k, v) then
				if type(params.ret) == "function" then
					return params.ret(k, v)
				end

				return v, k
			end
		end
	end
end

function isEmptyTable(t)
	return next(t) == nil
end

function isEqualTable(tab1, tab2)
	if type(tab1) == "table" and type(tab2) == "table" then
		local item2 = false
		local findTable, otherTable = tab1, tab2

		if table.nums(tab1) < table.nums(tab2) then
			findTable = tab2
			otherTable = tab1
		end

		for k, v in pairs(findTable) do
			item2 = otherTable[k]

			if type(v) == "table" and type(item2) == "table" then
				if not isEqualTable(v, item2) then
					return false
				end
			elseif v ~= item2 then
				return false
			end
		end
	end

	return true
end

local function getTableMapOne(tableName, name)
	local tableValue = {}

	for k, v in ipairs(tableName) do
		tableValue[v[name]] = v
	end

	return tableValue
end

local function getTableMapTwo(tableName, name1, name2)
	local tableValue = {}

	for k, v in ipairs(tableName) do
		if not tableValue[v[name1]] then
			tableValue[v[name1]] = {}
		end

		tableValue[v[name1]][v[name2]] = v
	end

	return tableValue
end

local function getTableMapThree(tableName, name1, name2, name3)
	local tableValue = {}

	for k, v in ipairs(tableName) do
		if not tableValue[v[name1]] then
			tableValue[v[name1]] = {}
		end

		if not tableValue[v[name1]][v[name2]] then
			tableValue[v[name1]][v[name2]] = {}
		end

		tableValue[v[name1]][v[name2]][v[name3]] = v
	end

	return tableValue
end

local funTable = {
	getTableMapOne,
	getTableMapTwo,
	getTableMapThree
}

function getTableMap(tableName, ...)
	local argsLen = select("#", ...)

	return argsLen > #funTable and tableName or funTable[argsLen](tableName, ...)
end

function deepCopy(object)
	local lookup_table = {}

	local function _copy(object)
		if type(object) ~= "table" then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}

		lookup_table[object] = new_table

		for key, value in pairs(object) do
			new_table[_copy(key)] = _copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return _copy(object)
end

function contains(tb, obj)
	for k, v in pairs(tb) do
		if v == obj then
			return true
		end
	end

	return false
end

function strToTable(str)
	if str == nil or type(str) ~= "string" then
		return
	end

	return loadstring("return " .. str)()
end

function addRange(tb1, tb2, notOrder)
	if notOrder then
		for k, v in pairs(tb2) do
			table.insert(tb1, v)
		end
	else
		for k, v in ipairs(tb2) do
			table.insert(tb1, v)
		end
	end
end

function addRangeNew(tb1, tb2, notOrder)
	local temp = {}

	if notOrder then
		for k, v in pairs(tb1) do
			table.insert(temp, v)
		end

		for k, v in pairs(tb2) do
			table.insert(temp, v)
		end
	else
		for k, v in ipairs(tb1) do
			table.insert(temp, v)
		end

		for k, v in ipairs(tb2) do
			table.insert(temp, v)
		end
	end

	return temp
end

local function dump_value_(v)
	if type(v) == "string" then
		v = "\"" .. v .. "\""
	end

	return tostring(v)
end

function dump(value, desciption, nesting)
	if type(nesting) ~= "number" then
		nesting = 3
	end

	local lookupTable = {}
	local result = {}
	local traceback = string.split(debug.traceback("", 2), "\n")

	local function dump_(value, desciption, indent, nest, keylen)
		desciption = desciption or "<var>"

		local spc = ""

		if type(keylen) == "number" then
			spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
		end

		if type(value) ~= "table" then
			result[#result + 1] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
		elseif lookupTable[tostring(value)] then
			result[#result + 1] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
		else
			lookupTable[tostring(value)] = true

			if nest > nesting then
				result[#result + 1] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
			else
				result[#result + 1] = string.format("%s%s = {", indent, dump_value_(desciption))

				local indent2 = indent .. "    "
				local keys = {}
				local keylen = 0
				local values = {}

				for k, v in pairs(value) do
					keys[#keys + 1] = k

					local vk = dump_value_(k)
					local vkl = string.len(vk)

					if keylen < vkl then
						keylen = vkl
					end

					values[k] = v
				end

				table.sort(keys, function(a, b)
					if type(a) == "number" and type(b) == "number" then
						return a < b
					else
						return tostring(a) < tostring(b)
					end
				end)

				for i, k in ipairs(keys) do
					dump_(values[k], k, indent2, nest + 1, keylen)
				end

				result[#result + 1] = string.format("%s}", indent)
			end
		end
	end

	dump_(value, desciption, "- ", 1)

	local temp = ""

	for i, line in ipairs(result) do
		temp = temp .. line .. "\n"
	end

	print(temp)
end

function arrayToMap(tableName)
	local map = {}

	for k, v in ipairs(tableName or {}) do
		if v then
			map[v] = k
		end
	end

	return map
end

function tableToMap(tb)
	local map = {}

	for k, v in pairs(tb or {}) do
		map[v] = k
	end

	return map
end

function removeByFun(array, param, func, removeall)
	local i, max = 1, #array
	local success = false

	while i <= max do
		if func(array[i], param) then
			table.remove(array, i)

			i = i - 1
			max = max - 1
			success = true

			if not removeall then
				break
			end
		end

		i = i + 1
	end

	return success
end

function findByFun(array, param, func)
	for i, v in ipairs(array) do
		if func(v, param) then
			return v, i
		end
	end

	return false, false
end

function subTable(tb, startIdx, endIdx)
	assert(TypeUtil.isNumber(startIdx) and startIdx >= 1, "startIdx must be number and positive integer")

	return {
		unpack(tb, startIdx, endIdx)
	}
end
