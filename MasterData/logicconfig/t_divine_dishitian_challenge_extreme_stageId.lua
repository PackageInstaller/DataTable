-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dishitian_challenge_extreme_stageId.lua

module("logicconfig.config.t_divine_dishitian_challenge_extreme_stageId", package.seeall)

local title = {
	stepId = 2,
	stageId = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		363001,
		1,
		1,
		101
	},
	{
		363001,
		1,
		2,
		102
	},
	{
		363001,
		1,
		3,
		103
	},
	{
		363001,
		1,
		4,
		104
	},
	{
		363001,
		1,
		5,
		105
	},
	{
		363001,
		1,
		6,
		106
	},
	{
		363001,
		2,
		1,
		107
	},
	{
		363001,
		2,
		2,
		108
	},
	{
		363001,
		2,
		3,
		109
	},
	{
		363001,
		2,
		4,
		110
	},
	{
		363001,
		2,
		5,
		111
	},
	{
		363001,
		2,
		6,
		112
	},
	{
		363001,
		3,
		1,
		113
	},
	{
		363001,
		3,
		2,
		114
	},
	{
		363001,
		3,
		3,
		115
	},
	{
		363001,
		3,
		4,
		116
	},
	{
		363001,
		3,
		5,
		117
	},
	{
		363001,
		3,
		6,
		118
	}
}
local t_divine_dishitian_challenge_extreme_stageId = {
	[363001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		},
		{
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_divine_dishitian_challenge_extreme_stageId.dataList = dataList

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

return t_divine_dishitian_challenge_extreme_stageId
