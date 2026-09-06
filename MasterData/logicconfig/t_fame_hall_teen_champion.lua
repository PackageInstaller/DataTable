-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fame_hall_teen_champion.lua

module("logicconfig.config.t_fame_hall_teen_champion", package.seeall)

local title = {
	id = 1,
	activityId = 2
}
local dataList = {
	{
		1,
		391001
	},
	{
		2,
		501001
	},
	{
		3,
		624001
	}
}
local t_fame_hall_teen_champion = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_fame_hall_teen_champion.dataList = dataList

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

return t_fame_hall_teen_champion
