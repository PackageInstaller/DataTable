-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tian_yan_match_manual_type.lua

module("logicconfig.config.t_tian_yan_match_manual_type", package.seeall)

local title = {
	activityId = 1,
	name = 3,
	manualType = 2
}
local dataList = {
	{
		503001,
		1,
		"兄弟齐心,其利断金(每次积分+10)"
	},
	{
		503001,
		2,
		"吵吵闹闹,欢喜冤家(每次积分+10)"
	},
	{
		503001,
		3,
		"普通组合(每次积分+5)"
	}
}
local t_tian_yan_match_manual_type = {
	[503001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_tian_yan_match_manual_type.dataList = dataList

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

return t_tian_yan_match_manual_type
