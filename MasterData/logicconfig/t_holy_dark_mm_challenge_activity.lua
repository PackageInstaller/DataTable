-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dark_mm_challenge_activity.lua

module("logicconfig.config.t_holy_dark_mm_challenge_activity", package.seeall)

local title = {
	activityId = 1,
	jump_rank = 6,
	petRaceIds = 3,
	detailDesc = 9,
	stageNum = 2,
	jump_give = 11,
	giftItem = 7,
	money = 10,
	raceId = 4,
	jump_gift = 5,
	giftDesc = 8
}
local dataList = {
	{
		284001,
		3,
		{
			15016,
			12017,
			11009,
			13007,
			14015,
			11010
		},
		15016,
		"mibao#shenyaolibao",
		"func#618#15016",
		"4:84390:1",
		"神曜材料特惠",
		"每收集一只神曜梦之队精灵将给我方全属性提升，最高可提升500%",
		"4:510184:1",
		"func#43#105"
	},
	{
		284002,
		3,
		{
			15016,
			12017,
			11009,
			13007,
			14015,
			11010
		},
		11026,
		"mibao#jinglingyangcheng",
		"func#618#11026",
		"",
		"购月卡送秩序",
		"",
		"",
		"func#545#22"
	}
}
local t_holy_dark_mm_challenge_activity = {
	[284001] = dataList[1],
	[284002] = dataList[2]
}

t_holy_dark_mm_challenge_activity.dataList = dataList

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

return t_holy_dark_mm_challenge_activity
