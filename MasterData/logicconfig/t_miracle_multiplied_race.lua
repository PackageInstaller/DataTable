-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_multiplied_race.lua

module("logicconfig.config.t_miracle_multiplied_race", package.seeall)

local title = {
	activityId = 1,
	raceId = 2
}
local dataList = {
	{
		380001,
		16025
	},
	{
		380001,
		12022
	},
	{
		380001,
		14025
	},
	{
		380001,
		13019
	},
	{
		380001,
		11024
	},
	{
		380001,
		15025
	}
}
local t_miracle_multiplied_race = {
	[380001] = {
		[16025] = dataList[1],
		[12022] = dataList[2],
		[14025] = dataList[3],
		[13019] = dataList[4],
		[11024] = dataList[5],
		[15025] = dataList[6]
	}
}

t_miracle_multiplied_race.dataList = dataList

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

return t_miracle_multiplied_race
