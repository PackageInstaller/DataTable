-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_clg_foramtion.lua

module("logicconfig.config.t_bone_dragon_clg_foramtion", package.seeall)

local title = {
	id = 3,
	positionLimit = 4,
	activityId = 1,
	formationPlanId = 2
}
local dataList = {
	{
		488001,
		1,
		1,
		"1#肉盾_3#平衡_6#魔法_7#利爪_9#疾速"
	},
	{
		488001,
		1,
		2,
		"1#肉盾_3#平衡_4#利爪_6#利爪_7#魔法"
	},
	{
		488001,
		1,
		3,
		"1#平衡_4#利爪_6#平衡_7#魔法_9#魔法"
	},
	{
		488001,
		1,
		4,
		"1#平衡_4#利爪_6#平衡_7#魔法_9#利爪"
	},
	{
		488001,
		1,
		5,
		"1#平衡_3#平衡_4#利爪_7#魔法_9#魔法"
	},
	{
		488001,
		1,
		6,
		"1#肉盾_3#平衡_6#利爪_7#魔法_9#疾速"
	}
}
local t_bone_dragon_clg_foramtion = {
	[488001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_bone_dragon_clg_foramtion.dataList = dataList

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

return t_bone_dragon_clg_foramtion
