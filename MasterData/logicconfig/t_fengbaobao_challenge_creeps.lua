-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_creeps.lua

module("logicconfig.config.t_fengbaobao_challenge_creeps", package.seeall)

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
	lv = 6
}
local dataList = {
	{
		1,
		1,
		90381,
		"王也",
		5,
		100,
		0,
		0,
		"",
		"生命+45919351#攻击+7956#物防+1041#魔防+1273#速度+4167",
		true,
		"",
		"",
		""
	}
}
local t_fengbaobao_challenge_creeps = {
	{
		dataList[1]
	}
}

t_fengbaobao_challenge_creeps.dataList = dataList

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

return t_fengbaobao_challenge_creeps
