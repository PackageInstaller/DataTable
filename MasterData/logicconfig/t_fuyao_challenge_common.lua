-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_challenge_common.lua

module("logicconfig.config.t_fuyao_challenge_common", package.seeall)

local title = {
	prize = 4,
	name = 5,
	creepsMasterId = 3,
	activityId = 1,
	puzzleId = 2
}
local dataList = {
	{
		272001,
		1,
		101,
		"4:191:4#8:1:500000",
		"伏"
	},
	{
		272001,
		2,
		102,
		"4:191:4#8:1:500000",
		"妖"
	},
	{
		272001,
		3,
		103,
		"4:191:4#4:40008:1",
		"镇"
	},
	{
		272001,
		4,
		104,
		"4:191:4#4:40008:1",
		"魔"
	},
	{
		272001,
		5,
		105,
		"4:191:2#4:30006:20",
		"卦"
	},
	{
		272001,
		6,
		106,
		"4:191:2#4:30006:20",
		"阵"
	},
	{
		272002,
		1,
		101,
		"8:1:1000",
		"伏"
	},
	{
		272002,
		2,
		102,
		"8:1:1000",
		"妖"
	},
	{
		272002,
		3,
		103,
		"8:1:1000",
		"镇"
	},
	{
		272002,
		4,
		104,
		"8:1:1000",
		"魔"
	},
	{
		272002,
		5,
		105,
		"8:1:1000",
		"卦"
	},
	{
		272002,
		6,
		106,
		"8:1:1000",
		"阵"
	}
}
local t_fuyao_challenge_common = {
	[272001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[272002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_fuyao_challenge_common.dataList = dataList

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

return t_fuyao_challenge_common
