-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recommend_psychic_formation.lua

module("logicconfig.config.t_recommend_psychic_formation", package.seeall)

local title = {
	id = 2,
	name = 5,
	isOnline = 6,
	fightId = 7,
	raceId = 1,
	desc = 8,
	target = 4,
	order = 3
}
local dataList = {
	{
		16009,
		1,
		11,
		5,
		"极",
		1,
		10044,
		"至极无量，万法唯识"
	},
	{
		16008,
		2,
		10,
		5,
		"蜜蕊可",
		1,
		10043,
		"心诚则灵，梦想成真"
	},
	{
		12005,
		3,
		9,
		2,
		"维蕾塔",
		1,
		10028,
		"双月之刃，凜光飞掠"
	},
	{
		13006,
		4,
		8,
		0,
		"盖西瑞",
		1,
		10032,
		"净化污浊，敬畏森林"
	},
	{
		17008,
		5,
		7,
		6,
		"弥娅",
		1,
		10037,
		"接受命运的裁决"
	},
	{
		11007,
		6,
		6,
		1,
		"天闪",
		1,
		10026,
		"风雷万箭"
	},
	{
		15013,
		7,
		5,
		4,
		"安",
		1,
		10040,
		"殛魔之怒，千里不息"
	},
	{
		16014,
		8,
		4,
		5,
		"尘",
		1,
		10042,
		"驭灵伐恶，弱者退散"
	},
	{
		12014,
		9,
		3,
		2,
		"伏妖",
		1,
		10046,
		"明生暗灭，炎堕虚无"
	},
	{
		15016,
		10,
		2,
		4,
		"暗黑",
		1,
		10047,
		"梦想起航"
	},
	{
		11014,
		11,
		1,
		1,
		"吞天",
		1,
		10048,
		"规则与法律由我确立"
	},
	{
		14017,
		12,
		1,
		3,
		"无敌",
		1,
		10052,
		"天上天下唯吾独尊"
	}
}
local t_recommend_psychic_formation = {
	[16009] = {
		dataList[1]
	},
	[16008] = {
		[2] = dataList[2]
	},
	[12005] = {
		[3] = dataList[3]
	},
	[13006] = {
		[4] = dataList[4]
	},
	[17008] = {
		[5] = dataList[5]
	},
	[11007] = {
		[6] = dataList[6]
	},
	[15013] = {
		[7] = dataList[7]
	},
	[16014] = {
		[8] = dataList[8]
	},
	[12014] = {
		[9] = dataList[9]
	},
	[15016] = {
		[10] = dataList[10]
	},
	[11014] = {
		[11] = dataList[11]
	},
	[14017] = {
		[12] = dataList[12]
	}
}

t_recommend_psychic_formation.dataList = dataList

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

return t_recommend_psychic_formation
