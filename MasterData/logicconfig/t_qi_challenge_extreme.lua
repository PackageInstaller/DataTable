-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qi_challenge_extreme.lua

module("logicconfig.config.t_qi_challenge_extreme", package.seeall)

local title = {
	challengeId = 2,
	creepsMasterId = 3,
	prize = 4,
	extremePlanId = 1
}
local dataList = {
	{
		1,
		1,
		101,
		"4:165:6"
	},
	{
		1,
		2,
		102,
		"4:165:6"
	},
	{
		1,
		3,
		103,
		"4:165:6"
	},
	{
		1,
		4,
		104,
		"4:165:6"
	},
	{
		1,
		5,
		105,
		"4:165:6"
	},
	{
		1,
		6,
		106,
		"4:165:6"
	},
	{
		1,
		7,
		107,
		"4:165:6"
	},
	{
		1,
		8,
		108,
		"4:165:6"
	},
	{
		1,
		9,
		109,
		"4:165:6"
	},
	{
		1,
		10,
		110,
		"4:165:6"
	},
	{
		1,
		11,
		111,
		"4:165:6"
	},
	{
		1,
		12,
		112,
		"4:165:6"
	},
	{
		1,
		13,
		113,
		"4:165:6"
	},
	{
		1,
		14,
		114,
		"4:165:6"
	},
	{
		1,
		15,
		115,
		"4:165:6"
	}
}
local t_qi_challenge_extreme = {
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
		dataList[15]
	}
}

t_qi_challenge_extreme.dataList = dataList

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

return t_qi_challenge_extreme
