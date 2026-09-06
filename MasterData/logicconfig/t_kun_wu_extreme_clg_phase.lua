-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kun_wu_extreme_clg_phase.lua

module("logicconfig.config.t_kun_wu_extreme_clg_phase", package.seeall)

local title = {
	stageBottomWord = 7,
	topRule = 5,
	phaseId = 2,
	bottomRule = 6,
	activityId = 1,
	caculateSymbol = 3,
	targetSumValue = 4
}
local dataList = {
	{
		444001,
		1,
		">=",
		15,
		"1.成功破阵后，其他的阵会获得该阵属性的BUFF。\r\n2.必须上阵4只与关卡属性相同的精灵。",
		"上层，存活数之和≥15",
		"破阵存活数："
	},
	{
		444001,
		2,
		"<=",
		8,
		"1.成功破阵后，其他的阵会获得该阵属性的BUFF。\r\n2.必须上阵4只与关卡属性相同的精灵。",
		"下层，回合之和≤8",
		"破阵回合数："
	}
}
local t_kun_wu_extreme_clg_phase = {
	[444001] = {
		dataList[1],
		dataList[2]
	}
}

t_kun_wu_extreme_clg_phase.dataList = dataList

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

return t_kun_wu_extreme_clg_phase
