-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_recap2021_base.lua

module("logicconfig.config.t_recap2021_base", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"ACTIVITY_ID",
		"136002"
	},
	{
		"RECAP_SHARE_LINK_ID",
		"10"
	},
	{
		"LETTER_PLAN_ID",
		"1"
	},
	{
		"AQ_EVENT_ID",
		"1"
	},
	{
		"PERSON_EVENT_ID",
		"1"
	},
	{
		"PET_WORD",
		"勇气#真诚#信念#善良#友谊#智慧#责任#热血#爱心#梦想#希望"
	},
	{
		"LETTER_SHOW_RACEIDS",
		"10002,10003"
	}
}
local t_recap2021_base = {
	ACTIVITY_ID = dataList[1],
	RECAP_SHARE_LINK_ID = dataList[2],
	LETTER_PLAN_ID = dataList[3],
	AQ_EVENT_ID = dataList[4],
	PERSON_EVENT_ID = dataList[5],
	PET_WORD = dataList[6],
	LETTER_SHOW_RACEIDS = dataList[7]
}

t_recap2021_base.dataList = dataList

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

return t_recap2021_base
