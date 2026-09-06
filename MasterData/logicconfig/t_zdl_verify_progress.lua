-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zdl_verify_progress.lua

module("logicconfig.config.t_zdl_verify_progress", package.seeall)

local title = {
	progressId = 2,
	verifyRaceNum = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		614001,
		1,
		4,
		"4:510849:1"
	}
}
local t_zdl_verify_progress = {
	[614001] = {
		dataList[1]
	}
}

t_zdl_verify_progress.dataList = dataList

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

return t_zdl_verify_progress
