-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_welfare_active.lua

module("logicconfig.config.t_welfare_active", package.seeall)

local title = {
	petId = 2,
	id = 1,
	behaviorId = 3
}
local dataList = {
	{
		1,
		10130,
		200304
	},
	{
		2,
		10167,
		200305
	},
	{
		3,
		10144,
		200306
	},
	{
		4,
		10324,
		200307
	},
	{
		5,
		10027,
		200308
	},
	{
		6,
		10323,
		200309
	}
}
local t_welfare_active = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_welfare_active.dataList = dataList

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

return t_welfare_active
