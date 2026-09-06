-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xingjiang_transmog_num_buff.lua

module("logicconfig.config.t_origin_xingjiang_transmog_num_buff", package.seeall)

local title = {
	aliveTransmogNum = 2,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		570001,
		2,
		"幻化精灵受到伤害加深20%，敌阵全属性+10%"
	},
	{
		570001,
		4,
		"幻化精灵受到伤害加深30%，敌阵全属性+20%"
	},
	{
		570001,
		8,
		"幻化精灵受到伤害加深40%，敌阵全属性+30%，敌阵精灵出手后若未击杀目标，则下一次出手获得40%增伤"
	},
	{
		570001,
		12,
		"幻化精灵受到伤害加深40%，敌阵全属性+30%，敌阵精灵出手后若未击杀目标，则下一次出手获得50%增伤"
	}
}
local t_origin_xingjiang_transmog_num_buff = {
	[570001] = {
		[2] = dataList[1],
		[4] = dataList[2],
		[8] = dataList[3],
		[12] = dataList[4]
	}
}

t_origin_xingjiang_transmog_num_buff.dataList = dataList

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

return t_origin_xingjiang_transmog_num_buff
