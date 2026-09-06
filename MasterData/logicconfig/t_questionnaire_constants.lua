-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_questionnaire_constants.lua

module("logicconfig.config.t_questionnaire_constants", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FillBlank_Min_Input_Characters",
		"5"
	}
}
local t_questionnaire_constants = {
	FillBlank_Min_Input_Characters = dataList[1]
}

t_questionnaire_constants.dataList = dataList

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

return t_questionnaire_constants
