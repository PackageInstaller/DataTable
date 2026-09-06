-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hoshigami_suit.lua

module("logicconfig.config.t_hoshigami_suit", package.seeall)

local title = {
	desc = 3,
	count = 2,
	type = 1
}
local dataList = {
	{
		1,
		3,
		"攻击+10%"
	},
	{
		1,
		5,
		"物防+10%"
	},
	{
		2,
		3,
		"暴击率+10%"
	},
	{
		2,
		5,
		"攻击力+10%"
	}
}
local t_hoshigami_suit = {
	{
		[3] = dataList[1],
		[5] = dataList[2]
	},
	{
		[3] = dataList[3],
		[5] = dataList[4]
	}
}

t_hoshigami_suit.dataList = dataList

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

return t_hoshigami_suit
