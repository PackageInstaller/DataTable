-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gift_box_pool.lua

module("logicconfig.config.t_gift_box_pool", package.seeall)

local title = {
	boxPlanId = 3,
	openCondition = 4,
	activityId = 1,
	poolId = 2
}
local dataList = {
	{
		318001,
		1,
		1,
		""
	},
	{
		318001,
		2,
		2,
		"1:1#2:1"
	},
	{
		318001,
		3,
		3,
		"1:1#2:2"
	},
	{
		318001,
		4,
		4,
		"1:1#2:3"
	},
	{
		318001,
		5,
		5,
		"1:1#2:4"
	},
	{
		318001,
		6,
		6,
		"1:1#2:5"
	},
	{
		318001,
		7,
		7,
		"1:1#2:6"
	},
	{
		318001,
		8,
		8,
		"1:1#2:7"
	},
	{
		318001,
		9,
		9,
		"1:1#2:8"
	}
}
local t_gift_box_pool = {
	[318001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_gift_box_pool.dataList = dataList

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

return t_gift_box_pool
