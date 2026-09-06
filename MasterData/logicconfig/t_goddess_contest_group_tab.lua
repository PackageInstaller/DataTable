-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_group_tab.lua

module("logicconfig.config.t_goddess_contest_group_tab", package.seeall)

local title = {
	showTab = 5,
	name = 3,
	viewname = 4,
	redPointId = 6,
	id = 2,
	groupTabsPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"女神投票",
		"goddesscontestgroupvoteview",
		"女神",
		"-327"
	},
	{
		1,
		2,
		"团长竞选",
		"goddesscontestgroupmemberview",
		"团长",
		"-328"
	},
	{
		1,
		3,
		"活动",
		"goddesscontesthudview",
		"热门",
		"-408"
	},
	{
		1,
		4,
		"大赛奖励",
		"goddesscontestrewardview",
		"奖励",
		""
	}
}
local t_goddess_contest_group_tab = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_goddess_contest_group_tab.dataList = dataList

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

return t_goddess_contest_group_tab
