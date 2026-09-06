-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_stronger.lua

module("logicconfig.config.t_stronger", package.seeall)

local title = {
	id = 1,
	name = 2,
	zdlRange = 3
}
local dataList = {
	{
		1,
		"公共养成",
		"1#9000000"
	},
	{
		2,
		"金币",
		""
	},
	{
		3,
		"经验",
		""
	},
	{
		4,
		"潜能",
		""
	},
	{
		5,
		"星神",
		"1#9000000"
	},
	{
		6,
		"装备",
		"1#9000000"
	},
	{
		7,
		"觉醒",
		""
	},
	{
		8,
		"灵纹",
		""
	},
	{
		9,
		"宠物",
		""
	},
	{
		10,
		"源核",
		""
	}
}
local t_stronger = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_stronger.dataList = dataList

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

return t_stronger
