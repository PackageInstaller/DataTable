-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ji_mix_stage.lua

module("logicconfig.config.t_king_ji_mix_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterIds = 4,
	openTime = 3,
	passPlanId = 5,
	rule = 7,
	stagePrize = 6,
	actId = 1
}
local dataList = {
	{
		308001,
		1,
		"2022-09-11T05:00:00",
		{
			301,
			302,
			303
		},
		1,
		"4:380:20",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	},
	{
		308001,
		2,
		"2022-09-11T05:00:00",
		{
			304,
			305,
			306
		},
		2,
		"4:380:20",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	},
	{
		308001,
		3,
		"2022-09-11T05:00:00",
		{
			307,
			308,
			309
		},
		3,
		"4:380:20",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	},
	{
		308002,
		1,
		"2022-09-11T05:00:00",
		{
			301,
			302,
			303
		},
		1,
		"8:1:1",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	},
	{
		308002,
		2,
		"2022-09-11T05:00:00",
		{
			304,
			305,
			306
		},
		2,
		"8:1:1",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	},
	{
		308002,
		3,
		"2022-09-11T05:00:00",
		{
			307,
			308,
			309
		},
		3,
		"8:1:1",
		"1、破阵时，我方存活精灵中满足关卡目标属性的精灵将被收集为元素\r\n2、挑战本关卡其他敌阵时，已作为元素进行收集的精灵不可再上阵\r\n3、本关所有敌阵挑战成功，且达成元素收集目标即可领取奖励"
	}
}
local t_king_ji_mix_stage = {
	[308001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[308002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_king_ji_mix_stage.dataList = dataList

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

return t_king_ji_mix_stage
