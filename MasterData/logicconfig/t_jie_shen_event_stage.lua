-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jie_shen_event_stage.lua

module("logicconfig.config.t_jie_shen_event_stage", package.seeall)

local title = {
	stageId = 1,
	mapId = 2,
	startTime = 3
}
local dataList = {
	{
		1,
		102,
		"2023-01-20T05:00:00"
	},
	{
		2,
		107,
		"2023-01-20T05:00:00"
	},
	{
		3,
		112,
		"2023-01-20T05:00:00"
	},
	{
		4,
		115,
		"2023-01-20T05:00:00"
	},
	{
		5,
		104,
		"2023-01-21T05:00:00"
	},
	{
		6,
		108,
		"2023-01-21T05:00:00"
	},
	{
		7,
		116,
		"2023-01-21T05:00:00"
	},
	{
		8,
		300103,
		"2023-01-21T05:00:00"
	},
	{
		9,
		111,
		"2023-01-22T05:00:00"
	},
	{
		10,
		300104,
		"2023-01-22T05:00:00"
	}
}
local t_jie_shen_event_stage = {
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

t_jie_shen_event_stage.dataList = dataList

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

return t_jie_shen_event_stage
