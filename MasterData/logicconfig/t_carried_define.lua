-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_carried_define.lua

module("logicconfig.config.t_carried_define", package.seeall)

local title = {
	carriedPetRaceId = 2,
	carriedMasterRaceId = 1
}
local dataList = {
	{
		18001,
		14022
	},
	{
		14022,
		18001
	},
	{
		18002,
		14022
	},
	{
		18003,
		14022
	},
	{
		18004,
		14022
	},
	{
		18005,
		14022
	},
	{
		18006,
		14022
	},
	{
		18007,
		14022
	},
	{
		18008,
		14022
	}
}
local t_carried_define = {
	[18001] = {
		[14022] = dataList[1]
	},
	[14022] = {
		[18001] = dataList[2]
	},
	[18002] = {
		[14022] = dataList[3]
	},
	[18003] = {
		[14022] = dataList[4]
	},
	[18004] = {
		[14022] = dataList[5]
	},
	[18005] = {
		[14022] = dataList[6]
	},
	[18006] = {
		[14022] = dataList[7]
	},
	[18007] = {
		[14022] = dataList[8]
	},
	[18008] = {
		[14022] = dataList[9]
	}
}

t_carried_define.dataList = dataList

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

return t_carried_define
