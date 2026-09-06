-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_zhong_fei_clg_normal_buff.lua

module("logicconfig.config.t_divine_zhong_fei_clg_normal_buff", package.seeall)

local title = {
	id = 2,
	damage = 3,
	activityId = 1,
	desc = 4
}
local dataList = {
	{
		515001,
		1,
		"1",
		"BOSS获得50%免伤"
	},
	{
		515001,
		2,
		"3",
		"BOSS攻击时，吸收50气势"
	},
	{
		515001,
		3,
		"5",
		"BOSS获得伤害+100%"
	}
}
local t_divine_zhong_fei_clg_normal_buff = {
	[515001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_divine_zhong_fei_clg_normal_buff.dataList = dataList

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

return t_divine_zhong_fei_clg_normal_buff
