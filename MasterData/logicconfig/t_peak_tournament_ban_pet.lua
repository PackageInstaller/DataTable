-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tournament_ban_pet.lua

module("logicconfig.config.t_peak_tournament_ban_pet", package.seeall)

local title = {
	playerBanRaceIdCount = 4,
	banRaceIdCount = 5,
	activityId = 1,
	notBanPlanId = 6,
	knockoutUseBanPet = 3,
	qualifyUseBanPet = 2
}
local dataList = {
	{
		217022,
		true,
		true,
		5,
		5,
		0
	},
	{
		217023,
		true,
		true,
		5,
		5,
		1
	},
	{
		217024,
		true,
		true,
		5,
		5,
		2
	},
	{
		217025,
		true,
		true,
		5,
		5,
		3
	},
	{
		217026,
		true,
		true,
		5,
		5,
		4
	},
	{
		217027,
		true,
		true,
		5,
		5,
		5
	},
	{
		217028,
		true,
		true,
		5,
		5,
		6
	},
	{
		217029,
		true,
		true,
		5,
		5,
		7
	},
	{
		217030,
		true,
		true,
		5,
		5,
		8
	},
	{
		217031,
		true,
		true,
		5,
		5,
		9
	},
	{
		217032,
		true,
		true,
		5,
		5,
		10
	},
	{
		217033,
		true,
		true,
		5,
		5,
		11
	},
	{
		217034,
		true,
		true,
		5,
		5,
		0
	},
	{
		217035,
		true,
		true,
		5,
		5,
		0
	},
	{
		217036,
		true,
		true,
		5,
		5,
		0
	},
	{
		217037,
		true,
		true,
		5,
		5,
		0
	},
	{
		217038,
		true,
		true,
		5,
		5,
		0
	},
	{
		217039,
		true,
		true,
		5,
		5,
		0
	},
	{
		217040,
		true,
		true,
		5,
		5,
		0
	},
	{
		217041,
		true,
		true,
		5,
		5,
		0
	},
	{
		217042,
		true,
		true,
		5,
		5,
		0
	},
	{
		217043,
		true,
		true,
		5,
		5,
		0
	},
	{
		217044,
		true,
		true,
		5,
		5,
		0
	},
	{
		217045,
		true,
		true,
		5,
		5,
		0
	},
	{
		217046,
		true,
		true,
		5,
		5,
		0
	},
	{
		217047,
		true,
		true,
		5,
		5,
		0
	},
	{
		217048,
		true,
		true,
		5,
		5,
		0
	}
}
local t_peak_tournament_ban_pet = {
	[217022] = dataList[1],
	[217023] = dataList[2],
	[217024] = dataList[3],
	[217025] = dataList[4],
	[217026] = dataList[5],
	[217027] = dataList[6],
	[217028] = dataList[7],
	[217029] = dataList[8],
	[217030] = dataList[9],
	[217031] = dataList[10],
	[217032] = dataList[11],
	[217033] = dataList[12],
	[217034] = dataList[13],
	[217035] = dataList[14],
	[217036] = dataList[15],
	[217037] = dataList[16],
	[217038] = dataList[17],
	[217039] = dataList[18],
	[217040] = dataList[19],
	[217041] = dataList[20],
	[217042] = dataList[21],
	[217043] = dataList[22],
	[217044] = dataList[23],
	[217045] = dataList[24],
	[217046] = dataList[25],
	[217047] = dataList[26],
	[217048] = dataList[27]
}

t_peak_tournament_ban_pet.dataList = dataList

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

return t_peak_tournament_ban_pet
