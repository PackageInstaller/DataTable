-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_extreme_score_buff.lua

module("logicconfig.config.t_summon_master_ji_extreme_score_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 3,
	startTotalScore = 2,
	desc = 4
}
local dataList = {
	{
		348001,
		0,
		1,
		"※%s：敌阵攻击前减少目标5%%全属性（1回合,不可叠加）"
	},
	{
		348001,
		10,
		2,
		"※%s：敌阵攻击前减少目标10%%全属性（1回合,不可叠加）"
	},
	{
		348001,
		20,
		3,
		"※%s：敌阵攻击前减少目标15%%全属性（1回合,不可叠加）"
	},
	{
		348001,
		30,
		4,
		"※%s：敌阵攻击前减少目标15%%全属性（1回合,不可叠加）并增加自身5%%全属性（2回合,不可叠加）"
	},
	{
		348001,
		40,
		5,
		"※%s：敌阵攻击前减少目标15%%全属性（1回合,不可叠加）并增加自身10%%全属性（2回合,不可叠加）"
	},
	{
		348001,
		50,
		6,
		"※%s：敌阵攻击前减少目标15%%全属性（1回合,不可叠加）并增加自身15%%全属性（2回合,不可叠加）"
	}
}
local t_summon_master_ji_extreme_score_buff = {
	[348001] = {
		[0] = dataList[1],
		[10] = dataList[2],
		[20] = dataList[3],
		[30] = dataList[4],
		[40] = dataList[5],
		[50] = dataList[6]
	}
}

t_summon_master_ji_extreme_score_buff.dataList = dataList

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

return t_summon_master_ji_extreme_score_buff
