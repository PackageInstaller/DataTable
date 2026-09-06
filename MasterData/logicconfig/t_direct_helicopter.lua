-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_direct_helicopter.lua

module("logicconfig.config.t_direct_helicopter", package.seeall)

local title = {
	id = 2,
	targetId = 3,
	activityId = 1
}
local dataList = {
	{
		60001,
		1,
		1
	},
	{
		60001,
		2,
		2
	},
	{
		60002,
		1,
		4
	},
	{
		60002,
		2,
		5
	},
	{
		60003,
		1,
		6
	},
	{
		60003,
		2,
		7
	},
	{
		60004,
		1,
		8
	},
	{
		60004,
		2,
		9
	}
}
local t_direct_helicopter = {
	[60001] = {
		dataList[1],
		dataList[2]
	},
	[60002] = {
		dataList[3],
		dataList[4]
	},
	[60003] = {
		dataList[5],
		dataList[6]
	},
	[60004] = {
		dataList[7],
		dataList[8]
	}
}

t_direct_helicopter.dataList = dataList

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

return t_direct_helicopter
