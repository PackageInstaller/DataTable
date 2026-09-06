-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mimengli_clg_buff.lua

module("logicconfig.config.t_divine_mimengli_clg_buff", package.seeall)

local title = {
	buffPlanId = 1,
	signBuffCount = 3,
	buffId = 2,
	desc = 4
}
local dataList = {
	{
		1,
		1,
		1,
		"己方全属性-20%"
	},
	{
		1,
		2,
		3,
		"己方全属性-40%，敌阵精灵额外出手一次（每个大回合限1次）"
	},
	{
		1,
		3,
		5,
		"己方全属性-60%，敌阵精灵额外出手一次（每个大回合限1次）"
	},
	{
		1,
		4,
		7,
		"己方全属性-80%，敌阵精灵额外出手一次（每个大回合限1次）"
	}
}
local t_divine_mimengli_clg_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_divine_mimengli_clg_buff.dataList = dataList

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

return t_divine_mimengli_clg_buff
