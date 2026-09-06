-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_knife.lua

module("logicconfig.config.t_dark_dragon_knife", package.seeall)

local title = {
	prizePlan = 4,
	propPlanId = 5,
	buyGameTimesPlan = 2,
	gameId = 6,
	redPointId = 7,
	activityId = 1,
	scorePlan = 3
}
local dataList = {
	{
		58001,
		1,
		1,
		1,
		1,
		1,
		137
	},
	{
		58002,
		1,
		1,
		2,
		2,
		2,
		137
	},
	{
		58003,
		1,
		1,
		3,
		3,
		3,
		137
	},
	{
		58004,
		1,
		1,
		4,
		4,
		4,
		477
	},
	{
		58005,
		1,
		1,
		5,
		5,
		5,
		477
	}
}
local t_dark_dragon_knife = {
	[58001] = dataList[1],
	[58002] = dataList[2],
	[58003] = dataList[3],
	[58004] = dataList[4],
	[58005] = dataList[5]
}

t_dark_dragon_knife.dataList = dataList

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

return t_dark_dragon_knife
