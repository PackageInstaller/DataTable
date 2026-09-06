-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_relation_power_task.lua

module("logicconfig.config.t_relation_power_task", package.seeall)

local title = {
	taskParam = 5,
	task = 3,
	prize = 6,
	type = 4,
	activityId = 1,
	taskId = 2
}
local dataList = {
	{
		354001,
		1,
		"收集神曜梦之队",
		"collect",
		"1",
		"4:510196:2"
	},
	{
		354001,
		2,
		"验证神曜梦之队\r\n战力达到150000战力",
		"verify",
		"1",
		"4:90400:1"
	},
	{
		354001,
		3,
		"收集万物归元·极&神\r\n曜五王&五王",
		"collect",
		"2",
		"4:510287:1"
	},
	{
		354001,
		4,
		"验证万物归元·极&神曜\r\n五王队达到150000战力",
		"verify",
		"3",
		"4:70021:1"
	},
	{
		354001,
		5,
		"验证万物归元·极&五王\r\n队达到150000战力",
		"verify",
		"4",
		"4:70023:1"
	},
	{
		354002,
		1,
		"收集神曜诺雅全民阵",
		"collect",
		"1",
		"4:90097:1"
	},
	{
		354002,
		2,
		"收集神曜诺雅最强阵",
		"collect",
		"2",
		"29:16:1"
	},
	{
		354002,
		3,
		"验证神曜诺雅最强阵达到420000战力",
		"verify",
		"2",
		"2:184:1"
	},
	{
		354003,
		1,
		"收集昆仑全民阵",
		"collect",
		"1",
		"4:90090:1"
	},
	{
		354003,
		2,
		"收集神曜昆仑阵",
		"collect",
		"2",
		"29:25:1"
	},
	{
		354003,
		3,
		"验证神曜昆仑阵达到420000战力",
		"verify",
		"2",
		"2:222:1"
	},
	{
		354004,
		1,
		"收集伏妖全民阵",
		"collect",
		"1",
		"4:70021:1"
	},
	{
		354004,
		2,
		"收集神曜伏妖阵",
		"collect",
		"2",
		"29:30:1"
	},
	{
		354004,
		3,
		"验证神曜伏妖阵达到350000战力",
		"verify",
		"3",
		"2:239:1"
	},
	{
		354005,
		1,
		"收集全民诺雅阵",
		"collect",
		"1",
		"4:400004:15"
	},
	{
		354005,
		2,
		"收集最强诺雅阵",
		"collect",
		"2",
		"13:490:1"
	},
	{
		354005,
		3,
		"验证最强诺雅阵达到\r\n600000战力",
		"verify",
		"2",
		"2:264:1"
	},
	{
		354006,
		1,
		"收集全民通灵极阵",
		"collect",
		"1",
		"4:400004:15"
	},
	{
		354006,
		2,
		"收集最强通灵极阵",
		"collect",
		"2",
		"2:268:1"
	},
	{
		354006,
		3,
		"验证最强通灵极阵达到\r\n600000战力",
		"verify",
		"2",
		"13:491:1"
	},
	{
		354007,
		1,
		"收集全民究阵",
		"collect",
		"1",
		"4:400004:15"
	},
	{
		354007,
		2,
		"收集最强究阵",
		"collect",
		"2",
		"13:550:1"
	},
	{
		354007,
		3,
		"验证最强究阵达到\r\n600000战力",
		"verify",
		"2",
		"2:297:1"
	},
	{
		354008,
		1,
		"收集全民暗阵",
		"collect",
		"1",
		"4:400004:15"
	},
	{
		354008,
		2,
		"收集最强暗阵",
		"collect",
		"2",
		"13:561:1"
	},
	{
		354008,
		3,
		"验证最强暗阵达到\r\n600000战力",
		"verify",
		"2",
		"2:310:1"
	},
	{
		354009,
		1,
		"收集全民尘阵",
		"collect",
		"1",
		"4:400004:15"
	},
	{
		354009,
		2,
		"收集最强尘阵",
		"collect",
		"2",
		"13:591:1"
	},
	{
		354009,
		3,
		"验证最强尘阵达到\r\n600000战力",
		"verify",
		"2",
		"2:331:1"
	}
}
local t_relation_power_task = {
	[354001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[354002] = {
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[354003] = {
		dataList[9],
		dataList[10],
		dataList[11]
	},
	[354004] = {
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[354005] = {
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[354006] = {
		dataList[18],
		dataList[19],
		dataList[20]
	},
	[354007] = {
		dataList[21],
		dataList[22],
		dataList[23]
	},
	[354008] = {
		dataList[24],
		dataList[25],
		dataList[26]
	},
	[354009] = {
		dataList[27],
		dataList[28],
		dataList[29]
	}
}

t_relation_power_task.dataList = dataList

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

return t_relation_power_task
