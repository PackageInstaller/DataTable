-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dragon_arya_clg_common.lua

module("logicconfig.config.t_divine_dragon_arya_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DESC_RANK_DAILY",
		"每日榜上榜后次日发放奖励内容"
	},
	{
		"DESC_RANK_GOD",
		"大神榜门槛：150印记 大神榜上榜后即刻发放奖励"
	},
	{
		"DESC_STAGE",
		"获得方式：我方精灵出手时对敌方带有印记的精灵<color=#C54949>造成伤害为克制属性</color>时，印记数量增加；敌方受击次数越多 印记数量越多；例我方水属性精灵对敌方携带火印记精灵造成一次伤害，则对应获得火印记+1"
	},
	{
		"SKIN_ID",
		"17015"
	},
	{
		"LZ_JUMP_SHOP",
		"mibao#shenyaolibao"
	},
	{
		"LZ_JUMP_JINHUA",
		"func#375"
	}
}
local t_divine_dragon_arya_clg_common = {
	DESC_RANK_DAILY = dataList[1],
	DESC_RANK_GOD = dataList[2],
	DESC_STAGE = dataList[3],
	SKIN_ID = dataList[4],
	LZ_JUMP_SHOP = dataList[5],
	LZ_JUMP_JINHUA = dataList[6]
}

t_divine_dragon_arya_clg_common.dataList = dataList

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

return t_divine_dragon_arya_clg_common
