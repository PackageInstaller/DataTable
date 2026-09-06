-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_era_nuo_ya_buff.lua

module("logicconfig.config.t_new_era_nuo_ya_buff", package.seeall)

local title = {
	activityId = 1,
	buffId = 2
}
local dataList = {
	{
		535001,
		1
	},
	{
		535001,
		2
	},
	{
		535001,
		3
	},
	{
		535001,
		4
	}
}
local t_new_era_nuo_ya_buff = {
	[535001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_new_era_nuo_ya_buff.dataList = dataList

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

return t_new_era_nuo_ya_buff
