-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_waking_lion_game_shape.lua

module("logicconfig.config.t_waking_lion_game_shape", package.seeall)

local title = {
	colorPlan = 3,
	name = 4,
	img = 7,
	id = 2,
	shapePlanId = 1,
	pic = 6,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"1",
		"刘备狮",
		"起舞刘备狮，富贵人人知。\r\n刘备狮为文狮，代表权贵之狮，象征着富贵、权力和财富，为“三圣狮”之首，舞动时带有仁义之气，主要用于迎宾喜庆等高贵的场合。",
		"board_xingshiwenhua_11",
		"board_shizitou_07"
	},
	{
		1,
		2,
		"2",
		"马超狮",
		"代表孝义之狮，舞动时带有怀缅之气。\r\n马超狮平日并不多见，只会出现于德高望重或地位显赫的前辈的丧礼上。马超狮舞动时多以跪行前进，不抬头，动作缓慢沉重，眼睛多为半眨，以示哀伤落泪之态。",
		"board_xingshiwenhua_10",
		"board_shizitou_09"
	},
	{
		1,
		3,
		"3",
		"关羽狮",
		"代表忠义之狮，舞动时带有胜利之气。\r\n关公狮是团结、侠义、英雄的象征。民间相传可以辟邪、镇宅、招财，带来国泰民安。",
		"board_xingshiwenhua_09",
		"board_shizitou_11"
	},
	{
		1,
		4,
		"4",
		"张飞狮",
		"张飞狮，代表霸气之狮，是智勇、威武的象征，枭雄、好斗、身经百战，是武狮的代表。\r\n人们寄望张飞狮凶猛，武威的神态，吓退妖邪，令其不能近身，憧憬能祛除病痛，事事顺利。",
		"board_xingshiwenhua_08",
		"board_shizitou_13"
	},
	{
		1,
		5,
		"5",
		"黄忠狮",
		"黄忠狮代表敬重之狮，形像老而堅，代表老资格，高辈分。\r\n一般德高望重，对地方有贡献的老师父，会用黄忠狮相赠，代表敬意。",
		"board_xingshiwenhua_07",
		"board_shizitou_15"
	},
	{
		1,
		6,
		"6",
		"赵云狮",
		"起舞赵云狮，虎威人人知。\r\n赵云狮是用来庆功的，因为赵云是“常胜将军，一般以青面为主。舞动时带有忠勇之气，是善战、英勇的象征。",
		"board_xingshiwenhua_12",
		"board_shizitou_17"
	}
}
local t_waking_lion_game_shape = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_waking_lion_game_shape.dataList = dataList

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

return t_waking_lion_game_shape
