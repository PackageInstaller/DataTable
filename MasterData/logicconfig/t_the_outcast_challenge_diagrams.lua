-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_the_outcast_challenge_diagrams.lua

module("logicconfig.config.t_the_outcast_challenge_diagrams", package.seeall)

local title = {
	gameId = 5,
	name = 6,
	diagramsId = 1,
	maxStageId = 2,
	prize = 3,
	startTime = 4
}
local dataList = {
	{
		1,
		3,
		"8:1:250000",
		"2021-08-05T05:00:00",
		1,
		"乾"
	},
	{
		2,
		6,
		"4:25:5",
		"2021-08-06T05:00:00",
		2,
		"巽"
	},
	{
		3,
		9,
		"4:31:10",
		"2021-08-07T05:00:00",
		3,
		"坎"
	},
	{
		4,
		12,
		"4:503:2",
		"2021-08-08T05:00:00",
		4,
		"艮"
	},
	{
		5,
		15,
		"4:30003:10",
		"2021-08-09T05:00:00",
		5,
		"坤"
	},
	{
		6,
		18,
		"4:90086:1",
		"2021-08-10T05:00:00",
		6,
		"震"
	},
	{
		7,
		21,
		"4:602:2",
		"2021-08-11T05:00:00",
		7,
		"離"
	},
	{
		8,
		24,
		"4:36:10",
		"2021-08-12T05:00:00",
		8,
		"兑"
	}
}
local t_the_outcast_challenge_diagrams = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_the_outcast_challenge_diagrams.dataList = dataList

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

return t_the_outcast_challenge_diagrams
