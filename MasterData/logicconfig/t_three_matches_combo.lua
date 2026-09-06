-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_matches_combo.lua

module("logicconfig.config.t_three_matches_combo", package.seeall)

local title = {
	combo = 1,
	score = 2
}
local dataList = {
	{
		1,
		10
	},
	{
		2,
		30
	},
	{
		3,
		50
	}
}
local t_three_matches_combo = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_three_matches_combo.dataList = dataList

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

return t_three_matches_combo
