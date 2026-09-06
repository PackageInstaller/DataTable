-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_roguelike_drop_buff_rerandom_cost_plan.lua

module("logicconfig.config.t_roguelike_drop_buff_rerandom_cost_plan", package.seeall)

local title = {
	cost = 4,
	activityId = 1,
	planId = 2,
	reRandomCount = 3
}
local dataList = {
	{
		393001,
		1,
		1,
		"10:393001:200"
	},
	{
		393001,
		1,
		2,
		"10:393001:200"
	},
	{
		393001,
		1,
		3,
		"10:393001:200"
	},
	{
		393001,
		2,
		1,
		"10:393001:500"
	},
	{
		393001,
		2,
		2,
		"10:393001:500"
	},
	{
		393001,
		2,
		3,
		"10:393001:500"
	},
	{
		393002,
		1,
		1,
		"10:393002:200"
	},
	{
		393002,
		1,
		2,
		"10:393002:200"
	},
	{
		393002,
		1,
		3,
		"10:393002:200"
	},
	{
		393002,
		2,
		1,
		"10:393002:500"
	},
	{
		393002,
		2,
		2,
		"10:393002:500"
	},
	{
		393002,
		2,
		3,
		"10:393002:500"
	},
	{
		393003,
		1,
		1,
		"10:393003:200"
	},
	{
		393003,
		1,
		2,
		"10:393003:200"
	},
	{
		393003,
		1,
		3,
		"10:393003:200"
	},
	{
		393003,
		2,
		1,
		"10:393003:500"
	},
	{
		393003,
		2,
		2,
		"10:393003:500"
	},
	{
		393003,
		2,
		3,
		"10:393003:500"
	}
}
local t_roguelike_drop_buff_rerandom_cost_plan = {
	[393001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	},
	[393002] = {
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	},
	[393003] = {
		{
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_roguelike_drop_buff_rerandom_cost_plan.dataList = dataList

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

return t_roguelike_drop_buff_rerandom_cost_plan
