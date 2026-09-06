-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_festival_collection_prize.lua

module("logicconfig.config.t_lantern_festival_collection_prize", package.seeall)

local title = {
	prizeId = 2,
	cost = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		566001,
		1,
		"10:566002:5#10:566003:5#10:566004:5#10:566005:5#10:566006:5#10:566007:5",
		"14:487:1"
	},
	{
		566001,
		2,
		"10:566002:5#10:566003:5#10:566004:5#10:566005:5#10:566006:5#10:566007:5",
		"1:12021:-1:1"
	}
}
local t_lantern_festival_collection_prize = {
	[566001] = {
		dataList[1],
		dataList[2]
	}
}

t_lantern_festival_collection_prize.dataList = dataList

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

return t_lantern_festival_collection_prize
