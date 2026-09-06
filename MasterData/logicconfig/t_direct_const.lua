-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_const.lua

module("logicconfig.config.t_direct_const", package.seeall)

local title = {
	value = 3,
	key = 2,
	activityId = 1
}
local dataList = {
	{
		75001,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		75001,
		"t_direct_key2",
		"无间魔焰·瞳特惠购"
	},
	{
		75001,
		"t_direct_pos1",
		"145291"
	},
	{
		75001,
		"t_direct_pos2",
		"904339"
	},
	{
		75002,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		75002,
		"t_direct_key2",
		"英灵女神·千璃特惠购"
	},
	{
		75002,
		"t_direct_pos1",
		"144654"
	},
	{
		75002,
		"t_direct_pos2",
		"915837"
	},
	{
		75003,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		75003,
		"t_direct_key2",
		"希妮安限时五折"
	},
	{
		75003,
		"t_direct_pos1",
		"144654"
	},
	{
		75003,
		"t_direct_pos2",
		"915837"
	},
	{
		86001,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		86001,
		"t_direct_key2",
		"龙女限时直购"
	},
	{
		86001,
		"t_direct_pos1",
		"147643"
	},
	{
		86001,
		"t_direct_pos2",
		"907804"
	},
	{
		75004,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		75004,
		"t_direct_key2",
		"雅典娜限时直购"
	},
	{
		75004,
		"t_direct_pos1",
		"148169"
	},
	{
		75004,
		"t_direct_pos2",
		"924711"
	},
	{
		86002,
		"t_direct_key1",
		"最强阵极限战力"
	},
	{
		86002,
		"t_direct_key2",
		"辛西娅限时直购"
	},
	{
		86002,
		"t_direct_pos1",
		"140534"
	},
	{
		86002,
		"t_direct_pos2",
		"879591"
	}
}
local t_direct_const = {
	[75001] = {
		t_direct_key1 = dataList[1],
		t_direct_key2 = dataList[2],
		t_direct_pos1 = dataList[3],
		t_direct_pos2 = dataList[4]
	},
	[75002] = {
		t_direct_key1 = dataList[5],
		t_direct_key2 = dataList[6],
		t_direct_pos1 = dataList[7],
		t_direct_pos2 = dataList[8]
	},
	[75003] = {
		t_direct_key1 = dataList[9],
		t_direct_key2 = dataList[10],
		t_direct_pos1 = dataList[11],
		t_direct_pos2 = dataList[12]
	},
	[86001] = {
		t_direct_key1 = dataList[13],
		t_direct_key2 = dataList[14],
		t_direct_pos1 = dataList[15],
		t_direct_pos2 = dataList[16]
	},
	[75004] = {
		t_direct_key1 = dataList[17],
		t_direct_key2 = dataList[18],
		t_direct_pos1 = dataList[19],
		t_direct_pos2 = dataList[20]
	},
	[86002] = {
		t_direct_key1 = dataList[21],
		t_direct_key2 = dataList[22],
		t_direct_pos1 = dataList[23],
		t_direct_pos2 = dataList[24]
	}
}

t_direct_const.dataList = dataList

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

return t_direct_const
