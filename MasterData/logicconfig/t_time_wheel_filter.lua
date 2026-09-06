-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_wheel_filter.lua

module("logicconfig.config.t_time_wheel_filter", package.seeall)

local title = {
	decompose = 2,
	noOnekeySelected = 6,
	raceId = 1,
	overflow = 5,
	reset = 3,
	revert = 4
}
local dataList = {
	{
		14003,
		true,
		true,
		true,
		true,
		false
	},
	{
		11000,
		true,
		true,
		true,
		true,
		false
	},
	{
		15015,
		true,
		false,
		true,
		false,
		false
	},
	{
		14006,
		true,
		false,
		true,
		false,
		false
	},
	{
		14001,
		true,
		false,
		true,
		false,
		false
	},
	{
		13003,
		true,
		false,
		true,
		false,
		false
	},
	{
		12002,
		true,
		false,
		true,
		false,
		false
	},
	{
		11006,
		true,
		false,
		true,
		false,
		false
	},
	{
		10362,
		false,
		false,
		false,
		false,
		true
	},
	{
		16001,
		false,
		false,
		false,
		true,
		false
	},
	{
		16026,
		false,
		false,
		false,
		true,
		false
	},
	{
		16010,
		false,
		false,
		false,
		true,
		false
	},
	{
		16040,
		false,
		false,
		false,
		true,
		false
	},
	{
		18001,
		false,
		false,
		false,
		true,
		false
	},
	{
		14022,
		false,
		false,
		false,
		true,
		false
	},
	{
		18021,
		false,
		false,
		false,
		true,
		false
	},
	{
		18031,
		false,
		false,
		false,
		true,
		false
	},
	{
		10381,
		false,
		false,
		false,
		true,
		false
	},
	{
		10380,
		false,
		false,
		false,
		true,
		false
	},
	{
		10385,
		false,
		false,
		false,
		true,
		false
	},
	{
		10386,
		false,
		false,
		false,
		true,
		false
	},
	{
		14031,
		false,
		false,
		false,
		true,
		false
	},
	{
		12039,
		false,
		false,
		false,
		true,
		false
	},
	{
		14043,
		false,
		false,
		false,
		true,
		false
	},
	{
		10383,
		false,
		false,
		false,
		true,
		false
	}
}
local t_time_wheel_filter = {
	[14003] = dataList[1],
	[11000] = dataList[2],
	[15015] = dataList[3],
	[14006] = dataList[4],
	[14001] = dataList[5],
	[13003] = dataList[6],
	[12002] = dataList[7],
	[11006] = dataList[8],
	[10362] = dataList[9],
	[16001] = dataList[10],
	[16026] = dataList[11],
	[16010] = dataList[12],
	[16040] = dataList[13],
	[18001] = dataList[14],
	[14022] = dataList[15],
	[18021] = dataList[16],
	[18031] = dataList[17],
	[10381] = dataList[18],
	[10380] = dataList[19],
	[10385] = dataList[20],
	[10386] = dataList[21],
	[14031] = dataList[22],
	[12039] = dataList[23],
	[14043] = dataList[24],
	[10383] = dataList[25]
}

t_time_wheel_filter.dataList = dataList

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

return t_time_wheel_filter
