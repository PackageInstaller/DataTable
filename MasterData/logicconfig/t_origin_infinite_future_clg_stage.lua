-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_infinite_future_clg_stage.lua

module("logicconfig.config.t_origin_infinite_future_clg_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	pos = 6,
	extproperties = 4,
	activityId = 1,
	passValuePercent = 5
}
local dataList = {
	{
		619001,
		1,
		1001,
		"生命+190000#攻击+40000#物防+13000#魔防+13000",
		10000,
		{
			-541,
			138
		}
	},
	{
		619001,
		2,
		1002,
		"生命+180000#攻击+45000#物防+12000#魔防+12000",
		10000,
		{
			-452,
			-122
		}
	},
	{
		619001,
		3,
		1003,
		"生命+180000#攻击+70000#物防+8000#魔防+8000",
		10000,
		{
			-257,
			20
		}
	},
	{
		619001,
		4,
		1004,
		"生命+250000#攻击+30000#物防+15000#魔防+15000",
		10000,
		{
			-18,
			166
		}
	},
	{
		619001,
		5,
		1005,
		"生命+170000#攻击+35000#物防+11000#魔防+11000",
		10000,
		{
			168,
			-39
		}
	},
	{
		619001,
		6,
		1006,
		"生命+170000#攻击+35000#物防+11000#魔防+11000",
		10000,
		{
			-63,
			-160
		}
	}
}
local t_origin_infinite_future_clg_stage = {
	[619001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_infinite_future_clg_stage.dataList = dataList

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

return t_origin_infinite_future_clg_stage
