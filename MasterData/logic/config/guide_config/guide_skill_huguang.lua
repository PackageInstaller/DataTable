-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_skill_huguang.lua

local configData = {
	step1 = {
		tips = "异能-[tag_弧光]的效果：对当前目标造成75%物理伤害后，[tag_弧光]会向目标2格内的随机单位弹射",
		img = "battle_effect_huguang_new1",
		imgKuang = {
			{
				93.5157,
				72.444,
				0,
				142.2984,
				144.85
			}
		},
		leftHint = {},
		rightHint = {
			{
				636,
				32.99995,
				0,
				"弧光"
			}
		}
	},
	step2 = {
		tips = "[tag_弧光]最多可弹射三次，每次衰减15%伤害。[tag_弧光]的效果会因不同的技能产生变化",
		img = "battle_effect_huguang_new2",
		imgKuang = {
			{
				202.3917,
				2.1924,
				0,
				151.8002,
				152.1593
			}
		},
		leftHint = {},
		rightHint = {
			{
				750.79,
				-76.8,
				0,
				"弧光"
			}
		}
	}
}

return configData
