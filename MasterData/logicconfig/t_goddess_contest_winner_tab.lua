-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_winner_tab.lua

module("logicconfig.config.t_goddess_contest_winner_tab", package.seeall)

local title = {
	showTab = 5,
	name = 3,
	viewname = 4,
	isHideBG = 7,
	id = 2,
	winnerTabsPlanId = 1,
	redPointId = 6
}
local dataList = {
	{
		1,
		1,
		"优胜女神",
		"goddesscontestwingroupview",
		"",
		"",
		false
	},
	{
		1,
		2,
		"优胜团",
		"goddesscontestwinleaderview",
		"",
		"",
		true
	}
}
local t_goddess_contest_winner_tab = {
	{
		dataList[1],
		dataList[2]
	}
}

t_goddess_contest_winner_tab.dataList = dataList

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

return t_goddess_contest_winner_tab
