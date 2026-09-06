-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ashless_dragon_clg.lua

module("logicconfig.config.t_king_ashless_dragon_clg", package.seeall)

local title = {
	extremeClgPrize = 5,
	effPath = 14,
	limitEndTime = 3,
	jumpStrThree = 8,
	battleDesc = 15,
	skinId = 11,
	jumpStrTwo = 7,
	bubbleItem = 12,
	popupDesc = 13,
	jumpStrOne = 6,
	redPointId = 4,
	jumpStrFive = 10,
	limitStartTime = 2,
	jumpStrFour = 9,
	activityId = 1
}
local dataList = {
	{
		440001,
		nil,
		nil,
		0,
		"4:423:120",
		"func#618#12027",
		"",
		"func#1179",
		"mibao#ZhounianShop2",
		"",
		12027,
		"",
		"",
		"",
		"1、破阵后，我方死亡精灵所在站位残留余烬，进入下的关卡时，在该站位上的精灵每次行动时，对己阵生命值最低的2位存活精灵造成攻击*140%的毁灭伤害\r\n2、多个关卡在相同的位置上死亡将叠加余烬层数，最大3层\r\n3、所有关卡每产生一个余烬，则剩余关卡中敌阵受击后，对伤害来源造成自身攻击力*30%的毁灭伤害，最多可叠加9层\r\n4、破阵后，封印我方存活的精灵"
	}
}
local t_king_ashless_dragon_clg = {
	[440001] = dataList[1]
}

t_king_ashless_dragon_clg.dataList = dataList

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

return t_king_ashless_dragon_clg
