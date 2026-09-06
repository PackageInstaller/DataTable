-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_actiivty.lua

module("logicconfig.config.t_prince_liyang_actiivty", package.seeall)

local title = {
	itemId = 5,
	storageLimit = 4,
	storyId = 9,
	rankTipStr = 8,
	c3RefreshCd = 12,
	eventLimit = 6,
	eventCd = 7,
	cycle = 3,
	redPointId = 2,
	shopGotoStr = 10,
	activityId = 1,
	ruleKey = 11
}
local dataList = {
	{
		509001,
		725,
		10,
		2100000000,
		509001,
		3,
		3600,
		"1、根据国君等级高低排行\n2、相同等级时，达成时间越早排行越高\n3、活动结束后，排行奖励将通过邮箱发送",
		4820011,
		"func#191#509#509001",
		"liyangkingmainview_rule",
		30
	}
}
local t_prince_liyang_actiivty = {
	[509001] = dataList[1]
}

t_prince_liyang_actiivty.dataList = dataList

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

return t_prince_liyang_actiivty
