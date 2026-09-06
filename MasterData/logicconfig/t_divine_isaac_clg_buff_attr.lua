-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_isaac_clg_buff_attr.lua

module("logicconfig.config.t_divine_isaac_clg_buff_attr", package.seeall)

local title = {
	buffId = 1,
	attr = 2
}
local dataList = {
	{
		20064502,
		"水"
	},
	{
		20064503,
		"火"
	},
	{
		20064504,
		"草"
	},
	{
		20064505,
		"光"
	},
	{
		20064506,
		"暗"
	},
	{
		20064507,
		"空"
	},
	{
		20064508,
		"创"
	}
}
local t_divine_isaac_clg_buff_attr = {
	[20064502] = dataList[1],
	[20064503] = dataList[2],
	[20064504] = dataList[3],
	[20064505] = dataList[4],
	[20064506] = dataList[5],
	[20064507] = dataList[6],
	[20064508] = dataList[7]
}

t_divine_isaac_clg_buff_attr.dataList = dataList

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

return t_divine_isaac_clg_buff_attr
