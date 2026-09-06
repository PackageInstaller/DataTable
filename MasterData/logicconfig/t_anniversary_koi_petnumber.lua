-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_koi_petnumber.lua

module("logicconfig.config.t_anniversary_koi_petnumber", package.seeall)

local title = {
	id = 2,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		261001,
		0,
		16014
	},
	{
		261001,
		1,
		16015
	},
	{
		261001,
		2,
		16016
	},
	{
		261001,
		3,
		16017
	},
	{
		261001,
		4,
		14013
	},
	{
		261001,
		5,
		14014
	},
	{
		261001,
		6,
		16011
	},
	{
		261001,
		7,
		14010
	},
	{
		261001,
		8,
		10330
	},
	{
		261001,
		9,
		15014
	}
}
local t_anniversary_koi_petnumber = {
	[261001] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_anniversary_koi_petnumber.dataList = dataList

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

return t_anniversary_koi_petnumber
