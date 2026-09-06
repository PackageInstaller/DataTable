-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory_Pet.lua

module("logicconfig.config.t_restore_glory_pet", package.seeall)

local title = {
	restoreId = 2,
	oldBg = 10,
	surveyBehaviorId = 9,
	jumpTo = 6,
	storyId = 12,
	restorePlanId = 1,
	newBg = 11,
	restoreJumpStr = 5,
	labelPlanId = 4,
	redPointId = 8,
	raceId = 3,
	awakenJumpTo = 7
}
local dataList = {
	{
		1,
		1,
		10324,
		1,
		"event#openrecastgloryshieldview#1",
		"ui#shareqrcodeview#share_01",
		"func#843",
		-323,
		201669,
		"board_chongzhurongguang_02",
		"board_chongzhurongguang_05",
		4450004
	},
	{
		1,
		2,
		10027,
		2,
		"event#openrecastgloryswordview#1",
		"ui#recastglorytaskview",
		"func#860",
		-324,
		201670,
		"board_chongzhurongguang_03",
		"board_chongzhurongguang_06",
		4450005
	}
}
local t_restore_glory_pet = {
	{
		dataList[1],
		dataList[2]
	}
}

t_restore_glory_pet.dataList = dataList

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

return t_restore_glory_pet
