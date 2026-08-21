-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_12.lua

local configData = {
	step1 = {
		tips = "单人事件的最终目的是击飞右侧全部的骰子",
		img = "paotuan_danren3",
		mask = true,
		imgKuang = {
			{
				224.6583,
				11.01267,
				0,
				100,
				150
			}
		},
		leftHint = {},
		rightHint = {}
	},
	step2 = {
		tips = "单人事件只由选择守秘人投掷一次",
		img = "paotuan_danren3",
		mask = true,
		imgKuang = {
			{
				-223.1898,
				6.607613,
				0,
				127,
				200
			}
		},
		leftHint = {
			{
				16.93802,
				-80.96078,
				0,
				"所选守秘人"
			}
		},
		rightHint = {}
	},
	step3 = {
		tips = "轮到守秘人投掷时，会拿出数量和考验属性数值对应的骰子",
		img = "paotuan_danren8",
		mask = true,
		imgKuang = {
			{
				-531.5443,
				122.6076,
				0,
				127,
				330
			},
			{
				-155.6455,
				69.74686,
				0,
				100,
				170
			}
		},
		leftHint = {
			{
				103.571,
				-14.88482,
				0,
				"基础骰"
			}
		},
		rightHint = {
			{
				-5.08728,
				36.50758,
				0,
				"对应关系"
			}
		}
	},
	step4 = {
		tips = "每一个基础骰上都初始固定为3个考验属性图案、3个空白",
		img = "paotuan_danren9",
		mask = true,
		imgKuang = {
			{
				-1.462982,
				9.509956,
				0,
				350,
				180
			}
		},
		leftHint = {
			{
				130.9378,
				-79.51623,
				0,
				"图案分布"
			}
		},
		rightHint = {}
	},
	step5 = {
		tips = "投掷后结果为属性图案的骰子会撞飞1颗对应的骰子",
		img = "paotuan_danren4",
		mask = true,
		imgKuang = {
			{
				-5.852203,
				43.16041,
				0,
				400,
				200
			}
		},
		leftHint = {
			{
				97.28738,
				22.8982,
				0,
				"生效结果"
			}
		},
		rightHint = {}
	}
}

return configData
