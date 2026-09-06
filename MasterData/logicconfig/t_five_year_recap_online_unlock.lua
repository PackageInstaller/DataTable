-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_online_unlock.lua

module("logicconfig.config.t_five_year_recap_online_unlock", package.seeall)

local title = {
	onlineMinute = 2,
	activityId = 1,
	unlockCount = 3
}
local dataList = {
	{
		586001,
		10,
		1
	},
	{
		586001,
		20,
		3
	},
	{
		586001,
		30,
		5
	},
	{
		586001,
		40,
		8
	},
	{
		586001,
		50,
		11
	},
	{
		586001,
		60,
		15
	}
}
local t_five_year_recap_online_unlock = {
	[586001] = {
		[10] = dataList[1],
		[20] = dataList[2],
		[30] = dataList[3],
		[40] = dataList[4],
		[50] = dataList[5],
		[60] = dataList[6]
	}
}

t_five_year_recap_online_unlock.dataList = dataList

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

return t_five_year_recap_online_unlock
