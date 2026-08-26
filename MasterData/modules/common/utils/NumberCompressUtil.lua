-- chunkname: @modules/common/utils/NumberCompressUtil.lua

module("modules.common.utils.NumberCompressUtil", package.seeall)

local NumberCompressUtil = {}
local bit = require("bit")
local dict = {
	"0",
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"H",
	"I",
	"J",
	"K",
	"L",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
	"-",
	"/"
}
local dictToIndex = {}

for k, v in pairs(dict) do
	dictToIndex[v] = k
end

function NumberCompressUtil.compress(list)
	local compressStrs = {}

	for i, num in ipairs(list) do
		compressStrs[i] = NumberCompressUtil.numToStr(num)
	end

	return table.concat(compressStrs, "#")
end

function NumberCompressUtil.decompress(str)
	local arr = string.split(str, "#")
	local newIds = {}

	for _, s in ipairs(arr) do
		local num = NumberCompressUtil.strToNum(s)

		if num ~= 0 then
			table.insert(newIds, num)
		end
	end

	return newIds
end

function NumberCompressUtil.numToStr(num)
	if type(num) ~= "number" then
		return ""
	end

	local str = ""

	while num > 0 do
		local remainder = bit.band(num, 63)

		if not dict[remainder + 1] then
			logError("NumberCompressUtil.numToStr Error:" .. tostring(remainder))

			return ""
		end

		str = dict[remainder + 1] .. str
		num = bit.rshift(num, 6)
	end

	return str
end

function NumberCompressUtil.strToNum(str)
	if string.nilorempty(str) then
		return 0
	end

	local strLen = #str
	local id = 0

	for i = 1, strLen do
		local c = string.sub(str, i, i)

		if not dictToIndex[c] then
			logError("NumberCompressUtil.strToNum Error：" .. tostring(str))

			return 0
		end

		id = id + bit.lshift(dictToIndex[c] - 1, (strLen - i) * 6)
	end

	return id
end

return NumberCompressUtil
