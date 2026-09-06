-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cloud_cut_fan_master.lua

module("logicconfig.config.t_cloud_cut_fan_master", package.seeall)

local title = {
	skipTime = 4,
	name = 3,
	heavenAwakenSummonPetId = 11,
	formCondition = 8,
	retreatMsgType = 6,
	heavenAwakenMasterId = 10,
	ruleDesc = 12,
	selfBuffProviderId = 7,
	winId = 5,
	creepsMasterId = 2,
	heroSkillId = 9,
	activityId = 1
}
local dataList = {
	{
		615001,
		1001,
		"巧手裁云扇-1",
		3,
		117,
		0,
		593,
		0,
		"",
		"",
		"",
		"在5个回合内造成尽可能多的伤害"
	}
}
local t_cloud_cut_fan_master = {
	[615001] = {
		[1001] = dataList[1]
	}
}

t_cloud_cut_fan_master.dataList = dataList

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

return t_cloud_cut_fan_master
