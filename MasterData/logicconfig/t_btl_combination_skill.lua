-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_btl_combination_skill.lua

module("logicconfig.config.t_btl_combination_skill", package.seeall)

local title = {
	raceIds = 2,
	skillId = 1
}
local dataList = {
	{
		610338,
		{
			10338,
			10339,
			10341,
			10342,
			10343
		}
	},
	{
		610339,
		{
			10338,
			10339,
			10341,
			10342,
			10343
		}
	},
	{
		610341,
		{
			10338,
			10339,
			10341,
			10342,
			10343
		}
	},
	{
		610342,
		{
			10338,
			10339,
			10341,
			10342,
			10343
		}
	},
	{
		610343,
		{
			10338,
			10339,
			10341,
			10342,
			10343
		}
	}
}
local t_btl_combination_skill = {
	[610338] = dataList[1],
	[610339] = dataList[2],
	[610341] = dataList[3],
	[610342] = dataList[4],
	[610343] = dataList[5]
}

t_btl_combination_skill.dataList = dataList

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

return t_btl_combination_skill
