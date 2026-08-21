-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/util/MultipleEnumUtil.lua

module("logic.common.util.MultipleEnumUtil", package.seeall)

local bit = require("bit")

function getMultipleEnum(keys, all)
	local len = #keys

	if len < 1 then
		return
	end

	local res = {}

	if all then
		res[all] = 0
	end

	for i = 1, len do
		local key = keys[i]

		if key ~= all then
			res[key] = bit.lshift(1, i - 1)
		end

		if all then
			res[all] = bit.bor(res[all], res[key])
		end
	end

	return res
end

function commEnum2Multiple(enum)
	local res = {}

	res[0] = 0

	for _, v in pairs(enum) do
		if v ~= 0 then
			res[v] = bit.lshift(1, v)
			res[0] = bit.bor(res[0], res[v])
		end
	end

	return res
end

function getOneMultipleValue(enumValue)
	return bit.lshift(1, enumValue)
end

function multipleEnumContain(disValue, checkValue)
	if not disValue or not checkValue then
		return false
	end

	return bit.band(disValue, checkValue) == checkValue
end

function multipleEnumAdd(disValue, addValue)
	if not disValue or not addValue then
		return 0
	end

	return bit.bor(disValue, addValue)
end

function multipleEnumSub(disValue, subValue)
	if not disValue or not subValue then
		return 0
	end

	if multipleEnumContain(disValue, subValue) then
		return bit.bxor(disValue, subValue)
	end

	return disValue
end

function multipleEnumContainOnZeroAll(disValue, checkValue)
	if not disValue or not checkValue then
		return false
	end

	if disValue == 0 or checkValue == 0 then
		return true
	end

	checkValue = bit.lshift(1, checkValue)

	return bit.band(disValue, checkValue) == checkValue
end

function multipleEnumParseOnZeroAll(disValue, maxValue, isAddZero)
	local res = {}

	if isAddZero then
		table.insert(res, 0)
	end

	for i = 1, maxValue do
		if multipleEnumContainOnZeroAll(disValue, i) then
			table.insert(res, i)
		end
	end

	return res
end

function multipleEnumIs(disValue, checkValue)
	if not disValue or not checkValue then
		return false
	end

	checkValue = bit.lshift(1, checkValue)

	return disValue == checkValue
end
