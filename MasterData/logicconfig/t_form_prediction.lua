-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_form_prediction.lua

module("logicconfig.config.t_form_prediction", package.seeall)

local title = {
	posMatchScore = 3,
	redPointId = 4,
	jumpTo = 5,
	petMatchScore = 2,
	activityId = 1
}
local dataList = {
	{
		385001,
		50,
		10,
		592,
		"func#1109"
	}
}
local t_form_prediction = {
	[385001] = dataList[1]
}

t_form_prediction.dataList = dataList

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

return t_form_prediction
