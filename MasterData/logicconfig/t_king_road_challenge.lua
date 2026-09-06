-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_road_challenge.lua

module("logicconfig.config.t_king_road_challenge", package.seeall)

local title = {
	challengeId = 1,
	verifyPlanId = 6,
	zdlLimit = 3,
	challengeDes = 4,
	petId = 5,
	challengeName = 2
}
local dataList = {
	{
		1,
		"爆甲吉斯",
		1,
		"战力大于1开启",
		10018,
		0
	},
	{
		2,
		"撒古特",
		6500,
		"战力大于6500开启",
		10016,
		0
	},
	{
		3,
		"寒冰骑士",
		20000,
		"战力大于20000开启",
		10017,
		0
	},
	{
		4,
		"卡雅公主",
		40000,
		"战力大于40000开启",
		10019,
		0
	},
	{
		5,
		"暗影所罗",
		60000,
		"战力大于60000开启",
		10072,
		0
	},
	{
		6,
		"怨毒灵宝",
		80000,
		"战力大于80000开启",
		10020,
		0
	},
	{
		7,
		"海赛斯",
		120000,
		"战力大于120000开启",
		10075,
		0
	},
	{
		8,
		"圣光飞龙",
		180000,
		"战力大于180000开启",
		10027,
		4
	}
}
local t_king_road_challenge = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_king_road_challenge.dataList = dataList

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

return t_king_road_challenge
