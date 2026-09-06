-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_space_dragon_clg_activity.lua

module("logicconfig.config.t_king_space_dragon_clg_activity", package.seeall)

local title = {
	ruleKeyLevels = 7,
	rewardStr = 8,
	jumpStrThree = 5,
	skinId = 2,
	jumpStrTwo = 4,
	ruleKeyMain = 6,
	activityId = 1,
	jumpStrOne = 3
}
local dataList = {
	{
		350001,
		14024,
		"func#618#14024",
		"func#1055",
		"mibao#rexueguixin5",
		"kingspacedragonmainview_rule",
		"kingspacedragonlevelsview_rule",
		"4:414"
	},
	{
		350002,
		11035,
		"func#618#11035",
		"func#545#22",
		"mibao#rexueguixin5",
		"divineymjdmainview_rule",
		"divineymjdlevelsview_rule",
		"4:398"
	},
	{
		350003,
		14024,
		"func#618#14024",
		"func#1055",
		"mibao#rexueguixin5",
		"kingspacedragonlevelsview_rule2",
		"kingspacedragonlevelsview_rule2",
		"8:1"
	},
	{
		350004,
		14044,
		"func#618#14044",
		"ui#lottery",
		"mibao#mengduiyangcheng",
		"aixinmmchallenge_rule",
		"aixinmmchallenge_rule",
		"4:510800"
	}
}
local t_king_space_dragon_clg_activity = {
	[350001] = dataList[1],
	[350002] = dataList[2],
	[350003] = dataList[3],
	[350004] = dataList[4]
}

t_king_space_dragon_clg_activity.dataList = dataList

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

return t_king_space_dragon_clg_activity
