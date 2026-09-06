-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bigOrange_type.lua

module("logicconfig.config.t_bigOrange_type", package.seeall)

local title = {
	id = 1,
	types = 2
}
local dataList = {
	{
		1,
		"精灵获得"
	},
	{
		2,
		"精灵养成"
	},
	{
		3,
		"精灵上新"
	},
	{
		4,
		"皮肤上新"
	},
	{
		5,
		"其他"
	}
}
local t_bigOrange_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_bigOrange_type.dataList = dataList

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

return t_bigOrange_type
