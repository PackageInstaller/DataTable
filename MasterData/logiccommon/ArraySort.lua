-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/ArraySort.lua

module("logiccommon.common.util.ArraySort", package.seeall)

local ArraySort = class("ArraySort")
local ArraySort = {}

ArraySort.NONE = 0
ArraySort.CASEINSENSITIVE = 1
ArraySort.DESCENDING = 2
ArraySort.NUMERIC = 4
ArraySort._TYPE_TABLE = "table"
ArraySort._TYPE_FUNCTION = "function"
ArraySort._TYPE_STRING = "string"
ArraySort._TYPE_NUMBER = "number"
ArraySort._TYPE_BOOLEAN = "boolean"
ArraySort.zeroStr = ""
ArraySort.pool = {}

function ArraySort.bor(...)
	return bit.bor(...)
end

function ArraySort._clearOrCreateEmptyTable(list)
	if list == nil then
		return {}
	else
		for i, v in pairs(list) do
			list[i] = nil
		end

		return list
	end
end

function ArraySort:sortNow()
	if self.datas then
		local len = #self.sortNames
		local n, av, bv, flag

		table.sort(self.datas, function(a, b)
			for i = 1, len do
				av = self.preprocessedValues[a][i]
				bv = self.preprocessedValues[b][i]
				flag = self.preprocessedFlags[i]

				if av > bv then
					return flag
				elseif av < bv then
					return not flag
				elseif i == len then
					return av > bv
				end
			end

			return false
		end)
	end

	return self.datas
end

function ArraySort.sortOn(arr, names, opts)
	if arr == nil then
		return
	end

	opts = opts or 0

	local nameList = type(names) == ArraySort._TYPE_TABLE and names or {
		names or ""
	}

	if type(opts) ~= ArraySort._TYPE_TABLE then
		opts = checknumber(opts)
	end

	local sortObject = #ArraySort.pool > 0 and table.remove(ArraySort.pool) or {}

	sortObject.sortNames = nameList
	sortObject.opts = opts
	sortObject.datas = arr
	sortObject.preprocessedValues = ArraySort._clearOrCreateEmptyTable(sortObject.preprocessedValues)
	sortObject.preprocessedFlags = ArraySort._clearOrCreateEmptyTable(sortObject.preprocessedFlags)

	local opTemps = {}

	for idx, _ in ipairs(sortObject.sortNames) do
		local op = 1

		op = type(sortObject.opts) == ArraySort._TYPE_TABLE and checknumber(sortObject.opts[idx]) or sortObject.opts
		opTemps[idx] = op
		sortObject.preprocessedFlags[idx] = bit.band(ArraySort.DESCENDING, op) > 0
	end

	local op = 1

	for _, data in ipairs(sortObject.datas) do
		if sortObject.preprocessedValues[data] == nil then
			sortObject.preprocessedValues[data] = {}

			for idx, typeValue in ipairs(sortObject.sortNames) do
				local value

				if type(typeValue) == ArraySort._TYPE_STRING then
					if type(data) == ArraySort._TYPE_NUMBER or type(data) == ArraySort._TYPE_BOOLEAN or type(data) == ArraySort._TYPE_STRING then
						value = data
					else
						value = data[typeValue]

						if type(data[typeValue]) == ArraySort._TYPE_FUNCTION then
							value = value(data)
						end
					end
				elseif type(typeValue) == ArraySort._TYPE_FUNCTION then
					value = typeValue(data)
				end

				if type(value) == ArraySort._TYPE_BOOLEAN then
					value = value and 1 or 0
				end

				op = opTemps[idx]

				if bit.band(ArraySort.CASEINSENSITIVE, opTemps[idx]) > 0 then
					value = string.upper((value or ArraySort.zeroStr) .. ArraySort.zeroStr)
				end

				if bit.band(ArraySort.NUMERIC, op) > 0 or value == nil then
					value = checknumber(value)
				end

				sortObject.preprocessedValues[data][idx] = value
			end
		end
	end

	local res = ArraySort.sortNow(sortObject)

	sortObject.sortNames = nil
	sortObject.opts = nil
	sortObject.datas = nil
	sortObject.preprocessedValues = ArraySort._clearOrCreateEmptyTable(sortObject.preprocessedValues)
	sortObject.preprocessedFlags = ArraySort._clearOrCreateEmptyTable(sortObject.preprocessedFlags)

	table.insert(ArraySort.pool, sortObject)

	return res
end

return ArraySort
