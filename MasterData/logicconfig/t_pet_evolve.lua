-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_evolve.lua

module("logicconfig.config.t_pet_evolve", package.seeall)

local title = {
	raceId = 1,
	cost = 3,
	newRaceId = 2
}
local dataList = {
	{
		10005,
		10004,
		"8:1:1000"
	},
	{
		10344,
		10338,
		"4:6002:1"
	},
	{
		10344,
		10339,
		"4:6003:1"
	},
	{
		10344,
		10343,
		"4:6001:1"
	},
	{
		10142,
		11006,
		"4:6001:1"
	},
	{
		10144,
		13003,
		"4:6001:1"
	}
}
local t_pet_evolve = {
	[10005] = {
		[10004] = dataList[1]
	},
	[10344] = {
		[10338] = dataList[2],
		[10339] = dataList[3],
		[10343] = dataList[4]
	},
	[10142] = {
		[11006] = dataList[5]
	},
	[10144] = {
		[13003] = dataList[6]
	}
}

t_pet_evolve.dataList = dataList

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

return t_pet_evolve
