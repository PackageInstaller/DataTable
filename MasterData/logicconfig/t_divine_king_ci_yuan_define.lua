-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ci_yuan_define.lua

module("logicconfig.config.t_divine_king_ci_yuan_define", package.seeall)

local title = {
	jumpStrThree = 4,
	jumpStrTwo = 3,
	skinId = 6,
	jumpStrOne = 2,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		405001,
		"func#618#14027",
		"ui#lottery",
		"mibao#shenyaonuoya3",
		"divinekingciyuanmainview_rule",
		14027
	},
	{
		405002,
		"func#618#14027",
		"ui#lottery",
		"mibao#shenyaonuoya3",
		"divinekingciyuanmainview_rule",
		14027
	}
}
local t_divine_king_ci_yuan_define = {
	[405001] = dataList[1],
	[405002] = dataList[2]
}

t_divine_king_ci_yuan_define.dataList = dataList

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

return t_divine_king_ci_yuan_define
