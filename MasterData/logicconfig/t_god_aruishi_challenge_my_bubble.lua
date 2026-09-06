-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_aruishi_challenge_my_bubble.lua

module("logicconfig.config.t_god_aruishi_challenge_my_bubble", package.seeall)

local title = {
	id = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"生命之树由我守护"
	},
	{
		2,
		"你们休想靠近！"
	},
	{
		3,
		"警告你们！不要动它！"
	},
	{
		4,
		"要打架么！随时奉陪"
	},
	{
		5,
		"我“阿瑞斯”可是战神之名！"
	}
}
local t_god_aruishi_challenge_my_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_god_aruishi_challenge_my_bubble.dataList = dataList

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

return t_god_aruishi_challenge_my_bubble
