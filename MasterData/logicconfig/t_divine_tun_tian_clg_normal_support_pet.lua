-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tun_tian_clg_normal_support_pet.lua

module("logicconfig.config.t_divine_tun_tian_clg_normal_support_pet", package.seeall)

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
		11030,
		"神曜吞天·兰德斯",
		100,
		0,
		0,
		"",
		"生命+399384#攻击+31121#物防+23600#魔防+23600#速度+7261",
		true,
		"",
		"",
		""
	}
}
local t_divine_tun_tian_clg_normal_support_pet = {
	[100000001] = dataList[1]
}

t_divine_tun_tian_clg_normal_support_pet.dataList = dataList

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

return t_divine_tun_tian_clg_normal_support_pet
