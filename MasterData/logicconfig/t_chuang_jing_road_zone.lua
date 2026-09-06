-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_zone.lua

module("logicconfig.config.t_chuang_jing_road_zone", package.seeall)

local title = {
	hudPos = 8,
	lihuiPos = 6,
	zoneId = 2,
	bossType = 4,
	faceId = 5,
	desc = 3,
	imageUrl = 10,
	lihuiScale = 7,
	rankDesc = 9,
	activityId = 1
}
local dataList = {
	{
		396001,
		1,
		"光境试炼",
		1,
		14018,
		{
			0,
			-420
		},
		1,
		{
			-412,
			128
		},
		"按照最终通关此试炼的时间，从快到慢进行排名，五个榜单上榜互不影响\r\n前1000名可上榜，可获得头像框奖励",
		"story/story_bg/gal_y_25_1"
	},
	{
		396001,
		2,
		"水境试炼",
		2,
		11021,
		{
			0,
			-500
		},
		1,
		{
			-447,
			-93
		},
		"按照最终通关此试炼的时间，从快到慢进行排名，五个榜单上榜互不影响\r\n前1000名可上榜，可获得头像框奖励",
		"story/story_bg/gal_y_5_4"
	},
	{
		396001,
		3,
		"火境试炼",
		3,
		12018,
		{
			0,
			-550
		},
		1,
		{
			387,
			-130
		},
		"按照最终通关此试炼的时间，从快到慢进行排名，五个榜单上榜互不影响\r\n前1000名可上榜，可获得头像框奖励",
		"story/story_bg/gal_y_15_2"
	},
	{
		396001,
		4,
		"草境试炼",
		4,
		13009,
		{
			0,
			-420
		},
		1,
		{
			-68,
			-197
		},
		"按照最终通关此试炼的时间，从快到慢进行排名，五个榜单上榜互不影响\r\n前1000名可上榜，可获得头像框奖励",
		"story/story_bg/gal_y_18_4"
	},
	{
		396001,
		5,
		"暗境试炼",
		4,
		15018,
		{
			0,
			-610
		},
		1,
		{
			450,
			128
		},
		"按照最终通关此试炼的时间，从快到慢进行排名，五个榜单上榜互不影响\r\n前1000名可上榜，可获得头像框奖励",
		"story/story_bg/gal_z3_3"
	}
}
local t_chuang_jing_road_zone = {
	[396001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_chuang_jing_road_zone.dataList = dataList

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

return t_chuang_jing_road_zone
