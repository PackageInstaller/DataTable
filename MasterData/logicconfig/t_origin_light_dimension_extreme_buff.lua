-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_light_dimension_extreme_buff.lua

module("logicconfig.config.t_origin_light_dimension_extreme_buff", package.seeall)

local title = {
	name = 4,
	buffId = 2,
	activateBuffId = 3,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		610001,
		20074001,
		20074003,
		"虚幻空间",
		"敌阵精灵获得生命值上限*50%护盾"
	},
	{
		610001,
		20074004,
		20074007,
		"次元空间",
		"敌阵精灵攻击附带攻击*30%伤害"
	},
	{
		610001,
		20074008,
		20074011,
		"万象空间",
		"敌阵精灵攻击后令自身获得30点气势"
	}
}
local t_origin_light_dimension_extreme_buff = {
	[610001] = {
		[20074001] = dataList[1],
		[20074004] = dataList[2],
		[20074008] = dataList[3]
	}
}

t_origin_light_dimension_extreme_buff.dataList = dataList

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

return t_origin_light_dimension_extreme_buff
