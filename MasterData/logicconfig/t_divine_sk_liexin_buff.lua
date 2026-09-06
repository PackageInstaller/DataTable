-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_sk_liexin_buff.lua

module("logicconfig.config.t_divine_sk_liexin_buff", package.seeall)

local title = {
	desc = 3,
	num = 2,
	collectDesc = 4,
	collectBuffPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"己阵全属性+<color=#20b376>20%</color>",
		"收集1个神曜圣骑队伍的精灵"
	},
	{
		1,
		2,
		"己阵全属性+<color=#20b376>50%</color>",
		"收集2个神曜圣骑队伍的精灵"
	},
	{
		1,
		3,
		"己阵全属性+<color=#20b376>100%</color>",
		"收集3个神曜圣骑队伍的精灵"
	},
	{
		1,
		4,
		"己阵全属性+<color=#20b376>500%</color>",
		"收集4个神曜圣骑队伍的精灵"
	},
	{
		1,
		5,
		"己阵全属性+<color=#20b376>700%</color>",
		"收集5个神曜圣骑队伍的精灵"
	}
}
local t_divine_sk_liexin_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_divine_sk_liexin_buff.dataList = dataList

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

return t_divine_sk_liexin_buff
