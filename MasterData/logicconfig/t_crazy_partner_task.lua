-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_crazy_partner_task.lua

module("logicconfig.config.t_crazy_partner_task", package.seeall)

local title = {
	score = 7,
	detectorParam = 6,
	resultDesc = 4,
	type = 5,
	battleTaskId = 8,
	desc = 3,
	difficulty = 2,
	taskId = 1
}
local dataList = {
	{
		101,
		1,
		"简单模式，上阵2种属性精灵",
		"上阵2种属性精灵",
		1,
		"2",
		40,
		1
	},
	{
		102,
		2,
		"普通模式，存活回合数达到12回合",
		"存活回合数达到12回合",
		5,
		"12",
		60,
		2
	},
	{
		103,
		3,
		"困难模式，超杀次数达到20次",
		"超杀次数达到20次",
		6,
		"20",
		100,
		3
	},
	{
		201,
		1,
		"简单模式，2号位和8号位上阵精灵",
		"2号位和8号位上阵精灵",
		4,
		"2,8",
		40,
		4
	},
	{
		202,
		2,
		"普通模式，超杀次数达到12次",
		"超杀次数达到12次",
		6,
		"12",
		60,
		5
	},
	{
		203,
		3,
		"困难模式，暴击次数达到5次",
		"暴击次数达到5次",
		3,
		"5",
		100,
		6
	},
	{
		301,
		1,
		"简单模式，存活回合数达到12回合",
		"存活回合数达到12回合",
		5,
		"12",
		40,
		7
	},
	{
		302,
		2,
		"普通模式，暴击次数达到5次",
		"暴击次数达到5次",
		3,
		"5",
		60,
		8
	},
	{
		303,
		3,
		"困难模式，存活回合数达到15回合",
		"存活回合数达到15回合",
		5,
		"15",
		100,
		9
	},
	{
		401,
		1,
		"简单模式，上阵3种属性精灵",
		"上阵3种属性精灵",
		1,
		"3",
		40,
		10
	},
	{
		402,
		2,
		"普通模式，存活回合数达到12回合",
		"存活回合数达到12回合",
		5,
		"12",
		60,
		11
	},
	{
		403,
		3,
		"困难模式，超杀次数达到30次",
		"超杀次数达到30次",
		6,
		"30",
		100,
		12
	},
	{
		501,
		1,
		"简单模式，1号位和9号位上阵精灵",
		"1号位和9号位上阵精灵",
		4,
		"1,9",
		40,
		13
	},
	{
		502,
		2,
		"普通模式，超杀次数达到20次",
		"超杀次数达到20次",
		6,
		"20",
		60,
		14
	},
	{
		503,
		3,
		"困难模式，暴击次数达到5次",
		"暴击次数达到5次",
		3,
		"5",
		100,
		15
	},
	{
		601,
		1,
		"简单模式，超杀次数达到20次",
		"超杀次数达到20次",
		6,
		"20",
		40,
		16
	},
	{
		602,
		2,
		"普通模式，暴击次数达到5次",
		"暴击次数达到5次",
		3,
		"5",
		60,
		17
	},
	{
		603,
		3,
		"困难模式，存活回合数达到16回合",
		"存活回合数达到16回合",
		5,
		"16",
		100,
		18
	}
}
local t_crazy_partner_task = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[201] = dataList[4],
	[202] = dataList[5],
	[203] = dataList[6],
	[301] = dataList[7],
	[302] = dataList[8],
	[303] = dataList[9],
	[401] = dataList[10],
	[402] = dataList[11],
	[403] = dataList[12],
	[501] = dataList[13],
	[502] = dataList[14],
	[503] = dataList[15],
	[601] = dataList[16],
	[602] = dataList[17],
	[603] = dataList[18]
}

t_crazy_partner_task.dataList = dataList

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

return t_crazy_partner_task
