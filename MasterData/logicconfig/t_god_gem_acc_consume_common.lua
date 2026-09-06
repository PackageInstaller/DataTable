-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_god_gem_acc_consume_common.lua

module("logicconfig.config.t_god_gem_acc_consume_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"RANK_DESC",
		"提示：小诺银饰将于活动结束后<color=#C54949>1-2个月内发放</color>，如有疑问，请联系客服QQ:800165123"
	},
	{
		"RECHARGE_JUMP",
		"mibao#ZhounianShop1"
	},
	{
		"CONSUME_JUMP",
		"mibao#ZhounianShop1"
	},
	{
		"REALITYPRIZEPROGRESS_TIP",
		"累计消费<color=#ff9000>%s</color>神钻，可得绝版限量挂饰"
	}
}
local t_god_gem_acc_consume_common = {
	RANK_DESC = dataList[1],
	RECHARGE_JUMP = dataList[2],
	CONSUME_JUMP = dataList[3],
	REALITYPRIZEPROGRESS_TIP = dataList[4]
}

t_god_gem_acc_consume_common.dataList = dataList

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

return t_god_gem_acc_consume_common
