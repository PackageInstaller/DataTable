-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_domain_adventure_game_event.lua

module("logicconfig.config.t_domain_adventure_game_event", package.seeall)

local title = {
	stagePlanId = 4,
	skinId = 5,
	prizePlanId = 3,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		402001,
		4001,
		3,
		1,
		14023
	},
	{
		402001,
		4002,
		3,
		1,
		14024
	},
	{
		402001,
		4003,
		3,
		1,
		12020
	},
	{
		402001,
		4004,
		3,
		1,
		12021
	},
	{
		402001,
		4005,
		3,
		1,
		14013
	},
	{
		402001,
		4006,
		3,
		2,
		13008
	},
	{
		402001,
		4007,
		3,
		2,
		14023
	},
	{
		402001,
		4008,
		3,
		2,
		11020
	},
	{
		402001,
		4009,
		3,
		2,
		11019
	},
	{
		402001,
		4010,
		3,
		2,
		11021
	},
	{
		402001,
		4011,
		3,
		2,
		11023
	},
	{
		402001,
		4012,
		3,
		2,
		16024
	},
	{
		402001,
		4013,
		3,
		2,
		11021
	},
	{
		402001,
		4014,
		3,
		2,
		11023
	},
	{
		402001,
		4015,
		3,
		2,
		16024
	}
}
local t_domain_adventure_game_event = {
	[402001] = {
		[4001] = dataList[1],
		[4002] = dataList[2],
		[4003] = dataList[3],
		[4004] = dataList[4],
		[4005] = dataList[5],
		[4006] = dataList[6],
		[4007] = dataList[7],
		[4008] = dataList[8],
		[4009] = dataList[9],
		[4010] = dataList[10],
		[4011] = dataList[11],
		[4012] = dataList[12],
		[4013] = dataList[13],
		[4014] = dataList[14],
		[4015] = dataList[15]
	}
}

t_domain_adventure_game_event.dataList = dataList

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

return t_domain_adventure_game_event
