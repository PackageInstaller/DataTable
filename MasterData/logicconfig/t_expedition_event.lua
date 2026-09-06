-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_event.lua

module("logicconfig.config.t_expedition_event", package.seeall)

local title = {
	id = 1,
	name = 2,
	targetDesc = 4,
	mask = 3
}
local dataList = {
	{
		0,
		"起点",
		false,
		""
	},
	{
		1,
		"挑战",
		true,
		"击败%d个怪物，并领取圣器"
	},
	{
		2,
		"支援精灵",
		true,
		"选择%d个支援精灵"
	},
	{
		3,
		"圣器",
		false,
		"选择%d个圣器"
	},
	{
		4,
		"奖励",
		false,
		"领取奖励"
	},
	{
		5,
		"曙光泉水",
		false,
		"在曙光泉水复活阵亡精灵"
	},
	{
		6,
		"黑市商人",
		false,
		"在商人处进行交易"
	},
	{
		7,
		"特殊奖励",
		false,
		"领取终极奖励"
	}
}
local t_expedition_event = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_expedition_event.dataList = dataList

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

return t_expedition_event
