-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_ya_clg.lua

module("logicconfig.config.t_divine_mi_ya_clg", package.seeall)

local title = {
	stageRule = 7,
	skillBuffDesc = 6,
	jumpTo = 4,
	shopShowPirze = 3,
	raceId = 2,
	dailyBuffDesc = 5,
	activityId = 1
}
local dataList = {
	{
		399001,
		17019,
		"4:248:1",
		{
			"mibao#shenyaolibao",
			"func#618#17019",
			"func#43"
		},
		"每日签到可获得全属性加成BUFF，最高可达1500%",
		"每使用一次技能，敌阵全属性（包括生命）增加5%，最高增加50%",
		"1、线性挑战，相邻时刻的挑战关卡不可使用同一个作战精灵\r\n2、发动星辰混沌：当前时针指向的时辰（关卡）与换影针指向的时辰（关卡）可进行替换\r\n注：两个指针可拨动调整指向的时辰"
	}
}
local t_divine_mi_ya_clg = {
	[399001] = dataList[1]
}

t_divine_mi_ya_clg.dataList = dataList

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

return t_divine_mi_ya_clg
