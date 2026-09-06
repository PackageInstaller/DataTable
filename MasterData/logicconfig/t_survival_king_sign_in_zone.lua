-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_sign_in_zone.lua

module("logicconfig.config.t_survival_king_sign_in_zone", package.seeall)

local title = {
	activityId = 1,
	prize = 3,
	zoneId = 2
}
local dataList = {
	{
		530001,
		1,
		"4:36:5#10:17173:180"
	},
	{
		530001,
		2,
		"4:36:5#10:17173:180"
	},
	{
		530001,
		3,
		"4:36:5#10:17173:180"
	},
	{
		530001,
		4,
		"4:36:5#10:17173:180"
	},
	{
		530001,
		5,
		"4:36:5#10:17173:180"
	}
}
local t_survival_king_sign_in_zone = {
	[530001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_survival_king_sign_in_zone.dataList = dataList

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

return t_survival_king_sign_in_zone
