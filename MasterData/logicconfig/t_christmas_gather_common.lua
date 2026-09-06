-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_christmas_gather_common.lua

module("logicconfig.config.t_christmas_gather_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RULES_KEY",
		"gathertask_rules"
	},
	{
		"SKIN_TIP",
		"修尔皮肤【圣诞雪夜】将于12.24 5:00后登场"
	},
	{
		"BUBBLE_COUNT",
		"2"
	},
	{
		"BUBBLE_TIPS_1",
		"快来帮我收集材料吧，每收集一个都会有小奖励哦！"
	},
	{
		"BUBBLE_TIPS_2",
		"收集完所有材料，可获得伊丽莎白*1哦！"
	},
	{
		"JUMP_TO",
		"func#454#22009"
	},
	{
		"GET_ALL_TIPS",
		"已集齐所有材料，快去看看修尔的新形象吧~"
	}
}
local t_christmas_gather_common = {
	RULES_KEY = dataList[1],
	SKIN_TIP = dataList[2],
	BUBBLE_COUNT = dataList[3],
	BUBBLE_TIPS_1 = dataList[4],
	BUBBLE_TIPS_2 = dataList[5],
	JUMP_TO = dataList[6],
	GET_ALL_TIPS = dataList[7]
}

t_christmas_gather_common.dataList = dataList

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

return t_christmas_gather_common
