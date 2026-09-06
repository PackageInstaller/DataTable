-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_campaign_consume_const.lua

module("logicconfig.config.t_campaign_consume_const", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TARGETACTIVITYID",
		"22010"
	},
	{
		"ANIMPATH",
		"storyconfig/animations/fx_ui_aixintanchuang.txt"
	}
}
local t_campaign_consume_const = {
	TARGETACTIVITYID = dataList[1],
	ANIMPATH = dataList[2]
}

t_campaign_consume_const.dataList = dataList

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

return t_campaign_consume_const
