-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_pet_group.lua

module("logicconfig.config.t_abyss_gold_rush_pet_group", package.seeall)

local title = {
	activityId = 1,
	petGroupId = 2
}
local dataList = {
	{
		612001,
		1
	},
	{
		612001,
		2
	},
	{
		612001,
		3
	},
	{
		612001,
		4
	},
	{
		612001,
		5
	},
	{
		612001,
		6
	},
	{
		612001,
		7
	},
	{
		612001,
		8
	},
	{
		612001,
		9
	},
	{
		612001,
		10
	},
	{
		612001,
		11
	},
	{
		612001,
		12
	}
}
local t_abyss_gold_rush_pet_group = {
	[612001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_abyss_gold_rush_pet_group.dataList = dataList

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

return t_abyss_gold_rush_pet_group
