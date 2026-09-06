-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_birthday_sports_wishes_tab.lua

module("logicconfig.config.t_birthday_sports_wishes_tab", package.seeall)

local title = {
	id = 2,
	openParam = 7,
	redPointId = 6,
	tag = 5,
	viewName = 4,
	title = 3,
	hudPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"战斗祝福",
		"battlewishesview",
		"战斗",
		"",
		""
	},
	{
		1,
		2,
		"租借精灵",
		"birthdaysportshireview",
		"祝福",
		"",
		"13005#11002#15006#16003#17006"
	},
	{
		1,
		3,
		"竞技任务",
		"birthdaysportstaskview",
		"任务",
		"454",
		"222002"
	}
}
local t_birthday_sports_wishes_tab = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_birthday_sports_wishes_tab.dataList = dataList

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

return t_birthday_sports_wishes_tab
