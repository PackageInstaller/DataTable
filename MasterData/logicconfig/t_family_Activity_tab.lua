-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_activity_tab.lua

module("logicconfig.config.t_family_Activity_tab", package.seeall)

local title = {
	name = 2,
	redIds = 4,
	subViewName = 6,
	tabId = 1,
	tag = 5,
	params = 7,
	sort = 3
}
local dataList = {
	{
		1,
		"信息",
		1,
		"-391",
		"",
		"",
		"openinfo"
	},
	{
		2,
		"成员",
		2,
		"",
		"",
		"familymember",
		""
	},
	{
		3,
		"活动",
		4,
		"100#-226",
		"热门",
		"familyactivity",
		"1"
	},
	{
		4,
		"事务",
		5,
		"246#28#c14",
		"",
		"familyactivity",
		"2"
	},
	{
		5,
		"福利",
		3,
		"405#423",
		"最新",
		"familyactivity",
		"3"
	}
}
local t_family_Activity_tab = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_family_Activity_tab.dataList = dataList

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

return t_family_Activity_tab
