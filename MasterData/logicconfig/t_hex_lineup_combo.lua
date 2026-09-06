-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_combo.lua

module("logicconfig.config.t_hex_lineup_combo", package.seeall)

local title = {
	score = 3,
	comboId = 1,
	count = 2
}
local dataList = {
	{
		1,
		2,
		10
	},
	{
		2,
		3,
		20
	},
	{
		3,
		4,
		30
	},
	{
		4,
		5,
		40
	}
}
local t_hex_lineup_combo = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_hex_lineup_combo.dataList = dataList

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

return t_hex_lineup_combo
