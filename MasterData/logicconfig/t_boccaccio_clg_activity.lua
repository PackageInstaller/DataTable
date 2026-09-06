-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_clg_activity.lua

module("logicconfig.config.t_boccaccio_clg_activity", package.seeall)

local title = {
	raceId = 2,
	jumpList = 3,
	activityId = 1
}
local dataList = {
	{
		578001,
		17027,
		{
			"ui#goddailyrankmainview#578001",
			"func#618#17027",
			"mibao#MibaoShop",
			"func#95#Skin#all#50068",
			"ui#wandererpassmainview#582001#4"
		}
	}
}
local t_boccaccio_clg_activity = {
	[578001] = dataList[1]
}

t_boccaccio_clg_activity.dataList = dataList

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

return t_boccaccio_clg_activity
