-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_page.lua

module("logicconfig.config.t_five_year_recap_page", package.seeall)

local title = {
	title = 3,
	bubbleFormatDesc = 5,
	skinId = 4,
	pageId = 2,
	activityId = 1
}
local dataList = {
	{
		586001,
		1,
		"江湖老资历",
		1702503,
		"看看谁才是真正的老资历？"
	},
	{
		586001,
		2,
		"江湖老资历",
		1702503,
		"看来得赠你称号：%s"
	},
	{
		586001,
		3,
		"江湖老资历",
		1702503,
		"这一块得尊称你为：%s"
	},
	{
		586001,
		4,
		"江湖老资历",
		1702503,
		"不吹不黑，确实算是：%s"
	},
	{
		586001,
		5,
		"江湖老资历",
		1702503,
		"这是上哪搜刮的？大侠可谓：%s"
	},
	{
		586001,
		6,
		"江湖老资历",
		1702503,
		"TA们一定是你的骄傲吧，奥奇"
	},
	{
		586001,
		7,
		"江湖买手篇",
		1702601,
		"大侠竟然在买手领域挑战我吗？"
	},
	{
		586001,
		8,
		"江湖买手篇",
		1702601,
		"不愧是道上流传的名人：%s"
	},
	{
		586001,
		9,
		"江湖买手篇",
		1702601,
		"为这些豪掷千金，想必收获颇丰吧？"
	},
	{
		586001,
		10,
		"江湖买手篇",
		1702601,
		"月卡？这就是你所学流派下的武功秘籍吗？"
	},
	{
		586001,
		11,
		"江湖买手篇",
		1702601,
		"对此实在佩服，今后将尊称您为：%s"
	},
	{
		586001,
		12,
		"江湖买手篇",
		1702601,
		"久仰大名，这都是强大的对手"
	},
	{
		586001,
		13,
		"江湖买手篇",
		1702601,
		"等等，为什么大家都是白毛？"
	},
	{
		586001,
		14,
		"藏宝收集篇",
		1303001,
		"奥奇，和我一起踏上寻宝之旅吧！"
	},
	{
		586001,
		15,
		"藏宝收集篇",
		1303001,
		"您猜怎么着，这可都是压箱底的好东西！"
	},
	{
		586001,
		16,
		"藏宝收集篇",
		1303001,
		"师父说过，可以不用，但不能没有！"
	},
	{
		586001,
		17,
		"藏宝收集篇",
		1303001,
		"顶奢服饰，这好像在客栈里见他们炫耀过！"
	},
	{
		586001,
		18,
		"藏宝收集篇",
		1303001,
		"少侠，这身衣裳敢问有无链接？"
	},
	{
		586001,
		19,
		"武林高手篇",
		1702904,
		"少侠，敢来与我过两招？"
	},
	{
		586001,
		20,
		"武林高手篇",
		1702904,
		"哼……奥奇，这些就是你的得力干将，对吧？"
	},
	{
		586001,
		21,
		"武林高手篇",
		1702904,
		"奥奇，你果然配得上传闻里的称号：%s"
	},
	{
		586001,
		22,
		"武林高手篇",
		1702904,
		"比武争锋，到时候在武力大会实力见真章！"
	},
	{
		586001,
		23,
		"武林高手篇",
		1702904,
		"高手，就是如此战无不胜攻无不克！"
	}
}
local t_five_year_recap_page = {
	[586001] = {
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
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23]
	}
}

t_five_year_recap_page.dataList = dataList

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

return t_five_year_recap_page
