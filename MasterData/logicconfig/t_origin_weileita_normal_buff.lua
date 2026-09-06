-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_normal_buff.lua

module("logicconfig.config.t_origin_weileita_normal_buff", package.seeall)

local title = {
	desc = 4,
	name = 3,
	activityId = 1,
	progress = 2
}
local dataList = {
	{
		561001,
		1,
		"进入战斗时，减少己方所有精灵10点气势",
		"进入战斗时，减少己方所有精灵10点气势"
	},
	{
		561001,
		3,
		"进入战斗时，减少己方所有精灵20点气势",
		"进入战斗时，减少己方所有精灵20点气势"
	},
	{
		561001,
		5,
		"进入战斗时，减少己方所有精灵30点气势",
		"进入战斗时，减少己方所有精灵30点气势"
	},
	{
		561001,
		7,
		"进入战斗时，减少己方所有精灵40点气势",
		"进入战斗时，减少己方所有精灵40点气势"
	},
	{
		561001,
		9,
		"进入战斗时，减少己方所有精灵50点气势",
		"进入战斗时，减少己方所有精灵50点气势"
	},
	{
		561001,
		12,
		"进入战斗时，减少己方所有精灵100点气势",
		"进入战斗时，减少己方所有精灵100点气势"
	},
	{
		561001,
		15,
		"进入战斗时，减少己方所有精灵150点气势",
		"进入战斗时，减少己方所有精灵150点气势"
	}
}
local t_origin_weileita_normal_buff = {
	[561001] = {
		dataList[1],
		[3] = dataList[2],
		[5] = dataList[3],
		[7] = dataList[4],
		[9] = dataList[5],
		[12] = dataList[6],
		[15] = dataList[7]
	}
}

t_origin_weileita_normal_buff.dataList = dataList

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

return t_origin_weileita_normal_buff
