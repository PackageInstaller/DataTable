-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_summary_lottery.lua

module("logicconfig.config.t_xiao_nuo_summary_lottery", package.seeall)

local title = {
	item = 4,
	jumpTo = 5,
	id = 1,
	title = 3,
	desc = 2
}
local dataList = {
	{
		1,
		"",
		"130<size=30>召唤券</size>",
		"4:10000013",
		"itemsource#4:10000013&&report_behavior#200532"
	},
	{
		2,
		"",
		"50<size=30>神唤券</size>",
		"4:10000014",
		"itemsource#4:10000014&&report_behavior#200533"
	},
	{
		3,
		"",
		"50<size=30>神炼石</size>",
		"4:10000015",
		"itemsource#4:10000015&&report_behavior#200534"
	},
	{
		4,
		"",
		"传说<size=30>精灵</size>",
		"4:10000008",
		"func#3#exchangecodeview&&report_behavior#200535"
	}
}
local t_xiao_nuo_summary_lottery = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_xiao_nuo_summary_lottery.dataList = dataList

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

return t_xiao_nuo_summary_lottery
