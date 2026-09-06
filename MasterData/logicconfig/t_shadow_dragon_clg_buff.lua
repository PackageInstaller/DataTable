-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shadow_dragon_clg_buff.lua

module("logicconfig.config.t_shadow_dragon_clg_buff", package.seeall)

local title = {
	buffType = 3,
	selectBuffPlan = 1,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"过去效果：自身战力最高的精灵首次死亡时满血复活\r\n现在效果：进入战斗时，令自身战力最高的精灵死亡"
	},
	{
		1,
		2,
		2,
		"过去效果：己阵精灵获得50%命中率\r\n现在效果：敌阵精灵获得50%闪避率"
	}
}
local t_shadow_dragon_clg_buff = {
	{
		dataList[1],
		dataList[2]
	}
}

t_shadow_dragon_clg_buff.dataList = dataList

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

return t_shadow_dragon_clg_buff
