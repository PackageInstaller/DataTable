-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fuyao_challenge.lua

module("logicconfig.config.t_fuyao_challenge", package.seeall)

local title = {
	jump_rank = 5,
	activityId = 1,
	mainRuleKey = 9,
	jump_shop = 7,
	jump_give = 6,
	extremeBuffId = 4,
	raceId = 8,
	extremePassScore = 2,
	extremePrize = 3
}
local dataList = {
	{
		272001,
		15,
		"100:12014:1:1",
		30000009,
		"func#618#12014",
		"func#43#105",
		"mibao#xuwufuyao1",
		12014,
		"FuYaoChallengeRule"
	},
	{
		272002,
		15,
		"8:1:1000",
		30000009,
		"func#618#12014",
		"func#43#105",
		"mibao#xuwufuyao1",
		12014,
		"FuYaoChallengeRule01"
	}
}
local t_fuyao_challenge = {
	[272001] = dataList[1],
	[272002] = dataList[2]
}

t_fuyao_challenge.dataList = dataList

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

return t_fuyao_challenge
