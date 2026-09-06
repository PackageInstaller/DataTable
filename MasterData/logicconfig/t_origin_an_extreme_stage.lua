-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_extreme_stage.lua

module("logicconfig.config.t_origin_an_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	pos = 5,
	skinId = 6,
	blockHealTimes = 4,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		589001,
		1,
		1001,
		5,
		{
			-455,
			80
		},
		17025
	},
	{
		589001,
		2,
		1002,
		7,
		{
			-200,
			225
		},
		16041
	},
	{
		589001,
		3,
		1003,
		9,
		{
			50,
			80
		},
		12040
	},
	{
		589001,
		4,
		1004,
		9,
		{
			-380,
			-200
		},
		13025
	},
	{
		589001,
		5,
		1005,
		7,
		{
			0,
			-200
		},
		12038
	},
	{
		589001,
		6,
		1006,
		5,
		{
			-205,
			-19
		},
		11036
	}
}
local t_origin_an_extreme_stage = {
	[589001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_an_extreme_stage.dataList = dataList

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

return t_origin_an_extreme_stage
