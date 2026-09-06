-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lucky_draw_point_plan.lua

module("logicconfig.config.t_lucky_draw_point_plan", package.seeall)

local title = {
	activityId = 1,
	beginScore = 2
}
local dataList = {
	{
		25005,
		0
	},
	{
		25005,
		20
	},
	{
		25005,
		40
	},
	{
		25005,
		60
	},
	{
		25005,
		80
	},
	{
		25005,
		100
	},
	{
		25009,
		0
	},
	{
		25009,
		20
	},
	{
		25009,
		40
	},
	{
		25009,
		60
	},
	{
		25009,
		80
	},
	{
		25009,
		100
	}
}
local t_lucky_draw_point_plan = {
	[25005] = {
		[0] = dataList[1],
		[20] = dataList[2],
		[40] = dataList[3],
		[60] = dataList[4],
		[80] = dataList[5],
		[100] = dataList[6]
	},
	[25009] = {
		[0] = dataList[7],
		[20] = dataList[8],
		[40] = dataList[9],
		[60] = dataList[10],
		[80] = dataList[11],
		[100] = dataList[12]
	}
}

t_lucky_draw_point_plan.dataList = dataList

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

return t_lucky_draw_point_plan
