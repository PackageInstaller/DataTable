-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bounty_pk_level.lua

module("logicconfig.config.t_bounty_pk_level", package.seeall)

local title = {
	baseScore = 2,
	name = 3,
	level = 1
}
local dataList = {
	{
		1,
		0,
		"黑铁"
	},
	{
		2,
		99999999,
		"黑铁"
	},
	{
		3,
		99999999,
		"黑铁"
	},
	{
		4,
		99999999,
		"黑铁"
	},
	{
		5,
		99999999,
		"黑铁"
	},
	{
		6,
		99999999,
		"黑铁"
	},
	{
		7,
		99999999,
		"黑铁"
	},
	{
		8,
		99999999,
		"黑铁"
	},
	{
		9,
		99999999,
		"黑铁"
	}
}
local t_bounty_pk_level = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_bounty_pk_level.dataList = dataList

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

return t_bounty_pk_level
