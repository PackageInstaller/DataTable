-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_golden_diamond.lua

module("logicconfig.config.t_new_hand_welfare_golden_diamond", package.seeall)

local title = {
	itemId = 1,
	jumpTo = 3,
	funcId = 2
}
local dataList = {
	{
		1,
		260,
		"func#260"
	},
	{
		2,
		25,
		"func#25"
	},
	{
		3,
		91,
		"func#91"
	},
	{
		4,
		52,
		"func#52"
	},
	{
		5,
		43,
		"func#43"
	},
	{
		6,
		93,
		"func#93"
	},
	{
		7,
		232,
		"func#232"
	},
	{
		8,
		106,
		"func#106"
	},
	{
		9,
		47,
		"func#47"
	}
}
local t_new_hand_welfare_golden_diamond = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_new_hand_welfare_golden_diamond.dataList = dataList

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

return t_new_hand_welfare_golden_diamond
