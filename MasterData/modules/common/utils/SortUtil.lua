-- chunkname: @modules/common/utils/SortUtil.lua

module("modules.common.utils.SortUtil", package.seeall)

local SortUtil = {}

function SortUtil.keyLower(key)
	return function(a, b)
		return a[key] < b[key]
	end
end

function SortUtil.keyUpper(key)
	return function(a, b)
		return a[key] > b[key]
	end
end

function SortUtil.tableKeyLower(t)
	return function(a, b)
		for _, key in ipairs(t) do
			if a[key] ~= b[key] then
				return a[key] < b[key]
			end
		end

		return false
	end
end

function SortUtil.tableKeyUpper(t)
	return function(a, b)
		for _, key in ipairs(t) do
			if a[key] ~= b[key] then
				return a[key] > b[key]
			end
		end

		return false
	end
end

return SortUtil
