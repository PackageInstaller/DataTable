-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_tower_activity.lua

module("logicconfig.config.t_summon_master_tower_activity", package.seeall)

local title = {
	activityId = 1,
	scoreItemKey = 3,
	seasonId = 2,
	periodId = 4
}
local dataList = {
	{
		85001,
		1,
		"10:85001",
		1
	},
	{
		85002,
		1,
		"10:85002",
		1
	},
	{
		85003,
		1,
		"10:199001",
		2
	},
	{
		85004,
		2,
		"10:199001",
		2
	},
	{
		85005,
		1,
		"10:199002",
		3
	},
	{
		85006,
		4,
		"10:85003",
		4
	},
	{
		85007,
		5,
		"10:85004",
		5
	},
	{
		85008,
		6,
		"10:85005",
		6
	}
}
local t_summon_master_tower_activity = {
	[85001] = dataList[1],
	[85002] = dataList[2],
	[85003] = dataList[3],
	[85004] = dataList[4],
	[85005] = dataList[5],
	[85006] = dataList[6],
	[85007] = dataList[7],
	[85008] = dataList[8]
}

t_summon_master_tower_activity.dataList = dataList

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

return t_summon_master_tower_activity
