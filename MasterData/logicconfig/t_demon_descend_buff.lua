-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_buff.lua

module("logicconfig.config.t_demon_descend_buff", package.seeall)

local title = {
	isUnlock = 5,
	buffType = 2,
	buffId = 4,
	requiredRedWine = 6,
	index = 3,
	activityId = 1,
	desc = 7
}
local dataList = {
	{
		497001,
		1,
		1,
		1,
		true,
		0,
		"BOSS受到伤害+0%"
	},
	{
		497001,
		1,
		2,
		2,
		false,
		20,
		"BOSS受到伤害+100%"
	},
	{
		497001,
		1,
		3,
		3,
		false,
		40,
		"BOSS受到伤害+200%"
	},
	{
		497001,
		1,
		4,
		4,
		false,
		60,
		"BOSS受到伤害+300%"
	},
	{
		497001,
		2,
		1,
		5,
		true,
		0,
		"己阵全属性及生命上限+0%"
	},
	{
		497001,
		2,
		2,
		6,
		false,
		20,
		"己阵全属性及生命上限+30%"
	},
	{
		497001,
		2,
		3,
		7,
		false,
		40,
		"己阵全属性及生命上限+60%"
	},
	{
		497001,
		2,
		4,
		8,
		false,
		60,
		"己阵全属性及生命上限+100%"
	},
	{
		497001,
		3,
		1,
		9,
		true,
		0,
		"每个大回合结束时，全阵恢复0点气势"
	},
	{
		497001,
		3,
		2,
		10,
		false,
		20,
		"每个大回合结束时，全阵恢复20点气势"
	},
	{
		497001,
		3,
		3,
		11,
		false,
		40,
		"每个大回合结束时，全阵恢复60点气势"
	},
	{
		497001,
		3,
		4,
		12,
		false,
		60,
		"每个大回合结束时，全阵恢复100点气势"
	}
}
local t_demon_descend_buff = {
	[497001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_demon_descend_buff.dataList = dataList

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

return t_demon_descend_buff
