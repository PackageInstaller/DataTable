-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_boss.lua

module("logicconfig.config.t_god_aruishi_challenge_boss", package.seeall)

local title = {
	bossId = 2,
	challengeId = 1,
	bossCreepsMasterId = 3,
	supportPetId = 4
}
local dataList = {
	{
		47,
		1,
		4001,
		1000004001
	},
	{
		47,
		2,
		4002,
		1000004002
	},
	{
		47,
		3,
		4003,
		1000004003
	},
	{
		47,
		4,
		4004,
		1000004004
	},
	{
		47,
		5,
		4005,
		1000004005
	},
	{
		50,
		1,
		4001,
		1000004001
	},
	{
		50,
		2,
		4002,
		1000004002
	},
	{
		50,
		3,
		4003,
		1000004003
	},
	{
		50,
		4,
		4004,
		1000004004
	},
	{
		50,
		5,
		4005,
		1000004005
	}
}
local t_god_aruishi_challenge_boss = {
	[47] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[50] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_god_aruishi_challenge_boss.dataList = dataList

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

return t_god_aruishi_challenge_boss
