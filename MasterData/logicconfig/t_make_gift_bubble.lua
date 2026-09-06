-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_make_gift_bubble.lua

module("logicconfig.config.t_make_gift_bubble", package.seeall)

local title = {
	id = 2,
	showDes = 3,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"不愧是阿修，真靠谱呀！"
	},
	{
		1,
		2,
		"阿修打架太辛苦了，我要给他做好吃的~"
	},
	{
		1,
		3,
		"阿修喜欢吃紫薯味的一切！"
	},
	{
		1,
		4,
		"咦，这个小紫薯好像阿修的脑袋哦"
	},
	{
		1,
		5,
		"我喜欢吃芒果，芒果紫薯千层……？算了算了"
	},
	{
		1,
		6,
		"饺子~嗯…希望煮完不会散开…散开的话就当成面片汤吧！"
	},
	{
		1,
		7,
		"比烤鸡腿好吃的烤蘑菇~来咯~"
	}
}
local t_make_gift_bubble = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_make_gift_bubble.dataList = dataList

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

return t_make_gift_bubble
