-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chop_king_against_two_clg.lua

module("logicconfig.config.t_chop_king_against_two_clg", package.seeall)

local title = {
	stageId = 2,
	enemyA = 3,
	activeScorePlanId = 5,
	activityId = 1,
	enemyB = 4
}
local dataList = {
	{
		470001,
		1,
		4001,
		4002,
		2
	},
	{
		470001,
		2,
		4003,
		4004,
		2
	},
	{
		470001,
		3,
		4005,
		4006,
		2
	},
	{
		470001,
		4,
		4007,
		4008,
		2
	},
	{
		470001,
		5,
		4009,
		4010,
		2
	},
	{
		470001,
		6,
		4011,
		4012,
		2
	},
	{
		470001,
		7,
		4013,
		4014,
		2
	},
	{
		470001,
		8,
		4015,
		4016,
		2
	},
	{
		470001,
		9,
		4017,
		4018,
		2
	},
	{
		470001,
		10,
		4019,
		4020,
		2
	}
}
local t_chop_king_against_two_clg = {
	[470001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_chop_king_against_two_clg.dataList = dataList

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

return t_chop_king_against_two_clg
