-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_toy.lua

module("logicconfig.config.t_tian_yan_match_toy", package.seeall)

local title = {
	desc = 3,
	res = 5,
	type = 4,
	activityId = 1,
	toyId = 2
}
local dataList = {
	{
		503001,
		1,
		"霸气小天",
		1,
		"ui/emoji/vip/emoji_anpai.png"
	},
	{
		503001,
		2,
		"疑问小天",
		1,
		"ui/emoji/vip/emoji_wenhao.png"
	},
	{
		503001,
		3,
		"财主小天",
		1,
		"ui/emoji/vip/emoji_youqian.png"
	},
	{
		503001,
		4,
		"震惊小天",
		1,
		"ui/emoji/vip/emoji_zhenjing.png"
	},
	{
		503001,
		5,
		"吃瓜小炎",
		2,
		"ui/emoji/vip/emoji_chigua.png"
	},
	{
		503001,
		6,
		"窃喜小炎",
		2,
		"ui/emoji/vip/emoji_qiexi.png"
	},
	{
		503001,
		7,
		"暴躁小炎",
		2,
		"ui/emoji/vip/emoji_shengqi.png"
	},
	{
		503001,
		8,
		"心虚小炎",
		2,
		"ui/emoji/vip/emoji_xinxu.png"
	}
}
local t_tian_yan_match_toy = {
	[503001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_tian_yan_match_toy.dataList = dataList

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

return t_tian_yan_match_toy
