-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shi_zu_dragon_clg_buff.lua

module("logicconfig.config.t_shi_zu_dragon_clg_buff", package.seeall)

local title = {
	activityId = 1,
	finishNum = 3,
	phaseId = 2,
	desc = 4
}
local dataList = {
	{
		500001,
		1,
		1,
		"敌阵全属性及生命上限+20%"
	},
	{
		500001,
		1,
		2,
		"敌阵全属性及生命上限+40%"
	},
	{
		500001,
		2,
		1,
		"敌阵全属性及生命上限+20%"
	},
	{
		500001,
		2,
		2,
		"敌阵全属性及生命上限+40%"
	},
	{
		500001,
		3,
		1,
		"敌阵全属性及生命上限+20%"
	},
	{
		500001,
		3,
		2,
		"敌阵全属性及生命上限+40%"
	}
}
local t_shi_zu_dragon_clg_buff = {
	[500001] = {
		{
			dataList[1],
			dataList[2]
		},
		{
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6]
		}
	}
}

t_shi_zu_dragon_clg_buff.dataList = dataList

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

return t_shi_zu_dragon_clg_buff
