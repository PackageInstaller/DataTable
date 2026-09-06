-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_poster_jigsaw_poster.lua

module("logicconfig.config.t_poster_jigsaw_poster", package.seeall)

local title = {
	relativeOpenDays = 3,
	posterPlanId = 1,
	perActivateCost = 5,
	jigsawCount = 4,
	puzzleDesc = 10,
	iconPath = 8,
	posterId = 2,
	perActivatePrize = 6,
	bigPrize = 7,
	puzzleName = 9
}
local dataList = {
	{
		1,
		1,
		0,
		12,
		"10:134001:35",
		"8:1:10000",
		"4:90212:1",
		"board_pt_01",
		"传说精灵",
		"奥奇手游一岁啦！感谢小奥奇一直以来的支持，希望和你们一起度过漫长岁月！"
	},
	{
		1,
		2,
		0,
		12,
		"10:134001:35",
		"8:1:10000",
		"4:90213:1",
		"board_pt_02",
		"蜜蕊可精灵",
		"奥奇已经和大家度过了10年，小奥奇们也都长大了，共同期待下一个十年！"
	},
	{
		1,
		3,
		14,
		12,
		"10:134001:35",
		"8:1:10000",
		"4:84014:3",
		"board_pt_03",
		"蜜蕊可魂*3",
		"十年如一日，不忘初心，共同成长！"
	},
	{
		1,
		4,
		14,
		12,
		"10:134001:35",
		"8:1:10000",
		"4:84014:3",
		"board_pt_04",
		"蜜蕊可魂*3",
		"在这里我们许下下一个十年之约，明年今日，不见不散！"
	}
}
local t_poster_jigsaw_poster = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_poster_jigsaw_poster.dataList = dataList

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

return t_poster_jigsaw_poster
