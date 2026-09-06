-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddishitian_challenge_score.lua

module("logicconfig.config.t_goddishitian_challenge_score", package.seeall)

local title = {
	id = 2,
	scorePlanId = 1,
	scoreShow = 4,
	desc = 3
}
local dataList = {
	{
		1,
		101,
		"胜利回合数%d",
		{
			"1~3",
			17,
			"4",
			13,
			"5",
			11,
			"6",
			7,
			"7",
			5,
			"≥8",
			2
		}
	},
	{
		2,
		102,
		"总伤害%d",
		{
			"300~400",
			2,
			"400~500",
			5,
			"500~600",
			7,
			"600~700",
			11,
			"700~800",
			13,
			"≥800",
			17
		}
	},
	{
		3,
		103,
		"属性克制攻击%d次",
		{
			"≥13",
			2,
			"≥15",
			5,
			"≥16",
			7,
			"≥18",
			11,
			"≥20",
			13,
			"≥21",
			17
		}
	},
	{
		4,
		104,
		"己方存活%d个数",
		{
			"1",
			2,
			"2",
			5,
			"3",
			7,
			"4",
			11,
			"5",
			13,
			"6",
			17
		}
	},
	{
		4,
		105,
		"精灵<color=#C54949>穹宇·智慧圣魂</color>存活",
		{
			"智慧圣魂",
			17
		}
	},
	{
		4,
		106,
		"精灵<color=#C54949>梦魇始魔·莱莉丝</color>存活",
		{
			"莱莉丝",
			17
		}
	},
	{
		5,
		107,
		"<color=#C54949>利爪</color>或<color=#C54950>疾速</color>职业精灵存活",
		{
			"1",
			20,
			"2",
			50,
			"3",
			100
		}
	},
	{
		6,
		108,
		"<color=#C54950>魔法</color>职业精灵存活%d个",
		{
			"1",
			20,
			"2",
			50,
			"3",
			100
		}
	}
}
local t_goddishitian_challenge_score = {
	{
		[101] = dataList[1]
	},
	{
		[102] = dataList[2]
	},
	{
		[103] = dataList[3]
	},
	{
		[104] = dataList[4],
		[105] = dataList[5],
		[106] = dataList[6]
	},
	{
		[107] = dataList[7]
	},
	{
		[108] = dataList[8]
	}
}

t_goddishitian_challenge_score.dataList = dataList

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

return t_goddishitian_challenge_score
