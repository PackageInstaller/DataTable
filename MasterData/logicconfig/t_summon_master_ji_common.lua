-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_common.lua

module("logicconfig.config.t_summon_master_ji_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITY_ID",
		"348001"
	},
	{
		"TEXT_DESC1",
		"说明：\n分数越高敌阵的BUFF效果越强"
	},
	{
		"PROCESS_ITEM",
		"1004:1364:10"
	},
	{
		"TEXT_DESC2",
		"通过所有关卡挑战且总积分达到 60分 可获得万物归元·极"
	}
}
local t_summon_master_ji_common = {
	ACTIVITY_ID = dataList[1],
	TEXT_DESC1 = dataList[2],
	PROCESS_ITEM = dataList[3],
	TEXT_DESC2 = dataList[4]
}

t_summon_master_ji_common.dataList = dataList

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

return t_summon_master_ji_common
