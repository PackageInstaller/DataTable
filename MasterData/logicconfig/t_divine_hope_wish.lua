-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_hope_wish.lua

module("logicconfig.config.t_divine_hope_wish", package.seeall)

local title = {
	score = 4,
	wishType = 3,
	buffDesc = 5,
	wishId = 2,
	activityId = 1
}
local dataList = {
	{
		518001,
		1,
		1,
		0,
		"无效果"
	},
	{
		518001,
		2,
		1,
		2,
		"敌阵攻击时不被属性克制影响，永远视为克制目标属性"
	},
	{
		518001,
		3,
		1,
		4,
		"敌阵攻击及受击时不被属性克制影响，永远视为克制目标属性"
	},
	{
		518001,
		4,
		2,
		0,
		"无效果"
	},
	{
		518001,
		5,
		2,
		2,
		"己阵精灵攻击时额外造成30%伤害同时敌阵精灵会反弹30%伤害"
	},
	{
		518001,
		6,
		2,
		4,
		"己阵每只精灵首次攻击时，令自身获得1次立即攻击，攻击后令自身死亡"
	}
}
local t_divine_hope_wish = {
	[518001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_hope_wish.dataList = dataList

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

return t_divine_hope_wish
