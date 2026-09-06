-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_ashless_dragon_clg_pos_buff.lua

module("logicconfig.config.t_king_ashless_dragon_clg_pos_buff", package.seeall)

local title = {
	activityId = 1,
	count = 2,
	desc = 3
}
local dataList = {
	{
		440001,
		1,
		"在该站位上的精灵每次行动时，对己阵生命值最低的2位存活精灵造成攻击*140%的毁灭伤害"
	},
	{
		440001,
		2,
		"在该站位上的精灵每次行动时，对己阵生命值最低的2位存活精灵造成攻击*140%的毁灭伤害，触发2次"
	},
	{
		440001,
		3,
		"在该站位上的精灵每次行动时，对己阵生命值最低的2位存活精灵造成攻击*140%的毁灭伤害，触发3次"
	}
}
local t_king_ashless_dragon_clg_pos_buff = {
	[440001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_king_ashless_dragon_clg_pos_buff.dataList = dataList

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

return t_king_ashless_dragon_clg_pos_buff
