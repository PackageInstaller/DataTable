-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_preheat_sale_emojipack.lua

module("logicconfig.config.t_preheat_sale_emojipack", package.seeall)

local title = {
	activityId = 1,
	myChat = 9,
	item = 3,
	otherName = 4,
	myHeadId = 10,
	myFrameId = 11,
	otherFrameId = 7,
	myName = 8,
	otherChat = 5,
	id = 2,
	otherHeadId = 6
}
local dataList = {
	{
		87002,
		1,
		"21:43:1",
		"奥奇",
		"我来送福利了！",
		1,
		1,
		"赤",
		"这是我不花钱就能看的吗？",
		74,
		71
	},
	{
		87002,
		2,
		"21:45:1",
		"奥奇",
		"你打BOSS的样子很靓仔！",
		1,
		1,
		"亦",
		"那是，芜湖~起飞~飞~飞~",
		74,
		71
	},
	{
		87002,
		3,
		"21:46:1",
		"奥奇",
		"小心破防",
		1,
		1,
		"赤",
		"我蚌埠住了！我摊牌了！",
		74,
		71
	},
	{
		87002,
		4,
		"21:47:1",
		"奥奇",
		"好家伙，山上的笋都被你夺完了",
		1,
		1,
		"亦",
		"我只是纯良的小猫咪，\n能有什么坏心思呢？",
		74,
		71
	},
	{
		87002,
		5,
		"21:48:1",
		"奥奇",
		"我刚刚直接报你身份证号了",
		1,
		1,
		"赤",
		"你礼貌吗？你礼貌吗？",
		74,
		71
	},
	{
		87002,
		6,
		"21:42:1",
		"奥奇",
		"一首凉凉送给你",
		1,
		1,
		"亦",
		"呜呜呜，芭比Q了……",
		74,
		71
	},
	{
		87002,
		7,
		"21:44:1",
		"奥奇",
		"没人比我更懂blablabla",
		1,
		1,
		"赤",
		"都叫你懂完了是吗？",
		74,
		71
	},
	{
		87002,
		8,
		"21:41:1",
		"奥奇",
		"这次的挑战全程无伤通关",
		1,
		1,
		"亦",
		"发现一只大佬，赶紧抓住！",
		74,
		71
	},
	{
		87003,
		1,
		"21:43:1",
		"奥奇",
		"我来送福利了！",
		1,
		1,
		"赤",
		"这是我不花钱就能看的吗？",
		74,
		71
	},
	{
		87003,
		2,
		"21:45:1",
		"奥奇",
		"你打BOSS的样子很靓仔！",
		1,
		1,
		"亦",
		"那是，芜湖~起飞~飞~飞~",
		74,
		71
	},
	{
		87003,
		3,
		"21:46:1",
		"奥奇",
		"小心破防",
		1,
		1,
		"赤",
		"我蚌埠住了！我摊牌了！",
		74,
		71
	},
	{
		87003,
		4,
		"21:47:1",
		"奥奇",
		"好家伙，山上的笋都被你夺完了",
		1,
		1,
		"亦",
		"我只是纯良的小猫咪，\n能有什么坏心思呢？",
		74,
		71
	},
	{
		87003,
		5,
		"21:48:1",
		"奥奇",
		"我刚刚直接报你身份证号了",
		1,
		1,
		"赤",
		"你礼貌吗？你礼貌吗？",
		74,
		71
	},
	{
		87003,
		6,
		"21:42:1",
		"奥奇",
		"一首凉凉送给你",
		1,
		1,
		"亦",
		"呜呜呜，芭比Q了……",
		74,
		71
	},
	{
		87003,
		7,
		"21:44:1",
		"奥奇",
		"没人比我更懂blablabla",
		1,
		1,
		"赤",
		"都叫你懂完了是吗？",
		74,
		71
	},
	{
		87003,
		8,
		"21:41:1",
		"奥奇",
		"这次的挑战全程无伤通关",
		1,
		1,
		"亦",
		"发现一只大佬，赶紧抓住！",
		74,
		71
	}
}
local t_preheat_sale_emojipack = {
	[87002] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[87003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_preheat_sale_emojipack.dataList = dataList

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

return t_preheat_sale_emojipack
