-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_2048_sup_stage.lua

module("logicconfig.config.t_game_2048_sup_stage", package.seeall)

local title = {
	index = 2,
	mapId = 4,
	skinId = 5,
	gbId = 3,
	activityId = 1
}
local dataList = {
	{
		320004,
		1,
		2,
		21,
		10140
	},
	{
		320004,
		2,
		4,
		22,
		10145
	},
	{
		320004,
		3,
		6,
		23,
		1014501
	},
	{
		320004,
		4,
		8,
		24,
		1014502
	},
	{
		320004,
		5,
		10,
		25,
		1014503
	},
	{
		320004,
		6,
		12,
		26,
		1401804
	},
	{
		320004,
		7,
		14,
		27,
		1401805
	},
	{
		320004,
		8,
		16,
		28,
		14005
	},
	{
		320004,
		9,
		18,
		29,
		14006
	},
	{
		320004,
		10,
		20,
		30,
		1400601
	},
	{
		320004,
		11,
		22,
		31,
		17009
	},
	{
		320004,
		12,
		24,
		32,
		14018
	},
	{
		320004,
		13,
		26,
		33,
		14025
	},
	{
		320004,
		14,
		28,
		34,
		14030
	},
	{
		320004,
		15,
		30,
		35,
		16028
	},
	{
		320005,
		1,
		2,
		21,
		10001
	},
	{
		320005,
		2,
		4,
		22,
		10002
	},
	{
		320005,
		3,
		6,
		23,
		10003
	},
	{
		320005,
		4,
		8,
		24,
		10158
	},
	{
		320005,
		5,
		10,
		25,
		10137
	},
	{
		320005,
		6,
		12,
		26,
		10138
	},
	{
		320005,
		7,
		14,
		27,
		10141
	},
	{
		320005,
		8,
		16,
		28,
		10139
	},
	{
		320005,
		9,
		18,
		29,
		10092
	},
	{
		320005,
		10,
		20,
		30,
		14002
	},
	{
		320005,
		11,
		22,
		31,
		10140
	},
	{
		320005,
		12,
		24,
		32,
		10282
	},
	{
		320005,
		13,
		26,
		33,
		10283
	},
	{
		320005,
		14,
		28,
		34,
		10284
	},
	{
		320005,
		15,
		30,
		35,
		10285
	}
}
local t_game_2048_sup_stage = {
	[320004] = {
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
		dataList[15]
	},
	[320005] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_game_2048_sup_stage.dataList = dataList

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

return t_game_2048_sup_stage
