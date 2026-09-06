-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_expedition_mining_floatword.lua

module("logicconfig.config.t_saint_knight_expedition_mining_floatword", package.seeall)

local title = {
	exp = 2,
	id = 1,
	color = 3
}
local dataList = {
	{
		1,
		100,
		"5EF0B3FF"
	},
	{
		2,
		200,
		"7CBEF0FF"
	},
	{
		3,
		400,
		"E187F8FF"
	},
	{
		4,
		600,
		"F8AA3CFF"
	},
	{
		5,
		1000,
		"FF545DFF"
	}
}
local t_saint_knight_expedition_mining_floatword = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_saint_knight_expedition_mining_floatword.dataList = dataList

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

return t_saint_knight_expedition_mining_floatword
