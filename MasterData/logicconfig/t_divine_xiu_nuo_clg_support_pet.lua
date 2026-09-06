-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_nuo_clg_support_pet.lua

module("logicconfig.config.t_divine_xiu_nuo_clg_support_pet", package.seeall)

local title = {
	awakenLv = 8,
	lv = 6,
	creepsId = 2,
	onlyUseExtProperties = 11,
	faceId = 14,
	summonedPetId = 13,
	posId = 5,
	summonMasterId = 12,
	equipment = 9,
	creepsName = 4,
	talentLv = 7,
	extproperties = 10,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		395001,
		100000001,
		15018,
		"神曜魅冥·修尔",
		5,
		100,
		0,
		0,
		"",
		"生命+295385#攻击+59780#物防+16000#魔防+16000#速度+17231",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000002,
		15018,
		"神曜魅冥·修尔",
		2,
		100,
		0,
		0,
		"",
		"生命+369231#攻击+74725#物防+20000#魔防+20000#速度+21538",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000003,
		15018,
		"神曜魅冥·修尔",
		8,
		100,
		0,
		0,
		"",
		"生命+443077#攻击+89670#物防+24000#魔防+24000#速度+25846",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000004,
		15018,
		"神曜魅冥·修尔",
		9,
		100,
		0,
		0,
		"",
		"生命+516923#攻击+104616#物防+28000#魔防+28000#速度+30154",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000005,
		15018,
		"神曜魅冥·修尔",
		6,
		100,
		0,
		0,
		"",
		"生命+590769#攻击+119561#物防+32000#魔防+32000#速度+34462",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000006,
		14018,
		"神曜时隙·诺亚",
		3,
		100,
		0,
		0,
		"",
		"生命+923077#攻击+270330#物防+55385#魔防+60000#速度+55385",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000007,
		14018,
		"神曜时隙·诺亚",
		1,
		100,
		0,
		0,
		"",
		"生命+984615#攻击+403692#物防+59077#魔防+64000#速度+59077",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000008,
		14018,
		"神曜时隙·诺亚",
		2,
		100,
		0,
		0,
		"",
		"生命+1046154#攻击+428923#物防+62769#魔防+68000#速度+62769",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000009,
		14018,
		"神曜时隙·诺亚",
		4,
		100,
		0,
		0,
		"",
		"生命+1107692#攻击+454154#物防+66462#魔防+72000#速度+66462",
		true,
		"",
		"",
		""
	},
	{
		395001,
		100000010,
		14018,
		"神曜时隙·诺亚",
		5,
		100,
		0,
		0,
		"",
		"生命+1169231#攻击+479385#物防+70154#魔防+76000#速度+70154",
		true,
		"",
		"",
		""
	}
}
local t_divine_xiu_nuo_clg_support_pet = {
	[395001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3],
		[100000004] = dataList[4],
		[100000005] = dataList[5],
		[100000006] = dataList[6],
		[100000007] = dataList[7],
		[100000008] = dataList[8],
		[100000009] = dataList[9],
		[100000010] = dataList[10]
	}
}

t_divine_xiu_nuo_clg_support_pet.dataList = dataList

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

return t_divine_xiu_nuo_clg_support_pet
