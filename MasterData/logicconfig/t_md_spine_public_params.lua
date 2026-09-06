-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_md_spine_public_params.lua

module("logicconfig.config.t_md_spine_public_params", package.seeall)

local title = {
	publicParamId = 2,
	min = 4,
	dataType = 3,
	skinPlanId = 1,
	max = 5
}
local dataList = {
	{
		1101103,
		1,
		"int",
		"1",
		"100"
	},
	{
		1101103,
		2,
		"bool",
		"",
		""
	},
	{
		1100203,
		1,
		"int",
		"1",
		"100"
	},
	{
		1100203,
		2,
		"bool",
		"",
		""
	},
	{
		1800102,
		1,
		"bool",
		"",
		""
	},
	{
		1800102,
		2,
		"bool",
		"",
		""
	},
	{
		1602606,
		1,
		"int",
		"1",
		"3"
	},
	{
		1602607,
		1,
		"int",
		"1",
		"3"
	},
	{
		1600106,
		1,
		"int",
		"1",
		"3"
	},
	{
		1600107,
		1,
		"int",
		"1",
		"3"
	},
	{
		1503201,
		1,
		"int",
		"1",
		"100"
	},
	{
		1503201,
		2,
		"int",
		"1",
		"3"
	},
	{
		1603404,
		1,
		"int",
		"1",
		"2"
	},
	{
		1603405,
		1,
		"int",
		"1",
		"2"
	},
	{
		1601604,
		1,
		"int",
		"1",
		"2"
	},
	{
		1601605,
		1,
		"int",
		"1",
		"2"
	},
	{
		1603202,
		1,
		"int",
		"1",
		"4"
	},
	{
		1600502,
		1,
		"int",
		"1",
		"4"
	},
	{
		1802103,
		1,
		"trigger",
		"",
		""
	},
	{
		1802103,
		2,
		"trigger",
		"",
		""
	},
	{
		1601003,
		1,
		"bool",
		"",
		""
	},
	{
		1604003,
		1,
		"bool",
		"",
		""
	},
	{
		1403803,
		1,
		"bool",
		"",
		""
	},
	{
		1803101,
		1,
		"int",
		"",
		""
	},
	{
		1202105000,
		1,
		"int",
		"",
		""
	},
	{
		1103704,
		1,
		"int",
		"",
		""
	},
	{
		1103704,
		2,
		"int",
		"",
		""
	},
	{
		1702701,
		1,
		"int",
		"",
		""
	},
	{
		1802104,
		1,
		"int",
		"",
		""
	},
	{
		1802104,
		2,
		"int",
		"",
		""
	},
	{
		1802104,
		3,
		"int",
		"",
		""
	},
	{
		1802104,
		4,
		"int",
		"",
		""
	},
	{
		1802104,
		5,
		"int",
		"",
		""
	}
}
local t_md_spine_public_params = {
	[1101103] = {
		dataList[1],
		dataList[2]
	},
	[1100203] = {
		dataList[3],
		dataList[4]
	},
	[1800102] = {
		dataList[5],
		dataList[6]
	},
	[1602606] = {
		dataList[7]
	},
	[1602607] = {
		dataList[8]
	},
	[1600106] = {
		dataList[9]
	},
	[1600107] = {
		dataList[10]
	},
	[1503201] = {
		dataList[11],
		dataList[12]
	},
	[1603404] = {
		dataList[13]
	},
	[1603405] = {
		dataList[14]
	},
	[1601604] = {
		dataList[15]
	},
	[1601605] = {
		dataList[16]
	},
	[1603202] = {
		dataList[17]
	},
	[1600502] = {
		dataList[18]
	},
	[1802103] = {
		dataList[19],
		dataList[20]
	},
	[1601003] = {
		dataList[21]
	},
	[1604003] = {
		dataList[22]
	},
	[1403803] = {
		dataList[23]
	},
	[1803101] = {
		dataList[24]
	},
	[1202105000] = {
		dataList[25]
	},
	[1103704] = {
		dataList[26],
		dataList[27]
	},
	[1702701] = {
		dataList[28]
	},
	[1802104] = {
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33]
	}
}

t_md_spine_public_params.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_md_spine_public_params
