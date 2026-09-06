-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_summon_type.lua

module("logicconfig.config.t_mahjong_battle_summon_type", package.seeall)

local title = {
	summonPetPlan = 5,
	name = 3,
	canSelectNum = 7,
	buffPlan = 9,
	bonusScore = 8,
	canContinuesSummonType = 10,
	summonType = 2,
	canSummonNum = 6,
	activityId = 1,
	isSpecialSummonType = 4
}
local dataList = {
	{
		571001,
		1,
		"顺子",
		false,
		1,
		3,
		1,
		0,
		0
	},
	{
		571001,
		2,
		"刻子",
		false,
		1,
		3,
		1,
		0,
		0
	},
	{
		571001,
		3,
		"杠子",
		false,
		2,
		4,
		1,
		0,
		0,
		{
			4,
			5,
			7
		}
	},
	{
		571001,
		4,
		"清一色",
		true,
		3,
		5,
		3,
		8,
		3
	},
	{
		571001,
		5,
		"基础胡",
		false,
		1,
		4,
		2,
		2,
		1
	},
	{
		571001,
		6,
		"手牌胡",
		false,
		2,
		5,
		2,
		5,
		2
	},
	{
		571001,
		7,
		"二连杠",
		false,
		3,
		6,
		3,
		0,
		3,
		{
			4,
			5,
			8
		}
	},
	{
		571001,
		8,
		"三连杠",
		false,
		3,
		6,
		3,
		0,
		4,
		{
			4,
			5,
			9
		}
	},
	{
		571001,
		9,
		"四连杠",
		false,
		3,
		6,
		3,
		0,
		5,
		{
			4,
			5
		}
	}
}
local t_mahjong_battle_summon_type = {
	[571001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_mahjong_battle_summon_type.dataList = dataList

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

return t_mahjong_battle_summon_type
