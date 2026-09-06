-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_support.lua

module("logicconfig.config.t_divine_god_dragon_support", package.seeall)

local title = {
	raceId = 2,
	maxHp = 11,
	creepsId = 1,
	onlyUseExtProperties = 7,
	faceId = 10,
	summonedPetId = 9,
	posId = 4,
	summonMasterId = 8,
	creepsName = 3,
	extproperties = 6,
	lv = 5
}
local dataList = {
	{
		100001,
		16022,
		"神曜星宙·超神圣龙",
		3,
		100,
		"生命+393332#攻击+161266#物防+23599#魔防+25566#速度+23599",
		true,
		"",
		"",
		"",
		""
	},
	{
		100002,
		15026,
		"神曜殛主·安",
		1,
		100,
		"生命+836923#攻击+157538#物防+51692#魔防+51692#速度+22153",
		true,
		"",
		"",
		"",
		""
	}
}
local t_divine_god_dragon_support = {
	[100001] = dataList[1],
	[100002] = dataList[2]
}

t_divine_god_dragon_support.dataList = dataList

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

return t_divine_god_dragon_support
