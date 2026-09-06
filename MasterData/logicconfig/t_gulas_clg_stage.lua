-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gulas_clg_stage.lua

module("logicconfig.config.t_gulas_clg_stage", package.seeall)

local title = {
	stagePlanId = 1,
	buffCondition = 4,
	stageId = 2,
	ldesc = 5,
	creepsMasterId = 3,
	rdesc = 6,
	posId = 7
}
local dataList = {
	{
		1,
		1,
		1001,
		"RaceType$水 >= 1 & RaceType$火 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只水属性和1只火属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		1,
		2,
		1002,
		"RaceType$火 >= 1 & RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只火属性和1只草属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		2,
		1,
		1003,
		"RaceType$水 >= 1 & RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>1只水属性和2只草属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		2,
		2,
		1004,
		"RaceType$火 >= 1 & RaceType$草 >= 1 & RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只火属性和1只草属性和1只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		3,
		1,
		1005,
		"RaceType$水 >= 2 & RaceType$火 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只水属性和2只火属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		3,
		2,
		1006,
		"RaceType$火 >= 1 & RaceType$水 >= 1 & RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>1只火属性和2只草属性和1只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		4,
		1,
		1007,
		"RaceType$草 >= 3 & RaceType$火 >= 2",
		"上阵至少\r\n<color=#FF7B7B>3只草属性和2只火属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		4,
		2,
		1008,
		"RaceType$火 >= 2 & RaceType$水 >= 2 & RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>2只火属性和1只草属性和2只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		5,
		1,
		1009,
		"RaceType$草 >= 3 & RaceType$水 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只草属性和3只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		5,
		2,
		1010,
		"RaceType$火 >= 2 & RaceType$水 >= 2 & RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只火属性和2只草属性和2只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		6,
		1,
		1011,
		"RaceType$水 >= 3 & RaceType$火 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只水属性和3只火属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		6,
		2,
		1012,
		"RaceType$火 >= 3 & RaceType$水 >= 2 & RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>3只火属性和1只草属性和2只水属性精灵</color>",
		"暗蚀之陷：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		7,
		1,
		2001,
		"RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		7,
		2,
		2002,
		"RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		8,
		1,
		2003,
		"RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		8,
		2,
		2004,
		"RaceType$草 >= 1",
		"上阵至少\r\n<color=#FF7B7B>1只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		9,
		1,
		2005,
		"RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		9,
		2,
		2006,
		"RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		10,
		1,
		2007,
		"RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		10,
		2,
		2008,
		"RaceType$草 >= 2",
		"上阵至少\r\n<color=#FF7B7B>2只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		11,
		1,
		2009,
		"RaceType$草 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		11,
		2,
		2010,
		"RaceType$草 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		12,
		1,
		2011,
		"RaceType$草 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	},
	{
		12,
		2,
		2012,
		"RaceType$草 >= 3",
		"上阵至少\r\n<color=#FF7B7B>3只草系精灵</color>",
		"蛮荒战神：\r\n<color=#FF7B7B>黑洞无法触发第三阶段的效果</color>",
		"5"
	}
}
local t_gulas_clg_stage = {
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
	},
	{
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18]
	},
	{
		dataList[19],
		dataList[20]
	},
	{
		dataList[21],
		dataList[22]
	},
	{
		dataList[23],
		dataList[24]
	}
}

t_gulas_clg_stage.dataList = dataList

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

return t_gulas_clg_stage
