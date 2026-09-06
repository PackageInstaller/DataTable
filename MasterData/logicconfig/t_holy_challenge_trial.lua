-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_challenge_trial.lua

module("logicconfig.config.t_holy_challenge_trial", package.seeall)

local title = {
	challengeId = 3,
	relativeDay = 1,
	times = 2
}
local dataList = {
	{
		0,
		1,
		101
	},
	{
		0,
		2,
		102
	},
	{
		0,
		3,
		103
	},
	{
		0,
		4,
		104
	},
	{
		0,
		5,
		105
	}
}
local t_holy_challenge_trial = {
	[0] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_holy_challenge_trial.dataList = dataList

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

return t_holy_challenge_trial
