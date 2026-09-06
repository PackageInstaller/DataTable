-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_good_feeling_schedule_chat_plan.lua

module("logicconfig.config.t_good_feeling_schedule_chat_plan", package.seeall)

local title = {
	replyText = 4,
	reqRaceId = 3,
	chatSeq = 2,
	chatPlanId = 1
}
local dataList = {
	{
		1,
		1,
		10004,
		"打雷啦！"
	},
	{
		1,
		2,
		10005,
		"下雨啦！"
	},
	{
		1,
		3,
		10006,
		"快收衣服啦！"
	},
	{
		2,
		1,
		10313,
		"等一下，大家看我眼色行事"
	},
	{
		2,
		2,
		10309,
		"这里有个问题……"
	},
	{
		2,
		3,
		10313,
		"什么问题？！"
	},
	{
		2,
		4,
		10309,
		"你眼睛太小了……看不到……"
	},
	{
		2,
		5,
		10313,
		"……"
	},
	{
		3,
		1,
		10017,
		"卡雅……我……"
	},
	{
		3,
		2,
		10019,
		"寒冰，你想说什么？"
	},
	{
		3,
		3,
		10017,
		"这……有些难以启齿，我真的可以说吗？"
	},
	{
		3,
		4,
		10019,
		"没关系，你说的一切我都接受。"
	},
	{
		3,
		5,
		10017,
		"卡雅，你……中午是不是吃了韭菜？卡在牙缝上了。"
	},
	{
		3,
		6,
		10019,
		"……"
	},
	{
		4,
		1,
		10016,
		"下次聚餐吃什么？"
	},
	{
		4,
		2,
		10018,
		"猪蹄！"
	},
	{
		4,
		3,
		10020,
		"五花肉！"
	},
	{
		4,
		4,
		10169,
		"猪颈肉！"
	},
	{
		4,
		5,
		10360,
		"……我可以选择报警吗？"
	}
}
local t_good_feeling_schedule_chat_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19]
	}
}

t_good_feeling_schedule_chat_plan.dataList = dataList

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

return t_good_feeling_schedule_chat_plan
