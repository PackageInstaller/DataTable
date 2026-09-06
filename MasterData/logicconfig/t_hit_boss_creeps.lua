-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_creeps.lua

module("logicconfig.config.t_hit_boss_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
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
	creepsMasterId = 1,
	showIndex = 15,
	lv = 6
}
local dataList = {
	{
		1001,
		1,
		98001,
		"凋亡神骸·凡尔维斯",
		5,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+200000#物防+100000#魔防+100000#速度+0",
		true,
		"",
		"",
		"",
		""
	},
	{
		1002,
		1,
		92022,
		"奇迹炙焰·龙炎",
		5,
		100,
		0,
		0,
		"",
		"生命+1000000000#攻击+400000#物防+0#魔防+0#速度+0",
		true,
		"",
		"",
		"",
		""
	}
}
local t_hit_boss_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	}
}

t_hit_boss_creeps.dataList = dataList

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

return t_hit_boss_creeps
