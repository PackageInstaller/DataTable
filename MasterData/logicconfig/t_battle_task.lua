-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_task.lua

module("logicconfig.config.t_battle_task", package.seeall)

local title = {
	id = 1,
	prefix = 4,
	params = 3,
	type = 2
}
local dataList = {
	{
		1,
		"MyPetAttrType",
		"2",
		"上阵2种属性精灵"
	},
	{
		2,
		"MyActiveRoundCount",
		"12",
		"存活回合数达到12回合"
	},
	{
		3,
		"MyUltCount",
		"20",
		"超杀次数达到20次"
	},
	{
		4,
		"MyInitPos",
		"2,8",
		"2号位和8号位上阵精灵"
	},
	{
		5,
		"MyUltCount",
		"12",
		"超杀次数达到12次"
	},
	{
		6,
		"MyCriticalCount",
		"5",
		"暴击次数达到5次"
	},
	{
		7,
		"MyActiveRoundCount",
		"12",
		"存活回合数达到12回合"
	},
	{
		8,
		"MyCriticalCount",
		"5",
		"暴击次数达到5次"
	},
	{
		9,
		"MyActiveRoundCount",
		"15",
		"存活回合数达到15回合"
	},
	{
		10,
		"MyPetAttrType",
		"3",
		"上阵3种属性精灵"
	},
	{
		11,
		"MyActiveRoundCount",
		"12",
		"存活回合数达到12回合"
	},
	{
		12,
		"MyUltCount",
		"30",
		"超杀次数达到30次"
	},
	{
		13,
		"MyInitPos",
		"1,9",
		"1号位和9号位上阵精灵"
	},
	{
		14,
		"MyUltCount",
		"20",
		"超杀次数达到20次"
	},
	{
		15,
		"MyCriticalCount",
		"5",
		"暴击次数达到5次"
	},
	{
		16,
		"MyUltCount",
		"20",
		"超杀次数达到20次"
	},
	{
		17,
		"MyCriticalCount",
		"5",
		"暴击次数达到5次"
	},
	{
		18,
		"MyActiveRoundCount",
		"16",
		"存活回合数达到16回合"
	}
}
local t_battle_task = {
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
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18]
}

t_battle_task.dataList = dataList

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

return t_battle_task
