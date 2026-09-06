-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_zone.lua

module("logicconfig.config.t_saint_knight_expedition_zone", package.seeall)

local title = {
	farBg = 11,
	openTime = 4,
	zoneId = 2,
	skinId = 6,
	name = 3,
	middleBg = 10,
	pos = 8,
	creepsMasterId = 5,
	bossDesc = 12,
	nearBg = 9,
	bossTimes = 7,
	activityId = 1
}
local dataList = {
	{
		481001,
		1,
		"沙漠",
		"2025-05-30T05:00:00",
		1061,
		12020,
		3,
		{
			-413,
			-130
		},
		"copychapter/chapterbg/pinminku1",
		"copychapter/chapterbg/pinminku2",
		"copychapter/chapterbg/pinminku3",
		"己阵精灵每次出手后，受到10%生命上限的伤害(Boss)"
	},
	{
		481001,
		2,
		"大海",
		"2025-06-06T05:00:00",
		1062,
		12022,
		3,
		{
			175,
			-165
		},
		"copychapter/chapterbg/lanlongwan1",
		"copychapter/chapterbg/lanlongwan2",
		"copychapter/chapterbg/lanlongwan3",
		"每个大回合结束时，给己阵全部精灵随机1个debuff，含伤害-20%，受到伤害+20%，气势-20，可叠加"
	},
	{
		481001,
		3,
		"森林",
		"2025-06-13T05:00:00",
		1063,
		13008,
		3,
		{
			-140,
			95
		},
		"copychapter/chapterbg/chuangkonglianmeng1",
		"copychapter/chapterbg/chuangkonglianmeng3",
		"copychapter/chapterbg/chuangkonglianmeng2",
		"每个大回合结束时，敌阵全体恢复50点气势(Boss)"
	},
	{
		481001,
		4,
		"圣殿",
		"2025-06-20T05:00:00",
		1064,
		15023,
		3,
		{
			326,
			192
		},
		"copychapter/chapterbg/jinbihuanjing1",
		"copychapter/chapterbg/jinbihuanjing2",
		"copychapter/chapterbg/jinbihuanjing3",
		"敌方攻击时，若属性克制，则额外出手一次（每个大回合限1次）(Boss)"
	}
}
local t_saint_knight_expedition_zone = {
	[481001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_saint_knight_expedition_zone.dataList = dataList

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

return t_saint_knight_expedition_zone
