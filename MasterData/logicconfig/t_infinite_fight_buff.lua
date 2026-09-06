-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_infinite_fight_buff.lua

module("logicconfig.config.t_infinite_fight_buff", package.seeall)

local title = {
	quality = 5,
	name = 3,
	buffId = 2,
	icon = 6,
	planId = 1,
	desc = 4
}
local dataList = {
	{
		1,
		111,
		"物防增强",
		"物防提升16%",
		2,
		"icon_expedition_wufang"
	},
	{
		1,
		112,
		"魔防增强",
		"魔防提升16%",
		2,
		"icon_expedition_mofang"
	},
	{
		1,
		116,
		"闪避增强",
		"闪避率提升6%",
		2,
		"icon_expedition_jihuo"
	},
	{
		1,
		118,
		"格挡增强",
		"格挡率提升20%",
		2,
		"icon_expedition_chushouqianjianshang"
	},
	{
		1,
		119,
		"暴击增强",
		"暴击率提升20%",
		2,
		"icon_expedition_baojilv1"
	}
}
local t_infinite_fight_buff = {
	{
		[111] = dataList[1],
		[112] = dataList[2],
		[116] = dataList[3],
		[118] = dataList[4],
		[119] = dataList[5]
	}
}

t_infinite_fight_buff.dataList = dataList

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

return t_infinite_fight_buff
