-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_xiu_nuo_clg.lua

module("logicconfig.config.t_divine_xiu_nuo_clg", package.seeall)

local title = {
	extremeClgPrize = 3,
	jumpStrOne = 4,
	skinId = 9,
	jumpStrThree = 6,
	bubbleItem = 10,
	jumpStrTwo = 5,
	redPointId = 2,
	jumpStrFive = 8,
	jumpStrFour = 7,
	activityId = 1
}
local dataList = {
	{
		395001,
		587,
		"",
		"func#618#17020",
		"mibao#shenyaolibao",
		"ui#lottery",
		"",
		"",
		17020,
		""
	}
}
local t_divine_xiu_nuo_clg = {
	[395001] = dataList[1]
}

t_divine_xiu_nuo_clg.dataList = dataList

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

return t_divine_xiu_nuo_clg
