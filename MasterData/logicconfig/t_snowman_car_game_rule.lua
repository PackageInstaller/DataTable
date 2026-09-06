-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_snowman_car_game_rule.lua

module("logicconfig.config.t_snowman_car_game_rule", package.seeall)

local title = {
	index = 2,
	picturePath = 3,
	desc = 4,
	ruleKey = 1
}
local dataList = {
	{
		"snowmancar_rule",
		1,
		"board_xuerenzhuangche_guize01",
		"每个小火车的的颜色都不一样，需要判断当前最前面的小火车的颜色与小五王的颜色是否一样，当两个颜色一样的时候即可匹配成功上车"
	},
	{
		"snowmancar_rule",
		2,
		"board_xuerenzhuangche_guize02",
		"点击左/右按钮，对应的左边/右边小五王就会上最前面的火车位置"
	},
	{
		"snowmancar_rule",
		3,
		"board_xuerenzhuangche_guize03",
		"如果匹配失败会扣除对应的血量，在活动倒计时结束前，快来累计更多的上车积分吧~"
	}
}
local t_snowman_car_game_rule = {
	snowmancar_rule = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_snowman_car_game_rule.dataList = dataList

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

return t_snowman_car_game_rule
