-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_kun_lun_clg_activity.lua

module("logicconfig.config.t_divine_kun_lun_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 4,
	sysPetPlanId = 3,
	jumpStr2 = 8,
	skinId = 12,
	jumpStr4 = 10,
	jumpStr5 = 11,
	normalDesc = 13,
	normalDailyStageCount = 2,
	jumpStr3 = 9,
	extremeDesc = 14,
	redPointId = 6,
	jumpStr1 = 7,
	activityId = 1,
	buffCounterId = 5
}
local dataList = {
	{
		464001,
		3,
		1,
		"4:270:100",
		30000031,
		683,
		"func#618#13023",
		"mibao#jinglingyangcheng",
		"func#43#132",
		"",
		"",
		13023,
		"1.使用系统精灵挑战，战胜敌阵后，累计己阵精灵连击次数\r\n2.每日5点刷新3个敌阵进行挑战\r\n3.己阵精灵出手，每击杀敌方 <color=#ffed98>1只</color>精灵，额外出手<color=#ffed98>1次</color>",
		"1.神曜昆仑作为第六人上阵，本关挑战<color=#ffed98>仅第六人神曜昆仑可通灵</color>\n\r\n2.敌阵精灵出手，每击杀我方 <color=#ffed98>1只</color>精灵，额外出手<color=#ffed98>1次</color>\n\r\n3.战胜敌阵，累计<color=#ffed98>己阵精灵连击次数</color>\n\r\n4.击败全部敌阵，按敌阵顺序连击次数<color=#ffed98>达成递增序列</color>即可通关(连击次数<color=#ffed98>不可为0</color>)"
	}
}
local t_divine_kun_lun_clg_activity = {
	[464001] = dataList[1]
}

t_divine_kun_lun_clg_activity.dataList = dataList

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

return t_divine_kun_lun_clg_activity
