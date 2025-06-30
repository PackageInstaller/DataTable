-- chunkname: @IQIGame\\Config\\CfgGmToolTable.lua

local CfgGmToolTable = {
	[1000] = {
		Id = 1000,
		Name = "道具",
		NodeType = 1,
		NodeIndex = 5
	},
	[3000] = {
		Id = 3000,
		Name = "副本",
		NodeType = 1,
		NodeIndex = 4
	},
	[4000] = {
		Id = 4000,
		Name = "其他",
		NodeType = 1,
		NodeIndex = 2
	},
	[5000] = {
		Id = 5000,
		Name = "一键",
		NodeType = 1,
		NodeIndex = 3
	},
	[1100] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "代币",
		NodeType = 2,
		NodeIndex = 7,
		Id = 1100,
		ConditionType = 1,
		Condition = {
			"1"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1000"
		}
	},
	[1200] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "道具",
		NodeType = 2,
		NodeIndex = 6,
		Id = 1200,
		ConditionType = 1,
		Condition = {
			"20",
			"0"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1300] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "装备",
		NodeType = 2,
		NodeIndex = 5,
		Id = 1300,
		ConditionType = 1,
		Condition = {
			"3"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1400] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "英雄",
		NodeType = 2,
		NodeIndex = 4,
		Id = 1400,
		ConditionType = 1,
		Condition = {
			"2"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1500] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "碎片",
		NodeType = 2,
		NodeIndex = 3,
		Id = 1500,
		ConditionType = 1,
		Condition = {
			"5"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1600] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "皮肤",
		NodeType = 2,
		Id = 1600,
		ConditionType = 1,
		Condition = {
			"7"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1800] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "技能",
		NodeType = 2,
		NodeIndex = 1,
		Id = 1800,
		ConditionType = 1,
		Condition = {
			"4"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[1900] = {
		Cmd = "/cmd additem",
		ParentNode = 1000,
		Name = "礼包",
		NodeType = 2,
		Id = 1900,
		ConditionType = 1,
		Condition = {
			"6"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[4100] = {
		Id = 4100,
		Name = "常规",
		NodeType = 2,
		NodeIndex = 3,
		ParentNode = 4000,
		ConditionType = 2
	},
	[4200] = {
		Id = 4200,
		Name = "系统",
		NodeType = 2,
		NodeIndex = 2,
		ParentNode = 4000,
		ConditionType = 2
	},
	[4300] = {
		Id = 4300,
		Name = "SDK",
		NodeType = 2,
		NodeIndex = 1,
		ParentNode = 4000,
		ConditionType = 2
	},
	[4400] = {
		Cmd = "/cmd additem",
		ParentNode = 4000,
		Name = "模拟充值",
		NodeType = 2,
		Id = 4400,
		ConditionType = 1,
		Condition = {
			"21"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[4500] = {
		Cmd = "/cmd additem",
		ParentNode = 4000,
		Name = "功能",
		NodeType = 2,
		NodeIndex = 2,
		Id = 4500,
		ConditionType = 1,
		Condition = {
			"20"
		},
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[4600] = {
		Id = 4600,
		Name = "RPG",
		NodeType = 2,
		NodeIndex = 5,
		ParentNode = 4000,
		ConditionType = 2
	},
	[4700] = {
		Id = 4700,
		Name = "迷宫",
		NodeType = 2,
		NodeIndex = 6,
		ParentNode = 4000,
		ConditionType = 2
	},
	[4800] = {
		Cmd = "/cmd addGlobalBuff",
		ParentNode = 4000,
		Name = "BUFF",
		NodeType = 2,
		NodeIndex = 7,
		Id = 4800,
		ConditionType = 11,
		InputName = {
			"数量"
		},
		inputDefault = {
			"1"
		}
	},
	[4201] = {
		Name = "修改系统时间",
		Cmd = "/cmd date",
		Id = 4201,
		ParentNode = 4200,
		InputName = {
			"时间",
			"日期"
		},
		inputDefault = {
			"date",
			"time"
		}
	},
	[4202] = {
		Id = 4202,
		Name = "获取当前时间",
		Cmd = "/cmd now",
		ParentNode = 4200
	},
	[4203] = {
		Name = "Aviator表达式测试",
		Cmd = "/cmd aviator",
		Id = 4203,
		ParentNode = 4200,
		InputName = {
			"表达式",
			"参数"
		}
	},
	[4204] = {
		Name = "自定义命令",
		Cmd = "/cmd",
		Id = 4204,
		ParentNode = 4200,
		InputName = {
			"命令"
		}
	},
	[4205] = {
		Name = "触发服务器行为",
		Cmd = "/cmd triggerAction",
		Id = 4205,
		ParentNode = 4200,
		InputName = {
			"行为类型",
			"行为参数"
		},
		inputDefault = {
			"0",
			"0,0"
		}
	},
	[4206] = {
		Name = "检测客户端条件(|分割)",
		Id = 4206,
		ParentNode = 4200,
		InputName = {
			"条件ID"
		},
		inputDefault = {
			"0"
		}
	},
	[4301] = {
		Id = 4301,
		Name = "SDK主动崩溃",
		NodeType = 1001,
		ParentNode = 4300
	},
	[4102] = {
		Name = "执行断线操作",
		Cmd = "/cmd dis",
		Id = 4102,
		ParentNode = 4100,
		InputName = {
			"类型"
		},
		inputDefault = {
			"1"
		}
	},
	[4103] = {
		Id = 4103,
		Name = "发送不带附件邮件",
		Cmd = "/cmd sendNoMail",
		ParentNode = 4100
	},
	[4104] = {
		Id = 4104,
		Name = "发送带附件的邮件",
		Cmd = "/cmd sendmail",
		ParentNode = 4100
	},
	[4106] = {
		Name = "发送推送",
		Cmd = "/cmd push",
		Id = 4106,
		ParentNode = 4100,
		InputName = {
			"延迟(秒)"
		},
		inputDefault = {
			"3"
		}
	},
	[4107] = {
		Name = "开启指定功能",
		Cmd = "/cmd openFunc",
		Id = 4107,
		ParentNode = 4100,
		InputName = {
			"开启指定功能(0全部)"
		},
		inputDefault = {
			"1"
		}
	},
	[4109] = {
		Name = "定位主线副本(支线不受影响)",
		Cmd = "/cmd setGeneralDup",
		Id = 4109,
		ParentNode = 4100,
		InputName = {
			"主线副本关卡ID"
		}
	},
	[4110] = {
		Name = "重置已通关支线",
		Cmd = "/cmd resetBranchLineDup",
		Id = 4110,
		ParentNode = 4100,
		InputName = {
			"支线关卡ID"
		}
	},
	[4111] = {
		Id = 4111,
		Name = "重置日常",
		Cmd = "/cmd freshDaily",
		ParentNode = 4100
	},
	[4112] = {
		Id = 4112,
		Name = "主界面事件刷新",
		Cmd = "/cmd freshEvent",
		ParentNode = 4100
	},
	[4113] = {
		Name = "静态战斗",
		Cmd = "/cmd staticFight",
		Id = 4113,
		ParentNode = 4100,
		InputName = {
			"ID"
		}
	},
	[4114] = {
		Name = "静态剧情",
		Cmd = "/cmd staticPlot",
		Id = 4114,
		ParentNode = 4100,
		InputName = {
			"ID"
		}
	},
	[4115] = {
		Name = "掉落",
		Cmd = "/cmd drop",
		Id = 4115,
		ParentNode = 4100,
		InputName = {
			"掉落id 空格 次数"
		},
		inputDefault = {
			"313 100"
		}
	},
	[4117] = {
		Name = "好感送礼",
		Cmd = "/cmd favor",
		Id = 4117,
		ParentNode = 4100,
		InputName = {
			"角色id 道具id 道具数量"
		}
	},
	[4118] = {
		Name = "定位支线(重新定位支线开启的主线)",
		Cmd = "/cmd setBranchDup",
		Id = 4118,
		ParentNode = 4100,
		InputName = {
			"支线关卡ID"
		}
	},
	[4119] = {
		Name = "完成问卷",
		Cmd = "/cmd question",
		Id = 4119,
		ParentNode = 4100,
		InputName = {
			"问卷id"
		}
	},
	[4121] = {
		Id = 4121,
		Name = "个人每日重置",
		Cmd = "/cmd resetplayer",
		ParentNode = 4100
	},
	[4122] = {
		Name = "模拟抽卡",
		Cmd = "/cmd draw",
		Id = 4122,
		ParentNode = 4100,
		InputName = {
			"卡池id"
		},
		inputDefault = {
			"次数"
		}
	},
	[4123] = {
		Name = "怪物测试",
		Cmd = "/cmd monsterTest",
		Id = 4123,
		ParentNode = 4100,
		InputName = {
			"怪物组ID",
			"玩家阵型ID",
			"攻击方BUFF",
			"防御方BUFF"
		},
		inputDefault = {
			"0",
			"1",
			"NULL",
			"NULL"
		}
	},
	[4601] = {
		Id = 4601,
		Name = "完成当前剧情",
		Cmd = "/cmd completePlot",
		ParentNode = 4600
	},
	[4602] = {
		Name = "修改地图场景",
		Cmd = "/cmd changeSceneMap",
		Id = 4602,
		ParentNode = 4600,
		InputName = {
			"目标类型",
			"目标ID",
			"目标状态"
		},
		inputDefault = {
			"0",
			"0",
			"0"
		}
	},
	[4603] = {
		Id = 4603,
		Name = "刷新逛街行为",
		Cmd = "/cmd refreshShopping",
		ParentNode = 4600
	},
	[4604] = {
		Name = "指定房间关卡",
		Cmd = "/cmd setSceneMapPlot",
		Id = 4604,
		ParentNode = 4600,
		InputName = {
			"房间ID",
			"关卡ID"
		},
		inputDefault = {
			"0",
			"0"
		}
	},
	[4605] = {
		Name = "手动触发行为",
		Cmd = "/cmd triggerSceneMapAction",
		Id = 4605,
		ParentNode = 4600,
		InputName = {
			"行为ID",
			"进度"
		},
		inputDefault = {
			"0",
			"0"
		}
	},
	[4701] = {
		Id = 4701,
		Name = "迷宫关卡刷新",
		Cmd = "/cmd freshLabyrinthStage",
		ParentNode = 4700
	},
	[4702] = {
		Id = 4702,
		Name = "迷宫周重置",
		Cmd = "/cmd weekFreshLabyrin",
		ParentNode = 4700
	},
	[4703] = {
		Name = "迷宫添加buff",
		Cmd = "/cmd addItemLabyrin",
		Id = 4703,
		ParentNode = 4700,
		InputName = {
			"buffid"
		}
	},
	[5100] = {
		Id = 5100,
		Name = "玩家",
		NodeType = 2,
		NodeIndex = 10,
		ParentNode = 5000,
		ConditionType = 2
	},
	[5101] = {
		Id = 5101,
		Name = "一键-高级角色",
		Cmd = "/cmd senior oneKeyAll",
		ParentNode = 5100
	},
	[5102] = {
		Id = 5102,
		Name = "一键-玩家升级",
		Cmd = "/cmd senior oneKeyMaxLv",
		NodeIndex = 9,
		ParentNode = 5100
	},
	[5103] = {
		Id = 5103,
		Name = "一键-完成任务",
		Cmd = "/cmd finishDupTask",
		ParentNode = 5100
	},
	[5104] = {
		Id = 5104,
		Name = "一键-获得代币",
		Cmd = "/cmd senior oneKeyCurrency",
		ParentNode = 5100
	},
	[5105] = {
		Id = 5105,
		Name = "一键-清空背包",
		Cmd = "/cmd warehouse",
		ParentNode = 5100
	},
	[5106] = {
		Id = 5106,
		Name = "一键-清除引导",
		Cmd = "/cmd clearGuide",
		ParentNode = 5100
	},
	[5107] = {
		Id = 5107,
		Name = "一键-开启功能",
		Cmd = "/cmd openFunc 0",
		ParentNode = 5100
	},
	[5108] = {
		Id = 5108,
		Name = "一键-废弃角色",
		Cmd = "/cmd discardPlayer",
		ParentNode = 5100
	},
	[5200] = {
		Id = 5200,
		Name = "英雄",
		NodeType = 2,
		NodeIndex = 9,
		ParentNode = 5000,
		ConditionType = 2
	},
	[5201] = {
		Id = 5201,
		Name = "一键-获得英雄",
		Cmd = "/cmd senior oneKeyUnlockHero",
		ParentNode = 5200
	},
	[5202] = {
		Id = 5202,
		Name = "一键-升级英雄",
		Cmd = "/cmd senior oneKeyUpgradeHero",
		ParentNode = 5200
	},
	[5203] = {
		Id = 5203,
		Name = "一键-突破英雄",
		Cmd = "/cmd senior oneKeyBreakHero",
		ParentNode = 5200
	},
	[5300] = {
		Id = 5300,
		Name = "装备",
		NodeType = 2,
		NodeIndex = 8,
		ParentNode = 5000,
		ConditionType = 2
	},
	[5301] = {
		Id = 5301,
		Name = "一键-穿戴装备",
		Cmd = "/cmd senior oneKeyHeroEquip",
		ParentNode = 5300
	},
	[5302] = {
		Id = 5302,
		Name = "一键-升级装备",
		Cmd = "/cmd senior oneKeyEquipUp",
		ParentNode = 5300
	},
	[3100] = {
		Id = 3100,
		Name = "主线",
		NodeType = 2,
		NodeIndex = 5,
		ParentNode = 3000,
		Cmd = "/cmd resetRpgMainTask",
		ConditionType = 10,
		Condition = {
			"1001",
			"1"
		}
	},
	[3200] = {
		Id = 3200,
		Name = "日常",
		NodeType = 2,
		NodeIndex = 3,
		ParentNode = 3000,
		Cmd = "/cmd finishDup 2",
		ConditionType = 4
	},
	[3300] = {
		Id = 3300,
		Name = "装备",
		NodeType = 2,
		NodeIndex = 2,
		ParentNode = 3000,
		Cmd = "/cmd finishDup 3",
		ConditionType = 5
	},
	[3400] = {
		Id = 3400,
		Name = "Boss",
		NodeType = 2,
		NodeIndex = 1,
		ParentNode = 3000,
		Cmd = "/cmd finishDup 4",
		ConditionType = 6
	},
	[3500] = {
		Id = 3500,
		Name = "爬塔",
		NodeType = 2,
		NodeIndex = 1,
		ParentNode = 3000,
		Cmd = "/cmd finishDup 6",
		ConditionType = 7
	},
	[3600] = {
		Id = 3600,
		Name = "支线",
		NodeType = 2,
		NodeIndex = 4,
		ParentNode = 3000,
		Cmd = "/cmd resetRpgMainTask",
		ConditionType = 10,
		Condition = {
			"1002",
			"1"
		}
	},
	[3700] = {
		Id = 3700,
		Name = "夏活",
		NodeType = 2,
		NodeIndex = 4,
		ParentNode = 3000,
		Cmd = "/cmd finishDup 5",
		ConditionType = 9
	}
}

setmetatable(CfgGmToolTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgGmToolTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Cmd = "",
		ParentNode = 0,
		Name = "",
		NodeType = 0,
		NodeIndex = 0,
		ConditionType = 0,
		Condition = {},
		InputName = {},
		inputDefault = {}
	}
}

for i, data in pairs(CfgGmToolTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgGmToolTable
