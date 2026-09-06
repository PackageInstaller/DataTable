-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_extreme_clg_stage.lua

module("logicconfig.config.t_kun_wu_extreme_clg_stage", package.seeall)

local title = {
	stageId = 3,
	stageBuffStr = 5,
	phaseId = 2,
	stageOriginBuff = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		444001,
		1,
		1,
		1001,
		"水：敌阵精灵超杀后获得一次立即出手",
		"水"
	},
	{
		444001,
		1,
		2,
		1002,
		"火：敌阵精灵每次出手后获得50点气势",
		"火"
	},
	{
		444001,
		1,
		3,
		1003,
		"草：敌阵精灵免疫负面及非直接伤害",
		"草"
	},
	{
		444001,
		2,
		1,
		1004,
		"水：敌阵精灵超杀后获得一次立即出手",
		"水"
	},
	{
		444001,
		2,
		2,
		1005,
		"火：敌阵精灵每次出手后获得50点气势",
		"火"
	},
	{
		444001,
		2,
		3,
		1006,
		"草：敌阵精灵免疫负面及非直接伤害",
		"草"
	}
}
local t_kun_wu_extreme_clg_stage = {
	[444001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_kun_wu_extreme_clg_stage.dataList = dataList

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

return t_kun_wu_extreme_clg_stage
