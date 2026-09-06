-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_invite_limit.lua

module("logicconfig.config.t_campaign_invite_limit", package.seeall)

local title = {
	desc = 6,
	limitType = 5,
	type = 2,
	timesLimit = 4,
	planId = 1,
	scorePrize = 3
}
local dataList = {
	{
		1,
		1,
		15,
		5,
		1,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		1,
		2,
		15,
		1,
		2,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		1,
		3,
		3,
		6,
		2,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		1,
		4,
		5,
		4,
		2,
		"使用%s分享的密语（<color=#eb4642>积分+%s</color>）"
	},
	{
		2,
		1,
		85,
		5,
		1,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		2,
		2,
		10,
		5,
		1,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		2,
		3,
		20,
		3,
		2,
		"分享密语被%s玩家使用（<color=#eb4642>积分+%s</color>）"
	},
	{
		2,
		4,
		5,
		4,
		2,
		"使用%s分享的密语（<color=#eb4642>积分+%s</color>）"
	}
}
local t_campaign_invite_limit = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_campaign_invite_limit.dataList = dataList

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

return t_campaign_invite_limit
