-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shen_ji_common.lua

module("logicconfig.config.t_shen_ji_common", package.seeall)

local title = {
	rewardIconPath = 2,
	comPlanId = 1,
	practiceTitle = 4,
	rewardDesc = 5,
	rewardName = 3
}
local dataList = {
	{
		1,
		"ui/icon/items/icon_shenendaibi.png",
		"神恩值",
		82056658,
		"通关【行祷】关卡时，己方精灵剩余血量的百分比乘以关卡提供的最大神恩值即为本关获取的神恩值\r\n神恩值会提升【道途】的能力加成"
	},
	{
		2,
		"ui/icon/expevents/icon_lounahuizhang.png",
		"化器值",
		82056659,
		"通关【杀伐】关卡时，己方精灵剩余血量的百分比乘以关卡提供的最大化器值即为本关获取的化器值\r\n化器值会提升【化器】的能力加成"
	},
	{
		3,
		"ui/icon/expevents/icon_lounahuizhang.png",
		"赐福值",
		82056659,
		"通关【黎月守望】关卡时，己方精灵剩余血量的百分比乘以关卡提供的最大赐福值即为本关获取的赐福值\r\n赐福值会提升【赐福】的能力加成"
	}
}
local t_shen_ji_common = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_shen_ji_common.dataList = dataList

local multiLanguageCells = {
	practiceTitle = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_shen_ji_common
