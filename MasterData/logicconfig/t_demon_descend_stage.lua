-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_stage.lua

module("logicconfig.config.t_demon_descend_stage", package.seeall)

local title = {
	stageId = 2,
	perfectWinGainRedWine = 5,
	winGainRedWine = 4,
	creepsMasterId = 3,
	killOrder = 6,
	activityId = 1
}
local dataList = {
	{
		497001,
		1,
		1001,
		10,
		30,
		{
			1,
			2,
			3
		}
	},
	{
		497001,
		2,
		1002,
		10,
		30,
		{
			2,
			3,
			4
		}
	},
	{
		497001,
		3,
		1003,
		10,
		30,
		{
			3,
			4,
			5
		}
	},
	{
		497001,
		4,
		1004,
		10,
		30,
		{
			4,
			5,
			6
		}
	},
	{
		497001,
		5,
		1005,
		10,
		30,
		{
			5,
			6,
			1
		}
	},
	{
		497001,
		6,
		1006,
		10,
		30,
		{
			6,
			1,
			2
		}
	}
}
local t_demon_descend_stage = {
	[497001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_demon_descend_stage.dataList = dataList

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

return t_demon_descend_stage
