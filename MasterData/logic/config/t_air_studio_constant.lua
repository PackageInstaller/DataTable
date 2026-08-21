-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_constant.lua

module("logic.config.t_air_studio_constant", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"PlainCellType",
		101,
		0,
		""
	},
	{
		"HighCellType",
		102,
		0,
		""
	},
	{
		"AttackDataShowNum",
		5,
		0,
		""
	},
	{
		"DefenceDataShowNum",
		5,
		0,
		""
	},
	{
		"CellKillShowNum",
		5,
		0,
		""
	},
	{
		"MineExitAdditionalTerrainCode",
		1005,
		0,
		""
	},
	{
		"AttackRecordSaveNum",
		200,
		0,
		""
	},
	{
		"RecommendNumPerTag",
		30,
		0,
		""
	},
	{
		"TagWeightCreator",
		20,
		0,
		""
	},
	{
		"TagWeightPlayer",
		1,
		0,
		""
	},
	{
		"MaxTagNumPerTimes",
		2,
		0,
		""
	},
	{
		"TagNumPerMap",
		2,
		0,
		""
	},
	{
		"WinDefaultDesc",
		0,
		0,
		"敌方全灭"
	},
	{
		"CommentSaveNum",
		50,
		0,
		""
	},
	{
		"StoreTabId",
		9001,
		0,
		""
	},
	{
		"MinBornCellNum",
		5,
		0,
		""
	},
	{
		"NewsCommentNum",
		20,
		0,
		""
	},
	{
		"NewsLikeNum",
		20,
		0,
		""
	},
	{
		"NewsDefenceNum",
		20,
		0,
		""
	}
}
local t_air_studio_constant = {}

t_air_studio_constant.dataList = dataList

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
	t_air_studio_constant[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_constant
