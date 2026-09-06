-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_year_pray_bubble.lua

module("logicconfig.config.t_new_year_pray_bubble", package.seeall)

local title = {
	bubbleId = 1,
	desc = 2
}
local dataList = {
	{
		1,
		"为祈愿灯注入希望吧~"
	},
	{
		2,
		"今日风向东北风，微风转阵雨适宜放飞更的许愿灯，让人生更加顺遂，展望未来～"
	},
	{
		3,
		"愿每一颗星星都听见你的心愿，每一片云彩都为你敞开幸福之门。"
	},
	{
		4,
		"愿许愿灯点燃你内心最美好的梦想，照亮前行的路途。"
	},
	{
		5,
		"愿你的愿望如同许愿灯的光芒，穿越黑夜，终至星辰。"
	},
	{
		6,
		"这一刻，许下心愿，愿所有美好的祝愿都成为你生活的一部分。"
	},
	{
		7,
		"让心愿随着烛光升腾，愿它在星空中熠熠生辉，如同最美的童话。"
	},
	{
		8,
		"愿每一次点燃许愿灯都是一次心灵的对话，让愿望如清风般轻轻而来。"
	},
	{
		9,
		"你的梦想像许愿灯一样，冉冉升起，终成为现实的星辰。"
	},
	{
		10,
		"在这片夜色中，愿你的愿望在星光中闪耀，如同夜空中最耀眼的流星。"
	},
	{
		11,
		"愿你的心愿如同许愿灯的火焰，照亮心灵深处的那份温暖。"
	},
	{
		12,
		"每一个心愿都如期而至，如同许愿灯的微光温柔而坚定。"
	}
}
local t_new_year_pray_bubble = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12]
}

t_new_year_pray_bubble.dataList = dataList

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

return t_new_year_pray_bubble
