-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake.lua

module("logicconfig.config.t_making_moon_cake", package.seeall)

local title = {
	buyTimesPlanId = 2,
	cumulativePrizePlanId = 3,
	activityId = 1,
	storyId = 5,
	weekMax = 4
}
local dataList = {
	{
		68001,
		1,
		1,
		500,
		0
	},
	{
		68002,
		0,
		2,
		1600,
		0
	},
	{
		68003,
		0,
		3,
		360,
		0
	},
	{
		68004,
		0,
		4,
		1000,
		0
	},
	{
		68005,
		0,
		5,
		1200,
		0
	},
	{
		68006,
		0,
		6,
		1000,
		4600005
	},
	{
		68007,
		0,
		7,
		1000,
		0
	}
}
local t_making_moon_cake = {
	[68001] = dataList[1],
	[68002] = dataList[2],
	[68003] = dataList[3],
	[68004] = dataList[4],
	[68005] = dataList[5],
	[68006] = dataList[6],
	[68007] = dataList[7]
}

t_making_moon_cake.dataList = dataList

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

return t_making_moon_cake
