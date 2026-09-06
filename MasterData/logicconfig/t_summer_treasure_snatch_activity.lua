-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_activity.lua

module("logicconfig.config.t_summer_treasure_snatch_activity", package.seeall)

local title = {
	shopTabName = 8,
	bossImgPath = 7,
	shopSkinId = 9,
	jumpTo = 6,
	scoreMatStr = 3,
	winTeamPrize = 4,
	actShopMatStr = 10,
	endTime = 2,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		623001,
		"2026-08-21T05:00:00",
		"1004:1746",
		"1:300079:-1:1#104:2:50",
		"xiariduobaomainview_rule",
		{
			"ui#commongrouptaskmainview#623001"
		},
		"com_icon_qixi3344",
		{
			82057700,
			82057701
		},
		16046,
		"10:623001"
	}
}
local t_summer_treasure_snatch_activity = {
	[623001] = dataList[1]
}

t_summer_treasure_snatch_activity.dataList = dataList

local multiLanguageCells = {
	shopTabName = true
}
local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			local value = rawget(t, index)

			if multiLanguageCells[key] then
				value = lang(value)
			end

			return value
		else
			printWarn(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_summer_treasure_snatch_activity
