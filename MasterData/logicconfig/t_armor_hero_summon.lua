-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_summon.lua

module("logicconfig.config.t_armor_hero_summon", package.seeall)

local title = {
	rds = 6,
	txtTitle = 7,
	prize = 4,
	name = 9,
	summonId = 2,
	dateStr = 8,
	gotoStr = 5,
	activityId = 1,
	needItem = 3
}
local dataList = {
	{
		540001,
		1,
		"10:540001:1",
		"4:36:10",
		"func#1148",
		"o72",
		"寻找火影石",
		"1.16上线",
		"铠甲勇士·炎龙侠"
	},
	{
		540001,
		2,
		"10:540005:1#10:540004:1#10:540006:1#10:540002:1#10:540003:1",
		"104:2:300",
		"func#1085",
		"o73",
		"寻找太极石",
		"1.23上线",
		"铠甲勇士·帝皇侠"
	},
	{
		540001,
		3,
		"10:540007:1#10:540008:100",
		"4:36:10",
		"ui#armorheroclg2view#540001#1",
		"o74",
		"挑战王者龙",
		"1.23上线",
		"帝昭天道·帝皇侠"
	},
	{
		540001,
		4,
		"10:540010:1#10:540009:100",
		"104:2:300",
		"ui#armorheroclgview#540001#2",
		"o75",
		"挑战无烬龙",
		"1.16上线",
		"永炎无烬·炎龙侠"
	},
	{
		540002,
		1,
		"10:540001:1",
		"4:36:10",
		"func#1148",
		"o72",
		"寻找火影石",
		"1.16上线",
		"铠甲勇士·炎龙侠"
	},
	{
		540002,
		2,
		"10:540005:1#10:540004:1#10:540006:1#10:540002:1#10:540003:1",
		"104:2:300",
		"func#1085",
		"o73",
		"寻找太极石",
		"1.23上线",
		"铠甲勇士·帝皇侠"
	},
	{
		540002,
		3,
		"10:540007:1#10:540008:100",
		"4:36:10",
		"ui#armorheroclg2view#540001#1",
		"o74",
		"挑战王者龙",
		"1.23上线",
		"帝昭天道·帝皇侠"
	},
	{
		540002,
		4,
		"10:540010:1#10:540009:100",
		"104:2:300",
		"ui#armorheroclgview#540001#2",
		"o75",
		"挑战无烬龙",
		"1.16上线",
		"永炎无烬·炎龙侠"
	}
}
local t_armor_hero_summon = {
	[540001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[540002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_armor_hero_summon.dataList = dataList

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

return t_armor_hero_summon
