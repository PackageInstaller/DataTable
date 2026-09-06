-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_extreme_buff.lua

module("logicconfig.config.t_origin_powers_clg_extreme_buff", package.seeall)

local title = {
	activityId = 1,
	buffNum = 2,
	desc = 3
}
local dataList = {
	{
		576001,
		3,
		"敌阵全属性+10%"
	},
	{
		576001,
		6,
		"敌阵全属性+20%，敌阵攻击自身所克制的属性敌人时伤害提高40%"
	},
	{
		576001,
		12,
		"敌阵全属性+30%，攻击伤害加深40%且攻击后将令敌方攻击力最高的存活精灵获得50气势和一次立即出手（每个大回合由此获得的立即出手上限为8次）"
	}
}
local t_origin_powers_clg_extreme_buff = {
	[576001] = {
		[3] = dataList[1],
		[6] = dataList[2],
		[12] = dataList[3]
	}
}

t_origin_powers_clg_extreme_buff.dataList = dataList

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

return t_origin_powers_clg_extreme_buff
