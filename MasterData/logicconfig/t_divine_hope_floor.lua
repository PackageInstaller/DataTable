-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_hope_floor.lua

module("logicconfig.config.t_divine_hope_floor", package.seeall)

local title = {
	stagePlanId = 7,
	passNeedDesire = 6,
	floorId = 2,
	passNeedHope = 5,
	activityId = 1,
	canUseWish = 4,
	prize = 3
}
local dataList = {
	{
		518001,
		1,
		"4:396:20",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		2,
		2,
		1
	},
	{
		518001,
		2,
		"4:396:30",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		6,
		6,
		2
	},
	{
		518001,
		3,
		"4:396:50",
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		10,
		10,
		3
	}
}
local t_divine_hope_floor = {
	[518001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_hope_floor.dataList = dataList

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

return t_divine_hope_floor
