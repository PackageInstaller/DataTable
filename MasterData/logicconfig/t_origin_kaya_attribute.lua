-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_kaya_attribute.lua

module("logicconfig.config.t_origin_kaya_attribute", package.seeall)

local title = {
	attributeId = 1,
	name = 2
}
local dataList = {
	{
		1,
		"草"
	},
	{
		2,
		"水"
	},
	{
		3,
		"火"
	},
	{
		4,
		"光"
	},
	{
		5,
		"暗"
	},
	{
		6,
		"空"
	},
	{
		7,
		"创"
	}
}
local t_origin_kaya_attribute = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_origin_kaya_attribute.dataList = dataList

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

return t_origin_kaya_attribute
