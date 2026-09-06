-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survey_define.lua

module("logicconfig.config.t_survey_define", package.seeall)

local title = {
	surveyId = 1,
	reward = 2
}
local dataList = {
	{
		11001,
		"4:31:1#8:1:30000"
	},
	{
		11002,
		"104:2:50#4:31:2#8:1:30000"
	},
	{
		11003,
		"104:2:300#4:36:1"
	},
	{
		11004,
		"104:2:500#4:36:2#8:1:100000"
	}
}
local t_survey_define = {
	[11001] = dataList[1],
	[11002] = dataList[2],
	[11003] = dataList[3],
	[11004] = dataList[4]
}

t_survey_define.dataList = dataList

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

return t_survey_define
