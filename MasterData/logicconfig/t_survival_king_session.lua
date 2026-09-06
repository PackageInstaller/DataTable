-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_session.lua

module("logicconfig.config.t_survival_king_session", package.seeall)

local title = {
	openTime = 3,
	sessionId = 2,
	endTime = 4,
	sessionName = 5,
	activityId = 1
}
local dataList = {
	{
		529001,
		1,
		"09:00:00",
		"11:00:00",
		"09:00-11:00"
	},
	{
		529001,
		2,
		"12:00:00",
		"14:00:00",
		"12:00-14:00"
	},
	{
		529001,
		3,
		"18:00:00",
		"20:00:00",
		"18:00-20:00"
	},
	{
		529001,
		4,
		"21:00:00",
		"23:00:00",
		"21:00-23:00"
	},
	{
		529002,
		1,
		"09:00:00",
		"11:00:00",
		"09:00-11:00"
	},
	{
		529002,
		2,
		"12:00:00",
		"14:00:00",
		"12:00-14:00"
	},
	{
		529002,
		3,
		"18:00:00",
		"20:00:00",
		"18:00-20:00"
	},
	{
		529002,
		4,
		"21:00:00",
		"23:00:00",
		"21:00-23:00"
	}
}
local t_survival_king_session = {
	[529001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[529002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_survival_king_session.dataList = dataList

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

return t_survival_king_session
