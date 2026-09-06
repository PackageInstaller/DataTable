-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_qing_gu_hud.lua

module("logicconfig.config.t_qing_gu_hud", package.seeall)

local title = {
	id = 1,
	name = 2,
	redPointId = 6,
	tag = 3,
	gotoFunc = 4,
	content = 5,
	reportBehavior = 7
}
local dataList = {
	{
		1,
		"新职业介绍",
		"教学",
		"func#612",
		"24:100441:4#4:30006:60",
		"283",
		201006
	},
	{
		2,
		"王牌战队",
		"必得",
		"func#614",
		"4:510022:1#4:30006:20",
		"",
		201007
	},
	{
		3,
		"召唤卡池",
		"获得",
		"func#614",
		"4:30006:24#4:40008:12",
		"",
		201008
	},
	{
		4,
		"青骨成长之路",
		"挑战",
		"func#615",
		"4:1021:1#4:30006:706",
		"",
		201009
	},
	{
		5,
		"世界BOSS",
		"",
		"func#611",
		"24:100241#4:30005",
		"",
		201010
	},
	{
		6,
		"特惠商店",
		"皮肤",
		"func#611",
		"24:100241#4:30005",
		"",
		201010
	},
	{
		7,
		"剧情",
		"",
		"func#611",
		"",
		"",
		201010
	}
}
local t_qing_gu_hud = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_qing_gu_hud.dataList = dataList

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

return t_qing_gu_hud
