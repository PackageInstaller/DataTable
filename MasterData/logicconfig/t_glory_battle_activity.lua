-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_activity.lua

module("logicconfig.config.t_glory_battle_activity", package.seeall)

local title = {
	paramStr = 3,
	showBar = 4,
	activityId = 1,
	battlePetPlan = 2
}
local dataList = {
	{
		528001,
		1,
		"{\"jumpStr1\":\"ui#glorybattlerankview\",\"jumpStr2\":\"ui#glorybattlereportview\",\"jumpStr3\":\"func#191#528#528001\",\"jumpStr4\":\"ui#commongrouptaskmainview#528001\"}",
		"10:528001"
	},
	{
		528002,
		2,
		"{\"jumpStr1\":\"ui#glorybattlerankview\",\"jumpStr2\":\"ui#glorybattlereportview\",\"jumpStr3\":\"func#191#528#528002\",\"jumpStr4\":\"ui#commongrouptaskmainview#528002\"}",
		"10:528002"
	},
	{
		528003,
		528003,
		"{\"jumpStr1\":\"ui#glorybattlerankview\",\"jumpStr2\":\"ui#glorybattlereportview\",\"jumpStr3\":\"func#191#528#528003\",\"jumpStr4\":\"ui#commongrouptaskmainview#528003\"}",
		"10:528003"
	},
	{
		528004,
		528004,
		"{\"jumpStr1\":\"ui#glorybattlerankview\",\"jumpStr2\":\"ui#glorybattlereportview\",\"jumpStr3\":\"func#191#528#528004\",\"jumpStr4\":\"ui#commongrouptaskmainview#528004\"}",
		"10:528004"
	},
	{
		528005,
		528005,
		"{\"jumpStr1\":\"ui#glorybattlerankview\",\"jumpStr2\":\"ui#glorybattlereportview\",\"jumpStr3\":\"func#191#528#528004\",\"jumpStr4\":\"ui#commongrouptaskmainview#528005\"}",
		"10:528005"
	}
}
local t_glory_battle_activity = {
	[528001] = dataList[1],
	[528002] = dataList[2],
	[528003] = dataList[3],
	[528004] = dataList[4],
	[528005] = dataList[5]
}

t_glory_battle_activity.dataList = dataList

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

return t_glory_battle_activity
