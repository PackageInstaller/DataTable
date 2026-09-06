-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_awaken_oath_ancestor_point.lua

module("logicconfig.config.t_awaken_oath_ancestor_point", package.seeall)

local title = {
	activityId = 1,
	pos = 3,
	pointId = 2
}
local dataList = {
	{
		496001,
		1,
		{
			-15,
			130
		}
	},
	{
		496001,
		2,
		{
			-225,
			100
		}
	},
	{
		496001,
		3,
		{
			195,
			100
		}
	},
	{
		496001,
		4,
		{
			-435,
			-5
		}
	},
	{
		496001,
		5,
		{
			420,
			-5
		}
	},
	{
		496001,
		6,
		{
			-330,
			-112
		}
	},
	{
		496001,
		7,
		{
			325,
			-112
		}
	},
	{
		496001,
		8,
		{
			3,
			-150
		}
	}
}
local t_awaken_oath_ancestor_point = {
	[496001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_awaken_oath_ancestor_point.dataList = dataList

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

return t_awaken_oath_ancestor_point
