-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_chen_clg_extreme_stage.lua

module("logicconfig.config.t_divine_chen_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	targetDesc = 6,
	passLimit = 5,
	enemyBuffDesc = 7,
	creepsMasterId = 3,
	selfBuffDesc = 8,
	activityId = 1,
	showRoleId = 4
}
local dataList = {
	{
		457001,
		1,
		1001,
		"13014",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457001,
		2,
		1002,
		"12020",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457001,
		3,
		1003,
		"12028",
		14,
		"我方女性精灵超杀累计14次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457001,
		4,
		1004,
		"17018",
		14,
		"我方女性精灵超杀累计14次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457001,
		5,
		1005,
		"16027",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457001,
		6,
		1006,
		"14026",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		1,
		1001,
		"13014",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		2,
		1002,
		"12020",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		3,
		1003,
		"12028",
		14,
		"我方女性精灵超杀累计14次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		4,
		1004,
		"17018",
		14,
		"我方女性精灵超杀累计14次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		5,
		1005,
		"16027",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	},
	{
		457002,
		6,
		1006,
		"14026",
		12,
		"我方女性精灵超杀累计12次",
		"根据我方上阵女性精灵数量激活加成",
		1
	}
}
local t_divine_chen_clg_extreme_stage = {
	[457001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[457002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_divine_chen_clg_extreme_stage.dataList = dataList

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

return t_divine_chen_clg_extreme_stage
