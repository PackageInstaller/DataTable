-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_npc.lua

module("logicconfig.config.t_surround_by_dream_girl_npc", package.seeall)

local title = {
	name = 2,
	npcId = 1,
	iconPath = 3
}
local dataList = {
	{
		1,
		"奥奇",
		"icon_common_aoqi"
	},
	{
		2,
		"末炎",
		"icon_15031_anmoyan01"
	},
	{
		3,
		"光耀神女",
		"icon_14031_nailong01"
	},
	{
		4,
		"弥梦离",
		"icon_12029_shenyaomimengli02"
	},
	{
		5,
		"尘",
		"icon_16031_shenyaochen02"
	}
}
local t_surround_by_dream_girl_npc = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_surround_by_dream_girl_npc.dataList = dataList

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

return t_surround_by_dream_girl_npc
