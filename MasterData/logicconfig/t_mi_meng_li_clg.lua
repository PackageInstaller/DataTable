-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mi_meng_li_clg.lua

module("logicconfig.config.t_mi_meng_li_clg", package.seeall)

local title = {
	extremeClgPrize = 4,
	jumpStrOne = 5,
	selectPetCount = 2,
	jumpStrThree = 7,
	bossBuffDesc = 15,
	bubbleItem = 11,
	jumpStrTwo = 6,
	alertTips = 12,
	resetTips = 13,
	fakeItemID = 14,
	redPointId = 3,
	jumpStrFive = 9,
	jumpStrFour = 8,
	skinId = 10,
	activityId = 1
}
local dataList = {
	{
		417001,
		20,
		0,
		"",
		"func#618#15030",
		"mibao#anxishenyao4",
		"func#1141",
		"func#545#54",
		"",
		15030,
		"商店已经给您打了八折了 哥们~",
		"您只可选择<color=#FF0010FF>20只</color>精灵带入参与作战\r\n\r\n<color=#FF0010FF>温馨提示</color>:每个精灵将会根据职业分配印记，战斗中存活的精灵所携带的印记将会获得局内奖励",
		"是否确认重置关卡,重置后需要重新选择参与作战的精灵",
		1405,
		"进入战斗时为己阵添加自哀自戚：下次受到攻击时必定闪避且首次闪避后进入隐身状态（1回合）且伤害+15%，暴击率+30%，最大生命值+30%"
	}
}
local t_mi_meng_li_clg = {
	[417001] = dataList[1]
}

t_mi_meng_li_clg.dataList = dataList

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

return t_mi_meng_li_clg
