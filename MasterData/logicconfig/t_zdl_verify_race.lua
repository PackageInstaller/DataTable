-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zdl_verify_race.lua

module("logicconfig.config.t_zdl_verify_race", package.seeall)

local title = {
	zdl = 4,
	verifyId = 2,
	raceId = 3,
	activityId = 1,
	unlockTime = 5
}
local dataList = {
	{
		614001,
		1,
		14046,
		180000
	},
	{
		614001,
		2,
		14047,
		180000
	},
	{
		614001,
		3,
		14049,
		180000
	},
	{
		614001,
		4,
		15051,
		180000,
		"2026-07-24T05:00:00"
	}
}
local t_zdl_verify_race = {
	[614001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_zdl_verify_race.dataList = dataList

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

return t_zdl_verify_race
