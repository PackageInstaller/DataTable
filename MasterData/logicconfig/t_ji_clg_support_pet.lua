-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_support_pet.lua

module("logicconfig.config.t_ji_clg_support_pet", package.seeall)

local title = {
	awakenLv = 6,
	raceId = 2,
	creepsId = 1,
	onlyUseExtProperties = 9,
	faceId = 12,
	summonedPetId = 11,
	talentLv = 5,
	summonMasterId = 10,
	equipment = 7,
	creepsName = 3,
	extproperties = 8,
	lv = 4
}
local dataList = {
	{
		100000001,
		14025,
		"奇迹光始·诺亚",
		100,
		15,
		6,
		"121114:5#122114:5#123114:5#124114:5",
		"",
		false,
		"",
		"",
		""
	},
	{
		100000002,
		11024,
		"奇迹陨星·帝释天",
		100,
		15,
		6,
		"111112:5#112112:5#113112:5#114112:5",
		"",
		false,
		"",
		"",
		""
	},
	{
		100000003,
		13019,
		"奇迹麓森·阿瑞斯",
		100,
		15,
		6,
		"131111:5#132111:5#133111:5#134111:5",
		"",
		false,
		"",
		"",
		""
	},
	{
		100000004,
		15025,
		"奇迹影蚀·修尔",
		100,
		15,
		6,
		"111115:5#112115:5#113115:5#114115:5",
		"",
		false,
		"",
		"",
		""
	},
	{
		100000005,
		12022,
		"奇迹炙焰·龙炎",
		100,
		15,
		6,
		"131113:5#132113:5#133113:5#134113:5",
		"",
		false,
		"",
		"",
		""
	}
}
local t_ji_clg_support_pet = {
	[100000001] = dataList[1],
	[100000002] = dataList[2],
	[100000003] = dataList[3],
	[100000004] = dataList[4],
	[100000005] = dataList[5]
}

t_ji_clg_support_pet.dataList = dataList

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

return t_ji_clg_support_pet
