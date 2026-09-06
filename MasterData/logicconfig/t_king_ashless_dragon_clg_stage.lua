-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ashless_dragon_clg_stage.lua

module("logicconfig.config.t_king_ashless_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 5,
	creepsMasterId = 4,
	activityId = 1,
	passPrize = 3
}
local dataList = {
	{
		440001,
		1,
		"4:423:10",
		1001,
		"第1关"
	},
	{
		440001,
		2,
		"4:423:10",
		1002,
		"第2关"
	},
	{
		440001,
		3,
		"4:423:10",
		1003,
		"第3关"
	},
	{
		440001,
		4,
		"4:423:10",
		1004,
		"第4关"
	},
	{
		440001,
		5,
		"4:423:10",
		1005,
		"第5关"
	},
	{
		440001,
		6,
		"4:423:10",
		1006,
		"第6关"
	},
	{
		440001,
		7,
		"4:423:10",
		1007,
		"第7关"
	},
	{
		440001,
		8,
		"4:423:15",
		1008,
		"第8关"
	},
	{
		440001,
		9,
		"4:423:15",
		1009,
		"第9关"
	},
	{
		440001,
		10,
		"4:423:20",
		1010,
		"第10关"
	}
}
local t_king_ashless_dragon_clg_stage = {
	[440001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_king_ashless_dragon_clg_stage.dataList = dataList

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

return t_king_ashless_dragon_clg_stage
