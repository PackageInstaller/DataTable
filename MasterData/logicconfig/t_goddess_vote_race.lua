-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_vote_race.lua

module("logicconfig.config.t_goddess_vote_race", package.seeall)

local title = {
	activityId = 1,
	raceId = 2
}
local dataList = {
	{
		127001,
		16005
	},
	{
		127001,
		11003
	},
	{
		127001,
		14004
	},
	{
		127001,
		10334
	},
	{
		127001,
		10328
	},
	{
		127001,
		10345
	},
	{
		127001,
		11001
	},
	{
		127001,
		10370
	},
	{
		127001,
		14001
	},
	{
		127001,
		10343
	},
	{
		127001,
		10332
	},
	{
		127001,
		10329
	},
	{
		127001,
		10327
	},
	{
		127001,
		10323
	},
	{
		127001,
		10322
	},
	{
		127001,
		10309
	},
	{
		127001,
		10308
	},
	{
		127001,
		10167
	},
	{
		127001,
		10147
	},
	{
		127001,
		10097
	},
	{
		127001,
		10352
	},
	{
		127001,
		10206
	},
	{
		127001,
		10204
	}
}
local t_goddess_vote_race = {
	[127001] = {
		[16005] = dataList[1],
		[11003] = dataList[2],
		[14004] = dataList[3],
		[10334] = dataList[4],
		[10328] = dataList[5],
		[10345] = dataList[6],
		[11001] = dataList[7],
		[10370] = dataList[8],
		[14001] = dataList[9],
		[10343] = dataList[10],
		[10332] = dataList[11],
		[10329] = dataList[12],
		[10327] = dataList[13],
		[10323] = dataList[14],
		[10322] = dataList[15],
		[10309] = dataList[16],
		[10308] = dataList[17],
		[10167] = dataList[18],
		[10147] = dataList[19],
		[10097] = dataList[20],
		[10352] = dataList[21],
		[10206] = dataList[22],
		[10204] = dataList[23]
	}
}

t_goddess_vote_race.dataList = dataList

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

return t_goddess_vote_race
