-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assist_team.lua

module("logicconfig.config.t_assist_team", package.seeall)

local title = {
	teamId = 1,
	commCost = 5,
	starCost = 6,
	teamName = 2,
	teamDes = 4,
	teamAttr = 3
}
local dataList = {
	{
		1,
		"生命守护",
		"草",
		"一大片青草",
		"4:4001",
		"4:4008"
	},
	{
		2,
		"智慧守护",
		"水",
		"白开水好喝不贵",
		"4:4002",
		"4:4009"
	},
	{
		3,
		"力量守护",
		"火",
		"冬天了需要烤火",
		"4:4003",
		"4:4010"
	},
	{
		4,
		"时间守护",
		"光",
		"奔跑吧圣光",
		"4:4004",
		"4:4011"
	},
	{
		5,
		"是非守护",
		"暗",
		"你脸太暗了",
		"4:4005",
		"4:4012"
	},
	{
		6,
		"虚无守护",
		"空",
		"空的？",
		"4:4006",
		"4:4013"
	},
	{
		7,
		"创造守护",
		"创",
		"创个撒",
		"4:4007",
		"4:4014"
	}
}
local t_assist_team = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_assist_team.dataList = dataList

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

return t_assist_team
