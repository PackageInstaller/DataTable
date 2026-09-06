-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mi_rui_ke_clg_support_pet.lua

module("logicconfig.config.t_divine_mi_rui_ke_clg_support_pet", package.seeall)

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
		381001,
		100000001,
		16025,
		"神曜奇迹·蜜蕊可",
		8,
		100,
		0,
		0,
		"",
		"生命+1210256#攻击+354432#物防+78667#魔防+72615#速度+72615",
		true,
		"",
		"",
		""
	},
	{
		381001,
		100000002,
		16025,
		"神曜奇迹·蜜蕊可",
		5,
		100,
		0,
		0,
		"",
		"生命+1210256#攻击+354432#物防+78667#魔防+72615#速度+72615",
		true,
		"",
		"",
		""
	},
	{
		381001,
		100000003,
		16025,
		"神曜奇迹·蜜蕊可",
		2,
		100,
		0,
		0,
		"",
		"生命+1210256#攻击+354432#物防+78667#魔防+72615#速度+72615",
		true,
		"",
		"",
		""
	}
}
local t_divine_mi_rui_ke_clg_support_pet = {
	[381001] = {
		[100000001] = dataList[1],
		[100000002] = dataList[2],
		[100000003] = dataList[3]
	}
}

t_divine_mi_rui_ke_clg_support_pet.dataList = dataList

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

return t_divine_mi_rui_ke_clg_support_pet
