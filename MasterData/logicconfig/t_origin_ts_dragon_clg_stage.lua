-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ts_dragon_clg_stage.lua

module("logicconfig.config.t_origin_ts_dragon_clg_stage", package.seeall)

local title = {
	stageId = 3,
	passDesc = 5,
	phaseId = 2,
	targetRound = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		591001,
		1,
		1,
		1001,
		"4回合内破阵即为胜利",
		4
	},
	{
		591001,
		1,
		2,
		1002,
		"4回合内破阵即为胜利",
		4
	},
	{
		591001,
		1,
		3,
		1003,
		"4回合内破阵即为胜利",
		4
	},
	{
		591001,
		2,
		1,
		1004,
		"3回合内破阵即为胜利",
		3
	},
	{
		591001,
		2,
		2,
		1005,
		"3回合内破阵即为胜利",
		3
	},
	{
		591001,
		2,
		3,
		1006,
		"3回合内破阵即为胜利",
		3
	},
	{
		591001,
		3,
		1,
		1007,
		"破阵时己阵至少存活5个精灵",
		0
	},
	{
		591001,
		3,
		2,
		1008,
		"破阵时己阵至少存活5个精灵",
		0
	},
	{
		591001,
		3,
		3,
		1009,
		"破阵时己阵至少存活5个精灵",
		0
	}
}
local t_origin_ts_dragon_clg_stage = {
	[591001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_origin_ts_dragon_clg_stage.dataList = dataList

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

return t_origin_ts_dragon_clg_stage
