-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_support_pet.lua

module("logicconfig.config.t_demon_descend_support_pet", package.seeall)

local title = {
	carriedPetId = 17,
	extproperties = 20,
	creepsId = 2,
	maxHp = 8,
	faceId = 9,
	summonedPetId = 11,
	talentLv = 6,
	onlyUseExtProperties = 21,
	summonMasterId = 10,
	holyStripeSuitName = 13,
	activityId = 1,
	cost = 7,
	oraclePetId = 19,
	fixedStarGodId = 12,
	imgUrl = 15,
	holyStripeSuitDesc = 14,
	creepsName = 4,
	raceId = 3,
	oracleMasterId = 18,
	lv = 5,
	carriedMasterId = 16
}
local dataList = {
	{
		497001,
		1000000001,
		12033,
		"神曜虚无·伏妖",
		100,
		0,
		"",
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+769231#攻击+225275#物防+46154#魔防+50000#速度+46154",
		true
	},
	{
		497001,
		1000000002,
		12034,
		"赤妖王·御神",
		100,
		0,
		"",
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+1307692#攻击+175824#物防+80769#魔防+80769#速度+34615",
		true
	},
	{
		497001,
		1000000003,
		12035,
		"神曜灭歌·路西法",
		100,
		0,
		"",
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+923077#攻击+186813#物防+50000#魔防+50000#速度+53846",
		true
	},
	{
		497001,
		1000000004,
		12036,
		"神曜戮魔·余灰",
		100,
		0,
		"",
		"",
		"",
		"1000000006",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+769231#攻击+225275#物防+50000#魔防+46154#速度+46154",
		true
	},
	{
		497001,
		1000000005,
		12037,
		"浴血罪冠·誓祖圣龙",
		100,
		0,
		"",
		"",
		"",
		"",
		"",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+1692308#攻击+131868#物防+100000#魔防+100000#速度+30769",
		true
	},
	{
		497001,
		1000000006,
		12009,
		"神曜莲火·末炎",
		100,
		0,
		"",
		"",
		"",
		"",
		"1000000004",
		nil,
		"",
		"",
		"",
		0,
		0,
		0,
		0,
		"生命+1307692#攻击+175824#物防+80769#魔防+80769#速度+34615",
		true
	}
}
local t_demon_descend_support_pet = {
	[497001] = {
		[1000000001] = dataList[1],
		[1000000002] = dataList[2],
		[1000000003] = dataList[3],
		[1000000004] = dataList[4],
		[1000000005] = dataList[5],
		[1000000006] = dataList[6]
	}
}

t_demon_descend_support_pet.dataList = dataList

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

return t_demon_descend_support_pet
