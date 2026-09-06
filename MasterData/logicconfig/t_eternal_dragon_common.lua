-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_dragon_common.lua

module("logicconfig.config.t_eternal_dragon_common", package.seeall)

local title = {
	tipsOfHasAllGrowEndInDisple = 15,
	tipsOfUnlockOfDisple = 16,
	waterViewTips = 13,
	tipsOfNotCanGain = 7,
	waterJumpStr = 3,
	tipsOfCanGain = 8,
	tipsOfBubbleInGrowing = 9,
	levelUpEff = 6,
	tipsOfUnlockOfCut = 19,
	comPlanId = 1,
	tipsOfEnoughTimesInCut = 20,
	tipsOfGrowing = 12,
	tipsOfWater = 11,
	tipsOfEnoughTimesInDisple = 17,
	progressEff = 5,
	tipsOfHasAllGrowEndInWater = 14,
	firstStoryId = 4,
	ruleKeyMain = 2,
	tipsOfBubbleInFinish = 10,
	tipsOfHasAllGrowEndInCut = 18
}
local dataList = {
	{
		1,
		"eternaldragon_rule",
		"func#5",
		4530002,
		"20230825/yonghengguodu/fx_ui_yonghengguodu_shu",
		"",
		"世界树尚未成长到本阶段\r\n快去继续培育吧~\r\n培育到本阶段后可领取上方奖励哦",
		"恭喜你，将世界树培育到了%s阶段\n点击领取上方奖励\n查看永恒圣龙的小秘密吧~",
		"世界树再生长<color=#eb4642>%.1f%%</color>\n就达到<color=#20b376>%s</color>阶段啦~",
		"世界树已培育完成~",
		"正在浇水，不要心急~",
		"正在成长，不要心急~",
		"完成日常任务，累计活跃度\r\n达到<color=#cd7800>30/60/90/120/150</color>\r\n即可分别获得<color=#20b376>1次</color>浇水次数",
		"世界树已经长大了，不需浇水",
		"世界树已经长大了，不需祛湿",
		"世界树达到%s阶段时解锁本培育方式",
		"今天没有次数了，明天再来吧~",
		"世界树已经长大了，不需修剪枝叶",
		"世界树达到%s阶段时解锁本培育方式",
		"世界树现在不需要修剪枝叶哦，晚点再来吧~"
	},
	{
		2,
		"eternaldragon_rule",
		"func#5",
		4600001,
		"20240119/shaohuifx/fx_ui_shaohui_fw",
		"",
		"记忆之书尚未激活到本阶段\r\n快去继续激活吧~\r\n培育到本阶段后可领取上方奖励哦",
		"<color=#dbd7ca>恭喜你，将记忆之书激活至%s阶段\n点击领取上方奖励\n查看法纳斯的故事吧~</color>",
		"记忆之书再激活<color=#eb4642>%.1f%%</color>\n就达到<color=#20b376>%s</color>阶段啦~",
		"记忆之书已激活完成~",
		"正在除尘，不要心急~",
		"正在激活，不要心急~",
		"完成日常任务，累计活跃度\r\n达到<color=#cd7800>30/60/90/120/150</color>\r\n即可分别获得<color=#20b376>1次</color>除尘次数",
		"记忆之书已经激活了，无需操作~",
		"记忆之书已经激活了，无需操作~",
		"记忆之书达到%s阶段时解锁本培育方式",
		"今天没有次数了，明天再来吧~",
		"记忆之书已经激活了，无需操作~",
		"记忆之书达到%s阶段时解锁本培育方式",
		"记忆之书现在不需要触摸回忆哦，晚点再来吧~"
	},
	{
		3,
		"eternaldragon_rule",
		"func#5",
		4660007,
		"20240531/wuwenjieshao/fx_ui_wuwenjieshao_yanchen",
		"20240531/wuwenjieshao/fx_ui_wuwenjieshao_dianliang",
		"宝箱尚未激活到开箱阶段\r\n快去继续激活吧~\r\n培育到本阶段后可领取上方奖励哦",
		"<color=#000000>恭喜你，将宝箱激活至%s阶段\n点击领取上方奖励\n查看无问的故事吧~</color>",
		"宝箱再激活<color=#eb4642>%.1f%%</color>\n就达到<color=#20b376>%s</color>阶段啦~",
		"宝箱已激活完成~",
		"正在除尘，不要心急~",
		"正在激活，不要心急~",
		"完成日常任务，累计活跃度\r\n达到<color=#cd7800>30/60/90/120/150</color>\r\n即可分别获得<color=#20b376>1次</color>除尘次数",
		"宝箱已经激活了，无需操作~",
		"宝箱已经激活了，无需操作~",
		"宝箱达到%s阶段时解锁本培育方式",
		"今天没有次数了，明天再来吧~",
		"宝箱已经激活了，无需操作~",
		"宝箱达到%s阶段时解锁本培育方式",
		"宝箱现在不需要触摸回忆哦，晚点再来吧~"
	},
	{
		4,
		"eternaldragon_rule",
		"func#5",
		0,
		"20240119/shaohuifx/fx_ui_shaohui_fw",
		"20240531/wuwenjieshao/fx_ui_wuwenjieshao_dianliang",
		"魔盒尚未激活到本阶段\r\n快去继续激活吧~\r\n培育到本阶段后可领取上方奖励哦",
		"<color=#dbd7ca>恭喜你，将魔盒激活至%s阶段\n点击领取上方奖励\n查看魔君的故事吧~</color>",
		"魔盒再激活<color=#eb4642>%.1f%%</color>\n就达到<color=#20b376>%s</color>阶段啦~",
		"魔盒已激活完成~",
		"正在除尘，不要心急~",
		"正在激活，不要心急~",
		"完成日常任务，累计活跃度\r\n达到<color=#cd7800>30/60/90/120/150</color>\r\n即可分别获得<color=#20b376>1次</color>除尘次数",
		"魔盒已经激活了，无需操作~",
		"魔盒已经激活了，无需操作~",
		"魔盒达到%s阶段时解锁本培育方式",
		"今天没有次数了，明天再来吧~",
		"魔盒已经激活了，无需操作~",
		"魔盒达到%s阶段时解锁本培育方式",
		"魔盒现在不需要触摸回忆哦，晚点再来吧~"
	}
}
local t_eternal_dragon_common = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_eternal_dragon_common.dataList = dataList

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

return t_eternal_dragon_common
