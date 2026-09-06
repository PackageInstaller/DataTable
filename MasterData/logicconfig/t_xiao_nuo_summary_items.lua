-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_items.lua

module("logicconfig.config.t_xiao_nuo_summary_items", package.seeall)

local title = {
	id = 1,
	jumpTo = 4,
	item = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"前往",
		"100:10141#4:64010",
		"func#978"
	},
	{
		2,
		"龙皇挑战兑换",
		"4:41004",
		"func#5003"
	}
}
local t_xiao_nuo_summary_items = {
	dataList[1],
	dataList[2]
}

t_xiao_nuo_summary_items.dataList = dataList

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

return t_xiao_nuo_summary_items
