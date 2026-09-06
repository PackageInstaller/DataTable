-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_extreme_stage.lua

module("logicconfig.config.t_ji_clg_extreme_stage", package.seeall)

local title = {
	stageId = 3,
	shortRule = 6,
	scoreRule = 5,
	detailRule = 7,
	creepsMasterId = 4,
	raceType = 2,
	activityId = 1
}
local dataList = {
	{
		420001,
		"光",
		1,
		2001,
		"Round$ruleId=1",
		"至少上阵3只光属性精灵破阵所用回合数越少，获得的能量越多",
		"<color=#C54949>回合数</color>                    <color=#C54949>能量</color>\r\n  1~2                      400\r\n  3                          300\r\n  4                          200\r\n≥5                           0"
	},
	{
		420001,
		"光",
		2,
		2002,
		"Damage$能量上限=400#下限万分比=5000",
		"己阵光属性精灵造成的伤害越高，获得的能量越多（能量＜200不记录）",
		"己阵光属性伤害值 \r\n 能量  = ——————————  X 400\r\n己阵总伤害值"
	},
	{
		420001,
		"光",
		3,
		2003,
		"Survive$ruleId=2",
		"通关时存活的光属性精灵越多,获得的能量越多",
		"<color=#C54949>存活数</color>                   <color=#C54949>能量</color>\r\n   6                        400\r\n   5                        300\r\n   4                        200\r\n   3                        100\r\n  ≤2                         0"
	},
	{
		420001,
		"暗",
		1,
		2004,
		"Round$ruleId=1",
		"至少上阵3只暗属性精灵破阵所用回合数越少，获得的能量越多",
		"<color=#C54949>回合数</color>                    <color=#C54949>能量</color>\r\n  1~2                      400\r\n  3                          300\r\n  4                          200\r\n≥5                           0"
	},
	{
		420001,
		"暗",
		2,
		2005,
		"Damage$能量上限=400#下限万分比=6000",
		"己阵暗属性精灵造成的伤害越高，获得的能量越多（能量＜240不记录）",
		"己阵暗属性伤害值 \r\n 能量  = ——————————  X 400\r\n己阵总伤害值"
	},
	{
		420001,
		"暗",
		3,
		2006,
		"Survive$ruleId=2",
		"通关时存活的暗属性精灵越多,获得的能量越多",
		"<color=#C54949>存活数</color>                   <color=#C54949>能量</color>\r\n   6                        400\r\n   5                        300\r\n   4                        200\r\n   3                        100\r\n  ≤2                         0"
	},
	{
		420001,
		"水",
		1,
		2007,
		"Round$ruleId=1",
		"至少上阵3只水属性精灵破阵所用回合数越少，获得的能量越多",
		"<color=#C54949>回合数</color>                    <color=#C54949>能量</color>\r\n  1~2                      400\r\n  3                          300\r\n  4                          200\r\n≥5                           0"
	},
	{
		420001,
		"水",
		2,
		2008,
		"Damage$能量上限=400#下限万分比=6000",
		"己阵水属性精灵造成的伤害越高，获得的能量越多（能量＜240不记录）",
		"己阵水属性伤害值 \r\n 能量  = ——————————  X 400\r\n己阵总伤害值"
	},
	{
		420001,
		"水",
		3,
		2009,
		"Survive$ruleId=2",
		"通关时存活的水属性精灵越多,获得的能量越多",
		"<color=#C54949>存活数</color>                   <color=#C54949>能量</color>\r\n   6                        400\r\n   5                        300\r\n   4                        200\r\n   3                        100\r\n  ≤2                         0"
	},
	{
		420001,
		"火",
		1,
		2010,
		"Round$ruleId=1",
		"至少上阵3只火属性精灵破阵所用回合数越少，获得的能量越多",
		"<color=#C54949>回合数</color>                    <color=#C54949>能量</color>\r\n  1~2                      400\r\n  3                          300\r\n  4                          200\r\n≥5                           0"
	},
	{
		420001,
		"火",
		2,
		2011,
		"Damage$能量上限=400#下限万分比=6000",
		"己阵火属性精灵造成的伤害越高，获得的能量越多（能量＜240不记录）",
		"己阵火属性伤害值 \r\n 能量  = ——————————  X 400\r\n己阵总伤害值"
	},
	{
		420001,
		"火",
		3,
		2012,
		"Survive$ruleId=2",
		"通关时存活的火属性精灵越多,获得的能量越多",
		"<color=#C54949>存活数</color>                   <color=#C54949>能量</color>\r\n   6                        400\r\n   5                        300\r\n   4                        200\r\n   3                        100\r\n  ≤2                         0"
	},
	{
		420001,
		"草",
		1,
		2013,
		"Round$ruleId=1",
		"至少上阵3只草属性精灵破阵所用回合数越少，获得的能量越多",
		"<color=#C54949>回合数</color>                    <color=#C54949>能量</color>\r\n  1~2                      400\r\n  3                          300\r\n  4                          200\r\n≥5                           0"
	},
	{
		420001,
		"草",
		2,
		2014,
		"Damage$能量上限=400#下限万分比=6000",
		"己阵草属性精灵造成的伤害越高，获得的能量越多（能量＜240不记录）",
		"己阵草属性伤害值 \r\n 能量  = ——————————  X 400\r\n己阵总伤害值"
	},
	{
		420001,
		"草",
		3,
		2015,
		"Survive$ruleId=2",
		"通关时存活的草属性精灵越多,获得的能量越多",
		"<color=#C54949>存活数</color>                   <color=#C54949>能量</color>\r\n   6                        400\r\n   5                        300\r\n   4                        200\r\n   3                        100\r\n  ≤2                         0"
	}
}
local t_ji_clg_extreme_stage = {
	[420001] = {
		光 = {
			dataList[1],
			dataList[2],
			dataList[3]
		},
		暗 = {
			dataList[4],
			dataList[5],
			dataList[6]
		},
		水 = {
			dataList[7],
			dataList[8],
			dataList[9]
		},
		火 = {
			dataList[10],
			dataList[11],
			dataList[12]
		},
		草 = {
			dataList[13],
			dataList[14],
			dataList[15]
		}
	}
}

t_ji_clg_extreme_stage.dataList = dataList

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

return t_ji_clg_extreme_stage
