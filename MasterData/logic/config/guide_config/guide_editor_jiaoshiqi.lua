-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/guide_config/guide_editor_jiaoshiqi.lua

local configData = {
	step1 = {
		tips = "校时器上的六面体可以通过【重新调校】再随机效果",
		img = "jiaoshiqi_01",
		mask = true,
		imgKuang = {
			{
				375.3734,
				-51.04443,
				0,
				400,
				50
			},
			{
				469.6093,
				-219.0986,
				0,
				170,
				100
			},
			{
				-36.12381,
				40.05036,
				0,
				450,
				80
			}
		},
		leftHint = {
			{
				480.9947,
				-135.5739,
				0,
				"当前生效"
			}
		},
		rightHint = {}
	},
	step2 = {
		tips = "再随机后效果仍是六面体原有效果之一",
		img = "jiaoshiqi_01",
		mask = true,
		imgKuang = {
			{
				395.7911,
				-36.90905,
				0,
				330,
				220
			}
		},
		leftHint = {
			{
				534.3951,
				-118.2973,
				0,
				"随机范围"
			}
		},
		rightHint = {}
	},
	step3 = {
		tips = "每件校时器只能进行有限次的重新调校",
		img = "jiaoshiqi_01",
		mask = true,
		imgKuang = {
			{
				-394.2205,
				-162.557,
				0,
				160,
				50
			}
		},
		leftHint = {},
		rightHint = {
			{
				152.7394,
				-248.657,
				0,
				"次数限制"
			}
		}
	},
	step4 = {
		tips = "通过重新调校去得到想要的效果吧",
		img = "jiaoshiqi_01",
		mask = true,
		imgKuang = {
			{
				-229.3075,
				66.75056,
				0,
				90,
				130
			},
			{
				318.8317,
				-36.90905,
				0,
				127,
				210
			}
		},
		leftHint = {
			{
				31.80325,
				-24.06127,
				0,
				"共鸣强化"
			},
			{
				561.0953,
				-116.7267,
				0,
				"类型和数值"
			}
		},
		rightHint = {}
	}
}

return configData
