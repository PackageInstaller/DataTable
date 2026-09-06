-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_publicity_view_task.lua

module("logicconfig.config.t_publicity_view_task", package.seeall)

local title = {
	desc = 4,
	name = 3,
	jumpTo = 6,
	tag = 5,
	planId = 1,
	taskId = 2
}
local dataList = {
	{
		1,
		1,
		"破阵天下",
		"掉落金色星神碎片！",
		"奖励",
		"func#18"
	},
	{
		1,
		2,
		"世界BOSS",
		"全民排行，参与皆可拿奖励！",
		"奖励",
		"func#93"
	},
	{
		1,
		3,
		"星神兑换",
		"指定金星任意兑，气吞全民拿！",
		"功能",
		"func#253#3"
	},
	{
		2,
		1,
		"召唤-装备",
		"水火草属性卡池常驻，光暗空创每周轮换！",
		"奖励",
		"func#323"
	},
	{
		2,
		2,
		"装备转化",
		"新增指定属性橙装/属性橙+1和随机属性橙装兑换",
		"功能",
		"func#253#1"
	},
	{
		3,
		1,
		"通行证",
		"通行证活跃产出良品修复液！",
		"奖励",
		"func#545#4"
	},
	{
		3,
		2,
		"每日基础奖励",
		"每日发放修复原液增加至30个！",
		"奖励",
		"func#174"
	},
	{
		3,
		3,
		"收藏品置换",
		"藏品指定置换，满级不再是梦！",
		"功能",
		"func#253#2"
	},
	{
		4,
		1,
		"家族护送",
		"潜能药水任务触发升级，预览奖励外显！",
		"奖励",
		"func#91"
	},
	{
		4,
		2,
		"任务派遣",
		"上调护送产出潜能药水！",
		"奖励",
		"func#74"
	},
	{
		5,
		1,
		"日常任务",
		"限时两周，每日任务每周任务奖励翻倍！",
		"奖励",
		"func#56"
	},
	{
		5,
		2,
		"日常任务",
		"10.14日前完成日常任务，可领取限时至尊券！",
		"卡券",
		"func#56"
	}
}
local t_publicity_view_task = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12]
	}
}

t_publicity_view_task.dataList = dataList

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

return t_publicity_view_task
