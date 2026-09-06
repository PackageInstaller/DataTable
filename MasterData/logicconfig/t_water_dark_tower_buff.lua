-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_dark_tower_buff.lua

module("logicconfig.config.t_water_dark_tower_buff", package.seeall)

local title = {
	raceId = 2,
	buffPlanId = 1,
	des = 3
}
local dataList = {
	{
		1,
		11007,
		"造成伤害提升：<color=#F5C701FF>50%</color>"
	},
	{
		1,
		12008,
		"攻击提升：<color=#F5C701FF>50%</color>"
	},
	{
		1,
		12007,
		"暴击率提升：<color=#F5C701FF>50%</color>"
	},
	{
		1,
		15011,
		"攻击吸收目标<color=#F5C701FF>20</color>气势"
	},
	{
		1,
		13001,
		"生命上限提升：<color=#F5C701FF>50%</color>"
	},
	{
		1,
		14008,
		"物防、魔防提升：<color=#F5C701FF>50%</color>"
	}
}
local t_water_dark_tower_buff = {
	{
		[11007] = dataList[1],
		[12008] = dataList[2],
		[12007] = dataList[3],
		[15011] = dataList[4],
		[13001] = dataList[5],
		[14008] = dataList[6]
	}
}

t_water_dark_tower_buff.dataList = dataList

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

return t_water_dark_tower_buff
