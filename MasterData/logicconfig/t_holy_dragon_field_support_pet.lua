-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dragon_field_support_pet.lua

module("logicconfig.config.t_holy_dragon_field_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	extproperties = 9,
	creepsId = 2,
	supportPetPlan = 1,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	onlyUseExtProperties = 10,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		1,
		100000001,
		14045,
		"天罗诸界·次元龙尊",
		100,
		0,
		0,
		"",
		"生命+1230769#攻击+504615#物防+73846#魔防+80000#速度+73846",
		true,
		"",
		"",
		""
	},
	{
		2,
		100000001,
		14046,
		"昼辉天临·黄金圣龙",
		100,
		0,
		0,
		"",
		"生命+2707692#攻击+295385#物防+160000#魔防+160000#速度+49231",
		true,
		"",
		"",
		""
	},
	{
		3,
		100000001,
		14049,
		"凌空引啸·圣光飞龙",
		100,
		0,
		0,
		"",
		"生命+1476923#攻击+418462#物防+80000#魔防+80000#速度+86154",
		true,
		"",
		"",
		""
	}
}
local t_holy_dragon_field_support_pet = {
	{
		[100000001] = dataList[1]
	},
	{
		[100000001] = dataList[2]
	},
	{
		[100000001] = dataList[3]
	}
}

t_holy_dragon_field_support_pet.dataList = dataList

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

return t_holy_dragon_field_support_pet
