-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_house_trade_const.lua

module("logic.config.t_house_trade_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"OrderProductivity",
		32000,
		0,
		""
	},
	{
		"DailyOrderRefreshTimesFree",
		1,
		0,
		""
	},
	{
		"DailyOrderRefreshTimesMax",
		10,
		0,
		""
	},
	{
		"OrderRefreshCost",
		0,
		0,
		"{1701001:3}"
	},
	{
		"GoodsPriceRatioMax",
		4,
		0,
		""
	},
	{
		"GoodsPriceRatioMin",
		0,
		0.3,
		""
	},
	{
		"OrderSpeedUpCostItem",
		1701001,
		0,
		""
	},
	{
		"OrderSpeedUpMinute",
		5,
		0,
		""
	},
	{
		"WorkJobNames",
		0,
		0,
		"{\"贸易操作\",\"物资调配\",\"采购中心\"}"
	},
	{
		"CharacterDefaultProduction",
		20,
		0,
		""
	}
}
local t_house_trade_const = {}

t_house_trade_const.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_house_trade_const[v[1]] = v

	setmetatable(v, mt)
end

return t_house_trade_const
