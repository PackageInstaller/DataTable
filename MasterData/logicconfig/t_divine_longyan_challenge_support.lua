-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_longyan_challenge_support.lua

module("logicconfig.config.t_divine_longyan_challenge_support", package.seeall)

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
		"龙炎",
		12018,
		"神曜狂焰·龙炎",
		1,
		0,
		0,
		"",
		"攻击+1",
		"",
		"",
		"",
		""
	}
}
local t_divine_longyan_challenge_support = {
	[100001] = dataList[1]
}

t_divine_longyan_challenge_support.dataList = dataList

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

return t_divine_longyan_challenge_support
