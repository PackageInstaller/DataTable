-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_badge_icon_group.lua

module("logicconfig.config.t_badge_icon_group", package.seeall)

local title = {
	icon = 3,
	iconGroupId = 1,
	level = 2
}
local dataList = {
	{
		1001,
		1,
		"icon_110001.png"
	},
	{
		1002,
		1,
		"icon_110002.png"
	},
	{
		1003,
		1,
		"icon_110003.png"
	},
	{
		1004,
		1,
		"icon_110004.png"
	},
	{
		1005,
		1,
		"icon_110005.png"
	},
	{
		1006,
		1,
		"icon_110006.png"
	},
	{
		1007,
		1,
		"icon_110007.png"
	},
	{
		1008,
		1,
		"icon_110008.png"
	},
	{
		1009,
		1,
		"icon_110009.png"
	},
	{
		1009,
		2,
		"icon_110009.png"
	},
	{
		1009,
		3,
		"icon_110009.png"
	},
	{
		1010,
		1,
		"icon_110010.png"
	},
	{
		1010,
		2,
		"icon_110010.png"
	},
	{
		1010,
		3,
		"icon_110010.png"
	},
	{
		1011,
		1,
		"icon_110011.png"
	},
	{
		1011,
		2,
		"icon_110011.png"
	},
	{
		1011,
		3,
		"icon_110011.png"
	},
	{
		1012,
		1,
		"icon_110012.png"
	},
	{
		1012,
		2,
		"icon_110012.png"
	},
	{
		1012,
		3,
		"icon_110012.png"
	}
}
local t_badge_icon_group = {
	[1001] = {
		dataList[1]
	},
	[1002] = {
		dataList[2]
	},
	[1003] = {
		dataList[3]
	},
	[1004] = {
		dataList[4]
	},
	[1005] = {
		dataList[5]
	},
	[1006] = {
		dataList[6]
	},
	[1007] = {
		dataList[7]
	},
	[1008] = {
		dataList[8]
	},
	[1009] = {
		dataList[9],
		dataList[10],
		dataList[11]
	},
	[1010] = {
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[1011] = {
		dataList[15],
		dataList[16],
		dataList[17]
	},
	[1012] = {
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_badge_icon_group.dataList = dataList

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

return t_badge_icon_group
