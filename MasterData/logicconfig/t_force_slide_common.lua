-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_force_slide_common.lua

module("logicconfig.config.t_force_slide_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"STORY_ID",
		"4230001"
	},
	{
		"ACTIVITY_ID",
		"17041"
	},
	{
		"TIP_TITLE_1",
		"力量神柱是精灵大陆五圣柱之一，其中蕴含的浓郁力量，是火系精灵们一代又一代传承下来的宝贵财富。如今神柱破裂，乌云蔽日，砂之国的精灵们受到了巨大的影响——虚弱、崩溃、疯狂、好战……砂之国正陷入前所未有的危机之中。\r\n奥奇城肩负维持大陆和平的责任，正在聚集人手，拯救虚弱精灵与狂暴精灵，并修复力量神柱。"
	},
	{
		"TIP_TITLE_2",
		"神秘火球对力量神柱造成强烈撞击，力量神柱出现裂缝，内部浓郁的火之力量泄露，引起了砂之国的精灵们力量失衡。\r\n疯狂的精灵们向神柱上攀爬，虚弱的精灵们在原地躺下，浓厚的黑云遮蔽了砂之国上空，精灵们眼中只剩下了对力量的渴望，开始对神柱进行攻击，试图吸收更多的火之力量……"
	}
}
local t_force_slide_common = {
	STORY_ID = dataList[1],
	ACTIVITY_ID = dataList[2],
	TIP_TITLE_1 = dataList[3],
	TIP_TITLE_2 = dataList[4]
}

t_force_slide_common.dataList = dataList

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

return t_force_slide_common
