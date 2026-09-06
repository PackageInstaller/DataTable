-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_role.lua

module("logicconfig.config.t_making_moon_cake_role", package.seeall)

local title = {
	prize = 5,
	progressPlanId = 3,
	roleId = 2,
	activityId = 1,
	needScore = 4
}
local dataList = {
	{
		68007,
		1,
		1,
		1000000,
		"60:1:600"
	},
	{
		68007,
		2,
		2,
		1000000,
		"8:1:1000000"
	},
	{
		68007,
		3,
		3,
		1000000,
		"60:1:600"
	},
	{
		68007,
		4,
		4,
		1000000,
		"8:1:1000000"
	}
}
local t_making_moon_cake_role = {
	[68007] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_making_moon_cake_role.dataList = dataList

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

return t_making_moon_cake_role
