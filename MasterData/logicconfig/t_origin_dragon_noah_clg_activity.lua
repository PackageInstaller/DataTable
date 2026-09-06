-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dragon_noah_clg_activity.lua

module("logicconfig.config.t_origin_dragon_noah_clg_activity", package.seeall)

local title = {
	passScore = 3,
	ruleDesc = 8,
	skinId = 6,
	jumpTo = 7,
	roleInitPos = 9,
	prize = 2,
	scoreBuffSignIds = 4,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		539001,
		"4:510648:100",
		55,
		{
			30000014,
			30000025
		},
		"origindragonnoahmainview_rule",
		16044,
		{
			"func#618#16044",
			"ui#lottery",
			"mibao#MibaoShop",
			"event#gotofirstpassrankview#539001"
		},
		"1、诺亚和敖九相向而行，初始距离为<color=#C54949>55</color>米，诺亚和敖九的距离等于<color=#C54949>0</color>时，且<color=#C54949>所有关卡</color>完成破阵，即为通关本挑战，获得奖励\r\n2、破阵时，根据指定条件控制诺亚和敖九前进的距离\r\n①己阵所有精灵的<color=#C54949>群攻次数</color>，转化为<color=#C54949>诺亚</color>前进的距离\r\n②己阵所有精灵的<color=#C54949>变身次数</color>，转化为<color=#C54949>敖九</color>前进的距离\r\n3、破阵后，封印己方战力最高的精灵，相同则都封印，在后续的关卡中不可上阵\r\n4、可单关重置，清空本关的精灵封印和距离变化\r\n5、<color=#C54949>敌阵效果</color>\r\n①全属性+50%，暴击率+100% \r\n②每次攻击后，给目标施加光核（最多2层，无视防御，可暴击） \r\n③首次死亡时，移除自身所有负面效果，恢复生命值至100%\"",
		{
			0,
			634
		}
	}
}
local t_origin_dragon_noah_clg_activity = {
	[539001] = dataList[1]
}

t_origin_dragon_noah_clg_activity.dataList = dataList

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

return t_origin_dragon_noah_clg_activity
