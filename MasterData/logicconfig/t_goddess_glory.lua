-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_glory.lua

module("logicconfig.config.t_goddess_glory", package.seeall)

local title = {
	challengeId = 1,
	push_item_tips = 4,
	mainImage = 5,
	push_item = 3,
	name = 2,
	rules_key = 6
}
local dataList = {
	{
		33,
		"未来之战",
		"8:25:45",
		"可兑换星神",
		"10027_shengguangfeilong01",
		"tips_goddessglory"
	}
}
local t_goddess_glory = {
	[33] = dataList[1]
}

t_goddess_glory.dataList = dataList

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

return t_goddess_glory
