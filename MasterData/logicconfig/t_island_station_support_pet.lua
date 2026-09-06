-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_support_pet.lua

module("logicconfig.config.t_island_station_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	lv = 5,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	extproperties = 9,
	carriedPetId = 15,
	raceId = 3,
	activityId = 1,
	carriedMasterId = 14
}
local dataList = {
	{
		487001,
		100000001,
		14035,
		"神曜圣骑·审判光轮",
		100,
		0,
		0,
		"",
		"生命+1569230#攻击+210989#物防+96923#魔防+96923#速度+41538",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		487001,
		100000002,
		12031,
		"神曜圣骑·红莲烈心",
		100,
		0,
		0,
		"",
		"生命+923076#攻击+270329#物防+55384#魔防+60000#速度+55384",
		true,
		"100000003",
		"",
		"",
		0,
		0
	},
	{
		487001,
		100000003,
		13024,
		"神曜圣骑·万象迷踪",
		100,
		0,
		0,
		"",
		"生命+2030769#攻击+158241#物防+120000#魔防+120000#速度+36923",
		true,
		"",
		"100000002",
		"",
		0,
		0
	},
	{
		487001,
		100000004,
		12032,
		"神曜圣骑·怒麟炎神",
		100,
		0,
		0,
		"",
		"生命+1569230#攻击+210989#物防+96923#魔防+96923#速度+41538",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		487001,
		100000005,
		15035,
		"神曜圣骑·疾刃阎罗",
		100,
		0,
		0,
		"",
		"生命+923076#攻击+270329#物防+60000#魔防+55384#速度+55384",
		true,
		"",
		"",
		"",
		0,
		0
	},
	{
		487001,
		100000006,
		11029,
		"神曜圣骑·苍穹天闪",
		100,
		0,
		0,
		"",
		"生命+1107692#攻击+224176#物防+60000#魔防+60000#速度+64615",
		true,
		"",
		"",
		"",
		0,
		0
	}
}
local t_island_station_support_pet = {
	[487001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6]
	}
}

t_island_station_support_pet.dataList = dataList

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

return t_island_station_support_pet
