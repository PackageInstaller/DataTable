-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ranking_match_task.lua

module("logicconfig.config.t_ranking_match_task", package.seeall)

local title = {
	matchType = 3,
	progress = 6,
	type = 2,
	id = 1,
	title = 4,
	prize = 7,
	desc = 5
}
local dataList = {
	{
		1001,
		1,
		0,
		"胜利",
		"经典场累计获得3次胜利",
		3,
		"8:3:40"
	},
	{
		1002,
		1,
		0,
		"勇往直前",
		"经典场累计战斗5次",
		5,
		"8:3:40"
	},
	{
		1003,
		1,
		0,
		"碾压",
		"经典场获胜时比分差距达3以上，累计1次",
		1,
		"8:3:40"
	},
	{
		1004,
		1,
		0,
		"调兵遣将",
		"经典场全活获胜累计1次",
		1,
		"8:3:40"
	},
	{
		1005,
		1,
		0,
		"连战连捷",
		"经典场获得3连胜，累计1次",
		1,
		"8:3:40"
	},
	{
		1006,
		1,
		1,
		"胜利",
		"极限场累计获得3次胜利",
		3,
		"8:3:40"
	},
	{
		1007,
		1,
		1,
		"勇往直前",
		"极限场累计战斗5次",
		5,
		"8:3:40"
	},
	{
		1008,
		1,
		1,
		"碾压",
		"极限场获胜时比分差距达3以上，累计1次",
		1,
		"8:3:40"
	},
	{
		1009,
		1,
		1,
		"调兵遣将",
		"极限场全活获胜累计1次",
		1,
		"8:3:40"
	},
	{
		1010,
		1,
		1,
		"连战连捷",
		"极限场获得3连胜，累计1次",
		1,
		"8:3:40"
	},
	{
		2001,
		2,
		0,
		"胜者为王",
		"经典场累计获得15次胜利",
		15,
		"8:3:60"
	},
	{
		2002,
		2,
		0,
		"战意",
		"经典场累计战斗30次",
		30,
		"8:3:60"
	},
	{
		2003,
		2,
		0,
		"碾碎",
		"经典场获胜时比分差距达3以上，累计15次",
		15,
		"8:3:60"
	},
	{
		2004,
		2,
		0,
		"掌控乾坤",
		"经典场全活获胜累计15次",
		15,
		"8:3:60"
	},
	{
		2005,
		2,
		0,
		"屡战屡胜",
		"经典场获得3连胜，累计10次",
		10,
		"8:3:60"
	},
	{
		2006,
		2,
		1,
		"胜者为王",
		"极限场累计获得15次胜利",
		15,
		"8:3:60"
	},
	{
		2007,
		2,
		1,
		"战意",
		"极限场累计战斗30次",
		30,
		"8:3:60"
	},
	{
		2008,
		2,
		1,
		"碾碎",
		"极限场获胜时比分差距达3以上，累计15次",
		15,
		"8:3:60"
	},
	{
		2009,
		2,
		1,
		"掌控乾坤",
		"极限场全活获胜累计15次",
		15,
		"8:3:60"
	},
	{
		2010,
		2,
		1,
		"屡战屡胜",
		"极限场获得3连胜，累计10次",
		10,
		"8:3:60"
	}
}
local t_ranking_match_task = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[1010] = dataList[10],
	[2001] = dataList[11],
	[2002] = dataList[12],
	[2003] = dataList[13],
	[2004] = dataList[14],
	[2005] = dataList[15],
	[2006] = dataList[16],
	[2007] = dataList[17],
	[2008] = dataList[18],
	[2009] = dataList[19],
	[2010] = dataList[20]
}

t_ranking_match_task.dataList = dataList

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

return t_ranking_match_task
