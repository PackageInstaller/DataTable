-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jigsaw.lua

module("logicconfig.config.t_jigsaw", package.seeall)

local title = {
	taskPlan = 3,
	collectPrizePlan = 4,
	icon = 5,
	activityId = 1,
	piecePlan = 2
}
local dataList = {
	{
		20001,
		1,
		1,
		1,
		""
	}
}
local t_jigsaw = {
	[20001] = dataList[1]
}

t_jigsaw.dataList = dataList

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

return t_jigsaw
