-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_martial_contest_system_pet.lua

module("logicconfig.config.t_martial_contest_system_pet", package.seeall)

local title = {
	awakenLv = 7,
	talentLv = 6,
	creepsId = 1,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	posId = 4,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 3,
	extproperties = 9,
	bookSpiritRaceId = 14,
	raceId = 2,
	lv = 5
}
local dataList = {
	{
		10000001,
		17025,
		"通灵秘源·究",
		5,
		100,
		0,
		0,
		"",
		"生命+2249230#攻击+423384#物防+138923#魔防+138923#速度+59538",
		true,
		"",
		"",
		"",
		0
	},
	{
		10000002,
		17026,
		"万刃殁锋·殒劫圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1323076#攻击+542461#物防+86000#魔防+79384#速度+79384",
		true,
		"",
		"",
		"",
		0
	},
	{
		10000003,
		17027,
		"虚骸噬灭·薄伽丘",
		5,
		100,
		0,
		0,
		"",
		"生命+2910769#攻击+317538#物防+172000#魔防+172000#速度+52923",
		true,
		"",
		"",
		"",
		13030
	},
	{
		10000004,
		17028,
		"万相同观·权天使",
		5,
		100,
		0,
		0,
		"",
		"生命+1323076#攻击+542461#物防+86000#魔防+79384#速度+79384",
		true,
		"",
		"",
		"",
		0
	},
	{
		10000005,
		13030,
		"苍青圣骑·阿特拉斯",
		5,
		100,
		0,
		0,
		"",
		"生命+2910769#攻击+317538#物防+172000#魔防+172000#速度+52923",
		true,
		"",
		"",
		"",
		0
	}
}
local t_martial_contest_system_pet = {
	[10000001] = dataList[1],
	[10000002] = dataList[2],
	[10000003] = dataList[3],
	[10000004] = dataList[4],
	[10000005] = dataList[5]
}

t_martial_contest_system_pet.dataList = dataList

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

return t_martial_contest_system_pet
