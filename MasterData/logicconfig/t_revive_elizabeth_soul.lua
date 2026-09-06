-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_revive_elizabeth_soul.lua

module("logicconfig.config.t_revive_elizabeth_soul", package.seeall)

local title = {
	flowerIcon = 3,
	flowerContent = 4,
	activityId = 1,
	flowerId = 2
}
local dataList = {
	{
		416001,
		1,
		"icon_ziluolan",
		"紫罗兰：经过寒冷的冬季才能盛开，代表着坚韧不拔、心志坚定、不轻易放弃"
	},
	{
		416001,
		2,
		"icon_yujinxiang",
		"粉色郁金香：它象征着永远的爱、纯情的少女之心、爱的浪漫以及美好和希望"
	},
	{
		416001,
		3,
		"icon_songhua02",
		"紫玫瑰：梦幻、安静、等待，象征对爱情的坚守和保护；表达去成熟的爱，对方幸福比自己更重要"
	},
	{
		416001,
		4,
		"icon_zixiuqiu",
		"紫色绣球花：在春季盛开，象征着希望和生机，其花朵紧密团团结，永不分离，象征着忠诚的爱情"
	},
	{
		416001,
		5,
		"icon_sh_hua02",
		"粉月季：纯真与美好、优雅与高贵，也代表着深深的感谢之情"
	},
	{
		416001,
		6,
		"com_icon_boyige",
		"紫桔梗：有着细致脆弱的花瓣，它既是永恒，也是无望，代表表着永恒无望的爱"
	}
}
local t_revive_elizabeth_soul = {
	[416001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_revive_elizabeth_soul.dataList = dataList

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

return t_revive_elizabeth_soul
