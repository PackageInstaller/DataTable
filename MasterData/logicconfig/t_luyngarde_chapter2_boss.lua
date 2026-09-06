-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_chapter2_boss.lua

module("logicconfig.config.t_luyngarde_chapter2_boss", package.seeall)

local title = {
	bossId = 2,
	showDesc = 5,
	triggerDamage = 3,
	showRole = 6,
	creepsMasterId = 4,
	activityId = 1
}
local dataList = {
	{
		466001,
		1,
		"0",
		201,
		"拥有40%减伤效果，每次出手时无视目标40%防御，5回合结束战斗",
		15032
	},
	{
		466001,
		2,
		"10000000000000",
		202,
		"每次出手后恢复自身80气势，攻击伤害变为绝毁伤害，5回合结束战斗",
		45032
	}
}
local t_luyngarde_chapter2_boss = {
	[466001] = {
		dataList[1],
		dataList[2]
	}
}

t_luyngarde_chapter2_boss.dataList = dataList

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

return t_luyngarde_chapter2_boss
