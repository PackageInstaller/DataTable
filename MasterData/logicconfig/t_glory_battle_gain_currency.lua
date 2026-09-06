-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_gain_currency.lua

module("logicconfig.config.t_glory_battle_gain_currency", package.seeall)

local title = {
	round = 1,
	gainCurrency = 2
}
local dataList = {
	{
		1,
		30
	},
	{
		2,
		40
	},
	{
		3,
		50
	},
	{
		4,
		60
	},
	{
		5,
		70
	},
	{
		6,
		80
	},
	{
		7,
		90
	},
	{
		8,
		100
	},
	{
		9,
		110
	},
	{
		10,
		120
	},
	{
		11,
		130
	}
}
local t_glory_battle_gain_currency = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11]
}

t_glory_battle_gain_currency.dataList = dataList

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

return t_glory_battle_gain_currency
