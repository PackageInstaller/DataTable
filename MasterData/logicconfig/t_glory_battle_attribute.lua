-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_attribute.lua

module("logicconfig.config.t_glory_battle_attribute", package.seeall)

local title = {
	name = 2,
	attributeId = 1,
	iconName = 3
}
local dataList = {
	{
		1,
		"草",
		"icon_chuanshuodaoju_cao"
	},
	{
		2,
		"水",
		"icon_chuanshuodaoju_shui"
	},
	{
		3,
		"火",
		"icon_chuanshuodaoju_huo"
	},
	{
		4,
		"光",
		"icon_chuanshuodaoju_guang"
	},
	{
		5,
		"暗",
		"icon_chuanshuodaoju_an"
	},
	{
		6,
		"空",
		"icon_chuanshuodaoju_kong"
	},
	{
		7,
		"创",
		"icon_chuanshuodaoju_chuang"
	}
}
local t_glory_battle_attribute = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_glory_battle_attribute.dataList = dataList

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

return t_glory_battle_attribute
