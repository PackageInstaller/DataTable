-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_support_pet.lua

module("logicconfig.config.t_project_ash_support_pet", package.seeall)

local title = {
	awakenLv = 7,
	lv = 5,
	creepsId = 2,
	onlyUseExtProperties = 10,
	faceId = 13,
	summonedPetId = 12,
	talentLv = 6,
	summonMasterId = 11,
	equipment = 8,
	creepsName = 4,
	extproperties = 9,
	showIndex = 14,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		265001,
		1000001,
		12009,
		"神曜莲火·末炎",
		100,
		0,
		0,
		"",
		"生命+947565#攻击+181755#物防+68900#魔防+72610#速度+25142",
		true,
		"",
		"",
		"",
		""
	}
}
local t_project_ash_support_pet = {
	[265001] = {
		[1000001] = dataList[1]
	}
}

t_project_ash_support_pet.dataList = dataList

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

return t_project_ash_support_pet
