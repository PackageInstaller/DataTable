-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_mode.lua

module("logicconfig.config.t_timed_challenge_miya_mode", package.seeall)

local title = {
	smallBubble = 4,
	bigBubble = 3,
	modeName = 2,
	modeId = 1,
	btnText = 5
}
local dataList = {
	{
		1,
		"时空乱局",
		"身处时空乱局，你还能保持镇定吗？我期待极了！\n战胜虚空异界者，才能得到你想要的，别一不小心就丢了性命哦~",
		"",
		"开始\n挑战"
	},
	{
		2,
		"造化神物",
		"神创的造化之物，总是能收割数不尽的生命与时间……你做好准备了吗？",
		"累积伤害：\r\n%s",
		"开始\n挑战"
	},
	{
		3,
		"交错命盘",
		"我与她的命盘相似又不同，不同究竟在哪呢？\n若是你能%s秒内找到%s处不同，便勉强过关吧~",
		"%s秒内找%s处不同",
		"开始\n游戏"
	},
	{
		4,
		"回溯咒语",
		"时间可是生命，你的咒语学得如何？\n若是你能%s秒内答对%s题，便勉强过关吧~",
		"%s秒内答对%s题",
		"开始\n游戏"
	},
	{
		5,
		"神之馈赠",
		"神化万物，而这万物之中又有着我稀罕的珍品，就给你开开眼界吧！",
		"运气爆棚！\r\n直接领奖！",
		"直接\n领奖"
	}
}
local t_timed_challenge_miya_mode = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_timed_challenge_miya_mode.dataList = dataList

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

return t_timed_challenge_miya_mode
