-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_competition_group.lua

module("logicconfig.config.t_annual_competition_group", package.seeall)

local title = {
	groupId = 2,
	cost = 3,
	systemPetPlanId = 1
}
local dataList = {
	{
		21,
		1,
		50
	},
	{
		21,
		2,
		30
	},
	{
		21,
		3,
		20
	},
	{
		22,
		1,
		50
	},
	{
		22,
		2,
		30
	},
	{
		22,
		3,
		20
	},
	{
		23,
		1,
		50
	},
	{
		23,
		2,
		30
	},
	{
		23,
		3,
		20
	},
	{
		24,
		1,
		50
	},
	{
		24,
		2,
		30
	},
	{
		24,
		3,
		20
	},
	{
		25,
		1,
		50
	},
	{
		25,
		2,
		30
	},
	{
		25,
		3,
		20
	},
	{
		26,
		1,
		50
	},
	{
		26,
		2,
		30
	},
	{
		26,
		3,
		20
	},
	{
		27,
		1,
		50
	},
	{
		27,
		2,
		30
	},
	{
		27,
		3,
		20
	},
	{
		28,
		1,
		50
	},
	{
		28,
		2,
		30
	},
	{
		28,
		3,
		20
	}
}
local t_annual_competition_group = {
	[21] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[22] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[23] = {
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[24] = {
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[25] = {
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[26] = {
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[27] = {
		dataList[19],
		dataList[20],
		dataList[21]
	},
	[28] = {
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_annual_competition_group.dataList = dataList

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

return t_annual_competition_group
