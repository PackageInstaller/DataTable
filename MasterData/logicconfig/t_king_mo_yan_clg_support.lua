-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_mo_yan_clg_support.lua

module("logicconfig.config.t_king_mo_yan_clg_support", package.seeall)

local title = {
	awakenLv = 7,
	lable = 2,
	creepsId = 1,
	maxHp = 12,
	faceId = 13,
	summonedPetId = 11,
	talentLv = 6,
	extproperties = 9,
	equipment = 8,
	creepsName = 4,
	summonMasterId = 10,
	raceId = 3,
	lv = 5
}
local dataList = {
	{
		100001,
		"炽莲王者·末炎",
		12023,
		"炽莲王者·末炎",
		100,
		0,
		0,
		"",
		"生命+968203#攻击+283545#物防+58092#魔防+62933#速度+58092",
		"",
		"",
		"",
		""
	}
}
local t_king_mo_yan_clg_support = {
	[100001] = dataList[1]
}

t_king_mo_yan_clg_support.dataList = dataList

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

return t_king_mo_yan_clg_support
