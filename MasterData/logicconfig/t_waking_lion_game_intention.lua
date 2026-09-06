-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game_intention.lua

module("logicconfig.config.t_waking_lion_game_intention", package.seeall)

local title = {
	name = 5,
	face = 4,
	desc = 6,
	id = 2,
	pic = 3,
	intentionPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"board_shizibiaoqing_01",
		"emoji_xingshi_02",
		"喜",
		"代表醒狮开心，舞动时醒狮将进行多次开心的跳跃，用来表达喜悦之情"
	},
	{
		1,
		2,
		"board_shizibiaoqing_08",
		"emoji_xingshi_04",
		"怒",
		"代表醒狮生气，舞动时将双脚点地，高举狮头，表达愤怒的情感"
	},
	{
		1,
		3,
		"board_shizibiaoqing_07",
		"emoji_xingshi_03",
		"哀",
		"代表醒狮哀伤，舞狮者将会用后腿轻挠狮头，动作缓慢，表达哀伤之情"
	},
	{
		1,
		4,
		"board_shizibiaoqing_03",
		"emoji_xingshi_05",
		"乐",
		"代表醒狮高兴，醒狮将表演出一个类似猫咪伸懒腰的动作，同时前爪交替快速拍地，并快乐地摇晃尾巴"
	},
	{
		1,
		5,
		"board_shizibiaoqing_05",
		"emoji_xingshi_07",
		"惊",
		"代表醒狮惊讶，醒狮将侧身看向观众，并且伴随着快速的身体抖动，表示震惊"
	},
	{
		1,
		6,
		"board_shizibiaoqing_02",
		"emoji_xingshi_01",
		"疑",
		"代表醒狮疑惑，醒狮将侧身站立，同时抬起前爪挠头，狮头微偏，伴随着缓慢的眨眼动作"
	}
}
local t_waking_lion_game_intention = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_waking_lion_game_intention.dataList = dataList

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

return t_waking_lion_game_intention
