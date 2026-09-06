-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_contest_authority.lua

module("logicconfig.config.t_goddess_contest_authority", package.seeall)

local title = {
	member2 = 3,
	member3 = 4,
	authority = 1,
	member4 = 5,
	member1 = 2
}
local dataList = {
	{
		"REVISE_DECLARATION",
		1,
		1,
		0,
		0
	},
	{
		"PRESS_VOTE",
		1,
		1,
		0,
		0
	}
}
local t_goddess_contest_authority = {
	REVISE_DECLARATION = dataList[1],
	PRESS_VOTE = dataList[2]
}

t_goddess_contest_authority.dataList = dataList

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

return t_goddess_contest_authority
