-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ao_jiu_clg_buff.lua

module("logicconfig.config.t_divine_ao_jiu_clg_buff", package.seeall)

local title = {
	activityId = 1,
	buffType = 3,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		511001,
		1,
		1,
		"敌阵精灵只会受到火系精灵伤害"
	},
	{
		511001,
		2,
		2,
		"敌阵精灵只会受到超杀伤害"
	},
	{
		511001,
		3,
		3,
		"敌阵精灵只会受到己阵战力最高的两位精灵的伤害"
	},
	{
		511001,
		4,
		4,
		"敌阵精灵首次受击后会免疫伤害来源属性的伤害"
	}
}
local t_divine_ao_jiu_clg_buff = {
	[511001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_ao_jiu_clg_buff.dataList = dataList

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

return t_divine_ao_jiu_clg_buff
