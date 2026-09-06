-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_surround_by_dream_girl_gift.lua

module("logicconfig.config.t_surround_by_dream_girl_gift", package.seeall)

local title = {
	addFetter = 4,
	materialKey = 3,
	giftId = 2,
	favouriteAddFetter = 5,
	activityId = 1
}
local dataList = {
	{
		459001,
		1,
		"10:459001",
		20,
		40
	},
	{
		459001,
		2,
		"10:459002",
		20,
		40
	},
	{
		459001,
		3,
		"10:459003",
		20,
		40
	},
	{
		459001,
		4,
		"10:459004",
		20,
		40
	}
}
local t_surround_by_dream_girl_gift = {
	[459001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_surround_by_dream_girl_gift.dataList = dataList

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

return t_surround_by_dream_girl_gift
