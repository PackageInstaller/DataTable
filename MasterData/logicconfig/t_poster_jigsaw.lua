-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_poster_jigsaw.lua

module("logicconfig.config.t_poster_jigsaw", package.seeall)

local title = {
	posterPlanId = 3,
	activityId = 1,
	perLotteryPrize = 6,
	perLotteryCostItemType = 4,
	perLotteryCostNum = 5,
	timeShow = 7,
	taskPlanId = 2
}
local dataList = {
	{
		134001,
		1,
		1,
		"10:134001",
		35,
		"9:1033:1",
		"活动时间：4月1日-4月29日"
	}
}
local t_poster_jigsaw = {
	[134001] = dataList[1]
}

t_poster_jigsaw.dataList = dataList

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

return t_poster_jigsaw
