-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_challenge_extreme.lua

module("logicconfig.config.t_fuyao_challenge_extreme", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		272001,
		1,
		1001,
		"六道·火"
	},
	{
		272001,
		2,
		1002,
		"六道·水"
	},
	{
		272001,
		3,
		1003,
		"六道·草"
	},
	{
		272001,
		4,
		1004,
		"六道·光"
	},
	{
		272001,
		5,
		1005,
		"六道·暗"
	},
	{
		272001,
		6,
		1006,
		"六道·空"
	},
	{
		272002,
		1,
		1001,
		"六道·火"
	},
	{
		272002,
		2,
		1002,
		"六道·水"
	},
	{
		272002,
		3,
		1003,
		"六道·草"
	},
	{
		272002,
		4,
		1004,
		"六道·光"
	},
	{
		272002,
		5,
		1005,
		"六道·暗"
	},
	{
		272002,
		6,
		1006,
		"六道·空"
	}
}
local t_fuyao_challenge_extreme = {
	[272001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[272002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_fuyao_challenge_extreme.dataList = dataList

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

return t_fuyao_challenge_extreme
