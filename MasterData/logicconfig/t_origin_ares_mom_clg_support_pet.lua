-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_support_pet.lua

module("logicconfig.config.t_origin_ares_mom_clg_support_pet", package.seeall)

local title = {
	activityId = 1,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 8,
	faceId = 11,
	summonedPetId = 10,
	posId = 5,
	summonMasterId = 9,
	creepsName = 4,
	extproperties = 7,
	lv = 6
}
local dataList = {
	{
		549001,
		100000001,
		13025,
		"盈沃生息·盖西瑞",
		5,
		100,
		"生命+183076#攻击+24615#物防+11307#魔防+11307#速度+4846",
		true,
		"",
		"",
		""
	}
}
local t_origin_ares_mom_clg_support_pet = {
	[549001] = {
		[100000001] = dataList[1]
	}
}

t_origin_ares_mom_clg_support_pet.dataList = dataList

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

return t_origin_ares_mom_clg_support_pet
