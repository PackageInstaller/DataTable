-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_activity.lua

module("logicconfig.config.t_origin_ares_mom_clg_activity", package.seeall)

local title = {
	extremePassEnergy = 4,
	buffEnergy = 3,
	raceId = 9,
	energyAddBuffPlanId = 6,
	buffSignId = 2,
	redPointId = 7,
	paramStr = 8,
	activityId = 1,
	extremePrize = 5
}
local dataList = {
	{
		549001,
		30000088,
		1,
		40,
		"4:510678:100",
		1,
		752,
		"{\"jumpStr1\":\"func#618#13025\",\"jumpStr2\":\"mibao#MibaoShop\",\"jumpStr3\":\"ui#lottery\",\"jumpStr4\":\"func#43#143\",\"jumpStr5\":\"event#gotofirstpassrankview#549001\"}",
		13025
	}
}
local t_origin_ares_mom_clg_activity = {
	[549001] = dataList[1]
}

t_origin_ares_mom_clg_activity.dataList = dataList

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

return t_origin_ares_mom_clg_activity
