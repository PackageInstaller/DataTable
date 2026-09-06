-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_team_hud_equipment.lua

module("logicconfig.config.t_dream_team_hud_equipment", package.seeall)

local title = {
	id = 1,
	showCells = 3,
	skinId = 2
}
local dataList = {
	{
		1,
		10343,
		"7:210343108:1#7:210343208:1"
	},
	{
		2,
		10339,
		"7:210339108:1#7:210339208:1"
	},
	{
		3,
		10342,
		"7:210342108:1#7:210342208:1"
	},
	{
		4,
		10338,
		"7:210338108:1#7:210338208:1"
	},
	{
		5,
		10341,
		"7:210341108:1#7:210341208:1"
	}
}
local t_dream_team_hud_equipment = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_dream_team_hud_equipment.dataList = dataList

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

return t_dream_team_hud_equipment
