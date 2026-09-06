-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_dragon_nuo_ya_clg_stage.lua

module("logicconfig.config.t_ci_yuan_dragon_nuo_ya_clg_stage", package.seeall)

local title = {
	stageId = 3,
	creepsId = 5,
	phaseId = 2,
	creepsMasterId = 4,
	activityId = 1,
	isShowLock = 6
}
local dataList = {
	{
		408001,
		1,
		1,
		1001,
		100000001,
		0
	},
	{
		408001,
		1,
		2,
		1002,
		100000002,
		0
	},
	{
		408001,
		1,
		3,
		1003,
		100000003,
		0
	},
	{
		408001,
		2,
		1,
		2001,
		0,
		0
	},
	{
		408001,
		2,
		2,
		2002,
		0,
		0
	},
	{
		408001,
		2,
		3,
		2003,
		0,
		0
	},
	{
		408001,
		2,
		4,
		2004,
		0,
		0
	},
	{
		408001,
		3,
		1,
		3001,
		0,
		1
	},
	{
		408001,
		3,
		2,
		3002,
		0,
		1
	},
	{
		408001,
		3,
		3,
		3003,
		0,
		1
	},
	{
		408001,
		3,
		4,
		3004,
		0,
		1
	},
	{
		408001,
		3,
		5,
		3005,
		0,
		1
	}
}
local t_ci_yuan_dragon_nuo_ya_clg_stage = {
	[408001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_ci_yuan_dragon_nuo_ya_clg_stage.dataList = dataList

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

return t_ci_yuan_dragon_nuo_ya_clg_stage
