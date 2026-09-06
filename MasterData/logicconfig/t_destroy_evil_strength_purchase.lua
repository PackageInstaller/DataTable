-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_strength_purchase.lua

module("logicconfig.config.t_destroy_evil_strength_purchase", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		322001,
		1,
		"10:322004:1"
	},
	{
		322001,
		2,
		"10:322004:1"
	},
	{
		322001,
		3,
		"10:322004:1"
	},
	{
		322001,
		4,
		"10:322004:1"
	},
	{
		322001,
		5,
		"10:322004:1"
	},
	{
		322001,
		6,
		"10:322004:1"
	},
	{
		322001,
		7,
		"10:322004:1"
	},
	{
		322001,
		8,
		"10:322004:1"
	},
	{
		322001,
		9,
		"10:322004:1"
	},
	{
		322001,
		10,
		"10:322004:1"
	},
	{
		322001,
		11,
		"10:322004:1"
	},
	{
		322001,
		12,
		"10:322004:1"
	},
	{
		322001,
		13,
		"10:322004:1"
	},
	{
		322001,
		14,
		"10:322004:1"
	},
	{
		322001,
		15,
		"10:322004:1"
	},
	{
		322001,
		16,
		"10:322004:1"
	},
	{
		322002,
		1,
		"10:322008:1"
	},
	{
		322002,
		2,
		"10:322008:1"
	},
	{
		322002,
		3,
		"10:322008:1"
	},
	{
		322002,
		4,
		"10:322008:1"
	},
	{
		322002,
		5,
		"10:322008:1"
	},
	{
		322002,
		6,
		"10:322008:1"
	},
	{
		322002,
		7,
		"10:322008:1"
	},
	{
		322002,
		8,
		"10:322008:1"
	},
	{
		322002,
		9,
		"10:322008:1"
	},
	{
		322002,
		10,
		"10:322008:1"
	},
	{
		322003,
		1,
		"10:322012:1"
	},
	{
		322003,
		2,
		"10:322012:1"
	},
	{
		322003,
		3,
		"10:322012:1"
	},
	{
		322003,
		4,
		"10:322012:1"
	},
	{
		322003,
		5,
		"10:322012:1"
	},
	{
		322003,
		6,
		"10:322012:1"
	},
	{
		322003,
		7,
		"10:322012:1"
	},
	{
		322003,
		8,
		"10:322012:1"
	},
	{
		322003,
		9,
		"10:322012:1"
	},
	{
		322003,
		10,
		"10:322012:1"
	}
}
local t_destroy_evil_strength_purchase = {
	[322001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	[322002] = {
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	},
	[322003] = {
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30],
		dataList[31],
		dataList[32],
		dataList[33],
		dataList[34],
		dataList[35],
		dataList[36]
	}
}

t_destroy_evil_strength_purchase.dataList = dataList

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

return t_destroy_evil_strength_purchase
