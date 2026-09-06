-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_king_order_clg_stage.lua

module("logicconfig.config.t_origin_king_order_clg_stage", package.seeall)

local title = {
	posSigns = 4,
	stageId = 2,
	firstPassPrize = 6,
	type = 3,
	creepsMasterId = 5,
	activityId = 1
}
local dataList = {
	{
		569001,
		1,
		1,
		{
			2
		},
		1001,
		"4:510726:10"
	},
	{
		569001,
		2,
		2,
		{
			4,
			6
		},
		1002,
		"4:510726:10"
	},
	{
		569001,
		3,
		1,
		{
			8
		},
		1003,
		"4:510726:20"
	},
	{
		569001,
		4,
		2,
		{
			1,
			9
		},
		1004,
		"4:510726:20"
	},
	{
		569001,
		5,
		1,
		{
			5
		},
		1005,
		"4:510726:20"
	},
	{
		569001,
		6,
		2,
		{
			3,
			7
		},
		1006,
		"4:510726:20"
	}
}
local t_origin_king_order_clg_stage = {
	[569001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_king_order_clg_stage.dataList = dataList

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

return t_origin_king_order_clg_stage
