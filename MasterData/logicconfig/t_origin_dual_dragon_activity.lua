-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dual_dragon_activity.lua

module("logicconfig.config.t_origin_dual_dragon_activity", package.seeall)

local title = {
	jumpToPrize = 5,
	jumpToRank = 4,
	jumpToPack = 7,
	ruleDesc = 9,
	prize = 2,
	jumpToShop = 6,
	raceId = 3,
	ruleKeyMain = 8,
	activityId = 1
}
local dataList = {
	{
		618001,
		"4:510845:100",
		16048,
		"event#gotofirstpassrankview#618001",
		"func#618#16048",
		"mibao#jinglingyangcheng",
		"ui#lottery",
		"origindualdragon_rule",
		"1、每关必须先通关善之试炼后对应解锁一关恶之试炼\r\n\r\n2、善之试炼中不可上阵相同精灵\r\n\r\n3、恶之试炼挑战开始时,会使用善之试炼的中的上阵精灵,且精灵血量继承。恶之试炼挑战时,会受到善之试炼的影响,具体产看关卡链接处的说明\r\n\r\n4、恶之试炼中，敌阵精灵减伤和非伤减伤提高50%，每次受击标记伤害来源，被标记的精灵下个大回合开始时立即死亡，每个大回合标记目标最多为4个"
	}
}
local t_origin_dual_dragon_activity = {
	[618001] = dataList[1]
}

t_origin_dual_dragon_activity.dataList = dataList

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

return t_origin_dual_dragon_activity
