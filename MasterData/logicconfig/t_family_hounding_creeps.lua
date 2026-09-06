-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_hounding_creeps.lua

module("logicconfig.config.t_family_hounding_creeps", package.seeall)

local title = {
	awakenLv = 8,
	raceId = 3,
	creepsId = 2,
	onlyUseExtProperties = 11,
	extproperties = 10,
	talentLv = 7,
	posId = 5,
	equipment = 9,
	creepsName = 4,
	creepsMasterId = 1,
	lv = 6
}
local dataList = {
	{
		1,
		1,
		91002,
		"神罚·秩序圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		2,
		1,
		90314,
		"烈焰·无烬圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		3,
		1,
		93008,
		"不朽枯木·永恒圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		4,
		1,
		90313,
		"万象·次元圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		5,
		1,
		95006,
		"无限时空·龙尊",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		6,
		1,
		96004,
		"星宙·超神圣龙",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	},
	{
		7,
		1,
		97002,
		"神爵·龙尊圣主",
		5,
		100,
		0,
		0,
		"",
		"生命+1500000000#攻击+500000#物防+0#魔防+0#速度+20000",
		true
	}
}
local t_family_hounding_creeps = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4]
	},
	{
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7]
	}
}

t_family_hounding_creeps.dataList = dataList

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

return t_family_hounding_creeps
