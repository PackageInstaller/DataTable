-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cantonese_opera_introduce_prize.lua

module("logicconfig.config.t_cantonese_opera_introduce_prize", package.seeall)

local title = {
	isLast = 9,
	name = 4,
	nodeId = 2,
	prize = 3,
	roadIdx = 8,
	image = 5,
	planId = 1,
	desc = 6,
	shareId = 7
}
local dataList = {
	{
		1,
		1,
		"10:17017:100#8:1:375000",
		"粤剧芳华",
		"hud_icon_s_mbsc02",
		"1",
		"11",
		"6",
		0
	},
	{
		1,
		2,
		"10:17017:100#8:1:375000",
		"传承使命",
		"hud_icon_s_zuduichongzhi",
		"2",
		"12",
		"12",
		0
	},
	{
		1,
		3,
		"10:17017:100#8:1:375000",
		"粤韵新唱",
		"hud_icon_s_yongchuangmijing",
		"3",
		"13",
		"15",
		0
	},
	{
		1,
		4,
		"2:57:1#10:17017:200#8:1:375000",
		"接受传承",
		"hud_icon_shengqituandui",
		"4",
		"",
		"21",
		1
	}
}
local t_cantonese_opera_introduce_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_cantonese_opera_introduce_prize.dataList = dataList

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

return t_cantonese_opera_introduce_prize
