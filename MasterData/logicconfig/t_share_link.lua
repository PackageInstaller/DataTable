-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_link.lua

module("logicconfig.config.t_share_link", package.seeall)

local title = {
	id = 1,
	startTime = 6,
	endTime = 7,
	url = 2,
	limitTimes = 4,
	reportBehavior = 8,
	prize = 5,
	periodType = 3
}
local dataList = {
	{
		1,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"daily",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2080-10-01T05:00:00",
		0
	},
	{
		2,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2020-11-04T05:00:00",
		0
	},
	{
		3,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		4,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:20",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		5,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:20",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		6,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:20",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		7,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:20",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		8,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:20",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		9,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"1:14003:-1:1#1:14004:-1:1",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		10,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		11,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:100",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201146
	},
	{
		12,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:100",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201147
	},
	{
		13,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:100",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201148
	},
	{
		14,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2021-11-04T05:00:00",
		0
	},
	{
		15,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:50",
		"2020-08-01T05:00:00",
		"2021-11-04T05:00:00",
		0
	},
	{
		16,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:150",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201149
	},
	{
		17,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:150",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201150
	},
	{
		18,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		1,
		"104:2:150",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		201151
	},
	{
		19,
		"https://www.bilibili.com/opus/1154353210531512326?spm_id_from=333.1387.0.0",
		"allTime",
		0,
		"104:2:188",
		"2020-08-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		20,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		0,
		"104:2:150",
		"2026-04-01T05:00:00",
		"2029-11-04T05:00:00",
		0
	},
	{
		21,
		"http://aqsy.100bt.com/zt-share/m/?fromAct=fenxiang",
		"allTime",
		0,
		"104:2:500#60:1:5000#4:36:10",
		"2026-04-03T05:00:00",
		"2026-04-30T05:00:00",
		0
	}
}
local t_share_link = {
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
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_share_link.dataList = dataList

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

return t_share_link
