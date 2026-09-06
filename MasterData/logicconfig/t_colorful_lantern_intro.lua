-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_colorful_lantern_intro.lua

module("logicconfig.config.t_colorful_lantern_intro", package.seeall)

local title = {
	leftTopTxt = 3,
	leftBottonTitle = 4,
	leftBottonTxt = 5,
	rightTitle = 7,
	leftTopTitle = 2,
	pageId = 1,
	rightResName = 6
}
local dataList = {
	{
		1,
		"彩灯文化介绍",
		"从当年唐明皇为庆祝太平盛世扎结花灯，希望借助明亮闪烁的灯光，预示彩龙兆祥、国泰民安，到如今祖国强盛、民族兴旺，彩灯花灯进入了千家万户。彩灯，以其色彩绚丽的视觉效果，勾画出幸福生活的美好蓝图，预示着新年伊始的如意吉祥，并寄寓着人们对未来的美好祝愿。",
		"奥奇×彩灯联动",
		"彩灯艺术具有浓郁的民族地方特色，作为一种历史悠久的民间艺术，它的存在与发展，跟丰富的民俗节庆活动紧密相联。\r\n本次奥奇传说与彩灯文化联动，正值金秋九月，寄托了所有小奥奇们对美好生活的展望——明月生辉，一年初望，花灯如昼，合家团圆。",
		"icon_shenqi_guanglun_04",
		"传统彩灯照片"
	}
}
local t_colorful_lantern_intro = {
	dataList[1]
}

t_colorful_lantern_intro.dataList = dataList

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

return t_colorful_lantern_intro
