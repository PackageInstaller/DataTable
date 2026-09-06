-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_xingjiang_transmog.lua

module("logicconfig.config.t_origin_xingjiang_transmog", package.seeall)

local title = {
	raceId = 4,
	transmogId = 2,
	activityId = 1,
	signBuffId = 3
}
local dataList = {
	{
		570001,
		1,
		20070801,
		20026
	},
	{
		570001,
		2,
		20070808,
		20027
	},
	{
		570001,
		3,
		20070815,
		20028
	},
	{
		570001,
		4,
		20070822,
		20029
	},
	{
		570001,
		5,
		20070829,
		20030
	},
	{
		570001,
		6,
		20070836,
		20031
	}
}
local t_origin_xingjiang_transmog = {
	[570001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_xingjiang_transmog.dataList = dataList

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

return t_origin_xingjiang_transmog
