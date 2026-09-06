-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_pet_rank.lua

module("logicconfig.config.t_timed_challenge_pet_rank", package.seeall)

local title = {
	raceId = 1,
	rankSize = 2
}
local dataList = {
	{
		10144,
		1000
	},
	{
		10167,
		1000
	},
	{
		10326,
		9999
	},
	{
		10027,
		1000
	},
	{
		10147,
		9999
	},
	{
		10318,
		9999
	},
	{
		10338,
		9999
	},
	{
		10339,
		9999
	},
	{
		10165,
		9999
	},
	{
		10100,
		5999
	},
	{
		10179,
		9999
	},
	{
		10380,
		5999
	},
	{
		10333,
		9999
	},
	{
		10322,
		5999
	},
	{
		10098,
		5999
	},
	{
		10345,
		5999
	},
	{
		10099,
		5999
	},
	{
		10328,
		5999
	},
	{
		10097,
		5999
	},
	{
		10334,
		5999
	},
	{
		10332,
		9999
	},
	{
		14000,
		9999
	},
	{
		11000,
		9999
	},
	{
		10370,
		9999
	},
	{
		11002,
		9999
	},
	{
		10344,
		9999
	},
	{
		14004,
		9999
	},
	{
		10101,
		9999
	},
	{
		14009,
		9999
	},
	{
		12015,
		9999
	},
	{
		16012,
		9999
	},
	{
		13007,
		9999
	},
	{
		15023,
		9999
	}
}
local t_timed_challenge_pet_rank = {
	[10144] = dataList[1],
	[10167] = dataList[2],
	[10326] = dataList[3],
	[10027] = dataList[4],
	[10147] = dataList[5],
	[10318] = dataList[6],
	[10338] = dataList[7],
	[10339] = dataList[8],
	[10165] = dataList[9],
	[10100] = dataList[10],
	[10179] = dataList[11],
	[10380] = dataList[12],
	[10333] = dataList[13],
	[10322] = dataList[14],
	[10098] = dataList[15],
	[10345] = dataList[16],
	[10099] = dataList[17],
	[10328] = dataList[18],
	[10097] = dataList[19],
	[10334] = dataList[20],
	[10332] = dataList[21],
	[14000] = dataList[22],
	[11000] = dataList[23],
	[10370] = dataList[24],
	[11002] = dataList[25],
	[10344] = dataList[26],
	[14004] = dataList[27],
	[10101] = dataList[28],
	[14009] = dataList[29],
	[12015] = dataList[30],
	[16012] = dataList[31],
	[13007] = dataList[32],
	[15023] = dataList[33]
}

t_timed_challenge_pet_rank.dataList = dataList

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

return t_timed_challenge_pet_rank
