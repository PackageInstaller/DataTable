-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_slack_off_game_rule.lua

module("logicconfig.config.t_slack_off_game_rule", package.seeall)

local title = {
	index = 2,
	url = 3,
	desc = 4,
	ruleKey = 1
}
local dataList = {
	{
		"rule_1",
		1,
		"ui/bigbg/views/moyuxingdong/board_moyu_guize01.png",
		"点击学生下方的“学习”、“摸鱼”按钮即可切换不同状态。不同标签的学生，对应的心情&知识吸收的增减速率也不同。教导主任巡视持续时长随机，即将到达窗边前会有警铃提示，在巡视过程中，学生们的心情&知识吸收的速率会受到一定影响。"
	}
}
local t_slack_off_game_rule = {
	rule_1 = {
		dataList[1]
	}
}

t_slack_off_game_rule.dataList = dataList

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

return t_slack_off_game_rule
