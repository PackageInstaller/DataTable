-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_creeps.lua

module("logicconfig.config.t_final_echo_creeps", package.seeall)

local title = {
	raceId = 3,
	creepsMasterId = 1,
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
		1001,
		1,
		96029,
		"神曜命星·梵天",
		5,
		100,
		"生命+2000000000#攻击+400000#物防+0#魔防+0#速度+10000",
		true,
		"",
		"",
		""
	},
	{
		1002,
		1,
		96035,
		"神曜圣谕·女帝",
		5,
		100,
		"生命+2000000000#攻击+400000#物防+0#魔防+0#速度+10000",
		true,
		"",
		"",
		""
	},
	{
		1003,
		1,
		96038,
		"乐律之神·音织",
		5,
		100,
		"生命+2000000000#攻击+400000#物防+0#魔防+0#速度+10000",
		true,
		"",
		"",
		""
	},
	{
		1004,
		1,
		91028,
		"浊流千幻·命渊圣龙",
		5,
		100,
		"生命+2000000000#攻击+400000#物防+0#魔防+0#速度+10000",
		true,
		"",
		"",
		""
	}
}
local t_final_echo_creeps = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	},
	[1003] = {
		dataList[3]
	},
	[1004] = {
		dataList[4]
	}
}

t_final_echo_creeps.dataList = dataList

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

return t_final_echo_creeps
