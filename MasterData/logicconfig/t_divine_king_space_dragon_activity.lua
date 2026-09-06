-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_space_dragon_activity.lua

module("logicconfig.config.t_divine_king_space_dragon_activity", package.seeall)

local title = {
	showRule = 8,
	jumpTo2 = 5,
	jumpTo4 = 7,
	skinId = 9,
	jumpTo3 = 6,
	petValidator = 2,
	jumpTo1 = 4,
	ruleKeyMain = 3,
	activityId = 1
}
local dataList = {
	{
		521001,
		"Job$神曜",
		"divinekingshikonglongzunmain_rule",
		"func#618#14037",
		"mibao#MibaoShop",
		"ui#lottery",
		"",
		"1、每层挑战有2个敌阵，挑战敌阵一只能上阵非神曜精灵，敌阵二只能上阵神曜精灵\r\n2、敌阵一破阵时，记录上阵精灵的剩余血量百分比，优先继承到敌阵二己方相同站位的精灵，若敌阵二中相同站位无上阵精灵，则从1~9号位置中依次寻找未继承血量的精灵，敌阵一中没上阵精灵的站位血量为0\r\n3、敌阵加成\r\n★敌阵超杀后，对目标施加溯时裂空斩\r\n★敌阵超杀后，令自身下次受到的超杀伤害降为0\r\n★敌阵攻击无视免疫效果并清除目标增益效果",
		14037
	}
}
local t_divine_king_space_dragon_activity = {
	[521001] = dataList[1]
}

t_divine_king_space_dragon_activity.dataList = dataList

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

return t_divine_king_space_dragon_activity
