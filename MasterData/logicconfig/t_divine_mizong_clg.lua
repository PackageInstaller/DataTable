-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_mizong_clg.lua

module("logicconfig.config.t_divine_mizong_clg", package.seeall)

local title = {
	farBg = 9,
	ruleKeyMain = 10,
	skinId = 6,
	jumpStrThree = 13,
	specialPetSign = 2,
	upgradeItem = 5,
	jumpStrTwo = 12,
	jumpRedIdTwo = 16,
	jumpRedIdOne = 15,
	jumpRedIdFour = 18,
	redPointId = 3,
	middleBg = 8,
	jumpRedIdThree = 17,
	activityId = 1,
	jumpStrOne = 11,
	nearBg = 7,
	jumpStrFour = 14,
	dailyGainItemCount = 4
}
local dataList = {
	{
		477001,
		"圣骑队",
		701,
		30,
		"1004:1462",
		13024,
		"copychapter/chapterbg/shuzuizhexiagu1",
		"copychapter/chapterbg/shuzuizhexiagu2",
		"copychapter/chapterbg/shuzuizhexiagu3",
		"divinemizongclgmainview_rule",
		"func#618#13024",
		"mibao#shengqiyangcheng",
		"ui#lottery",
		"func#545#20",
		"",
		"",
		"",
		""
	}
}
local t_divine_mizong_clg = {
	[477001] = dataList[1]
}

t_divine_mizong_clg.dataList = dataList

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

return t_divine_mizong_clg
