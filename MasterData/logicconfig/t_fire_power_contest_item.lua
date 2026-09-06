-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_power_contest_item.lua

module("logicconfig.config.t_fire_power_contest_item", package.seeall)

local title = {
	score = 2,
	effect = 3,
	colliderRange = 5,
	resImg = 4,
	resId = 1
}
local dataList = {
	{
		1,
		10,
		"fx_ui_hyll_shouji_lan",
		"board_hyll_18",
		{
			32,
			50,
			0,
			0
		}
	},
	{
		2,
		5,
		"fx_ui_hyll_shouji_zi",
		"board_hyll_19",
		{
			32,
			40,
			0,
			0
		}
	}
}
local t_fire_power_contest_item = {
	dataList[1],
	dataList[2]
}

t_fire_power_contest_item.dataList = dataList

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

return t_fire_power_contest_item
