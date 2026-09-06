-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_tian_shan_clg_normal_clg_buff.lua

module("logicconfig.config.t_divine_tian_shan_clg_normal_clg_buff", package.seeall)

local title = {
	leftHpRate = 3,
	buffPlanId = 1,
	buffId = 2,
	buffDesc = 4
}
local dataList = {
	{
		1,
		1,
		"0.3",
		"BOSS攻击后会减少我方精灵20%暴击率（不叠加）"
	},
	{
		2,
		1,
		"0.5",
		"BOSS攻击后会减少我方精灵20%命中率（不叠加）"
	},
	{
		3,
		1,
		"0.7",
		"BOSS攻击后会减少我方精灵25气势"
	},
	{
		4,
		1,
		"0.9",
		"BOSS攻击后会减少我方精灵15%防御（最多3层），并对受击目标相邻的精灵造成攻击者攻击力40%的伤害"
	}
}
local t_divine_tian_shan_clg_normal_clg_buff = {
	{
		dataList[1]
	},
	{
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4]
	}
}

t_divine_tian_shan_clg_normal_clg_buff.dataList = dataList

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

return t_divine_tian_shan_clg_normal_clg_buff
