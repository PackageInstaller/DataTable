-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_truss_single.lua

module("logicconfig.config.t_pay_truss_single", package.seeall)

local title = {
	isUseRole = 7,
	name = 6,
	isCanTurn = 8,
	payGoodsId = 3,
	mountId = 12,
	gender = 9,
	dressIds = 11,
	giftContent = 4,
	suitIds = 10,
	id = 2,
	originPrice = 5,
	activityId = 1
}
local dataList = {
	{
		27001,
		1,
		"rmb_28",
		"1:11021:-1:1#1:11025:-1:1",
		0,
		"",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27001,
		2,
		"rmb_30",
		"1:11022:-1:1#1:11026:-1:1",
		0,
		"",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27001,
		3,
		"rmb_30",
		"1:11023:-1:1#1:11027:-1:1",
		0,
		"",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27001,
		4,
		"rmb_40",
		"1:11024:-1:1#1:11028:-1:1",
		0,
		"",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27003,
		1,
		"rmb_18",
		"1:92004:-1:1#4:36:6#4:90062:100",
		0,
		"红莲经典神唤礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27003,
		2,
		"rmb_40",
		"1:4000002:-1:1#19:7:1#4:90062:150",
		0,
		"凌云超值中秋礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27004,
		1,
		"rmb_18",
		"4:36:6#4:90062:100#4:10:100",
		0,
		"经典神唤礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27004,
		2,
		"rmb_30",
		"4:90093:1#4:36:2#4:90062:150",
		0,
		"电竞达人礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27005,
		1,
		"rmb_12",
		"1:13001:-1:1#1:13002:-1:1#4:36:2#4:10:100",
		0,
		"心念短发礼包",
		true,
		true,
		2,
		"0:15#1:16",
		"0:13001#1:13002#2:3000001",
		0
	},
	{
		27005,
		2,
		"rmb_18",
		"1:3000001:-1:1#4:36:3#4:90062:150",
		0,
		"茸茸粉尾礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27006,
		1,
		"rmb_30",
		"4:90105:1#4:36:3#4:90062:150",
		0,
		"万圣服饰礼包",
		true,
		true,
		2,
		"0:37#1:38",
		"",
		15
	},
	{
		27006,
		2,
		"rmb_30",
		"4:1015:1#4:36:3#4:90062:150",
		0,
		"万圣坐骑礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27007,
		1,
		"rmb_18",
		"1:12010:-1:1#4:36:3#4:90062:150",
		0,
		"嘟嘟飞鸽礼包",
		true,
		true,
		2,
		"0:23#1:24",
		"2:12010#2:14001",
		0
	},
	{
		27007,
		2,
		"rmb_12",
		"1:14001:-1:1#4:36:2#4:10:100",
		0,
		"雅典娜之冠礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27008,
		1,
		"rmb_30",
		"4:90122:1#4:36:3#4:90062:150",
		0,
		"圣诞之约礼包",
		true,
		true,
		2,
		"0:39#1:40",
		"",
		0
	},
	{
		27008,
		2,
		"rmb_30",
		"1:300020:-1:1#13:71:1#4:36:8",
		0,
		"圣诞雪夜礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27009,
		1,
		"rmb_30",
		"4:90146:1#4:36:3#4:90062:150",
		0,
		"解神之心礼包",
		true,
		true,
		2,
		"0:41#1:42",
		"",
		0
	},
	{
		27009,
		2,
		"rmb_30",
		"13:75:1#14:74:1#4:90089:1",
		0,
		"梨园萦梦礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27010,
		1,
		"rmb_1",
		"4:34:2#104:2:10",
		0,
		"1元秒杀礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27010,
		2,
		"rmb_6",
		"4:90003:1#104:2:60",
		0,
		"6元秒杀礼包",
		false,
		false,
		0,
		"",
		"",
		0
	},
	{
		27010,
		3,
		"rmb_12",
		"4:510061:2#104:2:120",
		0,
		"12元秒杀礼包",
		false,
		false,
		0,
		"",
		"",
		0
	}
}
local t_pay_truss_single = {
	[27001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[27003] = {
		dataList[5],
		dataList[6]
	},
	[27004] = {
		dataList[7],
		dataList[8]
	},
	[27005] = {
		dataList[9],
		dataList[10]
	},
	[27006] = {
		dataList[11],
		dataList[12]
	},
	[27007] = {
		dataList[13],
		dataList[14]
	},
	[27008] = {
		dataList[15],
		dataList[16]
	},
	[27009] = {
		dataList[17],
		dataList[18]
	},
	[27010] = {
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_pay_truss_single.dataList = dataList

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

return t_pay_truss_single
