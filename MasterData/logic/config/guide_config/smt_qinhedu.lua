-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/smt_qinhedu.lua

local configData = {
	step1 = {
		tips = "守秘人前20个节点顺序解锁属性增强、等级上限或技能强化",
		img = "smt_qinhedu",
		mask = true,
		imgKuang = {
			{
				134.9645,
				21.38561,
				0,
				127,
				485
			}
		},
		leftHint = {
			{
				377.3623,
				-73.56228,
				0,
				"I~IV级节点"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "只有A级守秘人和S级守秘人会存在V级亲和度节点;V级节点可以跳跃解锁",
		img = "smt_qinhedu2",
		mask = true,
		imgKuang = {
			{
				151.1899,
				-80.39098,
				0,
				127,
				330
			}
		},
		leftHint = {
			{
				390.6375,
				-159.1136,
				0,
				"V级节点"
			}
		},
		rightHint = {}
	}
}

return configData
