-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_dungeon_buff.lua

module("logicconfig.config.t_bone_dragon_dungeon_buff", package.seeall)

local title = {
	num = 2,
	buffPlanId = 1,
	desc = 3
}
local dataList = {
	{
		1,
		1,
		"己阵全属性+<color=#20b376>30%</color>"
	},
	{
		1,
		2,
		"己阵全属性+<color=#20b376>50%</color>"
	},
	{
		1,
		3,
		"己阵全属性+<color=#20b376>150%</color>"
	},
	{
		1,
		4,
		"己阵全属性+<color=#20b376>300%</color>"
	},
	{
		1,
		5,
		"己阵全属性+<color=#20b376>500%</color>"
	},
	{
		1,
		6,
		"己阵全属性+<color=#20b376>800%</color>"
	}
}
local t_bone_dragon_dungeon_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_bone_dragon_dungeon_buff.dataList = dataList

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

return t_bone_dragon_dungeon_buff
