-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_message.lua

module("logicconfig.config.t_revive_elizabeth_message", package.seeall)

local title = {
	words = 2,
	messageId = 1
}
local dataList = {
	{
		1,
		"不要轻易放弃，你我坚韧的心志饱经苦寒风霜，才能盛放如初。"
	},
	{
		2,
		"清晨的微风拂去了午夜的甜蜜，少女依旧在爱河中徜徉，一切都那么自然、那么美好。"
	},
	{
		3,
		"成熟的爱情虽令人魂牵梦绕，但坚守对彼此幸福结局的向往之心，才是对未来自己最美好的期许。"
	},
	{
		4,
		"世间的爱会让人们成为更好的自己，从而明晰这份矢志不渝的情感来之不易。"
	},
	{
		5,
		"你的纯真容颜依旧，你的优雅从不凋零。"
	},
	{
		6,
		"唯爱无望，唯爱永恒。"
	}
}
local t_revive_elizabeth_message = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_revive_elizabeth_message.dataList = dataList

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

return t_revive_elizabeth_message
