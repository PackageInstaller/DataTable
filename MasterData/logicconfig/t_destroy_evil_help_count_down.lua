-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_destroy_evil_help_count_down.lua

module("logicconfig.config.t_destroy_evil_help_count_down", package.seeall)

local title = {
	shareTimeLimit = 3,
	activityId = 1,
	star = 2,
	autoPublicMin = 4
}
local dataList = {
	{
		322001,
		1,
		300,
		60
	},
	{
		322001,
		2,
		300,
		60
	},
	{
		322001,
		3,
		300,
		60
	},
	{
		322001,
		4,
		600,
		60
	},
	{
		322001,
		5,
		600,
		60
	},
	{
		322001,
		6,
		600,
		60
	},
	{
		322002,
		1,
		300,
		60
	},
	{
		322002,
		2,
		300,
		60
	},
	{
		322002,
		3,
		300,
		60
	},
	{
		322002,
		4,
		600,
		60
	},
	{
		322002,
		5,
		600,
		60
	},
	{
		322002,
		6,
		600,
		60
	},
	{
		322003,
		1,
		300,
		60
	},
	{
		322003,
		2,
		300,
		60
	},
	{
		322003,
		3,
		300,
		60
	},
	{
		322003,
		4,
		600,
		60
	},
	{
		322003,
		5,
		600,
		60
	},
	{
		322003,
		6,
		600,
		60
	}
}
local t_destroy_evil_help_count_down = {
	[322001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[322002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[322003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_destroy_evil_help_count_down.dataList = dataList

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

return t_destroy_evil_help_count_down
