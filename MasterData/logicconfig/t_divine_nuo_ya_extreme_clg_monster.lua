-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_extreme_clg_monster.lua

module("logicconfig.config.t_divine_nuo_ya_extreme_clg_monster", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 4,
	monsterId = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		316001,
		1,
		1,
		1001,
		"己阵前2个大回合治疗效果-30%"
	},
	{
		316001,
		1,
		2,
		1002,
		"己阵前2个大回合治疗效果-30%"
	},
	{
		316001,
		1,
		3,
		1003,
		"己阵前2个大回合治疗效果-30%"
	},
	{
		316001,
		2,
		1,
		2001,
		"己阵前2个大回合治疗效果-60%"
	},
	{
		316001,
		2,
		2,
		2002,
		"己阵前2个大回合治疗效果-60%"
	},
	{
		316001,
		2,
		3,
		2003,
		"己阵前2个大回合治疗效果-60%"
	},
	{
		316001,
		2,
		4,
		2004,
		"己阵前2个大回合治疗效果-60%"
	},
	{
		316001,
		3,
		1,
		3001,
		"己阵前2个大回合无法回血"
	},
	{
		316001,
		3,
		2,
		3002,
		"己阵前2个大回合无法回血"
	},
	{
		316001,
		3,
		3,
		3003,
		"己阵前2个大回合无法回血"
	},
	{
		316001,
		3,
		4,
		3004,
		"己阵前2个大回合无法回血"
	},
	{
		316001,
		3,
		5,
		3005,
		"己阵前2个大回合无法回血"
	}
}
local t_divine_nuo_ya_extreme_clg_monster = {
	[316001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_divine_nuo_ya_extreme_clg_monster.dataList = dataList

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

return t_divine_nuo_ya_extreme_clg_monster
