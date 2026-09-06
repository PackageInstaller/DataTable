-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_hud.lua

module("logicconfig.config.t_goddess_contest_hud", package.seeall)

local title = {
	id = 2,
	redPointId = 3,
	picPath = 4,
	gotoStr = 5,
	hudPlanId = 1,
	dealType = 6
}
local dataList = {
	{
		1,
		1,
		"",
		"board_nsds_hdjm17",
		"func#834",
		""
	},
	{
		1,
		2,
		"",
		"board_nsds_hdjm18",
		"func#835",
		""
	},
	{
		1,
		3,
		"-408",
		"board_nsds_hdjm34",
		"event#entercardview",
		""
	},
	{
		1,
		4,
		"",
		"board_nsds_hdjm19",
		"event#Goddess_Contest_Frenzy_Event",
		"Frenzy"
	}
}
local t_goddess_contest_hud = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_goddess_contest_hud.dataList = dataList

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

return t_goddess_contest_hud
