-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_light_dark_dragon_activity.lua

module("logicconfig.config.t_light_dark_dragon_activity", package.seeall)

local title = {
	supportSweep = 6,
	redPointId = 4,
	dailySignPlanId = 5,
	gotoCall = 9,
	gotoRank = 7,
	gotoMibao = 8,
	buffPlanId = 3,
	params = 10,
	activityId = 1,
	challengePlanId = 2
}
local dataList = {
	{
		110001,
		1,
		0,
		195,
		0,
		true,
		"func#618#15014",
		"mibao#xinchun2",
		"func#798"
	},
	{
		110002,
		2,
		0,
		201,
		1,
		false,
		"func#618#15014",
		"mibao#xinchun2",
		"func#798"
	},
	{
		110005,
		3,
		0,
		473,
		0,
		true,
		"func#618#16017",
		"mibao#zhouniantehui2",
		"func#851"
	},
	{
		110008,
		4,
		0,
		473,
		0,
		true,
		"func#618#11022",
		"mibao#xinqionglongming4",
		"",
		{
			rankJump = "func#618#11022",
			exchangeJump = "func#191#110#110008",
			shenyaoJump = "mibao#shenyaolibao",
			raceId = 11022,
			quanEJump = "func#545#3"
		}
	},
	{
		110009,
		5,
		0,
		695,
		0,
		true,
		"func#618#15033",
		"mibao#Skin",
		"func#545#1",
		{
			rankJump = "func#618#15033",
			exchangeJump = "func#191#110#110009",
			shenyaoJump = "mibao#Skin",
			raceId = 15033,
			quanEJump = "func#545#1"
		}
	}
}
local t_light_dark_dragon_activity = {
	[110001] = dataList[1],
	[110002] = dataList[2],
	[110005] = dataList[3],
	[110008] = dataList[4],
	[110009] = dataList[5]
}

t_light_dark_dragon_activity.dataList = dataList

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

return t_light_dark_dragon_activity
