-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_infinite_future_clg.lua

module("logicconfig.config.t_divine_infinite_future_clg", package.seeall)

local title = {
	paramStr = 3,
	openTime = 2,
	activityId = 1,
	skinId = 4
}
local dataList = {
	{
		455001,
		"00:00:00",
		"{\"jumpStr1\":\"func#618#16032\",\"jumpStr2\":\"mibao#shenyaomiya5\",\"jumpStr3\":\"ui#lottery\"}",
		16032
	},
	{
		455002,
		"00:00:00",
		"{\"jumpStr1\":\"func#618#16032\",\"jumpStr2\":\"mibao#shenyaomiya5\",\"jumpStr3\":\"ui#lottery\"}",
		16032
	}
}
local t_divine_infinite_future_clg = {
	[455001] = dataList[1],
	[455002] = dataList[2]
}

t_divine_infinite_future_clg.dataList = dataList

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

return t_divine_infinite_future_clg
