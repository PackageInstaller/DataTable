-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_saint_knight_fire_god_buff.lua

module("logicconfig.config.t_divine_saint_knight_fire_god_buff", package.seeall)

local title = {
	activityId = 1,
	desc = 4,
	buffId = 2,
	level = 3
}
local dataList = {
	{
		480001,
		1,
		1,
		"敌阵全属性及生命上限提高50%"
	},
	{
		480001,
		1,
		2,
		"敌阵全属性及生命上限提高100%"
	},
	{
		480001,
		1,
		3,
		"敌阵全属性及生命上限提高150%"
	},
	{
		480001,
		1,
		4,
		"敌阵全属性及生命上限提高200%"
	},
	{
		480001,
		2,
		1,
		"敌阵精灵死亡时对玩家随机1位存活精灵造成攻击*200%的伤害（每场对局限3次)"
	},
	{
		480001,
		2,
		2,
		"敌阵精灵死亡时对玩家随机2位存活精灵造成攻击*200%的伤害（每场对局限3次)"
	},
	{
		480001,
		2,
		3,
		"敌阵精灵死亡时对玩家随机3位存活精灵造成攻击*200%的伤害（每场对局限3次)"
	},
	{
		480001,
		2,
		4,
		"敌阵精灵死亡时对玩家随机4位存活精灵造成攻击*200%的伤害（每场对局限3次)"
	},
	{
		480001,
		3,
		1,
		"敌阵精灵首次出手后会立即出手一次且该次出手伤害提高30%"
	},
	{
		480001,
		3,
		2,
		"敌阵精灵首次出手后会立即出手一次且该次出手伤害提高60%"
	},
	{
		480001,
		3,
		3,
		"敌阵精灵首次出手后会立即出手一次且该次出手伤害提高90%"
	},
	{
		480001,
		3,
		4,
		"敌阵精灵首次出手后会立即出手一次且该次出手伤害提高120%"
	}
}
local t_divine_saint_knight_fire_god_buff = {
	[480001] = {
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

t_divine_saint_knight_fire_god_buff.dataList = dataList

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

return t_divine_saint_knight_fire_god_buff
