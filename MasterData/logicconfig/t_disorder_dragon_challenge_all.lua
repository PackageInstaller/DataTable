-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_dragon_challenge_all.lua

module("logicconfig.config.t_disorder_dragon_challenge_all", package.seeall)

local title = {
	challengeId = 2,
	winPrize = 4,
	defeatPrize = 5,
	creepsMasterId = 3,
	allPlanId = 1
}
local dataList = {
	{
		1,
		1,
		101,
		"4:178:1",
		""
	},
	{
		1,
		2,
		102,
		"4:178:1",
		""
	},
	{
		1,
		3,
		103,
		"4:178:1",
		""
	},
	{
		1,
		4,
		104,
		"4:178:1",
		""
	},
	{
		1,
		5,
		105,
		"4:178:1",
		""
	},
	{
		1,
		6,
		106,
		"4:178:1",
		""
	},
	{
		1,
		7,
		107,
		"4:178:1",
		""
	},
	{
		1,
		8,
		108,
		"4:178:1",
		""
	},
	{
		1,
		9,
		109,
		"4:178:1",
		""
	},
	{
		1,
		10,
		110,
		"4:178:1",
		""
	},
	{
		1,
		11,
		111,
		"4:178:1",
		""
	},
	{
		1,
		12,
		112,
		"4:178:1",
		""
	},
	{
		1,
		13,
		113,
		"4:178:1",
		""
	},
	{
		1,
		14,
		114,
		"4:178:1",
		""
	},
	{
		1,
		15,
		115,
		"4:178:1",
		""
	},
	{
		1,
		16,
		116,
		"4:178:1",
		""
	},
	{
		1,
		17,
		117,
		"4:178:1",
		""
	},
	{
		1,
		18,
		118,
		"4:178:1",
		""
	},
	{
		1,
		19,
		119,
		"4:178:1",
		""
	},
	{
		1,
		20,
		120,
		"4:178:1",
		""
	}
}
local t_disorder_dragon_challenge_all = {
	{
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
		dataList[20]
	}
}

t_disorder_dragon_challenge_all.dataList = dataList

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

return t_disorder_dragon_challenge_all
