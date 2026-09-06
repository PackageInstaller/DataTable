-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_dark_mm_challenge_master.lua

module("logicconfig.config.t_holy_dark_mm_challenge_master", package.seeall)

local title = {
	description = 7,
	video = 8,
	name = 2,
	skipTime = 3,
	perfectWinId = 11,
	formCondition = 12,
	btlMode = 6,
	btlBg = 4,
	selfBuffProviderId = 13,
	enableGainExp = 14,
	winId = 10,
	creepsMasterId = 1,
	heroSkillId = 5,
	introdRaceId = 9
}
local dataList = {
	{
		101,
		"关卡1",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		102,
		"关卡2",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		103,
		"关卡3",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		104,
		"关卡4",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		105,
		"关卡5",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		201,
		"关卡1",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		202,
		"关卡2",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		203,
		"关卡3",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		204,
		"关卡4",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	},
	{
		205,
		"关卡5",
		5,
		"",
		"",
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		false
	}
}
local t_holy_dark_mm_challenge_master = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[104] = dataList[4],
	[105] = dataList[5],
	[201] = dataList[6],
	[202] = dataList[7],
	[203] = dataList[8],
	[204] = dataList[9],
	[205] = dataList[10]
}

t_holy_dark_mm_challenge_master.dataList = dataList

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

return t_holy_dark_mm_challenge_master
