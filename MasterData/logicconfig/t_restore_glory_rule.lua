-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_rule.lua

module("logicconfig.config.t_restore_glory_rule", package.seeall)

local title = {
	descR = 5,
	ruleId = 1,
	ImgpathR = 3,
	ImgpathL = 2,
	descL = 4
}
local dataList = {
	{
		1,
		"board_zhongshu_17",
		"board_zhongshu_18",
		"点击长按剪刀，将其拖拽至枯叶处滑动，即可修剪枝叶",
		"枯叶完全清除后，视为修剪成功"
	},
	{
		2,
		"board_chongzhurongguang_17",
		"board_chongzhurongguang_18",
		"有跟随跑动的光效，光效到达指定位置时点击炼金锤，即可锻造1次圣剑",
		"每个位置需要锻造的次数不同，从左到右为5/4/6，锻造次数达成后视为重铸成功"
	}
}
local t_restore_glory_rule = {
	dataList[1],
	dataList[2]
}

t_restore_glory_rule.dataList = dataList

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

return t_restore_glory_rule
