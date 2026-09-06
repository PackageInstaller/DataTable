-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_eliminator_vote_plate.lua

module("logicconfig.config.t_peak_tournament_eliminator_vote_plate", package.seeall)

local title = {
	receiveVoteScore = 5,
	eliVotePlateId = 1,
	voteScoreDelta = 4,
	minVoteScore = 2,
	maxVoteScore = 3
}
local dataList = {
	{
		1,
		10,
		2000,
		10,
		100
	},
	{
		2,
		10,
		2000,
		10,
		100
	},
	{
		3,
		10,
		2000,
		10,
		200
	},
	{
		4,
		10,
		2000,
		10,
		200
	},
	{
		5,
		10,
		3000,
		10,
		300
	},
	{
		6,
		10,
		4000,
		10,
		400
	},
	{
		7,
		10,
		4000,
		10,
		500
	},
	{
		8,
		10,
		5000,
		10,
		600
	},
	{
		9,
		10,
		5000,
		10,
		200
	},
	{
		10,
		10,
		5000,
		10,
		200
	},
	{
		11,
		10,
		5000,
		10,
		300
	},
	{
		12,
		10,
		5000,
		10,
		400
	},
	{
		13,
		10,
		5000,
		10,
		500
	},
	{
		14,
		10,
		6000,
		10,
		600
	}
}
local t_peak_tournament_eliminator_vote_plate = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14]
}

t_peak_tournament_eliminator_vote_plate.dataList = dataList

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

return t_peak_tournament_eliminator_vote_plate
