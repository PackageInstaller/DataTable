-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_flower.lua

module("logicconfig.config.t_goddess_flower", package.seeall)

local title = {
	feeling = 4,
	effPath = 6,
	prize = 5,
	cost = 3,
	id = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		"4:105:1",
		6,
		"8:1:600",
		"fx_ui_yilishabaitiaozhan/fx_ui_songhua_1"
	},
	{
		1,
		2,
		"4:106:1",
		33,
		"8:1:3300",
		"fx_ui_yilishabaitiaozhan/fx_ui_songhua_2"
	}
}
local t_goddess_flower = {
	{
		dataList[1],
		dataList[2]
	}
}

t_goddess_flower.dataList = dataList

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

return t_goddess_flower
