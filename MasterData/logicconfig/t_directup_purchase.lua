-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_directup_purchase.lua

module("logicconfig.config.t_directup_purchase", package.seeall)

local title = {
	id = 2,
	shopItemId = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		60003,
		1,
		12012,
		"火属性传说之魂"
	},
	{
		60003,
		2,
		12013,
		"潜能满级礼包"
	},
	{
		60003,
		3,
		12014,
		"橙+1全套 星神全套"
	},
	{
		60004,
		1,
		12015,
		"传说之魂自选"
	},
	{
		60004,
		2,
		12016,
		"潜能满级礼包"
	},
	{
		60004,
		3,
		12017,
		"橙+1全套 星神全套"
	},
	{
		60005,
		1,
		12028,
		"火属性传说之魂"
	},
	{
		60005,
		2,
		12023,
		"潜能满级礼包"
	},
	{
		60005,
		3,
		12029,
		"火系橙+1全套 星神全套"
	},
	{
		60006,
		1,
		12033,
		"水属性传说之魂"
	},
	{
		60006,
		2,
		12034,
		"潜能满级礼包"
	},
	{
		60006,
		3,
		12035,
		"水系橙+1全套 星神全套"
	},
	{
		60007,
		1,
		12041,
		"光属性传说之魂"
	},
	{
		60007,
		2,
		12042,
		"潜能满级礼包"
	},
	{
		60007,
		3,
		12043,
		"光系橙+1全套 星神全套"
	},
	{
		60008,
		1,
		12045,
		"光属性传说之魂"
	},
	{
		60008,
		2,
		12046,
		"潜能满级礼包"
	},
	{
		60008,
		3,
		12047,
		"光系橙+1全套 星神全套"
	}
}
local t_directup_purchase = {
	[60003] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[60004] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[60005] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[60006] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[60007] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[60008] = {
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_directup_purchase.dataList = dataList

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

return t_directup_purchase
