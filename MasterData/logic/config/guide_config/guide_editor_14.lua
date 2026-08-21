-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_14.lua

local configData = {
	step1 = {
		tips = "遭遇陷阱判定后每个守秘人都会进行独立考验",
		img = "paotuan_xianjing1",
		mask = true,
		imgKuang = {
			{
				239.9424,
				50.47572,
				0,
				100,
				150
			},
			{
				-359.5999,
				57.27503,
				0,
				320,
				350
			}
		},
		leftHint = {
			{
				498.65,
				-38.975,
				0,
				"独立考验"
			}
		},
		rightHint = {
			{
				265.2,
				48.025,
				0,
				"守秘人"
			}
		}
	},
	step2 = {
		tips = "守秘人都会投掷一次，切换人员后重置右侧骰子数量",
		img = "paotuan_xianjing1",
		mask = true,
		imgKuang = {
			{
				-324.8,
				55.82501,
				0,
				370,
				350
			},
			{
				-101.5,
				-168.925,
				0,
				210,
				80
			}
		},
		leftHint = {},
		rightHint = {
			{
				329,
				46.57498,
				0,
				"守秘人"
			},
			{
				474,
				-255.025,
				0,
				"独立结算"
			}
		}
	},
	step3 = {
		tips = "轮到守秘人投掷时，会拿出数量和考验属性数值对应的骰子",
		img = "paotuan_danren8",
		mask = true,
		imgKuang = {
			{
				-532.5549,
				123.6289,
				0,
				127,
				330
			},
			{
				-168.2522,
				78.2739,
				0,
				100,
				170
			}
		},
		leftHint = {
			{
				88.50903,
				36.06577,
				0,
				"基础骰"
			}
		},
		rightHint = {
			{
				3.651367,
				110.682,
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
	},
	step6 = {
		tips = "失败的守秘人结束后各自承受失败效果",
		img = "paotuan_xianjing1",
		imgKuang = {},
		leftHint = {},
		rightHint = {}
	}
}

return configData
