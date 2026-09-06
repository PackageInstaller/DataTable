-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_global_buff.lua

module("logicconfig.config.t_free_scuffle_global_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2,
	desc = 3
}
local dataList = {
	{
		489001,
		1,
		"上阵精灵每更换一个技能词条，全属性+10%"
	},
	{
		489001,
		2,
		"攻击时若攻击类型不同，则本次攻击伤害+20%"
	},
	{
		489001,
		3,
		"若己阵使用了英雄技词条，则全阵全属性+10%"
	},
	{
		489001,
		4,
		"上阵精灵每更换一个技能词条，全属性-10%"
	},
	{
		489001,
		5,
		"攻击时若攻击类型不同，则本次攻击伤害-20%"
	},
	{
		489002,
		1,
		"上阵精灵每更换一个技能词条，全属性+10%"
	},
	{
		489002,
		2,
		"攻击时若攻击类型不同，则本次攻击伤害+20%"
	},
	{
		489002,
		3,
		"若己阵使用了英雄技词条，则全阵全属性+10%"
	},
	{
		489002,
		4,
		"上阵精灵每更换一个技能词条，全属性-10%"
	},
	{
		489002,
		5,
		"攻击时若攻击类型不同，则本次攻击伤害-20%"
	},
	{
		489003,
		1,
		"上阵精灵每更换一个技能词条，全属性+10%"
	},
	{
		489003,
		2,
		"攻击时若攻击类型不同，则本次攻击伤害+20%"
	},
	{
		489003,
		3,
		"若己阵使用了英雄技词条，则全阵全属性+10%"
	},
	{
		489003,
		4,
		"上阵精灵每更换一个技能词条，全属性-10%"
	},
	{
		489003,
		5,
		"攻击时若攻击类型不同，则本次攻击伤害-20%"
	}
}
local t_free_scuffle_global_buff = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[489002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[489003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_free_scuffle_global_buff.dataList = dataList

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

return t_free_scuffle_global_buff
