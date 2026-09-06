-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_guest.lua

module("logicconfig.config.t_anchor_simulator_guest", package.seeall)

local title = {
	skinId = 3,
	unlockLevel = 6,
	propertyType = 5,
	goalValues = 4,
	activityId = 1,
	guestId = 2
}
local dataList = {
	{
		446001,
		1,
		10140,
		{
			5,
			5,
			5
		},
		0,
		0
	},
	{
		446001,
		2,
		10139,
		{
			6,
			6,
			6
		},
		0,
		0
	},
	{
		446001,
		3,
		10138,
		{
			8,
			8,
			8
		},
		1,
		3
	},
	{
		446001,
		4,
		1302101,
		{
			5,
			15,
			5
		},
		2,
		3
	},
	{
		446001,
		5,
		1202701,
		{
			15,
			5,
			5
		},
		3,
		3
	},
	{
		446001,
		6,
		1202801,
		{
			5,
			5,
			15
		},
		4,
		3
	},
	{
		446001,
		7,
		1302202,
		{
			12,
			12,
			12
		},
		1,
		5
	},
	{
		446001,
		8,
		1800101,
		{
			8,
			20,
			8
		},
		2,
		5
	},
	{
		446001,
		9,
		1802101,
		{
			20,
			8,
			8
		},
		3,
		5
	},
	{
		446001,
		10,
		10386,
		{
			8,
			8,
			20
		},
		4,
		5
	}
}
local t_anchor_simulator_guest = {
	[446001] = {
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

t_anchor_simulator_guest.dataList = dataList

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

return t_anchor_simulator_guest
