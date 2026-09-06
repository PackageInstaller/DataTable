-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_six_art_daoguan_drop_buff_rerandom_cost.lua

module("logicconfig.config.t_six_art_daoguan_drop_buff_rerandom_cost", package.seeall)

local title = {
	cost = 3,
	activityId = 1,
	reRandomCount = 2
}
local dataList = {
	{
		447001,
		1,
		"105:2:100"
	},
	{
		447001,
		2,
		"105:2:100"
	},
	{
		447001,
		3,
		"105:2:100"
	}
}
local t_six_art_daoguan_drop_buff_rerandom_cost = {
	[447001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_six_art_daoguan_drop_buff_rerandom_cost.dataList = dataList

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

return t_six_art_daoguan_drop_buff_rerandom_cost
