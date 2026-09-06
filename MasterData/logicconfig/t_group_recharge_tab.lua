-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_group_recharge_tab.lua

module("logicconfig.config.t_group_recharge_tab", package.seeall)

local title = {
	reportBehavior = 8,
	name = 2,
	showTag = 10,
	redpointId = 6,
	parameter = 7,
	bg = 9,
	desc = 11,
	viewname = 3,
	funcId = 5,
	id = 1,
	sort = 4
}
local dataList = {
	{
		1,
		"个人奖励",
		"grouprechargeprogressview",
		2,
		0,
		"298",
		"1",
		0,
		"bg_czhl_zxsn",
		"",
		""
	},
	{
		2,
		"组队奖励",
		"grouprechargeprogressview",
		3,
		0,
		"",
		"2",
		0,
		"bg_czhl_wxwl02",
		"",
		""
	},
	{
		3,
		"组队列表",
		"grouprechargeteamview",
		1,
		0,
		"-251",
		"",
		0,
		"",
		"",
		"*团队人数达到2人即自动成团，成团后无法更改团队或退出"
	}
}
local t_group_recharge_tab = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_group_recharge_tab.dataList = dataList

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

return t_group_recharge_tab
