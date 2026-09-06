-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_boss.lua

module("logicconfig.config.t_sky_peak_boss", package.seeall)

local title = {
	bossId = 2,
	supportPetPlanId = 6,
	limitSupportPetPlanId = 7,
	title = 10,
	preStageId = 3,
	buffScore = 8,
	fmtTips = 9,
	creepsMasterId = 5,
	activityId = 1,
	unlockTime = 4
}
local dataList = {
	{
		592001,
		1,
		5,
		"2026-04-30T05:00:00",
		2001,
		1,
		0,
		30,
		"",
		"予夺天殛·安"
	},
	{
		592001,
		2,
		10,
		"2026-04-30T05:00:00",
		2002,
		1,
		0,
		45,
		"",
		"终时泰坦·时空龙尊"
	},
	{
		592001,
		3,
		15,
		"2026-05-08T05:00:00",
		2003,
		1,
		0,
		30,
		"",
		"暗狱次元·暗天使"
	},
	{
		592001,
		4,
		20,
		"2026-05-08T05:00:00",
		2004,
		1,
		0,
		45,
		"",
		"难明永夜·月影王"
	},
	{
		592001,
		5,
		25,
		"2026-05-15T05:00:00",
		2005,
		1,
		0,
		30,
		"",
		"花语流年·伊丽莎白"
	},
	{
		592001,
		6,
		30,
		"2026-05-15T05:00:00",
		2006,
		1,
		0,
		45,
		"",
		"无尽轮回·正理"
	},
	{
		592001,
		7,
		35,
		"2026-05-22T05:00:00",
		2007,
		1,
		0,
		30,
		"",
		"葬影裁断·修尔"
	},
	{
		592002,
		1,
		5,
		"2026-05-29T05:00:00",
		4001,
		0,
		2,
		40,
		"只可上阵梦之队精灵",
		"祈唤璨星·王者梦梦"
	},
	{
		592002,
		2,
		10,
		"2026-05-29T05:00:00",
		4002,
		0,
		2,
		40,
		"只可上阵梦之队精灵",
		"祈唤璨梦·王者梦梦"
	},
	{
		592002,
		3,
		15,
		"2026-05-29T05:00:00",
		4003,
		0,
		2,
		40,
		"只可上阵梦之队精灵",
		"真理之智·哆啦梦梦"
	},
	{
		592002,
		4,
		20,
		"2026-06-05T05:00:00",
		4004,
		0,
		3,
		40,
		"只可上阵梦之队精灵",
		"幽冥夜刃·暗黑梦梦"
	},
	{
		592002,
		5,
		25,
		"2026-06-05T05:00:00",
		4005,
		0,
		3,
		40,
		"只可上阵梦之队精灵",
		"铸贤翠金·炼金梦梦"
	},
	{
		592002,
		6,
		30,
		"2026-06-05T05:00:00",
		4006,
		0,
		3,
		40,
		"只可上阵梦之队精灵",
		"祈唤璨梦·王者梦梦"
	},
	{
		592002,
		7,
		35,
		"2026-06-12T05:00:00",
		4007,
		0,
		4,
		40,
		"只可上阵梦之队精灵",
		"猛火战狂·热血梦梦"
	},
	{
		592002,
		8,
		40,
		"2026-06-12T05:00:00",
		4008,
		0,
		4,
		40,
		"只可上阵梦之队精灵",
		"真理之智·哆啦梦梦"
	},
	{
		592002,
		9,
		45,
		"2026-06-12T05:00:00",
		4009,
		0,
		4,
		40,
		"只可上阵梦之队精灵",
		"幽冥夜刃·暗黑梦梦"
	},
	{
		592002,
		10,
		50,
		"2026-06-19T05:00:00",
		4010,
		0,
		5,
		40,
		"只可上阵梦之队精灵",
		"心咏成歌·爱心梦梦"
	},
	{
		592002,
		11,
		55,
		"2026-06-19T05:00:00",
		4011,
		0,
		5,
		40,
		"只可上阵梦之队精灵",
		"猛火战狂·热血梦梦"
	}
}
local t_sky_peak_boss = {
	[592001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[592002] = {
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
		dataList[18]
	}
}

t_sky_peak_boss.dataList = dataList

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

return t_sky_peak_boss
