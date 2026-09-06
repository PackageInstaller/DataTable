-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_mirror.lua

module("logicconfig.config.t_glory_battle_mirror", package.seeall)

local title = {
	creepsMasterId = 3,
	activityId = 1,
	round = 2
}
local dataList = {
	{
		528001,
		1,
		1001
	},
	{
		528001,
		2,
		1002
	},
	{
		528001,
		3,
		1003
	},
	{
		528001,
		4,
		1004
	},
	{
		528001,
		5,
		1005
	},
	{
		528001,
		6,
		1006
	},
	{
		528001,
		7,
		1007
	},
	{
		528001,
		8,
		1008
	},
	{
		528001,
		9,
		1009
	},
	{
		528001,
		10,
		1010
	},
	{
		528001,
		11,
		1011
	},
	{
		528001,
		11,
		1012
	},
	{
		528001,
		11,
		1013
	}
}
local t_glory_battle_mirror = {
	[528001] = {
		{
			[1001] = dataList[1]
		},
		{
			[1002] = dataList[2]
		},
		{
			[1003] = dataList[3]
		},
		{
			[1004] = dataList[4]
		},
		{
			[1005] = dataList[5]
		},
		{
			[1006] = dataList[6]
		},
		{
			[1007] = dataList[7]
		},
		{
			[1008] = dataList[8]
		},
		{
			[1009] = dataList[9]
		},
		{
			[1010] = dataList[10]
		},
		{
			[1011] = dataList[11],
			[1012] = dataList[12],
			[1013] = dataList[13]
		}
	}
}

t_glory_battle_mirror.dataList = dataList

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

return t_glory_battle_mirror
