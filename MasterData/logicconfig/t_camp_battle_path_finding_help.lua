-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_path_finding_help.lua

module("logicconfig.config.t_camp_battle_path_finding_help", package.seeall)

local title = {
	awakenLv = 8,
	lv = 6,
	creepsId = 3,
	onlyUseExtProperties = 11,
	campId = 2,
	extproperties = 10,
	talentLv = 7,
	faceId = 12,
	equipment = 9,
	creepsName = 5,
	raceId = 4,
	activityId = 1
}
local dataList = {
	{
		187001,
		1,
		1000000001,
		13004,
		"绝息者·楼那",
		100,
		0,
		0,
		"",
		"生命+6153#攻击+2523#物防+369#魔防+400#速度+369",
		true,
		""
	},
	{
		187001,
		2,
		1000000002,
		13003,
		"神祇·阿瑞斯",
		100,
		0,
		0,
		"",
		"生命+10461#攻击+1969#物防+646#魔防+646#速度+276",
		true,
		""
	},
	{
		187001,
		3,
		1000000003,
		17003,
		"天元·王者圣龙",
		100,
		0,
		0,
		"",
		"生命+6153#攻击+2523#物防+400#魔防+369#速度+369",
		true,
		""
	},
	{
		187002,
		1,
		1000000001,
		13004,
		"绝息者·楼那",
		100,
		0,
		0,
		"",
		"生命+6153#攻击+2523#物防+369#魔防+400#速度+369",
		true,
		""
	},
	{
		187002,
		2,
		1000000002,
		13003,
		"神祇·阿瑞斯",
		100,
		0,
		0,
		"",
		"生命+10461#攻击+1969#物防+646#魔防+646#速度+276",
		true,
		""
	},
	{
		187002,
		3,
		1000000003,
		17003,
		"天元·王者圣龙",
		100,
		0,
		0,
		"",
		"生命+6153#攻击+2523#物防+400#魔防+369#速度+369",
		true,
		""
	}
}
local t_camp_battle_path_finding_help = {
	[187001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[187002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_camp_battle_path_finding_help.dataList = dataList

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

return t_camp_battle_path_finding_help
