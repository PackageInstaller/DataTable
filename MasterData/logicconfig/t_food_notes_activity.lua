-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_food_notes_activity.lua

module("logicconfig.config.t_food_notes_activity", package.seeall)

local title = {
	cookPrize = 3,
	templateId = 6,
	dialogueDes = 5,
	timeDes = 4,
	dailyCookTimes = 2,
	activityId = 1
}
local dataList = {
	{
		125001,
		6,
		"",
		"活动时间：03月04日5:00-04月01日5:00",
		"这是我今天想吃的菜！",
		29
	},
	{
		125002,
		6,
		"",
		"活动时间：03月17日5:00-03月24日5:00",
		"这是今天想吃的菜！",
		29
	},
	{
		125003,
		4,
		"",
		"活动时间：04月30日5:00-05月17日5:00",
		"这是今天要做的礼物！",
		29
	},
	{
		125004,
		4,
		"",
		"活动时间：10月25日5:00-11月22日5:00",
		"这是今天要做的礼物！",
		29
	}
}
local t_food_notes_activity = {
	[125001] = dataList[1],
	[125002] = dataList[2],
	[125003] = dataList[3],
	[125004] = dataList[4]
}

t_food_notes_activity.dataList = dataList

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

return t_food_notes_activity
