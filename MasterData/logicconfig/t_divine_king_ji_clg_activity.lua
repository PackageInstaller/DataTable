-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ji_clg_activity.lua

module("logicconfig.config.t_divine_king_ji_clg_activity", package.seeall)

local title = {
	skinId = 4,
	paramStr = 5,
	sameRaceTypeAddLock = 3,
	diffRaceTypeAddLock = 2,
	activityId = 1
}
local dataList = {
	{
		463001,
		-1,
		2,
		16033,
		"{\"jumpStr1\":\"func#618#16033\",\"jumpStr2\":\"mibao#ZhounianShop2\",\"jumpStr3\":\"ui#lottery\"}"
	}
}
local t_divine_king_ji_clg_activity = {
	[463001] = dataList[1]
}

t_divine_king_ji_clg_activity.dataList = dataList

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

return t_divine_king_ji_clg_activity
