-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_psychic_ji_activity.lua

module("logicconfig.config.t_origin_psychic_ji_activity", package.seeall)

local title = {
	prize = 4,
	skinId = 5,
	paramStr = 6,
	differenceLimit = 2,
	extStageMaxEnergy = 3,
	activityId = 1
}
local dataList = {
	{
		542001,
		{
			0,
			10
		},
		120,
		"4:432:100",
		16041,
		"{\"jumpStr1\":\"func#618#16041\",\"jumpStr2\":\"event#gotofirstpassrankview#542001\",\"jumpStr3\":\"func#43#122\",\"jumpStr4\":\"ui#lottery\",\"jumpStr5\":\"mibao#jinglingyangcheng\"}"
	}
}
local t_origin_psychic_ji_activity = {
	[542001] = dataList[1]
}

t_origin_psychic_ji_activity.dataList = dataList

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

return t_origin_psychic_ji_activity
