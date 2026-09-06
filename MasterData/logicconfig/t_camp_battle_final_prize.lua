-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_final_prize.lua

module("logicconfig.config.t_camp_battle_final_prize", package.seeall)

local title = {
	finalPrizePlanId = 1,
	prize = 3,
	rank = 2,
	rankSection = 4
}
local dataList = {
	{
		1,
		1,
		"4:31:10#60:1:540#2:61:1",
		"第一阵营"
	},
	{
		1,
		2,
		"4:31:5#60:1:360#2:62:1",
		"第二阵营"
	},
	{
		1,
		3,
		"4:31:3#60:1:180#2:63:1",
		"第三阵营"
	},
	{
		2,
		1,
		"4:31:10#60:1:540#2:67:1",
		"第一阵营"
	},
	{
		2,
		2,
		"4:31:5#60:1:360#2:68:1",
		"第二阵营"
	},
	{
		2,
		3,
		"4:31:3#60:1:180#2:69:1",
		"第三阵营"
	}
}
local t_camp_battle_final_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_camp_battle_final_prize.dataList = dataList

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

return t_camp_battle_final_prize
