-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw_exchange.lua

module("logicconfig.config.t_jigsaw_exchange", package.seeall)

local title = {
	refundItemPerScore = 5,
	activityId = 1,
	activateJigsawCost = 6,
	scoreItemType = 4,
	picturePlanId = 3,
	taskPlanId = 2
}
local dataList = {
	{
		122001,
		1,
		1,
		"10:122001",
		"8:1:100",
		"10:122001:10"
	},
	{
		122004,
		2,
		2,
		"10:122004",
		"8:1:100",
		"10:122004:10"
	}
}
local t_jigsaw_exchange = {
	[122001] = dataList[1],
	[122004] = dataList[2]
}

t_jigsaw_exchange.dataList = dataList

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

return t_jigsaw_exchange
