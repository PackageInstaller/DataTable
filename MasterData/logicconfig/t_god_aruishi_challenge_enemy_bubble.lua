-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_enemy_bubble.lua

module("logicconfig.config.t_god_aruishi_challenge_enemy_bubble", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"看看你还能坚持多久"
	},
	{
		2,
		"呵，厮杀才有意思。"
	},
	{
		3,
		"你的命运，就在我的棋局中！"
	},
	{
		4,
		"力量… 我渴望生命之树的力量"
	}
}
local t_god_aruishi_challenge_enemy_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_god_aruishi_challenge_enemy_bubble.dataList = dataList

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

return t_god_aruishi_challenge_enemy_bubble
