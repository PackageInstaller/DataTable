-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_fu_yao_clg_extreme_buff.lua

module("logicconfig.config.t_divine_fu_yao_clg_extreme_buff", package.seeall)

local title = {
	activityId = 1,
	deadNum = 2,
	desc = 3
}
local dataList = {
	{
		502001,
		1,
		"我方精灵阵亡累计达1只，敌方全属性增益+10%"
	},
	{
		502001,
		2,
		"我方精灵阵亡累计达2只，敌方全属性增益+20%"
	},
	{
		502001,
		3,
		"我方精灵阵亡累计达3只，敌方全属性增益+30%"
	},
	{
		502001,
		4,
		"我方精灵阵亡累计达4只，敌方全属性增益+40%"
	},
	{
		502001,
		5,
		"我方精灵阵亡累计达5只，敌方全属性增益+50%"
	}
}
local t_divine_fu_yao_clg_extreme_buff = {
	[502001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_fu_yao_clg_extreme_buff.dataList = dataList

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

return t_divine_fu_yao_clg_extreme_buff
