-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_round.lua

module("logicconfig.config.t_survival_king_round", package.seeall)

local title = {
	groupId = 3,
	activityId = 1,
	roundId = 2,
	levelBuffEffect = 4
}
local dataList = {
	{
		529001,
		1,
		1,
		false
	},
	{
		529001,
		2,
		1,
		false
	},
	{
		529001,
		3,
		2,
		true
	},
	{
		529001,
		4,
		2,
		true
	},
	{
		529002,
		1,
		1,
		false
	},
	{
		529002,
		2,
		1,
		true
	},
	{
		529002,
		3,
		2,
		true
	},
	{
		529002,
		4,
		2,
		false
	}
}
local t_survival_king_round = {
	[529001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[529002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_survival_king_round.dataList = dataList

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

return t_survival_king_round
