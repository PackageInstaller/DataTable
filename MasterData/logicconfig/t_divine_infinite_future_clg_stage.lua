-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_infinite_future_clg_stage.lua

module("logicconfig.config.t_divine_infinite_future_clg_stage", package.seeall)

local title = {
	stageId = 2,
	rowColumnGridCount = 4,
	validatorType = 5,
	desc = 6,
	title = 7,
	activityId = 1,
	passPrize = 3
}
local dataList = {
	{
		455001,
		1,
		"4:268:20",
		3,
		"RowSumEqual",
		"1、每个横排相加等于某个值\n2、破阵成功后根据已阵存活精灵数填入数字",
		"己阵存活精灵数"
	},
	{
		455001,
		2,
		"4:268:30",
		3,
		"AllNumbers",
		"1、每个格子必须是1-9的数字，且不可重复\n2、破阵成功后根据已阵群攻次数填入数字",
		"己阵群攻次数"
	},
	{
		455001,
		3,
		"4:268:50",
		3,
		"AllNumbersNXDirectSumEqual",
		"1、把1至9的每个数字填到3*3的方格中,使横着,竖着,斜着个数相加相等（填入的数字不可重复）\n2、破阵成功后根据已阵复活次数填入数字",
		"己阵复活次数"
	},
	{
		455002,
		1,
		"4:268:20",
		3,
		"RowSumEqual",
		"1、每个横排相加等于某个值\n2、破阵成功后根据已阵存活精灵数填入数字",
		"己阵存活精灵数"
	},
	{
		455002,
		2,
		"4:268:30",
		3,
		"AllNumbers",
		"1、每个格子必须是1-9的数字，且不可重复\n2、破阵成功后根据已阵群攻次数填入数字",
		"己阵群攻次数"
	},
	{
		455002,
		3,
		"4:268:50",
		3,
		"AllNumbersNXDirectSumEqual",
		"1、把1至9的每个数字填到3*3的方格中,使横着,竖着,斜着个数相加相等（填入的数字不可重复）\n2、破阵成功后根据已阵复活次数填入数字",
		"己阵复活次数"
	}
}
local t_divine_infinite_future_clg_stage = {
	[455001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[455002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_infinite_future_clg_stage.dataList = dataList

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

return t_divine_infinite_future_clg_stage
