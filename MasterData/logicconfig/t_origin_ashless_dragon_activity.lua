-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ashless_dragon_activity.lua

module("logicconfig.config.t_origin_ashless_dragon_activity", package.seeall)

local title = {
	skinId = 5,
	jumpStrOne = 6,
	ruleTips = 3,
	jumpStrThree = 8,
	jumpStrFour = 9,
	jumpRedIdThree = 12,
	jumpStrTwo = 7,
	jumpRedIdTwo = 11,
	jumpRedIdFour = 13,
	jumpRedIdOne = 10,
	initBudget = 2,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		564001,
		400,
		"1、预算可用于无烬山的建设，消耗预算且关卡挑战胜利，将会同时获得该关卡的建设度、稳定度\r\n2、建设度还可通过通关条件获得对应值；总建设度达到目标值时视为本层通关\r\n3、超过建设度的部分,按照<color=#8bcdff>1:1比例</color>转为下一层的预算\r\n4、其中第二层在达标建设度的基础上<color=#8bcdff>必须将预算清零才算通关</color>",
		"yuanqiwujinlong_rule",
		12041,
		"event#gotofirstpassrankview#564001",
		"func#618#12041",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"",
		"",
		"",
		""
	}
}
local t_origin_ashless_dragon_activity = {
	[564001] = dataList[1]
}

t_origin_ashless_dragon_activity.dataList = dataList

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

return t_origin_ashless_dragon_activity
