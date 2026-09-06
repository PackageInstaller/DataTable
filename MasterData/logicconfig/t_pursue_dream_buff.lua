-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pursue_dream_buff.lua

module("logicconfig.config.t_pursue_dream_buff", package.seeall)

local title = {
	buffPlanId = 1,
	name = 5,
	selfBuff = 4,
	quality = 7,
	id = 2,
	icon = 8,
	weight = 3,
	desc = 6
}
local dataList = {
	{
		1,
		1,
		10,
		"623:99",
		"物防增强",
		"物防提升16%",
		2,
		"icon_expedition_wufang"
	},
	{
		1,
		2,
		10,
		"633:99",
		"魔防增强",
		"魔防提升16%",
		2,
		"icon_expedition_mofang"
	},
	{
		1,
		3,
		10,
		"675:99",
		"闪避增强",
		"闪避率提升6%",
		2,
		"icon_expedition_jihuo"
	},
	{
		1,
		4,
		10,
		"80:99",
		"格挡增强",
		"格挡率提升20%",
		2,
		"icon_expedition_chushouqianjianshang"
	},
	{
		1,
		5,
		10,
		"90:99",
		"暴击增强",
		"暴击率提升20%",
		2,
		"icon_expedition_baojilv1"
	}
}
local t_pursue_dream_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_pursue_dream_buff.dataList = dataList

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

return t_pursue_dream_buff
