-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qi_challenge_all.lua

module("logicconfig.config.t_qi_challenge_all", package.seeall)

local title = {
	challengeId = 2,
	creepsMasterId = 3,
	allPlanId = 1,
	prize = 5,
	hard = 4
}
local dataList = {
	{
		1,
		1,
		201,
		1,
		"4:168:40"
	},
	{
		1,
		2,
		202,
		2,
		"4:168:80"
	},
	{
		1,
		3,
		203,
		3,
		"4:168:120"
	}
}
local t_qi_challenge_all = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_qi_challenge_all.dataList = dataList

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

return t_qi_challenge_all
