-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anchor_simulator_bullet_screen.lua

module("logicconfig.config.t_anchor_simulator_bullet_screen", package.seeall)

local title = {
	bulletId = 2,
	bulletPlanId = 1,
	desc = 4,
	skinId = 3
}
local dataList = {
	{
		1,
		1,
		17018,
		"主播头发会发光！用的什么洗发水？"
	},
	{
		1,
		2,
		16026,
		"截屏抽奖吗？我网速拉满了！"
	},
	{
		1,
		3,
		17019,
		"刚刚说的零食链接呢？刷三遍了"
	},
	{
		1,
		4,
		17020,
		"笑到邻居捶墙！主播赔隔音费"
	},
	{
		1,
		5,
		14027,
		"手速太快了！这是人类操作？"
	},
	{
		1,
		6,
		14028,
		"管理员踢下那个剧透的！"
	},
	{
		1,
		7,
		14029,
		"说方言！给你刷火箭"
	},
	{
		1,
		8,
		14030,
		"背后窗帘在动！有情况？"
	},
	{
		1,
		9,
		16023,
		"同城的举个手！主播请奶茶"
	},
	{
		1,
		10,
		12018,
		"突然黑屏？是我卡了吗？"
	},
	{
		1,
		11,
		12019,
		"学唱奥奇主题曲就续费会员！"
	},
	{
		1,
		12,
		11026,
		"今天美颜开太高了吧？"
	},
	{
		1,
		13,
		11027,
		"截到表情包了！已存相册"
	},
	{
		1,
		14,
		12027,
		"主播和榜一大哥撞衫了！"
	},
	{
		1,
		15,
		12028,
		"求同款手机壳！疯狂心动"
	},
	{
		1,
		16,
		13021,
		"刚刚飘过的是小诺的弹幕吗？"
	},
	{
		1,
		17,
		13022,
		"说好的跳舞呢？取关了"
	},
	{
		1,
		18,
		14023,
		"外卖到了！暂停5分钟"
	},
	{
		1,
		19,
		14014,
		"朋友问我为什么看直播笑成这样"
	},
	{
		1,
		20,
		14017,
		"这操作我看过！复制代码"
	},
	{
		1,
		21,
		14018,
		"主播是不是偷偷补妆了？"
	},
	{
		1,
		22,
		15018,
		"管理员发个福袋求求了"
	},
	{
		1,
		23,
		16010,
		"突然变安静？掉线了吗"
	},
	{
		1,
		24,
		16012,
		"新人求眼熟！弹幕护体"
	},
	{
		1,
		25,
		16013,
		"别下播！充电器借你"
	},
	{
		1,
		26,
		16016,
		"截到双下巴了！笑死"
	},
	{
		1,
		27,
		17014,
		"说英语！给你刷小心心"
	},
	{
		1,
		28,
		17016,
		"今天声音好哑？多喝水"
	},
	{
		1,
		29,
		17018,
		"键盘冒奶了！快擦擦"
	},
	{
		1,
		30,
		18001,
		"求翻牌！生日求祝福！"
	}
}
local t_anchor_simulator_bullet_screen = {
	{
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
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_anchor_simulator_bullet_screen.dataList = dataList

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

return t_anchor_simulator_bullet_screen
