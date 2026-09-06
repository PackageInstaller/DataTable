-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_popularity_list_vip_times_plan.lua

module("logicconfig.config.t_popularity_list_vip_times_plan", package.seeall)

local title = {
	vipTimesPlanId = 1,
	vipLv = 2,
	times = 3
}
local dataList = {
	{
		1,
		0,
		1
	},
	{
		1,
		1,
		2
	},
	{
		1,
		2,
		2
	},
	{
		1,
		3,
		2
	},
	{
		1,
		4,
		3
	},
	{
		1,
		5,
		3
	},
	{
		1,
		6,
		4
	},
	{
		1,
		7,
		4
	},
	{
		1,
		8,
		5
	},
	{
		1,
		9,
		5
	},
	{
		1,
		10,
		6
	}
}
local t_popularity_list_vip_times_plan = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11]
	}
}

t_popularity_list_vip_times_plan.dataList = dataList

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

return t_popularity_list_vip_times_plan
