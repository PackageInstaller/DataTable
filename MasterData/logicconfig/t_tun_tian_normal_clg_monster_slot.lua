-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tun_tian_normal_clg_monster_slot.lua

module("logicconfig.config.t_tun_tian_normal_clg_monster_slot", package.seeall)

local title = {
	activityId = 1,
	pos = 3,
	slotId = 2
}
local dataList = {
	{
		289001,
		1,
		{
			-322,
			100
		}
	},
	{
		289001,
		2,
		{
			12,
			171
		}
	},
	{
		289001,
		3,
		{
			349,
			107
		}
	},
	{
		289001,
		4,
		{
			142,
			-187
		}
	},
	{
		289001,
		5,
		{
			-170,
			-110
		}
	},
	{
		289002,
		1,
		{
			-322,
			100
		}
	},
	{
		289002,
		2,
		{
			12,
			171
		}
	},
	{
		289002,
		3,
		{
			349,
			107
		}
	},
	{
		289002,
		4,
		{
			142,
			-187
		}
	},
	{
		289002,
		5,
		{
			-170,
			-110
		}
	}
}
local t_tun_tian_normal_clg_monster_slot = {
	[289001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[289002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_tun_tian_normal_clg_monster_slot.dataList = dataList

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

return t_tun_tian_normal_clg_monster_slot
