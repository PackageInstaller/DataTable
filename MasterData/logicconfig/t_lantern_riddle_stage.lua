-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_riddle_stage.lua

module("logicconfig.config.t_lantern_riddle_stage", package.seeall)

local title = {
	stageId = 2,
	gameExtParam = 5,
	gameType = 4,
	activityId = 1,
	startTime = 3
}
local dataList = {
	{
		441001,
		1,
		"2025-02-07T05:00:00",
		1,
		"1"
	},
	{
		441001,
		2,
		"2025-02-07T05:00:00",
		2,
		""
	},
	{
		441001,
		3,
		"2025-02-08T05:00:00",
		1,
		"7"
	},
	{
		441001,
		4,
		"2025-02-08T05:00:00",
		2,
		""
	},
	{
		441001,
		5,
		"2025-02-09T05:00:00",
		2,
		""
	},
	{
		441001,
		6,
		"2025-02-09T05:00:00",
		1,
		"6"
	},
	{
		441001,
		7,
		"2025-02-09T05:00:00",
		1,
		"15"
	}
}
local t_lantern_riddle_stage = {
	[441001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_lantern_riddle_stage.dataList = dataList

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

return t_lantern_riddle_stage
