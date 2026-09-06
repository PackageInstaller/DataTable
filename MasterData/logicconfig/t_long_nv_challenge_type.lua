-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_long_nv_challenge_type.lua

module("logicconfig.config.t_long_nv_challenge_type", package.seeall)

local title = {
	minAlivePet = 3,
	desc = 4,
	detectAttr = 2,
	type = 1
}
local dataList = {
	{
		1,
		"水",
		20,
		"水之力"
	},
	{
		2,
		"暗",
		20,
		"暗之力"
	},
	{
		3,
		"",
		0,
		"boss"
	}
}
local t_long_nv_challenge_type = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_long_nv_challenge_type.dataList = dataList

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

return t_long_nv_challenge_type
