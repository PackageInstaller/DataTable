-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_noah_clg_score_plan.lua

module("logicconfig.config.t_origin_dragon_noah_clg_score_plan", package.seeall)

local title = {
	score = 4,
	count = 3,
	buffSignIndex = 2,
	activityId = 1
}
local dataList = {
	{
		539001,
		1,
		1,
		1
	},
	{
		539001,
		1,
		3,
		2
	},
	{
		539001,
		1,
		6,
		3
	},
	{
		539001,
		1,
		9,
		4
	},
	{
		539001,
		1,
		12,
		5
	},
	{
		539001,
		1,
		15,
		6
	},
	{
		539001,
		1,
		18,
		7
	},
	{
		539001,
		1,
		21,
		8
	},
	{
		539001,
		1,
		24,
		9
	},
	{
		539001,
		2,
		1,
		1
	},
	{
		539001,
		2,
		2,
		2
	},
	{
		539001,
		2,
		4,
		3
	},
	{
		539001,
		2,
		6,
		4
	},
	{
		539001,
		2,
		8,
		5
	},
	{
		539001,
		2,
		10,
		6
	},
	{
		539001,
		2,
		12,
		7
	},
	{
		539001,
		2,
		14,
		8
	},
	{
		539001,
		2,
		16,
		9
	}
}
local t_origin_dragon_noah_clg_score_plan = {
	[539001] = {
		{
			dataList[1],
			[3] = dataList[2],
			[6] = dataList[3],
			[9] = dataList[4],
			[12] = dataList[5],
			[15] = dataList[6],
			[18] = dataList[7],
			[21] = dataList[8],
			[24] = dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			[4] = dataList[12],
			[6] = dataList[13],
			[8] = dataList[14],
			[10] = dataList[15],
			[12] = dataList[16],
			[14] = dataList[17],
			[16] = dataList[18]
		}
	}
}

t_origin_dragon_noah_clg_score_plan.dataList = dataList

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

return t_origin_dragon_noah_clg_score_plan
