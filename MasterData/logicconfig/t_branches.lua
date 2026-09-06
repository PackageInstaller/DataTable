-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_branches.lua

module("logicconfig.config.t_branches", package.seeall)

local title = {
	idStart = 6,
	name = 2,
	repeatable = 5,
	id = 1,
	branchType = 4,
	desc = 3
}
local dataList = {
	{
		1,
		"主线任务",
		"主线任务",
		1,
		false,
		101
	}
}
local t_branches = {
	dataList[1]
}

t_branches.dataList = dataList

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

return t_branches
